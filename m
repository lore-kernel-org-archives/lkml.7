Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EA6C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4986A20862
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nB3Y+Vlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388010AbfEWVYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 17:24:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35590 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387521AbfEWVYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 17:24:50 -0400
Received: by mail-lf1-f67.google.com with SMTP id c17so5472636lfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 14:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FzWr0jWUizq78fQjYjjq41koeiVNEvdn60rL1vMGWV8=;
        b=nB3Y+Vlwq85hV6ZNvfs2rVnxQSendJp43bsBt+2JYHIuuRCGenxT5SgaFLY5E7CMt1
         9cd6kziAiVcgNkwQ5opr7tBv1iplgg2PmD4IKiTklqrVV2JoB6H+kenz0UWY4fArez+m
         Z/T06tzdWHYwwCGI0nCpPDJ2zfKIMNVmwC0p6F/3ik6fZlWnZzOkf3bLwhIou1nTWkH6
         2Jl/5d0WyTqJidGqRbDu//1voBJ0UU5t7ySrO4Up5pjXQO6zpsZ5nUm9oZSE+Kjab/Ww
         UkRZIZwKDZRZHB9GAh2aaKRvpwAhV0jQeY6jZmsrOLXvvOU8Hhjsvv3V6RAlQpSWVgh8
         2ALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FzWr0jWUizq78fQjYjjq41koeiVNEvdn60rL1vMGWV8=;
        b=bY6FsBUhDnLJDrhH1s+cIkf2TUEDiM6z2gj3JgscbuZOOTq8j4/sz7NZFA186085Nx
         cL9M4br9OVvmIG4exVKWz+jhg9QbH6i+IRJe6BuZaPqVmnH4HCFepYuHQUk1WRfQav2/
         oARuKDmC4aQwGfY4KyR7zC1IUj9N/7RykuIjoWHTIVEZpFeTjd50Izu1xSzjyIaHfldi
         CsP0RY3aEVGYutlV3SxDsVYNs1JdAfE0xMHSeEwmp22uUz49Nuk0Rd49y+ZTXfAGnL15
         HjR0p35VFFKriXk0O//NDAmaegc5W2MgEkyGf5P2Gc0y6/j2Kp/YifUr7W2mE+9vcA/z
         k4GQ==
X-Gm-Message-State: APjAAAXpurpW+/gSA4IoWexcH3b5tEGjlohCTkZEpgcfOzq5vdEJ9uDa
        Di0pQFxgM8NLOBsEems0N/Khhw==
X-Google-Smtp-Source: APXvYqw0wQRztQNEXe5ECv9lUc6NSDiR+JDDfswtgJbKjbK3GH8kI/T2rb/i3Uq0p2tClCr/MsB2aA==
X-Received: by 2002:ac2:5468:: with SMTP id e8mr18855107lfn.167.1558646688642;
        Thu, 23 May 2019 14:24:48 -0700 (PDT)
Received: from centauri (m83-185-80-163.cust.tele2.se. [83.185.80.163])
        by smtp.gmail.com with ESMTPSA id i14sm136289ljj.57.2019.05.23.14.24.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 14:24:47 -0700 (PDT)
Date:   Thu, 23 May 2019 23:24:44 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        marc.w.gonzalez@free.fr, sibis@codeaurora.org,
        daniel.lezcano@linaro.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 6/9] arm64: dts: qcom: msm8996: Add PSCI cpuidle low
 power states
Message-ID: <20190523212444.GA25133@centauri>
References: <cover.1558430617.git.amit.kucheria@linaro.org>
 <2ffbb3f32484c03360ff7d6fa4668581ef298c9e.1558430617.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ffbb3f32484c03360ff7d6fa4668581ef298c9e.1558430617.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 03:05:16PM +0530, Amit Kucheria wrote:
> Add device bindings for cpuidle states for cpu devices.
> 
> msm8996 features 4 cpus - 2 in each cluster. However, all cpus implement
> the same microarchitecture and the two clusters only differ in the
> maximum frequency attainable by the CPUs.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
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

Hello Amit,

Looking at this line of code in msm-4.14:
https://source.codeaurora.org/quic/la/kernel/msm-4.14/tree/drivers/cpuidle/lpm-levels.c?h=LA.UM.7.1.r1-14000-sm8150.0#n993

And seeing the equivalent in msm-4.4:
https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/drivers/cpuidle/lpm-levels.c?h=msm-4.4#n1080

It becomes obvious that

qcom,time-overhead == entry-latency-us + exit-latency-us
and
qcom,latency-us == exit-latency-us

which means that

entry-latency-us == qcom,time-overhead - qcom,latency-us


Using this formula, with the numbers from downstream SDM845:
https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/arch/arm64/boot/dts/qcom/sdm845-pm.dtsi?h=msm-4.9#n123

qcom,latency-us = <621>;
qcom,time-overhead = <885>;

885 - 621 = 264

we end up with the same values that Raju
has in his submission for upstream SDM845:
https://patchwork.kernel.org/patch/10953253/

entry-latency-us = <264>;
exit-latency-us = <621>;



Which for msm8996:

qcom,latency-us = <80>;
qcom,time-overhead = <210>;

gives:

entry-latency-us = <130>
exit-latency-us = <80>;

> +				min-residency-us = <300>;
> +			};
> +		};
>  	};
>  
>  	thermal-zones {
> -- 
> 2.17.1
> 
