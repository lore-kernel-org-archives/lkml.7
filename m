Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5319CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA30214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572187503;
	bh=H3GAI5vLVjtZJ1aQlZsIHRQHBYBwQ2NuourT2ApKXvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n9fn7hInW1tCrswR/LBWtWLqwztMYTJI5KvBKJC/zhoGf2usesDCMEmgxcs8rdOcF
	 Hcogn4TMsE2dDEBCg11QDQxnxF8mIdTPA750PXpV9UQ2Sryd4JG2hF/ivw+TdmLdYP
	 7bGwf8ngYoZCj7KTkvkqIDiniz3oXDFos2Ixo3yg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfJ0OpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 10:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727216AbfJ0OpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 10:45:02 -0400
Received: from localhost.localdomain (82-132-239-15.dab.02.net [82.132.239.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A002621E6F;
        Sun, 27 Oct 2019 14:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572187501;
        bh=H3GAI5vLVjtZJ1aQlZsIHRQHBYBwQ2NuourT2ApKXvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=atHehoOBYndYpOWXv2VccG2C/Os7y7E0HQ2js6n4bCydxMuiTRvl+joyzst4XNgPO
         WOBdjfmmuve/nvXVXb3makrzdD49iQ2O2dZCks6o/C5DqGgMy/xKyKFaKdBhME3Smi
         xMtgQBV0MtSUulPn05Ev/ghPANxcb9NiyQahDmYA=
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
Subject: [PATCH v2 18/36] irqchip/gic-v4.1: Add VPE eviction callback
Date:   Sun, 27 Oct 2019 14:42:16 +0000
Message-Id: <20191027144234.8395-19-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191027144234.8395-1-maz@kernel.org>
References: <20191027144234.8395-1-maz@kernel.org>
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
index d45e9b4e5622..f7effd453729 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2487,7 +2487,7 @@ static int __init allocate_lpi_tables(void)
 	return 0;
 }
 
-static u64 its_clear_vpend_valid(void __iomem *vlpi_base)
+static u64 its_clear_vpend_valid(void __iomem *vlpi_base, u64 clr, u64 set)
 {
 	u32 count = 1000000;	/* 1s! */
 	bool clean;
@@ -2495,6 +2495,8 @@ static u64 its_clear_vpend_valid(void __iomem *vlpi_base)
 
 	val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
 	val &= ~GICR_VPENDBASER_Valid;
+	val &= ~clr;
+	val |= set;
 	gits_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
 
 	do {
@@ -2507,6 +2509,11 @@ static u64 its_clear_vpend_valid(void __iomem *vlpi_base)
 		}
 	} while (!clean && count);
 
+	if (unlikely(val & GICR_VPENDBASER_Dirty)) {
+		pr_err_ratelimited("ITS virtual pending table not cleaning\n");
+		val |= GICR_VPENDBASER_PendingLast;
+	}
+
 	return val;
 }
 
@@ -2615,7 +2622,7 @@ static void its_cpu_init_lpis(void)
 		 * ancient programming gets left in and has possibility of
 		 * corrupting memory.
 		 */
-		val = its_clear_vpend_valid(vlpi_base);
+		val = its_clear_vpend_valid(vlpi_base, 0, 0);
 		WARN_ON(val & GICR_VPENDBASER_Dirty);
 	}
 
@@ -3293,16 +3300,10 @@ static void its_vpe_deschedule(struct its_vpe *vpe)
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
@@ -3481,6 +3482,35 @@ static void its_vpe_4_1_schedule(struct its_vpe *vpe,
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
@@ -3492,6 +3522,7 @@ static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 		return 0;
 
 	case DESCHEDULE_VPE:
+		its_vpe_4_1_deschedule(vpe, info);
 		return 0;
 
 	case INVALL_VPE:
-- 
2.20.1

