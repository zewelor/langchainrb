# frozen_string_literal: true

require "ai21"

RSpec.describe Langchain::LLM::AI21 do
  let(:subject) { described_class.new(api_key: "123") }

  describe "#complete" do
    let(:response) do
      {
        id: "812c650e-a0d0-4502-a084-45b0d32fcb9c",
        prompt: {
          text: "What is the meaining of life?"
        },
        completions: [{
          data: {
            text: "\nWhat is the meaning of life? What is the meaning of life?\nWhat is the meaning"
          }
        }]
      }
    end

    context "with no additional parameters" do
      before do
        allow(subject.client).to receive(:complete).with("Hello World", {}).and_return(response)
      end

      it "returns a completion" do
        expect(subject.complete(prompt: "Hello World")).to eq("\nWhat is the meaning of life? What is the meaning of life?\nWhat is the meaning")
      end
    end

    context "with additional parameters" do
      before do
        allow(subject.client).to receive(:complete)
          .with("Hello World", {temperature: 0.7, model: "j2-jumbo"})
          .and_return(response)
      end

      it "returns a completion" do
        expect(subject.complete(prompt: "Hello World", model: "j2-jumbo", temperature: 0.7)).to eq(
          "\nWhat is the meaning of life? What is the meaning of life?\nWhat is the meaning"
        )
      end
    end
  end

  describe "#summarize" do
    let(:text) { "Text to summarize" }
    let(:response) do
      {
        id: "88636c32-99d7-3495-d832-4d94264bc1af",
        summary: "Summary"
      }
    end

    context "with no additional params" do
      before do
        allow(subject.client).to receive(:summarize)
          .with(text, "TEXT", {})
          .and_return(response)
      end

      it "returns a summary" do
        expect(subject.summarize(text: text)).to eq("Summary")
      end
    end

    context "with additional params" do
      before do
        allow(subject.client).to receive(:summarize)
          .with(text, "TEXT", {focus: "topic"})
          .and_return(response)
      end

      it "returns a summary" do
        expect(subject.summarize(text: text, focus: "topic")).to eq("Summary")
      end
    end
  end
end
