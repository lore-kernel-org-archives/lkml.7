Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972A5C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55AAD218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4niRzcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfLRVgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:36:09 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37173 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfLRVgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:36:09 -0500
Received: by mail-lf1-f65.google.com with SMTP id b15so2785887lfc.4;
        Wed, 18 Dec 2019 13:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XY/7ctgYqZHwIIQO9jA6KQXddiVZazVvunpxdtUNGKM=;
        b=Q4niRzcKMgphtzMiwa0Ky9j7KNeQUnUPJ9bYBHzaQw7kBpXyT7bUpUhXtOXu2rYfu5
         dd8h//y/Duyscxj5I2aUcKAMhSwe/OkCzARvgWy7jA+WsAEeneeUX9kZ1+zp1poqyxTr
         51LxJsSjUk20/DRpaXZVTPLqhQ6jUqWVs20ZuFyOhc7g5US8LjFKdE4+gi+O3Bknkpt8
         znm2zALfsf3VyCFov5ymb1U61ZBuwSvnEXHyJ8yWOKeR+Sf/XYXS5PNzn7kLAsPnsWYR
         vZd2pO6IWswhTY8Q1kYG1FUfD8aDcmo14GKu/kn2aBvx9nyQwRLPq+CWtu9RRGOkNmwl
         dUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XY/7ctgYqZHwIIQO9jA6KQXddiVZazVvunpxdtUNGKM=;
        b=JL2qAuBWnnR5hlGk19OI1n6VmSfPb2QE9JAOJnT82gbfR7uqRs+fXH1jvmJEhrthNF
         kevyZfOC2p+S2cfv2lK2lYYfuJ/HP+j1Um0QF1bGQssO4uV2VmKwnNNBOBIjNtzSi4Uu
         rsurmJPMkcNflOuh/1R9FNtpT6ZCU/HGInxApNbvGo7O6Taj59sGF+MbWQ6nwu7H421t
         otfH5PKZD9XlCKtspgBPSHGkLfqoPTCshDajesGljERhARARc6kh74FlOQonZ12skanO
         expXvHiTsUITk6VKvA61C7sMQxblNznjyaWVpexvj7pFQNKG6U9+4Ans+3/W45/SU8Sq
         TS3w==
X-Gm-Message-State: APjAAAWLN4+sy1KxQQlTYBzZ00JI6xI9DmBnNcd3AoQ5Kl2XSKj/Agxg
        mRGX7yc/a7QeNVjCFnzuq9Zoy+dB
X-Google-Smtp-Source: APXvYqxVHiapyBPuT0aQJDIGI3ZG8ijrHGlItMeH0U3Oa8pT068RNF4hvmC1XXq8fxlMUWwZR6rRHQ==
X-Received: by 2002:a19:c697:: with SMTP id w145mr3061717lff.54.1576704965372;
        Wed, 18 Dec 2019 13:36:05 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id a11sm1746251ljp.50.2019.12.18.13.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 13:36:04 -0800 (PST)
Subject: Re: [PATCH v4 15/19] ARM: dts: tegra: Add clock-cells property to pmc
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1576613046-17159-1-git-send-email-skomatineni@nvidia.com>
 <1576613046-17159-16-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f9ccf209-e539-2ddc-cdcc-29cdb5749fae@gmail.com>
Date:   Thu, 19 Dec 2019 00:36:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1576613046-17159-16-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.12.2019 23:04, Sowjanya Komatineni пишет:
> Tegra PMC has clk_out_1, clk_out_2, clk_out_3, and blink clock.
> 
> These clocks are moved from clock driver to pmc driver with pmc
> as the clock provider for these clocks.
> 
> This patch adds #clock-cells property with 1 clock specifier to
> the Tegra PMC node in device tree.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra114.dtsi | 4 +++-
>  arch/arm/boot/dts/tegra124.dtsi | 4 +++-
>  arch/arm/boot/dts/tegra20.dtsi  | 4 +++-
>  arch/arm/boot/dts/tegra30.dtsi  | 4 +++-
>  4 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
> index 0d7a6327e404..b8f12f24f314 100644
> --- a/arch/arm/boot/dts/tegra114.dtsi
> +++ b/arch/arm/boot/dts/tegra114.dtsi
> @@ -4,6 +4,7 @@
>  #include <dt-bindings/memory/tegra114-mc.h>
>  #include <dt-bindings/pinctrl/pinctrl-tegra.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/soc/tegra-pmc.h>
>  
>  / {
>  	compatible = "nvidia,tegra114";
> @@ -514,11 +515,12 @@
>  		status = "disabled";
>  	};
>  
> -	pmc@7000e400 {
> +	pmc: pmc@7000e400 {
>  		compatible = "nvidia,tegra114-pmc";
>  		reg = <0x7000e400 0x400>;
>  		clocks = <&tegra_car TEGRA114_CLK_PCLK>, <&clk32k_in>;
>  		clock-names = "pclk", "clk32k_in";
> +		#clock-cells = <1>;
>  	};
>  
>  	fuse@7000f800 {
> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
> index 413bfb981de8..d0802c4ae3bf 100644
> --- a/arch/arm/boot/dts/tegra124.dtsi
> +++ b/arch/arm/boot/dts/tegra124.dtsi
> @@ -6,6 +6,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/reset/tegra124-car.h>
>  #include <dt-bindings/thermal/tegra124-soctherm.h>
> +#include <dt-bindings/soc/tegra-pmc.h>
>  
>  / {
>  	compatible = "nvidia,tegra124";
> @@ -595,11 +596,12 @@
>  		clocks = <&tegra_car TEGRA124_CLK_RTC>;
>  	};
>  
> -	pmc@7000e400 {
> +	pmc: pmc@7000e400 {
>  		compatible = "nvidia,tegra124-pmc";
>  		reg = <0x0 0x7000e400 0x0 0x400>;
>  		clocks = <&tegra_car TEGRA124_CLK_PCLK>, <&clk32k_in>;
>  		clock-names = "pclk", "clk32k_in";
> +		#clock-cells = <1>;
>  	};
>  
>  	fuse@7000f800 {
> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> index 9c58e7fcf5c0..85a64747bec6 100644
> --- a/arch/arm/boot/dts/tegra20.dtsi
> +++ b/arch/arm/boot/dts/tegra20.dtsi
> @@ -4,6 +4,7 @@
>  #include <dt-bindings/memory/tegra20-mc.h>
>  #include <dt-bindings/pinctrl/pinctrl-tegra.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/soc/tegra-pmc.h>
>  
>  / {
>  	compatible = "nvidia,tegra20";
> @@ -608,11 +609,12 @@
>  		status = "disabled";
>  	};
>  
> -	pmc@7000e400 {
> +	pmc: pmc@7000e400 {
>  		compatible = "nvidia,tegra20-pmc";
>  		reg = <0x7000e400 0x400>;
>  		clocks = <&tegra_car TEGRA20_CLK_PCLK>, <&clk32k_in>;
>  		clock-names = "pclk", "clk32k_in";
> +		#clock-cells = <1>;
>  	};
>  
>  	mc: memory-controller@7000f000 {
> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
> index 55ae050042ce..4d5e9d0001d3 100644
> --- a/arch/arm/boot/dts/tegra30.dtsi
> +++ b/arch/arm/boot/dts/tegra30.dtsi
> @@ -4,6 +4,7 @@
>  #include <dt-bindings/memory/tegra30-mc.h>
>  #include <dt-bindings/pinctrl/pinctrl-tegra.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/soc/tegra-pmc.h>
>  
>  / {
>  	compatible = "nvidia,tegra30";
> @@ -714,11 +715,12 @@
>  		status = "disabled";
>  	};
>  
> -	pmc@7000e400 {
> +	pmc: pmc@7000e400 {

I think will be a bit better to name the phandle as "tegra_pmc", it has
the same vibe as the "tegra_car".

>  		compatible = "nvidia,tegra30-pmc";
>  		reg = <0x7000e400 0x400>;
>  		clocks = <&tegra_car TEGRA30_CLK_PCLK>, <&clk32k_in>;
>  		clock-names = "pclk", "clk32k_in";
> +		#clock-cells = <1>;
>  	};
>  
>  	mc: memory-controller@7000f000 {
> 

