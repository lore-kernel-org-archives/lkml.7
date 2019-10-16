Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B6BFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A5E2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394006AbfJPRHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 13:07:44 -0400
Received: from foss.arm.com ([217.140.110.172]:45988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393829AbfJPRHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 13:07:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C81928;
        Wed, 16 Oct 2019 10:07:43 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6A83F3F6C4;
        Wed, 16 Oct 2019 10:07:42 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org, maz@kernel.org,
        julien.grall@arm.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] iommu/dma: Relax locking in iommu_dma_prepare_msi()
Date:   Wed, 16 Oct 2019 18:07:36 +0100
Message-Id: <5af5e77102ca52576cb96816f0abcf6398820055.1571245656.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ece6e6f0218b ("iommu/dma-iommu: Split iommu_dma_map_msi_msg()
in two parts"), iommu_dma_prepare_msi() should no longer have to worry
about preempting itself, nor being called in atomic context at all. Thus
we can downgrade the IRQ-safe locking to a simple mutex to avoid angering
the new might_sleep() check in iommu_map().

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f321279baf9e..4ba3c49de017 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -19,6 +19,7 @@
 #include <linux/iova.h>
 #include <linux/irq.h>
 #include <linux/mm.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
@@ -43,7 +44,6 @@ struct iommu_dma_cookie {
 		dma_addr_t		msi_iova;
 	};
 	struct list_head		msi_page_list;
-	spinlock_t			msi_lock;
 
 	/* Domain for flush queue callback; NULL if flush queue not in use */
 	struct iommu_domain		*fq_domain;
@@ -62,7 +62,6 @@ static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type type)
 
 	cookie = kzalloc(sizeof(*cookie), GFP_KERNEL);
 	if (cookie) {
-		spin_lock_init(&cookie->msi_lock);
 		INIT_LIST_HEAD(&cookie->msi_page_list);
 		cookie->type = type;
 	}
@@ -1150,7 +1149,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 		if (msi_page->phys == msi_addr)
 			return msi_page;
 
-	msi_page = kzalloc(sizeof(*msi_page), GFP_ATOMIC);
+	msi_page = kzalloc(sizeof(*msi_page), GFP_KERNEL);
 	if (!msi_page)
 		return NULL;
 
@@ -1180,7 +1179,7 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct iommu_dma_cookie *cookie;
 	struct iommu_dma_msi_page *msi_page;
-	unsigned long flags;
+	static DEFINE_MUTEX(msi_prepare_lock);
 
 	if (!domain || !domain->iova_cookie) {
 		desc->iommu_cookie = NULL;
@@ -1190,13 +1189,12 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 	cookie = domain->iova_cookie;
 
 	/*
-	 * We disable IRQs to rule out a possible inversion against
-	 * irq_desc_lock if, say, someone tries to retarget the affinity
-	 * of an MSI from within an IPI handler.
+	 * In fact we should already be serialised by irq_domain_mutex
+	 * here, but that's way subtle, so belt and braces...
 	 */
-	spin_lock_irqsave(&cookie->msi_lock, flags);
+	mutex_lock(&msi_prepare_lock);
 	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
-	spin_unlock_irqrestore(&cookie->msi_lock, flags);
+	mutex_unlock(&msi_prepare_lock);
 
 	msi_desc_set_iommu_cookie(desc, msi_page);
 
-- 
2.21.0.dirty

