Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B06BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3FD2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfLBK33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 05:29:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:57614 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727442AbfLBK3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 05:29:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9DC99B2E6;
        Mon,  2 Dec 2019 10:29:22 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 7/9] arm64: dts: realtek: Add RTD1395 and BPi-M4
Date:   Mon,  2 Dec 2019 11:29:08 +0100
Message-Id: <20191202102910.26916-8-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191202102910.26916-1-afaerber@suse.de>
References: <20191202102910.26916-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Device Trees for Realtek RTD1395 SoC and Banana Pi BPi-M4 SBC.

For now reuse RTD1295 reset constants.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 To be followed up by patch unshadowing more RAM from /soc 0x98000000..0xffffffff,
 once we know the higher RAM windows.
 
 v1 -> v2:
 * Fixed r-bus size from 0x100000 to 0x200000 (James)
 * Changed #address-cells and #size-cells from 2 to 1 (James)
 * Carved out boot ROM from /memory and added it to /soc ranges (Rob/James)
 
 arch/arm64/boot/dts/realtek/Makefile           |   2 +
 arch/arm64/boot/dts/realtek/rtd1395-bpi-m4.dts |  30 ++++++
 arch/arm64/boot/dts/realtek/rtd1395.dtsi       |  65 +++++++++++
 arch/arm64/boot/dts/realtek/rtd139x.dtsi       | 142 +++++++++++++++++++++++++
 4 files changed, 239 insertions(+)
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1395-bpi-m4.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1395.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd139x.dtsi

diff --git a/arch/arm64/boot/dts/realtek/Makefile b/arch/arm64/boot/dts/realtek/Makefile
index fb5f05978ecc..f614080b5e27 100644
--- a/arch/arm64/boot/dts/realtek/Makefile
+++ b/arch/arm64/boot/dts/realtek/Makefile
@@ -8,4 +8,6 @@ dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-zidoo-x9s.dtb
 
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1296-ds418.dtb
 
+dtb-$(CONFIG_ARCH_REALTEK) += rtd1395-bpi-m4.dtb
+
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1619-mjolnir.dtb
diff --git a/arch/arm64/boot/dts/realtek/rtd1395-bpi-m4.dts b/arch/arm64/boot/dts/realtek/rtd1395-bpi-m4.dts
new file mode 100644
index 000000000000..9891967d1315
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1395-bpi-m4.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Copyright (c) 2019 Andreas Färber
+ */
+
+/dts-v1/;
+
+#include "rtd1395.dtsi"
+
+/ {
+	compatible = "bananapi,bpi-m4", "realtek,rtd1395";
+	model = "Banana Pi BPI-M4";
+
+	memory@2f000 {
+		device_type = "memory";
+		reg = <0x2f000 0x3ffd1000>; /* boot ROM to 1 GiB or 2 GiB */
+	};
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/realtek/rtd1395.dtsi b/arch/arm64/boot/dts/realtek/rtd1395.dtsi
new file mode 100644
index 000000000000..05c9216a87ee
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1395.dtsi
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Realtek RTD1395 SoC
+ *
+ * Copyright (c) 2019 Andreas Färber
+ */
+
+#include "rtd139x.dtsi"
+
+/ {
+	compatible = "realtek,rtd1395";
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x0>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x1>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x2>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x3>;
+			next-level-cache = <&l2>;
+		};
+
+		l2: l2-cache {
+			compatible = "cache";
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+};
+
+&arm_pmu {
+	interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+};
diff --git a/arch/arm64/boot/dts/realtek/rtd139x.dtsi b/arch/arm64/boot/dts/realtek/rtd139x.dtsi
new file mode 100644
index 000000000000..c11a505e43e2
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd139x.dtsi
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Realtek RTD1395 SoC family
+ *
+ * Copyright (c) 2019 Andreas Färber
+ */
+
+/memreserve/	0x0000000000000000 0x000000000002f000;
+/memreserve/	0x000000000002f000 0x00000000000d1000;
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/realtek,rtd1295.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		rpc_comm: rpc@2f000 {
+			reg = <0x2f000 0x1000>;
+		};
+
+		rpc_ringbuf: rpc@1ffe000 {
+			reg = <0x1ffe000 0x4000>;
+		};
+
+		tee: tee@10100000 {
+			reg = <0x10100000 0xf00000>;
+			no-map;
+		};
+	};
+
+	arm_pmu: arm-pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	osc27M: osc {
+		compatible = "fixed-clock";
+		clock-frequency = <27000000>;
+		#clock-cells = <0>;
+		clock-output-names = "osc27M";
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00000000 0x00000000 0x0001f000>, /* boot ROM */
+			 <0x98000000 0x98000000 0x68000000>;
+
+		rbus: bus@98000000 {
+			compatible = "simple-bus";
+			reg = <0x98000000 0x200000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x98000000 0x200000>;
+
+			reset1: reset-controller@0 {
+				compatible = "snps,dw-low-reset";
+				reg = <0x0 0x4>;
+				#reset-cells = <1>;
+			};
+
+			reset2: reset-controller@4 {
+				compatible = "snps,dw-low-reset";
+				reg = <0x4 0x4>;
+				#reset-cells = <1>;
+			};
+
+			reset3: reset-controller@8 {
+				compatible = "snps,dw-low-reset";
+				reg = <0x8 0x4>;
+				#reset-cells = <1>;
+			};
+
+			reset4: reset-controller@50 {
+				compatible = "snps,dw-low-reset";
+				reg = <0x50 0x4>;
+				#reset-cells = <1>;
+			};
+
+			iso_reset: reset-controller@7088 {
+				compatible = "snps,dw-low-reset";
+				reg = <0x7088 0x4>;
+				#reset-cells = <1>;
+			};
+
+			wdt: watchdog@7680 {
+				compatible = "realtek,rtd1295-watchdog";
+				reg = <0x7680 0x100>;
+				clocks = <&osc27M>;
+			};
+
+			uart0: serial@7800 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0x7800 0x400>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				clock-frequency = <27000000>;
+				resets = <&iso_reset RTD1295_ISO_RSTN_UR0>;
+				status = "disabled";
+			};
+
+			uart1: serial@1b200 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0x1b200 0x100>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				clock-frequency = <432000000>;
+				resets = <&reset2 RTD1295_RSTN_UR1>;
+				status = "disabled";
+			};
+
+			uart2: serial@1b400 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0x1b400 0x100>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				clock-frequency = <432000000>;
+				resets = <&reset2 RTD1295_RSTN_UR2>;
+				status = "disabled";
+			};
+		};
+
+		gic: interrupt-controller@ff011000 {
+			compatible = "arm,gic-400";
+			reg = <0xff011000 0x1000>,
+			      <0xff012000 0x2000>,
+			      <0xff014000 0x2000>,
+			      <0xff016000 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+	};
+};
-- 
2.16.4

