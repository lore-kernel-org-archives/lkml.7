Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5080C7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D72A2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563878693;
	bh=XP/FdRJLvhdiyBnFcp0xzvdcDzCq7Usls6AQoQGd2GA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VtqoNaYNC9IOuWYhYuNg3MsaidEdFf2vkoxza/L4kfrw9GWvg0OPHCWLzgqXAg4FS
	 CSFM2N+Nt3b0g7MeUwjkIqCxjmReVIamBMhgLFXXg4yDAUnCFCrsSq5KiK3w4kjBpd
	 rIJgsUiJmfPtNxwguSUPnTxq9W1fSwoMl+ZeARZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389078AbfGWKov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:44:51 -0400
Received: from foss.arm.com ([217.140.110.172]:52524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbfGWKot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:44:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 493951509;
        Tue, 23 Jul 2019 03:44:48 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 613253F71A;
        Tue, 23 Jul 2019 03:44:47 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/9] irqchip/gic: Rework gic_configure_irq to take the full ICFGR base
Date:   Tue, 23 Jul 2019 11:44:29 +0100
Message-Id: <20190723104437.154403-2-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723104437.154403-1-maz@kernel.org>
References: <20190723104437.154403-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index b0a8215a13fc..6900b6f0921c 100644
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
index 9bca4896fa6f..915b4ae8667f 100644
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
index e45f45e68720..ab48760acabb 100644
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
index cf705827599c..1626131834a6 100644
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
 
-- 
2.20.1

