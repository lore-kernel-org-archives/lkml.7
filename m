Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81049C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C17208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8s3qSZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfE1JVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:21:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33748 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfE1JVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:21:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id h17so10638676pgv.0;
        Tue, 28 May 2019 02:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uKG1ikDSyESQTlR9j1ykDDFLzKlwSz+CIfN2Fvj6ItU=;
        b=h8s3qSZb/jYY+kMxPaleQicYFJyqJ90vrKEJB6sHYSzVw226i/lneyhOi5btxdYMd4
         b7+0Tc1fhPvgxsbAZZz+WFQen4fK+iN7Oo7IPEoEuu951SDulg5FmfwDumxX1694qPsr
         V0merbF3bwq9ISzTcxVgEH7yah/K5uaCtcF0Bh/8jbZgmakmO8I8UOhd09SxIrL5K2x9
         vdoMm4iYMxsOEhe7E+L17RxvHx70XV4yE0/389hrbPIxqxzP1fCrCJ4f2ww1HOhkMmvM
         YqS/XepXUkR1kQe13fPIXImknRKiXD2kH1lrbpk90B68+8/t9qAK1rNwDhzFO/g4kYpd
         MnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uKG1ikDSyESQTlR9j1ykDDFLzKlwSz+CIfN2Fvj6ItU=;
        b=A7PQV4jK4Em4w7BRPXTpvjJAfbzW/TXvTv9tigVUHjD5hGxAOLQTjcy2NYKB7pPxo6
         l3HYDFCM9Rq9BAVx9nPgss2uMDVObYlQHgkYiOaxg5MiD1cQLM/BySR9ypQEEkHPiLuw
         /Klz5TLGabkynwjC5CxBVstyY9rkZQc0S4VzGJY+7AItyY14XLEKiywiC1xPJ4rcAA34
         U3k8eWoBY0GS5hCwbL/KnDRiEnfOKk3nGVWks+ry4CkoGdtuhqYfVSSNPJ7sB4iUYe8+
         FTmdORRiCq1Rc1gf6hrbTMNM5Q7th2iSd1SO5/rWO8WYLl6uQCs6CZJzEQF+P+D+zfcM
         CpqA==
X-Gm-Message-State: APjAAAVJ8WGYrr+Tbg5Q/XqKlkLE2L/SoMOMuiWUPQ1sut7gl/mKfKon
        TZrCZGqOV7Q0gWI7SpyYcbU=
X-Google-Smtp-Source: APXvYqwH0WVrUf07mNvfJWW4akSYFuTEoEJvwrpg07MbGaIspoS8fZqWOpW/LzMA4yhTErJOqlCPOQ==
X-Received: by 2002:a17:90a:480a:: with SMTP id a10mr4398505pjh.57.1559035297000;
        Tue, 28 May 2019 02:21:37 -0700 (PDT)
Received: from localhost.localdomain (45.78.73.89.16clouds.com. [45.78.73.89])
        by smtp.gmail.com with ESMTPSA id g17sm21052209pfk.55.2019.05.28.02.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 May 2019 02:21:36 -0700 (PDT)
From:   xieqinick@gmail.com
To:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     robh@kernel.org, nick@khadas.com
Subject: [PATCH] arm64: dts: rockchip: Add support for Khadas Edge/Edge-V/Captain boards
Date:   Tue, 28 May 2019 17:21:07 +0800
Message-Id: <1559035267-1884-1-git-send-email-xieqinick@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick <nick@khadas.com>

Add devicetree support for Khadas Edge/Edge-V/Captain boards.
Khadas Edge is an expandable Rockchip RK3399 board with goldfinger.
Khadas Captain is the carrier board for Khadas Edge.
Khadas Edge-V is a Khadas VIM form factor Rockchip RK3399 board.

Signed-off-by: Nick <nick@khadas.com>
---
 arch/arm64/boot/dts/rockchip/Makefile              |   3 +
 .../boot/dts/rockchip/rk3399-khadas-captain.dts    |  27 +
 .../boot/dts/rockchip/rk3399-khadas-edge-v.dts     |  28 +
 .../arm64/boot/dts/rockchip/rk3399-khadas-edge.dts |  17 +
 .../boot/dts/rockchip/rk3399-khadas-edge.dtsi      | 795 +++++++++++++++++++++
 5 files changed, 870 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-khadas-captain.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-v.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 5f2687a..28e5829 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -16,6 +16,9 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-bob.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-kevin.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-scarlet-inx.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-scarlet-kd.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-khadas-captain.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-khadas-edge.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-khadas-edge-v.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopc-t4.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-m4.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-neo4.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-captain.dts b/arch/arm64/boot/dts/rockchip/rk3399-khadas-captain.dts
new file mode 100644
index 0000000..85eb51c
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-captain.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Shenzhen Wesion Technology Co., Ltd.
+ * (https://www.khadas.com)
+ */
+
+/dts-v1/;
+#include "rk3399-khadas-edge.dtsi"
+
+/ {
+	model = "Khadas Captain";
+	compatible = "khadas,captain", "rockchip,rk3399";
+};
+
+&gmac {
+	status = "okay";
+};
+
+&pcie_phy {
+	status = "okay";
+};
+
+&pcie0 {
+	ep-gpios = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
+	num-lanes = <4>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-v.dts b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-v.dts
new file mode 100644
index 0000000..396b7f4
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge-v.dts
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Shenzhen Wesion Technology Co., Ltd.
+ * (https://www.khadas.com)
+ */
+
+/dts-v1/;
+#include "rk3399-khadas-edge.dtsi"
+
+/ {
+	model = "Khadas Edge-V";
+	compatible = "khadas,edge-v", "rockchip,rk3399";
+};
+
+&gmac {
+	status = "okay";
+};
+
+&pcie_phy {
+	status = "okay";
+};
+
+&pcie0 {
+	ep-gpios = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
+	num-lanes = <4>;
+	status = "okay";
+};
+
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dts b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dts
new file mode 100644
index 0000000..f0d5bae
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dts
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Shenzhen Wesion Technology Co., Ltd.
+ * (https://www.khadas.com)
+ */
+
+/dts-v1/;
+#include "rk3399-khadas-edge.dtsi"
+
+/ {
+	model = "Khadas Edge";
+	compatible = "khadas,edge", "rockchip,rk3399";
+};
+
+&gmac {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
new file mode 100644
index 0000000..872b535
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
@@ -0,0 +1,795 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Shenzhen Wesion Technology Co., Ltd.
+ * (https://www.khadas.com)
+ */
+
+/dts-v1/;
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/pwm/pwm.h>
+#include "rk3399.dtsi"
+#include "rk3399-opp.dtsi"
+
+/ {
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+
+	clkin_gmac: external-gmac-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
+		clock-output-names = "clkin_gmac";
+		#clock-cells = <0>;
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rk808 1>;
+		clock-names = "ext_clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable_h>;
+
+		/*
+		 * On the module itself this is one of these (depending
+		 * on the actual card populated):
+		 * - SDIO_RESET_L_WL_REG_ON
+		 * - PDN (power down when low)
+		 */
+		reset-gpios = <&gpio2 RK_PD4 GPIO_ACTIVE_LOW>;
+	};
+
+	/* switched by pmic_sleep */
+	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc1v8_s3";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_1v8>;
+	};
+
+	vcc3v3_pcie: vcc3v3-pcie-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_pcie";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vsys_3v3>;
+	};
+
+	/* Actually 3 regulators (host0, 1, 2) controlled by the same gpio */
+	vcc5v0_host: vcc5v0-host-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 RK_PD1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_host_en>;
+		regulator-name = "vcc5v0_host";
+		regulator-always-on;
+		vin-supply = <&vsys_5v0>;
+	};
+
+	vdd_log: vdd-log {
+		compatible = "pwm-regulator";
+		pwms = <&pwm2 0 25000 1>;
+		regulator-name = "vdd_log";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <1400000>;
+		vin-supply = <&vsys_3v3>;
+	};
+
+	vsys: vsys {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vsys_3v3: vsys-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_3v3";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vsys>;
+	};
+
+	vsys_5v0: vsys-5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vsys_5v0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vsys>;
+	};
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 1>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+		poll-interval = <100>;
+
+		recovery {
+			label = "Recovery";
+			linux,code = <KEY_VENDOR>;
+			press-threshold-microvolt = <18000>;
+		};
+	};
+
+	fan: pwm-fan {
+		compatible = "pwm-fan";
+		cooling-levels = <0 150 200 255>;
+		#cooling-cells = <2>;
+		fan-supply = <&vsys_5v0>;
+		pwms = <&pwm0 0 40000 0>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwrbtn>;
+
+		power {
+			debounce-interval = <100>;
+			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
+			label = "GPIO Key Power";
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&sys_led_gpio>, <&user_led_gpio>;
+
+		sys-led {
+			label = "sys_led";
+			linux,default-trigger = "heartbeat";
+			gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
+		};
+
+		user-led {
+			label = "user_led";
+			default-state = "off";
+			gpios = <&gpio4 RK_PD0 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&cpu_l0 {
+	cpu-supply = <&vdd_cpu_l>;
+};
+
+&cpu_l1 {
+	cpu-supply = <&vdd_cpu_l>;
+};
+
+&cpu_l2 {
+	cpu-supply = <&vdd_cpu_l>;
+};
+
+&cpu_l3 {
+	cpu-supply = <&vdd_cpu_l>;
+};
+
+&cpu_b0 {
+	cpu-supply = <&vdd_cpu_b>;
+};
+
+&cpu_b1 {
+	cpu-supply = <&vdd_cpu_b>;
+};
+
+&cpu_thermal {
+	trips {
+		cpu_warm: cpu_warm {
+			temperature = <55000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+
+		cpu_hot: cpu_hot {
+			temperature = <65000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map2 {
+			trip = <&cpu_warm>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
+		};
+
+		map3 {
+			trip = <&cpu_hot>;
+			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
+&emmc_phy {
+	status = "okay";
+};
+
+&gmac {
+	assigned-clocks = <&cru SCLK_RMII_SRC>;
+	assigned-clock-parents = <&clkin_gmac>;
+	clock_in_out = "input";
+	phy-supply = <&vcc_lan>;
+	phy-mode = "rgmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>;
+	snps,reset-gpio = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 10000 50000>;
+	tx_delay = <0x28>;
+	rx_delay = <0x11>;
+	status = "disabled";
+};
+
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
+&gpu_thermal {
+	trips {
+		gpu_warm: gpu_warm {
+			temperature = <55000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+
+		gpu_hot: gpu_hot {
+			temperature = <65000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+	};
+	cooling-maps {
+		map1 {
+			trip = <&gpu_warm>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
+		};
+
+		map2 {
+			trip = <&gpu_hot>;
+			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
+&hdmi {
+	ddc-i2c-bus = <&i2c3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_cec>;
+	status = "okay";
+};
+
+&hdmi_sound {
+	status = "okay";
+};
+
+&i2c3 {
+	i2c-scl-rising-time-ns = <450>;
+	i2c-scl-falling-time-ns = <15>;
+	status = "okay";
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
+	i2c-scl-rising-time-ns = <168>;
+	i2c-scl-falling-time-ns = <4>;
+	status = "okay";
+
+	rk808: pmic@1b {
+		compatible = "rockchip,rk808";
+		reg = <0x1b>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <22 IRQ_TYPE_LEVEL_LOW>;
+		#clock-cells = <1>;
+		clock-output-names = "xin32k", "rk808-clkout2";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int_l>;
+		rockchip,system-power-controller;
+		wakeup-source;
+
+		vcc1-supply = <&vsys_3v3>;
+		vcc2-supply = <&vsys_3v3>;
+		vcc3-supply = <&vsys_3v3>;
+		vcc4-supply = <&vsys_3v3>;
+		vcc6-supply = <&vsys_3v3>;
+		vcc7-supply = <&vsys_3v3>;
+		vcc8-supply = <&vsys_3v3>;
+		vcc9-supply = <&vsys_3v3>;
+		vcc10-supply = <&vsys_3v3>;
+		vcc11-supply = <&vsys_3v3>;
+		vcc12-supply = <&vsys_3v3>;
+		vddio-supply = <&vcc_1v8>;
+
+		regulators {
+			vdd_center: DCDC_REG1 {
+				regulator-name = "vdd_center";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_cpu_l: DCDC_REG2 {
+				regulator-name = "vdd_cpu_l";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-name = "vcc_ddr";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_1v8: DCDC_REG4 {
+				regulator-name = "vcc_1v8";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcc1v8_apio2: LDO_REG1 {
+				regulator-name = "vcc1v8_apio2";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_vldo2: LDO_REG2 {
+				regulator-name = "vcc_vldo2";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc1v8_pmupll: LDO_REG3 {
+				regulator-name = "vcc1v8_pmupll";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vccio_sd: LDO_REG4 {
+				regulator-name = "vccio_sd";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3000000>;
+				};
+			};
+
+			vcc_vldo5: LDO_REG5 {
+				regulator-name = "vcc_vldo5";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_1v5: LDO_REG6 {
+				regulator-name = "vcc_1v5";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1500000>;
+				};
+			};
+
+			vcc1v8_codec: LDO_REG7 {
+				regulator-name = "vcc1v8_codec";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_3v0: LDO_REG8 {
+				regulator-name = "vcc_3v0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3000000>;
+				};
+			};
+
+			vcc3v3_s3: vcc_lan: SWITCH_REG1 {
+				regulator-name = "vcc3v3_s3";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_s0: SWITCH_REG2 {
+				regulator-name = "vcc3v3_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
+
+	vdd_cpu_b: regulator@40 {
+		compatible = "silergy,syr827";
+		reg = <0x40>;
+		fcs,suspend-voltage-selector = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cpu_b_sleep>;
+		regulator-name = "vdd_cpu_b";
+		regulator-min-microvolt = <712500>;
+		regulator-max-microvolt = <1500000>;
+		regulator-ramp-delay = <1000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vsys_3v3>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	vdd_gpu: regulator@41 {
+		compatible = "silergy,syr828";
+		reg = <0x41>;
+		fcs,suspend-voltage-selector = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpu_sleep>;
+		regulator-name = "vdd_gpu";
+		regulator-min-microvolt = <712500>;
+		regulator-max-microvolt = <1500000>;
+		regulator-ramp-delay = <1000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vsys_3v3>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+};
+
+&i2c8 {
+	clock-frequency = <400000>;
+	i2c-scl-rising-time-ns = <160>;
+	i2c-scl-falling-time-ns = <30>;
+	status = "okay";
+};
+
+&i2s0 {
+	rockchip,playback-channels = <8>;
+	rockchip,capture-channels = <8>;
+	status = "okay";
+};
+
+&i2s1 {
+	rockchip,playback-channels = <2>;
+	rockchip,capture-channels = <2>;
+	status = "okay";
+};
+
+&i2s2 {
+	status = "okay";
+};
+
+&io_domains {
+	status = "okay";
+
+	bt656-supply = <&vcc1v8_apio2>;
+	audio-supply = <&vcc1v8_codec>;
+	sdmmc-supply = <&vccio_sd>;
+	gpio1830-supply = <&vcc_3v0>;
+};
+
+&pmu_io_domains {
+	pmu1830-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&pinctrl {
+	bt {
+		bt_host_wake_l: bt-host-wake-l {
+			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_reg_on_h: bt-reg-on-h {
+			rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_wake_l: bt-wake-l {
+			rockchip,pins = <2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	buttons {
+		pwrbtn: pwrbtn {
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	leds {
+		sys_led_gpio: sys_led-gpio {
+			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		user_led_gpio: user_led-gpio {
+			rockchip,pins = <4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pmic {
+		pmic_int_l: pmic-int-l {
+			rockchip,pins = <1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		cpu_b_sleep: cpu-b-sleep {
+			rockchip,pins = <1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		gpu_sleep: gpu-sleep {
+			rockchip,pins = <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	sdio-pwrseq {
+		wifi_enable_h: wifi-enable-h {
+			rockchip,pins = <2 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb2 {
+		vcc5v0_host_en: vcc5v0-host-en {
+			rockchip,pins = <4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	wifi {
+		wifi_host_wake_l: wifi-host-wake-l {
+			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&pwm0 {
+	status = "okay";
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+&saradc {
+	vref-supply = <&vcca1v8_s3>;
+	status = "okay";
+};
+
+&sdio0 {
+	/* WiFi & BT combo module Ampak AP6356S */
+	bus-width = <4>;
+	cap-sdio-irq;
+	cap-sd-highspeed;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	num-slots = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
+	sd-uhs-sdr104;
+
+	/* Power supply */
+	vqmmc-supply = &vcc1v8_s3;	/* IO line */
+	vmmc-supply = &vccio_sd;	/* card's power */
+
+	status = "okay";
+
+	brcmf: wifi@1 {
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
+		interrupt-names = "host-wake";
+		brcm,drive-strength = <5>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_host_wake_l>;
+	};
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	cd-gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	max-frequency = <150000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
+	status = "okay";
+};
+
+&sdhci {
+	bus-width = <8>;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	non-removable;
+	status = "okay";
+};
+
+&tcphy0 {
+	status = "okay";
+};
+
+&tcphy1 {
+	status = "okay";
+};
+
+&tsadc {
+	/* tshut mode 0:CRU 1:GPIO */
+	rockchip,hw-tshut-mode = <1>;
+	/* tshut polarity 0:LOW 1:HIGH */
+	rockchip,hw-tshut-polarity = <1>;
+	status = "okay";
+};
+
+&u2phy0 {
+	status = "okay";
+
+	u2phy0_otg: otg-port {
+		status = "okay";
+	};
+
+	u2phy0_host: host-port {
+		phy-supply = <&vcc5v0_host>;
+		status = "okay";
+	};
+};
+
+&u2phy1 {
+	status = "okay";
+
+	u2phy1_otg: otg-port {
+		status = "okay";
+	};
+
+	u2phy1_host: host-port {
+		phy-supply = <&vcc5v0_host>;
+		status = "okay";
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_xfer &uart0_rts &uart0_cts>;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		clocks = <&rk808 1>;
+		clock-names = "lpo";
+		device-wakeup-gpios = <&gpio2 RK_PD2 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
+		max-speed = <4000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_reg_on_h &bt_host_wake_l &bt_wake_l>;
+		vbat-supply = <&vsys_3v3>;
+		vddio-supply = <&vcc_1v8>;
+	};
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
+
+&usbdrd3_0 {
+	status = "okay";
+};
+
+&usbdrd_dwc3_0 {
+	status = "okay";
+	dr_mode = "otg";
+};
+
+&usbdrd3_1 {
+	status = "okay";
+};
+
+&usbdrd_dwc3_1 {
+	status = "okay";
+	dr_mode = "host";
+};
+
+&vopb {
+	status = "okay";
+};
+
+&vopb_mmu {
+	status = "okay";
+};
+
+&vopl {
+	status = "okay";
+};
+
+&vopl_mmu {
+	status = "okay";
+};
-- 
2.7.4

