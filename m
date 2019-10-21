Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5BFCA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06AD22466
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 02:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfJUCKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 22:10:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:57670 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726866AbfJUCKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 22:10:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 27E4CB294;
        Mon, 21 Oct 2019 02:10:45 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: Prepare Realtek RTD1195 and MeLE X1000
Date:   Mon, 21 Oct 2019 04:10:35 +0200
Message-Id: <20191021021035.7032-4-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191021021035.7032-1-afaerber@suse.de>
References: <20191021021035.7032-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Device Trees for Realtek RTD1195 SoC and MeLE X1000 TV box.

Reuse the existing RTD1295 watchdog compatible for now.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/arm/boot/dts/Makefile               |   2 +
 arch/arm/boot/dts/rtd1195-mele-x1000.dts |  30 ++++++++
 arch/arm/boot/dts/rtd1195.dtsi           | 128 +++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+)
 create mode 100644 arch/arm/boot/dts/rtd1195-mele-x1000.dts
 create mode 100644 arch/arm/boot/dts/rtd1195.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 73d33611c372..89a951485da8 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -858,6 +858,8 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 dtb-$(CONFIG_ARCH_RDA) += \
 	rda8810pl-orangepi-2g-iot.dtb \
 	rda8810pl-orangepi-i96.dtb
+dtb-$(CONFIG_ARCH_REALTEK) += \
+	rtd1195-mele-x1000.dtb
 dtb-$(CONFIG_ARCH_REALVIEW) += \
 	arm-realview-pb1176.dtb \
 	arm-realview-pb11mp.dtb \
diff --git a/arch/arm/boot/dts/rtd1195-mele-x1000.dts b/arch/arm/boot/dts/rtd1195-mele-x1000.dts
new file mode 100644
index 000000000000..ce9a255950d3
--- /dev/null
+++ b/arch/arm/boot/dts/rtd1195-mele-x1000.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Copyright (c) 2017 Andreas Färber
+ */
+
+/dts-v1/;
+
+#include "rtd1195.dtsi"
+
+/ {
+	compatible = "mele,x1000", "realtek,rtd1195";
+	model = "MeLE X1000";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x40000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/rtd1195.dtsi b/arch/arm/boot/dts/rtd1195.dtsi
new file mode 100644
index 000000000000..475740c67d26
--- /dev/null
+++ b/arch/arm/boot/dts/rtd1195.dtsi
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Copyright (c) 2017 Andreas Färber
+ */
+
+/memreserve/ 0x00000000 0x0000c000; /* boot code */
+/memreserve/ 0x0000c000 0x000f4000;
+/memreserve/ 0x01b00000 0x00400000; /* audio */
+/memreserve/ 0x01ffe000 0x00004000; /* rpc ringbuf */
+/memreserve/ 0x10000000 0x00100000; /* secure */
+/memreserve/ 0x17fff000 0x00001000;
+/memreserve/ 0x18000000 0x00100000; /* rbus */
+/memreserve/ 0x18100000 0x01000000; /* nor */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "realtek,rtd1195";
+	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x0>;
+			clock-frequency = <1000000000>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x1>;
+			clock-frequency = <1000000000>;
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		secure@10000000 {
+			reg = <0x10000000 0x100000>;
+			no-map;
+		};
+
+		rbus@18000000 {
+			reg = <0x18000000 0x100000>;
+			no-map;
+		};
+
+		nor@18100000 {
+			reg = <0x18100000 0x1000000>;
+			no-map;
+		};
+	};
+
+	arm-pmu {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>;
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <GIC_PPI 13
+			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14
+			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11
+			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10
+			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>;
+		clock-frequency = <27000000>;
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
+		ranges;
+
+		wdt: watchdog@18007680 {
+			compatible = "realtek,rtd1295-watchdog";
+			reg = <0x18007680 0x100>;
+			clocks = <&osc27M>;
+		};
+
+		uart0: serial@18007800 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x18007800 0x400>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <27000000>;
+			status = "disabled";
+		};
+
+		uart1: serial@1801b200 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x1801b200 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <27000000>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller@ff011000 {
+			compatible = "arm,cortex-a7-gic";
+			reg = <0xff011000 0x1000>,
+			      <0xff012000 0x2000>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+	};
+};
-- 
2.16.4

