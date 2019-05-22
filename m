Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E44C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 03:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4544A2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 03:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pbcHDo3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfEVDbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 23:31:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35725 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbfEVDbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 23:31:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id t87so559346pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 20:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=70DJ6xEYXdyE5ONMBui8fhHROrLWF1i2GATP34gSzBE=;
        b=pbcHDo3xPViuCzHm2rSbJYkI9lDRRhEKtkcVN/h8NeSGBWVbhQOz47Yj2hT+Tc06FV
         xtASp0+1WdTHgsegau+V0DqUpx2Yr87Li75jrWQjs23pxqIsDWBWbPuPqy+EkOEPtzoj
         mC5MlchKkNL00s3TyGX+HgATuaVkur5SydLyEft/6oiYTbp4hWvh3ygzYJ6nQkYee+bi
         HRdtBzcJHBMQbw+MhhPbMPch2UGxBkFUbgpoTwsBDn3102BwxVYIwwHQYzrmAfpQACbo
         ONKWAk6/fgbBFygsgPf5u3+/OEqcqzR3WxblPf4zWjXQ2OMAEL4nQ6UgKJuOkYXuvaAT
         g+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=70DJ6xEYXdyE5ONMBui8fhHROrLWF1i2GATP34gSzBE=;
        b=OUtEh17fXnVQ7atJMRu/rK3HjyyKGadzyr2I9tjxToeo1t0hkD8G23vk6fFSw4QLbL
         ejV/eldA56YYf5S01yFpWVHEhRFfgWE5UFV8C/WLvaAk8dehZKE6j8HBQfEiuZThCE3Z
         nXRql7gGvwZbvwC7GCgE+v3BWqHxLHQE2mUor1eZFp1j+Bz7bENjdZFFWipCHgfRioG9
         Xqg/KIxB4ldQA5d8aOXARSrJY1MhqpUjSqBldn2xpapC5umjoZC0JYJ0FxMhCvyotmLz
         H6jdtXcdNwZtiHxNpNCxL4VRfuOE7wfcAETIpIsjOkBHn251Lb4qHl2pHWZFdFOsk0et
         XD4A==
X-Gm-Message-State: APjAAAXUcWvfn/4IQz+HeTXrsSQB9KAPFPumaJnRge3exA76MCx673Xl
        ngP+ti5iI7inupjlp1fghVpwzw==
X-Google-Smtp-Source: APXvYqx/zst8wDzIb6P89YyExTovp2xI3XT920F4myuEeSrUm2I9hhhxwU5SxZOdntWJE79iRgVyXg==
X-Received: by 2002:a62:5306:: with SMTP id h6mr35072808pfb.29.1558495893384;
        Tue, 21 May 2019 20:31:33 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w66sm45540879pfb.47.2019.05.21.20.31.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 20:31:32 -0700 (PDT)
Date:   Tue, 21 May 2019 20:31:30 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, niklas.cassel@linaro.org,
        marc.w.gonzalez@free.fr, sibis@codeaurora.org,
        daniel.lezcano@linaro.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/9] arm64: dts: qcom: qcs404: Add PSCI cpuidle low
 power states
Message-ID: <20190522033130.GL3137@builder>
References: <cover.1558430617.git.amit.kucheria@linaro.org>
 <cddc5957a510eef61284656fd1d739d4112a2daa.1558430617.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cddc5957a510eef61284656fd1d739d4112a2daa.1558430617.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21 May 02:35 PDT 2019, Amit Kucheria wrote:

> From: Niklas Cassel <niklas.cassel@linaro.org>
> 
> Add device bindings for cpuidle states for cpu devices.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> [rename the idle-states to more generic names and fixups]
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Applied

Regards,
Bjorn

>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index e8fd26633d57..0a9b29af64c2 100644
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
> +			entry-method = "psci";
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
> -- 
> 2.17.1
> 
