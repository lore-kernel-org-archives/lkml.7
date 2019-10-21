Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04AFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C0F2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571654293;
	bh=PEunH+MbQmuiQvHioHFkjQVeDSMFINabeIQdo+/1ACM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FmByjcBTtQ7E65psvd4tCpuij1J5svi9r5LZ/SZXPu9wOMs3enmMhFmBFqA26YoBd
	 6DC9her8CchGNdxKutcl8c3s7uw9VBhywqb8i6H/b+Ia0AYA3wGhmfKwTDc+Ol+J7D
	 JE6Yk50RslDoZr4mgJIJSo83AnJV7mPqQ+9Q3A1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfJUKiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:38:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34566 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbfJUKiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:38:11 -0400
Received: by mail-ed1-f65.google.com with SMTP id b72so658292edf.1;
        Mon, 21 Oct 2019 03:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gMVb6pc6U8u8dJnpa1YBYsQQf7AyL9iY9eok78Yj9Q8=;
        b=DmZn5qGA8voLtNUMx7JpymqsH0+Ngr1GS7tH2uNMvucKfPPV3jXKYEg34eqD/KztO1
         gutYTG4SQW9ZjTdpQuYALUqtZTyOM56m64TLUYJ2PMt73hsWGbqO/MCxCse4ee2HK5NX
         bNkOwt2P2FSQbtPKttvYz+a50nW6Ue11CNvgogROT3wl1f82ECJbaw0wv99g3xriw0NG
         xufKFSYNYi3l3wnN2zQi2ttq/VRSz1E+mT/v8agoFxxhSyn8eR7fGcacwy4eKuAtqERM
         PVKTc2RozJvEYXkME7ImHqIBZyr7MZz2FMjDkmeZjlrYCrsk5DuGVU5WIug7w5m1g5cU
         sBkg==
X-Gm-Message-State: APjAAAWSczf5/JGJ4DJFyj+ZZWTbZv5u13Vqh7tV36NGvcl23jlxbo2O
        zh7KKnfE3YzOKUf5lxzEnv/I814H
X-Google-Smtp-Source: APXvYqzM43SGtxmG6cidDiwIhdowKNO8B+deIAY+/JM0LTiG4eLdILRXiQoDWf/J1ovvgKDhvAt7cA==
X-Received: by 2002:a17:906:2d49:: with SMTP id e9mr21192830eji.240.1571654289167;
        Mon, 21 Oct 2019 03:38:09 -0700 (PDT)
Received: from pi3 ([194.230.155.217])
        by smtp.googlemail.com with ESMTPSA id a26sm609293edm.45.2019.10.21.03.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 03:38:08 -0700 (PDT)
Date:   Mon, 21 Oct 2019 12:38:02 +0200
From:   "krzk@kernel.org" <krzk@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/10] ARM: dts: imx6ul-kontron-n6310-s: Move common
 nodes to a separate file
Message-ID: <20191021103802.GC1934@pi3>
References: <20191016150622.21753-1-frieder.schrempf@kontron.de>
 <20191016150622.21753-4-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191016150622.21753-4-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 03:07:25PM +0000, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The baseboard for the Kontron N6310 SoM is also used for other SoMs
> such as N6311 and N6411. In order to share the code, we move the
> definitions of the baseboard to a separate dtsi file.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts  | 405 +----------------
>  arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi | 412 ++++++++++++++++++
>  2 files changed, 413 insertions(+), 404 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
> 
> diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts b/arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts
> index 0205fd56d975..5a3e06d6219b 100644
> --- a/arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts
> +++ b/arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts
> @@ -8,413 +8,10 @@
>  /dts-v1/;
>  
>  #include "imx6ul-kontron-n6310-som.dtsi"
> +#include "imx6ul-kontron-n6x1x-s.dtsi"
>  
>  / {
>  	model = "Kontron N6310 S";
>  	compatible = "kontron,imx6ul-n6310-s", "kontron,imx6ul-n6310-som",
>  		     "fsl,imx6ul";
> -
> -	gpio-leds {
> -		compatible = "gpio-leds";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_gpio_leds>;
> -
> -		led1 {
> -			label = "debug-led1";
> -			gpios = <&gpio1 30 GPIO_ACTIVE_LOW>;
> -			default-state = "off";
> -			linux,default-trigger = "heartbeat";
> -		};
> -
> -		led2 {
> -			label = "debug-led2";
> -			gpios = <&gpio5 3 GPIO_ACTIVE_LOW>;
> -			default-state = "off";
> -		};
> -
> -		led3 {
> -			label = "debug-led3";
> -			gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
> -			default-state = "off";
> -		};
> -	};
> -
> -	pwm-beeper {
> -		compatible = "pwm-beeper";
> -		pwms = <&pwm8 0 5000>;
> -	};
> -
> -	reg_3v3: regulator-3v3 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "3v3";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -	};
> -
> -	reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
> -		compatible = "regulator-fixed";
> -		regulator-name = "usb_otg1_vbus";
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		gpio = <&gpio1 4 GPIO_ACTIVE_HIGH>;
> -		enable-active-high;
> -	};
> -
> -	reg_vref_adc: regulator-vref-adc {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vref-adc";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -	};
> -};
> -
> -&adc1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_adc1>;
> -	num-channels = <3>;
> -	vref-supply = <&reg_vref_adc>;
> -	status = "okay";
> -};
> -
> -&can2 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_flexcan2>;
> -	status = "okay";
> -};
> -
> -&ecspi1 {
> -	cs-gpios = <&gpio4 26 GPIO_ACTIVE_HIGH>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_ecspi1>;
> -	status = "okay";
> -
> -	eeprom@0 {
> -		compatible = "anvo,anv32e61w", "atmel,at25";
> -		reg = <0>;
> -		spi-max-frequency = <20000000>;
> -		spi-cpha;
> -		spi-cpol;
> -		pagesize = <1>;
> -		size = <8192>;
> -		address-width = <16>;
> -	};
> -};
> -
> -&fec1 {
> -	pinctrl-0 = <&pinctrl_enet1>;
> -	/delete-node/ mdio;
> -};
> -
> -&fec2 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_enet2 &pinctrl_enet2_mdio>;
> -	phy-mode = "rmii";
> -	phy-handle = <&ethphy2>;
> -	status = "okay";
> -
> -	mdio {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		ethphy1: ethernet-phy@1 {
> -			reg = <1>;
> -			micrel,led-mode = <0>;
> -			clocks = <&clks IMX6UL_CLK_ENET_REF>;
> -			clock-names = "rmii-ref";
> -		};
> -
> -		ethphy2: ethernet-phy@2 {
> -			reg = <2>;
> -			micrel,led-mode = <0>;
> -			clocks = <&clks IMX6UL_CLK_ENET2_REF>;
> -			clock-names = "rmii-ref";
> -		};
> -	};
> -};
> -
> -&i2c1 {
> -	clock-frequency = <100000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_i2c1>;
> -	status = "okay";
> -};
> -
> -&i2c4 {
> -	clock-frequency = <100000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_i2c4>;
> -	status = "okay";
> -
> -	rtc@32 {
> -		compatible = "epson,rx8900";
> -		reg = <0x32>;
> -	};
> -};
> -
> -&pwm8 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_pwm8>;
> -	status = "okay";
> -};
> -
> -&snvs_poweroff {
> -	status = "okay";
> -};
> -
> -&uart1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_uart1>;
> -	status = "okay";
> -};
> -
> -&uart2 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_uart2>;
> -	linux,rs485-enabled-at-boot-time;
> -	rs485-rx-during-tx;
> -	rs485-rts-active-low;
> -	uart-has-rtscts;
> -	status = "okay";
> -};
> -
> -&uart3 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_uart3>;
> -	fsl,uart-has-rtscts;
> -	status = "okay";
> -};
> -
> -&uart4 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_uart4>;
> -	status = "okay";
> -};
> -
> -&usbotg1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_usbotg1>;
> -	dr_mode = "otg";
> -	srp-disable;
> -	hnp-disable;
> -	adp-disable;
> -	vbus-supply = <&reg_usb_otg1_vbus>;
> -	status = "okay";
> -};
> -
> -&usbotg2 {
> -	dr_mode = "host";
> -	disable-over-current;
> -	status = "okay";
> -};
> -
> -&usdhc1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_usdhc1>;
> -	cd-gpios = <&gpio1 19 GPIO_ACTIVE_LOW>;
> -	keep-power-in-suspend;
> -	wakeup-source;
> -	vmmc-supply = <&reg_3v3>;
> -	voltage-ranges = <3300 3300>;
> -	no-1-8-v;
> -	status = "okay";
> -};
> -
> -&usdhc2 {
> -	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> -	pinctrl-0 = <&pinctrl_usdhc2>;
> -	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
> -	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
> -	non-removable;
> -	keep-power-in-suspend;
> -	wakeup-source;
> -	vmmc-supply = <&reg_3v3>;
> -	voltage-ranges = <3300 3300>;
> -	no-1-8-v;
> -	status = "okay";
> -};
> -
> -&wdog1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_wdog>;
> -	fsl,ext-reset-output;
> -	status = "okay";
> -};
> -
> -&iomuxc {
> -	pinctrl-0 = <&pinctrl_reset_out &pinctrl_gpio>;
> -
> -	pinctrl_adc1: adc1grp {
> -		fsl,pins = <
> -			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02	0xb0
> -			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03	0xb0
> -			MX6UL_PAD_GPIO1_IO08__GPIO1_IO08	0xb0
> -		>;
> -	};
> -
> -	/* FRAM */
> -	pinctrl_ecspi1: ecspi1grp {
> -		fsl,pins = <
> -			MX6UL_PAD_CSI_DATA07__ECSPI1_MISO	0x100b1
> -			MX6UL_PAD_CSI_DATA06__ECSPI1_MOSI	0x100b1
> -			MX6UL_PAD_CSI_DATA04__ECSPI1_SCLK	0x100b1
> -			MX6UL_PAD_CSI_DATA05__GPIO4_IO26	0x100b1	/* ECSPI1-CS1 */
> -		>;
> -	};
> -
> -	pinctrl_enet2: enet2grp {
> -		fsl,pins = <
> -			MX6UL_PAD_ENET2_RX_EN__ENET2_RX_EN	0x1b0b0
> -			MX6UL_PAD_ENET2_RX_ER__ENET2_RX_ER	0x1b0b0
> -			MX6UL_PAD_ENET2_RX_DATA0__ENET2_RDATA00	0x1b0b0
> -			MX6UL_PAD_ENET2_RX_DATA1__ENET2_RDATA01	0x1b0b0
> -			MX6UL_PAD_ENET2_TX_EN__ENET2_TX_EN	0x1b0b0
> -			MX6UL_PAD_ENET2_TX_DATA0__ENET2_TDATA00	0x1b0b0
> -			MX6UL_PAD_ENET2_TX_DATA1__ENET2_TDATA01	0x1b0b0
> -			MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b009
> -		>;
> -	};
> -
> -	pinctrl_enet2_mdio: enet2mdiogrp {
> -		fsl,pins = <
> -			MX6UL_PAD_GPIO1_IO07__ENET2_MDC         0x1b0b0
> -			MX6UL_PAD_GPIO1_IO06__ENET2_MDIO        0x1b0b0
> -		>;
> -	};
> -
> -	pinctrl_flexcan2: flexcan2grp{
> -		fsl,pins = <
> -			MX6UL_PAD_UART2_RTS_B__FLEXCAN2_RX	0x1b020
> -			MX6UL_PAD_UART2_CTS_B__FLEXCAN2_TX	0x1b020
> -		>;
> -	};
> -
> -	pinctrl_gpio: gpiogrp {
> -		fsl,pins = <
> -			MX6UL_PAD_SNVS_TAMPER5__GPIO5_IO05	0x1b0b0 /* DOUT1 */
> -			MX6UL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0 /* DIN1 */
> -			MX6UL_PAD_SNVS_TAMPER1__GPIO5_IO01	0x1b0b0 /* DOUT2 */
> -			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0b0 /* DIN2 */
> -		>;
> -	};
> -
> -	pinctrl_gpio_leds: gpioledsgrp {
> -		fsl,pins = <
> -			MX6UL_PAD_UART5_TX_DATA__GPIO1_IO30	0x1b0b0	/* LED H14 */
> -			MX6UL_PAD_SNVS_TAMPER3__GPIO5_IO03	0x1b0b0	/* LED H15 */
> -			MX6UL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x1b0b0	/* LED H16 */
> -		>;
> -	};
> -
> -	pinctrl_i2c1: i2c1grp {
> -		fsl,pins = <
> -			MX6UL_PAD_CSI_PIXCLK__I2C1_SCL		0x4001b8b0
> -			MX6UL_PAD_CSI_MCLK__I2C1_SDA		0x4001b8b0
> -		>;
> -	};
> -
> -	pinctrl_i2c4: i2c4grp {
> -		fsl,pins = <
> -			MX6UL_PAD_UART2_TX_DATA__I2C4_SCL	0x4001f8b0
> -			MX6UL_PAD_UART2_RX_DATA__I2C4_SDA	0x4001f8b0
> -		>;
> -	};
> -
> -	pinctrl_pwm8: pwm8grp {
> -		fsl,pins = <
> -			MX6UL_PAD_CSI_HSYNC__PWM8_OUT		0x110b0
> -		>;
> -	};
> -
> -	pinctrl_uart1: uart1grp {
> -		fsl,pins = <
> -			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b1
> -			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b1
> -		>;
> -	};
> -
> -	pinctrl_uart2: uart2grp {
> -		fsl,pins = <
> -			MX6UL_PAD_NAND_DATA04__UART2_DCE_TX	0x1b0b1
> -			MX6UL_PAD_NAND_DATA05__UART2_DCE_RX	0x1b0b1
> -			MX6UL_PAD_NAND_DATA06__UART2_DCE_CTS	0x1b0b1
> -			/*
> -			 * mux unused RTS to make sure it doesn't cause
> -			 * any interrupts when it is undefined
> -			 */
> -			MX6UL_PAD_NAND_DATA07__UART2_DCE_RTS	0x1b0b1
> -		>;
> -	};
> -
> -	pinctrl_uart3: uart3grp {
> -		fsl,pins = <
> -			MX6UL_PAD_UART3_TX_DATA__UART3_DCE_TX	0x1b0b1
> -			MX6UL_PAD_UART3_RX_DATA__UART3_DCE_RX	0x1b0b1
> -			MX6UL_PAD_UART3_CTS_B__UART3_DCE_CTS	0x1b0b1
> -			MX6UL_PAD_UART3_RTS_B__UART3_DCE_RTS	0x1b0b1
> -		>;
> -	};
> -
> -	pinctrl_uart4: uart4grp {
> -		fsl,pins = <
> -			MX6UL_PAD_UART4_TX_DATA__UART4_DCE_TX	0x1b0b1
> -			MX6UL_PAD_UART4_RX_DATA__UART4_DCE_RX	0x1b0b1
> -		>;
> -	};
> -
> -	pinctrl_usbotg1: usbotg1 {
> -		fsl,pins = <
> -			MX6UL_PAD_GPIO1_IO04__GPIO1_IO04	0x1b0b0
> -		>;
> -	};
> -
> -	pinctrl_usdhc1: usdhc1grp {
> -		fsl,pins = <
> -			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059
> -			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x10059
> -			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x17059
> -			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x17059
> -			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x17059
> -			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059
> -			MX6UL_PAD_UART1_RTS_B__GPIO1_IO19	0x100b1	/* SD1_CD */
> -		>;
> -	};
> -
> -	pinctrl_usdhc2: usdhc2grp {
> -		fsl,pins = <
> -			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x10059
> -			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x17059
> -			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x17059
> -			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x17059
> -			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x17059
> -			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x17059
> -		>;
> -	};
> -
> -	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> -		fsl,pins = <
> -			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100b9
> -			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170b9
> -			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x170b9
> -			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x170b9
> -			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x170b9
> -			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170b9
> -		>;
> -	};
> -
> -	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
> -		fsl,pins = <
> -			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100f9
> -			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170f9
> -			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x170f9
> -			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x170f9
> -			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x170f9
> -			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170f9
> -		>;
> -	};
> -
> -	pinctrl_wdog: wdoggrp {
> -		fsl,pins = <
> -			MX6UL_PAD_GPIO1_IO09__WDOG1_WDOG_ANY	0x30b0
> -		>;
> -	};
>  };
> diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
> new file mode 100644
> index 000000000000..08a326ce2cbe
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
> @@ -0,0 +1,412 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2017 exceet electronics GmbH
> + * Copyright (C) 2018 Kontron Electronics GmbH
> + * Copyright (c) 2019 Krzysztof Kozlowski <krzk@kernel.org>
> + */
> +

This file does not include anything else but uses defines (GPIO flags,
clocks, pins). Usually sources should not rely on inclusions coming from
unrelated files so here you should include necessary headers. In case of
future refactorings or reuse one might not know which defines you wanted
to use (in other platforms for example there might be multiple defines
in multiple header files with same name).


Best regards,
Krzysztof

