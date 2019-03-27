Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E29AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F162075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="NHEKNCUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbfC0XRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:17:03 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:58430 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfC0XRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1553728618; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5Ll59DErd5wGJ3pnn+Wyg9b/lmHZ+0+DsY/1n4SmGV8=;
        b=NHEKNCUvkYUjmH7zrf136s4694WJWVTYrRJMAbVqa1IVlPGg3Q/rHdzjZ8IeQs5wZ17+j/
        nIRVm1nlyegYGiODjgIPedmrp2pgbUxp8EBL1Hg0FucPdQC6alpXTJFPzBOpvFiVugT4PI
        zcP4t7jUkzeJKZL5XkyYh0rc/YMIr9U=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Mathieu Malaterre <malat@debian.org>, od@zcrc.me,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v11 03/27] dt-bindings: Add doc for the Ingenic TCU drivers
Date:   Thu, 28 Mar 2019 00:16:07 +0100
Message-Id: <20190327231631.15708-4-paul@crapouillou.net>
In-Reply-To: <20190327231631.15708-1-paul@crapouillou.net>
References: <20190327231631.15708-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation about how to properly use the Ingenic TCU
(Timer/Counter Unit) drivers from devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---
 .../devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt |  25 ----
 .../devicetree/bindings/timer/ingenic,tcu.txt      | 139 +++++++++++++++++++++
 .../bindings/watchdog/ingenic,jz4740-wdt.txt       |  17 ---
 3 files changed, 139 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/timer/ingenic,tcu.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt

diff --git a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
deleted file mode 100644
index 7d9d3f90641b..000000000000
--- a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Ingenic JZ47xx PWM Controller
-=============================
-
-Required properties:
-- compatible: One of:
-  * "ingenic,jz4740-pwm"
-  * "ingenic,jz4770-pwm"
-  * "ingenic,jz4780-pwm"
-- #pwm-cells: Should be 3. See pwm.txt in this directory for a description
-  of the cells format.
-- clocks : phandle to the external clock.
-- clock-names : Should be "ext".
-
-
-Example:
-
-	pwm: pwm@10002000 {
-		compatible = "ingenic,jz4740-pwm";
-		reg = <0x10002000 0x1000>;
-
-		#pwm-cells = <3>;
-
-		clocks = <&ext>;
-		clock-names = "ext";
-	};
diff --git a/Documentation/devicetree/bindings/timer/ingenic,tcu.txt b/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
new file mode 100644
index 000000000000..0a381cf9d286
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
@@ -0,0 +1,139 @@
+Ingenic JZ47xx SoCs Timer/Counter Unit devicetree bindings
+==========================================================
+
+For a description of the TCU hardware and drivers, have a look at
+Documentation/mips/ingenic-tcu.txt.
+
+Required properties:
+
+- compatible: Must be one of:
+  * ingenic,jz4740-tcu
+  * ingenic,jz4725b-tcu
+  * ingenic,jz4770-tcu
+- reg: Should be the offset/length value corresponding to the TCU registers
+- clocks: List of phandle & clock specifiers for clocks external to the TCU.
+  The "pclk", "rtc", "ext" and "tcu" clocks should be provided.
+- clock-names: List of name strings for the external clocks.
+- #clock-cells: Should be <1>;
+  Clock consumers specify this argument to identify a clock. The valid values
+  may be found in <dt-bindings/clock/ingenic,tcu.h>.
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value should be 1.
+- interrupt-parent : phandle of the interrupt controller.
+- interrupts : Specifies the interrupt the controller is connected to.
+
+Optional properties:
+
+- ingenic,pwm-channels-mask: Bitmask of TCU channels reserved for PWM use.
+  Default value is 0xfc.
+
+
+Children nodes
+==========================================================
+
+
+PWM node:
+---------
+
+Required properties:
+
+- compatible: Must be one of:
+  * ingenic,jz4740-pwm
+  * ingenic,jz4725b-pwm
+- #pwm-cells: Should be 3. See ../pwm/pwm.txt for a description of the cell
+  format.
+- clocks: List of phandle & clock specifiers for the TCU clocks.
+- clock-names: List of name strings for the TCU clocks.
+
+
+Watchdog node:
+--------------
+
+Required properties:
+
+- compatible: Must be one of:
+  * ingenic,jz4740-watchdog
+  * ingenic,jz4780-watchdog
+- clocks: phandle to the WDT clock
+- clock-names: should be "wdt"
+
+
+OS Timer node:
+---------
+
+Required properties:
+
+- compatible: Must be one of:
+  * ingenic,jz4725b-ost
+  * ingenic,jz4770-ost
+- clocks: phandle to the OST clock
+- clock-names: should be "ost"
+- interrupts : Specifies the interrupt the OST is connected to.
+
+
+Example
+==========================================================
+
+#include <dt-bindings/clock/jz4770-cgu.h>
+#include <dt-bindings/clock/ingenic,tcu.h>
+
+/ {
+	tcu: timer@10002000 {
+		compatible = "ingenic,jz4770-tcu";
+		reg = <0x10002000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x10002000 0x1000>;
+
+		#clock-cells = <1>;
+
+		clocks = <&cgu JZ4770_CLK_RTC
+			  &cgu JZ4770_CLK_EXT
+			  &cgu JZ4770_CLK_PCLK
+			  &cgu JZ4770_CLK_EXT>;
+		clock-names = "rtc", "ext", "pclk", "tcu";
+
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <27 26 25>;
+
+		watchdog: watchdog@0 {
+			compatible = "ingenic,jz4740-watchdog";
+			reg = <0x0 0xc>;
+
+			clocks = <&tcu TCU_CLK_WDT>;
+			clock-names = "wdt";
+		};
+
+		pwm: pwm@40 {
+			compatible = "ingenic,jz4740-pwm";
+			reg = <0x40 0x80>;
+
+			#pwm-cells = <3>;
+
+			clocks = <&tcu TCU_CLK_TIMER0
+				  &tcu TCU_CLK_TIMER1
+				  &tcu TCU_CLK_TIMER2
+				  &tcu TCU_CLK_TIMER3
+				  &tcu TCU_CLK_TIMER4
+				  &tcu TCU_CLK_TIMER5
+				  &tcu TCU_CLK_TIMER6
+				  &tcu TCU_CLK_TIMER7>;
+			clock-names = "timer0", "timer1", "timer2", "timer3",
+				      "timer4", "timer5", "timer6", "timer7";
+		};
+
+		ost: timer@e0 {
+			compatible = "ingenic,jz4770-ost";
+			reg = <0xe0 0x20>;
+
+			clocks = <&tcu TCU_CLK_OST>;
+			clock-names = "ost";
+
+			interrupts = <15>;
+		};
+	};
+};
diff --git a/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt b/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt
deleted file mode 100644
index ce1cb72d5345..000000000000
--- a/Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Ingenic Watchdog Timer (WDT) Controller for JZ4740 & JZ4780
-
-Required properties:
-compatible: "ingenic,jz4740-watchdog" or "ingenic,jz4780-watchdog"
-reg: Register address and length for watchdog registers
-clocks: phandle to the RTC clock
-clock-names: should be "rtc"
-
-Example:
-
-watchdog: jz4740-watchdog@10002000 {
-	compatible = "ingenic,jz4740-watchdog";
-	reg = <0x10002000 0x10>;
-
-	clocks = <&cgu JZ4740_CLK_RTC>;
-	clock-names = "rtc";
-};
-- 
2.11.0

