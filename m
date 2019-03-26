Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DFEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA1020856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbfCZILv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:11:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34030 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726175AbfCZILv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:11:51 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 150CFEDFC18E5EBC1B34;
        Tue, 26 Mar 2019 16:11:49 +0800 (CST)
Received: from euler.huawei.com (10.175.104.193) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.408.0; Tue, 26 Mar 2019 16:11:38 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <julien.thierry@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>,
        <huawei.libin@huawei.com>
Subject: [PATCH] arm64: gic-v3: fix unexpected overwrite of spi/ppi/sgi prio
Date:   Tue, 26 Mar 2019 16:16:58 +0800
Message-ID: <20190326081658.37450-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.193]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The priority config will be restored to the default value in the
notifiers of gic suspend. While the arm64 nmi-like interrupt has been
implemented by using priority since commit bc3c03ccb464 ("arm64: Enable
the support of pseudo-NMIs"), we need to do the save and restore exactly.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 drivers/irqchip/irq-gic.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index fd3110c171ba..5928c4338b28 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -79,10 +79,12 @@ struct gic_chip_data {
 	u32 saved_spi_enable[DIV_ROUND_UP(1020, 32)];
 	u32 saved_spi_active[DIV_ROUND_UP(1020, 32)];
 	u32 saved_spi_conf[DIV_ROUND_UP(1020, 16)];
+	u32 saved_spi_prio[DIV_ROUND_UP(1020, 4)];
 	u32 saved_spi_target[DIV_ROUND_UP(1020, 4)];
 	u32 __percpu *saved_ppi_enable;
 	u32 __percpu *saved_ppi_active;
 	u32 __percpu *saved_ppi_conf;
+	u32 __percpu *saved_ppi_prio;
 #endif
 	struct irq_domain *domain;
 	unsigned int gic_irqs;
@@ -599,6 +601,10 @@ void gic_dist_save(struct gic_chip_data *gic)
 	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 32); i++)
 		gic->saved_spi_active[i] =
 			readl_relaxed(dist_base + GIC_DIST_ACTIVE_SET + i * 4);
+
+	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 4); i++)
+		gic->saved_spi_prio[i] =
+			readl_relaxed(dist_base + GIC_DIST_PRI + i * 4);
 }
 
 /*
@@ -630,7 +636,7 @@ void gic_dist_restore(struct gic_chip_data *gic)
 			dist_base + GIC_DIST_CONFIG + i * 4);
 
 	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 4); i++)
-		writel_relaxed(GICD_INT_DEF_PRI_X4,
+		writel_relaxed(gic->saved_spi_prio[i],
 			dist_base + GIC_DIST_PRI + i * 4);
 
 	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 4); i++)
@@ -682,6 +688,9 @@ void gic_cpu_save(struct gic_chip_data *gic)
 	for (i = 0; i < DIV_ROUND_UP(32, 16); i++)
 		ptr[i] = readl_relaxed(dist_base + GIC_DIST_CONFIG + i * 4);
 
+	ptr = raw_cpu_ptr(gic->saved_ppi_prio);
+	for (i = 0; i < DIV_ROUND_UP(32, 4); i++)
+		ptr[i] = readl_relaxed(dist_base + GIC_DIST_PRI + i * 4);
 }
 
 void gic_cpu_restore(struct gic_chip_data *gic)
@@ -718,9 +727,9 @@ void gic_cpu_restore(struct gic_chip_data *gic)
 	for (i = 0; i < DIV_ROUND_UP(32, 16); i++)
 		writel_relaxed(ptr[i], dist_base + GIC_DIST_CONFIG + i * 4);
 
+	ptr = raw_cpu_ptr(gic->saved_ppi_prio);
 	for (i = 0; i < DIV_ROUND_UP(32, 4); i++)
-		writel_relaxed(GICD_INT_DEF_PRI_X4,
-					dist_base + GIC_DIST_PRI + i * 4);
+		writel_relaxed(ptr[i], dist_base + GIC_DIST_PRI + i * 4);
 
 	writel_relaxed(GICC_INT_PRI_THRESHOLD, cpu_base + GIC_CPU_PRIMASK);
 	gic_cpu_if_up(gic);
@@ -778,11 +787,18 @@ static int gic_pm_init(struct gic_chip_data *gic)
 	if (WARN_ON(!gic->saved_ppi_conf))
 		goto free_ppi_active;
 
+	gic->saved_ppi_prio = __alloc_percpu(DIV_ROUND_UP(32, 4) * 4,
+		sizeof(u32));
+	if (WARN_ON(!gic->saved_ppi_prio))
+		goto free_ppi_prio;
+
 	if (gic == &gic_data[0])
 		cpu_pm_register_notifier(&gic_notifier_block);
 
 	return 0;
 
+free_ppi_prio:
+	free_percpu(gic->saved_ppi_conf);
 free_ppi_active:
 	free_percpu(gic->saved_ppi_active);
 free_ppi_enable:
-- 
2.17.1

