Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DF4C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C4D22DCC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfICHGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 03:06:39 -0400
Received: from mail-sh.amlogic.com ([58.32.228.43]:19737 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbfICHGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 03:06:37 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Sep 2019 03:06:26 EDT
Received: from droid13.amlogic.com (116.236.93.172) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.1591.10; Tue, 3 Sep 2019
 14:52:14 +0800
From:   Jianxin Pan <jianxin.pan@amlogic.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>
CC:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Tao Zeng <tao.zeng@amlogic.com>
Subject: [PATCH 4/4] arm64: dts: add support for A1 based Amlogic AD401
Date:   Tue, 3 Sep 2019 02:51:15 -0400
Message-ID: <1567493475-75451-5-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567493475-75451-1-git-send-email-jianxin.pan@amlogic.com>
References: <1567493475-75451-1-git-send-email-jianxin.pan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [116.236.93.172]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic support for the Amlogic A1 based Amlogic AD401 board:
which describe components as follows: Reserve Memory, CPU, GIC, IRQ,
Timer, UART. It's capable of booting up into the serial console.

Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/Makefile           |   1 +
 arch/arm64/boot/dts/amlogic/meson-a1-ad401.dts |  30 ++++++
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi      | 121 +++++++++++++++++++++++++
 3 files changed, 152 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-a1-ad401.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-a1.dtsi

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index edbf128..1720c45 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -36,3 +36,4 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxm-rbox-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-vega-s96.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-a1-ad401.dts b/arch/arm64/boot/dts/amlogic/meson-a1-ad401.dts
new file mode 100644
index 00000000..3c05cc0
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-a1-ad401.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "meson-a1.dtsi"
+
+/ {
+	compatible = "amlogic,ad401", "amlogic,a1";
+	model = "Amlogic Meson A1 AD401 Development Board";
+
+	aliases {
+		serial0 = &uart_AO_B;
+	};
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+	memory@0 {
+		device_type = "memory";
+		linux,usable-memory = <0x0 0x0 0x0 0x8000000>;
+	};
+};
+
+&uart_AO_B {
+	status = "okay";
+	/*pinctrl-0 = <&uart_ao_a_pins>;*/
+	/*pinctrl-names = "default";*/
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
new file mode 100644
index 00000000..b98d648
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "amlogic,a1";
+
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <0x2>;
+		#size-cells = <0x0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		l2: l2-cache0 {
+			compatible = "cache";
+		};
+	};
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x800000>;
+			alignment = <0x0 0x400000>;
+			linux,cma-default;
+		};
+	};
+
+	sm: secure-monitor {
+		compatible = "amlogic,meson-gxbb-sm";
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		uart_AO: serial@fe001c00 {
+			compatible = "amlogic,meson-gx-uart",
+				     "amlogic,meson-ao-uart";
+			reg = <0x0 0xfe001c00 0x0 0x18>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&xtal>, <&xtal>, <&xtal>;
+			clock-names = "xtal", "pclk", "baud";
+			status = "disabled";
+		};
+
+		uart_AO_B: serial@fe002000 {
+			compatible = "amlogic,meson-gx-uart",
+				     "amlogic,meson-ao-uart";
+				     reg = <0x0 0xfe002000 0x0 0x18>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&xtal>, <&xtal>, <&xtal>;
+			clock-names = "xtal", "pclk", "baud";
+			status = "disabled";
+		};
+
+		gic: interrupt-controller@ff901000 {
+			compatible = "arm,gic-400";
+			reg = <0x0 0xff901000 0x0 0x1000>,
+			      <0x0 0xff902000 0x0 0x2000>,
+			      <0x0 0xff904000 0x0 0x2000>,
+			      <0x0 0xff906000 0x0 0x2000>;
+			interrupt-controller;
+			interrupts = <GIC_PPI 9
+				(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13
+			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14
+			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11
+			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10
+			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	xtal: xtal-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "xtal";
+		#clock-cells = <0>;
+	};
+};
-- 
2.7.4

