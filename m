Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD6BC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EC621670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403961AbfIFLJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:09:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47070 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392367AbfIFLIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:08:32 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i6C6O-0007AI-4x; Fri, 06 Sep 2019 13:08:28 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 662131C0E2B;
        Fri,  6 Sep 2019 13:08:17 +0200 (CEST)
Date:   Fri, 06 Sep 2019 11:08:17 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic: Rework gic_configure_irq to take the
 full ICFGR base
Cc:     Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156776809737.24167.16109669324170708245.tip-bot2@tip-bot2>
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

Commit-ID:     13d22e2e1f35f2d3cc7ddc002c23e733c2782dd4
Gitweb:        https://git.kernel.org/tip/13d22e2e1f35f2d3cc7ddc002c23e733c2782dd4
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 16 Jul 2019 14:35:17 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 20 Aug 2019 10:04:09 +01:00

irqchip/gic: Rework gic_configure_irq to take the full ICFGR base

gic_configure_irq is currently passed the (re)distributor address,
to which it applies an a fixed offset to get to the configuration
registers. This offset is constant across all GICs, or rather it was
until to v3.1...

An easy way out is for the individual drivers to pass the base
address of the configuration register for the considered interrupt.
At the same time, move part of the error handling back to the
individual drivers, as things are about to change on that front.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-common.c | 14 +++++---------
 drivers/irqchip/irq-gic-v3.c     | 11 ++++++++++-
 drivers/irqchip/irq-gic.c        | 10 +++++++++-
 drivers/irqchip/irq-hip04.c      |  7 ++++++-
 4 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index b0a8215..6900b6f 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -63,7 +63,7 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 	 * for "irq", depending on "type".
 	 */
 	raw_spin_lock_irqsave(&irq_controller_lock, flags);
-	val = oldval = readl_relaxed(base + GIC_DIST_CONFIG + confoff);
+	val = oldval = readl_relaxed(base + confoff);
 	if (type & IRQ_TYPE_LEVEL_MASK)
 		val &= ~confmask;
 	else if (type & IRQ_TYPE_EDGE_BOTH)
@@ -83,14 +83,10 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 	 * does not allow us to set the configuration or we are in a
 	 * non-secure mode, and hence it may not be catastrophic.
 	 */
-	writel_relaxed(val, base + GIC_DIST_CONFIG + confoff);
-	if (readl_relaxed(base + GIC_DIST_CONFIG + confoff) != val) {
-		if (WARN_ON(irq >= 32))
-			ret = -EINVAL;
-		else
-			pr_warn("GIC: PPI%d is secure or misconfigured\n",
-				irq - 16);
-	}
+	writel_relaxed(val, base + confoff);
+	if (readl_relaxed(base + confoff) != val)
+		ret = -EINVAL;
+
 	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
 
 	if (sync_access)
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index be961c2..efc5319 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -407,6 +407,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	unsigned int irq = gic_irq(d);
 	void (*rwp_wait)(void);
 	void __iomem *base;
+	int ret;
 
 	/* Interrupt configuration for SGIs can't be changed */
 	if (irq < 16)
@@ -425,7 +426,15 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 		rwp_wait = gic_dist_wait_for_rwp;
 	}
 
-	return gic_configure_irq(irq, type, base, rwp_wait);
+
+	ret = gic_configure_irq(irq, type, base + GICD_ICFGR, rwp_wait);
+	if (ret && irq < 32) {
+		/* Misconfigured PPIs are usually not fatal */
+		pr_warn("GIC: PPI%d is secure or misconfigured\n", irq - 16);
+		ret = 0;
+	}
+
+	return ret;
 }
 
 static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index b6b8573..5ca7d55 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -291,6 +291,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 {
 	void __iomem *base = gic_dist_base(d);
 	unsigned int gicirq = gic_irq(d);
+	int ret;
 
 	/* Interrupt configuration for SGIs can't be changed */
 	if (gicirq < 16)
@@ -301,7 +302,14 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 			    type != IRQ_TYPE_EDGE_RISING)
 		return -EINVAL;
 
-	return gic_configure_irq(gicirq, type, base, NULL);
+	ret = gic_configure_irq(gicirq, type, base + GIC_DIST_CONFIG, NULL);
+	if (ret && gicirq < 32) {
+		/* Misconfigured PPIs are usually not fatal */
+		pr_warn("GIC: PPI%d is secure or misconfigured\n", gicirq - 16);
+		ret = 0;
+	}
+
+	return ret;
 }
 
 static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
index cf70582..1626131 100644
--- a/drivers/irqchip/irq-hip04.c
+++ b/drivers/irqchip/irq-hip04.c
@@ -130,7 +130,12 @@ static int hip04_irq_set_type(struct irq_data *d, unsigned int type)
 
 	raw_spin_lock(&irq_controller_lock);
 
-	ret = gic_configure_irq(irq, type, base, NULL);
+	ret = gic_configure_irq(irq, type, base + GIC_DIST_CONFIG, NULL);
+	if (ret && irq < 32) {
+		/* Misconfigured PPIs are usually not fatal */
+		pr_warn("GIC: PPI%d is secure or misconfigured\n", irq - 16);
+		ret = 0;
+	}
 
 	raw_spin_unlock(&irq_controller_lock);
 
