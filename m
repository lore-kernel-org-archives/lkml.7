Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E16C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE012133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vho9mWPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbfEWHBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:01:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36492 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730049AbfEWHBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Rp40+LdNRp98UqXMvQypPDjb/jX042Nj39KT14C9XFY=; b=Vho9mWPQ28aGFIQOWYzSHau5p1
        Sh+x/LcNT6W32+4J8F0Vb2HohbsmBHBG7tWarXkBdWfXfW4i7lrmiH7TGy9oQJF01MJk+XLwLW7If
        jhajQFufStFkaEEL1jP5oo+4l4IY58FRnKwrKf4U+bdITszTAK7a3FOCuIu1LZA4dZbVeCmA1sAY5
        GvReEpeciqeqDfM//8+OpoemTmIPnds/sHxZ2bB0M5t0CMRmvDM0VmkdiONccEYK9K5yijopjzBnO
        04vrSeijcAOIvxt/jtRBreT8JK0Bjak3aqGcsdypu0p+8Q1gi7szgr2yVNTxnjpLhf5WcAra4WRxA
        WbLUC1kQ==;
Received: from 213-225-10-46.nat.highway.a1.net ([213.225.10.46] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hThil-0005G0-Qw; Thu, 23 May 2019 07:01:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Tom Murphy <tmurphy@arista.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/23] iommu/dma: Remove __iommu_dma_free
Date:   Thu, 23 May 2019 09:00:15 +0200
Message-Id: <20190523070028.7435-11-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523070028.7435-1-hch@lst.de>
References: <20190523070028.7435-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only have a single caller of this function left, so open code it there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 0ccc25fd5c86..191c0a4c8e31 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -563,24 +563,6 @@ static struct page **__iommu_dma_get_pages(void *cpu_addr)
 	return area->pages;
 }
 
-/**
- * iommu_dma_free - Free a buffer allocated by iommu_dma_alloc_remap()
- * @dev: Device which owns this buffer
- * @pages: Array of buffer pages as returned by __iommu_dma_alloc_remap()
- * @size: Size of buffer in bytes
- * @handle: DMA address of buffer
- *
- * Frees both the pages associated with the buffer, and the array
- * describing them
- */
-static void __iommu_dma_free(struct device *dev, struct page **pages,
-		size_t size, dma_addr_t *handle)
-{
-	__iommu_dma_unmap(dev, *handle, size);
-	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
-	*handle = DMA_MAPPING_ERROR;
-}
-
 /**
  * iommu_dma_alloc_remap - Allocate and map a buffer contiguous in IOVA space
  * @dev: Device to allocate memory for. Must be a real device
@@ -1053,7 +1035,8 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 
 		if (!pages)
 			return;
-		__iommu_dma_free(dev, pages, iosize, &handle);
+		__iommu_dma_unmap(dev, handle, iosize);
+		__iommu_dma_free_pages(pages, size >> PAGE_SHIFT);
 		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
 	} else {
 		__iommu_dma_unmap(dev, handle, iosize);
-- 
2.20.1

