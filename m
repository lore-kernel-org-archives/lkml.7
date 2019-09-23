Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEE0C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCFA21783
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569263253;
	bh=/NcGqlE0MObhs9KQwQ8gF62K7V/MAKOdVlsDFvkAlGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H/iGok47vPkLNRr3pIg4rozOnleKKt2aTUqKjRSf0LYGFa2mACliLppU4Oc3M9s5F
	 2fK4KIOZjJJ4vU2C3MeRNAdEB3JqVGDUWtTqJfhSfazyjM0PQjjp8+j4jrre3g/n2/
	 wqCDKubdnFfCUest9aLKSGgWFo3k0x5uw9SyivR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502364AbfIWS1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:27:32 -0400
Received: from foss.arm.com ([217.140.110.172]:46944 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbfIWS1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:27:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80EDD1BA8;
        Mon, 23 Sep 2019 11:27:30 -0700 (PDT)
Received: from big-swifty.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20C9B3F694;
        Mon, 23 Sep 2019 11:27:26 -0700 (PDT)
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
Subject: [PATCH 17/35] irqchip/gic-v4.1: Add VPE eviction callback
Date:   Mon, 23 Sep 2019 19:25:48 +0100
Message-Id: <20190923182606.32100-18-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923182606.32100-1-maz@kernel.org>
References: <20190923182606.32100-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When descheduling a VPE, special care must be taken to tell the GIC
about whether we want to receive a doorbell or not. This is a
major improvement on GICv4.0, where the doorbell had to be separately
enabled/disabled.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 53 +++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 72d80daa7230..3079ce74def6 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2483,7 +2483,7 @@ static int __init allocate_lpi_tables(void)
 	return 0;
 }
 
-static u64 its_clear_vpend_valid(void __iomem *vlpi_base)
+static u64 its_clear_vpend_valid(void __iomem *vlpi_base, u64 clr, u64 set)
 {
 	u32 count = 1000000;	/* 1s! */
 	bool clean;
@@ -2491,6 +2491,8 @@ static u64 its_clear_vpend_valid(void __iomem *vlpi_base)
 
 	val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
 	val &= ~GICR_VPENDBASER_Valid;
+	val &= ~clr;
+	val |= set;
 	gits_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
 
 	do {
@@ -2503,6 +2505,11 @@ static u64 its_clear_vpend_valid(void __iomem *vlpi_base)
 		}
 	} while (!clean && count);
 
+	if (unlikely(val & GICR_VPENDBASER_Dirty)) {
+		pr_err_ratelimited("ITS virtual pending table not cleaning\n");
+		val |= GICR_VPENDBASER_PendingLast;
+	}
+
 	return val;
 }
 
@@ -2611,7 +2618,7 @@ static void its_cpu_init_lpis(void)
 		 * ancient programming gets left in and has possibility of
 		 * corrupting memory.
 		 */
-		val = its_clear_vpend_valid(vlpi_base);
+		val = its_clear_vpend_valid(vlpi_base, 0, 0);
 		WARN_ON(val & GICR_VPENDBASER_Dirty);
 	}
 
@@ -3289,16 +3296,10 @@ static void its_vpe_deschedule(struct its_vpe *vpe)
 	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
 	u64 val;
 
-	val = its_clear_vpend_valid(vlpi_base);
+	val = its_clear_vpend_valid(vlpi_base, 0, 0);
 
-	if (unlikely(val & GICR_VPENDBASER_Dirty)) {
-		pr_err_ratelimited("ITS virtual pending table not cleaning\n");
-		vpe->idai = false;
-		vpe->pending_last = true;
-	} else {
-		vpe->idai = !!(val & GICR_VPENDBASER_IDAI);
-		vpe->pending_last = !!(val & GICR_VPENDBASER_PendingLast);
-	}
+	vpe->idai = !!(val & GICR_VPENDBASER_IDAI);
+	vpe->pending_last = !!(val & GICR_VPENDBASER_PendingLast);
 }
 
 static void its_vpe_invall(struct its_vpe *vpe)
@@ -3476,6 +3477,35 @@ static void its_vpe_4_1_schedule(struct its_vpe *vpe,
 	gits_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
 }
 
+static void its_vpe_4_1_deschedule(struct its_vpe *vpe,
+				   struct its_cmd_info *info)
+{
+	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
+	u64 val;
+
+	if (info->req_db) {
+		/*
+		 * vPE is going to block: make the vPE non-resident with
+		 * PendingLast clear and DB set. The GIC guarantees that if
+		 * we read-back PendingLast clear, then a doorbell will be
+		 * delivered when an interrupt comes.
+		 */
+		val = its_clear_vpend_valid(vlpi_base,
+					    GICR_VPENDBASER_PendingLast,
+					    GICR_VPENDBASER_4_1_DB);
+		vpe->pending_last = !!(val & GICR_VPENDBASER_PendingLast);
+	} else {
+		/*
+		 * We're not blocking, so just make the vPE non-resident
+		 * with PendingLast set, indicating that we'll be back.
+		 */
+		val = its_clear_vpend_valid(vlpi_base,
+					    0,
+					    GICR_VPENDBASER_PendingLast);
+		vpe->pending_last = true;
+	}
+}
+
 static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 {
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
@@ -3487,6 +3517,7 @@ static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 		return 0;
 
 	case DESCHEDULE_VPE:
+		its_vpe_4_1_deschedule(vpe, info);
 		return 0;
 
 	case INVALL_VPE:
-- 
2.20.1

