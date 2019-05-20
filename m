Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C9AC072A4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163F720856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oxc3vNYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbfETHbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 03:31:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44210 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730944AbfETHbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 03:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3CnF0iIDb7oqE4diwy/VUBuunHutTDVCxO3IZ+FSTTc=; b=oxc3vNYm3jKoNiPnZeFWIl+vj8
        FeUOi7OgFpImyVinf9UjUWTNftfoZu6aPmKXqdlYnNabml1T9cSvdpqRJShv5xzoaElqHEREOig6P
        i5wnC0QCNPymvEWPGeGTfyIe80vLEUBV2Sa8OICrZAgTh9qGJRcEpD/r5H4gHoDm68chfeXMS5pxA
        mcwMhu/p1ZKongiz0VmfKW5JOGP0t7mJmYJBTiiwK0e5HhQuYf9n9BXkAcR0aUShvM+SNS1TvivwL
        5CcPmChHzyM0O0TWw9es7z8OhHpAapa/KrSUXcFG88IPmPoJ9J22aiIJ9nEH98N/qI9wgCOnjLijk
        PNpFz0qw==;
Received: from 089144206147.atnat0015.highway.bob.at ([89.144.206.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSclI-0004HO-Ov; Mon, 20 May 2019 07:31:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Murphy <tmurphy@arista.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/24] iommu/dma: Remove __iommu_dma_free
Date:   Mon, 20 May 2019 09:29:35 +0200
Message-Id: <20190520072948.11412-12-hch@lst.de>
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

We only have a single caller of this function left, so open code it there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 0ffb7805de77..5e0c8450fa0b 100644
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

