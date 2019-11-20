Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36022C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E43E2251F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbfKTNVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:21:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56818 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbfKTNVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:25 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPuy-0007AV-Lb; Wed, 20 Nov 2019 14:21:12 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AA72D1C1A16;
        Wed, 20 Nov 2019 14:21:04 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:04 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3-its: Make is_v4 use a TYPER copy
Cc:     Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191027144234.8395-5-maz@kernel.org>
References: <20191027144234.8395-5-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <157425606463.12247.12920936505160143228.tip-bot2@tip-bot2>
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

Commit-ID:     0dd57fed6b46659b2db1156cb9100fbcfef6fe5d
Gitweb:        https://git.kernel.org/tip/0dd57fed6b46659b2db1156cb9100fbcfef6fe5d
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 08 Nov 2019 16:57:58 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Nov 2019 18:47:51 

irqchip/gic-v3-its: Make is_v4 use a TYPER copy

Instead of caching the GICv4 compatibility in a discrete way, cache the
TYPER register instead, which can then be used to implement the same
functionnality. This will get used more extensively in subsequent patches.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/r/20191027144234.8395-5-maz@kernel.org
Link: https://lore.kernel.org/r/20191108165805.3071-5-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 6065b09..5bb3eac 100644
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
@@ -181,7 +183,7 @@ static u16 get_its_list(struct its_vm *vm)
 	unsigned long its_list = 0;
 
 	list_for_each_entry(its, &its_nodes, entry) {
-		if (!its->is_v4)
+		if (!is_v4(its))
 			continue;
 
 		if (vm->vlpi_count[its->list_nr])
@@ -1037,7 +1039,7 @@ static void its_send_vmovp(struct its_vpe *vpe)
 
 	/* Emit VMOVPs */
 	list_for_each_entry(its, &its_nodes, entry) {
-		if (!its->is_v4)
+		if (!is_v4(its))
 			continue;
 
 		if (!vpe->its_vm->vlpi_count[its->list_nr])
@@ -1448,7 +1450,7 @@ static int its_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 	struct its_cmd_info *info = vcpu_info;
 
 	/* Need a v4 ITS */
-	if (!its_dev->its->is_v4)
+	if (!is_v4(its_dev->its))
 		return -EINVAL;
 
 	/* Unmap request? */
@@ -2412,7 +2414,7 @@ static bool its_alloc_vpe_table(u32 vpe_id)
 	list_for_each_entry(its, &its_nodes, entry) {
 		struct its_baser *baser;
 
-		if (!its->is_v4)
+		if (!is_v4(its))
 			continue;
 
 		baser = its_get_baser(its, GITS_BASER_TYPE_VCPU);
@@ -2900,7 +2902,7 @@ static void its_vpe_invall(struct its_vpe *vpe)
 	struct its_node *its;
 
 	list_for_each_entry(its, &its_nodes, entry) {
-		if (!its->is_v4)
+		if (!is_v4(its))
 			continue;
 
 		if (its_list_map && !vpe->its_vm->vlpi_count[its->list_nr])
@@ -3168,7 +3170,7 @@ static int its_vpe_irq_domain_activate(struct irq_domain *domain,
 	vpe->col_idx = cpumask_first(cpu_online_mask);
 
 	list_for_each_entry(its, &its_nodes, entry) {
-		if (!its->is_v4)
+		if (!is_v4(its))
 			continue;
 
 		its_send_vmapp(its, vpe, true);
@@ -3194,7 +3196,7 @@ static void its_vpe_irq_domain_deactivate(struct irq_domain *domain,
 		return;
 
 	list_for_each_entry(its, &its_nodes, entry) {
-		if (!its->is_v4)
+		if (!is_v4(its))
 			continue;
 
 		its_send_vmapp(its, vpe, false);
@@ -3632,12 +3634,12 @@ static int __init its_probe_one(struct resource *res,
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
@@ -3704,7 +3706,7 @@ static int __init its_probe_one(struct resource *res,
 	gits_write_cwriter(0, its->base + GITS_CWRITER);
 	ctlr = readl_relaxed(its->base + GITS_CTLR);
 	ctlr |= GITS_CTLR_ENABLE;
-	if (its->is_v4)
+	if (is_v4(its))
 		ctlr |= GITS_CTLR_ImDe;
 	writel_relaxed(ctlr, its->base + GITS_CTLR);
 
@@ -4029,7 +4031,7 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 		return err;
 
 	list_for_each_entry(its, &its_nodes, entry)
-		has_v4 |= its->is_v4;
+		has_v4 |= is_v4(its);
 
 	if (has_v4 & rdists->has_vlpis) {
 		if (its_init_vpe_domain() ||
