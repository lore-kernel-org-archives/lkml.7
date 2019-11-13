Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3795C17442
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C653521A49
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfKMHj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 02:39:59 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48251 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfKMHj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:39:59 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iUnFm-0007Nc-30; Wed, 13 Nov 2019 08:39:50 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iUnFi-0007pn-Ee; Wed, 13 Nov 2019 08:39:46 +0100
Date:   Wed, 13 Nov 2019 08:39:46 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     shawnguo@kernel.org, narmstrong@baylibre.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 1/3] ARM: dts: imx6ul: Add Variscite DART-6UL SoM
 support
Message-ID: <20191113073946.jmpjfsxx7fbg6emu@pengutronix.de>
References: <1573586526-15007-1-git-send-email-oliver.graute@gmail.com>
 <1573586526-15007-2-git-send-email-oliver.graute@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573586526-15007-2-git-send-email-oliver.graute@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:26:34 up 179 days, 13:44, 119 users,  load average: 0.04, 0.05,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

thanks for the patch. I made my comments inline.

On 19-11-12 20:22, Oliver Graute wrote:
> This patch adds support for the i.MX6UL variant of the Variscite DART-6UL
> SoM Carrier-Board
> 
> Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Marco Felsch <m.felsch@pengutronix.de>
> ---
> Changelog:
> 
> v7:
>  - removed cpu0 node
>  - fixed phy problem
> 
> v6:
>  - renamed touch regulator
>  - renamed rmii clock
>  - moved some muxing to baseboard
>  - added pinctrl for gpio key
>  - added bus-width to usdhc1
>  - fixed missing subnode on partitions
> 
>  .../boot/dts/imx6ul-imx6ull-var-dart-common.dtsi   | 376 +++++++++++++++++++++
>  1 file changed, 376 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi
> 
> diff --git a/arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi b/arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi
> new file mode 100644
> index 00000000..b3cd928
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi
> @@ -0,0 +1,367 @@
> +// SPDX-License-Identifier: (GPL-2.0)
> +/dts-v1/;
> +
> +#include "imx6ul.dtsi"
> +/ {
> +	chosen {
> +		stdout-path = &uart1;
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x20000000>;
> +	};
> +
> +	clk_rmii_ref: clock-rmii-ref {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <25000000>;
> +		clock-output-names = "rmii-ref";
> +	};
> +
> +	reg_touch_3v3: regulator-touch-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "touch_3v3_supply";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};

Where is this regulator used?

> +
> +	reg_sd1_vmmc: regulator-sd1-vmmc {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VSD_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	reg_gpio_dvfs: regulator-gpio {
> +		compatible = "regulator-gpio";
> +		regulator-min-microvolt = <1300000>;
> +		regulator-max-microvolt = <1400000>;
> +		regulator-name = "gpio_dvfs";
> +		regulator-type = "voltage";
> +		gpios = <&gpio4 13 GPIO_ACTIVE_HIGH>;

Please add a dedicated pinctrl for this regultor.

> +		enable-active-high;
> +		states = <1300000 0x1 1400000 0x0>;
> +	};

Can you alphabetical order the regultor-* nodes?

> +};
> +
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet1>;
> +	phy-mode = "rmii";
> +	phy-handle = <&ethphy0>;
> +	phy-reset-gpios=<&gpio5 10 1>;

Where happens this mux?

> +	phy-reset-duration=<100>;
> +	phy-reset-on-resume;
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: ethernet-phy@1 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			micrel,rmii-reference-clock-select-25-mhz;
> +			clocks = <&clk_rmii_ref>;
> +			clock-names = "rmii-ref";
> +			reg = <1>;
> +		};
> +
> +		ethphy1: ethernet-phy@3 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			micrel,rmii-reference-clock-select-25-mhz;
> +			clocks = <&clk_rmii_ref>;
> +			clock-names = "rmii-ref";
> +			reg = <3>;
> +		};
> +	};
> +};
> +
> +&gpmi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpmi_nand>;
> +	status = "okay";
> +
> +	nand@0 {

I never saw this notation. Please check the
Documentation/devicetree/bindings/mtd/partition.txt.

> +		partition@0 {
> +			label = "spl";
> +			reg = <0x00000000 0x00200000>;
> +		};
> +
> +		partition@200000 {
> +			label = "uboot";
> +			reg = <0x00200000 0x00200000>;
> +		};
> +
> +		partition@400000 {
> +			label = "uboot-env";
> +			reg = <0x00400000 0x00200000>;
> +		};
> +
> +		partition@600000 {
> +			label = "kernel";
> +			reg = <0x00600000 0x00800000>;
> +		};
> +
> +		partition@e00000 {
> +			label = "rootfs";
> +			reg = <0x00e00000 0x3f200000>;
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +};

Please sort it alphabetical.

> +
> +&sai2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai2>;
> +	assigned-clocks = <&clks IMX6UL_CLK_SAI2_SEL>,
> +			  <&clks IMX6UL_CLK_SAI2>;
> +	assigned-clock-parents = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
> +	assigned-clock-rates = <0>, <12288000>;
> +	fsl,sai-mclk-direction-output;
> +	status = "okay";
> +};
> +
> +&snvs_poweroff {
> +	status = "okay";
> +};
> +
> +&snvs_rtc {
> +	status = "disabled";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	uart-has-rtscts;
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	bus-width = <4>;
> +	no-1-8-v;

HS200 mode only works with 1.8V or 1.2V. Can you verify the HS200 state?

Regards,
  Marco

> +	keep-power-in-suspend;
> +	vmmc-supply = <&reg_sd1_vmmc>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&wdog1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wdog>;
> +	fsl,ext-reset-output;
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	pinctrl_enet1: enet1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN	0x1b0b0
> +			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER	0x1b0b0
> +			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00	0x1b0b0
> +			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01	0x1b0b0
> +			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b0b0
> +			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b0b0
> +			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b0b0
> +			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x4001b031
> +		>;
> +	};
> +
> +	pinctrl_enet2: enet2grp {
> +		fsl,pins = <
> +			MX6UL_PAD_ENET2_RX_EN__ENET2_RX_EN	0x1b0b0
> +			MX6UL_PAD_ENET2_RX_ER__ENET2_RX_ER	0x1b0b0
> +			MX6UL_PAD_ENET2_RX_DATA0__ENET2_RDATA00	0x1b0b0
> +			MX6UL_PAD_ENET2_RX_DATA1__ENET2_RDATA01	0x1b0b0
> +			MX6UL_PAD_ENET2_TX_EN__ENET2_TX_EN	0x1b0b0
> +			MX6UL_PAD_ENET2_TX_DATA0__ENET2_TDATA00	0x1b0b0
> +			MX6UL_PAD_ENET2_TX_DATA1__ENET2_TDATA01	0x1b0b0
> +			MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b031
> +			MX6UL_PAD_JTAG_MOD__GPIO1_IO10		0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_flexcan1: flexcan1grp{
> +		fsl,pins = <
> +			MX6UL_PAD_LCD_DATA09__FLEXCAN1_RX	0x1b020
> +			MX6UL_PAD_LCD_DATA08__FLEXCAN1_TX	0x1b020
> +		>;
> +	};
> +
> +	pinctrl_flexcan2: flexcan2grp{
> +		fsl,pins = <
> +			MX6UL_PAD_UART2_RTS_B__FLEXCAN2_RX	0x1b020
> +			MX6UL_PAD_UART2_CTS_B__FLEXCAN2_TX	0x1b020
> +		>;
> +	};
> +
> +	pinctrl_gpio_keys: gpio_keysgrp {
> +		fsl,pins = <
> +			MX6UL_PAD_GPIO1_IO00__GPIO1_IO00	0x17059
> +		>;
> +	};
> +
> +	pinctrl_gpio_leds: gpioledsgrp {
> +		fsl,pins = <
> +			MX6UL_PAD_CSI_HSYNC__GPIO4_IO20		0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_gpmi_nand: gpminandgrp {
> +		fsl,pins = <
> +			MX6UL_PAD_NAND_CLE__RAWNAND_CLE		0xb0b1
> +			MX6UL_PAD_NAND_ALE__RAWNAND_ALE		0xb0b1
> +			MX6UL_PAD_NAND_WP_B__RAWNAND_WP_B	0xb0b1
> +			MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B	0xb000
> +			MX6UL_PAD_NAND_CE0_B__RAWNAND_CE0_B	0xb0b1
> +			MX6UL_PAD_NAND_CE1_B__RAWNAND_CE1_B	0xb0b1
> +			MX6UL_PAD_NAND_RE_B__RAWNAND_RE_B	0xb0b1
> +			MX6UL_PAD_NAND_WE_B__RAWNAND_WE_B	0xb0b1
> +			MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00	0xb0b1
> +			MX6UL_PAD_NAND_DATA01__RAWNAND_DATA01	0xb0b1
> +			MX6UL_PAD_NAND_DATA02__RAWNAND_DATA02	0xb0b1
> +			MX6UL_PAD_NAND_DATA03__RAWNAND_DATA03	0xb0b1
> +			MX6UL_PAD_NAND_DATA04__RAWNAND_DATA04	0xb0b1
> +			MX6UL_PAD_NAND_DATA05__RAWNAND_DATA05	0xb0b1
> +			MX6UL_PAD_NAND_DATA06__RAWNAND_DATA06	0xb0b1
> +			MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07	0xb0b1
> +		>;
> +	};
> +
> +	pinctrl_hog: hoggrp {
> +		fsl,pins = <
> +			MX6UL_PAD_GPIO1_IO03__OSC32K_32K_OUT    0x03029
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART4_TX_DATA__I2C1_SCL	0x4001b8b0
> +			MX6UL_PAD_UART4_RX_DATA__I2C1_SDA	0x4001b8b0
> +		>;
> +	};
> +
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART5_TX_DATA__I2C2_SCL	0x4001b8b0
> +			MX6UL_PAD_UART5_RX_DATA__I2C2_SDA	0x4001b8b0
> +		>;
> +	};
> +
> +	pinctrl_lcdif: lcdif {
> +		fsl,pins = <
> +			MX6UL_PAD_LCD_DATA02__LCDIF_DATA02	0x79
> +			MX6UL_PAD_LCD_DATA03__LCDIF_DATA03	0x79
> +			MX6UL_PAD_LCD_DATA04__LCDIF_DATA04	0x79
> +			MX6UL_PAD_LCD_DATA05__LCDIF_DATA05	0x79
> +			MX6UL_PAD_LCD_DATA06__LCDIF_DATA06	0x79
> +			MX6UL_PAD_LCD_DATA07__LCDIF_DATA07	0x79
> +			MX6UL_PAD_LCD_DATA10__LCDIF_DATA10	0x79
> +			MX6UL_PAD_LCD_DATA11__LCDIF_DATA11	0x79
> +			MX6UL_PAD_LCD_DATA12__LCDIF_DATA12	0x79
> +			MX6UL_PAD_LCD_DATA13__LCDIF_DATA13	0x79
> +			MX6UL_PAD_LCD_DATA14__LCDIF_DATA14	0x79
> +			MX6UL_PAD_LCD_DATA15__LCDIF_DATA15	0x79
> +			MX6UL_PAD_LCD_DATA18__LCDIF_DATA18	0x79
> +			MX6UL_PAD_LCD_DATA19__LCDIF_DATA19	0x79
> +			MX6UL_PAD_LCD_DATA20__LCDIF_DATA20	0x79
> +			MX6UL_PAD_LCD_DATA21__LCDIF_DATA21	0x79
> +			MX6UL_PAD_LCD_DATA22__LCDIF_DATA22	0x79
> +			MX6UL_PAD_LCD_DATA23__LCDIF_DATA23	0x79
> +			MX6UL_PAD_LCD_CLK__LCDIF_CLK		0x79
> +			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE	0x79
> +		>;
> +	};
> +
> +	pinctrl_pwm1: pwm1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_LCD_DATA00__PWM1_OUT		0x110b0
> +		>;
> +	};
> +
> +	pinctrl_sai2: sai2grp {
> +		fsl,pins = <
> +			MX6UL_PAD_JTAG_TDI__SAI2_TX_BCLK	0x17088
> +			MX6UL_PAD_JTAG_TDO__SAI2_TX_SYNC	0x17088
> +			MX6UL_PAD_JTAG_TRST_B__SAI2_TX_DATA	0x11088
> +			MX6UL_PAD_JTAG_TCK__SAI2_RX_DATA	0x11088
> +			MX6UL_PAD_JTAG_TMS__SAI2_MCLK		0x17088
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b1
> +			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX	0x1b0b1
> +			MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX	0x1b0b1
> +			MX6UL_PAD_UART2_CTS_B__UART2_DCE_CTS	0x1b0b1
> +			MX6UL_PAD_UART2_RTS_B__UART2_DCE_RTS	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_uart3: uart3grp {
> +		fsl,pins = <
> +			MX6UL_PAD_UART3_TX_DATA__UART3_DCE_TX	0x1b0b1
> +			MX6UL_PAD_UART3_RX_DATA__UART3_DCE_RX	0x1b0b1
> +			MX6UL_PAD_UART3_CTS_B__UART3_DCE_CTS	0x1b0b1
> +			MX6UL_PAD_UART3_RTS_B__UART3_DCE_RTS	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059
> +			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x17059
> +			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x17059
> +			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x17059
> +			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x17059
> +			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059
> +			MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
> +		fsl,pins = <
> +			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170b9
> +			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100b9
> +			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170b9
> +			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170b9
> +			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170b9
> +			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
> +			MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
> +		fsl,pins = <
> +			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170f9
> +			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100f9
> +			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170f9
> +			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170f9
> +			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170f9
> +			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170f9
> +			MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_wdog: wdoggrp {
> +		fsl,pins = <
> +			MX6UL_PAD_GPIO1_IO08__WDOG1_WDOG_B	0x78b0
> +		>;
> +	};
> +};
> -- 
> 2.7.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
