Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E25C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E9E2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 04:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ne4FYldH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfDJEPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 00:15:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34380 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfDJEPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 00:15:07 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3A4En1W127809;
        Tue, 9 Apr 2019 23:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554869689;
        bh=vl3lda1kO5ppm0bVL49eWVITNO4PwCELEtnb0/iqvhY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ne4FYldHyBrWNRrDKe67Ue4G0TOm2AXhwpxNXTh9zh1nx1kDjvsV/Ws+zoW3L+IvU
         xnzF6FTM9fvUEHY4lCcCb5oVGv0czOkqxwQG+NwHv43DHkUxt4mpkQBHSMpBg/1Cwl
         AbIKvy41g16lYm78AtM+X9cEnhnHEx9zOK7LrqII=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3A4Envs070407
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Apr 2019 23:14:49 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 9 Apr
 2019 23:14:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 9 Apr 2019 23:14:49 -0500
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3A4EKZR029255;
        Tue, 9 Apr 2019 23:14:45 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <jason@lakedaemon.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v6 06/12] dt-bindings: irqchip: Introduce TISCI Interrupt router bindings
Date:   Wed, 10 Apr 2019 09:43:52 +0530
Message-ID: <20190410041358.16809-7-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190410041358.16809-1-lokeshvutla@ti.com>
References: <20190410041358.16809-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT binding documentation for Interrupt router driver.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v5:
- Introduced a new property for specifying router trigger type.
- Dropped the trigger type from interrupt cells property.

Marc,
	Firmware change to not differentiate INTA interrupts and peripheral
	interrupts might take couple more weeks, but it is going to come.
	I am posting this series to get a review on the INTA driver.

 .../interrupt-controller/ti,sci-intr.txt      | 83 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
new file mode 100644
index 000000000000..613911013db1
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
@@ -0,0 +1,83 @@
+Texas Instruments K3 Interrupt Router
+=====================================
+
+The Interrupt Router (INTR) module provides a mechanism to mux M
+interrupt inputs to N interrupt outputs, where all M inputs are selectable
+to be driven per N output. An Interrupt Router can either handle edge triggered
+or level triggered interrupts and that is fixed in hardware.
+
+                                 Interrupt Router
+                             +----------------------+
+                             |  Inputs     Outputs  |
+        +-------+            | +------+             |
+        | GPIO  |----------->| | irq0 |             |       Host IRQ
+        +-------+            | +------+             |      controller
+                             |    .        +-----+  |      +-------+
+        +-------+            |    .        |  0  |  |----->|  IRQ  |
+        | INTA  |----------->|    .        +-----+  |      +-------+
+        +-------+            |    .          .      |
+                             | +------+      .      |
+                             | | irqM |    +-----+  |
+                             | +------+    |  N  |  |
+                             |             +-----+  |
+                             +----------------------+
+
+There is one register per output (MUXCNTL_N) that controls the selection.
+Configuration of these MUXCNTL_N registers is done by a system controller
+(like the Device Memory and Security Controller on K3 AM654 SoC). System
+controller will keep track of the used and unused registers within the Router.
+Driver should request the system controller to get the range of GIC IRQs
+assigned to the requesting hosts. It is the drivers responsibility to keep
+track of Host IRQs.
+
+Communication between the host processor running an OS and the system
+controller happens through a protocol called TI System Control Interface
+(TISCI protocol). For more details refer:
+Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+
+TISCI Interrupt Router Node:
+----------------------------
+Required Properties:
+- compatible:		Must be "ti,sci-intr".
+- ti,intr-trigger-type:	Should be 1 if the interrupt router supports edge
+			triggered interrupts, 4 for level triggered interrupts.
+- interrupt-controller:	Identifies the node as an interrupt controller
+- #interrupt-cells:	Specifies the number of cells needed to encode an
+			interrupt source. The value should be 3.
+			First cell should contain the TISCI device ID of source
+			Second cell should contain the interrupt source offset
+			within the device.
+			Third cell should be 1 if the irq is coming from the
+			interrupt aggregator else 0.
+- ti,sci:		Phandle to TI-SCI compatible System controller node.
+- ti,sci-dst-id:	TISCI device ID of the destination IRQ controller.
+- ti,sci-rm-range-girq:	Array of TISCI subtype ids representing the host irqs
+			assigned to this interrupt router. Each subtype id
+			corresponds to a range of host irqs.
+
+For more details on TISCI IRQ resource management refer:
+http://downloads.ti.com/tisci/esd/latest/2_tisci_msgs/rm/rm_irq.html
+
+Example:
+--------
+The following example demonstrates both interrupt router node and the consumer
+node(main gpio) on the AM654 SoC:
+
+main_intr: interrupt-controller0 {
+	compatible = "ti,sci-intr";
+	ti,intr-trigger-type = <1>;
+	interrupt-controller;
+	interrupt-parent = <&gic500>;
+	#interrupt-cells = <3>;
+	ti,sci = <&dmsc>;
+	ti,sci-dst-id = <56>;
+	ti,sci-rm-range-girq = <0x1>;
+};
+
+main_gpio0: gpio@600000 {
+	...
+	interrupt-parent = <&main_intr>;
+	interrupts = <57 256 0>, <57 257 0>, <57 258 0>,
+		     <57 259 0>, <57 260 0>, <57 261 0>;
+	...
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 2359e12e4c41..9c4e71187ca1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15349,6 +15349,7 @@ F:	Documentation/devicetree/bindings/reset/ti,sci-reset.txt
 F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
 F:	drivers/clk/keystone/sci-clk.c
 F:	drivers/reset/reset-ti-sci.c
+F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
 
 Texas Instruments ASoC drivers
 M:	Peter Ujfalusi <peter.ujfalusi@ti.com>
-- 
2.21.0

