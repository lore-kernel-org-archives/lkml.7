Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C82C468BC
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 04:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB3820833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 04:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560142502;
	bh=pNVtwDi1EOVr8B79cvvDcqYTcIy9EArIA8yhGGfUK+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=biPEUPNFH6VPH90oUFqmzf91HvLbrOsBLWq992Dnh8yjpdNA+JtrZjtq6fck7IoJf
	 fHxyvhMs/YK6kFiOLvNOFuR85Fcd2fSuaXehlf8zy+UcLH2/zDXZF5DST1oltORwLs
	 qaL4BqyphLlVXq4DaWZFEhXch/7ftWDNusGVI+co=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfFJEzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 00:55:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbfFJEzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 00:55:00 -0400
Received: from localhost (unknown [122.182.223.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AAEE207E0;
        Mon, 10 Jun 2019 04:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560142499;
        bh=pNVtwDi1EOVr8B79cvvDcqYTcIy9EArIA8yhGGfUK+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KTw7EhRntHexBM4QG2iHqWsly9oEVnROvuplzi0KrEIcXo/VAGLOAwdezCKeKbw+A
         7+UkZAQrAkWlvgsVhIfNVUIS4+SfVPT8bzCEpYHDJm1WhrjW34GBxGo/yojiyDLzTx
         lCF+LkLtz34CdJoE6zX00mQbSPF8ZwS6FJJtzAg0=
Date:   Mon, 10 Jun 2019 10:21:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/6] dt-bindings: soundwire: add bindings for Qcom
 controller
Message-ID: <20190610045150.GJ9160@vkoul-mobl.Dlink>
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
 <20190607085643.932-6-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607085643.932-6-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-06-19, 09:56, Srinivas Kandagatla wrote:
> This patch adds bindings for Qualcomm soundwire controller.
> 
> Qualcomm SoundWire Master controller is present in most Qualcomm SoCs
> either integrated as part of WCD audio codecs via slimbus or
> as part of SOC I/O.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/soundwire/qcom,swr.txt           | 62 +++++++++++++++++++

So I was expecting to see bus support patches for OF first. I think you
have missed those changes. Please do include those in v2 with bindings
and OF support for bus.

>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,swr.txt
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

On these I think we should have specified dpn properties as specified in
DisCo, but then looking at spec we do not define that for master, but
bus seems to have it.

Pierre do you why master does not have dpn properties in DisCo?

> +- qcom,ports-offset1:	Must be frame offset1 of each data port.
> +			Out followed by In. Used for Block size calculation.
> +- qcom,ports-offset2: 	Must be frame offset2 of each data port.
> +			Out followed by In. Used for Block size calculation.
> +- qcom,ports-sinterval-low: Must be sample interval low of each data port.
> +			Out followed by In. Used for Sample Interval calculation.

These are software so do not belong here
-- 
~Vinod
