Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12C1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A14A2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TmAEAI/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfDDCfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:35:09 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38617 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfDDCfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:35:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id g37so372686plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 19:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cpNPhnHlvkFGKfi0ejvd3Y/CasYlaZaOuSTN3WofdKg=;
        b=TmAEAI/T+eTuvNcldHaVpc+b/cE6vIuCCXrUeZtBaVlkR9xPLT+0/KQKrLlOV/1MDM
         FafHFR0G/rmLYC1icljCAcFTmLkXrBS5wK10vkcF/Cafk1pew43XI1/+9D7i2zKfcjgk
         Qs/rYwQH+Fn/6fzQkjXj1KeOvwiRI/1OGkMNx8ty3HYs0NJ72amaX52H5VwRP4jFq2Vx
         ovRJd9G1ZIo0gQsumJgNoJ7/igBfispNETVyoErzNfmGbSTllCs/5OejP5HUopM2rEm4
         jT9FrhrEQE8/0SNZetVdrbjttPVlOZ9OKLxarcuH+Ps+0PFulsNvQAAXACnOTZM4RsUm
         59mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cpNPhnHlvkFGKfi0ejvd3Y/CasYlaZaOuSTN3WofdKg=;
        b=fGJgWwxoNokwICmaCZRoT5sx0drPXIct5J8VUw/hzJi/arcaGY714ckAxK8eBnFboe
         ZE7mcidCVYCrWXYXcyKxNxnpvNbRu0VQyAfjW7bsAlPnXSYBxy6nNvfvMxeHsd4yEtsJ
         hrABYEOUs3KNXpM7lVZ9kKkBAx2IEFq+Sd+HGg3nR6eSx7b5Q6TKXVwMVBgj/ZjwoH42
         P7+Om0EO+BGNHzUWzQnZdb34DYkbYWVqg77Enxofi9eTzI18CfmfvOJO35NqM0wiTByi
         60sre+pqhp3iOSBS4eA98GB5hI4mr/PuwDBL3WISjzrOrbwVVvY4kNamlKfrNYJakg9x
         xRVQ==
X-Gm-Message-State: APjAAAXYO1QNgMeMR+giY1BsxOSBICNHVpf2ZODd1ONlnzTPhWgcWUd1
        74YRbEEhs5MBjLWP96vfB3W/og==
X-Google-Smtp-Source: APXvYqyJuDVfgeN9a2z/dG5Duu/R2TMvZ13v/DNNllDOnoBZXcl7VSW34o9tFWYDNrT9o+FV1gRRUA==
X-Received: by 2002:a17:902:8ecc:: with SMTP id x12mr3686623plo.0.1554345307521;
        Wed, 03 Apr 2019 19:35:07 -0700 (PDT)
Received: from [10.71.14.66] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id i15sm21581314pfd.162.2019.04.03.19.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 19:35:06 -0700 (PDT)
Subject: Re: [PATCH v4] arm64: dts: ls1088a: add one more thermal zone node
To:     Yuantian Tang <andy.tang@nxp.com>, shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, edubezval@gmail.com
References: <20190401032905.32711-1-andy.tang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <273bb946-8659-8e50-6598-3cffa6dff9f5@linaro.org>
Date:   Thu, 4 Apr 2019 04:35:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401032905.32711-1-andy.tang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 05:29, Yuantian Tang wrote:
> Ls1088a has 2 thermal sensors, core cluster and SoC platform. Core cluster
> sensor is used to monitor the temperature of core and SoC platform is for
> platform. The current dts only support the first sensor.
> This patch adds the second sensor node to dts to enable it.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---
> v4:
> 	- use hyphen instead of underscore in node name
> v3:
> 	- use more descriptive name for each zone
> v2:
> 	- Add more information about sensors to description
> PS: In order to keep consistency to the first thermal-zone node, there will
> be "WARNING: line over 80 characters" warnings.
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |   43 +++++++++++++++++++++--
>  1 files changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index 661137f..d6d4ff2 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -129,19 +129,19 @@
>  	};
>  
>  	thermal-zones {
> -		cpu_thermal: cpu-thermal {
> +		core-cluster-thermal {
>  			polling-delay-passive = <1000>;
>  			polling-delay = <5000>;
>  			thermal-sensors = <&tmu 0>;
>  
>  			trips {
> -				cpu_alert: cpu-alert {
> +				core_cluster_alert: core-cluster-alert {
>  					temperature = <85000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu_crit: cpu-crit {
> +				core_cluster_crit: core-cluster-crit {
>  					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "critical";
> @@ -150,7 +150,42 @@
>  
>  			cooling-maps {
>  				map0 {
> -					trip = <&cpu_alert>;
> +					trip = <&core_cluster_alert>;
> +					cooling-device =
> +						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};

Does it make sense to assign the same cooling devices to two different
thermal zones running different instances of governor ?

> +			};
> +		};
> +
> +		platform-thermal {
> +			polling-delay-passive = <1000>;
> +			polling-delay = <5000>;
> +			thermal-sensors = <&tmu 1>;
> +
> +			trips {
> +				platform_alert: platform-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				platform_crit: platform-crit {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&platform_alert>;
>  					cooling-device =
>  						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>  						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

