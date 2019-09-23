Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA48AC4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F9720665
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569263219;
	bh=Go+WF0ojIvZEza1BV8OiNEXrSvCkj1CJpj6PQAyGMvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=loA7wixZ3dI3Tj/sFaxxc5OeQz/9131ax5UGWeRQdTdKi6I/baBrMouV8bzSqd3NF
	 uJ/kOmNFm03lKuYN9hYI952Ia+EiuSjOakwU6zCCc7wzc3GqrC6y7q6bfraBdkrdGy
	 C283/ZTcIy0KBGH3tQ5QpOWqMDFeuVGWuEksNCtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502266AbfIWS06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:26:58 -0400
Received: from foss.arm.com ([217.140.110.172]:46768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502244AbfIWS05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:26:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B5BB16A3;
        Mon, 23 Sep 2019 11:26:57 -0700 (PDT)
Received: from big-swifty.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A12BA3F694;
        Mon, 23 Sep 2019 11:26:53 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Cc:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>
Subject: [PATCH 08/35] irqchip/gic-v3-its: Kill its->device_ids and use TYPER copy instead
Date:   Mon, 23 Sep 2019 19:25:39 +0100
Message-Id: <20190923182606.32100-9-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923182606.32100-1-maz@kernel.org>
References: <20190923182606.32100-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a copy of TYPER in the ITS structure, rely on this
to provide the same service as its->device_ids, which gets axed.
Errata workarounds are now updating the cached fields instead of
requiring a separate field in the ITS structure.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c   | 24 +++++++++++++-----------
 include/linux/irqchip/arm-gic-v3.h |  2 +-
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 94a0885a57b6..fbe7b0c14b9e 100644
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
 
@@ -1947,9 +1947,9 @@ static bool its_parse_indirect_baser(struct its_node *its,
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
@@ -1995,7 +1995,7 @@ static int its_alloc_tables(struct its_node *its)
 		case GITS_BASER_TYPE_DEVICE:
 			indirect = its_parse_indirect_baser(its, baser,
 							    psz, &order,
-							    its->device_ids);
+							    device_ids(its));
 			break;
 
 		case GITS_BASER_TYPE_VCPU:
@@ -2386,7 +2386,7 @@ static bool its_alloc_device_table(struct its_node *its, u32 dev_id)
 
 	/* Don't allow device id that exceeds ITS hardware limit */
 	if (!baser)
-		return (ilog2(dev_id) < its->device_ids);
+		return (ilog2(dev_id) < device_ids(its));
 
 	return its_alloc_table_entry(its, baser, dev_id);
 }
@@ -3237,8 +3237,9 @@ static bool __maybe_unused its_enable_quirk_cavium_22375(void *data)
 {
 	struct its_node *its = data;
 
-	/* erratum 22375: only alloc 8MB table size */
-	its->device_ids = 0x14;		/* 20 bits, 8MB */
+	/* erratum 22375: only alloc 8MB table size (20 bits) */
+	its->typer &= ~GITS_TYPER_DEVBITS;
+	its->typer |= FIELD_PREP(GITS_TYPER_DEVBITS, 20 - 1);
 	its->flags |= ITS_FLAGS_WORKAROUND_CAVIUM_22375;
 
 	return true;
@@ -3293,8 +3294,10 @@ static bool __maybe_unused its_enable_quirk_socionext_synquacer(void *data)
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
@@ -3527,7 +3530,7 @@ static int its_init_vpe_domain(void)
 	}
 
 	/* Use the last possible DevID */
-	devid = GENMASK(its->device_ids - 1, 0);
+	devid = GENMASK(device_ids(its) - 1, 0);
 	vpe_proxy.dev = its_create_device(its, devid, entries, false);
 	if (!vpe_proxy.dev) {
 		kfree(vpe_proxy.vpes);
@@ -3628,7 +3631,6 @@ static int __init its_probe_one(struct resource *res,
 	its->typer = typer;
 	its->base = its_base;
 	its->phys_base = res->start;
-	its->device_ids = GITS_TYPER_DEVBITS(typer);
 	if (is_v4(its)) {
 		if (!(typer & GITS_TYPER_VMOVP)) {
 			err = its_compute_its_list_map(res, its_base);
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index df8994f23a00..8c6be56da7e9 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -342,7 +342,7 @@
 #define GITS_TYPER_ITT_ENTRY_SIZE	GENMASK_ULL(7, 4)
 #define GITS_TYPER_IDBITS_SHIFT		8
 #define GITS_TYPER_DEVBITS_SHIFT	13
-#define GITS_TYPER_DEVBITS(r)		((((r) >> GITS_TYPER_DEVBITS_SHIFT) & 0x1f) + 1)
+#define GITS_TYPER_DEVBITS		GENMASK_ULL(17, 13)
 #define GITS_TYPER_PTA			(1UL << 19)
 #define GITS_TYPER_HCC_SHIFT		24
 #define GITS_TYPER_HCC(r)		(((r) >> GITS_TYPER_HCC_SHIFT) & 0xff)
-- 
2.20.1

