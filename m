Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E04EC5DF61
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7437E21882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572970999;
	bh=12e4qL6ftVehsKpuSSeZuHLcddVERrtAHBjLyEEFY7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QhEJ3e2VgyOdtfVpHvqUfy5a3z8eXeniJL7eiv/8Y2GXoX7r7fkFkJr8rt61F8XeN
	 mhBJd6cPNeLkrjzY8rP7xwZny5TCHSsVBVcSKdd5jKGo4Su9+qsh1b86BXRQK5bOWw
	 e6mWnhdOIXyVbfvSO3EtMXUsgWhX/E9E6s0cLhZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390238AbfKEQXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 11:23:18 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:51960 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390083AbfKEQXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 11:23:14 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iS1bs-0001q9-68; Tue, 05 Nov 2019 17:23:12 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, lorenzo.pieralisi@arm.com,
        Andrew.Murray@arm.com, yuzenghui@huawei.com,
        Heyi Guo <guoheyi@huawei.com>
Subject: [PATCH 04/11] irqchip/gic-v3-its: Make is_v4 use a TYPER copy
Date:   Tue,  5 Nov 2019 16:22:51 +0000
Message-Id: <20191105162258.22214-5-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191105162258.22214-1-maz@kernel.org>
References: <20191105162258.22214-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, Andrew.Murray@arm.com, yuzenghui@huawei.com, guoheyi@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of caching the GICv4 compatibility in a discrete way, cache the
TYPER register instead, which can then be used to implement the same
functionnality. This will get used more extensively in subsequent patches.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index b9e9314ed702..a5d947b243f2 100644
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
@@ -1034,7 +1036,7 @@ static void its_send_vmovp(struct its_vpe *vpe)
 
 	/* Emit VMOVPs */
 	list_for_each_entry(its, &its_nodes, entry) {
-		if (!its->is_v4)
+		if (!is_v4(its))
 			continue;
 
 		if (!vpe->its_vm->vlpi_count[its->list_nr])
@@ -1445,7 +1447,7 @@ static int its_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 	struct its_cmd_info *info = vcpu_info;
 
 	/* Need a v4 ITS */
-	if (!its_dev->its->is_v4)
+	if (!is_v4(its_dev->its))
 		return -EINVAL;
 
 	/* Unmap request? */
@@ -2409,7 +2411,7 @@ static bool its_alloc_vpe_table(u32 vpe_id)
 	list_for_each_entry(its, &its_nodes, entry) {
 		struct its_baser *baser;
 
-		if (!its->is_v4)
+		if (!is_v4(its))
 			continue;
 
 		baser = its_get_baser(its, GITS_BASER_TYPE_VCPU);
@@ -2898,7 +2900,7 @@ static void its_vpe_invall(struct its_vpe *vpe)
 	struct its_node *its;
 
 	list_for_each_entry(its, &its_nodes, entry) {
-		if (!its->is_v4)
+		if (!is_v4(its))
 			continue;
 
 		if (its_list_map && !vpe->its_vm->vlpi_count[its->list_nr])
@@ -3166,7 +3168,7 @@ static int its_vpe_irq_domain_activate(struct irq_domain *domain,
 	vpe->col_idx = cpumask_first(cpu_online_mask);
 
 	list_for_each_entry(its, &its_nodes, entry) {
-		if (!its->is_v4)
+		if (!is_v4(its))
 			continue;
 
 		its_send_vmapp(its, vpe, true);
@@ -3192,7 +3194,7 @@ static void its_vpe_irq_domain_deactivate(struct irq_domain *domain,
 		return;
 
 	list_for_each_entry(its, &its_nodes, entry) {
-		if (!its->is_v4)
+		if (!is_v4(its))
 			continue;
 
 		its_send_vmapp(its, vpe, false);
@@ -3630,12 +3632,12 @@ static int __init its_probe_one(struct resource *res,
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
@@ -3702,7 +3704,7 @@ static int __init its_probe_one(struct resource *res,
 	gits_write_cwriter(0, its->base + GITS_CWRITER);
 	ctlr = readl_relaxed(its->base + GITS_CTLR);
 	ctlr |= GITS_CTLR_ENABLE;
-	if (its->is_v4)
+	if (is_v4(its))
 		ctlr |= GITS_CTLR_ImDe;
 	writel_relaxed(ctlr, its->base + GITS_CTLR);
 
@@ -4027,7 +4029,7 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 		return err;
 
 	list_for_each_entry(its, &its_nodes, entry)
-		has_v4 |= its->is_v4;
+		has_v4 |= is_v4(its);
 
 	if (has_v4 & rdists->has_vlpis) {
 		if (its_init_vpe_domain() ||
-- 
2.20.1

