Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B257DC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75AD22183F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RGTr/tRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfDTKLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 06:11:54 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45844 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfDTKLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 06:11:51 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3KAB8Bf008006;
        Sat, 20 Apr 2019 05:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555755068;
        bh=+EcleQFsjn9IyCJOG5f1Gabc1660ZJVaGPOaRYpHL6w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RGTr/tRefqmVcqrhA3Fx7XrdGYS9ae284jozniuy70kXQ2ooTx0oIt3dzZomqXgyV
         36bOaBBpfRwDyud08QjNlGdV8Muuqot8fg30bjuwRUznc7l9goySH7qmKQHDY+YUkN
         0u5iu6vB+k5QHPJssmdmekeGnqSXieRbp2M3kGn8=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3KAB8gt060541
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 20 Apr 2019 05:11:08 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Sat, 20
 Apr 2019 05:11:07 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Sat, 20 Apr 2019 05:11:07 -0500
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3KAAHa1070234;
        Sat, 20 Apr 2019 05:11:03 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>,
        <linus.walleij@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>
Subject: [PATCH v7 10/14] dt-bindings: irqchip: Introduce TISCI Interrupt Aggregator bindings
Date:   Sat, 20 Apr 2019 15:39:46 +0530
Message-ID: <20190420100950.7997-11-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190420100950.7997-1-lokeshvutla@ti.com>
References: <20190420100950.7997-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT binding documentation for Interrupt Aggregator driver.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v6:
- None

 .../interrupt-controller/ti,sci-inta.txt      | 66 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
new file mode 100644
index 000000000000..7841cb099e13
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
@@ -0,0 +1,66 @@
+Texas Instruments K3 Interrupt Aggregator
+=========================================
+
+The Interrupt Aggregator (INTA) provides a centralized machine
+which handles the termination of system events to that they can
+be coherently processed by the host(s) in the system. A maximum
+of 64 events can be mapped to a single interrupt.
+
+
+                              Interrupt Aggregator
+                     +-----------------------------------------+
+                     |      Intmap            VINT             |
+                     | +--------------+  +------------+        |
+            m ------>| | vint  | bit  |  | 0 |.....|63| vint0  |
+               .     | +--------------+  +------------+        |       +------+
+               .     |         .               .               |       | HOST |
+Globalevents  ------>|         .               .               |------>| IRQ  |
+               .     |         .               .               |       | CTRL |
+               .     |         .               .               |       +------+
+            n ------>| +--------------+  +------------+        |
+                     | | vint  | bit  |  | 0 |.....|63| vintx  |
+                     | +--------------+  +------------+        |
+                     |                                         |
+                     +-----------------------------------------+
+
+Configuration of these Intmap registers that maps global events to vint is done
+by a system controller (like the Device Memory and Security Controller on K3
+AM654 SoC). Driver should request the system controller to get the range
+of global events and vints assigned to the requesting host. Management
+of these requested resources should be handled by driver and requests
+system controller to map specific global event to vint, bit pair.
+
+Communication between the host processor running an OS and the system
+controller happens through a protocol called TI System Control Interface
+(TISCI protocol). For more details refer:
+Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+
+TISCI Interrupt Aggregator Node:
+-------------------------------
+- compatible:		Must be "ti,sci-inta".
+- reg:			Should contain registers location and length.
+- interrupt-controller:	Identifies the node as an interrupt controller
+- msi-controller:	Identifies the node as an MSI controller.
+- interrupt-parent:	phandle of irq parent.
+- ti,sci:		Phandle to TI-SCI compatible System controller node.
+- ti,sci-dev-id:	TISCI device ID of the Interrupt Aggregator.
+- ti,sci-rm-range-vint:	Array of TISCI subtype ids representing vints(inta
+			outputs) range within this INTA, assigned to the
+			requesting host context.
+- ti,sci-rm-range-global-event:	Array of TISCI subtype ids representing the
+			global events range reaching this IA and are assigned
+			to the requesting host context.
+
+Example:
+--------
+main_udmass_inta: interrupt-controller@33d00000 {
+	compatible = "ti,sci-inta";
+	reg = <0x0 0x33d00000 0x0 0x100000>;
+	interrupt-controller;
+	msi-controller;
+	interrupt-parent = <&main_navss_intr>;
+	ti,sci = <&dmsc>;
+	ti,sci-dev-id = <179>;
+	ti,sci-rm-range-vint = <0x0>;
+	ti,sci-rm-range-global-event = <0x1>;
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 63851f106b5c..461db0a8233f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15350,6 +15350,7 @@ F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
 F:	drivers/clk/keystone/sci-clk.c
 F:	drivers/reset/reset-ti-sci.c
 F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-intr.txt
+F:	Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
 F:	drivers/irqchip/irq-ti-sci-intr.c
 
 Texas Instruments ASoC drivers
-- 
2.21.0

