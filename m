Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91FCCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8268520684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ou4e8uZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfJXUOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:14:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35173 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfJXUOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:14:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id l10so27038388wrb.2;
        Thu, 24 Oct 2019 13:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5CCYXEJ3KS4BOi54EgFM7QurD64PvAhJciYb1sSHmbI=;
        b=Ou4e8uZhb0MKkl+6TqSr10ochGdvvF9mOd+5R6wpXD/J+IuzS6KzgPFZkI8E8iSISi
         k4HaktQ0/4aAaUurM8dTovI2qUiOvHnRd+zqyp4TgrXysptd5Pif4Vq9YfNt9ldpm1qq
         dh5pBaKy/+jhExczjKSKL4A2PWQ5U748SQ8zBD/uIpa2sTALxfEYe5C80HCY+d5be39k
         Wq0/CHglZb8EnUHlTGcCwT+32ThQyF1054Hqt8Q+d4oqUUz5Irvs2kDCazgzC0OEwaKf
         hfTF90sR+OrFV/VFQacFdYYSU383mZcG02loD9yB28x8XQzeJDSCd2jHHdqfp3enKi/T
         GQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5CCYXEJ3KS4BOi54EgFM7QurD64PvAhJciYb1sSHmbI=;
        b=Z5D0Pxcuzz3+CN/lHk4OtXdv6NYvB1VxU+zcvRO+leQLWpYetnVih4l/ZuCn/6EQue
         +O6BgnEwJXM9E0icgbrmvCNq0T8jH7aJOy0njIQ+2fJlq2MnI+rwQ61/p+Eog74G3186
         4LYKrzGdvrKUU8tEN33SMdOKxBjHFlkU0r5qTqrEIhc0ADyJOY+9WNMwlzRWV/NjfKBQ
         yNEBqb1C8i5qCL2CGMQVbNMCcgrQIcdkH7j2PY/PciULjPM2s11WIWCAp6sVIOp82IBr
         AFkwnjdAATwy1mg0xW/M3Nl33pV++4vyOwYUbGuXSWT033XSAbjrNWedHgjvqqtTef20
         GQIQ==
X-Gm-Message-State: APjAAAWR/6ydeh9F+NdU2yZsxs1aIqmhEjrY90boQsyCiYgC0F/DmTld
        uryJfmD0r3h9socHsZfHkUC2wUUc
X-Google-Smtp-Source: APXvYqx80JcncS9iN6IxEENWG5/0ZghTIF3B3mdMMNXvddSGhOqxHC4OV5T7e9Mqfe87OMivYBzU1A==
X-Received: by 2002:adf:9185:: with SMTP id 5mr5725955wri.389.1571948077944;
        Thu, 24 Oct 2019 13:14:37 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u21sm4788536wmu.27.2019.10.24.13.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 13:14:37 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
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
Subject: [PATCH v3 5/5] irqchip/irq-bcm7038-l1: Support brcm,int-fwd-mask
Date:   Thu, 24 Oct 2019 13:14:15 -0700
Message-Id: <20191024201415.23454-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024201415.23454-1-f.fainelli@gmail.com>
References: <20191024201415.23454-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some specific chips like 7211 we need to leave some interrupts
untouched/forwarded to the VPU which is another agent in the system
making use of that interrupt controller hardware (goes to both ARM GIC
and VPU L1 interrupt controller). Make that possible by using the
existing brcm,int-fwd-mask property and take necessary actions to avoid
masking that interrupt as well as not allowing Linux to map them.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-bcm7038-l1.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index 45879e59e58b..cbf01afcd2a6 100644
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
-- 
2.17.1

