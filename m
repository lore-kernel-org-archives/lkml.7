Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3C6C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7AA21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfDXJGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:06:09 -0400
Received: from atl4mhfb04.myregisteredsite.com ([209.17.115.120]:41760 "EHLO
        atl4mhfb04.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727329AbfDXJGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:06:06 -0400
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Apr 2019 05:06:05 EDT
Received: from jax4mhob21.registeredsite.com (jax4mhob21.registeredsite.com [64.69.218.109])
        by atl4mhfb04.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id x3O92ROh026499
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 05:02:27 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.206])
        by jax4mhob21.registeredsite.com (8.14.4/8.14.4) with ESMTP id x3O92P71092996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 05:02:25 -0400
Received: (qmail 9435 invoked by uid 0); 24 Apr 2019 09:02:24 -0000
X-TCPREMOTEIP: 81.173.50.109
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO mikebuntu.TOPIC.LOCAL) (mike@milosoftware.com@81.173.50.109)
  by 0 with ESMTPA; 24 Apr 2019 09:02:24 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] dt-bindings: Add silabs,si5341
Date:   Wed, 24 Apr 2019 11:02:16 +0200
Message-Id: <20190424090216.18417-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the devicetree bindings for the si5341 driver that supports the
Si5341 and Si5340 chips.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 .../bindings/clock/silabs,si5341.txt          | 141 ++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/silabs,si5341.txt

diff --git a/Documentation/devicetree/bindings/clock/silabs,si5341.txt b/Documentation/devicetree/bindings/clock/silabs,si5341.txt
new file mode 100644
index 000000000000..1a00dd83100f
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/silabs,si5341.txt
@@ -0,0 +1,141 @@
+Binding for Silicon Labs Si5341 and Si5340 programmable i2c clock generator.
+
+Reference
+[1] Si5341 Data Sheet
+    https://www.silabs.com/documents/public/reference-manuals/Si5341-40-D-RM.pdf
+
+The Si5341 and Si5340 are programmable i2c clock generators with up to 10 output
+clocks. The chip contains a PLL that sources 5 (or 4) multisynth clocks, which
+in turn can be directed to any of the 10 (or 4) outputs through a divider.
+The internal structure of the clock generators can be found in [1].
+
+The driver can be used in "as is" mode, reading the current settings from the
+chip at boot, in case you have a (pre-)programmed device. If the PLL is not
+configured when the driver probes, it assumes the driver must fully initialize
+it.
+
+The device type, speed grade and revision are determined runtime by probing.
+
+The driver currently only supports XTAL input mode, and does not support any
+fancy input configurations. They can still be programmed into the chip and
+the driver will leave them "as is".
+
+==I2C device node==
+
+Required properties:
+- compatible: shall be one of the following: "silabs,si5341", "silabs,si5340"
+- reg: i2c device address, usually 0x74
+- #clock-cells: from common clock binding; shall be set to 1.
+- clocks: from common clock binding; list of parent clock
+  handles, shall be xtal reference clock. Usually a fixed clock.
+- clock-names: Shall be "xtal".
+- #address-cells: shall be set to 1.
+- #size-cells: shall be set to 0.
+
+Optional properties:
+- silabs,pll-m-num, silabs,pll-m-den: Numerator and denominator for PLL
+  feedback divider. Must be such that the PLL output is in the valid range. For
+  example, to create 14GHz from a 48MHz xtal, use m-num=14000 and m-den=48. Only
+  the fraction matters, using 3500 and 12 will deliver the exact same result.
+  If these are not specified, and the PLL is not yet programmed when the driver
+  probes, the PLL will be set to 14GHz.
+- silabs,reprogram: When present, the driver will always assume the device must
+  be initialized, and always performs the soft-reset routine. Since this will
+  temporarily stop all output clocks, don't do this if the chip is generating
+  the CPU clock for example.
+
+==Child nodes==
+
+Each of the clock outputs can be overwritten individually by
+using a child node to the I2C device node. If a child node for a clock
+output is not set, the configuration remains unchanged.
+
+Required child node properties:
+- reg: number of clock output.
+
+Optional child node properties:
+- silabs,format: Output format, see [1], 1=differential, 2=low-power, 4=LVCMOS
+- silabs,common-mode: Output common mode, depends on standard.
+- silabs,amplitude: Output amplitude, depends on standard.
+- silabs,synth-source: Select which multisynth to use for this output
+- silabs,synth-frequency: Sets the frequency for the multisynth connected to
+  this output. This will affect other outputs connected to this multisynth. The
+  setting is applied before silabs,synth-master and clock-frequency.
+- silabs,synth-master: If present, this output is allowed to change the
+  multisynth frequency dynamically.
+- clock-frequency: Sets a default frequency for this output.
+- always-on: Immediately and permanently enable this output. Particulary
+  useful when combined with assigned-clocks, since that does not prepare clocks.
+
+==Example==
+
+/* 48MHz reference crystal */
+ref48: ref48M {
+	compatible = "fixed-clock";
+	#clock-cells = <0>;
+	clock-frequency = <48000000>;
+};
+
+i2c-master-node {
+
+	/* Programmable clock (for logic) */
+	si5341: clock-generator@74 {
+		reg = <0x74>;
+		compatible = "silabs,si5341";
+		#clock-cells = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&ref48>;
+		clock-names = "xtal";
+
+		silabs,pll-m-num = <14000>; /* PLL at 14.0 GHz */
+		silabs,pll-m-den = <48>;
+		silabs,reprogram; /* Chips are not programmed, always reset */
+
+		/*
+		 * Output 0 configuration:
+		 *  LVDS 3v3
+		 *  Source from Multisynth 3
+		 *  Use 600MHz synth frequency, and generate 100MHz from that
+		 *  Always keep this clock running
+		 */
+		out0 {
+			/* refclk0 for PS-GT, usually for SATA or PCIe */
+			reg = <0>;
+			silabs,format = <1>; /* LVDS 3v3 */
+			silabs,common-mode = <3>;
+			silabs,amplitude = <3>;
+			silabs,synth-source = <3>; /* Multisynth 3 */
+			silabs,synth-frequency = <600000000>;
+			silabs,synth-master;
+			clock-frequency = <10000000>;
+			always-on;
+		};
+
+		/*
+		 * Output 6 configuration:
+		 *  LVDS 1v8
+		 */
+		out6 {
+			/* FPGA clock 200MHz */
+			reg = <6>;
+			silabs,format = <1>; /* LVDS 1v8 */
+			silabs,common-mode = <13>;
+			silabs,amplitude = <3>;
+		};
+
+		/*
+		 * Output 8 configuration:
+		 *  HCSL 3v3
+		 *  run at 100MHz
+		 */
+		out8 {
+			reg = <8>;
+			silabs,format = <2>;
+			silabs,common-mode = <11>;
+			silabs,amplitude = <3>;
+			silabs,synth-source = <0>;
+			clock-frequency = <100000000>;
+		};
+	};
+};
-- 
2.17.1

