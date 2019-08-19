Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A53C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB50E20989
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566213444;
	bh=SBx9yLs7l7QkTChHV7UVCy8UM+MrlbLRIJn2z15OfDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0zga0TQnffWz4rMq8mtfBUeyU0Ro1KK+FbIaYEu5fxtYDVpOtSqoOUs9WSRla9BSa
	 nAZ7SXu7mRsPklB2Mao4A6Gykxa5eGwfyhNqr8JdWpmPVUuas+yuGDF1Vd+8Dz8AUs
	 sMOB1ziRMeBGUO/QtI8WeOVhg0u56qvk1v9EtaAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfHSLRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:17:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:32828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfHSLRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:17:23 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7669A2086C;
        Mon, 19 Aug 2019 11:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566213441;
        bh=SBx9yLs7l7QkTChHV7UVCy8UM+MrlbLRIJn2z15OfDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nvK/FQ2iXY/JDm0pIrjZFcxpZ/5Ywrn8G3rCKnH9pItCtPhu7x5KaNQZPPfN78WNp
         kGo3pDamxs/iuZmVVggukIKtRPhZMg+WoK+lqft8ohEvxYp0bc1VPbXeThX7GLJjcW
         fR0R7Bzkj+hUa5CZ0qceHa/iLb2woHraePmuuOX4=
Date:   Mon, 19 Aug 2019 13:17:08 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4 06/21] ARM: dts: imx7-colibri: add GPIO wakeup key
Message-ID: <20190819111707.GP5999@X250>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
 <20190812142105.1995-7-philippe.schenker@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812142105.1995-7-philippe.schenker@toradex.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 02:21:23PM +0000, Philippe Schenker wrote:
> From: Stefan Agner <stefan.agner@toradex.com>
> 
> Add wakeup GPIO key which is able to wake the system from sleep
> modes (e.g. Suspend-to-Memory).
> 
> Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v4:
> - Add Marcel Ziswiler's Ack
> 
> Changes in v3: None
> Changes in v2: None
> 
>  arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 14 ++++++++++++++
>  arch/arm/boot/dts/imx7-colibri.dtsi         |  7 ++++++-
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> index 3f2746169181..d4dbc4fc1adf 100644
> --- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> +++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> @@ -52,6 +52,20 @@
>  		clock-frequency = <16000000>;
>  	};
>  
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpiokeys>;
> +
> +		power {
> +			label = "Wake-Up";
> +			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
> +			linux,code = <KEY_WAKEUP>;
> +			debounce-interval = <10>;
> +			gpio-key,wakeup;

Please check Documentation/devicetree/bindings/power/wakeup-source.txt

Shawn

> +		};
> +	};
> +
>  	panel: panel {
>  		compatible = "edt,et057090dhu";
>  		backlight = <&bl>;
> diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
> index cab40d22d24e..5347ed38acb2 100644
> --- a/arch/arm/boot/dts/imx7-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx7-colibri.dtsi
> @@ -741,12 +741,17 @@
>  
>  	pinctrl_gpio_lpsr: gpio1-grp {
>  		fsl,pins = <
> -			MX7D_PAD_LPSR_GPIO1_IO01__GPIO1_IO1	0x59
>  			MX7D_PAD_LPSR_GPIO1_IO02__GPIO1_IO2	0x59
>  			MX7D_PAD_LPSR_GPIO1_IO03__GPIO1_IO3	0x59
>  		>;
>  	};
>  
> +	pinctrl_gpiokeys: gpiokeysgrp {
> +		fsl,pins = <
> +			MX7D_PAD_LPSR_GPIO1_IO01__GPIO1_IO1	0x19
> +		>;
> +	};
> +
>  	pinctrl_i2c1: i2c1-grp {
>  		fsl,pins = <
>  			MX7D_PAD_LPSR_GPIO1_IO05__I2C1_SDA	0x4000007f
> -- 
> 2.22.0
> 
