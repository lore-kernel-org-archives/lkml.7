Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2644C43140
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D1421670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403991AbfIFLJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:09:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47066 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392350AbfIFLIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:08:30 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i6C6N-00077z-FK; Fri, 06 Sep 2019 13:08:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CF5911C0E27;
        Fri,  6 Sep 2019 13:08:16 +0200 (CEST)
Date:   Fri, 06 Sep 2019 11:08:16 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3: Dynamically allocate PPI NMI refcounts
Cc:     Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156776809681.24167.5607321387316678190.tip-bot2@tip-bot2>
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

Commit-ID:     81a43273045b116901e569ca27ddf55550f92caf
Gitweb:        https://git.kernel.org/tip/81a43273045b116901e569ca27ddf55550f92caf
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 18 Jul 2019 12:53:05 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 20 Aug 2019 10:23:34 +01:00

irqchip/gic-v3: Dynamically allocate PPI NMI refcounts

As we're about to have a variable number of PPIs, let's make the
allocation of the NMI refcounts dynamic. Also apply some minor
cleanups (moving things around).

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c | 47 +++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index f884dd9..869a805 100644
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
 
