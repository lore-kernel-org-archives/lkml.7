Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9DAC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2980F22530
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbfKTNVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:21:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56688 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730146AbfKTNVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:10 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPus-00077I-TO; Wed, 20 Nov 2019 14:21:07 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 03E361C1A0E;
        Wed, 20 Nov 2019 14:21:03 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:02 -0000
From:   "tip-bot2 for Paul Cercueil" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip: ingenic: Drop redundant irq_suspend /
 irq_resume functions
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1570015525-27018-2-git-send-email-zhouyanjie@zoho.com>
References: <1570015525-27018-2-git-send-email-zhouyanjie@zoho.com>
MIME-Version: 1.0
Message-ID: <157425606292.12247.1623250092467011574.tip-bot2@tip-bot2>
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

Commit-ID:     20b44b4de61f2887694981e8cae74fe1bf58f950
Gitweb:        https://git.kernel.org/tip/20b44b4de61f2887694981e8cae74fe1bf58f950
Author:        Paul Cercueil <paul@crapouillou.net>
AuthorDate:    Wed, 02 Oct 2019 19:25:21 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Nov 2019 18:55:29 

irqchip: ingenic: Drop redundant irq_suspend / irq_resume functions

The same behaviour can be obtained by using the IRQCHIP_MASK_ON_SUSPEND
flag on the IRQ chip.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1570015525-27018-2-git-send-email-zhouyanjie@zoho.com
---
 drivers/irqchip/irq-ingenic.c   | 24 +-----------------------
 include/linux/irqchip/ingenic.h | 14 --------------
 2 files changed, 1 insertion(+), 37 deletions(-)
 delete mode 100644 include/linux/irqchip/ingenic.h

diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index f126255..06fa810 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -10,7 +10,6 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/irqchip.h>
-#include <linux/irqchip/ingenic.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/timex.h>
@@ -50,26 +49,6 @@ static irqreturn_t intc_cascade(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void intc_irq_set_mask(struct irq_chip_generic *gc, uint32_t mask)
-{
-	struct irq_chip_regs *regs = &gc->chip_types->regs;
-
-	writel(mask, gc->reg_base + regs->enable);
-	writel(~mask, gc->reg_base + regs->disable);
-}
-
-void ingenic_intc_irq_suspend(struct irq_data *data)
-{
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
-	intc_irq_set_mask(gc, gc->wake_active);
-}
-
-void ingenic_intc_irq_resume(struct irq_data *data)
-{
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
-	intc_irq_set_mask(gc, gc->mask_cache);
-}
-
 static struct irqaction intc_cascade_action = {
 	.handler = intc_cascade,
 	.name = "SoC intc cascade interrupt",
@@ -127,8 +106,7 @@ static int __init ingenic_intc_of_init(struct device_node *node,
 		ct->chip.irq_mask = irq_gc_mask_disable_reg;
 		ct->chip.irq_mask_ack = irq_gc_mask_disable_reg;
 		ct->chip.irq_set_wake = irq_gc_set_wake;
-		ct->chip.irq_suspend = ingenic_intc_irq_suspend;
-		ct->chip.irq_resume = ingenic_intc_irq_resume;
+		ct->chip.flags = IRQCHIP_MASK_ON_SUSPEND;
 
 		irq_setup_generic_chip(gc, IRQ_MSK(32), 0, 0,
 				       IRQ_NOPROBE | IRQ_LEVEL);
diff --git a/include/linux/irqchip/ingenic.h b/include/linux/irqchip/ingenic.h
deleted file mode 100644
index 1465588..0000000
--- a/include/linux/irqchip/ingenic.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
- */
-
-#ifndef __LINUX_IRQCHIP_INGENIC_H__
-#define __LINUX_IRQCHIP_INGENIC_H__
-
-#include <linux/irq.h>
-
-extern void ingenic_intc_irq_suspend(struct irq_data *data);
-extern void ingenic_intc_irq_resume(struct irq_data *data);
-
-#endif
