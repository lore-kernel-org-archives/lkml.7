Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1BFC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899C9224F3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbfKTNVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:21:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56658 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbfKTNVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:08 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPup-00075u-GN; Wed, 20 Nov 2019 14:21:03 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2C7761C1A01;
        Wed, 20 Nov 2019 14:21:02 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:02 -0000
From:   "tip-bot2 for Zhou Yanjie" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip: Ingenic: Add process for more than one irq
 at the same time.
Cc:     Zhou Yanjie <zhouyanjie@zoho.com>, Marc Zyngier <maz@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1570015525-27018-6-git-send-email-zhouyanjie@zoho.com>
References: <1570015525-27018-6-git-send-email-zhouyanjie@zoho.com>
MIME-Version: 1.0
Message-ID: <157425606206.12247.3466209751027396364.tip-bot2@tip-bot2>
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

Commit-ID:     b8b0145f7d0e24d98a58b7e54051dca0c1d77526
Gitweb:        https://git.kernel.org/tip/b8b0145f7d0e24d98a58b7e54051dca0c1d77526
Author:        Zhou Yanjie <zhouyanjie@zoho.com>
AuthorDate:    Wed, 02 Oct 2019 19:25:25 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Nov 2019 18:55:31 

irqchip: Ingenic: Add process for more than one irq at the same time.

Add process for the situation that more than one irq is coming to
a single chip at the same time. The original code will only respond
to the lowest setted bit in JZ_REG_INTC_PENDING, and then exit the
interrupt dispatch function. After exiting the interrupt dispatch
function, since the second interrupt has not yet responded, the
interrupt dispatch function is again entered to process the second
interrupt. This creates additional unnecessary overhead, and the
more interrupts that occur at the same time, the more overhead is
added. The improved method in this patch is to check whether there
are still unresponsive interrupts after processing the lowest
setted bit interrupt. If there are any, the processing will be
processed according to the bit in JZ_REG_INTC_PENDING, and the
interrupt dispatch function will be exited until all processing
is completed.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Link: https://lore.kernel.org/r/1570015525-27018-6-git-send-email-zhouyanjie@zoho.com
---
 drivers/irqchip/irq-ingenic.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index 06ab3ad..01d18b3 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
- *  JZ4740 platform IRQ support
+ *  Ingenic XBurst platform IRQ support
  */
 
 #include <linux/errno.h>
@@ -37,18 +37,23 @@ static irqreturn_t intc_cascade(int irq, void *data)
 	struct ingenic_intc_data *intc = irq_get_handler_data(irq);
 	struct irq_domain *domain = intc->domain;
 	struct irq_chip_generic *gc;
-	uint32_t irq_reg;
+	uint32_t pending;
 	unsigned i;
 
 	for (i = 0; i < intc->num_chips; i++) {
 		gc = irq_get_domain_generic_chip(domain, i * 32);
 
-		irq_reg = irq_reg_readl(gc, JZ_REG_INTC_PENDING);
-		if (!irq_reg)
+		pending = irq_reg_readl(gc, JZ_REG_INTC_PENDING);
+		if (!pending)
 			continue;
 
-		irq = irq_find_mapping(domain, __fls(irq_reg) + (i * 32));
-		generic_handle_irq(irq);
+		while (pending) {
+			int bit = __fls(pending);
+
+			irq = irq_find_mapping(domain, bit + (i * 32));
+			generic_handle_irq(irq);
+			pending &= ~BIT(bit);
+		}
 	}
 
 	return IRQ_HANDLED;
