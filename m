Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5250C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CBF22520
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbfKTNWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:22:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56811 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730260AbfKTNVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:24 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPv6-0007Fh-Di; Wed, 20 Nov 2019 14:21:20 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A0E2F1C1A20;
        Wed, 20 Nov 2019 14:21:06 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:06 -0000
From:   "tip-bot2 for Justin Chen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/irq-bcm7038-l1: Add PM support
Cc:     Justin Chen <justinpopo6@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191024201415.23454-2-f.fainelli@gmail.com>
References: <20191024201415.23454-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Message-ID: <157425606659.12247.5642929885117278097.tip-bot2@tip-bot2>
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

Commit-ID:     6468fc18b00685c82408f40e9569c0d3527862b8
Gitweb:        https://git.kernel.org/tip/6468fc18b00685c82408f40e9569c0d3527862b8
Author:        Justin Chen <justinpopo6@gmail.com>
AuthorDate:    Thu, 24 Oct 2019 13:14:11 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Nov 2019 18:47:46 

irqchip/irq-bcm7038-l1: Add PM support

The current L1 controller does not mask any interrupts when dropping
into suspend. This mean we can receive unexpected wake up sources.
Modified the BCM7038 L1 controller to mask the all non-wake interrupts
before dropping into suspend.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20191024201415.23454-2-f.fainelli@gmail.com
---
 drivers/irqchip/irq-bcm7038-l1.c | 89 +++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index fc75c61..689e487 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -27,6 +27,7 @@
 #include <linux/types.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/syscore_ops.h>
 
 #define IRQS_PER_WORD		32
 #define REG_BYTES_PER_IRQ_WORD	(sizeof(u32) * 4)
@@ -39,6 +40,10 @@ struct bcm7038_l1_chip {
 	unsigned int		n_words;
 	struct irq_domain	*domain;
 	struct bcm7038_l1_cpu	*cpus[NR_CPUS];
+#ifdef CONFIG_PM_SLEEP
+	struct list_head	list;
+	u32			wake_mask[MAX_WORDS];
+#endif
 	u8			affinity[MAX_WORDS * IRQS_PER_WORD];
 };
 
@@ -287,6 +292,77 @@ static int __init bcm7038_l1_init_one(struct device_node *dn,
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+/*
+ * We keep a list of bcm7038_l1_chip used for suspend/resume. This hack is
+ * used because the struct chip_type suspend/resume hooks are not called
+ * unless chip_type is hooked onto a generic_chip. Since this driver does
+ * not use generic_chip, we need to manually hook our resume/suspend to
+ * syscore_ops.
+ */
+static LIST_HEAD(bcm7038_l1_intcs_list);
+static DEFINE_RAW_SPINLOCK(bcm7038_l1_intcs_lock);
+
+static int bcm7038_l1_suspend(void)
+{
+	struct bcm7038_l1_chip *intc;
+	int boot_cpu, word;
+
+	/* Wakeup interrupt should only come from the boot cpu */
+	boot_cpu = cpu_logical_map(0);
+
+	list_for_each_entry(intc, &bcm7038_l1_intcs_list, list) {
+		for (word = 0; word < intc->n_words; word++) {
+			l1_writel(~intc->wake_mask[word],
+				intc->cpus[boot_cpu]->map_base + reg_mask_set(intc, word));
+			l1_writel(intc->wake_mask[word],
+				intc->cpus[boot_cpu]->map_base + reg_mask_clr(intc, word));
+		}
+	}
+
+	return 0;
+}
+
+static void bcm7038_l1_resume(void)
+{
+	struct bcm7038_l1_chip *intc;
+	int boot_cpu, word;
+
+	boot_cpu = cpu_logical_map(0);
+
+	list_for_each_entry(intc, &bcm7038_l1_intcs_list, list) {
+		for (word = 0; word < intc->n_words; word++) {
+			l1_writel(intc->cpus[boot_cpu]->mask_cache[word],
+				intc->cpus[boot_cpu]->map_base + reg_mask_set(intc, word));
+			l1_writel(~intc->cpus[boot_cpu]->mask_cache[word],
+				intc->cpus[boot_cpu]->map_base + reg_mask_clr(intc, word));
+		}
+	}
+}
+
+static struct syscore_ops bcm7038_l1_syscore_ops = {
+	.suspend	= bcm7038_l1_suspend,
+	.resume		= bcm7038_l1_resume,
+};
+
+static int bcm7038_l1_set_wake(struct irq_data *d, unsigned int on)
+{
+	struct bcm7038_l1_chip *intc = irq_data_get_irq_chip_data(d);
+	unsigned long flags;
+	u32 word = d->hwirq / IRQS_PER_WORD;
+	u32 mask = BIT(d->hwirq % IRQS_PER_WORD);
+
+	raw_spin_lock_irqsave(&intc->lock, flags);
+	if (on)
+		intc->wake_mask[word] |= mask;
+	else
+		intc->wake_mask[word] &= ~mask;
+	raw_spin_unlock_irqrestore(&intc->lock, flags);
+
+	return 0;
+}
+#endif
+
 static struct irq_chip bcm7038_l1_irq_chip = {
 	.name			= "bcm7038-l1",
 	.irq_mask		= bcm7038_l1_mask,
@@ -295,6 +371,9 @@ static struct irq_chip bcm7038_l1_irq_chip = {
 #ifdef CONFIG_SMP
 	.irq_cpu_offline	= bcm7038_l1_cpu_offline,
 #endif
+#ifdef CONFIG_PM_SLEEP
+	.irq_set_wake		= bcm7038_l1_set_wake,
+#endif
 };
 
 static int bcm7038_l1_map(struct irq_domain *d, unsigned int virq,
@@ -340,6 +419,16 @@ int __init bcm7038_l1_of_init(struct device_node *dn,
 		goto out_unmap;
 	}
 
+#ifdef CONFIG_PM_SLEEP
+	/* Add bcm7038_l1_chip into a list */
+	raw_spin_lock(&bcm7038_l1_intcs_lock);
+	list_add_tail(&intc->list, &bcm7038_l1_intcs_list);
+	raw_spin_unlock(&bcm7038_l1_intcs_lock);
+
+	if (list_is_singular(&bcm7038_l1_intcs_list))
+		register_syscore_ops(&bcm7038_l1_syscore_ops);
+#endif
+
 	pr_info("registered BCM7038 L1 intc (%pOF, IRQs: %d)\n",
 		dn, IRQS_PER_WORD * intc->n_words);
 
