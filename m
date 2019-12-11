Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AB3C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBDE22527
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbfLKSdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:33:33 -0500
Received: from foss.arm.com ([217.140.110.172]:42776 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729955AbfLKSdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:33:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC9AC31B;
        Wed, 11 Dec 2019 10:33:31 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9F41E3F6CF;
        Wed, 11 Dec 2019 10:33:30 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, hch@lst.de
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        stephan@gerhold.net, natechancellor@gmail.com,
        nsaenzjulienne@suse.de, arnd@arndb.de
Subject: [PATCH v2] iommu/dma: Rationalise types for DMA masks
Date:   Wed, 11 Dec 2019 18:33:26 +0000
Message-Id: <00d1ddf9439a8c79fb561b0fc740bddf9e6fe6b1.1576089015.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.23.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since iommu_dma_alloc_iova() combines incoming masks with the u64 bus
limit, it makes more sense to pass them around in their native u64
rather than converting to dma_addr_t early. Do that, and resolve the
remaining type discrepancy against the domain geometry with a cheeky
cast to keep things simple.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Reworked from "iommu/dma: Use a better type for dma_limit"

 drivers/iommu/dma-iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 0cc702a70a96..6e573d1cb8bf 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -399,7 +399,7 @@ static int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
 }
 
 static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
-		size_t size, dma_addr_t dma_limit, struct device *dev)
+		size_t size, u64 dma_limit, struct device *dev)
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
@@ -424,7 +424,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 	dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
 
 	if (domain->geometry.force_aperture)
-		dma_limit = min(dma_limit, domain->geometry.aperture_end);
+		dma_limit = min(dma_limit, (u64)domain->geometry.aperture_end);
 
 	/* Try to get PCI devices a SAC address */
 	if (dma_limit > DMA_BIT_MASK(32) && dev_is_pci(dev))
@@ -477,7 +477,7 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-		size_t size, int prot, dma_addr_t dma_mask)
+		size_t size, int prot, u64 dma_mask)
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
-- 
2.23.0.dirty

