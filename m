Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5973C742BD
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9685621019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562940787;
	bh=qu9QTYz+oCRm3BaJ7/QciYosNfSS1u2ie+y28EK2MwQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=wcNEGNAVaJkzZ2fN0RlLx1J/dO+r/Kjd1CJ1w/H/MVSpbRU+ejoN3bqILxUD8O7jX
	 Ng52Dwm1/VOS/+b+pkt05Dg47AtdEajRaHFKYkea2TOkFC4+oJhvI5Ccp2qEDc9fID
	 8Um7eus3SuHGrx1Le3q9+sKCPnpi1RF/9kwhvwE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfGLONG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 10:13:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbfGLONF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 10:13:05 -0400
Received: from localhost.localdomain (unknown [194.230.155.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84A83206B8;
        Fri, 12 Jul 2019 14:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562940783;
        bh=qu9QTYz+oCRm3BaJ7/QciYosNfSS1u2ie+y28EK2MwQ=;
        h=From:To:Cc:Subject:Date:From;
        b=HrIF/iVAgbCF1LTe7FuQttaR4F8qZ0bsVu8Ra5ZBThwKE+HJ7TMfC0llhVaj73m6B
         zcY33C4A4woikkQkgy3ZjFxTIOIMe5lM/VexSswTuKkYgea9Hh7grsSih25DFXMUym
         FjVbWkde59lfYUsf558Nty91yeC8dvhOZgU9tsdI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     frieder.schrempf@kontron.de, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] ARM: dts: imx6ul-kontron-ul2: Add Exceet/Kontron iMX6-UL2 SoM
Date:   Fri, 12 Jul 2019 16:12:42 +0200
Message-Id: <20190712141242.4915-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for iMX6-UL2 modules from Kontron Electronics GmbH (before
acquisition: Exceet Electronics) and evalkit boards based on it:

1. i.MX6 UL System-on-Module, a 25x25 mm solderable module (LGA pads and
   pin castellations) with 256 MB RAM, 1 MB NOR-Flash, 256 MB NAND and
   other interfaces,
1. UL2 evalkit, w/wo eMMC, without display,
2. UL2 evalkit with 4.3" display,
3. UL2 evalkit with 5.0" display.

This includes device nodes for unsupported displays (Admatec
T043C004800272T2A and T070P133T0S301).

The work is based on Exceet source code (GPLv2) with numerous changes:
1. Reorganize files,
2. Rename Exceet -> Kontron,
3. Fix coding style errors,
4. Fix DTC warnings,
5. Extend compatibles so eval boards inherit the SoM compatible,
6. Use defines instead of GPIO flag values,
7. Adjust operating points of CPU0,
8. Sort nodes alphabetically.

In downstream BSP the Exceet name still appears in multiple places
therefore I left it in the model names.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/Makefile                    |   3 +
 arch/arm/boot/dts/imx6ul-kontron-ul2-43.dts   | 123 +++++
 arch/arm/boot/dts/imx6ul-kontron-ul2-50.dts   | 123 +++++
 arch/arm/boot/dts/imx6ul-kontron-ul2-som.dtsi | 152 ++++++
 arch/arm/boot/dts/imx6ul-kontron-ul2.dts      | 435 ++++++++++++++++++
 5 files changed, 836 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-kontron-ul2-43.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-kontron-ul2-50.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-kontron-ul2-som.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-kontron-ul2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9159fa2cea90..3431bb44fb5d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -569,6 +569,9 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-geam.dtb \
 	imx6ul-isiot-emmc.dtb \
 	imx6ul-isiot-nand.dtb \
+	imx6ul-kontron-ul2.dtb \
+	imx6ul-kontron-ul2-43.dtb \
+	imx6ul-kontron-ul2-50.dtb \
 	imx6ul-liteboard.dtb \
 	imx6ul-opos6uldev.dtb \
 	imx6ul-pico-hobbit.dtb \
diff --git a/arch/arm/boot/dts/imx6ul-kontron-ul2-43.dts b/arch/arm/boot/dts/imx6ul-kontron-ul2-43.dts
new file mode 100644
index 000000000000..a2b68ba14765
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-kontron-ul2-43.dts
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 exceet electronics GmbH
+ * Copyright (c) 2019 Krzysztof Kozlowski <krzk@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "imx6ul-kontron-ul2.dts"
+
+/ {
+	model = "Exceet/Kontron iMX6 UL-2 S 43";
+	compatible = "kontron,imx6ul-ul2-s-43", "kontron,imx6ul-ul2-s",
+		     "kontron,imx6ul-ul2-som", "fsl,imx6ul";
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm7 0 5000000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+		status = "okay";
+	};
+
+	panel {
+		compatible = "admatec,t043c004800272t2a";
+		backlight = <&backlight>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&display_out>;
+			};
+		};
+	};
+};
+
+&i2c4 {
+	gt911@5d {
+		compatible = "goodix,gt928";
+		reg = <0x5d>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_cap_touch>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <6 8>;
+		reset-gpios = <&gpio5 8 GPIO_ACTIVE_HIGH>;
+		irq-gpios = <&gpio5 6 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&iomuxc {
+	pinctrl_lcdif_dat: lcdifdatgrp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA00__LCDIF_DATA00	0x79
+			MX6UL_PAD_LCD_DATA01__LCDIF_DATA01	0x79
+			MX6UL_PAD_LCD_DATA02__LCDIF_DATA02	0x79
+			MX6UL_PAD_LCD_DATA03__LCDIF_DATA03	0x79
+			MX6UL_PAD_LCD_DATA04__LCDIF_DATA04	0x79
+			MX6UL_PAD_LCD_DATA05__LCDIF_DATA05	0x79
+			MX6UL_PAD_LCD_DATA06__LCDIF_DATA06	0x79
+			MX6UL_PAD_LCD_DATA07__LCDIF_DATA07	0x79
+			MX6UL_PAD_LCD_DATA08__LCDIF_DATA08	0x79
+			MX6UL_PAD_LCD_DATA09__LCDIF_DATA09	0x79
+			MX6UL_PAD_LCD_DATA10__LCDIF_DATA10	0x79
+			MX6UL_PAD_LCD_DATA11__LCDIF_DATA11	0x79
+			MX6UL_PAD_LCD_DATA12__LCDIF_DATA12	0x79
+			MX6UL_PAD_LCD_DATA13__LCDIF_DATA13	0x79
+			MX6UL_PAD_LCD_DATA14__LCDIF_DATA14	0x79
+			MX6UL_PAD_LCD_DATA15__LCDIF_DATA15	0x79
+			MX6UL_PAD_LCD_DATA16__LCDIF_DATA16	0x79
+			MX6UL_PAD_LCD_DATA17__LCDIF_DATA17	0x79
+			MX6UL_PAD_LCD_DATA18__LCDIF_DATA18	0x79
+			MX6UL_PAD_LCD_DATA19__LCDIF_DATA19	0x79
+			MX6UL_PAD_LCD_DATA20__LCDIF_DATA20	0x79
+			MX6UL_PAD_LCD_DATA21__LCDIF_DATA21	0x79
+			MX6UL_PAD_LCD_DATA22__LCDIF_DATA22	0x79
+			MX6UL_PAD_LCD_DATA23__LCDIF_DATA23	0x79
+		>;
+	};
+
+	pinctrl_lcdif_ctrl: lcdifctrlgrp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_CLK__LCDIF_CLK		0x79
+			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE	0x79
+			MX6UL_PAD_LCD_HSYNC__LCDIF_HSYNC	0x79
+			MX6UL_PAD_LCD_VSYNC__LCDIF_VSYNC	0x79
+			MX6UL_PAD_LCD_RESET__LCDIF_RESET	0x79
+		>;
+	};
+
+	pinctrl_cap_touch: captouchgrp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x1b0b0 /* Touch Interrupt */
+			MX6UL_PAD_SNVS_TAMPER7__GPIO5_IO07	0x1b0b0 /* Touch Reset */
+			MX6UL_PAD_SNVS_TAMPER8__GPIO5_IO08	0x1b0b0 /* Touch Wake */
+		>;
+	};
+
+	pinctrl_pwm7: pwm7grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_VSYNC__PWM7_OUT		0x110b0
+		>;
+	};
+};
+
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcdif_dat
+		     &pinctrl_lcdif_ctrl>;
+	status = "okay";
+
+	port {
+		display_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
+};
+
+&pwm7 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm7>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6ul-kontron-ul2-50.dts b/arch/arm/boot/dts/imx6ul-kontron-ul2-50.dts
new file mode 100644
index 000000000000..61017020e02f
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-kontron-ul2-50.dts
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 exceet electronics GmbH
+ * Copyright (c) 2019 Krzysztof Kozlowski <krzk@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "imx6ul-kontron-ul2.dts"
+
+/ {
+	model = "Exceet/Kontron iMX6 UL-2 S 50";
+	compatible = "kontron,imx6ul-ul2-s-50", "kontron,imx6ul-ul2-s",
+		     "kontron,imx6ul-ul2-som", "fsl,imx6ul";
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm7 0 5000000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+		status = "okay";
+	};
+
+	panel {
+		compatible = "admatec,t070p133t0s301";
+		backlight = <&backlight>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&display_out>;
+			};
+		};
+	};
+};
+
+&i2c4 {
+	gt911@5d {
+		compatible = "goodix,gt928";
+		reg = <0x5d>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_cap_touch>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <6 8>;
+		reset-gpios = <&gpio5 8 GPIO_ACTIVE_HIGH>;
+		irq-gpios = <&gpio5 6 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&iomuxc {
+	pinctrl_lcdif_dat: lcdifdatgrp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_DATA00__LCDIF_DATA00	0x79
+			MX6UL_PAD_LCD_DATA01__LCDIF_DATA01	0x79
+			MX6UL_PAD_LCD_DATA02__LCDIF_DATA02	0x79
+			MX6UL_PAD_LCD_DATA03__LCDIF_DATA03	0x79
+			MX6UL_PAD_LCD_DATA04__LCDIF_DATA04	0x79
+			MX6UL_PAD_LCD_DATA05__LCDIF_DATA05	0x79
+			MX6UL_PAD_LCD_DATA06__LCDIF_DATA06	0x79
+			MX6UL_PAD_LCD_DATA07__LCDIF_DATA07	0x79
+			MX6UL_PAD_LCD_DATA08__LCDIF_DATA08	0x79
+			MX6UL_PAD_LCD_DATA09__LCDIF_DATA09	0x79
+			MX6UL_PAD_LCD_DATA10__LCDIF_DATA10	0x79
+			MX6UL_PAD_LCD_DATA11__LCDIF_DATA11	0x79
+			MX6UL_PAD_LCD_DATA12__LCDIF_DATA12	0x79
+			MX6UL_PAD_LCD_DATA13__LCDIF_DATA13	0x79
+			MX6UL_PAD_LCD_DATA14__LCDIF_DATA14	0x79
+			MX6UL_PAD_LCD_DATA15__LCDIF_DATA15	0x79
+			MX6UL_PAD_LCD_DATA16__LCDIF_DATA16	0x79
+			MX6UL_PAD_LCD_DATA17__LCDIF_DATA17	0x79
+			MX6UL_PAD_LCD_DATA18__LCDIF_DATA18	0x79
+			MX6UL_PAD_LCD_DATA19__LCDIF_DATA19	0x79
+			MX6UL_PAD_LCD_DATA20__LCDIF_DATA20	0x79
+			MX6UL_PAD_LCD_DATA21__LCDIF_DATA21	0x79
+			MX6UL_PAD_LCD_DATA22__LCDIF_DATA22	0x79
+			MX6UL_PAD_LCD_DATA23__LCDIF_DATA23	0x79
+		>;
+	};
+
+	pinctrl_lcdif_ctrl: lcdifctrlgrp {
+		fsl,pins = <
+			MX6UL_PAD_LCD_CLK__LCDIF_CLK		0x79
+			MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE	0x79
+			MX6UL_PAD_LCD_HSYNC__LCDIF_HSYNC	0x79
+			MX6UL_PAD_LCD_VSYNC__LCDIF_VSYNC	0x79
+			MX6UL_PAD_LCD_RESET__LCDIF_RESET	0x79
+		>;
+	};
+
+	pinctrl_cap_touch: captouchgrp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER6__GPIO5_IO06	0x1b0b0 /* Touch Interrupt */
+			MX6UL_PAD_SNVS_TAMPER7__GPIO5_IO07	0x1b0b0 /* Touch Reset */
+			MX6UL_PAD_SNVS_TAMPER8__GPIO5_IO08	0x1b0b0 /* Touch Wake */
+		>;
+	};
+
+	pinctrl_pwm7: pwm7grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_VSYNC__PWM7_OUT		0x110b0
+		>;
+	};
+};
+
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcdif_dat
+		     &pinctrl_lcdif_ctrl>;
+	status = "okay";
+
+	port {
+		display_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
+};
+
+&pwm7 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm7>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6ul-kontron-ul2-som.dtsi b/arch/arm/boot/dts/imx6ul-kontron-ul2-som.dtsi
new file mode 100644
index 000000000000..26b6615cf839
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-kontron-ul2-som.dtsi
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 exceet electronics GmbH
+ * Copyright (c) 2019 Krzysztof Kozlowski <krzk@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "imx6ul.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Exceet/Kontron iMX6 UL-2 SOM";
+	compatible = "kontron,imx6ul-ul2-som", "fsl,imx6ul";
+
+	memory@80000000 {
+		reg = <0x80000000 0x10000000>;
+	};
+};
+
+&cpu0 {
+	clock-frequency = <528000000>;
+	operating-points = <
+		/* kHz	uV */
+		528000	1175000
+		396000	1025000
+		198000	950000
+	>;
+	fsl,soc-operating-points = <
+		/* KHz	uV */
+		528000	1175000
+		396000	1175000
+		198000	1175000
+	>;
+};
+
+&ecspi2 {
+	cs-gpios = <&gpio4 22 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	status = "okay";
+
+	flash: mx25v80@0 {
+		compatible = "macronix,mx25v8035f", "jedec,spi-nor";
+		spi-max-frequency = <50000000>;
+		reg = <0>;
+	};
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1 &pinctrl_enet1_mdio>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy1>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy1: ethernet-phy@1 {
+			reg = <1>;
+			micrel,led-mode = <0>;
+			clocks = <&clks IMX6UL_CLK_ENET_REF>;
+			clock-names = "rmii-ref";
+		};
+	};
+};
+
+&fec2 {
+	phy-mode = "rmii";
+	status = "disabled";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_reset_out>;
+
+	pinctrl_reset_out: rstoutgrp {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER9__GPIO5_IO09      0x1b0b0
+		>;
+	};
+
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_DATA03__ECSPI2_MISO      0x100b1
+			MX6UL_PAD_CSI_DATA02__ECSPI2_MOSI      0x100b1
+			MX6UL_PAD_CSI_DATA00__ECSPI2_SCLK      0x100b1
+			MX6UL_PAD_CSI_DATA01__GPIO4_IO22       0x100b1
+		>;
+	};
+
+	pinctrl_enet1: enet1grp {
+		fsl,pins = <
+			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN      0x1b0b0
+			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER      0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00 0x1b0b0
+			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01 0x1b0b0
+			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN      0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00 0x1b0b0
+			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01 0x1b0b0
+			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1  0x4001b009
+		>;
+	};
+
+	pinctrl_enet1_mdio: enet1mdiogrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO07__ENET1_MDC         0x1b0b0
+			MX6UL_PAD_GPIO1_IO06__ENET1_MDIO        0x1b0b0
+		>;
+	};
+
+	pinctrl_qspi: qspigrp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_WP_B__QSPI_A_SCLK        0x70a1
+			MX6UL_PAD_NAND_READY_B__QSPI_A_DATA00   0x70a1
+			MX6UL_PAD_NAND_CE0_B__QSPI_A_DATA01     0x70a1
+			MX6UL_PAD_NAND_CE1_B__QSPI_A_DATA02     0x70a1
+			MX6UL_PAD_NAND_CLE__QSPI_A_DATA03       0x70a1
+			MX6UL_PAD_NAND_DQS__QSPI_A_SS0_B        0x70a1
+		>;
+	};
+};
+
+&qspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi>;
+	status = "okay";
+
+	flash0: w25m02gv@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spi-nand";
+		spi-max-frequency = <108000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+		reg = <0>;
+
+		partition@0 {
+			label = "ubi1";
+			reg = <0x00000000 0x08000000>;
+		};
+
+		partition@8000000 {
+			label = "ubi2";
+			reg = <0x08000000 0x08000000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx6ul-kontron-ul2.dts b/arch/arm/boot/dts/imx6ul-kontron-ul2.dts
new file mode 100644
index 000000000000..6d394a97712b
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-kontron-ul2.dts
@@ -0,0 +1,435 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 exceet electronics GmbH
+ * Copyright (c) 2019 Krzysztof Kozlowski <krzk@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/dts-v1/;
+
+#include "imx6ul-kontron-ul2-som.dtsi"
+
+/ {
+	model = "Exceet/Kontron iMX6 UL-2 S";
+	compatible = "kontron,imx6ul-ul2-s", "kontron,imx6ul-ul2-som",
+		     "fsl,imx6ul";
+
+	pwm-beeper {
+		compatible = "pwm-beeper";
+		pwms = <&pwm8 0 5000>;
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		led1 {
+			label = "debug-led1";
+			gpios = <&gpio1 30 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+			linux,default-trigger = "heartbeat";
+		};
+
+		led2 {
+			label = "debug-led2";
+			gpios = <&gpio5 3 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led3 {
+			label = "debug-led3";
+			gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_3v3: regulator@0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "3v3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		reg_vref_adc: regulator@1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "vref-adc";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		reg_usb_otg1_vbus: regulator@2 {
+			compatible = "regulator-fixed";
+			reg = <2>;
+			regulator-name = "usb_otg1_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio1 4 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
+	};
+
+};
+
+&adc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc1>;
+	num-channels = <3>;
+	vref-supply = <&reg_vref_adc>;
+	status = "okay";
+};
+
+&can2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	status = "okay";
+};
+
+&ecspi1 {
+	fsl,spi-num-chipselects = <1>;
+	cs-gpios = <&gpio4 26 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	status = "okay";
+
+	fram@0 {
+		compatible = "atmel,at25";
+		reg = <0>;
+		spi-max-frequency = <20000000>;
+		spi-cpha;
+		spi-cpol;
+		pagesize = <1>;
+		size = <8192>;
+		address-width = <16>;
+	};
+};
+
+&fec1 {
+	pinctrl-0 = <&pinctrl_enet1>;
+	/delete-node/ mdio;
+};
+
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet2 &pinctrl_enet2_mdio>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy2>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy1: ethernet-phy@1 {
+			reg = <1>;
+			micrel,led-mode = <0>;
+			clocks = <&clks IMX6UL_CLK_ENET_REF>;
+			clock-names = "rmii-ref";
+		};
+
+		ethphy2: ethernet-phy@2 {
+			reg = <2>;
+			micrel,led-mode = <0>;
+			clocks = <&clks IMX6UL_CLK_ENET2_REF>;
+			clock-names = "rmii-ref";
+		};
+	};
+};
+
+&i2c1 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+};
+
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	status = "okay";
+
+	rtc@32 {
+		compatible = "epson,rx8900";
+		reg = <0x32>;
+	};
+};
+
+&iomuxc {
+	pinctrl-0 = <&pinctrl_reset_out &pinctrl_gpio>;
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO09__WDOG1_WDOG_ANY	0x30b0
+		>;
+	};
+
+	pinctrl_gpio: gpio {
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER5__GPIO5_IO05	0x1b0b0 /* DOUT1 */
+			MX6UL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0 /* DIN1 */
+			MX6UL_PAD_SNVS_TAMPER1__GPIO5_IO01	0x1b0b0 /* DOUT2 */
+			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0b0 /* DIN2 */
+		>;
+	};
+
+	pinctrl_usbotg1: usbotg1 {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO04__GPIO1_IO04	0x1b0b0
+		>;
+	};
+
+	pinctrl_gpio_leds: gpio_leds {
+		fsl,pins = <
+			MX6UL_PAD_UART5_TX_DATA__GPIO1_IO30	0x1b0b0	/* LED H14 */
+			MX6UL_PAD_SNVS_TAMPER3__GPIO5_IO03	0x1b0b0	/* LED H15 */
+			MX6UL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x1b0b0	/* LED H16 */
+		>;
+	};
+
+	/* FRAM */
+	pinctrl_ecspi1: ecspi1grp-1 {
+		fsl,pins = <
+			MX6UL_PAD_CSI_DATA07__ECSPI1_MISO	0x100b1
+			MX6UL_PAD_CSI_DATA06__ECSPI1_MOSI	0x100b1
+			MX6UL_PAD_CSI_DATA04__ECSPI1_SCLK	0x100b1
+			MX6UL_PAD_CSI_DATA05__GPIO4_IO26	0x100b1	/* ECSPI1-CS1 */
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
+			MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b009
+		>;
+	};
+
+	pinctrl_enet2_mdio: enet2mdiogrp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO07__ENET2_MDC         0x1b0b0
+			MX6UL_PAD_GPIO1_IO06__ENET2_MDIO        0x1b0b0
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
+	pinctrl_pwm8: pwm8grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_HSYNC__PWM8_OUT		0x110b0
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
+			MX6UL_PAD_NAND_DATA04__UART2_DCE_TX	0x1b0b1
+			MX6UL_PAD_NAND_DATA05__UART2_DCE_RX	0x1b0b1
+			MX6UL_PAD_NAND_DATA06__UART2_DCE_CTS	0x1b0b1
+			/*
+			 * mux unused RTS to make sure it doesn't cause
+			 * any interrupts when it is undefined
+			 */
+			MX6UL_PAD_NAND_DATA07__UART2_DCE_RTS	0x1b0b1
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
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX6UL_PAD_UART4_TX_DATA__UART4_DCE_TX	0x1b0b1
+			MX6UL_PAD_UART4_RX_DATA__UART4_DCE_RX	0x1b0b1
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059
+			MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x10059
+			MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x17059
+			MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x17059
+			MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x17059
+			MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059
+			MX6UL_PAD_UART1_RTS_B__GPIO1_IO19	0x100b1	/* SD1_CD */
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x10059
+			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x17059
+			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x17059
+			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x17059
+			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x17059
+			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x17059
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+		fsl,pins = <
+			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100b9
+			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170b9
+			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x170b9
+			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x170b9
+			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x170b9
+			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170b9
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+		fsl,pins = <
+			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100f9
+			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170f9
+			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x170f9
+			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x170f9
+			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x170f9
+			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170f9
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_PIXCLK__I2C1_SCL		0x4001b8b0
+			MX6UL_PAD_CSI_MCLK__I2C1_SDA		0x4001b8b0
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX6UL_PAD_UART2_TX_DATA__I2C4_SCL	0x4001f8b0
+			MX6UL_PAD_UART2_RX_DATA__I2C4_SDA	0x4001f8b0
+		>;
+	};
+
+	pinctrl_adc1: adc1grp {
+		fsl,pins = <
+			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02	0xb0
+			MX6UL_PAD_GPIO1_IO03__GPIO1_IO03	0xb0
+			MX6UL_PAD_GPIO1_IO08__GPIO1_IO08	0xb0
+		>;
+	};
+};
+
+&pwm8 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm8>;
+	status = "okay";
+};
+
+&snvs_poweroff {
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	linux,rs485-enabled-at-boot-time;
+	rs485-rx-during-tx;
+	rs485-rts-active-low;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>;
+	status = "okay";
+};
+
+&usbotg1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg1>;
+	dr_mode = "otg";
+	status = "okay";
+	srp-disable;
+	hnp-disable;
+	adp-disable;
+	vbus-supply = <&reg_usb_otg1_vbus>;
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	cd-gpios = <&gpio1 19 GPIO_ACTIVE_LOW>;
+	keep-power-in-suspend;
+	enable-sdio-wakeup;
+	vmmc-supply = <&reg_3v3>;
+	voltage-ranges = <3300 3300>;
+	no-1-8-v;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
+	tuning-step = <2>;
+	non-removable;
+	keep-power-in-suspend;
+	enable-sdio-wakeup;
+	vmmc-supply = <&reg_3v3>;
+	voltage-ranges = <3300 3300>;
+	no-1-8-v;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	status = "okay";
+	fsl,ext-reset-output;
+};
-- 
2.17.1

