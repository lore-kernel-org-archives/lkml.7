Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E6FC2D0C6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 15:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B659208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 15:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfL1PGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 10:06:20 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:42379 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfL1PGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 10:06:19 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBSF61DR031654, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBSF61DR031654
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Sat, 28 Dec 2019 23:06:01 +0800
Received: from james-BS01.localdomain (172.21.190.33) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Sat, 28 Dec 2019 23:06:00 +0800
From:   James Tai <james.tai@realtek.com>
To:     <linux-realtek-soc@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 2/2] arm64: dts: realtek: Add RTD1319 SoC and Realtek PymParticle EVB
Date:   Sat, 28 Dec 2019 23:05:53 +0800
Message-ID: <20191228150553.6210-3-james.tai@realtek.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191228150553.6210-1-james.tai@realtek.com>
References: <20191228150553.6210-1-james.tai@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Device Trees for Realtek RTD1319 SoC family, RTD1319 SoC and
Realtek PymParticle EVB.

Signed-off-by: James Tai <james.tai@realtek.com>
---
 arch/arm64/boot/dts/realtek/Makefile          |   2 +
 .../boot/dts/realtek/rtd1319-pymparticle.dts  |  43 ++++
 arch/arm64/boot/dts/realtek/rtd1319.dtsi      |  12 +
 arch/arm64/boot/dts/realtek/rtd13xx.dtsi      | 212 ++++++++++++++++++
 4 files changed, 269 insertions(+)
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1319-pymparticle.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1319.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd13xx.dtsi

diff --git a/arch/arm64/boot/dts/realtek/Makefile b/arch/arm64/boot/dts/realtek/Makefile
index ef8d8fcbaa05..c0ae96f324eb 100644
--- a/arch/arm64/boot/dts/realtek/Makefile
+++ b/arch/arm64/boot/dts/realtek/Makefile
@@ -9,6 +9,8 @@ dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-zidoo-x9s.dtb
 
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1296-ds418.dtb
 
+dtb-$(CONFIG_ARCH_REALTEK) += rtd1319-pymparticle.dtb
+
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1395-bpi-m4.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1395-lionskin.dtb
 
diff --git a/arch/arm64/boot/dts/realtek/rtd1319-pymparticle.dts b/arch/arm64/boot/dts/realtek/rtd1319-pymparticle.dts
new file mode 100644
index 000000000000..2a36d220fef6
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1319-pymparticle.dts
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Copyright (c) 2019 Realtek Semiconductor Corp.
+ */
+
+/dts-v1/;
+
+#include "rtd1319.dtsi"
+
+/ {
+	compatible = "realtek,pymparticle", "realtek,rtd1319";
+	model = "Realtek PymParticle EVB";
+
+	memory@2e000 {
+		device_type = "memory";
+		reg = <0x2e000 0x3ffd2000>; /* boot ROM to 1 GiB or 2 GiB */
+	};
+
+	chosen {
+		stdout-path = "serial0:460800n8";
+	};
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+	};
+};
+
+/* debug console (J1) */
+&uart0 {
+	status = "okay";
+};
+
+/* M.2 slot (CON8) */
+&uart1 {
+	status = "disabled";
+};
+
+/* GPIO connector (T1) */
+&uart2 {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/realtek/rtd1319.dtsi b/arch/arm64/boot/dts/realtek/rtd1319.dtsi
new file mode 100644
index 000000000000..1dcee00009cd
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1319.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Realtek RTD1319 SoC
+ *
+ * Copyright (c) 2019 Realtek Semiconductor Corp.
+ */
+
+#include "rtd13xx.dtsi"
+
+/ {
+	compatible = "realtek,rtd1319";
+};
diff --git a/arch/arm64/boot/dts/realtek/rtd13xx.dtsi b/arch/arm64/boot/dts/realtek/rtd13xx.dtsi
new file mode 100644
index 000000000000..18d063feaa7e
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd13xx.dtsi
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Realtek RTD13xx SoC family
+ *
+ * Copyright (c) 2019 Realtek Semiconductor Corp.
+ */
+
+/memreserve/	0x0000000000000000 0x000000000002e000; /* Boot ROM */
+/memreserve/	0x000000000002e000 0x0000000000100000; /* Boot loader */
+/memreserve/	0x000000000f400000 0x0000000000500000; /* Video FW */
+/memreserve/	0x000000000f900000 0x0000000000500000; /* Audio FW */
+/memreserve/	0x0000000010000000 0x0000000000014000; /* Audio FW RAM */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
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
+		rpc_comm: rpc@3f000 {
+			reg = <0x3f000 0x1000>;
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
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x100>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x200>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x300>;
+			enable-method = "psci";
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
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	arm_pmu: pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	osc27M: osc {
+		compatible = "fixed-clock";
+		clock-frequency = <27000000>;
+		clock-output-names = "osc27M";
+		#clock-cells = <0>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00000000 0x00000000 0x0002e000>, /* boot ROM */
+			 <0xff100000 0xff100000 0x00200000>, /* GIC */
+			 <0x98000000 0x98000000 0x00200000>; /* rbus */
+
+		rbus: bus@98000000 {
+			compatible = "simple-bus";
+			reg = <0x98000000 0x200000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x98000000 0x200000>;
+
+			crt: syscon@0 {
+				compatible = "syscon", "simple-mfd";
+				reg = <0x0 0x1000>;
+				reg-io-width = <4>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x0 0x1000>;
+			};
+
+			iso: syscon@7000 {
+				compatible = "syscon", "simple-mfd";
+				reg = <0x7000 0x1000>;
+				reg-io-width = <4>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x7000 0x1000>;
+			};
+
+			sb2: syscon@1a000 {
+				compatible = "syscon", "simple-mfd";
+				reg = <0x1a000 0x1000>;
+				reg-io-width = <4>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x1a000 0x1000>;
+			};
+
+			misc: syscon@1b000 {
+				compatible = "syscon", "simple-mfd";
+				reg = <0x1b000 0x1000>;
+				reg-io-width = <4>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x1b000 0x1000>;
+			};
+
+			scpu_wrapper: syscon@1d000 {
+				compatible = "syscon", "simple-mfd";
+				reg = <0x1d000 0x1000>;
+				reg-io-width = <4>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x1d000 0x1000>;
+			};
+		};
+
+		gic: interrupt-controller@ff100000 {
+			compatible = "arm,gic-v3";
+			reg = <0xff100000 0x10000>,
+			      <0xff140000 0xc0000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+	};
+};
+
+&iso {
+	uart0: serial0@800 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0x800 0x400>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <432000000>;
+		status = "disabled";
+	};
+};
+
+&misc {
+	uart1: serial1@200 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0x200 0x400>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <432000000>;
+		status = "disabled";
+	};
+
+	uart2: serial2@400 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0x400 0x400>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <432000000>;
+		status = "disabled";
+	};
+};
-- 
2.24.1

