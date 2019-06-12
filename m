Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303EEC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065A721721
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="FjNDRYeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438769AbfFLMSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:18:02 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:54316 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438756AbfFLMSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:18:02 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 64E305C2176;
        Wed, 12 Jun 2019 14:17:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1560341879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/KH0/i4R3MFhchQ0T0snADnLYDTs7aFotX1/6SeWxhU=;
        b=FjNDRYeX/PtHXdcW9e8GNSv42F0BHqkcPhNorsrgHPuy03m/dRNJKTlY+psz48RUEnd+3f
        IEZBG5raooHHVy+i6B9P20h+EOukDGaEO2c79N5grBB3+iHhyu4IqX4DacTYiRX148NKjY
        LrYiKoroQEosDlrg9KqsL9bPJ/rFJa0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 12 Jun 2019 14:17:59 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Igor Opaniuk <igor.opaniuk@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        marcel@ziswiler.com, marcel.ziswiler@toradex.com
Subject: Re: [PATCH 1/1] ARM: dts: imx6ull-colibri: enable UHS-I for USDHC1
In-Reply-To: <20190606090612.16685-1-igor.opaniuk@gmail.com>
References: <20190606090612.16685-1-igor.opaniuk@gmail.com>
Message-ID: <3b84f3cc6cd5399f25ebd8e1c8559c58@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.06.2019 11:06, Igor Opaniuk wrote:
> From: Igor Opaniuk <igor.opaniuk@toradex.com>
> 
> Allows to use the SD interface at a higher speed mode if the card
> supports it. For this the signaling voltage is switched from 3.3V to
> 1.8V under the usdhc1's drivers control.
> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
> ---
>  arch/arm/boot/dts/imx6ul.dtsi                  |  4 ++++
>  arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi | 11 +++++++++--
>  arch/arm/boot/dts/imx6ull-colibri.dtsi         |  6 ++++++
>  3 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
> index fc388b84bf22..91a0ced44e27 100644
> --- a/arch/arm/boot/dts/imx6ul.dtsi
> +++ b/arch/arm/boot/dts/imx6ul.dtsi
> @@ -857,6 +857,8 @@
>  					 <&clks IMX6UL_CLK_USDHC1>,
>  					 <&clks IMX6UL_CLK_USDHC1>;
>  				clock-names = "ipg", "ahb", "per";
> +				fsl,tuning-step= <2>;
> +				fsl,tuning-start-tap = <20>;
>  				bus-width = <4>;
>  				status = "disabled";
>  			};
> @@ -870,6 +872,8 @@
>  					 <&clks IMX6UL_CLK_USDHC2>;
>  				clock-names = "ipg", "ahb", "per";
>  				bus-width = <4>;
> +				fsl,tuning-step= <2>;
> +				fsl,tuning-start-tap = <20>;
>  				status = "disabled";
>  			};
>  
> diff --git a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
> b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
> index 006690ea98c0..7dc7770cf52c 100644
> --- a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
> +++ b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
> @@ -145,13 +145,20 @@
>  };
>  
>  &usdhc1 {
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
>  	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_snvs_usdhc1_cd>;
> -	no-1-8-v;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz &pinctrl_snvs_usdhc1_cd>;
> +	pinctrl-2 = <&pinctrl_usdhc1_100mhz &pinctrl_snvs_usdhc1_cd>;

Should that not be pinctrl_usdhc1_200mhz?

--
Stefan

> +	pinctrl-3 = <&pinctrl_usdhc1 &pinctrl_snvs_usdhc1_sleep_cd>;
>  	cd-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
>  	disable-wp;
>  	wakeup-source;
>  	keep-power-in-suspend;
>  	vmmc-supply = <&reg_3v3>;
> +	vqmmc-supply = <&reg_sd1_vmmc>;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
>  	status = "okay";
>  };
> diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi
> b/arch/arm/boot/dts/imx6ull-colibri.dtsi
> index 9ad1da159768..d56728f03c35 100644
> --- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
> @@ -545,6 +545,12 @@
>  		>;
>  	};
>  
> +	pinctrl_snvs_usdhc1_sleep_cd: snvs-usdhc1-cd-grp-slp {
> +		fsl,pins = <
> +			MX6ULL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x0
> +		>;
> +	};
> +
>  	pinctrl_snvs_wifi_pdn: snvs-wifi-pdn-grp {
>  		fsl,pins = <
>  			MX6ULL_PAD_BOOT_MODE1__GPIO5_IO11	0x14
