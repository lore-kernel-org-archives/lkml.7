Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D336FC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE512087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zC8ivZGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfEQQLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 12:11:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54370 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbfEQQLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 12:11:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id i3so7463715wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 09:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o3znglSYE3qWmbHWfVx7bUQXAqGJQvSQXgl1NOhCAVQ=;
        b=zC8ivZGjYMdfpaM3iFqctfmjEYxiou7E1dRg+77y5lw2eJ0a5+xq0gvLDIQv5iuONp
         wrei1mpheIyRIM0QyPMLCba4jnj2KksNNGzg1wNwO8eoHfbaqaNyxyH4jdtVf//2Acm9
         nhQeqxco9Dhbsm891E/BDwsPm2yJUkYx9qM/BpNUZ1ihzeu9Bq0Lf+nJV1RJU55nPzYM
         ejupTDvwK+3seXgL8TYP8B4UIic8Uvg17r0ZyjVtEi/2+09l5uOpFOqgoqjvlD2XKISW
         gOM9EYcneCW0/a9AAAZ33cfRefmnkRN/dtBfb4mMLGWrHeUARCBpWqDajaJE5XjLztxy
         BPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o3znglSYE3qWmbHWfVx7bUQXAqGJQvSQXgl1NOhCAVQ=;
        b=JxsTqu6sY2TXkPkvs/bBWzm+VrUVF3CkHG17aMNPKHwzW5/Agc0vqQe7w56cFQO+1P
         AzhZB27xFz3ENGSW/ymXfn0gFASXC/oW/wSLInUbN56+8xhADcXa48q22dhvwsCw/rd6
         5ix+7mQGhRkqAIkkNYNhl6VWrvARGvAQ6+1DZJtxtI7cwlGtwfmXUVwR41AUl1ZReve3
         GbmouYbpiQ7WrD5yFgqJ0OTDFHpImsJAkx+zW9COjIUMPNPQnVx0jnYaTtPO8+P3kiBU
         LeU/DKGyv0QzoOS7jelcnKh6pKictG0UsDRoG7u4z6G1heoHNxbqDuzGeBcKGmSRM2xV
         4OBA==
X-Gm-Message-State: APjAAAU2wH5y/0JhEkIPmhZIgTQ4iep0zj+ae2DErKem6DMB3rolrYV2
        FPE/JJsL3gom6PyxGRlb+vfwzg==
X-Google-Smtp-Source: APXvYqytFb6Lr6UvVt6vABF1Ha5/L0gUrj561kuxWy2jGkrPlViqSGlF3tlPtcq9umuF69+5oH3ZEQ==
X-Received: by 2002:a1c:7518:: with SMTP id o24mr2624307wmc.42.1558109461904;
        Fri, 17 May 2019 09:11:01 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id z8sm10116243wrh.48.2019.05.17.09.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 09:11:01 -0700 (PDT)
Subject: Re: [PATCHv1 7/8] arm64: dts: qcom: msm8998: Add PSCI cpuidle low
 power states
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>, devicetree@vger.kernel.org
References: <cover.1557486950.git.amit.kucheria@linaro.org>
 <0afe77d25490b10250f9eac4b4e92ccac8c42718.1557486950.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6b60656e-7786-1560-05f9-e2cbd6d1d18d@linaro.org>
Date:   Fri, 17 May 2019 18:11:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0afe77d25490b10250f9eac4b4e92ccac8c42718.1557486950.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2019 13:29, Amit Kucheria wrote:
> Add device bindings for cpuidle states for cpu devices.
> 
> Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 32 +++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index 3fd0769fe648..208281f318e2 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -78,6 +78,7 @@
>  			compatible = "arm,armv8";
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&LITTLE_CPU_PD>;
>  			efficiency = <1024>;
>  			next-level-cache = <&L2_0>;
>  			L2_0: l2-cache {
> @@ -97,6 +98,7 @@
>  			compatible = "arm,armv8";
>  			reg = <0x0 0x1>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&LITTLE_CPU_PD>;
>  			efficiency = <1024>;
>  			next-level-cache = <&L2_0>;
>  			L1_I_1: l1-icache {
> @@ -112,6 +114,7 @@
>  			compatible = "arm,armv8";
>  			reg = <0x0 0x2>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&LITTLE_CPU_PD>;
>  			efficiency = <1024>;
>  			next-level-cache = <&L2_0>;
>  			L1_I_2: l1-icache {
> @@ -127,6 +130,7 @@
>  			compatible = "arm,armv8";
>  			reg = <0x0 0x3>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&LITTLE_CPU_PD>;
>  			efficiency = <1024>;
>  			next-level-cache = <&L2_0>;
>  			L1_I_3: l1-icache {
> @@ -142,6 +146,7 @@
>  			compatible = "arm,armv8";
>  			reg = <0x0 0x100>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&BIG_CPU_PD>;
>  			efficiency = <1536>;
>  			next-level-cache = <&L2_1>;
>  			L2_1: l2-cache {
> @@ -161,6 +166,7 @@
>  			compatible = "arm,armv8";
>  			reg = <0x0 0x101>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&BIG_CPU_PD>;
>  			efficiency = <1536>;
>  			next-level-cache = <&L2_1>;
>  			L1_I_101: l1-icache {
> @@ -176,6 +182,7 @@
>  			compatible = "arm,armv8";
>  			reg = <0x0 0x102>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&BIG_CPU_PD>;
>  			efficiency = <1536>;
>  			next-level-cache = <&L2_1>;
>  			L1_I_102: l1-icache {
> @@ -191,6 +198,7 @@
>  			compatible = "arm,armv8";
>  			reg = <0x0 0x103>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&BIG_CPU_PD>;
>  			efficiency = <1536>;
>  			next-level-cache = <&L2_1>;
>  			L1_I_103: l1-icache {
> @@ -238,6 +246,30 @@
>  				};
>  			};
>  		};
> +
> +		idle-states {
> +			entry-method="psci";
> +
> +			LITTLE_CPU_PD: little-power-down {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "little-power-down";
> +				arm,psci-suspend-param = <0x00000002>;
> +				entry-latency-us = <43>;
> +				exit-latency-us = <43>;
> +				min-residency-us = <200>;
> +				local-timer-stop;
> +			};
> +
> +			BIG_CPU_PD: big-power-down {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "big-power-down";
> +				arm,psci-suspend-param = <0x00000002>;
> +				entry-latency-us = <41>;
> +				exit-latency-us = <41>;
> +				min-residency-us = <200>;
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

