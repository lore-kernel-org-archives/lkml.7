Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404B7C3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1567621D7D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003095;
	bh=5X4e9gDqzVaDUVUQN7W0flU942iFDH3f0nbHsKP9i5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yctkIhUVUsH84Od/tswVjtWSKgFnKdl5es+m0q/h1n1ehoBV/NlG42PDlbVefA+No
	 tFYbvhAklfmrmG0nZ/++RMHNTxbO9vOLMCiz0GMei4CEwvq+bx4s3LJsgDdhmHZUMg
	 C0o/g5P2mPaQA/0o6KNZ1PJEoC1+Hqz8jQsHQoYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgABWLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:11:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:49678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbgABWLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:11:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AA2422314;
        Thu,  2 Jan 2020 22:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003090;
        bh=5X4e9gDqzVaDUVUQN7W0flU942iFDH3f0nbHsKP9i5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y+I6xLy8AuOKnzrL7ifjl2DZlRSL1t0bKrtwcxPxUQIcYkKSO9pWZ0eg/gR/o1rwq
         siWLo/ayEdBXfxGJCu+UI5mv3TINufBKQmqDAU2XwV6xXqy0esO1Q0MTwl/OYGlwDo
         rIA8D0d+VNjmsV5eRN3/E+VvsfxODLWC2VhzxXmE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 016/191] iommu/tegra-smmu: Fix page tables in > 4 GiB memory
Date:   Thu,  2 Jan 2020 23:04:58 +0100
Message-Id: <20200102215831.515906646@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit 96d3ab802e4930a29a33934373157d6dff1b2c7e ]

Page tables that reside in physical memory beyond the 4 GiB boundary are
currently not working properly. The reason is that when the physical
address for page directory entries is read, it gets truncated at 32 bits
and can cause crashes when passing that address to the DMA API.

Fix this by first casting the PDE value to a dma_addr_t and then using
the page frame number mask for the SMMU instance to mask out the invalid
bits, which are typically used for mapping attributes, etc.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/tegra-smmu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 7293fc3f796d..dd486233e282 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -159,9 +159,9 @@ static bool smmu_dma_addr_valid(struct tegra_smmu *smmu, dma_addr_t addr)
 	return (addr & smmu->pfn_mask) == addr;
 }
 
-static dma_addr_t smmu_pde_to_dma(u32 pde)
+static dma_addr_t smmu_pde_to_dma(struct tegra_smmu *smmu, u32 pde)
 {
-	return pde << 12;
+	return (dma_addr_t)(pde & smmu->pfn_mask) << 12;
 }
 
 static void smmu_flush_ptc_all(struct tegra_smmu *smmu)
@@ -549,6 +549,7 @@ static u32 *tegra_smmu_pte_lookup(struct tegra_smmu_as *as, unsigned long iova,
 				  dma_addr_t *dmap)
 {
 	unsigned int pd_index = iova_pd_index(iova);
+	struct tegra_smmu *smmu = as->smmu;
 	struct page *pt_page;
 	u32 *pd;
 
@@ -557,7 +558,7 @@ static u32 *tegra_smmu_pte_lookup(struct tegra_smmu_as *as, unsigned long iova,
 		return NULL;
 
 	pd = page_address(as->pd);
-	*dmap = smmu_pde_to_dma(pd[pd_index]);
+	*dmap = smmu_pde_to_dma(smmu, pd[pd_index]);
 
 	return tegra_smmu_pte_offset(pt_page, iova);
 }
@@ -599,7 +600,7 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 	} else {
 		u32 *pd = page_address(as->pd);
 
-		*dmap = smmu_pde_to_dma(pd[pde]);
+		*dmap = smmu_pde_to_dma(smmu, pd[pde]);
 	}
 
 	return tegra_smmu_pte_offset(as->pts[pde], iova);
@@ -624,7 +625,7 @@ static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
 	if (--as->count[pde] == 0) {
 		struct tegra_smmu *smmu = as->smmu;
 		u32 *pd = page_address(as->pd);
-		dma_addr_t pte_dma = smmu_pde_to_dma(pd[pde]);
+		dma_addr_t pte_dma = smmu_pde_to_dma(smmu, pd[pde]);
 
 		tegra_smmu_set_pde(as, iova, 0);
 
-- 
2.20.1



