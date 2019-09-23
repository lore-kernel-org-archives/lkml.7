Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACA5C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A8521655
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439402AbfIWKPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 06:15:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57822 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439241AbfIWKPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 06:15:35 -0400
Received: from [5.158.153.52] (helo=kurt.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt@linutronix.de>)
        id 1iCLNS-0001oR-WA; Mon, 23 Sep 2019 12:15:31 +0200
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        devicetree@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH v6 2/2] dt/bindings: Add bindings for Layerscape external irqs
Date:   Mon, 23 Sep 2019 12:15:13 +0200
Message-Id: <20190923101513.32719-3-kurt@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923101513.32719-1-kurt@linutronix.de>
References: <20190923101513.32719-1-kurt@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

This adds Device Tree binding documentation for the external interrupt
lines with configurable polarity present on some Layerscape SOCs.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---

Changes since v5:

 - Add #address-cells and #size-cells to parent
 - Mention LS2088A and the ISC unit

.../interrupt-controller/fsl,ls-extirq.txt    | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
new file mode 100644
index 000000000000..7b53f9cc8019
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
@@ -0,0 +1,47 @@
+* Freescale Layerscape external IRQs
+
+Some Layerscape SOCs (LS1021A, LS1043A, LS1046A, LS2088A) support
+inverting the polarity of certain external interrupt lines.
+
+The device node must be a child of the node representing the
+Supplemental Configuration Unit (SCFG) or the Interrupt Sampling
+Control (ISC) Unit.
+
+Required properties:
+- compatible: should be "fsl,<soc-name>-extirq", e.g. "fsl,ls1021a-extirq".
+- interrupt-controller: Identifies the node as an interrupt controller
+- #interrupt-cells: Must be 2. The first element is the index of the
+  external interrupt line. The second element is the trigger type.
+- interrupt-parent: phandle of GIC.
+- reg: Specifies the Interrupt Polarity Control Register (INTPCR) in the SCFG.
+- fsl,extirq-map: Specifies the mapping to interrupt numbers in the parent
+  interrupt controller. Interrupts are mapped one-to-one to parent
+  interrupts.
+
+Optional properties:
+- fsl,bit-reverse: This boolean property should be set on the LS1021A
+  if the SCFGREVCR register has been set to all-ones (which is usually
+  the case), meaning that all reads and writes of SCFG registers are
+  implicitly bit-reversed. Other compatible platforms do not have such
+  a register.
+
+Example:
+	scfg: scfg@1570000 {
+		compatible = "fsl,ls1021a-scfg", "syscon";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		...
+		extirq: interrupt-controller {
+			compatible = "fsl,ls1021a-extirq";
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			interrupt-parent = <&gic>;
+			reg = <0x1ac>;
+			fsl,extirq-map = <163 164 165 167 168 169>;
+			fsl,bit-reverse;
+		};
+	};
+
+
+	interrupts-extended = <&gic GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+			      <&extirq 1 IRQ_TYPE_LEVEL_LOW>;
-- 
2.20.1

