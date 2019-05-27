Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE61C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F03B214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfE0MRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:17:19 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:52678 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbfE0MRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:17:18 -0400
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id HQHF2000l3XaVaC01QHFwY; Mon, 27 May 2019 14:17:16 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVEZ1-0001Su-Oa; Mon, 27 May 2019 14:17:15 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hVEZ1-0001Lg-NX; Mon, 27 May 2019 14:17:15 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Chris Brandt <chris.brandt@renesas.com>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 1/2] dt-bindings: interrupt-controller: Add Renesas RZ/A1 Interrupt Controller
Date:   Mon, 27 May 2019 14:17:10 +0200
Message-Id: <20190527121711.5138-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527121711.5138-1-geert+renesas@glider.be>
References: <20190527121711.5138-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for the Renesas RZ/A1 Interrupt Controller.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v4:
  - Add Reviewed-by,

v3:
  - Use interrupt-map (+ #address-cells and interrupt-map-mask) instead
    of renesas,gic-spi-base,

v2:
  - Add "renesas,gic-spi-base",
  - Document RZ/A2M.
---
 .../renesas,rza1-irqc.txt                     | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rza1-irqc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rza1-irqc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,rza1-irqc.txt
new file mode 100644
index 0000000000000000..727b7e4cd6e01110
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rza1-irqc.txt
@@ -0,0 +1,43 @@
+DT bindings for the Renesas RZ/A1 Interrupt Controller
+
+The RZ/A1 Interrupt Controller is a front-end for the GIC found on Renesas
+RZ/A1 and RZ/A2 SoCs:
+  - IRQ sense select for 8 external interrupts, 1:1-mapped to 8 GIC SPI
+    interrupts,
+  - NMI edge select.
+
+Required properties:
+  - compatible: Must be "renesas,<soctype>-irqc", and "renesas,rza1-irqc" as
+		fallback.
+		Examples with soctypes are:
+		  - "renesas,r7s72100-irqc" (RZ/A1H)
+		  - "renesas,r7s9210-irqc" (RZ/A2M)
+  - #interrupt-cells: Must be 2 (an interrupt index and flags, as defined
+				 in interrupts.txt in this directory)
+  - #address-cells: Must be zero
+  - interrupt-controller: Marks the device as an interrupt controller
+  - reg: Base address and length of the memory resource used by the interrupt
+         controller
+  - interrupt-map: Specifies the mapping from external interrupts to GIC
+		   interrupts
+  - interrupt-map-mask: Must be <7 0>
+
+Example:
+
+	irqc: interrupt-controller@fcfef800 {
+		compatible = "renesas,r7s72100-irqc", "renesas,rza1-irqc";
+		#interrupt-cells = <2>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0xfcfef800 0x6>;
+		interrupt-map =
+			<0 0 &gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+			<1 0 &gic GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+			<2 0 &gic GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+			<3 0 &gic GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+			<4 0 &gic GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+			<5 0 &gic GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+			<6 0 &gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+			<7 0 &gic GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map-mask = <7 0>;
+	};
-- 
2.17.1

