Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FEDCA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CEE214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572352471;
	bh=u+1ITL87h6ImOthGngmYhcBAP+hlgJeYPm22xeQD6yU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IRC0rnYSTcdo0CD/o6RrXgCXDRTVtQ12lQ1yTLmHq9utbqsqVooJ7sWsLlfF7urXj
	 JQw1GPAff4aXfA0n7+hl+L1/kfuVVhGYJeFFpB31dApDnvCoDdhtR4ynUU8341askK
	 ehtchbBRfh/TMshjMT0NwBasIBvDp5M2UCjsrJSQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfJ2Mea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:34:30 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42875 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfJ2Mea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:34:30 -0400
Received: by mail-oi1-f195.google.com with SMTP id i185so8748378oif.9;
        Tue, 29 Oct 2019 05:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NuGvNr5d2i3rf51wx85q7m6lDMmKS60m3xzeENQ/V5I=;
        b=doZ0rvRets4olFvKXpxlrrCVVS6rlQGsqLhi7kHXnuKqN2dDM1xlqxRqAQG5/H2zUK
         8L8Dt7opLT+tNm2qCYqw1aIA1/cC5eZqURUHgOJqZEL/gIJuZv6w9w2dmYBmxyKKfGUM
         BUHE1k5vX3lMkg2saTKSHJBRamiZCKy7l3aY+4UOX3450sD2Qs5zS+GiyWdTW0iI3Nxe
         gXuZWB+atLLB72aeS3a63atHXApooozaw9TNVH4RgJnrZzrtzE8tEwfh/fcygJ9SxVL/
         EI8SI6Kh2tgKE7hiiS3k4y6KRmOYFfi51Ebc9pA0KBJ1kBqCIMMm9pubmqcYSShL4bbl
         3V1w==
X-Gm-Message-State: APjAAAUbCH0aaViVn+BvC/G5gJW98QZodOFA6EGzzlfP9M3UVHPI8Mum
        laiZvDaG/FVWW3DVKny3fA==
X-Google-Smtp-Source: APXvYqyKfHHEU0+WHpt8FAZ1kGjO3iGV0VKL6cIl4PDExXqHjBfHF/9A1De9Cet/U9+IxV6W9Nx6eA==
X-Received: by 2002:aca:f046:: with SMTP id o67mr3664860oih.155.1572352468513;
        Tue, 29 Oct 2019 05:34:28 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q5sm2691065oih.55.2019.10.29.05.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 05:34:27 -0700 (PDT)
Date:   Tue, 29 Oct 2019 07:34:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?K=E9vin?= RAYMOND <k.raymond@overkiz.com>,
        Mickael GARDET <m.gardet@overkiz.com>
Subject: Re: [PATCH 2/2] ARM: dts: at91: add a common kizboxmini dtsi file
Message-ID: <20191029123426.GB8412@bogus>
References: <20191018140304.31547-1-kamel.bouhara@bootlin.com>
 <20191018140304.31547-3-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191018140304.31547-3-kamel.bouhara@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 04:03:04PM +0200, Kamel Bouhara wrote:
> Split the Kizbox Mini boards into two board configuration, the
> Kizboxmini Mother board and the Kizboxmini RailDIN board.
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Signed-off-by: Kévin RAYMOND <k.raymond@overkiz.com>
> Signed-off-by: Mickael GARDET <m.gardet@overkiz.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   2 +
>  arch/arm/boot/dts/at91-kizboxmini-mb.dts      |  38 ++++
>  arch/arm/boot/dts/at91-kizboxmini-rd.dts      |  54 ++++++
>  arch/arm/boot/dts/at91-kizboxmini_common.dtsi | 166 ++++++++++++++++++
>  4 files changed, 260 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91-kizboxmini-mb.dts
>  create mode 100644 arch/arm/boot/dts/at91-kizboxmini-rd.dts
>  create mode 100644 arch/arm/boot/dts/at91-kizboxmini_common.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index c976b72a4c94..6b3a65f3f6f8 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -38,6 +38,8 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
>  	at91-ariettag25.dtb \
>  	at91-cosino_mega2560.dtb \
>  	at91-kizboxmini.dtb \
> +	at91-kizboxmini-mb.dtb \
> +	at91-kizboxmini-rd.dtb \
>  	at91-wb45n.dtb \
>  	at91sam9g15ek.dtb \
>  	at91sam9g25ek.dtb \
> diff --git a/arch/arm/boot/dts/at91-kizboxmini-mb.dts b/arch/arm/boot/dts/at91-kizboxmini-mb.dts
> new file mode 100644
> index 000000000000..52921f547dd6
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-kizboxmini-mb.dts
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2015-2018 Overkiz SAS
> + *   Author: Mickael Gardet <m.gardet@overkiz.com>
> + *           Kévin Raymond <k.raymond@overkiz.com>
> + */
> +/dts-v1/;
> +#include "at91-kizboxmini_common.dtsi"
> +
> +/ {
> +	model = "Overkiz Kizbox Mini Mother Board";
> +	compatible = "overkiz,kizboxmini-mb", "atmel,at91sam9g25",
> +		     "atmel,at91sam9x5", "atmel,at91sam9";
> +
> +	clocks {
> +		slow_xtal {

Don't use '_' in node names.

> +			clock-frequency = <32768>;
> +		};
> +	};
> +
> +	pwm_leds {
> +		blue {
> +			label = "pwm:blue:user";
> +			pwms = <&pwm0 2 10000000 0>;
> +			max-brightness = <255>;
> +			linux,default-trigger = "none";
> +		};
> +	};
> +};
> +
> +&usb0 {
> +	num-ports = <2>;
> +};
> +
> +&rtc {
> +	status = "okay";
> +};
> +
> diff --git a/arch/arm/boot/dts/at91-kizboxmini-rd.dts b/arch/arm/boot/dts/at91-kizboxmini-rd.dts
> new file mode 100644
> index 000000000000..1d2db8e16271
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-kizboxmini-rd.dts
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2015-2018 Overkiz SAS
> + *   Author: Mickael Gardet <m.gardet@overkiz.com>
> + *           Kévin Raymond <k.raymond@overkiz.com>
> + */
> +/dts-v1/;
> +#include "at91-kizboxmini_common.dtsi"
> +
> +/ {
> +	model = "Overkiz Kizbox Mini RailDIN";
> +	compatible = "overkiz,kizboxmini-rd", "atmel,at91sam9g25",
> +		     "atmel,at91sam9x5", "atmel,at91sam9";
> +
> +	clocks {
> +		slow_xtal {
> +			clock-frequency = <32768>;
> +		};
> +		adc_op_clk {
> +			status = "okay";
> +		};
> +	};
> +};
> +
> +&pinctrl {
> +	adc0 {
> +		pinctrl_adc0_ad5: adc0_ad5-0 {
> +			/* pull-up disable */
> +			atmel,pins = <AT91_PIOB 16 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +		};
> +	};
> +};
> +
> +&usart0 {
> +	status = "disabled";
> +};
> +
> +&rtc {
> +	status = "okay";
> +};
> +
> +&leds {
> +	blue {
> +		status = "okay";
> +	};
> +};
> +
> +&adc0 {
> +	atmel,adc-vref = <2500>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_adc0_ad5>;
> +	atmel,adc-channels-used = <0x0020>;
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/at91-kizboxmini_common.dtsi b/arch/arm/boot/dts/at91-kizboxmini_common.dtsi
> new file mode 100644
> index 000000000000..2598b776a278
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-kizboxmini_common.dtsi
> @@ -0,0 +1,166 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * at91-kizboxmini.dts - Device Tree file for Overkiz Kizbox mini board
> + *
> + * Copyright (C) 2014-2018 Overkiz SAS
> + *   Author: Antoine Aubert <a.aubert@overkiz.com>
> + *           Gaël Portay <g.portay@overkiz.com>
> + *           Kévin Raymond <k.raymond@overkiz.com>
> + *           Dorian Rocipon <d.rocipon@overkiz.com>
> + */
> +#include "at91sam9g25.dtsi"
> +
> +/ {
> +	chosen {
> +		bootargs = "ubi.mtd=ubi";
> +		stdout-path = &dbgu;
> +	};
> +
> +	memory {

memory@20000000

Build your dtb with W=12 and fix any new warnings (feel free to fix 
existing ones too :) ).

> +		reg = <0x20000000 0x8000000>;
> +	};
> +
> +	clocks {
> +		main_xtal {
> +			clock-frequency = <12000000>;
> +		};
> +
> +		adc_op_clk {
> +			status = "disabled";
> +		};
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		prog {
> +			label = "PB_PROG";
> +			gpios = <&pioC 17 GPIO_ACTIVE_LOW>;
> +			linux,code = <0x102>;
> +			wakeup-source;
> +		};
> +
> +		reset {
> +			label = "PB_RST";
> +			gpios = <&pioC 16 GPIO_ACTIVE_LOW>;
> +			linux,code = <0x100>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	leds: pwm_leds {
> +		compatible = "pwm-leds";
> +
> +		blue {
> +			label = "pwm:blue:user";
> +			pwms = <&pwm0 2 10000000 0>;
> +			max-brightness = <255>;
> +			linux,default-trigger = "none";
> +			status = "disabled";
> +		};
> +
> +		green {
> +			label = "pwm:green:user";
> +			pwms = <&pwm0 0 10000000 0>;
> +			max-brightness = <255>;
> +			linux,default-trigger = "default-on";
> +		};
> +
> +		red {
> +			label = "pwm:red:user";
> +			pwms = <&pwm0 1 10000000 0>;
> +			max-brightness = <255>;
> +			linux,default-trigger = "default-on";
> +		};
> +	};
> +};
> +
> +&usart0 {
> +	atmel,use-dma-rx;
> +	atmel,use-dma-tx;
> +	status = "okay";
> +};
> +
> +&macb0 {
> +	phy-mode = "rmii";
> +	status = "okay";
> +};
> +
> +&pwm0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm0_pwm0_1
> +		     &pinctrl_pwm0_pwm1_1
> +		     &pinctrl_pwm0_pwm2_1>;
> +	status = "okay";
> +};
> +
> +&dbgu {
> +	status = "okay";
> +};
> +
> +&watchdog {
> +	status = "okay";
> +};
> +
> +&adc0 {
> +	status = "disabled";
> +};
> +
> +&rtc {
> +	status = "disabled";
> +};
> +
> +&ebi {
> +	pinctrl-0 = <&pinctrl_ebi_addr_nand
> +			&pinctrl_ebi_data_0_7>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&nand_controller {
> +	status = "okay";
> +	pinctrl-0 = <&pinctrl_nand_oe_we
> +		     &pinctrl_nand_cs
> +		     &pinctrl_nand_rb>;
> +	pinctrl-names = "default";
> +
> +	nand@3 {
> +		reg = <0x3 0x0 0x800000>;
> +		rb-gpios = <&pioD 5 GPIO_ACTIVE_HIGH>;
> +		cs-gpios = <&pioD 4 GPIO_ACTIVE_HIGH>;
> +		nand-bus-width = <8>;
> +		nand-ecc-mode = "hw";
> +		nand-ecc-strength = <4>;
> +		nand-ecc-step-size = <512>;
> +		nand-on-flash-bbt;
> +		label = "atmel_nand";
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			bootstrap@0 {
> +				label = "bootstrap";
> +				reg = <0x0 0x20000>;
> +			};
> +
> +			ubi@20000 {
> +				label = "ubi";
> +				reg = <0x20000 0x7fe0000>;
> +			};
> +		};
> +	};
> +};
> +
> +&usb0 {
> +	num-ports = <1>;
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	status = "okay";
> +};
> +
> -- 
> 2.23.0
> 
