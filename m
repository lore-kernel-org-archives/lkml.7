Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C495C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345862173B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565085723;
	bh=su7mbG6gx8vss1ZVSZ1MZlSlT98c8GARl9DjJ8zhdCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b4U5z2qCX+JFxbmhGQc91k0/4BknxZc5zxMSZqVpLEOhM4qkyRJW+8YseOL6g0QSs
	 9dsDY8BnzxiFrGgIL4Jbk7su1SiJ26yVfqOkoHCnOTY4MtAA2Gnz4j/E1EIN4tKWyt
	 nOofEAkTzcm4jOhhbLAgaBmfn1tzhTJZq88ZvNpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732805AbfHFKCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 06:02:01 -0400
Received: from foss.arm.com ([217.140.110.172]:59458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732689AbfHFKBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:01:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8FF0337;
        Tue,  6 Aug 2019 03:01:36 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0A6F3F706;
        Tue,  6 Aug 2019 03:01:35 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     John Garry <john.garry@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 06/12] irqchip/gic-v3: Dynamically allocate PPI NMI refcounts
Date:   Tue,  6 Aug 2019 11:01:15 +0100
Message-Id: <20190806100121.240767-7-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806100121.240767-1-maz@kernel.org>
References: <20190806100121.240767-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we're about to have a variable number of PPIs, let's make the
allocation of the NMI refcounts dynamic. Also apply some minor
cleanups (moving things around).

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c | 47 ++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index e03fb6d7c2ce..4253c7f67c86 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -88,7 +88,7 @@ static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
 static DEFINE_STATIC_KEY_FALSE(supports_pseudo_nmis);
 
 /* ppi_nmi_refs[n] == number of cpus having ppi[n + 16] set as NMI */
-static refcount_t ppi_nmi_refs[16];
+static refcount_t *ppi_nmi_refs;
 
 static struct gic_kvm_info gic_v3_kvm_info;
 static DEFINE_PER_CPU(bool, has_rss);
@@ -409,6 +409,16 @@ static void gic_irq_set_prio(struct irq_data *d, u8 prio)
 	writeb_relaxed(prio, base + offset + index);
 }
 
+static u32 gic_get_ppi_index(struct irq_data *d)
+{
+	switch (get_intid_range(d)) {
+	case PPI_RANGE:
+		return d->hwirq - 16;
+	default:
+		unreachable();
+	}
+}
+
 static int gic_irq_nmi_setup(struct irq_data *d)
 {
 	struct irq_desc *desc = irq_to_desc(d->irq);
@@ -429,10 +439,12 @@ static int gic_irq_nmi_setup(struct irq_data *d)
 		return -EINVAL;
 
 	/* desc lock should already be held */
-	if (gic_irq(d) < 32) {
+	if (gic_irq_in_rdist(d)) {
+		u32 idx = gic_get_ppi_index(d);
+
 		/* Setting up PPI as NMI, only switch handler for first NMI */
-		if (!refcount_inc_not_zero(&ppi_nmi_refs[gic_irq(d) - 16])) {
-			refcount_set(&ppi_nmi_refs[gic_irq(d) - 16], 1);
+		if (!refcount_inc_not_zero(&ppi_nmi_refs[idx])) {
+			refcount_set(&ppi_nmi_refs[idx], 1);
 			desc->handle_irq = handle_percpu_devid_fasteoi_nmi;
 		}
 	} else {
@@ -464,9 +476,11 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
 		return;
 
 	/* desc lock should already be held */
-	if (gic_irq(d) < 32) {
+	if (gic_irq_in_rdist(d)) {
+		u32 idx = gic_get_ppi_index(d);
+
 		/* Tearing down NMI, only switch handler for last NMI */
-		if (refcount_dec_and_test(&ppi_nmi_refs[gic_irq(d) - 16]))
+		if (refcount_dec_and_test(&ppi_nmi_refs[idx]))
 			desc->handle_irq = handle_percpu_devid_irq;
 	} else {
 		desc->handle_irq = handle_fasteoi_irq;
@@ -1394,7 +1408,19 @@ static void gic_enable_nmi_support(void)
 {
 	int i;
 
-	for (i = 0; i < 16; i++)
+	if (!gic_prio_masking_enabled())
+		return;
+
+	if (gic_has_group0() && !gic_dist_security_disabled()) {
+		pr_warn("SCR_EL3.FIQ is cleared, cannot enable use of pseudo-NMIs\n");
+		return;
+	}
+
+	ppi_nmi_refs = kcalloc(gic_data.ppi_nr, sizeof(*ppi_nmi_refs), GFP_KERNEL);
+	if (!ppi_nmi_refs)
+		return;
+
+	for (i = 0; i < gic_data.ppi_nr; i++)
 		refcount_set(&ppi_nmi_refs[i], 0);
 
 	static_branch_enable(&supports_pseudo_nmis);
@@ -1472,12 +1498,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 			gicv2m_init(handle, gic_data.domain);
 	}
 
-	if (gic_prio_masking_enabled()) {
-		if (!gic_has_group0() || gic_dist_security_disabled())
-			gic_enable_nmi_support();
-		else
-			pr_warn("SCR_EL3.FIQ is cleared, cannot enable use of pseudo-NMIs\n");
-	}
+	gic_enable_nmi_support();
 
 	return 0;
 
-- 
2.20.1

