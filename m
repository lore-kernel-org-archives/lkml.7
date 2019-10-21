Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17870CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 04:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E172089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 04:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571632046;
	bh=BznKn2M5fb/b64b1A0f57cJkw+MKF62qhcz0rLjG/sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B6F2w3MnMHix8xuFmc4AGMyUufDxEuOev8VIrB2A3mGSgiG880Hl+XalSgoXrDfPT
	 StS4lq9HCpcD5iDrvJa60s1JpgVz5Uvbri2Qq/fND+aH0SZqTNyNZATtHq81V/Fnwt
	 k9AwrcrTi4/iorYPiTVsj6j98Bt/5+ZOEVg5fllA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfJUE1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 00:27:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfJUE1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 00:27:12 -0400
Received: from localhost (unknown [122.167.89.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10E6D2089C;
        Mon, 21 Oct 2019 04:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571632031;
        bh=BznKn2M5fb/b64b1A0f57cJkw+MKF62qhcz0rLjG/sk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c71OQiO+CbGZk2N0q3XcnQOtQs0N3xFEzMe+cTJzy6eU3iEmu0sqEYP8S96aGFMT+
         cGo1xVT4IdVHObp/O+76tteZqYVEa5JcdnGvI8Hz7TRjBFXEjYZU14/0sE/Gy+HiD0
         2mjaZIjBoWHmFjcNHT0PcUiQe6koiJvl1Crn58yo=
Date:   Mon, 21 Oct 2019 09:57:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh@kernel.org, broonie@kernel.org, bgoswami@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, spapothi@codeaurora.org
Subject: Re: [PATCH v3 1/2] dt-bindings: soundwire: add bindings for Qcom
 controller
Message-ID: <20191021042706.GA2654@vkoul-mobl>
References: <20191011154423.2506-1-srinivas.kandagatla@linaro.org>
 <20191011154423.2506-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011154423.2506-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-10-19, 16:44, Srinivas Kandagatla wrote:
> This patch adds bindings for Qualcomm soundwire controller.
> 
> Qualcomm SoundWire Master controller is present in most Qualcomm SoCs
> either integrated as part of WCD audio codecs via slimbus or
> as part of SOC I/O.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/soundwire/qcom,sdw.txt           | 167 ++++++++++++++++++
>  1 file changed, 167 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
> 
> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
> new file mode 100644
> index 000000000000..436547f3b155
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
> @@ -0,0 +1,167 @@
> +Qualcomm SoundWire Controller Bindings
> +
> +
> +This binding describes the Qualcomm SoundWire Controller along with its
> +board specific bus parameters.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,soundwire-v<MAJOR>.<MINOR>.<STEP>",
> +		    Example:
> +			"qcom,soundwire-v1.3.0"
> +			"qcom,soundwire-v1.5.0"
> +			"qcom,soundwire-v1.6.0"
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: the base address and size of SoundWire controller
> +		    address space.
> +
> +- interrupts:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: should specify the SoundWire Controller IRQ
> +
> +- clock-names:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: should be "iface" for SoundWire Controller interface clock
> +
> +- clocks:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: should specify the SoundWire Controller interface clock
> +
> +- #sound-dai-cells:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: must be 1 for digital audio interfaces on the controller.
> +
> +- qcom,dout-ports:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: must be count of data out ports
> +
> +- qcom,din-ports:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: must be count of data in ports
> +
> +- qcom,ports-offset1:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: should specify payload transport window offset1 of each
> +		    data port. Out ports followed by In ports.
> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> +
> +- qcom,ports-offset2:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: should specify payload transport window offset2 of each
> +		    data port. Out ports followed by In ports.
> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.

Do we need to define these two in DT? Would this not be allocated in
Software and programmed?

> +
> +- qcom,ports-sinterval-low:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: should be sample interval low of each data port.
> +		    Out ports followed by In ports. Used for Sample Interval
> +		    calculation.
> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> +
> +- qcom,ports-word-length:
> +	Usage: optional
> +	Value type: <prop-encoded-array>
> +	Definition: should be size of payload channel sample.
> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> +
> +- qcom,ports-block-pack-mode:
> +	Usage: optional
> +	Value type: <prop-encoded-array>
> +	Definition: should be 0 or 1 to indicate the block packing mode.
> +		    0 to indicate Blocks are per Channel
> +		    1 to indicate Blocks are per Port.
> +		    Out ports followed by In ports.
> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> +
> +- qcom,ports-block-group-count:
> +	Usage: optional
> +	Value type: <prop-encoded-array>
> +	Definition: should be in range 1 to 4 to indicate how many sample
> +		    intervals are combined into a payload.
> +		    Out ports followed by In ports.
> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> +
> +- qcom,ports-lane-control:
> +	Usage: optional
> +	Value type: <prop-encoded-array>
> +	Definition: should be in range 0 to 7 to identify which	data lane
> +		    the data port uses.
> +		    Out ports followed by In ports.
> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> +
> +- qcom,ports-hstart:
> +	Usage: optional
> +	Value type: <prop-encoded-array>
> +	Definition: should be number identifying lowerst numbered coloum in
> +		    SoundWire Frame, i.e. left edge of the Transport sub-frame
> +		    for each port. Values between 0 and 15 are valid.
> +		    Out ports followed by In ports.
> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.
> +
> +- qcom,ports-hstop:
> +	Usage: optional
> +	Value type: <prop-encoded-array>
> +	Definition: should be number identifying highest numbered coloum in
> +		    SoundWire Frame, i.e. the right edge of the Transport
> +		    sub-frame for each port. Values between 0 and 15 are valid.
> +		    Out ports followed by In ports.
> +		    More info in MIPI Alliance SoundWire 1.0 Specifications.

Ditto with these two as well
-- 
~Vinod
