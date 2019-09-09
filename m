Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E286C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBD2218AC
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jN1PE35h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389414AbfIIIkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 04:40:11 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:51001 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfIIIkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568018410; x=1599554410;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=8HdAfP560DuFfXUXyq4ESO9XpMATN8BUOpZizShWOqI=;
  b=jN1PE35h6X9aXFVMBsThpubzW6bEMBlbervCeWWKyyiFd6hcycThV7Fl
   QBzQj8vLDr7I0/8es+H6K7CbEGcKWcGkrhQimYHepXLOjUlFVBlzE8UvI
   AgobnpcmXS3punp9ok/4HA96gO1DiRClW0lKjHZqdRCz5vjV8HWyZuL2D
   0=;
X-IronPort-AV: E=Sophos;i="5.64,484,1559520000"; 
   d="scan'208";a="829155200"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 09 Sep 2019 08:39:44 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id 8B3BBA1C35;
        Mon,  9 Sep 2019 08:39:43 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Sep 2019 08:39:42 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.160.149) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Sep 2019 08:39:36 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <talel@amazon.com>, <linux-kernel@vger.kernel.org>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <barakw@amazon.com>
Subject: [PATCH 1/1] irqchip: al-fic: add support for irq retrigger
Date:   Mon, 9 Sep 2019 11:39:18 +0300
Message-ID: <1568018358-18985-1-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.149]
X-ClientProxiedBy: EX13D17UWC002.ant.amazon.com (10.43.162.61) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce interrupts retrigger support for Amazon's Annapurna Labs Fabric
Interrupt Controller.

Signed-off-by: Talel Shenhar <talel@amazon.com>
---
 drivers/irqchip/irq-al-fic.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/irqchip/irq-al-fic.c b/drivers/irqchip/irq-al-fic.c
index 1a57cee..0b0a737 100644
--- a/drivers/irqchip/irq-al-fic.c
+++ b/drivers/irqchip/irq-al-fic.c
@@ -15,6 +15,7 @@
 
 /* FIC Registers */
 #define AL_FIC_CAUSE		0x00
+#define AL_FIC_SET_CAUSE	0x08
 #define AL_FIC_MASK		0x10
 #define AL_FIC_CONTROL		0x28
 
@@ -126,6 +127,16 @@ static void al_fic_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(irqchip, desc);
 }
 
+static int al_fic_irq_retrigger(struct irq_data *data)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
+	struct al_fic *fic = gc->private;
+
+	writel_relaxed(BIT(data->hwirq), fic->base + AL_FIC_SET_CAUSE);
+
+	return 1;
+}
+
 static int al_fic_register(struct device_node *node,
 			   struct al_fic *fic)
 {
@@ -159,6 +170,7 @@ static int al_fic_register(struct device_node *node,
 	gc->chip_types->chip.irq_unmask = irq_gc_mask_clr_bit;
 	gc->chip_types->chip.irq_ack = irq_gc_ack_clr_bit;
 	gc->chip_types->chip.irq_set_type = al_fic_irq_set_type;
+	gc->chip_types->chip.irq_retrigger = al_fic_irq_retrigger;
 	gc->chip_types->chip.flags = IRQCHIP_SKIP_SET_WAKE;
 	gc->private = fic;
 
-- 
2.7.4

