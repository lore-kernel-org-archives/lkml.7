Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32105C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FBD2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eqtMLehk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbfEQPzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 11:55:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38904 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728820AbfEQPzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 11:55:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id t5so5885588wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9n65JKv2XtPRLEdFty+JHya3Hjv0VqsllvETqv34x3s=;
        b=eqtMLehkSuVpZWU8YmbIdTgq3l1bQgg7oenIJACGfzp0n0gA5cHySNoLpfqW61V6FE
         yg2edrtMPTNl6grlRjM5KMn21ohd4hQe/V20GWefTBh4O/PMQ27z9LcQhn2TRsUtw5Uc
         vC9v22wkaQ+lQKYMwV6o6PaHmDcT4bu0pRDAtjqirQPLYYZ6/hCKGwLzRD6edyJKLbd3
         npy+XyhvE/qrQ8Mq1+XDZeGRUAV8kYZnqNRJwBOXCAWAuykziVlRlesQ8myaci4ZtXU/
         VuChTSL1DYUSbpb+YjgdVEf3CdmFiesBd4yQh0pXUMIxlyYyMALfLwGCpkS8yHEq7plt
         YO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9n65JKv2XtPRLEdFty+JHya3Hjv0VqsllvETqv34x3s=;
        b=kKsMyWaKF5lWXjP7qdtqKS0qBgGfRx+eOrxjIRwKFKFnQp/MGiXIvDeA7CaMXwsNWA
         4lLP9K6kDwOnJhsrqO7z4mWVFNZywZiU7AlREhjiXrDk7pd+196092d8bebN1Z0WFiBA
         /S8HGF2mg5/WSmphBy7rV6PoXZ1YIgw3OddHZxM5zGeGiHUCxFZGiRUmnSW51SbxqpzT
         5tptNLyvvv5Beemxc+dIIfNk6V6QSK2UyZVRQj07YvcAEcLE2vnUsmmjU+NfxxVVgkGO
         cdroz07CuYEWp3lXFGIl3hfuG+uaSlZ5T4Ca4Duof/K7p/dRxs+YF+YURA8GNys+3/1D
         ucIQ==
X-Gm-Message-State: APjAAAWXSZEHjKwguYQZelGBOhlgqLXnRMKuoO9FoZOrsyKVjT+Pu7AV
        Ev0ibHTYM3pun4Iq06BI/7czmg==
X-Google-Smtp-Source: APXvYqxyD1MoKJab3x0ukgsHx31lbCyhH+uK861VI4R8nx43jO0xg/nPl2AK0Cj1rIQtnP3UUpZLng==
X-Received: by 2002:a1c:9eca:: with SMTP id h193mr23434703wme.125.1558108522628;
        Fri, 17 May 2019 08:55:22 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id z7sm7544362wme.26.2019.05.17.08.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 08:55:21 -0700 (PDT)
Subject: Re: [PATCHv1 6/8] arm64: dts: qcom: msm8996: Add PSCI cpuidle low
 power states
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org
References: <cover.1557486950.git.amit.kucheria@linaro.org>
 <8648ba97d49a9f731001e4b36611be9650e37f37.1557486950.git.amit.kucheria@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b488bd2a-5544-4f7e-3f5f-8ce1b686ce87@linaro.org>
Date:   Fri, 17 May 2019 17:55:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8648ba97d49a9f731001e4b36611be9650e37f37.1557486950.git.amit.kucheria@linaro.org>
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
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 28 +++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index c761269caf80..b615bcb9e351 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -95,6 +95,7 @@
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&LITTLE_CPU_PD>;

It is the same micro architecture, the CPUS differ by their max OPP.
Shall we call it really little?

I take the opportunity to report the capacity-dmips-mhz attribute is
missing. The max capacity computation is not triggered, thus the
scheduler see the same capacity for both cluster even if one has less
OPP. Adding capacity-dmips-mhz = <1024>; to all CPUs will fix it.

>  			next-level-cache = <&L2_0>;
>  			L2_0: l2-cache {
>  			      compatible = "cache";
> @@ -107,6 +108,7 @@
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x1>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&LITTLE_CPU_PD>;
>  			next-level-cache = <&L2_0>;
>  		};
>  
> @@ -115,6 +117,7 @@
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x100>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&BIG_CPU_PD>;
>  			next-level-cache = <&L2_1>;
>  			L2_1: l2-cache {
>  			      compatible = "cache";
> @@ -127,6 +130,7 @@
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x101>;
>  			enable-method = "psci";
> +			cpu-idle-states = <&BIG_CPU_PD>;
>  			next-level-cache = <&L2_1>;
>  		};
>  
> @@ -151,6 +155,30 @@
>  				};
>  			};
>  		};
> +
> +		idle-states {
> +			entry-method="psci";
> +
> +			LITTLE_CPU_PD: little-power-down {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "standalone-power-collapse";
> +				arm,psci-suspend-param = <0x00000004>;
> +				entry-latency-us = <40>;
> +				exit-latency-us = <40>;
> +				min-residency-us = <300>;
> +				local-timer-stop;
> +			};
> +
> +			BIG_CPU_PD: big-power-down {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "standalone-power-collapse";
> +				arm,psci-suspend-param = <0x00000004>;
> +				entry-latency-us = <40>;
> +				exit-latency-us = <40>;
> +				min-residency-us = <300>;
> +				local-timer-stop;
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

