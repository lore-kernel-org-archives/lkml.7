Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB6EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDD120811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbfDXM3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:29:04 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.4]:43795 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbfDXM3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:29:03 -0400
Received: from [67.219.250.102] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.us-west-2.aws.symcld.net id 72/72-25145-98650CC5; Wed, 24 Apr 2019 12:28:57 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRWlGSWpSXmKPExsWSLveKVbcz7EC
  Mwcn50ha7LnNYzNj7gNli/pFzrBa/z/9lttj0+BqrRfPqc8wWl3fNYbNYev0ik8WplhcsFq17
  j7Bb7D2wkcWB2+Nq+y52jzXz1jB6LNhU6nHx4zFmj02rOtk8Ni+p9zg/YyGjx+dNcgEcUayZe
  Un5FQmsGV27r7MWvGtmrOi5/YWpgfFmVhcjF4eQQAeTxLwLbWwQznxGiV3t91m7GDk52ATUJE
  7OvscKkhAR+Mgo8f/kHbAqZoFJjBINX64wg1QJC9hKrFwymRHEZhFQldj/7AU7iM0r4CzxonM
  aG4gtISAncfNcJ/MERs4FjAyrGC2SijLTM0pyEzNzdA0NDHQNDY10DY1BtLleYpVuol5psW55
  anGJrpFeYnmxXnFlbnJOil5easkmRmDgpRQ0le5gvLI8/RCjJAeTkihvueyBGCG+pPyUyozE4
  oz4otKc1OJDjDIcHEoSvIWhQDnBotT01Iq0zBxgDMCkJTh4lER41YBxIMRbXJCYW5yZDpE6xa
  goJc6rDpIQAElklObBtcHi7hKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYlYV5NkO08mXklcNN
  fAS1mAlpcbwG2uCQRISXVwDh90mm2/sAlt1fGVa/Z8t6sJ5PRwkajYs+Xq/zOZy6/ZVMzbwrv
  N7dPmZnX8mmVYEaKZ8OVluvlh/1via7VqJM6WfmfbYd23b1LETOeRD/8oVdjx9+88uXDS/MlX
  dwfNWixOsVOXS6nqNqzVvzjBc5PiotVKu7UlqlMe29664b8yQObox6o7lZiKc5INNRiLipOBA
  CyqIgXtgIAAA==
X-Env-Sender: pengms1@lenovo.com
X-Msg-Ref: server-8.tower-326.messagelabs.com!1556108934!6509030!1
X-Originating-IP: [103.30.234.5]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1439 invoked from network); 24 Apr 2019 12:28:56 -0000
Received: from unknown (HELO apsmtp.lenovo.com) (103.30.234.5)
  by server-8.tower-326.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 24 Apr 2019 12:28:56 -0000
Received: from smtpinternal.lenovo.com (unknown [10.96.80.15])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id AA8E61E7882F9BF9AB4E;
        Wed, 24 Apr 2019 20:28:53 +0800 (CST)
Received: from localhost.localdomain (unknown [10.245.100.154])
        by Forcepoint Email with ESMTP id 436762F6EFDD8296EDDD;
        Wed, 24 Apr 2019 20:28:53 +0800 (CST)
From:   Andrew Peng <pengms1@lenovo.com>
To:     venture@google.com, benjaminfair@google.com,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        andrew@aj.id.au, mark.rutland@arm.com, robh+dt@kernel.org
Cc:     pengms1@lenovo.com, liuyj19@lenovo.com, dukh@lenovo.com,
        liuyh21@lenovo.com, hsung1@lenovo.com, joel@jms.id.au,
        openbmc@lists.ozlabs.org
Subject: [PATCH v3] ARM: dts: aspeed: Adding Lenovo Hr630 BMC
Date:   Wed, 24 Apr 2019 20:28:46 +0800
Message-Id: <1556108926-233682-1-git-send-email-pengms1@lenovo.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial introduction of Lenovo Hr630 family equipped with
Aspeed 2500 BMC SoC. Hr630 is a x86 server development kit
with a ASPEED ast2500 BMC manufactured by Lenovo.
Specifically, This adds the Hr630 platform device tree file
used by the Hr630 BMC machines.

This also adds an entry of Hr630 device tree file in Makefile

Signed-off-by: Andrew Peng <pengms1@lenovo.com>
Signed-off-by: Yonghui Liu <liuyh21@lenovo.com>
Signed-off-by: Lisa Liu <liuyj19@lenovo.com>
---
Changes in v3:
 - revise i2c switch aliases name.
Changes in v2:
 - add i2c switch aliases name.
 - remove the unused eeprom device from DT file.
 - remove "Licensed under..." sentence.

 arch/arm/boot/dts/Makefile                    |   3 +-
 arch/arm/boot/dts/aspeed-bmc-lenovo-hr630.dts | 886 ++++++++++++++++++++++++++
 2 files changed, 888 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-lenovo-hr630.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f4f5aea..375e53b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1261,4 +1261,5 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-opp-witherspoon.dtb \
 	aspeed-bmc-opp-zaius.dtb \
 	aspeed-bmc-portwell-neptune.dtb \
-	aspeed-bmc-quanta-q71l.dtb
+	aspeed-bmc-quanta-q71l.dtb \
+	aspeed-bmc-lenovo-hr630.dtb
diff --git a/arch/arm/boot/dts/aspeed-bmc-lenovo-hr630.dts b/arch/arm/boot/dts/aspeed-bmc-lenovo-hr630.dts
new file mode 100644
index 0000000..5c45523
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-lenovo-hr630.dts
@@ -0,0 +1,886 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Device Tree file for Lenovo Hr630 platform
+ *
+ * Copyright (C) 2019-present Lenovo
+ */
+
+/dts-v1/;
+
+#include "aspeed-g5.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "HR630 BMC";
+	compatible = "lenovo,hr630-bmc", "aspeed,ast2500";
+
+	aliases {
+		pca9545_i2c0 = &i2c_rbp;
+		pca9545_i2c1 = &i2c_fbp1;
+		pca9545_i2c2 = &i2c_fbp2;
+		pca9545_i2c3 = &i2c_fbp3;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=tty0 console=ttyS4,115200 earlyprintk";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		flash_memory: region@98000000 {
+			no-map;
+			reg = <0x98000000 0x00100000>; /* 1M */
+		};
+
+		gfx_memory: framebuffer {
+			size = <0x01000000>;
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		heartbeat {
+			gpios = <&gpio ASPEED_GPIO(J, 1) GPIO_ACTIVE_LOW>;
+		};
+
+		fault {
+			gpios = <&gpio ASPEED_GPIO(J, 0) GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
+		<&adc 4>, <&adc 5>, <&adc 6>, <&adc 7>,
+		<&adc 8>, <&adc 9>, <&adc 10>,
+		<&adc 12>, <&adc 13>, <&adc 14>;
+	};
+
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout.dtsi"
+	};
+};
+
+&lpc_ctrl {
+	status = "okay";
+	memory-region = <&flash_memory>;
+	flash = <&spi1>;
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
+&uart5 {
+	status = "okay";
+};
+
+&vuart {
+	status = "okay";
+};
+
+&ibt {
+	status = "okay";
+};
+
+&mac0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii1_default>;
+	use-ncsi;
+};
+
+&mac1 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
+};
+
+&adc {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+	/* temp1 inlet */
+	tmp75@4e {
+		compatible = "national,lm75";
+		reg = <0x4e>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	/* temp2 outlet */
+	tmp75@4d {
+		compatible = "national,lm75";
+		reg = <0x4d>;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+	/*	Slot 0,
+	 *	Slot 1,
+	 *	Slot 2,
+	 *	Slot 3
+	 */
+
+	i2c-switch@70 {
+		compatible = "nxp,pca9545";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;	/* may use mux@70 next. */
+
+		i2c_rbp: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c_fbp1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c_fbp2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c_fbp3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+&i2c7 {
+	status = "okay";
+
+	/*	Slot 0,
+	 *	Slot 1,
+	 *	Slot 2,
+	 *	Slot 3
+	 */
+	i2c-switch@76 {
+		compatible = "nxp,pca9546";
+		reg = <0x76>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;  /* may use mux@76 next. */
+
+		i2c_riser2: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c_pcie4: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c_riser1: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c_ocp: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+&i2c8 {
+	status = "okay";
+
+	eeprom@57 {
+		compatible = "atmel,24c256";
+		reg = <0x57>;
+		pagesize = <16>;
+	};
+};
+
+&i2c9 {
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+};
+
+&i2c12 {
+	status = "okay";
+};
+
+/*
+ * Enable port A as device (via the virtual hub) and port B as
+ * host by default on the eval board. This can be easily changed
+ * by replacing the override below with &ehci0 { ... } to enable
+ * host on both ports.
+ */
+&vhub {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&uhci {
+	status = "okay";
+};
+
+&gfx {
+	status = "okay";
+	memory-region = <&gfx_memory>;
+};
+
+&pwm_tacho {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default
+	&pinctrl_pwm1_default
+	&pinctrl_pwm2_default
+	&pinctrl_pwm3_default
+	&pinctrl_pwm4_default
+	&pinctrl_pwm5_default
+	&pinctrl_pwm6_default>;
+
+	fan@0 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x00>;
+	};
+
+	fan@1 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x01>;
+	};
+
+	fan@2 {
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x02>;
+	};
+
+	fan@3 {
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x03>;
+	};
+
+	fan@4 {
+		reg = <0x02>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x04>;
+	};
+
+	fan@5 {
+		reg = <0x02>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x05>;
+	};
+
+	fan@6 {
+		reg = <0x03>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x06>;
+	};
+
+	fan@7 {
+		reg = <0x03>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x07>;
+	};
+
+	fan@8 {
+		reg = <0x04>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x08>;
+	};
+
+	fan@9 {
+		reg = <0x04>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x09>;
+	};
+
+	fan@10 {
+		reg = <0x05>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0a>;
+	};
+
+	fan@11 {
+		reg = <0x05>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0b>;
+	};
+
+	fan@12 {
+		reg = <0x06>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0c>;
+	};
+
+	fan@13 {
+		reg = <0x06>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x0d>;
+	};
+};
+
+&gpio {
+
+	pin_gpio_a0 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(A, 0) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "MAC1_INT_N";
+	};
+
+	pin_gpio_a1 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(A, 1) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "MEZZ_C_PRESENT_N";
+	};
+
+	pin_gpio_a2 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(A, 2) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "PSU1_PRST";
+	};
+
+	pin_gpio_a3 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(A, 3) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "PSU2_PRST";
+	};
+
+	pin_gpio_b5 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "IRQ_BMC_PCH_SMI_LPC_N";
+	};
+
+	pin_gpio_f0 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(F, 0) GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "IRQ_BMC_PCH_NMI_R";
+	};
+
+	pin_gpio_f1 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(F, 1) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "FM_CPU1_DISABLE_COD_N";
+	};
+
+	pin_gpio_f2 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(F, 2) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "SMB_LAN_ALERT_N_MEZZ";
+	};
+
+	pin_gpio_f3 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(F, 3) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "I2C_BUS0_RST_OUT_N";
+	};
+
+	pin_gpio_f4 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(F, 4) GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "FM_SKT0_FAULT_LED";
+	};
+
+	pin_gpio_f5 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(F, 5) GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "FM_SKT1_FAULT_LED";
+	};
+
+	pin_gpio_f6 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(F, 6) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "IRQ_BMC_CPLD_NMI";
+	};
+
+	pin_gpio_f7 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(F, 7) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "PSU2_ALERT_N";
+	};
+
+	pin_gpio_g0 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(G, 0) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "FM_CPU_ERR2_LVT3_N";
+	};
+
+	pin_gpio_g1 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(G, 1) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "FM_CPU_MSMI_CATERR_LVT3_N";
+	};
+
+	pin_gpio_g2 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(G, 2) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "FM_PCH_BMC_THERMTRIP_N";
+	};
+
+	pin_gpio_g3 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(G, 3) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "BMC_I2C_BUS7_INT_N";
+	};
+
+	pin_gpio_g4 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(G, 4) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "FAN_PWR_CTL_N";
+	};
+
+	pin_gpio_g5 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(G, 5) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "NFC_FD_N";
+	};
+
+	pin_gpio_g6 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(G, 6) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "IRQ_NMI_EVENT_N";
+	};
+
+	pin_gpio_g7 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(G, 7) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "RST_BMC_PCIE_I2CMUX_N";
+	};
+
+	pin_gpio_h0 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(H, 0) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "PSU1_EPOW_N_R";
+	};
+
+	pin_gpio_h1 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(H, 1) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "PSU2_EPOW_N_R";
+	};
+
+	pin_gpio_h2 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(H, 2) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "PSU1_FFS_N_R";
+	};
+
+	pin_gpio_h3 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(H, 3) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "PSU2_FFS_N_R";
+	};
+
+	pin_gpio_h4 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(H, 4) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "PSU1_THROTTLE_N_R";
+	};
+
+	pin_gpio_h5 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(H, 5) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "PSU2_THROTTLE_N_R";
+	};
+
+	pin_gpio_h6 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(H, 6) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "PSU1_SMB_RESET_N";
+	};
+
+	pin_gpio_h7 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(H, 7) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "PSU2_SMB_RESET_N";
+	};
+
+	pin_gpio_i1 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(I, 1) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "FP_PWR_BTN_N";
+	};
+
+	pin_gpio_i2 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(I, 2) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "BIOS_RCVR_N";
+	};
+
+	pin_gpio_i3 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(I, 3) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "BMC_INTRUDED_COVER";
+	};
+
+	pin_gpio_j2 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(J, 2) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "BMC_BIOS_UPDATE_N";
+	};
+
+	pin_gpio_j3 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(J, 3) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "RST_BMC_HDD_I2CMUX_N";
+	};
+
+	pin_gpio_q4 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(Q, 4) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "MEZZ_A_PRESENT_N";
+	};
+
+	pin_gpio_q5 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(Q, 5) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "VGA_FRONT_PRES_N";
+	};
+
+	pin_gpio_q6 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(Q, 6) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "I2C_RISER1_INT_N";
+	};
+
+	pin_gpio_q7 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(Q, 7) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "NCSI_CABLE_DET_N";
+	};
+
+	pin_gpio_r0 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(R, 0) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "FP_RST_BTN_N";
+	};
+
+	pin_gpio_r2 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(R, 2) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "HDDSIG1_DETECT_N";
+	};
+
+	pin_gpio_r3 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(R, 3) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "HDDSIG2_DETECT_N";
+	};
+
+	pin_gpio_r4 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(R, 4) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "HDDSIG3_DETECT_N";
+	};
+
+	pin_gpio_r5 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(R, 5) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "VIDEO_CABLE_DETECT_N";
+	};
+
+	pin_gpio_s0 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(S, 0) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "BMC_PS_RAPIDON_WAKE_R_N";
+	};
+
+	pin_gpio_s1 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(S, 1) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "HOST_TPM_PP_BUF";
+	};
+
+	pin_gpio_s2 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(S, 2) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "BMC_VGA_SW";
+	};
+
+	pin_gpio_s3 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(S, 3) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "IRQ_SML0_ALERT_MUX_N";
+	};
+
+	pin_gpio_s4 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(S, 4) GPIO_ACTIVE_HIGH>;
+		output;
+		line-name = "VBAT_EN_N";
+	};
+
+	pin_gpio_s5 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(S, 5) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "BMC_HW_STRAP_4";
+	};
+
+	pin_gpio_s6 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(S, 6) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "PU_BMC_GPIOS6";
+	};
+
+	pin_gpio_s7 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(S, 7) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "I2C_BUS7_RESET_N";
+	};
+
+	pin_gpio_y0 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(Y, 0) GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "BMC_NCSI_MUX_CTL_S0";
+	};
+
+	pin_gpio_y1 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(Y, 1) GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "BMC_NCSI_MUX_CTL_S1";
+	};
+
+	pin_gpio_y2 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(Y, 2) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "UID_ALERT_N";
+	};
+
+	pin_gpio_z0 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(Z, 0) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "I2C_RISER2_INT_N";
+	};
+
+	pin_gpio_z2 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(Z, 2) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "I2C_RISER2_RESET_N";
+	};
+
+	pin_gpio_z3 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "FM_BMC_PCH_SCI_LPC_N";
+	};
+
+	pin_gpio_z4 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "BMC_HW_STRAP_17";
+	};
+
+	pin_gpio_z6 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(Z, 6) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "BMC_HW_STRAP_20";
+	};
+
+	pin_gpio_z7 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(Z, 7) GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "BMC_POST_CMPLT_N";
+	};
+
+	pin_gpio_aa0 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(AA, 0) GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "HOST_BMC_USB_SEL";
+	};
+
+	pin_gpio_aa1 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(AA, 1) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "PSU1_ALERT_N";
+	};
+
+	pin_gpio_aa2 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(AA, 2) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "FM_PVCCIN_CPU0_PWR_IN_ALERT_N";
+	};
+
+	pin_gpio_aa3 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(AA, 3) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "FM_PVCCIN_CPU1_PWR_IN_ALERT_N";
+	};
+
+	pin_gpio_aa4 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(AA, 4) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "USB_CABLE_DETECT_N";
+	};
+
+	pin_gpio_aa5 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(AA, 5) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "I2C_BUS1_RST_OUT_N";
+	};
+
+	pin_gpio_aa6 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(AA, 6) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "IRQ_SMI_ACTIVE_N";
+	};
+
+	pin_gpio_aa7 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(AA, 7) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "FM_BIOS_POST_CMPLT_N";
+	};
+
+	pin_gpio_ab0 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(AB, 0) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "FM_TPM_MOD_PRES_N";
+	};
+
+	pin_gpio_ab1 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(AB, 1) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "FORCE_NMI_SW_FPGA_N";
+	};
+
+	pin_gpio_ab2 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(AB, 2) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "1U_2U_PCBA_SEL_R";
+	};
+
+	pin_gpio_ab3 {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(AB, 3) GPIO_ACTIVE_HIGH>;
+		input;
+		line-name = "INTRUDED_PRES_N";
+	};
+};
-- 
2.7.4

