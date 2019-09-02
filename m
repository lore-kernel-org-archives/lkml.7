Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1348C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C2E2168B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R/7x+fHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfIBNEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:04:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37930 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730469AbfIBNEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ta9M2b2y7wj8yOyfpMAIMWmSlpU0UyW1ZNcRY8yDGCI=; b=R/7x+fHstCiuPGDtTHZn3ll3Vq
        Bje0x8mwce/f0sqmLfpKhlzht358B2ZCHH5NQIfoFuM4jMAzL8nXsLiMLhuXBa0imvQ1m2YnjijdP
        m4damP9kMDPrjWt5jsPBW9o/EL1AfD2NDjGpsag7XmbClPAsxIcv/QuF5Zryeen6r3c6KjjSP7qe0
        qv/l3JSmpx00SKgeMwjRNwlMp/NhSOLsl37N6vA4sslaJhHkNqFFFXNGxmxDHqiUPr8HKjrvv10Wh
        yusnBdKDI2O1aOBewMIYkw/jzkmP8HJQI6gU1gh+JtUdwrZdhzm23/WXdtwKfbDjrZnqdFeiFkesu
        poUiRbxA==;
Received: from [2001:4bb8:18c:1755:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i4m04-0001Ym-VB; Mon, 02 Sep 2019 13:04:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        gross@suse.com, boris.ostrovsky@oracle.com
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] swiotlb-xen: remove xen_swiotlb_dma_mmap and -xen_swiotlb_dma_get_sgtable
Date:   Mon,  2 Sep 2019 15:03:33 +0200
Message-Id: <20190902130339.23163-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902130339.23163-1-hch@lst.de>
References: <20190902130339.23163-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to wrap the common version, just wire them up directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 drivers/xen/swiotlb-xen.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index eee86cc7046b..b8808677ae1d 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -547,31 +547,6 @@ xen_swiotlb_dma_supported(struct device *hwdev, u64 mask)
 	return xen_virt_to_bus(xen_io_tlb_end - 1) <= mask;
 }
 
-/*
- * Create userspace mapping for the DMA-coherent memory.
- * This function should be called with the pages from the current domain only,
- * passing pages mapped from other domains would lead to memory corruption.
- */
-static int
-xen_swiotlb_dma_mmap(struct device *dev, struct vm_area_struct *vma,
-		     void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		     unsigned long attrs)
-{
-	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
-}
-
-/*
- * This function should be called with the pages from the current domain only,
- * passing pages mapped from other domains would lead to memory corruption.
- */
-static int
-xen_swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
-			void *cpu_addr, dma_addr_t handle, size_t size,
-			unsigned long attrs)
-{
-	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size, attrs);
-}
-
 const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.alloc = xen_swiotlb_alloc_coherent,
 	.free = xen_swiotlb_free_coherent,
@@ -584,6 +559,6 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.map_page = xen_swiotlb_map_page,
 	.unmap_page = xen_swiotlb_unmap_page,
 	.dma_supported = xen_swiotlb_dma_supported,
-	.mmap = xen_swiotlb_dma_mmap,
-	.get_sgtable = xen_swiotlb_get_sgtable,
+	.mmap = dma_common_mmap,
+	.get_sgtable = dma_common_get_sgtable,
 };
-- 
2.20.1

