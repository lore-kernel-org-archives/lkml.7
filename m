Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CBBC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E915721743
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KLN3Piuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfEQPmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 11:42:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36525 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbfEQPmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 11:42:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id j187so7208060wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 08:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0ljscussLX+Xz81jCi4NKL5yP2ulmpgvfBkZvg2epaI=;
        b=KLN3PiuqIzN+THEIDcnop/qPR0Y7vjupFcPbrwQ4/jkRF1i+hANU9DyYhBQLHTDjql
         2+beV/LtVp3OH2TKx/yIjC9YSTBru/lmVueKMI8GkXDFaxaduF2htTrDH4hhnNpKBMme
         1Uq38vTSbEF4yrH5kd7hCWI+RCyY+za3ioxHsyyko+iGbEckxGsIhXnwfgH0VkJzsRjY
         KtcwPgo7nYWeNyPvSQR1C7nBJx136nDu4oWPTKNSsb7p0bMYFiAgS78Lnh/J2dlRwElU
         Xe1Z2boiIzhqXEyxt4XhC+HqEowZvfxJfDas9Men07mkoDF6SbQcLJ6f77pw2ctuVLRI
         OQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0ljscussLX+Xz81jCi4NKL5yP2ulmpgvfBkZvg2epaI=;
        b=ccI7WY3DoKEzKdODEAbUsnaBLo4Oyr0Kb+fatYgMGjh6ZMMq4ilwkpDq3cN8SM6JZm
         p/RFjWwdXT4PflB2wZbJ0GM5nZBRqI2jV9QOG3Lk+0ELeGKYJzLPnKYVmxUZDYNFZE2C
         qFmtKxLY7YdinL+xu/byMsqFfzfNMIWy7F4RmlpxctViJSzzQWbo6ycRpvfZLEqndENh
         BflJm6RMIrbNrq9m+xkUp8OTmcoACiP593WdpqgciFV7pg159VA5nfyBXMpeSSAxJuip
         GuhK/mFtngLkV9Nww9X8+OxotxQMjtevE6ZIDSCgsbvT4ouRRJtRH7h/jOc1N3BElpYy
         ZtTQ==
X-Gm-Message-State: APjAAAVQnCKX+XL6zl5gf0db1iL4+Y6+U+zLn3Dbf9VrS+j+Rh6yk/6q
        ag6cJV7w8Y5wkBLREI/Cvuchcw==
X-Google-Smtp-Source: APXvYqyKtujFcksA0NJ1l2dY7gUa/W1S2MMATMRv56p+AInonz4cSuBZK7+0OUqA3Ujk+P25vXHyVw==
X-Received: by 2002:a1c:9c03:: with SMTP id f3mr32886891wme.67.1558107741425;
        Fri, 17 May 2019 08:42:21 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id v11sm8441552wrq.80.2019.05.17.08.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 08:42:20 -0700 (PDT)
Subject: Re: [PATCHv1 5/8] arm64: dts: qcom: qcs404: Add PSCI cpuidle low
 power states
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        devicetree@vger.kernel.org
References: <cover.1557486950.git.amit.kucheria@linaro.org>
 <d3a517b90620fe167eb9fd27bcc88a43dce514b2.1557486950.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6efa62cb-2f9b-f462-95fc-b9bcddac76b2@linaro.org>
Date:   Fri, 17 May 2019 17:42:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d3a517b90620fe167eb9fd27bcc88a43dce514b2.1557486950.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2019 13:29, Amit Kucheria wrote:
> From: Niklas Cassel <niklas.cassel@linaro.org>
> 
> Add device bindings for cpuidle states for cpu devices.
> 
> [amit: rename the idle-states to more generic names and fixups]
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index e8fd26633d57..369c59c35bc7 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -30,6 +30,7 @@
>  			compatible = "arm,cortex-a53";
>  			reg = <0x100>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&CPU_SLEEP_0>;
>  			next-level-cache = <&L2_0>;
>  		};
>  
> @@ -38,6 +39,7 @@
>  			compatible = "arm,cortex-a53";
>  			reg = <0x101>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&CPU_SLEEP_0>;
>  			next-level-cache = <&L2_0>;
>  		};
>  
> @@ -46,6 +48,7 @@
>  			compatible = "arm,cortex-a53";
>  			reg = <0x102>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&CPU_SLEEP_0>;
>  			next-level-cache = <&L2_0>;
>  		};
>  
> @@ -54,6 +57,7 @@
>  			compatible = "arm,cortex-a53";
>  			reg = <0x103>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&CPU_SLEEP_0>;
>  			next-level-cache = <&L2_0>;
>  		};
>  
> @@ -61,6 +65,20 @@
>  			compatible = "cache";
>  			cache-level = <2>;
>  		};
> +
> +		idle-states {
> +			entry-method="psci";
> +
> +			CPU_SLEEP_0: cpu-sleep-0 {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "standalone-power-collapse";
> +				arm,psci-suspend-param = <0x40000003>;
> +				entry-latency-us = <125>;
> +				exit-latency-us = <180>;
> +				min-residency-us = <595>;
> +				local-timer-stop;
> +			};
> +		};
>  	};
>  
>  	firmware {
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

