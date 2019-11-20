Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDB0C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AF32251F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfKTNWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:22:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56766 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbfKTNVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:19 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPuw-00079t-9r; Wed, 20 Nov 2019 14:21:10 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4B72D1C1A14;
        Wed, 20 Nov 2019 14:21:04 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:04 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3-its: Kill its->device_ids and use
 TYPER copy instead
Cc:     Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191027144234.8395-7-maz@kernel.org>
References: <20191027144234.8395-7-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <157425606422.12247.11348364268048333731.tip-bot2@tip-bot2>
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

Commit-ID:     576a83429757999f220f36f206044af2b9026672
Gitweb:        https://git.kernel.org/tip/576a83429757999f220f36f206044af2b9026672
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 08 Nov 2019 16:58:00 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Nov 2019 18:47:52 

irqchip/gic-v3-its: Kill its->device_ids and use TYPER copy instead

Now that we have a copy of TYPER in the ITS structure, rely on this
to provide the same service as its->device_ids, which gets axed.
Errata workarounds are now updating the cached fields instead of
requiring a separate field in the ITS structure.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/r/20191027144234.8395-7-maz@kernel.org
Link: https://lore.kernel.org/r/20191108165805.3071-7-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c   | 24 +++++++++++++-----------
 include/linux/irqchip/arm-gic-v3.h |  2 +-
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index c3a1e47..e8aeb07 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -109,7 +109,6 @@ struct its_node {
 	struct list_head	its_device_list;
 	u64			flags;
 	unsigned long		list_nr;
-	u32			device_ids;
 	int			numa_node;
 	unsigned int		msi_domain_flags;
 	u32			pre_its_base; /* for Socionext Synquacer */
@@ -117,6 +116,7 @@ struct its_node {
 };
 
 #define is_v4(its)		(!!((its)->typer & GITS_TYPER_VLPIS))
+#define device_ids(its)		(FIELD_GET(GITS_TYPER_DEVBITS, (its)->typer) + 1)
 
 #define ITS_ITT_ALIGN		SZ_256
 
@@ -1956,9 +1956,9 @@ static bool its_parse_indirect_baser(struct its_node *its,
 	if (new_order >= MAX_ORDER) {
 		new_order = MAX_ORDER - 1;
 		ids = ilog2(PAGE_ORDER_TO_SIZE(new_order) / (int)esz);
-		pr_warn("ITS@%pa: %s Table too large, reduce ids %u->%u\n",
+		pr_warn("ITS@%pa: %s Table too large, reduce ids %llu->%u\n",
 			&its->phys_base, its_base_type_string[type],
-			its->device_ids, ids);
+			device_ids(its), ids);
 	}
 
 	*order = new_order;
@@ -2004,7 +2004,7 @@ static int its_alloc_tables(struct its_node *its)
 		case GITS_BASER_TYPE_DEVICE:
 			indirect = its_parse_indirect_baser(its, baser,
 							    psz, &order,
-							    its->device_ids);
+							    device_ids(its));
 			break;
 
 		case GITS_BASER_TYPE_VCPU:
@@ -2395,7 +2395,7 @@ static bool its_alloc_device_table(struct its_node *its, u32 dev_id)
 
 	/* Don't allow device id that exceeds ITS hardware limit */
 	if (!baser)
-		return (ilog2(dev_id) < its->device_ids);
+		return (ilog2(dev_id) < device_ids(its));
 
 	return its_alloc_table_entry(its, baser, dev_id);
 }
@@ -3247,8 +3247,9 @@ static bool __maybe_unused its_enable_quirk_cavium_22375(void *data)
 {
 	struct its_node *its = data;
 
-	/* erratum 22375: only alloc 8MB table size */
-	its->device_ids = 0x14;		/* 20 bits, 8MB */
+	/* erratum 22375: only alloc 8MB table size (20 bits) */
+	its->typer &= ~GITS_TYPER_DEVBITS;
+	its->typer |= FIELD_PREP(GITS_TYPER_DEVBITS, 20 - 1);
 	its->flags |= ITS_FLAGS_WORKAROUND_CAVIUM_22375;
 
 	return true;
@@ -3303,8 +3304,10 @@ static bool __maybe_unused its_enable_quirk_socionext_synquacer(void *data)
 		its->get_msi_base = its_irq_get_msi_base_pre_its;
 
 		ids = ilog2(pre_its_window[1]) - 2;
-		if (its->device_ids > ids)
-			its->device_ids = ids;
+		if (device_ids(its) > ids) {
+			its->typer &= ~GITS_TYPER_DEVBITS;
+			its->typer |= FIELD_PREP(GITS_TYPER_DEVBITS, ids - 1);
+		}
 
 		/* the pre-ITS breaks isolation, so disable MSI remapping */
 		its->msi_domain_flags &= ~IRQ_DOMAIN_FLAG_MSI_REMAP;
@@ -3537,7 +3540,7 @@ static int its_init_vpe_domain(void)
 	}
 
 	/* Use the last possible DevID */
-	devid = GENMASK(its->device_ids - 1, 0);
+	devid = GENMASK(device_ids(its) - 1, 0);
 	vpe_proxy.dev = its_create_device(its, devid, entries, false);
 	if (!vpe_proxy.dev) {
 		kfree(vpe_proxy.vpes);
@@ -3638,7 +3641,6 @@ static int __init its_probe_one(struct resource *res,
 	its->typer = typer;
 	its->base = its_base;
 	its->phys_base = res->start;
-	its->device_ids = GITS_TYPER_DEVBITS(typer);
 	if (is_v4(its)) {
 		if (!(typer & GITS_TYPER_VMOVP)) {
 			err = its_compute_its_list_map(res, its_base);
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 4bce7a9..b6514e8 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -337,7 +337,7 @@
 #define GITS_TYPER_ITT_ENTRY_SIZE	GENMASK_ULL(7, 4)
 #define GITS_TYPER_IDBITS_SHIFT		8
 #define GITS_TYPER_DEVBITS_SHIFT	13
-#define GITS_TYPER_DEVBITS(r)		((((r) >> GITS_TYPER_DEVBITS_SHIFT) & 0x1f) + 1)
+#define GITS_TYPER_DEVBITS		GENMASK_ULL(17, 13)
 #define GITS_TYPER_PTA			(1UL << 19)
 #define GITS_TYPER_HCC_SHIFT		24
 #define GITS_TYPER_HCC(r)		(((r) >> GITS_TYPER_HCC_SHIFT) & 0xff)
