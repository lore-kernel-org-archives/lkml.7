Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17658C00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E767F21670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393036AbfIFLIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:08:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47049 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392266AbfIFLI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:08:28 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i6C6J-00078K-Ks; Fri, 06 Sep 2019 13:08:23 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EC05B1C0E28;
        Fri,  6 Sep 2019 13:08:16 +0200 (CEST)
Date:   Fri, 06 Sep 2019 11:08:16 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic: Prepare for more than 16 PPIs
Cc:     Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156776809692.24167.5379815403831575120.tip-bot2@tip-bot2>
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

Commit-ID:     1a60e1e6439164c06636dce5d32660de505d23c3
Gitweb:        https://git.kernel.org/tip/1a60e1e6439164c06636dce5d32660de505d23c3
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 18 Jul 2019 11:15:14 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 20 Aug 2019 10:23:34 +01:00

irqchip/gic: Prepare for more than 16 PPIs

GICv3.1 allows up to 80 PPIs (16 legaci PPIs and 64 Extended PPIs),
meaning we can't just leave the old 16 hardcoded everywhere.

We also need to add the infrastructure to discover the number of PPIs
on a per redistributor basis, although we still pretend there is only
16 of them for now.

No functional change.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-common.c | 19 ++++++++++++-------
 drivers/irqchip/irq-gic-common.h |  2 +-
 drivers/irqchip/irq-gic-v3.c     | 22 +++++++++++++++-------
 drivers/irqchip/irq-gic.c        |  2 +-
 drivers/irqchip/irq-hip04.c      |  2 +-
 5 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index 6900b6f..14110db 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -128,26 +128,31 @@ void gic_dist_config(void __iomem *base, int gic_irqs,
 		sync_access();
 }
 
-void gic_cpu_config(void __iomem *base, void (*sync_access)(void))
+void gic_cpu_config(void __iomem *base, int nr, void (*sync_access)(void))
 {
 	int i;
 
 	/*
 	 * Deal with the banked PPI and SGI interrupts - disable all
-	 * PPI interrupts, ensure all SGI interrupts are enabled.
-	 * Make sure everything is deactivated.
+	 * private interrupts. Make sure everything is deactivated.
 	 */
-	writel_relaxed(GICD_INT_EN_CLR_X32, base + GIC_DIST_ACTIVE_CLEAR);
-	writel_relaxed(GICD_INT_EN_CLR_PPI, base + GIC_DIST_ENABLE_CLEAR);
-	writel_relaxed(GICD_INT_EN_SET_SGI, base + GIC_DIST_ENABLE_SET);
+	for (i = 0; i < nr; i += 32) {
+		writel_relaxed(GICD_INT_EN_CLR_X32,
+			       base + GIC_DIST_ACTIVE_CLEAR + i / 8);
+		writel_relaxed(GICD_INT_EN_CLR_X32,
+			       base + GIC_DIST_ENABLE_CLEAR + i / 8);
+	}
 
 	/*
 	 * Set priority on PPI and SGI interrupts
 	 */
-	for (i = 0; i < 32; i += 4)
+	for (i = 0; i < nr; i += 4)
 		writel_relaxed(GICD_INT_DEF_PRI_X4,
 					base + GIC_DIST_PRI + i * 4 / 4);
 
+	/* Ensure all SGI interrupts are now enabled */
+	writel_relaxed(GICD_INT_EN_SET_SGI, base + GIC_DIST_ENABLE_SET);
+
 	if (sync_access)
 		sync_access();
 }
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index 5a46b6b..ccba8b0 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -22,7 +22,7 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
                        void __iomem *base, void (*sync_access)(void));
 void gic_dist_config(void __iomem *base, int gic_irqs,
 		     void (*sync_access)(void));
-void gic_cpu_config(void __iomem *base, void (*sync_access)(void));
+void gic_cpu_config(void __iomem *base, int nr, void (*sync_access)(void));
 void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 		void *data);
 void gic_enable_of_quirks(const struct device_node *np,
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 0afc942..f884dd9 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -51,6 +51,7 @@ struct gic_chip_data {
 	u32			nr_redist_regions;
 	u64			flags;
 	bool			has_rss;
+	unsigned int		ppi_nr;
 	struct partition_desc	*ppi_descs[16];
 };
 
@@ -812,19 +813,24 @@ static int gic_populate_rdist(void)
 	return -ENODEV;
 }
 
-static int __gic_update_vlpi_properties(struct redist_region *region,
-					void __iomem *ptr)
+static int __gic_update_rdist_properties(struct redist_region *region,
+					 void __iomem *ptr)
 {
 	u64 typer = gic_read_typer(ptr + GICR_TYPER);
 	gic_data.rdists.has_vlpis &= !!(typer & GICR_TYPER_VLPIS);
 	gic_data.rdists.has_direct_lpi &= !!(typer & GICR_TYPER_DirectLPIS);
+	gic_data.ppi_nr = 16;
 
 	return 1;
 }
 
-static void gic_update_vlpi_properties(void)
+static void gic_update_rdist_properties(void)
 {
-	gic_iterate_rdists(__gic_update_vlpi_properties);
+	gic_data.ppi_nr = UINT_MAX;
+	gic_iterate_rdists(__gic_update_rdist_properties);
+	if (WARN_ON(gic_data.ppi_nr == UINT_MAX))
+		gic_data.ppi_nr = 0;
+	pr_info("%d PPIs implemented\n", gic_data.ppi_nr);
 	pr_info("%sVLPI support, %sdirect LPI support\n",
 		!gic_data.rdists.has_vlpis ? "no " : "",
 		!gic_data.rdists.has_direct_lpi ? "no " : "");
@@ -968,6 +974,7 @@ static int gic_dist_supports_lpis(void)
 static void gic_cpu_init(void)
 {
 	void __iomem *rbase;
+	int i;
 
 	/* Register ourselves with the rest of the world */
 	if (gic_populate_rdist())
@@ -978,9 +985,10 @@ static void gic_cpu_init(void)
 	rbase = gic_data_rdist_sgi_base();
 
 	/* Configure SGIs/PPIs as non-secure Group-1 */
-	writel_relaxed(~0, rbase + GICR_IGROUPR0);
+	for (i = 0; i < gic_data.ppi_nr + 16; i += 32)
+		writel_relaxed(~0, rbase + GICR_IGROUPR0 + i / 8);
 
-	gic_cpu_config(rbase, gic_redist_wait_for_rwp);
+	gic_cpu_config(rbase, gic_data.ppi_nr + 16, gic_redist_wait_for_rwp);
 
 	/* initialise system registers */
 	gic_cpu_sys_reg_init();
@@ -1449,7 +1457,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	set_handle_irq(gic_handle_irq);
 
-	gic_update_vlpi_properties();
+	gic_update_rdist_properties();
 
 	gic_smp_init();
 	gic_dist_init();
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 5ca7d55..30ab623 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -543,7 +543,7 @@ static int gic_cpu_init(struct gic_chip_data *gic)
 				gic_cpu_map[i] &= ~cpu_mask;
 	}
 
-	gic_cpu_config(dist_base, NULL);
+	gic_cpu_config(dist_base, 32, NULL);
 
 	writel_relaxed(GICC_INT_PRI_THRESHOLD, base + GIC_CPU_PRIMASK);
 	gic_cpu_if_up(gic);
diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
index 1626131..130caa1 100644
--- a/drivers/irqchip/irq-hip04.c
+++ b/drivers/irqchip/irq-hip04.c
@@ -273,7 +273,7 @@ static void hip04_irq_cpu_init(struct hip04_irq_data *intc)
 		if (i != cpu)
 			hip04_cpu_map[i] &= ~cpu_mask;
 
-	gic_cpu_config(dist_base, NULL);
+	gic_cpu_config(dist_base, 32, NULL);
 
 	writel_relaxed(0xf0, base + GIC_CPU_PRIMASK);
 	writel_relaxed(1, base + GIC_CPU_CTRL);
