Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E39C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5734820665
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569263279;
	bh=gpGU6L84s0+cOfjzteEE9iEfC8f+7KliKkLni1q2cPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NBXIohcgBMghzE/r/p/3YNEvm/DNtsWvKvchm4ZR+2bzCs+diskVxMYRkXCx14F9p
	 0wOgBjw1Ib+B45UTdDU4jqZAa3y1JiAl5RU3bYvkXSxlv437TltXaXw2iNUYuxONHf
	 SDyMBJRYxehMyj0ep8IhveMMqrkmWwfvSG9fTXSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733026AbfIWS16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:27:58 -0400
Received: from foss.arm.com ([217.140.110.172]:47066 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbfIWS1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:27:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A05322C7;
        Mon, 23 Sep 2019 11:27:55 -0700 (PDT)
Received: from big-swifty.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63D8F3F694;
        Mon, 23 Sep 2019 11:27:51 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Cc:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>
Subject: [PATCH 23/35] irqchip/gic-v4.1: Plumb skeletal VSGI irqchip
Date:   Mon, 23 Sep 2019 19:25:54 +0100
Message-Id: <20190923182606.32100-24-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923182606.32100-1-maz@kernel.org>
References: <20190923182606.32100-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since GICv4.1 has the capability to inject 16 SGIs into each VPE,
and that I'm keen not to invent too many specific interfaces to
manupulate these interrupts, let's pretend that each of these SGIs
is an actual Linux interrupt.

For that matter, let's introduce a minimal irqchip and irqdomain
setup that will get fleshed up in the following patches.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c   | 68 +++++++++++++++++++++++++++++-
 drivers/irqchip/irq-gic-v4.c       |  8 +++-
 include/linux/irqchip/arm-gic-v4.h |  9 +++-
 3 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 88933b3fd61d..69c26be709be 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3574,6 +3574,67 @@ static struct irq_chip its_vpe_4_1_irq_chip = {
 	.irq_set_vcpu_affinity	= its_vpe_4_1_set_vcpu_affinity,
 };
 
+static int its_sgi_set_affinity(struct irq_data *d,
+				const struct cpumask *mask_val,
+				bool force)
+{
+	return -EINVAL;
+}
+
+static struct irq_chip its_sgi_irq_chip = {
+	.name			= "GICv4.1-sgi",
+	.irq_set_affinity	= its_sgi_set_affinity,
+};
+
+static int its_sgi_irq_domain_alloc(struct irq_domain *domain,
+				    unsigned int virq, unsigned int nr_irqs,
+				    void *args)
+{
+	struct its_vpe *vpe = args;
+	int i;
+
+	/* Yes, we do want 16 SGIs */
+	WARN_ON(nr_irqs != 16);
+
+	for (i = 0; i < 16; i++) {
+		vpe->sgi_config[i].priority = 0;
+		vpe->sgi_config[i].enabled = false;
+		vpe->sgi_config[i].group = false;
+
+		irq_domain_set_hwirq_and_chip(domain, virq + i, i,
+					      &its_sgi_irq_chip, vpe);
+		irq_set_status_flags(virq + i, IRQ_DISABLE_UNLAZY);
+	}
+
+	return 0;
+}
+
+static void its_sgi_irq_domain_free(struct irq_domain *domain,
+				    unsigned int virq,
+				    unsigned int nr_irqs)
+{
+	/* Nothing to do */
+}
+
+static int its_sgi_irq_domain_activate(struct irq_domain *domain,
+				       struct irq_data *d, bool reserve)
+{
+	return 0;
+}
+
+static void its_sgi_irq_domain_deactivate(struct irq_domain *domain,
+					  struct irq_data *d)
+{
+	/* Nothing to do */
+}
+
+static struct irq_domain_ops its_sgi_domain_ops = {
+	.alloc		= its_sgi_irq_domain_alloc,
+	.free		= its_sgi_irq_domain_free,
+	.activate	= its_sgi_irq_domain_activate,
+	.deactivate	= its_sgi_irq_domain_deactivate,
+};
+
 static int its_vpe_id_alloc(void)
 {
 	return ida_simple_get(&its_vpeid_ida, 0, ITS_MAX_VPEID, GFP_KERNEL);
@@ -4615,8 +4676,13 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 		rdists->has_rvpeid = false;
 
 	if (has_v4 & rdists->has_vlpis) {
+		struct irq_domain_ops *sgi_ops = NULL;
+
+		if (has_v4_1)
+			sgi_ops = &its_sgi_domain_ops;
+
 		if (its_init_vpe_domain() ||
-		    its_init_v4(parent_domain, &its_vpe_domain_ops)) {
+		    its_init_v4(parent_domain, &its_vpe_domain_ops, sgi_ops)) {
 			rdists->has_vlpis = false;
 			pr_err("ITS: Disabling GICv4 support\n");
 		}
diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
index 45969927cc81..c01910d53f9e 100644
--- a/drivers/irqchip/irq-gic-v4.c
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -85,6 +85,7 @@
 
 static struct irq_domain *gic_domain;
 static const struct irq_domain_ops *vpe_domain_ops;
+static const struct irq_domain_ops *sgi_domain_ops;
 
 int its_alloc_vcpu_irqs(struct its_vm *vm)
 {
@@ -216,12 +217,15 @@ int its_prop_update_vlpi(int irq, u8 config, bool inv)
 	return irq_set_vcpu_affinity(irq, &info);
 }
 
-int its_init_v4(struct irq_domain *domain, const struct irq_domain_ops *ops)
+int its_init_v4(struct irq_domain *domain,
+		const struct irq_domain_ops *vpe_ops,
+		const struct irq_domain_ops *sgi_ops)
 {
 	if (domain) {
 		pr_info("ITS: Enabling GICv4 support\n");
 		gic_domain = domain;
-		vpe_domain_ops = ops;
+		vpe_domain_ops = vpe_ops;
+		sgi_domain_ops = sgi_ops;
 		return 0;
 	}
 
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index edbaa37fd3f1..03bbd0aed2e2 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -47,6 +47,11 @@ struct its_vpe {
 		};
 		/* GICv4.1 implementations */
 		struct {
+			struct {
+				u8	priority;
+				bool	enabled;
+				bool	group;
+			}			sgi_config[16];
 			atomic_t vmapp_count;
 		};
 	};
@@ -116,6 +121,8 @@ int its_unmap_vlpi(int irq);
 int its_prop_update_vlpi(int irq, u8 config, bool inv);
 
 struct irq_domain_ops;
-int its_init_v4(struct irq_domain *domain, const struct irq_domain_ops *ops);
+int its_init_v4(struct irq_domain *domain,
+		const struct irq_domain_ops *vpe_ops,
+		const struct irq_domain_ops *sgi_ops);
 
 #endif
-- 
2.20.1

