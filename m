Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D176CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A890121850
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572187404;
	bh=cUEdEwphqN43cYOxa2q8QizaXOhiNpLrbbRlDlA67fU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1por/EmaYmIw/Yb9MnMgExTMQ+dmSEbtfqa5W9PZASI+JLtNJqDJgHpzgrOwVyirI
	 5ByaYPrD1HJwc91k//AFgbGOUCUuKaH2pFLH6dajwQxL1f+z1hv+pH2uw7R4FPP1dA
	 +retuzdjWPSHXZo/anfUU5fSxjZxnq6TT1FvRkLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfJ0OnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 10:43:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbfJ0OnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 10:43:23 -0400
Received: from localhost.localdomain (82-132-239-15.dab.02.net [82.132.239.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42B09214AF;
        Sun, 27 Oct 2019 14:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572187401;
        bh=cUEdEwphqN43cYOxa2q8QizaXOhiNpLrbbRlDlA67fU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sky7QoVE+aOUCloU1W0N0ZxRF7ELtvLkESfQ1fXIRrobyIUb/3X8NdgVafHtQwyut
         NQnVXCUV6W0Dv5mOSRKmfT36XkRQCGNhCHN2QxfYjffWu2b2OVd5uIbR0FOy7oM5Jp
         rDUF6A62v6+F8c2hkEeqfYO7HL8q4rTMv+i5o+bI=
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Cc:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Jayachandran C <jnair@marvell.com>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2 04/36] irqchip/gic-v3-its: Make is_v4 use a TYPER copy
Date:   Sun, 27 Oct 2019 14:42:02 +0000
Message-Id: <20191027144234.8395-5-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191027144234.8395-1-maz@kernel.org>
References: <20191027144234.8395-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of caching the GICv4 compatibility in a discrete way, cache the
TYPER register instead, which can then be used to implement the same
functionnality. This will get used more extensively in subsequent patches.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 3e33cdc08200..b3c9bc0c3ecd 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -102,6 +102,7 @@ struct its_node {
 	struct its_collection	*collections;
 	struct fwnode_handle	*fwnode_handle;
 	u64			(*get_msi_base)(struct its_device *its_dev);
+	u64			typer;
 	u64			cbaser_save;
 	u32			ctlr_save;
 	struct list_head	its_device_list;
@@ -112,10 +113,11 @@ struct its_node {
 	int			numa_node;
 	unsigned int		msi_domain_flags;
 	u32			pre_its_base; /* for Socionext Synquacer */
-	bool			is_v4;
 	int			vlpi_redist_offset;
 };
 
+#define is_v4(its)		(!!((its)->typer & GITS_TYPER_VLPIS))
+
 #define ITS_ITT_ALIGN		SZ_256
 
 /* The maximum number of VPEID bits supported by VLPI commands */
@@ -1019,7 +1021,7 @@ static void its_send_vmovp(struct its_vpe *vpe)
 
 	/* Emit VMOVPs */
 	list_for_each_entry(its, &its_nodes, entry) {
-		if (!its->is_v4)
+		if (!is_v4(its))
 			continue;
 
 		if (!vpe->its_vm->vlpi_count[its->list_nr])
@@ -1430,7 +1432,7 @@ static int its_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 	struct its_cmd_info *info = vcpu_info;
 
 	/* Need a v4 ITS */
-	if (!its_dev->its->is_v4)
+	if (!is_v4(its_dev->its))
 		return -EINVAL;
 
 	/* Unmap request? */
@@ -2394,7 +2396,7 @@ static bool its_alloc_vpe_table(u32 vpe_id)
 	list_for_each_entry(its, &its_nodes, entry) {
 		struct its_baser *baser;
 
-		if (!its->is_v4)
+		if (!is_v4(its))
 			continue;
 
 		baser = its_get_baser(its, GITS_BASER_TYPE_VCPU);
@@ -2882,7 +2884,7 @@ static void its_vpe_invall(struct its_vpe *vpe)
 	struct its_node *its;
 
 	list_for_each_entry(its, &its_nodes, entry) {
-		if (!its->is_v4)
+		if (!is_v4(its))
 			continue;
 
 		if (its_list_map && !vpe->its_vm->vlpi_count[its->list_nr])
@@ -3150,7 +3152,7 @@ static int its_vpe_irq_domain_activate(struct irq_domain *domain,
 	vpe->col_idx = cpumask_first(cpu_online_mask);
 
 	list_for_each_entry(its, &its_nodes, entry) {
-		if (!its->is_v4)
+		if (!is_v4(its))
 			continue;
 
 		its_send_vmapp(its, vpe, true);
@@ -3176,7 +3178,7 @@ static void its_vpe_irq_domain_deactivate(struct irq_domain *domain,
 		return;
 
 	list_for_each_entry(its, &its_nodes, entry) {
-		if (!its->is_v4)
+		if (!is_v4(its))
 			continue;
 
 		its_send_vmapp(its, vpe, false);
@@ -3614,12 +3616,12 @@ static int __init its_probe_one(struct resource *res,
 	INIT_LIST_HEAD(&its->entry);
 	INIT_LIST_HEAD(&its->its_device_list);
 	typer = gic_read_typer(its_base + GITS_TYPER);
+	its->typer = typer;
 	its->base = its_base;
 	its->phys_base = res->start;
 	its->ite_size = GITS_TYPER_ITT_ENTRY_SIZE(typer);
 	its->device_ids = GITS_TYPER_DEVBITS(typer);
-	its->is_v4 = !!(typer & GITS_TYPER_VLPIS);
-	if (its->is_v4) {
+	if (is_v4(its)) {
 		if (!(typer & GITS_TYPER_VMOVP)) {
 			err = its_compute_its_list_map(res, its_base);
 			if (err < 0)
@@ -3686,7 +3688,7 @@ static int __init its_probe_one(struct resource *res,
 	gits_write_cwriter(0, its->base + GITS_CWRITER);
 	ctlr = readl_relaxed(its->base + GITS_CTLR);
 	ctlr |= GITS_CTLR_ENABLE;
-	if (its->is_v4)
+	if (is_v4(its))
 		ctlr |= GITS_CTLR_ImDe;
 	writel_relaxed(ctlr, its->base + GITS_CTLR);
 
@@ -4011,7 +4013,7 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 		return err;
 
 	list_for_each_entry(its, &its_nodes, entry)
-		has_v4 |= its->is_v4;
+		has_v4 |= is_v4(its);
 
 	if (has_v4 & rdists->has_vlpis) {
 		if (its_init_vpe_domain() ||
-- 
2.20.1

