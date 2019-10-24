Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E72CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C78E21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ek5sPHSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfJXUOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:14:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42167 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfJXUO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:14:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id r1so17658874wrs.9;
        Thu, 24 Oct 2019 13:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nflyxBy3Fu9U2+RG84t/ZVbeUppgbKt41+dBtuuebF0=;
        b=ek5sPHSzYaao6sAVHC55P2Hkq0ZVt8JMs5x3AUEUJCaVozknLx3ZZ0oC/vOPz8/C6P
         kiad7snMiLIC4Yo9plU/57CdeP+srPqaZEhoNTgD3Y+4IFq7fLFRFM8KuJEmYEnFDeow
         UKgJlcSQvpOsnN12/oCr4w8ejw/5e6UMGcfXO0byRq+4FzJJ9RyyruoBws+zPRiVNz2O
         D0tV/IgdC82+xqgr0Gv6Rxjm6cRyAYMPOThWEEfPt7Tjz2KFfWk9NmT64l8ohDkUyhL7
         6AtCFh5U88eiY+B7pKQ/+/g8h+cbqBnw1Vrz9leVVl0xlHbyfGwgeGLhIrNNGDPxwRAR
         +S7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nflyxBy3Fu9U2+RG84t/ZVbeUppgbKt41+dBtuuebF0=;
        b=iTJg6cZpH2IARHODRIA9UGcrdeC89OjJvz/r0amIw5woEyOddMSa83BEQfg2uXSH2I
         /YV3EOYwEvQS14PiPmhJJqhKL1PaL3v78yIkjrwHSOr/vUGpw+ytmr6lImy5ys4VBH81
         Mq7KPHkRllSUvdvaL/IpqKs6Wh9uUkYZXn8r2vEOG9D6j6gOovzKtGXltrdvJHg3/GQg
         IJ8iFDXf5OOcdrXFRdj2DAPv19m3z3fx5iMd88tRo0w4DE+OIsobOrd4nObRBYhzv+Vt
         zZZIRaHQ7tl8QDZ+4x0mqNYh5XUnFR5wo16luNjSvAQv72VmF+t1ms0wzidzRDTEp4uI
         2IpQ==
X-Gm-Message-State: APjAAAVZhpChxJ6iPc44fyr58rHBBPmfmGE/WXamQZprq14nPV2368DK
        dluSPMVAkC6rQJe1AxMwZAlN3vCf
X-Google-Smtp-Source: APXvYqzSzhEeQHn7MNftoxjVTbM10FZaz1/fHauXJ2XapiiqDSTKI909t/xPFEX+gu30UzlJ7AVSzA==
X-Received: by 2002:adf:f7d1:: with SMTP id a17mr4830177wrq.111.1571948066846;
        Thu, 24 Oct 2019 13:14:26 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u21sm4788536wmu.27.2019.10.24.13.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 13:14:26 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Justin Chen <justinpopo6@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2835
        ARM ARCHITECTURE)
Subject: [PATCH v3 1/5] irqchip/irq-bcm7038-l1: Add PM support
Date:   Thu, 24 Oct 2019 13:14:11 -0700
Message-Id: <20191024201415.23454-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024201415.23454-1-f.fainelli@gmail.com>
References: <20191024201415.23454-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Chen <justinpopo6@gmail.com>

The current L1 controller does not mask any interrupts when dropping
into suspend. This mean we can receive unexpected wake up sources.
Modified the BCM7038 L1 controller to mask the all non-wake interrupts
before dropping into suspend.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-bcm7038-l1.c | 89 ++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index fc75c61233aa..689e487be80c 100644
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
 
-- 
2.17.1

