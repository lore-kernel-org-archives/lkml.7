Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB726C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF71C21773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dkbaEWk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfEUKNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:13:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43668 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfEUKNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:13:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so17873971wro.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 03:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ExhtHOYixmQ3q1DaWe84tRAbBCksXA4j7ETOHrXNd7Q=;
        b=dkbaEWk2jBQbR2GXBgbKgYnKBf4wzflpQsQOwwuKmqRzR1jvkdKuv2V+0nBXcugw+R
         qXUJerGUfUdd5U6RpUHhd80mWpaIQNZtNG1EF94VpiH3RouLOtgwk8FPGjevHWQqUQiv
         P1GLowr79+uCtGnhfosMrt0RDOEKIqxydGMHIgVZiqu3UcNua3uuzzC9wDELw02RQDA/
         kRU9OCqDZixLi1R/iqMkpbCGpUC1rkuG03reORC/GqPQEV2zw0q7dxAn5/XbXuK9OEUt
         M0VlbIi4UDk2nGgfaxvIvYgYtPcxWyFJuQpV265MkTnTC0mYWol6BAAWZyDXqcS2ptae
         5VJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ExhtHOYixmQ3q1DaWe84tRAbBCksXA4j7ETOHrXNd7Q=;
        b=BLb1ZjCYbNUzpIa3TxZUh0ueiB/1/FR/GYo8iwOEbqHNxo9BrGFYyXroLQVMuaTepA
         ApiqObs975GOm/V+74xbIVKNNeVwy6bpfGvqROuMZPDPowfKuG52zxL+ct9s0wv0UKSc
         vlXpwkjO9KRjWPptyswpPMsLe3pDXMSbzBvliK3LVk+139GZKqb8JaXDmEEXXnV7vhOo
         0lgzcMF44O3fXbVUH7Mj3uviQ0pWj7/lPv9vIHF1CHyoDY5Ml1VPvQqN6SJWQIU+ktvY
         iqm5t7vDFbSMzHwJINuspyvhMhKcomhdfXlzTlTTleQoJS2YmcylLL+qrG+cmh8nfl1X
         T1fw==
X-Gm-Message-State: APjAAAX62IFezz7wg7WLzjBZwc/wPJhHs5+BarrCFWt9BDin74trSun2
        TpJd/awdTewxacArjPs2/5iuEQ==
X-Google-Smtp-Source: APXvYqx6nGhjKpD8X1e8RNKlkcPEHA0wu1fWgProf887xpQF5o3CDXBEqtzPwSaBYOyhclFuYvUG+w==
X-Received: by 2002:adf:cf0e:: with SMTP id o14mr13521746wrj.230.1558433620515;
        Tue, 21 May 2019 03:13:40 -0700 (PDT)
Received: from [10.1.203.87] (nat-wifi.sssup.it. [193.205.81.22])
        by smtp.googlemail.com with ESMTPSA id y8sm2751112wmi.8.2019.05.21.03.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 03:13:39 -0700 (PDT)
Subject: Re: [PATCH v2 6/9] arm64: dts: qcom: msm8996: Add PSCI cpuidle low
 power states
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        niklas.cassel@linaro.org, marc.w.gonzalez@free.fr,
        sibis@codeaurora.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org
References: <cover.1558430617.git.amit.kucheria@linaro.org>
 <2ffbb3f32484c03360ff7d6fa4668581ef298c9e.1558430617.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <10d95552-0a0c-3e8a-62c3-80a307fed0c9@linaro.org>
Date:   Tue, 21 May 2019 12:13:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2ffbb3f32484c03360ff7d6fa4668581ef298c9e.1558430617.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2019 11:35, Amit Kucheria wrote:
> Add device bindings for cpuidle states for cpu devices.
> 
> msm8996 features 4 cpus - 2 in each cluster. However, all cpus implement
> the same microarchitecture and the two clusters only differ in the
> maximum frequency attainable by the CPUs.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index c761269caf80..4f2fb7885f39 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -95,6 +95,7 @@
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&CPU_SLEEP_0>;
>  			next-level-cache = <&L2_0>;
>  			L2_0: l2-cache {
>  			      compatible = "cache";
> @@ -107,6 +108,7 @@
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x1>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&CPU_SLEEP_0>;
>  			next-level-cache = <&L2_0>;
>  		};
>  
> @@ -115,6 +117,7 @@
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x100>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&CPU_SLEEP_0>;
>  			next-level-cache = <&L2_1>;
>  			L2_1: l2-cache {
>  			      compatible = "cache";
> @@ -127,6 +130,7 @@
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x101>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&CPU_SLEEP_0>;
>  			next-level-cache = <&L2_1>;
>  		};
>  
> @@ -151,6 +155,19 @@
>  				};
>  			};
>  		};
> +
> +		idle-states {
> +			entry-method = "psci";
> +
> +			CPU_SLEEP_0: cpu-sleep-0 {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "standalone-power-collapse";
> +				arm,psci-suspend-param = <0x00000004>;
> +				entry-latency-us = <40>;
> +				exit-latency-us = <80>;
> +				min-residency-us = <300>;
> +			};
> +		};
>  	};
>  
>  	thermal-zones {
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

