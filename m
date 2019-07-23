Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901CEC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EECB2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 10:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563878719;
	bh=qaS9SmWH34ny5qaNljMBmvTm/kJ2jWyoFQPuXCTeewo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r9cDJNCFbchypMOr/BXNmVYw7zdTT5zwl2EVe4ILSPWJ94S3YJfzBRKIoFa7KFSxw
	 hJV8IMeAylzor5wNbBc/zZ0lm7zA9Rr+jnxQRXe1S84DTZmQbug55tZfW606PxG331
	 wfW6t+JPgi3wP+7hVz+Aikze596HE+Px7Jd50/Sg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389241AbfGWKpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 06:45:18 -0400
Received: from foss.arm.com ([217.140.110.172]:52616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389182AbfGWKo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:44:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 546BE1509;
        Tue, 23 Jul 2019 03:44:57 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C7D23F71A;
        Tue, 23 Jul 2019 03:44:56 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 9/9] irqchip/gic-v3: Add EPPI range support
Date:   Tue, 23 Jul 2019 11:44:37 +0100
Message-Id: <20190723104437.154403-10-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723104437.154403-1-maz@kernel.org>
References: <20190723104437.154403-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expand the pre-existing PPI support to be able to deal with the
Extended PPI range (EPPI). This includes obtaining the number of PPIs
from each individual redistributor, and compute the minimum set
(just in case someone builds something really clever...).

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c       | 42 +++++++++++++++++++++++++-----
 include/linux/irqchip/arm-gic-v3.h | 12 +++++++++
 2 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b85acab4a6a1..c91e4c759c95 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -104,6 +104,7 @@ static DEFINE_PER_CPU(bool, has_rss);
 enum gic_intid_range {
 	PPI_RANGE,
 	SPI_RANGE,
+	EPPI_RANGE,
 	ESPI_RANGE,
 	LPI_RANGE,
 	__INVALID_RANGE__
@@ -116,6 +117,8 @@ static enum gic_intid_range __get_intid_range(irq_hw_number_t hwirq)
 		return PPI_RANGE;
 	case 32 ... 1019:
 		return SPI_RANGE;
+	case EPPI_BASE_INTID ... 1119:
+		return EPPI_RANGE;
 	case ESPI_BASE_INTID ... 8191:
 		return ESPI_RANGE;
 	case 8192 ... GENMASK(23, 0):
@@ -137,13 +140,15 @@ static inline unsigned int gic_irq(struct irq_data *d)
 
 static inline int gic_irq_in_rdist(struct irq_data *d)
 {
-	return get_intid_range(d) == PPI_RANGE;
+	enum gic_intid_range range = get_intid_range(d);
+	return range == PPI_RANGE || range == EPPI_RANGE;
 }
 
 static inline void __iomem *gic_dist_base(struct irq_data *d)
 {
 	switch (get_intid_range(d)) {
 	case PPI_RANGE:
+	case EPPI_RANGE:
 		/* SGI+PPI -> SGI_base for this CPU */
 		return gic_data_rdist_sgi_base();
 
@@ -242,6 +247,14 @@ static u32 convert_offset_index(struct irq_data *d, u32 offset, u32 *index)
 	case SPI_RANGE:
 		*index = d->hwirq;
 		return offset;
+	case EPPI_RANGE:
+		/*
+		 * Contrary to the ESPI range, the EPPI range is contiguous
+		 * to the PPI range in the registers, so let's adjust the
+		 * displacement accordingly. Consistency is overrated.
+		 */
+		*index = d->hwirq - EPPI_BASE_INTID + 32;
+		return offset;
 	case ESPI_RANGE:
 		*index = d->hwirq - ESPI_BASE_INTID;
 		switch (offset) {
@@ -414,6 +427,8 @@ static u32 gic_get_ppi_index(struct irq_data *d)
 	switch (get_intid_range(d)) {
 	case PPI_RANGE:
 		return d->hwirq - 16;
+	case EPPI_RANGE:
+		return d->hwirq - EPPI_BASE_INTID + 16;
 	default:
 		unreachable();
 	}
@@ -507,6 +522,7 @@ static void gic_eoimode1_eoi_irq(struct irq_data *d)
 
 static int gic_set_type(struct irq_data *d, unsigned int type)
 {
+	enum gic_intid_range range;
 	unsigned int irq = gic_irq(d);
 	void (*rwp_wait)(void);
 	void __iomem *base;
@@ -517,9 +533,11 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	if (irq < 16)
 		return -EINVAL;
 
+	range = get_intid_range(d);
+
 	/* SPIs have restrictions on the supported types */
-	if (irq >= 32 && type != IRQ_TYPE_LEVEL_HIGH &&
-			 type != IRQ_TYPE_EDGE_RISING)
+	if ((range == SPI_RANGE || range == ESPI_RANGE) &&
+	    type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
 		return -EINVAL;
 
 	if (gic_irq_in_rdist(d)) {
@@ -533,9 +551,9 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	offset = convert_offset_index(d, GICD_ICFGR, &index);
 
 	ret = gic_configure_irq(index, type, base + offset, rwp_wait);
-	if (ret && irq < 32) {
+	if (ret && (range == PPI_RANGE || range == EPPI_RANGE)) {
 		/* Misconfigured PPIs are usually not fatal */
-		pr_warn("GIC: PPI%d is secure or misconfigured\n", irq - 16);
+		pr_warn("GIC: PPI INTID%d is secure or misconfigured\n", irq);
 		ret = 0;
 	}
 
@@ -833,7 +851,7 @@ static int __gic_update_rdist_properties(struct redist_region *region,
 	u64 typer = gic_read_typer(ptr + GICR_TYPER);
 	gic_data.rdists.has_vlpis &= !!(typer & GICR_TYPER_VLPIS);
 	gic_data.rdists.has_direct_lpi &= !!(typer & GICR_TYPER_DirectLPIS);
-	gic_data.ppi_nr = 16;
+	gic_data.ppi_nr = min(GICR_TYPER_NR_PPIS(typer), gic_data.ppi_nr);
 
 	return 1;
 }
@@ -1218,6 +1236,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 
 	switch (__get_intid_range(hw)) {
 	case PPI_RANGE:
+	case EPPI_RANGE:
 		irq_set_percpu_devid(irq);
 		irq_domain_set_info(d, irq, hw, chip, d->host_data,
 				    handle_percpu_devid_irq, NULL, NULL);
@@ -1262,15 +1281,24 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 			*hwirq = fwspec->param[1] + 32;
 			break;
 		case 1:			/* PPI */
-		case GIC_IRQ_TYPE_PARTITION:
 			*hwirq = fwspec->param[1] + 16;
 			break;
 		case 2:			/* ESPI */
 			*hwirq = fwspec->param[1] + ESPI_BASE_INTID;
 			break;
+		case 3:			/* EPPI */
+			*hwirq = fwspec->param[1] + EPPI_BASE_INTID;
+			break;
 		case GIC_IRQ_TYPE_LPI:	/* LPI */
 			*hwirq = fwspec->param[1];
 			break;
+		case GIC_IRQ_TYPE_PARTITION:
+			*hwirq = fwspec->param[1];
+			if (fwspec->param[1] >= 16)
+				*hwirq += EPPI_BASE_INTID - 16;
+			else
+				*hwirq += 16;
+			break;
 		default:
 			return -EINVAL;
 		}
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index c523bf1faa55..9ec3349dee04 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -124,6 +124,18 @@
 
 #define GICR_TYPER_CPU_NUMBER(r)	(((r) >> 8) & 0xffff)
 
+#define EPPI_BASE_INTID			1056
+
+#define GICR_TYPER_NR_PPIS(r)						\
+	({								\
+		unsigned int __ppinum = ((r) >> 27) & 0x1f;		\
+		unsigned int __nr_ppis = 16;				\
+		if (__ppinum == 1 || __ppinum == 2)			\
+			__nr_ppis +=  __ppinum * 32;			\
+									\
+		__nr_ppis;						\
+	 })
+
 #define GICR_WAKER_ProcessorSleep	(1U << 1)
 #define GICR_WAKER_ChildrenAsleep	(1U << 2)
 
-- 
2.20.1

