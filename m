Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBC6C76194
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 19:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE212075E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 19:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="WibTbuLE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388203AbfG0TSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 15:18:15 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:43994 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387841AbfG0TSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 15:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1564255083; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6iLLaFVh1hkz7E3umTHIOyxy4HAXyW1rBel4zv59DSg=;
        b=WibTbuLExbstPrrszMPfB6f010QM48CHlWo1La6J6ua/nP22WoI3lCHSTnO9t6gTKTE+J3
        78cbWc7SP4xfyOalspCPA/CHJJhi9PiS/b0f7wOr3QX+oA5cXhxj8ugFTfxiggOFW3y47q
        A7cCZCSiK7x5pwlGtV6RQeKN6Ki3luc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-kernel@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/4] irqchip: ingenic: Alloc generic chips from IRQ domain
Date:   Sat, 27 Jul 2019 15:17:41 -0400
Message-Id: <20190727191741.30317-4-paul@crapouillou.net>
In-Reply-To: <20190727191741.30317-1-paul@crapouillou.net>
References: <20190727191741.30317-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By creating the generic chips from the IRQ domain, we don't rely on the
JZ4740_IRQ_BASE macro. It also makes the code a bit cleaner.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/irqchip/irq-ingenic.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index 82a079fa3a3d..06ab3ad22ad2 100644
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
-- 
2.21.0.593.g511ec345e18

