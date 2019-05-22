Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532D8C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 03:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B15E205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 03:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tyAAgLvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbfEVDt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 23:49:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36880 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbfEVDt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 23:49:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id n27so589242pgm.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 20:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+5eKx9BGX2PYwAXvbYXkSUqFGc5sUv/YklAZr9+T8Rw=;
        b=tyAAgLvcoMiC8oNgVgpM66a4C26bapaZwCW6m/CC9aSsfe4zW++d7aOCFhCIN54Dnh
         I+hMnY3fIrQ3sRFlT2agmUpne7Rv661Yvq9rtEeq9VKo8UTLmE4KIN6u8MurOOks1vC/
         Z4+/s5hEBnJ6rW9sU+07pUR9VT003WSUPsTzUoNchPwDezACujn/OA5T+Mi5tHHCtAka
         x0NLru9+XHhdP52IW1UXh1MWWGvtjlBNCMwYqDXWAPRpBKWU0WaRwsZBaoT3nM2hSu2J
         kfEGFjxmCkoWR4TgrH90NqT4s5HDSugQJly+yGhL38JtruG1Pd3yEHRnpJy/IkRYFJer
         iXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+5eKx9BGX2PYwAXvbYXkSUqFGc5sUv/YklAZr9+T8Rw=;
        b=Jvi2peKCXP4IVFy5JrJongsHPScIJW8QujHVG0e4mijYT5LxsVA4VP/8MjOJKLFZ4a
         njBckiSyUQ7SbclN57FAWOPRFrAsdSJbVp/rpRD0OAWHm03I4Pw0SAK8MdzQqg94YZC2
         95gHTS3/W3wOgrakFD+wssgSBHr6y9JvCsr/d+AcietJ1cGW8q+AYvf9V6c5WTiAGTo/
         eD1lF8I3wJMGSt90VF1l6fAVGQIXtWW8pj/VRCywNAMlWD9l9wTt/8LVDaJYHFge6uVc
         eRb1gbPcTtRTskk/UHA4RICbcxVjbNydaA3YNj0iygGUbA3KLWVL+U9e88Mb433G2ets
         qSEA==
X-Gm-Message-State: APjAAAXZ65GDlltoB7RJOO9y6hCpcVHqksetmQszJcyfMvcUg4WM7POu
        BfwdUShES/cRGYZ/Mc3Y/W3Txw==
X-Google-Smtp-Source: APXvYqwH1v6QMBg6bMZX3t/Uug93jmA0iAlZDfsxwAZi5uPB1WowK6+qHbiHvMlfQD+/VVInvtKQVA==
X-Received: by 2002:a63:b706:: with SMTP id t6mr81714275pgf.305.1558496996388;
        Tue, 21 May 2019 20:49:56 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 132sm23660233pga.79.2019.05.21.20.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 20:49:55 -0700 (PDT)
Date:   Tue, 21 May 2019 20:49:53 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, niklas.cassel@linaro.org,
        marc.w.gonzalez@free.fr, sibis@codeaurora.org,
        daniel.lezcano@linaro.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 6/9] arm64: dts: qcom: msm8996: Add PSCI cpuidle low
 power states
Message-ID: <20190522034953.GM3137@builder>
References: <cover.1558430617.git.amit.kucheria@linaro.org>
 <2ffbb3f32484c03360ff7d6fa4668581ef298c9e.1558430617.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ffbb3f32484c03360ff7d6fa4668581ef298c9e.1558430617.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21 May 02:35 PDT 2019, Amit Kucheria wrote:

> Add device bindings for cpuidle states for cpu devices.
> 
> msm8996 features 4 cpus - 2 in each cluster. However, all cpus implement
> the same microarchitecture and the two clusters only differ in the
> maximum frequency attainable by the CPUs.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Applied

Regards,
Bjorn

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
> -- 
> 2.17.1
> 
