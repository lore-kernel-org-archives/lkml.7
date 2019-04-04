Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7C8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A9E20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388128AbfDDJTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:19:25 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33861 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387495AbfDDJTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:19:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id x14so1538236eds.1;
        Thu, 04 Apr 2019 02:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KKqmP1dIi1z1bm3PdUGDwVj69dWotf8/FaB1nHBpT88=;
        b=PPqcLuC6AswUYVU1HeU84tzYWZkgx7pm/vnz6RZoWzA8gMODCoO1zqkje8XxSoIWyI
         h+9l3PMC0RKyL58s0BVlo2tt/2zi+FuroA65wrcbv/SDZ+iC5jTDLUHV231RaSpPpZdr
         H9Zthg1eXNaSpT9Vr6xeUq4C3JorWxpaWQsi+nPdkt2TnX2cjYGJ1KN+knlKLZ6ak4Tx
         55/9gT1gMtS+PnrnI8EfqkgcNpgpzcCthHKzOOoJkqKuDFMvxKWxoTU3DTpNX4+O/xS2
         bwlBVqj2ifpHejOe3F4nVCZTe6WUcKbDbzIGka0GQBMXmZpKvbl7RN9cxuI6ijOIzSJk
         XZOQ==
X-Gm-Message-State: APjAAAUSDAm18YKzVdd2Qae420eGD1FmcG388jhDtOkpcqvviXmtJ6WO
        phvENPsKbO50DHE6GB8MHy5lfyQS
X-Google-Smtp-Source: APXvYqyhZfKzgYmgHLgLjj0ukhQaFzSH4ZmLTWAoiWc8VzymTqeNk/5h+VveJt6gNt2t+grL22RAyw==
X-Received: by 2002:a50:8283:: with SMTP id 3mr2916717edg.269.1554369560384;
        Thu, 04 Apr 2019 02:19:20 -0700 (PDT)
Received: from localhost ([46.140.72.82])
        by smtp.gmail.com with ESMTPSA id v35sm5565224edm.14.2019.04.04.02.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 02:19:19 -0700 (PDT)
From:   Igor Opaniuk <igor.opaniuk@toradex.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, marcel@ziswiler.com
Subject: [PATCH v1 1/1] ARM: dts: colibri: introduce dts with UHS-I support enabled
Date:   Thu,  4 Apr 2019 11:19:19 +0200
Message-Id: <20190404091919.30772-1-igor.opaniuk@toradex.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce DTS for Colibri iMX6DL with proper configuration for VGEN3,
which allows that rail to be automatically switched to 1.8 volts for
proper UHS-I operation mode.

Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
---
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts  | 245 +-----------------
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dtsi | 213 +++++++++++++++
 .../boot/dts/imx6dl-colibri-uhs-eval-v3.dts   |  29 +++
 arch/arm/boot/dts/imx6qdl-colibri.dtsi        |  36 ++-
 4 files changed, 278 insertions(+), 245 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-colibri-uhs-eval-v3.dts

diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
index 9a5d6c94cca4..14d7f359d8d6 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -1,258 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0 OR X11
 /*
- * Copyright 2014-2016 Toradex AG
- * Copyright 2012 Freescale Semiconductor, Inc.
- * Copyright 2011 Linaro Ltd.
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License
- *     version 2 as published by the Free Software Foundation.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
+ * Copyright 2019 Toradex AG
  */
 
 /dts-v1/;
 
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-#include "imx6dl.dtsi"
-#include "imx6qdl-colibri.dtsi"
+#include "imx6dl-colibri-eval-v3.dtsi"
 
 / {
 	model = "Toradex Colibri iMX6DL/S on Colibri Evaluation Board V3";
 	compatible = "toradex,colibri_imx6dl-eval-v3", "toradex,colibri_imx6dl",
 		     "fsl,imx6dl";
-
-	/* Will be filled by the bootloader */
-	memory@10000000 {
-		device_type = "memory";
-		reg = <0x10000000 0>;
-	};
-
-	aliases {
-		i2c0 = &i2c2;
-		i2c1 = &i2c3;
-	};
-
-	aliases {
-		rtc0 = &rtc_i2c;
-		rtc1 = &snvs_rtc;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	/* Fixed crystal dedicated to mcp251x */
-	clk16m: clock-16m {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <16000000>;
-		clock-output-names = "clk16m";
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_keys>;
-
-		wakeup {
-			label = "Wake-Up";
-			gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>; /* SODIMM 45 */
-			linux,code = <KEY_WAKEUP>;
-			debounce-interval = <10>;
-			wakeup-source;
-		};
-	};
-
-	lcd_display: disp0 {
-		compatible = "fsl,imx-parallel-display";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		interface-pix-fmt = "bgr666";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_ipu1_lcdif>;
-		status = "okay";
-
-		port@0 {
-			reg = <0>;
-
-			lcd_display_in: endpoint {
-				remote-endpoint = <&ipu1_di0_disp0>;
-			};
-		};
-
-		port@1 {
-			reg = <1>;
-
-			lcd_display_out: endpoint {
-				remote-endpoint = <&lcd_panel_in>;
-			};
-		};
-	};
-
-	panel: panel {
-		/*
-		 * edt,et057090dhu: EDT 5.7" LCD TFT
-		 * edt,et070080dh6: EDT 7.0" LCD TFT
-		 */
-		compatible = "edt,et057090dhu";
-		backlight = <&backlight>;
-
-		port {
-			lcd_panel_in: endpoint {
-				remote-endpoint = <&lcd_display_out>;
-			};
-		};
-	};
-};
-
-&backlight {
-	brightness-levels = <0 127 191 223 239 247 251 255>;
-	default-brightness-level = <1>;
-	status = "okay";
-};
-
-/* Colibri SSP */
-&ecspi4 {
-	status = "okay";
-
-	mcp251x0: mcp251x@0 {
-		compatible = "microchip,mcp2515";
-		reg = <0>;
-		clocks = <&clk16m>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <27 0x2>;
-		spi-max-frequency = <10000000>;
-		status = "okay";
-	};
-};
-
-&hdmi {
-	status = "okay";
-};
-
-/*
- * Colibri I2C: I2C3_SDA/SCL on SODIMM 194/196 (e.g. RTC on carrier board)
- */
-&i2c3 {
-	status = "okay";
-
-	/* M41T0M6 real time clock on carrier board */
-	rtc_i2c: rtc@68 {
-		compatible = "st,m41t0";
-		reg = <0x68>;
-	};
-};
-
-&ipu1_di0_disp0 {
-	remote-endpoint = <&lcd_display_in>;
-};
-
-&pwm1 {
-	status = "okay";
-};
-
-&pwm2 {
-	status = "okay";
-};
-
-&pwm3 {
-	status = "okay";
-};
-
-&pwm4 {
-	status = "okay";
-};
-
-&reg_usb_host_vbus {
-	status = "okay";
-};
-
-&uart1 {
-	status = "okay";
-};
-
-&uart2 {
-	status = "okay";
-};
-
-&uart3 {
-	status = "okay";
-};
-
-&usbh1 {
-	vbus-supply = <&reg_usb_host_vbus>;
-	status = "okay";
-};
-
-&usbotg {
-	status = "okay";
 };
 
 /* Colibri MMC */
 &usdhc1 {
 	status = "okay";
 };
-
-&weim {
-	status = "okay";
-
-	/* weim memory map: 32MB on CS0, CS1, CS2 and CS3 */
-	ranges = <0 0 0x08000000 0x02000000
-		  1 0 0x0a000000 0x02000000
-		  2 0 0x0c000000 0x02000000
-		  3 0 0x0e000000 0x02000000>;
-
-	/* SRAM on Colibri nEXT_CS0 */
-	sram@0,0 {
-		compatible = "cypress,cy7c1019dv33-10zsxi, mtd-ram";
-		reg = <0 0 0x00010000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		bank-width = <2>;
-		fsl,weim-cs-timing = <0x00010081 0x00000000 0x04000000
-				      0x00000000 0x04000040 0x00000000>;
-	};
-
-	/* SRAM on Colibri nEXT_CS1 */
-	sram@1,0 {
-		compatible = "cypress,cy7c1019dv33-10zsxi, mtd-ram";
-		reg = <1 0 0x00010000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		bank-width = <2>;
-		fsl,weim-cs-timing = <0x00010081 0x00000000 0x04000000
-				      0x00000000 0x04000040 0x00000000>;
-	};
-};
diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dtsi
new file mode 100644
index 000000000000..3e73fcaca057
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dtsi
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0 OR X11
+/*
+ * Copyright 2014-2016 Toradex AG
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "imx6dl.dtsi"
+#include "imx6qdl-colibri.dtsi"
+
+/ {
+	/* Will be filled by the bootloader */
+	memory@10000000 {
+		device_type = "memory";
+		reg = <0x10000000 0>;
+	};
+
+	aliases {
+		i2c0 = &i2c2;
+		i2c1 = &i2c3;
+	};
+
+	aliases {
+		rtc0 = &rtc_i2c;
+		rtc1 = &snvs_rtc;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	/* Fixed crystal dedicated to mcp251x */
+	clk16m: clock-16m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <16000000>;
+		clock-output-names = "clk16m";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		wakeup {
+			label = "Wake-Up";
+			gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>; /* SODIMM 45 */
+			linux,code = <KEY_WAKEUP>;
+			debounce-interval = <10>;
+			wakeup-source;
+		};
+	};
+
+	lcd_display: disp0 {
+		compatible = "fsl,imx-parallel-display";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interface-pix-fmt = "bgr666";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu1_lcdif>;
+		status = "okay";
+
+		port@0 {
+			reg = <0>;
+
+			lcd_display_in: endpoint {
+				remote-endpoint = <&ipu1_di0_disp0>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			lcd_display_out: endpoint {
+				remote-endpoint = <&lcd_panel_in>;
+			};
+		};
+	};
+
+	panel: panel {
+		/*
+		 * edt,et057090dhu: EDT 5.7" LCD TFT
+		 * edt,et070080dh6: EDT 7.0" LCD TFT
+		 */
+		compatible = "edt,et057090dhu";
+		backlight = <&backlight>;
+
+		port {
+			lcd_panel_in: endpoint {
+				remote-endpoint = <&lcd_display_out>;
+			};
+		};
+	};
+};
+
+&backlight {
+	brightness-levels = <0 127 191 223 239 247 251 255>;
+	default-brightness-level = <1>;
+	status = "okay";
+};
+
+/* Colibri SSP */
+&ecspi4 {
+	status = "okay";
+
+	mcp251x0: mcp251x@0 {
+		compatible = "microchip,mcp2515";
+		reg = <0>;
+		clocks = <&clk16m>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <27 0x2>;
+		spi-max-frequency = <10000000>;
+		status = "okay";
+	};
+};
+
+&hdmi {
+	status = "okay";
+};
+
+/*
+ * Colibri I2C: I2C3_SDA/SCL on SODIMM 194/196 (e.g. RTC on carrier board)
+ */
+&i2c3 {
+	status = "okay";
+
+	/* M41T0M6 real time clock on carrier board */
+	rtc_i2c: rtc@68 {
+		compatible = "st,m41t0";
+		reg = <0x68>;
+	};
+};
+
+&ipu1_di0_disp0 {
+	remote-endpoint = <&lcd_display_in>;
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+&pwm3 {
+	status = "okay";
+};
+
+&pwm4 {
+	status = "okay";
+};
+
+&reg_usb_host_vbus {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&usbh1 {
+	vbus-supply = <&reg_usb_host_vbus>;
+	status = "okay";
+};
+
+&usbotg {
+	status = "okay";
+};
+
+&weim {
+	status = "okay";
+
+	/* weim memory map: 32MB on CS0, CS1, CS2 and CS3 */
+	ranges = <0 0 0x08000000 0x02000000
+		  1 0 0x0a000000 0x02000000
+		  2 0 0x0c000000 0x02000000
+		  3 0 0x0e000000 0x02000000>;
+
+	/* SRAM on Colibri nEXT_CS0 */
+	sram@0,0 {
+		compatible = "cypress,cy7c1019dv33-10zsxi, mtd-ram";
+		reg = <0 0 0x00010000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		bank-width = <2>;
+		fsl,weim-cs-timing = <0x00010081 0x00000000 0x04000000
+				      0x00000000 0x04000040 0x00000000>;
+	};
+
+	/* SRAM on Colibri nEXT_CS1 */
+	sram@1,0 {
+		compatible = "cypress,cy7c1019dv33-10zsxi, mtd-ram";
+		reg = <1 0 0x00010000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		bank-width = <2>;
+		fsl,weim-cs-timing = <0x00010081 0x00000000 0x04000000
+				      0x00000000 0x04000040 0x00000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6dl-colibri-uhs-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-uhs-eval-v3.dts
new file mode 100644
index 000000000000..9a18b5c70752
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-colibri-uhs-eval-v3.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0 OR X11
+/*
+ * Copyright 2019 Toradex AG
+ */
+
+/dts-v1/;
+
+#include "imx6dl-colibri-eval-v3.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX6DL/S on Colibri Ev. Board V3 with UHS-I";
+	compatible = "toradex,colibri_imx6dl-eval-v3", "toradex,colibri_imx6dl",
+		     "fsl,imx6dl";
+};
+
+/* Colibri MMC with UHS-I support*/
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_mmc_cd>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz &pinctrl_mmc_cd>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz &pinctrl_mmc_cd>;
+	vqmmc-supply = <&vgen3_reg>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+	/delete-property/no-1-8-v;
+};
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 1beac22266ed..8eed89634a45 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -215,7 +215,12 @@
 				regulator-always-on;
 			};
 
-			/* vgen3: unused */
+			vgen3_reg: vgen3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
 
 			vgen4_reg: vgen4 {
 				regulator-min-microvolt = <1800000>;
@@ -385,12 +390,15 @@
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_mmc_cd>;
+	no-1-8-v;
 	cd-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>; /* MMCD */
 	disable-wp;
-	vqmmc-supply = <&reg_module_3v3>;
+	enable-sdio-wakeup;
+	keep-power-in-suspend;
 	bus-width = <4>;
-	no-1-8-v;
 	status = "disabled";
+	cap-sd-highspeed;
+	vmmc-supply = <&reg_module_3v3>;
 };
 
 /* eMMC */
@@ -698,6 +706,28 @@
 		>;
 	};
 
+	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x170b1
+			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x100b1
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x170b1
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x170b1
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x170b1
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x170b1
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x170f1
+			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x100f1
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x170f1
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x170f1
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x170f1
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x170f1
+		>;
+	};
+
 	pinctrl_weim_cs0: weimcs0grp {
 		fsl,pins = <
 			/* nEXT_CS0 */
-- 
2.17.1

