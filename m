Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75610C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBAF20665
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569263268;
	bh=wr6DhAaaMiCf/7XSEI9I1LdfKCKq/oXMO2jSu9bZIkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yAxU6/gija1TZLYANWxJrzKcjp2HhOgZxrLNsCm81CMsLR22rxWh/FdET2rRw+kAf
	 aVHA7mHPls/izRMhhtgVa80yxS2cdquVFO1UDMHCZMFvVdsy3LpcdGQ4xVViDnG3tn
	 jv3zJ1KKA8N0Lwffp5OfX2O1ubmJsF5trPenr7jE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502383AbfIWS1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:27:47 -0400
Received: from foss.arm.com ([217.140.110.172]:47016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbfIWS1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:27:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBE261C01;
        Mon, 23 Sep 2019 11:27:44 -0700 (PDT)
Received: from big-swifty.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29A503F694;
        Mon, 23 Sep 2019 11:27:40 -0700 (PDT)
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
Subject: [PATCH 20/35] irqchip/gic-v4.1: Allow direct invalidation of VLPIs
Date:   Mon, 23 Sep 2019 19:25:51 +0100
Message-Id: <20190923182606.32100-21-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923182606.32100-1-maz@kernel.org>
References: <20190923182606.32100-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like for INVALL, GICv4.1 has grown a VPE-aware INVLPI register.
Let's plumb it in and make use of the DirectLPI code in that case.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c   | 19 +++++++++++++++++--
 include/linux/irqchip/arm-gic-v3.h |  1 +
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index b791c9beddf2..34595a7fcccb 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1200,13 +1200,27 @@ static void wait_for_syncr(void __iomem *rdbase)
 
 static void direct_lpi_inv(struct irq_data *d)
 {
+	struct its_vlpi_map *map = get_vlpi_map(d);
 	struct its_collection *col;
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
 	col = irq_to_col(d);
 	rdbase = per_cpu_ptr(gic_rdists->rdist, col->col_id)->rd_base;
-	gic_write_lpir(d->hwirq, rdbase + GICR_INVLPIR);
+	gic_write_lpir(val, rdbase + GICR_INVLPIR);
 
 	wait_for_syncr(rdbase);
 }
@@ -1216,7 +1230,8 @@ static void lpi_update_config(struct irq_data *d, u8 clr, u8 set)
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 
 	lpi_write_config(d, clr, set);
-	if (gic_rdists->has_direct_lpi && !irqd_is_forwarded_to_vcpu(d))
+	if (gic_rdists->has_direct_lpi &&
+	    (is_v4_1(its_dev->its) || !irqd_is_forwarded_to_vcpu(d)))
 		direct_lpi_inv(d);
 	else
 		its_send_inv(its_dev, its_get_event_id(d));
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index b69f60792554..5f3278cbf247 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -247,6 +247,7 @@
 #define GICR_TYPER_COMMON_LPI_AFF	GENMASK_ULL(25, 24)
 #define GICR_TYPER_AFFINITY		GENMASK_ULL(63, 32)
 
+#define GICR_INVLPIR_INTID		GENMASK_ULL(31, 0)
 #define GICR_INVLPIR_VPEID		GENMASK_ULL(47, 32)
 #define GICR_INVLPIR_V			GENMASK_ULL(63, 63)
 
-- 
2.20.1

