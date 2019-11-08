Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7565C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79699214DA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731826AbfKHJna convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:43:30 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:56628 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730948AbfKHJn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:43:26 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xA89gwZQ009629, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xA89gwZQ009629
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 8 Nov 2019 17:42:58 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV02.realtek.com.tw ([::1]) with mapi id 14.03.0468.000; Fri, 8 Nov
 2019 17:42:58 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?iso-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "'DTML'" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
Subject: [PATCH v2 2/2] arm64: dts: Initial RTD1619 SoC and Realtek Mjolnir EVB support
Thread-Topic: [PATCH v2 2/2] arm64: dts: Initial RTD1619 SoC and Realtek
 Mjolnir EVB support
Thread-Index: AdWWGAsiCC6BRMYDRzOBshxk4uZ5Zg==
Date:   Fri, 8 Nov 2019 09:42:57 +0000
Message-ID: <43B123F21A8CFE44A9641C099E4196FFCF91F9D6@RTITMBSVM04.realtek.com.tw>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.187]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Device Trees for Realtek RTD1619 SoC family, RTD1619 SoC and
Realtek Mjolnir EVB.

Signed-off-by: James Tai <james.tai@realtek.com>
---
 arch/arm64/boot/dts/realtek/Makefile          |   2 +
 .../boot/dts/realtek/rtd1619-mjolnir.dts      |  40 +++++
 arch/arm64/boot/dts/realtek/rtd1619.dtsi      |  12 ++
 arch/arm64/boot/dts/realtek/rtd16xx.dtsi      | 154 ++++++++++++++++++
 4 files changed, 208 insertions(+)
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1619.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd16xx.dtsi

diff --git a/arch/arm64/boot/dts/realtek/Makefile b/arch/arm64/boot/dts/realtek/Makefile
index 555638ada721..8f6aa77c265b 100644
--- a/arch/arm64/boot/dts/realtek/Makefile
+++ b/arch/arm64/boot/dts/realtek/Makefile
@@ -7,3 +7,5 @@ dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-probox2-ava.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-zidoo-x9s.dtb
 
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1296-ds418.dtb
+
+dtb-$(CONFIG_ARCH_REALTEK) += rtd1619-mjolnir.dtb
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts b/arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts
new file mode 100644
index 000000000000..fd59b086e5d8
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Copyright (c) 2019 Realtek Semiconductor Corp.
+ */
+
+/dts-v1/;
+
+#include "rtd1619.dtsi"
+
+/ {
+	compatible = "realtek,rtd1619","realtek,mjolnir";
+	model= "Realtek Mjolnir EVB";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x80000000>;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+	};
+};
+
+&uart0 {
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
diff --git a/arch/arm64/boot/dts/realtek/rtd1619.dtsi b/arch/arm64/boot/dts/realtek/rtd1619.dtsi
new file mode 100644
index 000000000000..e52bf708b04e
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1619.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Realtek RTD1619 SoC
+ *
+ * Copyright (c) 2019 Realtek Semiconductor Corp.
+ */
+
+#include "rtd16xx.dtsi"
+
+/ {
+	compatible = "realtek,rtd1619";
+};
diff --git a/arch/arm64/boot/dts/realtek/rtd16xx.dtsi b/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
new file mode 100644
index 000000000000..b23e675e2816
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd16xx.dtsi
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Realtek RTD16xx SoC family
+ *
+ * Copyright (c) 2019 Realtek Semiconductor Corp.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/{
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
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
+			next-level-cache = <&l3>;
+		};
+
+		cpu2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x200>;
+			enable-method = "psci";
+			next-level-cache = <&l3>;
+		};
+
+		cpu3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x300>;
+			enable-method = "psci";
+			next-level-cache = <&l3>;
+		};
+
+		cpu4: cpu@400 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x400>;
+			enable-method = "psci";
+			next-level-cache = <&l3>;
+		};
+
+		cpu5: cpu@500 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x500>;
+			enable-method = "psci";
+			next-level-cache = <&l3>;
+		};
+
+		l2: l2-cache {
+			compatible = "cache";
+			next-level-cache = <&l3>;
+
+		};
+
+		l3: l3-cache {
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
+	rbus: r-bus@98000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x98000000 0x0 0x98000000 0x200000>;
+
+		uart0: serial0@98007800 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x98007800 0x400>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <27000000>;
+			status = "disabled";
+		};
+
+		uart1: serial1@9801b200 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x9801b200 0x400>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <432000000>;
+			status = "disabled";
+		};
+
+		uart2: serial2@9801b400 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x9801b400 0x400>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <432000000>;
+			status = "disabled";
+		};
+	};
+
+	gic: interrupt-controller@ff100000 {
+		compatible = "arm,gic-v3";
+		reg = <0x0 0xff100000 0x0 0x10000>,
+		      <0x0 0xff140000 0x0 0xc0000>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
+
+&arm_pmu {
+	interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>,
+		<&cpu3>, <&cpu4>, <&cpu5>;
+};
-- 
2.17.1

