Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A947C43140
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB3B21670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393231AbfIFLJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:09:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47077 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392387AbfIFLIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:08:34 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i6C6N-00078c-C4; Fri, 06 Sep 2019 13:08:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 148E21C0E22;
        Fri,  6 Sep 2019 13:08:17 +0200 (CEST)
Date:   Fri, 06 Sep 2019 11:08:17 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3: Add ESPI range support
Cc:     Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156776809705.24167.8311013008650700749.tip-bot2@tip-bot2>
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

Commit-ID:     211bddd210a6746e4fdfa9b6cdfbdb15026530a7
Gitweb:        https://git.kernel.org/tip/211bddd210a6746e4fdfa9b6cdfbdb15026530a7
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 16 Jul 2019 15:17:31 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 20 Aug 2019 10:23:34 +01:00

irqchip/gic-v3: Add ESPI range support

Add the required support for the ESPI range, which behave exactly like
the SPIs of old, only with new funky INTIDs.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c       | 85 +++++++++++++++++++++++------
 include/linux/irqchip/arm-gic-v3.h | 17 +++++-
 2 files changed, 85 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 660ec43..0afc942 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -51,13 +51,16 @@ struct gic_chip_data {
 	u32			nr_redist_regions;
 	u64			flags;
 	bool			has_rss;
-	unsigned int		irq_nr;
 	struct partition_desc	*ppi_descs[16];
 };
 
 static struct gic_chip_data gic_data __read_mostly;
 static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
 
+#define GIC_ID_NR	(1U << GICD_TYPER_ID_BITS(gic_data.rdists.gicd_typer))
+#define GIC_LINE_NR	max(GICD_TYPER_SPIS(gic_data.rdists.gicd_typer), 1020U)
+#define GIC_ESPI_NR	GICD_TYPER_ESPIS(gic_data.rdists.gicd_typer)
+
 /*
  * The behaviours of RPR and PMR registers differ depending on the value of
  * SCR_EL3.FIQ, and the behaviour of non-secure priority registers of the
@@ -100,6 +103,7 @@ static DEFINE_PER_CPU(bool, has_rss);
 enum gic_intid_range {
 	PPI_RANGE,
 	SPI_RANGE,
+	ESPI_RANGE,
 	LPI_RANGE,
 	__INVALID_RANGE__
 };
@@ -111,6 +115,8 @@ static enum gic_intid_range __get_intid_range(irq_hw_number_t hwirq)
 		return PPI_RANGE;
 	case 32 ... 1019:
 		return SPI_RANGE;
+	case ESPI_BASE_INTID ... (ESPI_BASE_INTID + 1023):
+		return ESPI_RANGE;
 	case 8192 ... GENMASK(23, 0):
 		return LPI_RANGE;
 	default:
@@ -141,6 +147,7 @@ static inline void __iomem *gic_dist_base(struct irq_data *d)
 		return gic_data_rdist_sgi_base();
 
 	case SPI_RANGE:
+	case ESPI_RANGE:
 		/* SPI -> dist_base */
 		return gic_data.dist_base;
 
@@ -234,6 +241,31 @@ static u32 convert_offset_index(struct irq_data *d, u32 offset, u32 *index)
 	case SPI_RANGE:
 		*index = d->hwirq;
 		return offset;
+	case ESPI_RANGE:
+		*index = d->hwirq - ESPI_BASE_INTID;
+		switch (offset) {
+		case GICD_ISENABLER:
+			return GICD_ISENABLERnE;
+		case GICD_ICENABLER:
+			return GICD_ICENABLERnE;
+		case GICD_ISPENDR:
+			return GICD_ISPENDRnE;
+		case GICD_ICPENDR:
+			return GICD_ICPENDRnE;
+		case GICD_ISACTIVER:
+			return GICD_ISACTIVERnE;
+		case GICD_ICACTIVER:
+			return GICD_ICACTIVERnE;
+		case GICD_IPRIORITYR:
+			return GICD_IPRIORITYRnE;
+		case GICD_ICFGR:
+			return GICD_ICFGRnE;
+		case GICD_IROUTER:
+			return GICD_IROUTERnE;
+		default:
+			break;
+		}
+		break;
 	default:
 		break;
 	}
@@ -316,7 +348,7 @@ static int gic_irq_set_irqchip_state(struct irq_data *d,
 {
 	u32 reg;
 
-	if (d->hwirq >= gic_data.irq_nr) /* PPI/SPI only */
+	if (d->hwirq >= 8192) /* PPI/SPI only */
 		return -EINVAL;
 
 	switch (which) {
@@ -343,7 +375,7 @@ static int gic_irq_set_irqchip_state(struct irq_data *d,
 static int gic_irq_get_irqchip_state(struct irq_data *d,
 				     enum irqchip_irq_state which, bool *val)
 {
-	if (d->hwirq >= gic_data.irq_nr) /* PPI/SPI only */
+	if (d->hwirq >= 8192) /* PPI/SPI only */
 		return -EINVAL;
 
 	switch (which) {
@@ -567,7 +599,12 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 		gic_arch_enable_irqs();
 	}
 
-	if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
+	/* Check for special IDs first */
+	if ((irqnr >= 1020 && irqnr <= 1023))
+		return;
+
+	/* Treat anything but SGIs in a uniform way */
+	if (likely(irqnr > 15)) {
 		int err;
 
 		if (static_branch_likely(&supports_deactivate_key))
@@ -655,10 +692,26 @@ static void __init gic_dist_init(void)
 	 * do the right thing if the kernel is running in secure mode,
 	 * but that's not the intended use case anyway.
 	 */
-	for (i = 32; i < gic_data.irq_nr; i += 32)
+	for (i = 32; i < GIC_LINE_NR; i += 32)
 		writel_relaxed(~0, base + GICD_IGROUPR + i / 8);
 
-	gic_dist_config(base, gic_data.irq_nr, gic_dist_wait_for_rwp);
+	/* Extended SPI range, not handled by the GICv2/GICv3 common code */
+	for (i = 0; i < GIC_ESPI_NR; i += 32) {
+		writel_relaxed(~0U, base + GICD_ICENABLERnE + i / 8);
+		writel_relaxed(~0U, base + GICD_ICACTIVERnE + i / 8);
+	}
+
+	for (i = 0; i < GIC_ESPI_NR; i += 32)
+		writel_relaxed(~0U, base + GICD_IGROUPRnE + i / 8);
+
+	for (i = 0; i < GIC_ESPI_NR; i += 16)
+		writel_relaxed(0, base + GICD_ICFGRnE + i / 4);
+
+	for (i = 0; i < GIC_ESPI_NR; i += 4)
+		writel_relaxed(GICD_INT_DEF_PRI_X4, base + GICD_IPRIORITYRnE + i);
+
+	/* Now do the common stuff, and wait for the distributor to drain */
+	gic_dist_config(base, GIC_LINE_NR, gic_dist_wait_for_rwp);
 
 	/* Enable distributor with ARE, Group1 */
 	writel_relaxed(GICD_CTLR_ARE_NS | GICD_CTLR_ENABLE_G1A | GICD_CTLR_ENABLE_G1,
@@ -669,8 +722,11 @@ static void __init gic_dist_init(void)
 	 * enabled.
 	 */
 	affinity = gic_mpidr_to_affinity(cpu_logical_map(smp_processor_id()));
-	for (i = 32; i < gic_data.irq_nr; i++)
+	for (i = 32; i < GIC_LINE_NR; i++)
 		gic_write_irouter(affinity, base + GICD_IROUTER + i * 8);
+
+	for (i = 0; i < GIC_ESPI_NR; i++)
+		gic_write_irouter(affinity, base + GICD_IROUTERnE + i * 8);
 }
 
 static int gic_iterate_rdists(int (*fn)(struct redist_region *, void __iomem *))
@@ -1134,8 +1190,6 @@ static struct irq_chip gic_eoimode1_chip = {
 				  IRQCHIP_MASK_ON_SUSPEND,
 };
 
-#define GIC_ID_NR	(1U << GICD_TYPER_ID_BITS(gic_data.rdists.gicd_typer))
-
 static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hw)
 {
@@ -1153,6 +1207,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		break;
 
 	case SPI_RANGE:
+	case ESPI_RANGE:
 		irq_domain_set_info(d, irq, hw, chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		irq_set_probe(irq);
@@ -1192,6 +1247,9 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 		case GIC_IRQ_TYPE_PARTITION:
 			*hwirq = fwspec->param[1] + 16;
 			break;
+		case 2:			/* ESPI */
+			*hwirq = fwspec->param[1] + ESPI_BASE_INTID;
+			break;
 		case GIC_IRQ_TYPE_LPI:	/* LPI */
 			*hwirq = fwspec->param[1];
 			break;
@@ -1346,7 +1404,6 @@ static int __init gic_init_bases(void __iomem *dist_base,
 				 struct fwnode_handle *handle)
 {
 	u32 typer;
-	int gic_irqs;
 	int err;
 
 	if (!is_hyp_mode_available())
@@ -1363,15 +1420,11 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	/*
 	 * Find out how many interrupts are supported.
-	 * The GIC only supports up to 1020 interrupt sources (SGI+PPI+SPI)
 	 */
 	typer = readl_relaxed(gic_data.dist_base + GICD_TYPER);
 	gic_data.rdists.gicd_typer = typer;
-	gic_irqs = GICD_TYPER_IRQS(typer);
-	if (gic_irqs > 1020)
-		gic_irqs = 1020;
-	gic_data.irq_nr = gic_irqs;
-
+	pr_info("%d SPIs implemented\n", GIC_LINE_NR - 32);
+	pr_info("%d Extended SPIs implemented\n", GIC_ESPI_NR);
 	gic_data.domain = irq_domain_create_tree(handle, &gic_irq_domain_ops,
 						 &gic_data);
 	irq_domain_update_bus_token(gic_data.domain, DOMAIN_BUS_WIRED);
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 67c4b98..c523bf1 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -30,10 +30,22 @@
 #define GICD_ICFGR			0x0C00
 #define GICD_IGRPMODR			0x0D00
 #define GICD_NSACR			0x0E00
+#define GICD_IGROUPRnE			0x1000
+#define GICD_ISENABLERnE		0x1200
+#define GICD_ICENABLERnE		0x1400
+#define GICD_ISPENDRnE			0x1600
+#define GICD_ICPENDRnE			0x1800
+#define GICD_ISACTIVERnE		0x1A00
+#define GICD_ICACTIVERnE		0x1C00
+#define GICD_IPRIORITYRnE		0x2000
+#define GICD_ICFGRnE			0x3000
 #define GICD_IROUTER			0x6000
+#define GICD_IROUTERnE			0x8000
 #define GICD_IDREGS			0xFFD0
 #define GICD_PIDR2			0xFFE8
 
+#define ESPI_BASE_INTID			4096
+
 /*
  * Those registers are actually from GICv2, but the spec demands that they
  * are implemented as RES0 if ARE is 1 (which we do in KVM's emulated GICv3).
@@ -69,10 +81,13 @@
 #define GICD_TYPER_RSS			(1U << 26)
 #define GICD_TYPER_LPIS			(1U << 17)
 #define GICD_TYPER_MBIS			(1U << 16)
+#define GICD_TYPER_ESPI			(1U << 8)
 
 #define GICD_TYPER_ID_BITS(typer)	((((typer) >> 19) & 0x1f) + 1)
 #define GICD_TYPER_NUM_LPIS(typer)	((((typer) >> 11) & 0x1f) + 1)
-#define GICD_TYPER_IRQS(typer)		((((typer) & 0x1f) + 1) * 32)
+#define GICD_TYPER_SPIS(typer)		((((typer) & 0x1f) + 1) * 32)
+#define GICD_TYPER_ESPIS(typer)						\
+	(((typer) & GICD_TYPER_ESPI) ? GICD_TYPER_SPIS((typer) >> 27) : 0)
 
 #define GICD_IROUTER_SPI_MODE_ONE	(0U << 31)
 #define GICD_IROUTER_SPI_MODE_ANY	(1U << 31)
