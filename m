Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B113C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0FB212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfFGMuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:50:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:32818 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbfFGMuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 08:50:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 05:50:23 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jun 2019 05:50:23 -0700
Received: from kwong4-mobl.amr.corp.intel.com (unknown [10.252.203.122])
        by linux.intel.com (Postfix) with ESMTP id 76DB058044F;
        Fri,  7 Jun 2019 05:50:22 -0700 (PDT)
Subject: Re: [alsa-devel] [RFC PATCH 5/6] dt-bindings: soundwire: add bindings
 for Qcom controller
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org, vkoul@kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
 <20190607085643.932-6-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f2ea97b2-935d-0c7d-cb55-6e16a19c2060@linux.intel.com>
Date:   Fri, 7 Jun 2019 07:50:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607085643.932-6-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/19 3:56 AM, Srinivas Kandagatla wrote:
> This patch adds bindings for Qualcomm soundwire controller.
> 
> Qualcomm SoundWire Master controller is present in most Qualcomm SoCs
> either integrated as part of WCD audio codecs via slimbus or
> as part of SOC I/O.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   .../bindings/soundwire/qcom,swr.txt           | 62 +++++++++++++++++++
>   1 file changed, 62 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,swr.txt

you seem to use the 'swr' prefix in this patch. Most implementers use 
'sdw', and that's the default also used in the MIPI DisCo spec for 
properties. Can we align on the same naming conventions?

> 
> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,swr.txt b/Documentation/devicetree/bindings/soundwire/qcom,swr.txt
> new file mode 100644
> index 000000000000..eb84d0f4f36f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soundwire/qcom,swr.txt
> @@ -0,0 +1,62 @@
> +Qualcomm SoundWire Controller
> +
> +This binding describes the Qualcomm SoundWire Controller Bindings.
> +
> +Required properties:
> +
> +- compatible:		Must be "qcom,soundwire-v<MAJOR>.<MINOR>.<STEP>",
> +	 		example:
> +			"qcom,soundwire-v1.3.0"
> +			"qcom,soundwire-v1.5.0"
> +			"qcom,soundwire-v1.6.0"
> +- reg:			SoundWire controller address space.
> +- interrupts:		SoundWire controller interrupt.
> +- clock-names:		Must contain "iface".
> +- clocks:		Interface clocks needed for controller.
> +- #sound-dai-cells:	Must be 1 for digital audio interfaces on the controllers.
> +- #address-cells:	Must be 1 for SoundWire devices;
> +- #size-cells:		Must be <0> as SoundWire addresses have no size component.
> +- qcom,dout-ports: 	Must be count of data out ports
> +- qcom,din-ports: 	Must be count of data in ports
> +- qcom,ports-offset1:	Must be frame offset1 of each data port.
> +			Out followed by In. Used for Block size calculation.
> +- qcom,ports-offset2: 	Must be frame offset2 of each data port.
> +			Out followed by In. Used for Block size calculation.
> +- qcom,ports-sinterval-low: Must be sample interval low of each data port.
> +			Out followed by In. Used for Sample Interval calculation.

These definitions are valid only for specific types of ports, I believe 
here it's a 'reduced' port since offset2 is not required for simpler 
ports and you don't have Hstart/Hstop.

so if you state that all of these properties are required, you are 
explicitly ruling out future implementations of simple ports or will 
have to redefine them later.

Also the definition 'frame offset1/2' is incorrect. the offset is 
defined within each Payload Transport Window - not each frame - and its 
definition depends on the packing mode used, which isn't defined or 
stated here.

And last it looks like you assume a fixed frame shape - likely 50 rows 
by 8 columns, it might be worth adding a note on the max values for 
offset1/2 implied by this frame shape.

> +
> += SoundWire devices
> +Each subnode of the bus represents SoundWire device attached to it.
> +The properties of these nodes are defined by the individual bindings.
> +
> += EXAMPLE
> +The following example represents a SoundWire controller on DB845c board
> +which has controller integrated inside WCD934x codec on SDM845 SoC.
> +
> +soundwire: soundwire@c85 {
> +	compatible = "qcom,soundwire-v1.3.0";
> +	reg = <0xc85 0x20>;
> +	interrupts = <20 IRQ_TYPE_EDGE_RISING>;
> +	clocks = <&wcc>;
> +	clock-names = "iface";
> +	#sound-dai-cells = <1>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	qcom,dout-ports	= <6>;
> +	qcom,din-ports	= <2>;
> +	qcom,ports-sinterval-low =/bits/ 8  <0x07 0x1F 0x3F 0x7 0x1F 0x3F 0x0F 0x0F>;
> +	qcom,ports-offset1 = /bits/ 8 <0x01 0x02 0x0C 0x6 0x12 0x0D 0x07 0x0A >;
> +	qcom,ports-offset2 = /bits/ 8 <0x00 0x00 0x1F 0x00 0x00 0x1F 0x00 0x00>;
> +
> +	/* Left Speaker */
> +	wsa8810@1{
> +		....
> +		reg = <1>;
> +	};
> +
> +	/* Right Speaker */
> +	wsa8810@2{
> +		....
> +		reg = <2>;
> +	};
> +};
> 

