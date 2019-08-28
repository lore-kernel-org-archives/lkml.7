Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D4FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874982173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6fRhYtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfH1QUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 12:20:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35314 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfH1QUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 12:20:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so710306wmg.0;
        Wed, 28 Aug 2019 09:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+aZDMy74L0EeQ+epbhzKkFhVLGRjk1qPp0jN7zkjQQ0=;
        b=i6fRhYtLPNc+uXS5AWrJezeqQaTLVL5n7VuOV63YGd44R+Nmq3FQf01zRCVGX3wcMN
         cF95DLStcED7QKNfU+QV//ZUi5UYlAEBjPZjRX0d+N2PEFS159V43t4i+E+7ayMzp2zd
         dCcr0mUAx0mVHl3LfJ22mPp1jhGMsM2+M7sPp4oBtDR08naoHSVM4htqkrfgrUFRGS4J
         IZYwCOhKDV1hgLjB1+gapTDYbQQEOHJM8QuHweSs4yPc+iiB9Wr2Gs7Rjgp9XhS5QE0Y
         2wDu2H8QrgL5Vx0ElrQwE24wozFYxzQJGcKIuDJVP8/6+mBSaKttxzvn7RZ28z42Id57
         ZZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+aZDMy74L0EeQ+epbhzKkFhVLGRjk1qPp0jN7zkjQQ0=;
        b=Z9RfI8BRKjz8Zpy2QJ3obPm9OtiOTREuDpFU2HX+erZ4AxmrJo9h5Ya/tOPvc+L+aH
         OrqlvVn+SXWLwx792FpIPXnaA4GATBoIpesba8JfEjmQryXGE9Lfxr98aL0cYRKgx/6N
         c4v5DeIkwpAO7UamJ0Qo9gBBrk7XPDgvHR9nV4UPZStaXOlgPK4nXfF4O/PFKpSUxhh1
         PmAmeLChSPNKH+y1RCzugAPszVKoBfAkK+evYpWeesUEGx2OLs1D6nSX2BNtwbH53LwL
         U5HGVbo931oMru0d3JMxKoCMqLIyWA3iVlQWOnvlrBcXpTmp4+Eb/YcYxDJEcC8venHV
         fSkw==
X-Gm-Message-State: APjAAAVyoiujqgGWSuFaocm7By1hEuYCnl5akveB9k+i1ajxMTSClHpo
        UzvvjL5hHp5H7o/rzK44Uoc=
X-Google-Smtp-Source: APXvYqyT4y3lpQkCXwgHVhW4wA1Z1rgqsMT/rFDDq8btGQYmiBkwrmX03SuzxKGiglcBXfwOgtILqA==
X-Received: by 2002:a1c:6387:: with SMTP id x129mr5762471wmb.166.1567009198075;
        Wed, 28 Aug 2019 09:19:58 -0700 (PDT)
Received: from localhost ([31.16.217.87])
        by smtp.gmail.com with ESMTPSA id v6sm4754870wma.24.2019.08.28.09.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 09:19:57 -0700 (PDT)
From:   Oliver Graute <oliver.graute@gmail.com>
To:     shawnguo@kernel.org
Cc:     oliver.graute@gmail.com, narmstrong@baylibre.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCHv5 1/2] ARM: dts: imx6ul: Add Variscite DART-6UL SoM support
Date:   Wed, 28 Aug 2019 18:19:17 +0200
Message-Id: <1567009160-21965-2-git-send-email-oliver.graute@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567009160-21965-1-git-send-email-oliver.graute@gmail.com>
References: <1567009160-21965-1-git-send-email-oliver.graute@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the i.MX6UL variant of the Variscite DART-6UL
SoM Carrier-Board

Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/imx6ul-imx6ull-var-dart-common.dtsi   | 445 +++++++++++++++++++++
 1 file changed, 445 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi

diff --git a/arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi b/arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi
new file mode 100644
index 00000000..f345d69
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi
@@ -0,0 +1,445 @@
+// SPDX-License-Identifier: (GPL-2.0)
+/dts-v1/;
+
+#include "imx6ul.dtsi"
+/ {
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	touch_3v3_regulator: regulator-touch-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "touch_3v3_supply";
+		regulator-always-on;
+	};
+
+	reg_sd1_vmmc: regulator-sd1-vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_gpio_dvfs: regulator-gpio {
+		compatible = "regulator-gpio";
+		regulator-min-microvolt = <1300000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-name = "gpio_dvfs";
+		regulator-type = "voltage";
+		gpios = <&gpio4 13 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		states = <1300000 0x1 1400000 0x0>;
+	};
+
+	rmii_ref_clk: clock-rmii-ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+		clock-output-names = "rmii-ref";
+	};
+
+};
+
+&adc1 {
+	vref-supply = <&touch_3v3_regulator>;
+	status = "okay";
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	status = "disabled";
+};
+
+&can2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	status = "disabled";
+};
+
+&cpu0 {
+	arm-supply = <&reg_arm>;
+	soc-supply = <&reg_soc>;
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1>;
+	phy-mode = "rmii";
+	status = "disabled";
+};
+
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet2>;
+	phy-mode = "rmii";
+	status = "disabled";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			micrel,rmii-reference-clock-select-25-mhz;
+			clocks = <&rmii_ref_clk>;
+			clock-names = "rmii-ref";
+			reg = <1>;
+		};
+
+		ethphy1: ethernet-phy@3 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			micrel,rmii-reference-clock-select-25-mhz;
+			clocks = <&rmii_ref_clk>;
+			clock-names = "rmii-ref";
+			reg = <3>;
+		};
+	};
+};
+
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand>;
+	status = "okay";
+
+	partition@0 {
+		label = "spl";
+		reg = <0x00000000 0x00200000>;
+	};
+
+	partition@200000 {
+		label = "uboot";
+		reg = <0x00200000 0x00200000>;
+	};
+
+	partition@400000 {
+		label = "uboot-env";
+		reg = <0x00400000 0x00200000>;
+	};
+
+	partition@600000 {
+		label = "kernel";
+		reg = <0x00600000 0x00800000>;
+	};
+
+	partition@e00000 {
+		label = "rootfs";
+		reg = <0x00e00000 0x3f200000>;
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "disabled";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "disabled";
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "disabled";
+};
+
+&sai2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai2>;
+	assigned-clocks = <&clks IMX6UL_CLK_SAI2_SEL>,
+			  <&clks IMX6UL_CLK_SAI2>;
+	assigned-clock-parents = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
+	assigned-clock-rates = <0>, <12288000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
+&snvs_poweroff {
+	status = "okay";
+};
+
+&snvs_rtc {
+	status = "disabled";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "disabled";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	uart-has-rtscts;
+	status = "disabled";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	uart-has-rtscts;
+	status = "disabled";
+};
+
+&usbotg1 {
+	disable-over-current;
+	status = "disabled";
+};
+
+&usbotg2 {
+	disable-over-current;
+	status = "disabled";
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	no-1-8-v;
+	keep-power-in-suspend;
+	vmmc-supply = <&reg_sd1_vmmc>;
+	non-removable;
+	status = "okay";
+};
+
+&usdhc2 {
+	status = "disabled";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_enet1: enet1grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN	0x1b0b0
+			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER	0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00	0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01	0x1b0b0
+			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b0b0
+			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x4001b031
+		>;
+	};
+
+	pinctrl_enet2: enet2grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET2_RX_EN__ENET2_RX_EN	0x1b0b0
+			MX6UL_PAD_ENET2_RX_ER__ENET2_RX_ER	0x1b0b0
+			MX6UL_PAD_ENET2_RX_DATA0__ENET2_RDATA00	0x1b0b0
+			MX6UL_PAD_ENET2_RX_DATA1__ENET2_RDATA01	0x1b0b0
+			MX6UL_PAD_ENET2_TX_EN__ENET2_TX_EN	0x1b0b0
+			MX6UL_PAD_ENET2_TX_DATA0__ENET2_TDATA00	0x1b0b0
+			MX6UL_PAD_ENET2_TX_DATA1__ENET2_TDATA01	0x1b0b0
+			MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b031
+			MX6UL_PAD_GPIO1_IO07__ENET2_MDC		0x1b0b0
+			MX6UL_PAD_GPIO1_IO06__ENET2_MDIO	0x1b0b0
+			MX6UL_PAD_JTAG_MOD__GPIO1_IO10		0x1b0b0
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp{
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA09__FLEXCAN1_RX	0x1b020
+			MX6UL_PAD_LCD_DATA08__FLEXCAN1_TX	0x1b020
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp{
+		fsl,pins = <
+			MX6UL_PAD_UART2_RTS_B__FLEXCAN2_RX	0x1b020
+			MX6UL_PAD_UART2_CTS_B__FLEXCAN2_TX	0x1b020
+		>;
+	};
+
+	pinctrl_gpio_leds: gpioledsgrp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_HSYNC__GPIO4_IO20		0x1b0b0
+			MX6UL_PAD_GPIO1_IO00__GPIO1_IO00	0x17059
+		>;
+	};
+
+	pinctrl_gpmi_nand: gpminandgrp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_CLE__RAWNAND_CLE		0xb0b1
+			MX6UL_PAD_NAND_ALE__RAWNAND_ALE		0xb0b1
+			MX6UL_PAD_NAND_WP_B__RAWNAND_WP_B	0xb0b1
+			MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B	0xb000
+			MX6UL_PAD_NAND_CE0_B__RAWNAND_CE0_B	0xb0b1
+			MX6UL_PAD_NAND_CE1_B__RAWNAND_CE1_B	0xb0b1
+			MX6UL_PAD_NAND_RE_B__RAWNAND_RE_B	0xb0b1
+			MX6UL_PAD_NAND_WE_B__RAWNAND_WE_B	0xb0b1
+			MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00	0xb0b1
+			MX6UL_PAD_NAND_DATA01__RAWNAND_DATA01	0xb0b1
+			MX6UL_PAD_NAND_DATA02__RAWNAND_DATA02	0xb0b1
+			MX6UL_PAD_NAND_DATA03__RAWNAND_DATA03	0xb0b1
+			MX6UL_PAD_NAND_DATA04__RAWNAND_DATA04	0xb0b1
+			MX6UL_PAD_NAND_DATA05__RAWNAND_DATA05	0xb0b1
+			MX6UL_PAD_NAND_DATA06__RAWNAND_DATA06	0xb0b1
+			MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07	0xb0b1
+		>;
+	};
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO03__OSC32K_32K_OUT    0x03029
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6UL_PAD_UART4_TX_DATA__I2C1_SCL	0x4001b8b0
+			MX6UL_PAD_UART4_RX_DATA__I2C1_SDA	0x4001b8b0
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX6UL_PAD_UART5_TX_DATA__I2C2_SCL	0x4001b8b0
+			MX6UL_PAD_UART5_RX_DATA__I2C2_SDA	0x4001b8b0
+		>;
+	};
+
+	pinctrl_lcdif: lcdif {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA02__LCDIF_DATA02	0x79
+			MX6UL_PAD_LCD_DATA03__LCDIF_DATA03	0x79
+			MX6UL_PAD_LCD_DATA04__LCDIF_DATA04	0x79
+			MX6UL_PAD_LCD_DATA05__LCDIF_DATA05	0x79
+			MX6UL_PAD_LCD_DATA06__LCDIF_DATA06	0x79
+			MX6UL_PAD_LCD_DATA07__LCDIF_DATA07	0x79
+			MX6UL_PAD_LCD_DATA10__LCDIF_DATA10	0x79
+			MX6UL_PAD_LCD_DATA11__LCDIF_DATA11	0x79
+			MX6UL_PAD_LCD_DATA12__LCDIF_DATA12	0x79
+			MX6UL_PAD_LCD_DATA13__LCDIF_DATA13	0x79
+			MX6UL_PAD_LCD_DATA14__LCDIF_DATA14	0x79
+			MX6UL_PAD_LCD_DATA15__LCDIF_DATA15	0x79
+			MX6UL_PAD_LCD_DATA18__LCDIF_DATA18	0x79
+			MX6UL_PAD_LCD_DATA19__LCDIF_DATA19	0x79
+			MX6UL_PAD_LCD_DATA20__LCDIF_DATA20	0x79
+			MX6UL_PAD_LCD_DATA21__LCDIF_DATA21	0x79
+			MX6UL_PAD_LCD_DATA22__LCDIF_DATA22	0x79
+			MX6UL_PAD_LCD_DATA23__LCDIF_DATA23	0x79
+			MX6UL_PAD_LCD_CLK__LCDIF_CLK		0x79
+			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE	0x79
+		>;
+	};
+
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA00__PWM1_OUT		0x110b0
+		>;
+	};
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_DATA05__SAI1_TX_BCLK	0x11088
+			MX6UL_PAD_CSI_DATA04__SAI1_TX_SYNC	0x17088
+			MX6UL_PAD_CSI_DATA06__SAI1_RX_DATA	0x11088
+			MX6UL_PAD_CSI_DATA07__SAI1_TX_DATA	0x11088
+		>;
+	};
+
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+			MX6UL_PAD_JTAG_TDI__SAI2_TX_BCLK	0x17088
+			MX6UL_PAD_JTAG_TDO__SAI2_TX_SYNC	0x17088
+			MX6UL_PAD_JTAG_TRST_B__SAI2_TX_DATA	0x11088
+			MX6UL_PAD_JTAG_TCK__SAI2_RX_DATA	0x11088
+			MX6UL_PAD_JTAG_TMS__SAI2_MCLK		0x17088
+		>;
+	};
+
+	pinctrl_tsc: tscgrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO01__GPIO1_IO01	0xb0
+			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02	0xb0
+			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03	0xb0
+			MX6UL_PAD_GPIO1_IO04__GPIO1_IO04	0xb0
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX	0x1b0b1
+			MX6UL_PAD_UART2_CTS_B__UART2_DCE_CTS	0x1b0b1
+			MX6UL_PAD_UART2_RTS_B__UART2_DCE_RTS	0x1b0b1
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX6UL_PAD_UART3_TX_DATA__UART3_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART3_RX_DATA__UART3_DCE_RX	0x1b0b1
+			MX6UL_PAD_UART3_CTS_B__UART3_DCE_CTS	0x1b0b1
+			MX6UL_PAD_UART3_RTS_B__UART3_DCE_RTS	0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x17059
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x17059
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x17059
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x17059
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059
+			MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170b9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100b9
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170b9
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170b9
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170b9
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
+			MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170f9
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100f9
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170f9
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170f9
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170f9
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170f9
+			MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x1b0b1
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO08__WDOG1_WDOG_B	0x78b0
+		>;
+	};
+};
-- 
2.7.4

