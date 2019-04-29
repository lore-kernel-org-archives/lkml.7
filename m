Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9A2C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79A420656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfD2OpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:45:02 -0400
Received: from foss.arm.com ([217.140.101.70]:59058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728331AbfD2Oo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:44:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C73A01682;
        Mon, 29 Apr 2019 07:44:55 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 782303F5C1;
        Mon, 29 Apr 2019 07:44:53 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     logang@deltatee.com, douliyangs@gmail.com,
        miquel.raynal@bootlin.com, marc.zyngier@arm.com,
        jason@lakedaemon.net, tglx@linutronix.de, joro@8bytes.org,
        robin.murphy@arm.com, bigeasy@linutronix.de,
        linux-rt-users@vger.kernel.org, Julien Grall <julien.grall@arm.com>
Subject: [PATCH v2 7/7] iommu/dma-iommu: Remove iommu_dma_map_msi_msg()
Date:   Mon, 29 Apr 2019 15:44:28 +0100
Message-Id: <20190429144428.29254-8-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190429144428.29254-1-julien.grall@arm.com>
References: <20190429144428.29254-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent change split iommu_dma_map_msi_msg() in two new functions. The
function was still implemented to avoid modifying all the callers at
once.

Now that all the callers have been reworked, iommu_dma_map_msi_msg() can
be removed.

Signed-off-by: Julien Grall <julien.grall@arm.com>

---
    Changes in v2:
        - Rework the commit message
---
 drivers/iommu/dma-iommu.c | 20 --------------------
 include/linux/dma-iommu.h |  5 -----
 2 files changed, 25 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 2309f59cefa4..12f4464828a4 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -936,23 +936,3 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 	msg->address_lo &= cookie_msi_granule(domain->iova_cookie) - 1;
 	msg->address_lo += lower_32_bits(msi_page->iova);
 }
-
-void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
-{
-	struct msi_desc *desc = irq_get_msi_desc(irq);
-	phys_addr_t msi_addr = (u64)msg->address_hi << 32 | msg->address_lo;
-
-	if (WARN_ON(iommu_dma_prepare_msi(desc, msi_addr))) {
-		/*
-		 * We're called from a void callback, so the best we can do is
-		 * 'fail' by filling the message with obviously bogus values.
-		 * Since we got this far due to an IOMMU being present, it's
-		 * not like the existing address would have worked anyway...
-		 */
-		msg->address_hi = ~0U;
-		msg->address_lo = ~0U;
-		msg->data = ~0U;
-	} else {
-		iommu_dma_compose_msi_msg(desc, msg);
-	}
-}
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 3fc48fbd6f63..ddd217c197df 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -82,7 +82,6 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
 void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 			       struct msi_msg *msg);
 
-void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
 #else
@@ -122,10 +121,6 @@ static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc,
 {
 }
 
-static inline void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
-{
-}
-
 static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
 }
-- 
2.11.0

