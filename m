Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EDBC2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 03:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E712176D
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 03:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pRvRA2I6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfL2DS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 22:18:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37259 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfL2DS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 22:18:56 -0500
Received: by mail-pl1-f195.google.com with SMTP id c23so13348641plz.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 19:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fJBQZ6q3+2lZpk+M9I6LDvvhdKjGpOfzDinaq2pqIgA=;
        b=pRvRA2I6QSL3plHmxs23DCx7OVMNeFWKizs7qkhPQ4lsfqvJ9VnJBNOV7CFjeRk9vC
         Ii0rFrga8vUWviVzCzkAdP80imrz117TO76H+LH1L8ExqcVdYDI69xSJimqVo6bmdqIk
         oRbQ+Tb3XfeuFpcHvjsb3UycX0ML7/00qbaYgXHjeuglW0z9VvhK9dx0pIe0AGovXH1t
         Bvc5UAppa3Fr8RHqElyi6bMHNPMDu5y0dfjPGV7u3zbE5GoYUjdqXsy3c39SiM5fWmjF
         oeMYAOmDy6cNmvwlzYaVQA68wRx3Js4gCWAoJEbCVEqAyd5cj1hJz370UJZdxGVUloTV
         56BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fJBQZ6q3+2lZpk+M9I6LDvvhdKjGpOfzDinaq2pqIgA=;
        b=FvQLqe0cOWT0KL2pqsmW649hAMxuLbVRkJdfK0VxgljTZfgcZYXJexCRbjCJHLJuf8
         +mluajpg4tCmH3ZdHhEzwJukdNajYF0XqbQSw1as3HxATc3SA/8cQLWBu630QnMPGVYu
         OjzIrMKllpufsjGHwkZHjqNR7veEFi3LJ7BlplSSDe6I/Gp3Q0G6loUejCf5DfSdc+TL
         r/pSLsmxVOyhp+c5draWCv01lgN5K9Uv6O+oFTEvNf0/mecaz/XBR86ittl/ty64tY2w
         hs5ltP6ClQ45DUSLIA/hwPsdbPrziblKkPXfH+L1ViwCGq1nve/2m0b5cemjVvyHh6uc
         eZXg==
X-Gm-Message-State: APjAAAV5vvPch+D1vp3DaRLYQwoK5Hyt3IkbHK9oqGpqBJsqQn7uUXcR
        0xFFCiKXxkJxi5INDQAyrYrFWCyiYwo=
X-Google-Smtp-Source: APXvYqxPapWvKkYX16lehlOKRxG2uLZL6TiZv9y9GqwIxrLile80wxO9ddaWADvxBHLMzsc5BaLkpg==
X-Received: by 2002:a17:902:6b03:: with SMTP id o3mr39105245plk.331.1577589536058;
        Sat, 28 Dec 2019 19:18:56 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u128sm24121926pfu.60.2019.12.28.19.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 19:18:55 -0800 (PST)
Date:   Sat, 28 Dec 2019 19:18:53 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dikshita Agarwal <dikshita@codeaurora.org>
Cc:     linux-media@vger.kernel.org, stanimir.varbanov@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vgarodia@codeaurora.org
Subject: Re: [PATCH 1/3] arm64: dts: sc7180: Add Venus video codec DT node
Message-ID: <20191229031853.GL3755841@builder>
References: <1576828760-13176-1-git-send-email-dikshita@codeaurora.org>
 <1576828760-13176-2-git-send-email-dikshita@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576828760-13176-2-git-send-email-dikshita@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19 Dec 23:59 PST 2019, Dikshita Agarwal wrote:

> This adds Venus video codec DT node for sc7180.
> 
> Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 6876aae2..42c70f5 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -10,6 +10,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/phy/phy-qcom-qusb2.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/clock/qcom,videocc-sc7180.h>
>  
>  / {
>  	interrupt-parent = <&intc>;
> @@ -66,6 +67,11 @@
>  			compatible = "qcom,cmd-db";
>  			no-map;
>  		};
> +
> +		venus_mem: memory@8F600000 {
> +			reg = <0 0x8F600000 0 0x500000>;
> +			no-map;
> +		};
>  	};
>  
>  	cpus {
> @@ -1042,6 +1048,36 @@
>  			};
>  		};
>  
> +		venus: video-codec@aa00000 {
> +			compatible = "qcom,sc7180-venus";
> +			reg = <0 0x0aa00000 0 0xff000>;
> +			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
> +			power-domains = <&videocc VENUS_GDSC>,

Should this be aligned with the DT refactoring done for sdm845, where
the GDSC is moved into the *-core subnodes etc?

Regards,
Bjorn

> +					<&videocc VCODEC0_GDSC>;
> +			power-domain-names = "venus", "vcodec0";
> +			clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
> +				<&videocc VIDEO_CC_VENUS_AHB_CLK>,
> +				<&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>,
> +				<&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
> +				<&videocc VIDEO_CC_VCODEC0_AXI_CLK>;
> +			clock-names = "core", "iface", "bus",
> +					"vcodec0_core", "vcodec0_bus";
> +			iommus = <&apps_smmu 0x0C00 0x60>;
> +			memory-region = <&venus_mem>;
> +
> +			video-core0 {
> +					compatible = "venus-decoder";
> +			};
> +
> +			video-core1 {
> +					compatible = "venus-encoder";
> +			};
> +
> +			video-firmware {
> +					iommus = <&apps_smmu 0x0C42 0x0>;
> +			};
> +		};
> +
>  		pdc: interrupt-controller@b220000 {
>  			compatible = "qcom,sc7180-pdc", "qcom,pdc";
>  			reg = <0 0x0b220000 0 0x30000>;
> -- 
> 1.9.1
> 
