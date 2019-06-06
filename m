Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D5EC28D1B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C865920883
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559806691;
	bh=FbQwaR/M7fJ9GopKbQYq8gUnFTC0AGFLQAlSApSI2bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LYDfckg0h2Q62aBnQc12+4mQtiU0FjKyCTlJ2X9KIc7wzmdum1ly+3OKKJ79qUSQ9
	 p6hVgNh2QejgV6a+EzQjCMduzBh860QAy2G3ZwaLQkW2HrrEoq9PqTArLDXwNReyd+
	 j5f4iBvSOZi9Pvve6GmxJaZ8p9FU/MmvYEaDJ2yk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfFFHiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 03:38:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfFFHiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 03:38:10 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7249720868;
        Thu,  6 Jun 2019 07:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559806689;
        bh=FbQwaR/M7fJ9GopKbQYq8gUnFTC0AGFLQAlSApSI2bg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jB2J2TQPtw8q2Mj9RAuZ3foFvc7LOFlyfwtQ12xRZsxpLTpnL/VVomVkdcb7NubCO
         WQWejRPU8vOjszx8BPrne/qFfvl57vp8NFZvBH56rvsBihh2ZAtTUffwpUG1vZWOsD
         0Ujw5ER7BFp7cMDlDcPrxR8PLbKnX1MN3xeCQPmE=
From:   guoren@kernel.org
To:     marc.zyngier@arm.com, mark.rutland@arm.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        guoren@kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V5 1/3] irqchip/irq-csky-mpintc: Add triger type
Date:   Thu,  6 Jun 2019 15:37:31 +0800
Message-Id: <1559806653-11249-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559806653-11249-1-git-send-email-guoren@kernel.org>
References: <1559806653-11249-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Support 4 triger types:
 - IRQ_TYPE_LEVEL_HIGH
 - IRQ_TYPE_LEVEL_LOW
 - IRQ_TYPE_EDGE_RISING
 - IRQ_TYPE_EDGE_FALLING

All of above could be set in DeviceTree file and it still compatible
with the old DeviceTree format.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-csky-mpintc.c | 78 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
index c67c961..4457722 100644
--- a/drivers/irqchip/irq-csky-mpintc.c
+++ b/drivers/irqchip/irq-csky-mpintc.c
@@ -32,6 +32,7 @@ static void __iomem *INTCL_base;
 #define INTCG_CIDSTR	0x1000
 
 #define INTCL_PICTLR	0x0
+#define INTCL_CFGR	0x14
 #define INTCL_SIGR	0x60
 #define INTCL_HPPIR	0x68
 #define INTCL_RDYIR	0x6c
@@ -41,6 +42,35 @@ static void __iomem *INTCL_base;
 
 static DEFINE_PER_CPU(void __iomem *, intcl_reg);
 
+static unsigned long *__trigger;
+
+#define IRQ_OFFSET(irq) ((irq < COMM_IRQ_BASE) ? irq : (irq - COMM_IRQ_BASE))
+
+#define TRIG_BYTE_OFFSET(i)	((((i) * 2) / 32) * 4)
+#define TRIG_BIT_OFFSET(i)	 (((i) * 2) % 32)
+
+#define TRIG_VAL(trigger, irq)	(trigger << TRIG_BIT_OFFSET(IRQ_OFFSET(irq)))
+#define TRIG_VAL_MSK(irq)	    (~(3 << TRIG_BIT_OFFSET(IRQ_OFFSET(irq))))
+
+#define TRIG_BASE(irq) \
+	(TRIG_BYTE_OFFSET(IRQ_OFFSET(irq)) + ((irq < COMM_IRQ_BASE) ? \
+	(this_cpu_read(intcl_reg) + INTCL_CFGR) : (INTCG_base + INTCG_CICFGR)))
+
+static DEFINE_SPINLOCK(setup_lock);
+static void setup_trigger(unsigned long irq, unsigned long trigger)
+{
+	unsigned int tmp;
+
+	spin_lock(&setup_lock);
+
+	/* setup trigger */
+	tmp = readl_relaxed(TRIG_BASE(irq)) & TRIG_VAL_MSK(irq);
+
+	writel_relaxed(tmp | TRIG_VAL(trigger, irq), TRIG_BASE(irq));
+
+	spin_unlock(&setup_lock);
+}
+
 static void csky_mpintc_handler(struct pt_regs *regs)
 {
 	void __iomem *reg_base = this_cpu_read(intcl_reg);
@@ -56,6 +86,8 @@ static void csky_mpintc_enable(struct irq_data *d)
 {
 	void __iomem *reg_base = this_cpu_read(intcl_reg);
 
+	setup_trigger(d->hwirq, __trigger[d->hwirq]);
+
 	writel_relaxed(d->hwirq, reg_base + INTCL_SENR);
 }
 
@@ -73,6 +105,28 @@ static void csky_mpintc_eoi(struct irq_data *d)
 	writel_relaxed(d->hwirq, reg_base + INTCL_CACR);
 }
 
+static int csky_mpintc_set_type(struct irq_data *d, unsigned int type)
+{
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_LEVEL_HIGH:
+		__trigger[d->hwirq] = 0;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		__trigger[d->hwirq] = 1;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		__trigger[d->hwirq] = 2;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		__trigger[d->hwirq] = 3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_SMP
 static int csky_irq_set_affinity(struct irq_data *d,
 				 const struct cpumask *mask_val,
@@ -105,6 +159,7 @@ static struct irq_chip csky_irq_chip = {
 	.irq_eoi	= csky_mpintc_eoi,
 	.irq_enable	= csky_mpintc_enable,
 	.irq_disable	= csky_mpintc_disable,
+	.irq_set_type	= csky_mpintc_set_type,
 #ifdef CONFIG_SMP
 	.irq_set_affinity = csky_irq_set_affinity,
 #endif
@@ -125,9 +180,26 @@ static int csky_irqdomain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
+static int csky_irq_domain_xlate_cells(struct irq_domain *d,
+		struct device_node *ctrlr, const u32 *intspec,
+		unsigned int intsize, unsigned long *out_hwirq,
+		unsigned int *out_type)
+{
+	if (WARN_ON(intsize < 1))
+		return -EINVAL;
+
+	*out_hwirq = intspec[0];
+	if (intsize > 1)
+		*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
+	else
+		*out_type = IRQ_TYPE_LEVEL_HIGH;
+
+	return 0;
+}
+
 static const struct irq_domain_ops csky_irqdomain_ops = {
 	.map	= csky_irqdomain_map,
-	.xlate	= irq_domain_xlate_onecell,
+	.xlate	= csky_irq_domain_xlate_cells,
 };
 
 #ifdef CONFIG_SMP
@@ -161,6 +233,10 @@ csky_mpintc_init(struct device_node *node, struct device_node *parent)
 	if (ret < 0)
 		nr_irq = INTC_IRQS;
 
+	__trigger  = kcalloc(nr_irq, sizeof(unsigned long), GFP_KERNEL);
+	if (__trigger == NULL)
+		return -ENXIO;
+
 	if (INTCG_base == NULL) {
 		INTCG_base = ioremap(mfcr("cr<31, 14>"),
 				     INTCL_SIZE*nr_cpu_ids + INTCG_SIZE);
-- 
2.7.4

