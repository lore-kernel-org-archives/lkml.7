Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1887C47409
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E51206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577187674;
	bh=6zK4UAv/vYfcn3bU4JaqOJ/7pjxB7S6f67TV3oAxIwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UBC4H0l+o4xAEuYPmItCEbgRN7SvN9QgZv4/PWpjHNAqUfnCrsEB1zAziFpCfo2Za
	 GmZth1yk6PbMnOFDrcH83Q6wFEsqxAh2GkqjDJmuvPaUh1t+AjrAdI+MpdtBQrZ0GM
	 WoImytntKV6eFwc2xxo6aOBx04RfHMBvL1kHKDEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfLXLlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:41:13 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:40775 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726184AbfLXLlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 06:41:11 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iji5v-000169-JX; Tue, 24 Dec 2019 12:11:20 +0100
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
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v3 12/32] irqchip/gic-v4.1: Add VPE eviction callback
Date:   Tue, 24 Dec 2019 11:10:35 +0000
Message-Id: <20191224111055.11836-13-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224111055.11836-1-maz@kernel.org>
References: <20191224111055.11836-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, eric.auger@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, Andrew.Murray@arm.com, yuzenghui@huawei.com, rrichter@marvell.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When descheduling a VPE, special care must be taken to tell the GIC
about whether we want to receive a doorbell or not. This is a
major improvement on GICv4.0, where the doorbell had to be separately
enabled/disabled.

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 53 +++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 49850297fe56..a5567d099a3e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2631,7 +2631,7 @@ static int __init allocate_lpi_tables(void)
 	return 0;
 }
 
-static u64 its_clear_vpend_valid(void __iomem *vlpi_base)
+static u64 its_clear_vpend_valid(void __iomem *vlpi_base, u64 clr, u64 set)
 {
 	u32 count = 1000000;	/* 1s! */
 	bool clean;
@@ -2639,6 +2639,8 @@ static u64 its_clear_vpend_valid(void __iomem *vlpi_base)
 
 	val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
 	val &= ~GICR_VPENDBASER_Valid;
+	val &= ~clr;
+	val |= set;
 	gits_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
 
 	do {
@@ -2651,6 +2653,11 @@ static u64 its_clear_vpend_valid(void __iomem *vlpi_base)
 		}
 	} while (!clean && count);
 
+	if (unlikely(val & GICR_VPENDBASER_Dirty)) {
+		pr_err_ratelimited("ITS virtual pending table not cleaning\n");
+		val |= GICR_VPENDBASER_PendingLast;
+	}
+
 	return val;
 }
 
@@ -2759,7 +2766,7 @@ static void its_cpu_init_lpis(void)
 		 * ancient programming gets left in and has possibility of
 		 * corrupting memory.
 		 */
-		val = its_clear_vpend_valid(vlpi_base);
+		val = its_clear_vpend_valid(vlpi_base, 0, 0);
 		WARN_ON(val & GICR_VPENDBASER_Dirty);
 	}
 
@@ -3439,16 +3446,10 @@ static void its_vpe_deschedule(struct its_vpe *vpe)
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
@@ -3640,6 +3641,35 @@ static void its_vpe_4_1_schedule(struct its_vpe *vpe,
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
@@ -3651,6 +3681,7 @@ static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 		return 0;
 
 	case DESCHEDULE_VPE:
+		its_vpe_4_1_deschedule(vpe, info);
 		return 0;
 
 	case INVALL_VPE:
-- 
2.20.1

