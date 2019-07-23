Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230D3C7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7D422543
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563878710;
	bh=Br4ddll1kTZdHBrW5FwZ/z/uoaYhUtj2MLOot/tX1Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xNqlFExb9UgNAox6qlzUNJoWWZxLfYhPsy2Wex8evE5zUMzVVl585J7PxtUB4Q5bI
	 nfKQ4sybt3e0zli0W2SuRw8e6mwuGV6joRar6Y/rY3YrPsr1hwuGhRHnvFCRqrR7Br
	 H/P8CYv+gm48r/EeIFZeJYzYuuOgLjX1hE0WSE/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389204AbfGWKpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:45:07 -0400
Received: from foss.arm.com ([217.140.110.172]:52572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389125AbfGWKox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:44:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D661415A1;
        Tue, 23 Jul 2019 03:44:52 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEA783F71A;
        Tue, 23 Jul 2019 03:44:51 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/9] irqchip/gic: Prepare for more than 16 PPIs
Date:   Tue, 23 Jul 2019 11:44:33 +0100
Message-Id: <20190723104437.154403-6-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723104437.154403-1-maz@kernel.org>
References: <20190723104437.154403-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GICv3.1 allows up to 80 PPIs (16 legaci PPIs and 64 Extended PPIs),
meaning we can't just leave the old 16 hardcoded everywhere.

We also need to add the infrastructure to discuver the number of PPIs
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
index 6900b6f0921c..14110db01c05 100644
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
index 5a46b6b57750..ccba8b0fe0f5 100644
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
index d328a8de533f..2d4ecf36d0fd 100644
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
@@ -964,6 +970,7 @@ static int gic_dist_supports_lpis(void)
 static void gic_cpu_init(void)
 {
 	void __iomem *rbase;
+	int i;
 
 	/* Register ourselves with the rest of the world */
 	if (gic_populate_rdist())
@@ -974,9 +981,10 @@ static void gic_cpu_init(void)
 	rbase = gic_data_rdist_sgi_base();
 
 	/* Configure SGIs/PPIs as non-secure Group-1 */
-	writel_relaxed(~0, rbase + GICR_IGROUPR0);
+	for (i = 0; i < gic_data.ppi_nr + 16; i += 32)
+		writel_relaxed(~0, rbase + GICR_IGROUPR0 + i / 8);
 
-	gic_cpu_config(rbase, gic_redist_wait_for_rwp);
+	gic_cpu_config(rbase, gic_data.ppi_nr + 16, gic_redist_wait_for_rwp);
 
 	/* initialise system registers */
 	gic_cpu_sys_reg_init();
@@ -1445,7 +1453,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	set_handle_irq(gic_handle_irq);
 
-	gic_update_vlpi_properties();
+	gic_update_rdist_properties();
 
 	gic_smp_init();
 	gic_dist_init();
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index ab48760acabb..25c1ae69db30 100644
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
index 1626131834a6..130caa1c9d93 100644
--- a/drivers/irqchip/irq-hip04.c
+++ b/drivers/irqchip/irq-hip04.c
@@ -273,7 +273,7 @@ static void hip04_irq_cpu_init(struct hip04_irq_data *intc)
 		if (i != cpu)
 			hip04_cpu_map[i] &= ~cpu_mask;
 
-	gic_cpu_config(dist_base, NULL);
+	gic_cpu_config(dist_base, 32, NULL);
 
 	writel_relaxed(0xf0, base + GIC_CPU_PRIMASK);
 	writel_relaxed(1, base + GIC_CPU_CTRL);
-- 
2.20.1

