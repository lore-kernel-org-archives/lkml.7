Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B53C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76384205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gk4iFbUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfENQMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 12:12:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32931 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfENQMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 12:12:25 -0400
Received: by mail-lj1-f195.google.com with SMTP id w1so12299642ljw.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 09:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zyRJ5gEio6kbCHrd2BA8IdC/+WTDJiovhhtKZ2lJSnw=;
        b=Gk4iFbUX8kvAlxK1PKJXDIWnU6qCakwFCRl+X856LaSt/xqUXN7LA3XL2zW1j6hC/z
         UGCVZhRZqEMhaR2P0lOkepfSXfhU9jjYcHKOjOnZ0edOOPGVUq1XiFE4q8dV+fQXQE0m
         dLgc6T+Bg5FYwIBWeyv5WDEaQLPFV8Ad54vBj5EtVSjkag/7ez494y/0GzqczflF/zJG
         eJQbpHEB3URmB/rtpi/HTbZy89qs+Lp+BFuv9X83FHS6rK9wDvpG21IClKXP3ZJrdk6n
         NUvLpADI0gU/kdgs88hyKfCamNQ7pbJkfqfv6sEeuZM44c+Iah86tD31gzCU4UU6JrlP
         fgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zyRJ5gEio6kbCHrd2BA8IdC/+WTDJiovhhtKZ2lJSnw=;
        b=IHXT+KwUCqoEyWQR30iAwYtT3FITau0R1CMAKrj6xZMggwkJm3nlqjFon5XjcOC9Hi
         Y0zf0HMXec6CpuYyyObT++i8GYhmDPCg20L6720P4cA6d1Tm9M+I0uA7C14Wp/QJgCVW
         dc10H0loC1k2xxeK3lbUOgRVGeFPtXX/6S/hazDVbb9lY5HmMMtPOJ189Al1sgzI7fBU
         3gn3M1ELncy6azF53X2tR0h2Bo+mjRMBLT0S4wDwrBWP7CW+i7zfpICcdSlQu3Ppjgf8
         VeYbLEjQ+F2FZPmmhMZZnDkLV5gTASGnYsVX7+ieSAHi/LuJUDH+Fh+lFlRGg/8iXiPD
         D96A==
X-Gm-Message-State: APjAAAW8oTitqZq3hd29WQlpBntTGrP5QuJ0xySLHuCGjAkwESSMc5JO
        Hx0cViHgOD8GHaeg7+CXAU4PzQ==
X-Google-Smtp-Source: APXvYqzj0Xj3smd+d+AMXxhca5kGPrvpYbF7I3V3m6atuwS7rhuynOR5U/5W1SKadHE1DCmQmjyXvw==
X-Received: by 2002:a2e:9a4f:: with SMTP id k15mr12916028ljj.159.1557850342944;
        Tue, 14 May 2019 09:12:22 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id x184sm2010356lfa.27.2019.05.14.09.12.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 09:12:22 -0700 (PDT)
Date:   Tue, 14 May 2019 18:12:20 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCHv1 4/8] arm64: dts: qcom: msm8916: Use more generic idle
 state names
Message-ID: <20190514161220.GC1824@centauri.ideon.se>
References: <cover.1557486950.git.amit.kucheria@linaro.org>
 <2a0626da4d8d5a1018c351b24b63e5e0d7a45a10.1557486950.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a0626da4d8d5a1018c351b24b63e5e0d7a45a10.1557486950.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 04:59:42PM +0530, Amit Kucheria wrote:
> Instead of using Qualcomm-specific terminology, use generic node names
> for the idle states that are easier to understand. Move the description
> into the "idle-state-name" property.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index ded1052e5693..400b609bb3fd 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -110,7 +110,7 @@
>  			reg = <0x0>;
>  			next-level-cache = <&L2_0>;
>  			enable-method = "psci";
> -			cpu-idle-states = <&CPU_SPC>;
> +			cpu-idle-states = <&CPU_SLEEP_0>;
>  			clocks = <&apcs>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			#cooling-cells = <2>;
> @@ -122,7 +122,7 @@
>  			reg = <0x1>;
>  			next-level-cache = <&L2_0>;
>  			enable-method = "psci";
> -			cpu-idle-states = <&CPU_SPC>;
> +			cpu-idle-states = <&CPU_SLEEP_0>;
>  			clocks = <&apcs>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			#cooling-cells = <2>;
> @@ -134,7 +134,7 @@
>  			reg = <0x2>;
>  			next-level-cache = <&L2_0>;
>  			enable-method = "psci";
> -			cpu-idle-states = <&CPU_SPC>;
> +			cpu-idle-states = <&CPU_SLEEP_0>;
>  			clocks = <&apcs>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			#cooling-cells = <2>;
> @@ -146,7 +146,7 @@
>  			reg = <0x3>;
>  			next-level-cache = <&L2_0>;
>  			enable-method = "psci";
> -			cpu-idle-states = <&CPU_SPC>;
> +			cpu-idle-states = <&CPU_SLEEP_0>;
>  			clocks = <&apcs>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			#cooling-cells = <2>;
> @@ -160,8 +160,9 @@
>  		idle-states {
>  			entry-method="psci";

Please add a space before and after "=".

>  
> -			CPU_SPC: spc {
> +			CPU_SLEEP_0: cpu-sleep-0 {

While I like your idea of using power state names from
Server Base System Architecture document (SBSA) where applicable,
does each qcom power state have a matching state in SBSA?

These are the qcom power states:
https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/Documentation/devicetree/bindings/arm/msm/lpm-levels.txt?h=msm-4.4#n53

Note that qcom defines:
"wfi", "retention", "gdhs", "pc", "fpc"
while SBSA simply defines "idle_standby" (aka wfi), "idle_retention", "sleep".

Unless you know the equivalent name for each qcom power state
(perhaps several qcom power states are really the same SBSA state?),
I think that you should omit the renaming from this patch series.

>  				compatible = "arm,idle-state";
> +				idle-state-name = "standalone-power-collapse";
>  				arm,psci-suspend-param = <0x40000002>;
>  				entry-latency-us = <130>;
>  				exit-latency-us = <150>;
> -- 
> 2.17.1
> 
