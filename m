Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DAFC48BD3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4B120663
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfFYA2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 20:28:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:50534 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726395AbfFYA2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 20:28:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 45525ADD5;
        Tue, 25 Jun 2019 00:28:38 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-csky@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH] csky: dts: Add NationalChip GX6605S
Date:   Tue, 25 Jun 2019 02:28:29 +0200
Message-Id: <20190625002829.17409-1-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Device Trees for NationalChip GX6605S SoC (based on CK610 CPU) and its
dev board. GxLoader expects as filename gx6605s.dtb, so keep that.
The bootargs are prepared to boot from USB and to output to serial.

Compatibles for the SoC and board are left out for now.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/csky/boot/dts/gx6605s.dts  | 104 ++++++++++++++++++++++++++++++++++++++++
 arch/csky/boot/dts/gx6605s.dtsi |  82 +++++++++++++++++++++++++++++++
 2 files changed, 186 insertions(+)
 create mode 100644 arch/csky/boot/dts/gx6605s.dts
 create mode 100644 arch/csky/boot/dts/gx6605s.dtsi

diff --git a/arch/csky/boot/dts/gx6605s.dts b/arch/csky/boot/dts/gx6605s.dts
new file mode 100644
index 000000000000..f7511024ec6f
--- /dev/null
+++ b/arch/csky/boot/dts/gx6605s.dts
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause */
+/*
+ * GX6605S dev board
+ *
+ * Copyright (c) 2019 Andreas Färber
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+
+#include "gx6605s.dtsi"
+
+/ {
+	model = "Nationalchip GX6605S";
+
+	aliases {
+		serial0 = &uart;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 root=/dev/sda2 rw rootwait";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@10000000 {
+		device_type = "memory";
+		reg = <0x10000000 0x04000000>;
+	};
+
+	dummy_apb_clk: dummy-apb-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>; /* guesstimate */
+		#clock-cells = <0>;
+	};
+
+	buttons {
+		compatible = "gpio-keys-polled";
+		poll-interval = <100>;
+		autorepeat;
+
+		button5 {
+			label = "button5";
+			linux,code = <103>;
+			gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
+		};
+
+		button6 {
+			label = "button6";
+			linux,code = <106>;
+			gpios = <&gpio 6 GPIO_ACTIVE_LOW>;
+		};
+
+		button7 {
+			label = "button7";
+			linux,code = <28>;
+			gpios = <&gpio 7 GPIO_ACTIVE_LOW>;
+		};
+
+		button8 {
+			label = "button8";
+			linux,code = <105>;
+			gpios = <&gpio 8 GPIO_ACTIVE_LOW>;
+		};
+
+		button9 {
+			label = "button9";
+			linux,code = <108>;
+			gpios = <&gpio 9 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led0 {
+			label = "led10";
+			gpios = <&gpio 10 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led1 {
+			label = "led11";
+			gpios = <&gpio 11 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "timer";
+		};
+
+		led2 {
+			label = "led12";
+			gpios = <&gpio 12 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-on";
+		};
+
+		led3 {
+			label = "led13";
+			gpios = <&gpio 13 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-on";
+		};
+	};
+};
+
+&timer0 {
+		clocks = <&dummy_apb_clk>;
+};
diff --git a/arch/csky/boot/dts/gx6605s.dtsi b/arch/csky/boot/dts/gx6605s.dtsi
new file mode 100644
index 000000000000..956af5674add
--- /dev/null
+++ b/arch/csky/boot/dts/gx6605s.dtsi
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause */
+/*
+ * NationalChip GX6605S SoC
+ *
+ * Copyright (c) 2019 Andreas Färber
+ */
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "csky,ck610";
+			reg = <0>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&intc>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		timer0: timer@20a000 {
+			compatible = "csky,gx6605s-timer";
+			reg = <0x0020a000 0x400>;
+			clocks = <&dummy_apb_clk>;
+			interrupts = <10>;
+		};
+
+		gpio: gpio@305000 {
+			compatible = "wd,mbl-gpio";
+			reg-names = "dirout", "dat", "set", "clr";
+			reg = <0x00305000 0x4>,
+			      <0x00305004 0x4>,
+			      <0x00305008 0x4>,
+			      <0x0030500c 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		uart: serial@403000 {
+			compatible = "ns16550a";
+			reg = <0x00403000 0x400>;
+			interrupts = <15>;
+			clock-frequency = <29491200>;
+			reg-shift = <2>;
+			reg-io-width = <1>;
+		};
+
+		intc: interrupt-controller@500000 {
+			compatible = "csky,gx6605s-intc";
+			reg = <0x00500000 0x400>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		ehci_hcd: usb@900000 {
+			compatible = "generic-ehci";
+			reg = <0x00900000 0x400>;
+			interrupts = <59>;
+		};
+
+		ohci_hcd0: usb@a00000 {
+			compatible = "generic-ohci";
+			reg = <0x00a00000 0x400>;
+			interrupts = <58>;
+		};
+
+		ohci_hcd1: usb@b00000 {
+			compatible = "generic-ohci";
+			reg = <0x00b00000 0x400>;
+			interrupts = <57>;
+		};
+	};
+};
-- 
2.16.4

