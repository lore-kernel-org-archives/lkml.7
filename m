Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4379ACA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1B320650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KaGKOlu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405106AbfJWLuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:50:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55148 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733180AbfJWLuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:50:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id g7so2816598wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 04:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wDYk9ecxVmBs+fLPH4NRWrGaP2z4tJFrCfIWmLCCUuk=;
        b=KaGKOlu8YrKxfNkM1N0LQQcM5xZYyJR+rVFsi0De4kZtD7uAZp8VWGNqlQVeo6Im52
         iPmveajFItIOTHJix9H0JOU+2IVkb3BXnkxcsGeB2IWfNLlGAoE9FCXLBHyKfqi002RB
         1EQMmowGvO9CHqnXHRlpH8E6VVat2qBPT3f9AZ1JJbuebnSSJltD7LldgvpkgjMEgP6M
         zSVgR0OQiBwAeECibJD/ho4PYMaQaVPRSqhQ26NBkxpRRAZd0X0S7Mk0OEeBwkOBYEh4
         BZGLuIEk96a2BdRQPZBV3JKVM19Bsy6TH88FO8K63nuOSCDEHaMpCn/5OHhgbZCWLO6g
         JTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wDYk9ecxVmBs+fLPH4NRWrGaP2z4tJFrCfIWmLCCUuk=;
        b=TttOcesXnTKzA+RQOCN5IWOIXQQQwe/O3UUcO/rp9JUiWU7QaGDyNQzAUSX+Zn+Pom
         28GKtAqNaa6wQBK10w2dAu25b4g0UfaZrc/7Nqpps4TmuOphlhmk1b1gniMXQew7D1jm
         /3GcfQZlNW36h3AtVbhMkUpgjTAA45In2UayEHcnEoBfjFq2uw38gg7ba8GqPtkLjM5k
         QqAwtwkSt+sCVZmrVdoXHAqYeD0AwZXMUPx/FmrtmK9c3wINg43pkioEvuq5XbbchyyN
         IvnjLbOiCFxpkNGvtrGabY0fbKKwKnI0xy2ONZ6k+KLmh8BX1qApAS8GT0WjMeRSkJ3S
         fFSA==
X-Gm-Message-State: APjAAAV/K0DDCDs7lS843Y3ieYa5E8wm3oGAkahOUUz5m5vzKmcuB7Vv
        Kagn2MarImJ9xhieMmVTTO1jZQ==
X-Google-Smtp-Source: APXvYqy/5LGwNsdjQoZRl8FIEKa93VFwqP0nK7ixRAhHPotJv2ZJeht3bwVZ2vma4fAkn5NDziu6+A==
X-Received: by 2002:a05:600c:2214:: with SMTP id z20mr7692758wml.10.1571831422367;
        Wed, 23 Oct 2019 04:50:22 -0700 (PDT)
Received: from [192.168.27.135] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id j19sm38467203wre.0.2019.10.23.04.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 04:50:21 -0700 (PDT)
Subject: Re: [PATCH 5/5] ARM: dts: qcom: msm8974: add interconnect nodes
To:     Brian Masney <masneyb@onstation.org>, agross@kernel.org,
        bjorn.andersson@linaro.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20191013080804.10231-1-masneyb@onstation.org>
 <20191013080804.10231-6-masneyb@onstation.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d154b0c6-fc39-bebc-d1b5-cc179fb6055d@linaro.org>
Date:   Wed, 23 Oct 2019 14:50:19 +0300
MIME-Version: 1.0
In-Reply-To: <20191013080804.10231-6-masneyb@onstation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

Thanks for the patch!

On 13.10.19 г. 11:08 ч., Brian Masney wrote:
> Add interconnect nodes that's needed to support bus scaling.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 60 +++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index bdbde5125a56..ed98d14a88b1 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /dts-v1/;
>  
> +#include <dt-bindings/interconnect/qcom,msm8974.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,gcc-msm8974.h>
>  #include <dt-bindings/clock/qcom,mmcc-msm8974.h>
> @@ -1106,6 +1107,60 @@
>  			};
>  		};
>  
> +		bimc: interconnect@fc380000 {
> +			reg = <0xfc380000 0x6a000>;
> +			compatible = "qcom,msm8974-bimc";
> +			#interconnect-cells = <1>;
> +			clock-names = "bus", "bus_a";
> +			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
> +			         <&rpmcc RPM_SMD_BIMC_A_CLK>;
> +		};
> +
> +		cnoc: interconnect@fc480000 {
> +			reg = <0xfc480000 0x4000>;
> +			compatible = "qcom,msm8974-cnoc";
> +			#interconnect-cells = <1>;
> +			clock-names = "bus", "bus_a";
> +			clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
> +			         <&rpmcc RPM_SMD_CNOC_A_CLK>;
> +		};
> +
> +		mmssnoc: interconnect@fc478000 {
> +			reg = <0xfc478000 0x4000>;
> +			compatible = "qcom,msm8974-mmssnoc";
> +			#interconnect-cells = <1>;
> +			clock-names = "bus", "bus_a";
> +			clocks = <&mmcc MMSS_S0_AXI_CLK>,
> +			         <&mmcc MMSS_S0_AXI_CLK>;
> +		};
> +
> +		ocmemnoc: interconnect@fc470000 {
> +			reg = <0xfc470000 0x4000>;
> +			compatible = "qcom,msm8974-ocmemnoc";
> +			#interconnect-cells = <1>;
> +			clock-names = "bus", "bus_a";
> +			clocks = <&rpmcc RPM_SMD_OCMEMGX_CLK>,
> +			         <&rpmcc RPM_SMD_OCMEMGX_A_CLK>;
> +		};
> +
> +		pnoc: interconnect@fc468000 {
> +			reg = <0xfc468000 0x4000>;
> +			compatible = "qcom,msm8974-pnoc";
> +			#interconnect-cells = <1>;
> +			clock-names = "bus", "bus_a";
> +			clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
> +			         <&rpmcc RPM_SMD_PNOC_A_CLK>;
> +		};
> +
> +		snoc: interconnect@fc460000 {
> +			reg = <0xfc460000 0x4000>;
> +			compatible = "qcom,msm8974-snoc";
> +			#interconnect-cells = <1>;
> +			clock-names = "bus", "bus_a";
> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> +			         <&rpmcc RPM_SMD_SNOC_A_CLK>;
> +		};

It would have been nice to have the DT nodes sorted by address, but i suppose it
doesn't make much difference, as the rest of the nodes in this file are unsorted
anyway.

> +
>  		mdss: mdss@fd900000 {
>  			status = "disabled";
>  
> @@ -1152,6 +1207,11 @@
>  				              "core",
>  				              "vsync";
>  
> +				interconnects = <&mmssnoc MNOC_MAS_GRAPHICS_3D &bimc BIMC_SLV_EBI_CH0>,
> +				                <&ocmemnoc OCMEM_VNOC_MAS_GFX3D &ocmemnoc OCMEM_SLV_OCMEM>;

Who will be the requesting bandwidth to DDR and ocmem? Is it the display or GPU
or both? The above seem like GPU-related interconnects, so maybe these
properties should be in the GPU DT node.

> +				interconnect-names = "mdp0-mem",
> +				                     "mdp1-mem";

As the second path is not to DDR, but to ocmem, it might be better to call it
something like "gpu-ocmem".

Thanks,
Georgi

> +
>  				ports {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>
