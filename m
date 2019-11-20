Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C92C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556FC22520
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfKTNWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:22:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56776 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbfKTNVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:21 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPv3-0007Dr-FL; Wed, 20 Nov 2019 14:21:17 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D22761C1A1C;
        Wed, 20 Nov 2019 14:21:05 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:05 -0000
From:   "tip-bot2 for Florian Fainelli" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/irq-bcm7038-l1: Support brcm,int-fwd-mask
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191024201415.23454-6-f.fainelli@gmail.com>
References: <20191024201415.23454-6-f.fainelli@gmail.com>
MIME-Version: 1.0
Message-ID: <157425606576.12247.4120040549066780732.tip-bot2@tip-bot2>
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

Commit-ID:     96de80c14bc6b43b797299270e31b8924f89fa52
Gitweb:        https://git.kernel.org/tip/96de80c14bc6b43b797299270e31b8924f89fa52
Author:        Florian Fainelli <f.fainelli@gmail.com>
AuthorDate:    Thu, 24 Oct 2019 13:14:15 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Nov 2019 18:47:48 

irqchip/irq-bcm7038-l1: Support brcm,int-fwd-mask

On some specific chips like 7211 we need to leave some interrupts
untouched/forwarded to the VPU which is another agent in the system
making use of that interrupt controller hardware (goes to both ARM GIC
and VPU L1 interrupt controller). Make that possible by using the
existing brcm,int-fwd-mask property and take necessary actions to avoid
masking that interrupt as well as not allowing Linux to map them.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20191024201415.23454-6-f.fainelli@gmail.com
---
 drivers/irqchip/irq-bcm7038-l1.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index 45879e5..cbf01af 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -44,6 +44,7 @@ struct bcm7038_l1_chip {
 	struct list_head	list;
 	u32			wake_mask[MAX_WORDS];
 #endif
+	u32			irq_fwd_mask[MAX_WORDS];
 	u8			affinity[MAX_WORDS * IRQS_PER_WORD];
 };
 
@@ -254,6 +255,7 @@ static int __init bcm7038_l1_init_one(struct device_node *dn,
 	resource_size_t sz;
 	struct bcm7038_l1_cpu *cpu;
 	unsigned int i, n_words, parent_irq;
+	int ret;
 
 	if (of_address_to_resource(dn, idx, &res))
 		return -EINVAL;
@@ -267,6 +269,14 @@ static int __init bcm7038_l1_init_one(struct device_node *dn,
 	else if (intc->n_words != n_words)
 		return -EINVAL;
 
+	ret = of_property_read_u32_array(dn , "brcm,int-fwd-mask",
+					 intc->irq_fwd_mask, n_words);
+	if (ret != 0 && ret != -EINVAL) {
+		/* property exists but has the wrong number of words */
+		pr_err("invalid brcm,int-fwd-mask property\n");
+		return -EINVAL;
+	}
+
 	cpu = intc->cpus[idx] = kzalloc(sizeof(*cpu) + n_words * sizeof(u32),
 					GFP_KERNEL);
 	if (!cpu)
@@ -277,8 +287,11 @@ static int __init bcm7038_l1_init_one(struct device_node *dn,
 		return -ENOMEM;
 
 	for (i = 0; i < n_words; i++) {
-		l1_writel(0xffffffff, cpu->map_base + reg_mask_set(intc, i));
-		cpu->mask_cache[i] = 0xffffffff;
+		l1_writel(~intc->irq_fwd_mask[i],
+			  cpu->map_base + reg_mask_set(intc, i));
+		l1_writel(intc->irq_fwd_mask[i],
+			  cpu->map_base + reg_mask_clr(intc, i));
+		cpu->mask_cache[i] = ~intc->irq_fwd_mask[i];
 	}
 
 	parent_irq = irq_of_parse_and_map(dn, idx);
@@ -311,15 +324,17 @@ static int bcm7038_l1_suspend(void)
 {
 	struct bcm7038_l1_chip *intc;
 	int boot_cpu, word;
+	u32 val;
 
 	/* Wakeup interrupt should only come from the boot cpu */
 	boot_cpu = cpu_logical_map(0);
 
 	list_for_each_entry(intc, &bcm7038_l1_intcs_list, list) {
 		for (word = 0; word < intc->n_words; word++) {
-			l1_writel(~intc->wake_mask[word],
+			val = intc->wake_mask[word] | intc->irq_fwd_mask[word];
+			l1_writel(~val,
 				intc->cpus[boot_cpu]->map_base + reg_mask_set(intc, word));
-			l1_writel(intc->wake_mask[word],
+			l1_writel(val,
 				intc->cpus[boot_cpu]->map_base + reg_mask_clr(intc, word));
 		}
 	}
@@ -383,6 +398,13 @@ static struct irq_chip bcm7038_l1_irq_chip = {
 static int bcm7038_l1_map(struct irq_domain *d, unsigned int virq,
 			  irq_hw_number_t hw_irq)
 {
+	struct bcm7038_l1_chip *intc = d->host_data;
+	u32 mask = BIT(hw_irq % IRQS_PER_WORD);
+	u32 word = hw_irq / IRQS_PER_WORD;
+
+	if (intc->irq_fwd_mask[word] & mask)
+		return -EPERM;
+
 	irq_set_chip_and_handler(virq, &bcm7038_l1_irq_chip, handle_level_irq);
 	irq_set_chip_data(virq, d->host_data);
 	irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(virq)));
