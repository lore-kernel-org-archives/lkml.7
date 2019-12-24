Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF15C2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD23320722
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577187643;
	bh=vopwOvtgaQN6+4VDwS92oPmIzt3+qNdzTKNQnQ5Pxa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QmKWhDIA18NIg9Ubb1aulTKPGQrWMgHA0dD2lQR19iBEYhfSEbuyoRPVATxRa0UOi
	 u+mkfOlC5tZybuZpZ8JN94R7+V4IlBDuq7gfbjPPe3Zd27vfUdXYEhjRN+Qmr/CYtz
	 Jb/E1OwjdQ9ESxHDxANqs4OIBczLkWj1P842k33Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLXLkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:40:36 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:34136 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbfLXLkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 06:40:35 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iji5z-000169-E5; Tue, 24 Dec 2019 12:11:23 +0100
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
Subject: [PATCH v3 15/32] irqchip/gic-v4.1: Allow direct invalidation of VLPIs
Date:   Tue, 24 Dec 2019 11:10:38 +0000
Message-Id: <20191224111055.11836-16-maz@kernel.org>
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

Just like for INVALL, GICv4.1 has grown a VPE-aware INVLPI register.
Let's plumb it in and make use of the DirectLPI code in that case.

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c   | 53 ++++++++++++++++++++----------
 include/linux/irqchip/arm-gic-v3.h |  1 +
 2 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index f00c8ddd3798..360ca2c1533f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -228,11 +228,26 @@ static struct its_vlpi_map *dev_event_to_vlpi_map(struct its_device *its_dev,
 	return &its_dev->event_map.vlpi_maps[event];
 }
 
-static struct its_collection *irq_to_col(struct irq_data *d)
+static struct its_vlpi_map *get_vlpi_map(struct irq_data *d)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+	u32 event = its_get_event_id(d);
+
+	if (!irqd_is_forwarded_to_vcpu(d))
+		return NULL;
 
-	return dev_event_to_col(its_dev, its_get_event_id(d));
+	return dev_event_to_vlpi_map(its_dev, event);
+}
+
+static int irq_to_cpuid(struct irq_data *d)
+{
+	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+	struct its_vlpi_map *map = get_vlpi_map(d);
+
+	if (map)
+		return map->vpe->col_idx;
+
+	return its_dev->event_map.col_map[its_get_event_id(d)];
 }
 
 static struct its_collection *valid_col(struct its_collection *col)
@@ -1270,17 +1285,6 @@ static void its_send_invdb(struct its_node *its, struct its_vpe *vpe)
 /*
  * irqchip functions - assumes MSI, mostly.
  */
-static struct its_vlpi_map *get_vlpi_map(struct irq_data *d)
-{
-	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
-	u32 event = its_get_event_id(d);
-
-	if (!irqd_is_forwarded_to_vcpu(d))
-		return NULL;
-
-	return dev_event_to_vlpi_map(its_dev, event);
-}
-
 static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
 {
 	struct its_vlpi_map *map = get_vlpi_map(d);
@@ -1323,13 +1327,25 @@ static void wait_for_syncr(void __iomem *rdbase)
 
 static void direct_lpi_inv(struct irq_data *d)
 {
-	struct its_collection *col;
+	struct its_vlpi_map *map = get_vlpi_map(d);
 	void __iomem *rdbase;
+	u64 val;
+
+	if (map) {
+		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+
+		WARN_ON(!is_v4_1(its_dev->its));
+
+		val  = GICR_INVLPIR_V;
+		val |= FIELD_PREP(GICR_INVLPIR_VPEID, map->vpe->vpe_id);
+		val |= FIELD_PREP(GICR_INVLPIR_INTID, map->vintid);
+	} else {
+		val = d->hwirq;
+	}
 
 	/* Target the redistributor this LPI is currently routed to */
-	col = irq_to_col(d);
-	rdbase = per_cpu_ptr(gic_rdists->rdist, col->col_id)->rd_base;
-	gic_write_lpir(d->hwirq, rdbase + GICR_INVLPIR);
+	rdbase = per_cpu_ptr(gic_rdists->rdist, irq_to_cpuid(d))->rd_base;
+	gic_write_lpir(val, rdbase + GICR_INVLPIR);
 
 	wait_for_syncr(rdbase);
 }
@@ -1339,7 +1355,8 @@ static void lpi_update_config(struct irq_data *d, u8 clr, u8 set)
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 
 	lpi_write_config(d, clr, set);
-	if (gic_rdists->has_direct_lpi && !irqd_is_forwarded_to_vcpu(d))
+	if (gic_rdists->has_direct_lpi &&
+	    (is_v4_1(its_dev->its) || !irqd_is_forwarded_to_vcpu(d)))
 		direct_lpi_inv(d);
 	else if (!irqd_is_forwarded_to_vcpu(d))
 		its_send_inv(its_dev, its_get_event_id(d));
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 37b14fb82773..a30ea5294784 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -249,6 +249,7 @@
 #define GICR_TYPER_COMMON_LPI_AFF	GENMASK_ULL(25, 24)
 #define GICR_TYPER_AFFINITY		GENMASK_ULL(63, 32)
 
+#define GICR_INVLPIR_INTID		GENMASK_ULL(31, 0)
 #define GICR_INVLPIR_VPEID		GENMASK_ULL(47, 32)
 #define GICR_INVLPIR_V			GENMASK_ULL(63, 63)
 
-- 
2.20.1

