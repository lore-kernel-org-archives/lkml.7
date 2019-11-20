Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A3DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992892251F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbfKTNVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:21:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56701 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730165AbfKTNVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:12 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPut-00075y-RO; Wed, 20 Nov 2019 14:21:07 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 630241C1A0C;
        Wed, 20 Nov 2019 14:21:02 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:02 -0000
From:   "tip-bot2 for Paul Cercueil" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip: ingenic: Alloc generic chips from IRQ domain
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1570015525-27018-5-git-send-email-zhouyanjie@zoho.com>
References: <1570015525-27018-5-git-send-email-zhouyanjie@zoho.com>
MIME-Version: 1.0
Message-ID: <157425606229.12247.4626237349062233321.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     8bc7464b5140218cb714abae55ea4cfe26b30c96
Gitweb:        https://git.kernel.org/tip/8bc7464b5140218cb714abae55ea4cfe26b30c96
Author:        Paul Cercueil <paul@crapouillou.net>
AuthorDate:    Wed, 02 Oct 2019 19:25:24 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Nov 2019 18:55:30 

irqchip: ingenic: Alloc generic chips from IRQ domain

By creating the generic chips from the IRQ domain, we don't rely on the
JZ4740_IRQ_BASE macro. It also makes the code a bit cleaner.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1570015525-27018-5-git-send-email-zhouyanjie@zoho.com
---
 drivers/irqchip/irq-ingenic.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index 82a079f..06ab3ad 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -36,12 +36,14 @@ static irqreturn_t intc_cascade(int irq, void *data)
 {
 	struct ingenic_intc_data *intc = irq_get_handler_data(irq);
 	struct irq_domain *domain = intc->domain;
+	struct irq_chip_generic *gc;
 	uint32_t irq_reg;
 	unsigned i;
 
 	for (i = 0; i < intc->num_chips; i++) {
-		irq_reg = readl(intc->base + (i * CHIP_SIZE) +
-				JZ_REG_INTC_PENDING);
+		gc = irq_get_domain_generic_chip(domain, i * 32);
+
+		irq_reg = irq_reg_readl(gc, JZ_REG_INTC_PENDING);
 		if (!irq_reg)
 			continue;
 
@@ -92,7 +94,7 @@ static int __init ingenic_intc_of_init(struct device_node *node,
 
 	domain = irq_domain_add_legacy(node, num_chips * 32,
 				       JZ4740_IRQ_BASE, 0,
-				       &irq_domain_simple_ops, NULL);
+				       &irq_generic_chip_ops, NULL);
 	if (!domain) {
 		err = -ENOMEM;
 		goto out_unmap_base;
@@ -100,17 +102,17 @@ static int __init ingenic_intc_of_init(struct device_node *node,
 
 	intc->domain = domain;
 
-	for (i = 0; i < num_chips; i++) {
-		/* Mask all irqs */
-		writel(0xffffffff, intc->base + (i * CHIP_SIZE) +
-		       JZ_REG_INTC_SET_MASK);
+	err = irq_alloc_domain_generic_chips(domain, 32, 1, "INTC",
+					     handle_level_irq, 0,
+					     IRQ_NOPROBE | IRQ_LEVEL, 0);
+	if (err)
+		goto out_domain_remove;
 
-		gc = irq_alloc_generic_chip("INTC", 1,
-					    JZ4740_IRQ_BASE + (i * 32),
-					    intc->base + (i * CHIP_SIZE),
-					    handle_level_irq);
+	for (i = 0; i < num_chips; i++) {
+		gc = irq_get_domain_generic_chip(domain, i * 32);
 
 		gc->wake_enabled = IRQ_MSK(32);
+		gc->reg_base = intc->base + (i * CHIP_SIZE);
 
 		ct = gc->chip_types;
 		ct->regs.enable = JZ_REG_INTC_CLEAR_MASK;
@@ -121,13 +123,15 @@ static int __init ingenic_intc_of_init(struct device_node *node,
 		ct->chip.irq_set_wake = irq_gc_set_wake;
 		ct->chip.flags = IRQCHIP_MASK_ON_SUSPEND;
 
-		irq_setup_generic_chip(gc, IRQ_MSK(32), 0, 0,
-				       IRQ_NOPROBE | IRQ_LEVEL);
+		/* Mask all irqs */
+		irq_reg_writel(gc, IRQ_MSK(32), JZ_REG_INTC_SET_MASK);
 	}
 
 	setup_irq(parent_irq, &intc_cascade_action);
 	return 0;
 
+out_domain_remove:
+	irq_domain_remove(domain);
 out_unmap_base:
 	iounmap(intc->base);
 out_unmap_irq:
