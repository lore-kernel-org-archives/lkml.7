Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0034FC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3DD21905
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554530855;
	bh=7fIpk3V3XmT6BNxdxoF82pxsESFKa6HJP6mDsudjyf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zPRK34k9q7b5zHeGVipMXmqt3onLZ26EKVhbNyeVI6OMikrVChdssiUNl3hOOmibB
	 mmYNVv3iEWtsG9e252tc/H0UXUUqznhSFW/K0XgPlHzUPfAdK3K71FyH4EPCJoFGn8
	 cuKvLvlTjolfrROCRanI46/t+A1XU6ozoi5xXX4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfDFGHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 02:07:34 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37321 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfDFGHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 02:07:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id w23so4185570ply.4;
        Fri, 05 Apr 2019 23:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=kA5XpT8ny/uQYtFJqHHiKeW1TpUP/VLJHc15eh1KuA0=;
        b=ie62Zwk8pnKy+sgTJc9UIGThDFSYw1deOpOs63Co0OFgPiyB28hyCvUUBESqyzxW8K
         CWZLVxT7HvrzKmpIEt4qcsxUikhte2cQJvEn/Cg4Rr+Qd7AERkCkJcXR3aX5DQKOB3Aj
         OzutsDJUEbFgRsRz0mg218K9Hu88E2N40LV9EeVV5Zqzu0wZIu2uOduRx4r+hNk/MdEa
         X3Da9NaalzgSB+LDqBhfj75j4HsD0MuMPwDKzGdbBAh1j7HVwH2eZalXUaC4any1Tt0r
         OFI9e5Ptl7MyTzpoHAKgdP35JdtKUchN/ZEBPeTrIOI1NFQ0qz3Cg3PVXlIsCaMCFfWh
         hE5Q==
X-Gm-Message-State: APjAAAUajH7IYl0rYVubVljxSbaRVD+svNJQ8mi8ArHs4Wc6DfZx90Bo
        qCkFhQno+pTTUF3dqH7PBQ==
X-Google-Smtp-Source: APXvYqzJT0xpk2WPmvwNNewIqYhd1psdFnCvsQW7ukVMfVaKhIO7ZnNCWvMidNE9mUf3mbKKkddyJQ==
X-Received: by 2002:a17:902:1003:: with SMTP id b3mr16949745pla.306.1554530849380;
        Fri, 05 Apr 2019 23:07:29 -0700 (PDT)
Received: from localhost ([210.160.217.71])
        by smtp.gmail.com with ESMTPSA id c134sm47143046pfc.87.2019.04.05.23.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 23:07:28 -0700 (PDT)
Message-ID: <5ca84220.1c69fb81.2daad.3164@mx.google.com>
Date:   Sat, 06 Apr 2019 01:07:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 7/9] dt-bindings: power: avs: Add support for CPR
 (Core Power Reduction)
References: <20190404050931.9812-1-niklas.cassel@linaro.org>
 <20190404050931.9812-8-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404050931.9812-8-niklas.cassel@linaro.org>
X-Mutt-References: <20190404050931.9812-8-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 07:09:28AM +0200, Niklas Cassel wrote:
> Add DT bindings to describe the CPR HW found on certain Qualcomm SoCs.
> 
> Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  .../bindings/power/avs/qcom,cpr.txt           | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/avs/qcom,cpr.txt b/Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
> new file mode 100644
> index 000000000000..541c9b31cd3b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
> @@ -0,0 +1,119 @@
> +QCOM CPR (Core Power Reduction)
> +
> +CPR (Core Power Reduction) is a technology to reduce core power on a CPU
> +or other device. Each OPP of a device corresponds to a "corner" that has
> +a range of valid voltages for a particular frequency. While the device is
> +running at a particular frequency, CPR monitors dynamic factors such as
> +temperature, etc. and suggests adjustments to the voltage to save power
> +and meet silicon characteristic requirements.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: must be "qcom,cpr"

Needs to be SoC specific.

> +
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: base address and size of the rbcpr register region
> +
> +- interrupts:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: list of three interrupts in order of irq0, irq1, irq2

Does each irq have some defined meaning/function?

> +
> +- acc-syscon:
> +	Usage: optional
> +	Value type: <phandle>
> +	Definition: phandle to syscon for writing ACC settings
> +
> +- nvmem:
> +	Usage: required
> +	Value type: <phandle>
> +	Definition: phandle to nvmem provider containing efuse settings
> +
> +- nvmem-names:
> +	Usage: required
> +	Value type: <string>
> +	Definition: must be "qfprom"
> +
> +vdd-mx-supply = <&pm8916_l3>;
> +
> +- qcom,cpr-ref-clk:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: rate of reference clock in kHz

Can't you use the clock binding for this?

> +
> +- qcom,cpr-timer-delay-us:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: delay in uS for the timer interval
> +
> +- qcom,cpr-timer-cons-up:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: Consecutive number of timer intervals, or units of
> +		    qcom,cpr-timer-delay-us, that occur before issuing an up
> +		    interrupt
> +
> +- qcom,cpr-timer-cons-down:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: Consecutive number of timer intervals, or units of
> +		    qcom,cpr-timer-delay-us, that occur before issuing a down
> +		    interrupt
> +
> +- qcom,cpr-up-threshold:
> +	Usage: optional
> +	Value type: <u32>
> +	Definition: The threshold for CPR to issue interrupt when error_steps
> +		    is greater than it when stepping up
> +
> +- qcom,cpr-down-threshold:
> +	Usage: optional
> +	Value type: <u32>
> +	Definition: The threshold for CPR to issue interrdownt when error_steps

typo

> +		    is greater than it when stepping down
> +
> +- qcom,cpr-down-threshold:
> +	Usage: optional
> +	Value type: <u32>
> +	Definition: Idle clock cycles ring oscillator can be in
> +
> +- qcom,cpr-gcnt-us:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: The time for gate count in uS
> +
> +- qcom,vdd-apc-step-up-limit:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: Limit of vdd-apc-supply steps for scaling up

# of steps or a voltage?

> +
> +- qcom,vdd-apc-step-down-limit:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: Limit of vdd-apc-supply steps for scaling down
> +
> +Example:
> +
> +	avs@b018000 {
> +		compatible = "qcom,cpr";
> +		reg = <0xb018000 0x1000>;
> +		interrupts = <0 15 1>, <0 16 1>, <0 17 1>;
> +		vdd-mx-supply = <&pm8916_l3>;
> +		acc-syscon = <&tcsr>;
> +		nvmem = <&qfprom>;
> +		nvmem-names = "qfprom";
> +
> +		qcom,cpr-ref-clk = <19200>;
> +		qcom,cpr-timer-delay-us = <5000>;
> +		qcom,cpr-timer-cons-up = <0>;
> +		qcom,cpr-timer-cons-down = <2>;
> +		qcom,cpr-up-threshold = <0>;
> +		qcom,cpr-down-threshold = <2>;
> +		qcom,cpr-idle-clocks = <15>;
> +		qcom,cpr-gcnt-us = <1>;
> +		qcom,vdd-apc-step-up-limit = <1>;
> +		qcom,vdd-apc-step-down-limit = <1>;
> +	};
> -- 
> 2.20.1
> 

