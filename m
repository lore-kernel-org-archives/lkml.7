Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96C2C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B610D22530
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbfKTNVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:21:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56713 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbfKTNVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:11 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPuv-00076J-2j; Wed, 20 Nov 2019 14:21:09 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 927CF1C19FE;
        Wed, 20 Nov 2019 14:21:02 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:02 -0000
From:   "tip-bot2 for Paul Cercueil" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip: ingenic: Get virq number from IRQ domain
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1570015525-27018-4-git-send-email-zhouyanjie@zoho.com>
References: <1570015525-27018-4-git-send-email-zhouyanjie@zoho.com>
MIME-Version: 1.0
Message-ID: <157425606250.12247.13541398452844645434.tip-bot2@tip-bot2>
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

Commit-ID:     208caadce5d4d38f48af965206bbd4473d265080
Gitweb:        https://git.kernel.org/tip/208caadce5d4d38f48af965206bbd4473d265080
Author:        Paul Cercueil <paul@crapouillou.net>
AuthorDate:    Wed, 02 Oct 2019 19:25:23 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Nov 2019 18:55:30 

irqchip: ingenic: Get virq number from IRQ domain

Get the virq number from the IRQ domain instead of calculating it from
the hardcoded irq base.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1570015525-27018-4-git-send-email-zhouyanjie@zoho.com
---
 drivers/irqchip/irq-ingenic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index d97a3a5..82a079f 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -21,6 +21,7 @@
 
 struct ingenic_intc_data {
 	void __iomem *base;
+	struct irq_domain *domain;
 	unsigned num_chips;
 };
 
@@ -34,6 +35,7 @@ struct ingenic_intc_data {
 static irqreturn_t intc_cascade(int irq, void *data)
 {
 	struct ingenic_intc_data *intc = irq_get_handler_data(irq);
+	struct irq_domain *domain = intc->domain;
 	uint32_t irq_reg;
 	unsigned i;
 
@@ -43,7 +45,8 @@ static irqreturn_t intc_cascade(int irq, void *data)
 		if (!irq_reg)
 			continue;
 
-		generic_handle_irq(__fls(irq_reg) + (i * 32) + JZ4740_IRQ_BASE);
+		irq = irq_find_mapping(domain, __fls(irq_reg) + (i * 32));
+		generic_handle_irq(irq);
 	}
 
 	return IRQ_HANDLED;
@@ -95,6 +98,8 @@ static int __init ingenic_intc_of_init(struct device_node *node,
 		goto out_unmap_base;
 	}
 
+	intc->domain = domain;
+
 	for (i = 0; i < num_chips; i++) {
 		/* Mask all irqs */
 		writel(0xffffffff, intc->base + (i * CHIP_SIZE) +
