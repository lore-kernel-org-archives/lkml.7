Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BADCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9402121897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410103AbfJROX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:23:26 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:50291 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731923AbfJROX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:23:26 -0400
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 62409200009;
        Fri, 18 Oct 2019 14:23:23 +0000 (UTC)
Date:   Fri, 18 Oct 2019 16:23:23 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?K=E9vin?= RAYMOND <k.raymond@overkiz.com>,
        Mickael GARDET <m.gardet@overkiz.com>
Subject: Re: [PATCH 2/2] ARM: dts: at91: add a common kizboxmini dtsi file
Message-ID: <20191018142323.GI3125@piout.net>
References: <20191018140304.31547-1-kamel.bouhara@bootlin.com>
 <20191018140304.31547-3-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191018140304.31547-3-kamel.bouhara@bootlin.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2019 16:03:04+0200, Kamel Bouhara wrote:
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

This adds more than the subject says.

>  4 files changed, 260 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91-kizboxmini-mb.dts
>  create mode 100644 arch/arm/boot/dts/at91-kizboxmini-rd.dts
>  create mode 100644 arch/arm/boot/dts/at91-kizboxmini_common.dtsi
> 

Is arch/arm/boot/dts/at91-kizboxmini.dts still necessary after that?

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

The pwm is redefined here but is still left disabled from the common
dtsi.

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

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
