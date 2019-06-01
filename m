Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B48C28CC3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 09:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB45271C1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 09:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ftzq3jR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfFAJvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 05:51:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37399 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfFAJvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 05:51:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id 20so5437661pgr.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 02:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RNxGbxuQjJnKHmflH8io0Yh7K3STajOAFY5UlUeImlE=;
        b=ftzq3jR2++4o8NJW8hDTNe4IEPPtpBxc6+CvixxSQYqrrMYyMK0FzKvHhVlVMpyjLp
         tsuJMJbjfLULDaK8sjJNLkWrG9vMaaoGRnWlq0I6CSgjjB8uz8CX938f5shEc+LbxgsV
         aI3kxJoTtsRnwz5Q1H9OZv8R6MOdfFvNsQ5gewgkPYS1+z7b/vNHrpeLVukE/dRo6gMn
         54ps7O57q9L+8NcpZxWwMTIDedNIrIEmZ2qwSNkT8qyXqDxN3Z3dHi46EyyQC570ti1y
         SOt7Ls7zsxDaxnTuxtrW4XT7TWqp284BP8+qP/5qZDEAqOV3Wav7gzaRZSro76A9VIWZ
         V5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RNxGbxuQjJnKHmflH8io0Yh7K3STajOAFY5UlUeImlE=;
        b=GmzvIK7iRkX0ytBZmG2B9pY9kMO0JI7fYsZBPTSHDR5dFHHFmDb8kX95X4CpMDc5Er
         tZPs5t9reKnQsiuNvqGvnMjAfF0Th2iXC6nmD9+BvxgkF7XUPTWt2+ZK5M5svgam8Zl9
         iQZ2eV60pDeihM8ZpBz6cVwU46hkw6wo753f141aZyowvZohzRu7xM3o6VuO4uAMBorF
         5PeV0lXh09ifPDXwLK2chOAF9iEvggGzqVjOiMHYe7rfOBT5lPORoVxOuIFf1e9QVmQP
         CuQHhVRCkKgur33ZNn8hkEfTIN09qItiW+Rda0h4rD8F9kw1FDz9zNZ/ynN5QrLUQ4Nu
         AgIA==
X-Gm-Message-State: APjAAAW7hDURS+bToDdjGrKmrUtD31Uoqmy/hrqJrnC4JoQF8453t+rM
        BS6l0upMnQHzM5kwm14erHDr
X-Google-Smtp-Source: APXvYqx465ZqZSGI5f9aNCQ1QW6+B2C0NyP5YwUfaCtwz4wNoXssIWR/WyKtFDiUgKvIIdWIaw3JMw==
X-Received: by 2002:a62:1993:: with SMTP id 141mr15320990pfz.97.1559382677973;
        Sat, 01 Jun 2019 02:51:17 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:73c0:f79b:51a5:964b:dc02:28ec])
        by smtp.gmail.com with ESMTPSA id u14sm9611863pfc.31.2019.06.01.02.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Jun 2019 02:51:16 -0700 (PDT)
Date:   Sat, 1 Jun 2019 15:21:06 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add missing configuration pwr
 amd rst for PCIe
Message-ID: <20190601095106.GA2213@Mani-XPS-13-9360>
References: <20190531201913.1122-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531201913.1122-1-linux.amoon@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 31, 2019 at 08:19:13PM +0000, Anand Moon wrote:
> This patch add missing PCIe gpio pin (#PCIE_PWR) for vcc3v3_pcie power
> regulator node also add missing reset pinctrl (#PCIE_PERST_L) for PCIe node.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> using schematics: thanks for suggested by Manivannan
> [1] https://dl.vamrs.com/products/rock960/docs/hw/rock960_sch_v12_20180314.pdf
> 
> Changes from prevoius patch:
> [2] https://patchwork.kernel.org/patch/10968695/
> 
> Fix the suject and commit message and corrected the PWR and PERST configuration
> as per shematics and dts nodes.
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-ficus.dts    | 7 +++++++
>  arch/arm64/boot/dts/rockchip/rk3399-rock960.dts  | 7 +++++++
>  arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi | 3 +--
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> index 6b059bd7a04f..94e2a59bc1c7 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> @@ -89,6 +89,8 @@
>  
>  &pcie0 {
>  	ep-gpios = <&gpio4 RK_PD4 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie_clkreqn_cpm &pcie_perst_l>;

Looks like ep-gpio is wrong here :/ I probably referred old schematics
at that time. Correct pin mapping is,

ep-gpios = <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;

And this should be fixed in a separate patch with "Fixes" tag!

>  };
>  
>  &pinctrl {
> @@ -104,6 +106,11 @@
>  			rockchip,pins =
>  				<1 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
>  			};
> +
> +		pcie_perst_l: pcie-perst-l {
> +			rockchip,pins =
> +				<4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
>  	};
>  
>  	usb2 {
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> index 12285c51cceb..665fe09c7c74 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> @@ -64,6 +64,8 @@
>  
>  &pcie0 {
>  	ep-gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie_clkreqn_cpm &pcie_perst_l>;
>  };
>  
>  &pinctrl {
> @@ -104,6 +106,11 @@
>  			rockchip,pins =
>  				<2 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
>  			};
> +
> +		pcie_perst_l: pcie-perst-l {
> +			rockchip,pins =
> +				<2 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
>  	};
>  
>  	usb2 {
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> index c7d48d41e184..3df0cd67b4b2 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> @@ -55,6 +55,7 @@
>  
>  	vcc3v3_pcie: vcc3v3-pcie-regulator {
>  		compatible = "regulator-fixed";
> +		gpio = <&gpio2 RK_PA5 GPIO_ACTIVE_HIGH>;

Actually the PWR pin mapping is defined in a separate node for both Rock960
and Ficus in respective dts. So defining it here would be wrong as the PWR
pin mapping is different for both boards.

Thanks,
Mani

>  		enable-active-high;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pcie_drv>;
> @@ -382,8 +383,6 @@
>  
>  &pcie0 {
>  	num-lanes = <4>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie_clkreqn_cpm>;
>  	vpcie3v3-supply = <&vcc3v3_pcie>;
>  	status = "okay";
>  };
> -- 
> 2.21.0
> 
