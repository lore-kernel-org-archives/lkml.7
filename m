Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C976BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B6A21D79
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390951AbfIILBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 07:01:03 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:21227 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729481AbfIILBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 07:01:02 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 9xll3BMS+TMUyqo+IYQ9PebZVty6ukX2OAoxO7O6xicbl+ZItOjg9+xK32hgPRww+4CeHuqp6M
 dboQhy1wz01CBmDyKuuDZ6aJvUJ0KMl8iY6XRuVGFvkzWScW/0J+r4NOlInlW82eW+whZbfI3e
 HUreJqRNcu48WCwHAdSWgdYjBJ9qcsfeDxtxscz5sJLCveh5gx5WIf2DnP/l5bJGb919gWYnEe
 tVGzwUJRtt19ya4oXbrMoglSXd8rIPXjV5xn6BwZRbI8CB1/EgzDOHXanoUdhJj7sp1rRTYFKr
 0Ww=
X-IronPort-AV: E=Sophos;i="5.64,484,1559545200"; 
   d="scan'208";a="49728710"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Sep 2019 04:00:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 9 Sep 2019 04:00:42 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Mon, 9 Sep 2019 04:00:38 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sandeep Sheriker Mallikarjun 
        <sandeepsheriker.mallikarjun@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] irqchip/atmel-aic5: add support for sam9x60 irqchip
Date:   Mon, 9 Sep 2019 14:00:35 +0300
Message-ID: <1568026835-6646-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>

Add support for SAM9X60 irqchip.

Signed-off-by: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>
[claudiu.beznea@microchip.com: update aic5_irq_fixups[], update
 documentation]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../devicetree/bindings/interrupt-controller/atmel,aic.txt     |  7 +++++--
 drivers/irqchip/irq-atmel-aic5.c                               | 10 ++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
index f4c5d34c4111..7079d44bf3ba 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
@@ -1,8 +1,11 @@
 * Advanced Interrupt Controller (AIC)
 
 Required properties:
-- compatible: Should be "atmel,<chip>-aic"
-  <chip> can be "at91rm9200", "sama5d2", "sama5d3" or "sama5d4"
+- compatible: Should be:
+    - "atmel,<chip>-aic" where  <chip> can be "at91rm9200", "sama5d2",
+      "sama5d3" or "sama5d4"
+    - "microchip,<chip>-aic" where <chip> can be "sam9x60"
+
 - interrupt-controller: Identifies the node as an interrupt controller.
 - #interrupt-cells: The number of cells to define the interrupts. It should be 3.
   The first cell is the IRQ number (aka "Peripheral IDentifier" on datasheet).
diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index 6acad2ea0fb3..29333497ba10 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -313,6 +313,7 @@ static void __init sama5d3_aic_irq_fixup(void)
 static const struct of_device_id aic5_irq_fixups[] __initconst = {
 	{ .compatible = "atmel,sama5d3", .data = sama5d3_aic_irq_fixup },
 	{ .compatible = "atmel,sama5d4", .data = sama5d3_aic_irq_fixup },
+	{ .compatible = "microchip,sam9x60", .data = sama5d3_aic_irq_fixup },
 	{ /* sentinel */ },
 };
 
@@ -390,3 +391,12 @@ static int __init sama5d4_aic5_of_init(struct device_node *node,
 	return aic5_of_init(node, parent, NR_SAMA5D4_IRQS);
 }
 IRQCHIP_DECLARE(sama5d4_aic5, "atmel,sama5d4-aic", sama5d4_aic5_of_init);
+
+#define NR_SAM9X60_IRQS		50
+
+static int __init sam9x60_aic5_of_init(struct device_node *node,
+				       struct device_node *parent)
+{
+	return aic5_of_init(node, parent, NR_SAM9X60_IRQS);
+}
+IRQCHIP_DECLARE(sam9x60_aic5, "microchip,sam9x60-aic", sam9x60_aic5_of_init);
-- 
2.7.4

