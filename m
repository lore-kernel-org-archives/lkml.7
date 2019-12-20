Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7773C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE15D2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TWfDrkro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfLTJeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 04:34:44 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45496 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfLTJen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 04:34:43 -0500
Received: by mail-ed1-f68.google.com with SMTP id v28so7590334edw.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 01:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NTB7wX7Yv4jCUuAve4vjjE5dVjsx/SPNfAjKddDNjGA=;
        b=TWfDrkroJVL91zz3SzoGgEFWBV+3o/1TdQOazPMUiXOyF7Eg2eG4497kjHIBTG1wG1
         Vtg9OucWHFlGksGjOf2Gt5/8N8d2H8mnaueXjfY4BwJ8gS9SywFmxOYLL9X7R8MOCXg7
         EUQcKbGqPWiu4iWnvubdiHlsj+dKARxxammH8DECs4J2kuaU8ljFoXdWPuY2iSLayoZ/
         jDf4IhT9dftLRZg0RrEKlzvh4KyVQoneyT5aQ0BIq3jUKdwXhK5l6Hn/rw8+czugI/EN
         lmuAL9WNlTiIujJApVDuXzwdgFVQY9qrWcmVz7hinUyhZMPT3nUzecYMczWBaW1kL9UW
         krJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NTB7wX7Yv4jCUuAve4vjjE5dVjsx/SPNfAjKddDNjGA=;
        b=H4RiqPyuRfEhONk3umEkd14Qmee5MULWhso/8iCuLkx9dd77iYxUFkjc8qfsc2CL4f
         DqjSDBqWsZGCRczovqvdZSeRmK0QHgqB8s+94OWE9kkYLt+RgvR0ozKm1qhC37OjQ3xm
         4BBH68nzoLXKw1UCNDuwQUtItImlrqdF1/LN48GzfrRSzVkBNsvy66UdiB4fHfAILanW
         7NWMPzzcDrHb7c9bfJ5NlAl2DW+y3IFLAqIgYG67G3Ur1jFgwKGYnJPSUZ2wcEEe+AoI
         L+aKKUYwiakwOJvSailNKHSnL6xmlLa6lb8Jj8DnKmW017pzH0DqF0HoIzbsHNql91gS
         znMw==
X-Gm-Message-State: APjAAAVI6rP1kOh5iuQw6egS0nYmS46gNSI581RiA9JfPTrmzg+/ZRJy
        4MhgcCSdzXjTimZqhyyQY0/+VA==
X-Google-Smtp-Source: APXvYqwtedAE80TQ1voCP5xx8obcg7Jzf+08DPEo4f2WFFFbsiXKKauQR9XC8bMXaXk+7XM4CFAmiA==
X-Received: by 2002:a05:6402:229a:: with SMTP id cw26mr7564061edb.69.1576834481632;
        Fri, 20 Dec 2019 01:34:41 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.193])
        by smtp.googlemail.com with ESMTPSA id c20sm867853edt.67.2019.12.20.01.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 01:34:40 -0800 (PST)
Subject: Re: [PATCH 1/3] arm64: dts: sc7180: Add Venus video codec DT node
To:     Dikshita Agarwal <dikshita@codeaurora.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vgarodia@codeaurora.org
References: <1576828760-13176-1-git-send-email-dikshita@codeaurora.org>
 <1576828760-13176-2-git-send-email-dikshita@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <17a371c0-d73a-75eb-34f2-c9afb51d46f5@linaro.org>
Date:   Fri, 20 Dec 2019 11:34:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576828760-13176-2-git-send-email-dikshita@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dikshita,

Thanks for the patch.

On 12/20/19 9:59 AM, Dikshita Agarwal wrote:
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

Please use lower-case for hex numbers.

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
> +					<&videocc VCODEC0_GDSC>;
> +			power-domain-names = "venus", "vcodec0";
> +			clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
> +				<&videocc VIDEO_CC_VENUS_AHB_CLK>,
> +				<&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>,
> +				<&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
> +				<&videocc VIDEO_CC_VCODEC0_AXI_CLK>;

could you align those entries to the first one (you can use tabs and
after that spaces to align)

> +			clock-names = "core", "iface", "bus",
> +					"vcodec0_core", "vcodec0_bus";
> +			iommus = <&apps_smmu 0x0C00 0x60>;

lower-case please

> +			memory-region = <&venus_mem>;
> +
> +			video-core0 {
> +					compatible = "venus-decoder";

something is wrong with the indentation?

Please run checkpatch with --strict

> +			};
> +
> +			video-core1 {
> +					compatible = "venus-encoder";
> +			};
> +
> +			video-firmware {
> +					iommus = <&apps_smmu 0x0C42 0x0>;

lower-case

> +			};

This subnode should be in sc7180-idp.dts, because we assume that by
default the qcom platforms have TZ.

> +		};
> +
>  		pdc: interrupt-controller@b220000 {
>  			compatible = "qcom,sc7180-pdc", "qcom,pdc";
>  			reg = <0 0x0b220000 0 0x30000>;
> 

-- 
regards,
Stan
