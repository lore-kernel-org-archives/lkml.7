Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117A3C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4F720656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DFhNdYi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbfETHbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 03:31:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45688 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730458AbfETHbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 03:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XDEf4tvtC15nXRmNowH8SE/L4xMl+bd3jBNDiCdF9Jw=; b=DFhNdYi1wo5zdVrcg3q8PugGxZ
        9ZKVQUITYEqU0tlKCrFEnm+jRX4CU8vmdrJYpmsvSp/HsDS4f5JC3WB+HZuq9sOUMyTA5SvJWswdX
        GK7pJLdOnwEB1FWMpJcBXOiSlcbDbazy7HUvUXRrarHKs/shkFvddTGvxo1mQ5yHKBvcmklKeU6kP
        pL3W8MbVPwTtQN8f90tN+uCjiS4PRAU8SjAltkGxbWqJaN2y1G/PYBJrKU+/7BitWkA0F6wAmC7vi
        w7SlELe7qxzxA7Hky4zeY6+MZhb21xU1xwgkhsTmrC3HW3JxoPp/gsMBSkVAtKc//Jy2BH/RZH33b
        ADN+ZVMw==;
Received: from 089144206147.atnat0015.highway.bob.at ([89.144.206.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSclQ-0004Pr-Bh; Mon, 20 May 2019 07:31:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Murphy <tmurphy@arista.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/24] iommu/dma: Don't remap CMA unnecessarily
Date:   Mon, 20 May 2019 09:29:38 +0200
Message-Id: <20190520072948.11412-15-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520072948.11412-1-hch@lst.de>
References: <20190520072948.11412-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

Always remapping CMA allocations was largely a bodge to keep the freeing
logic manageable when it was split between here and an arch wrapper. Now
that it's all together and streamlined, we can relax that limitation.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4134f13b5529..cffd30810d41 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -973,7 +973,6 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 {
 	bool coherent = dev_is_dma_coherent(dev);
 	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
-	pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
 	size_t iosize = size;
 	struct page *page;
 	void *addr;
@@ -1021,13 +1020,19 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	if (*handle == DMA_MAPPING_ERROR)
 		goto out_free_pages;
 
-	addr = dma_common_contiguous_remap(page, size, VM_USERMAP, prot,
-			__builtin_return_address(0));
-	if (!addr)
-		goto out_unmap;
+	if (!coherent || PageHighMem(page)) {
+		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
 
-	if (!coherent)
-		arch_dma_prep_coherent(page, iosize);
+		addr = dma_common_contiguous_remap(page, size, VM_USERMAP, prot,
+				__builtin_return_address(0));
+		if (!addr)
+			goto out_unmap;
+
+		if (!coherent)
+			arch_dma_prep_coherent(page, iosize);
+	} else {
+		addr = page_address(page);
+	}
 	memset(addr, 0, size);
 	return addr;
 out_unmap:
-- 
2.20.1

