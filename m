Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12C9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15412075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G9YopJwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbfC0IFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:05:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57612 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfC0IFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kg++s64sRofPDeejwO8nLYnNMA4wFK2g7Jlv72+0fyE=; b=G9YopJwORM96vgKkuXXMEfZtAl
        qIoCQlbINmcM2jCHGxSXzU78Xl9jnkEHjl6kUI2wws2ZmpAErDGJg7rrglhnnyGeWEAqEuJ8gnbbb
        Pxgt5XD3tbSQcu0PjW4fHqxJPyc7uHCt9M5RyX1VNdKcYGcE0LUN7ELxnRaV9ldTzDHX9aTS2DMyD
        kfMg2BTR+IVVHKO0QqCvPwTugJfVjWQjE2aMXyIybSWPWC3lstqiH2mjxeCcKnd3dIVaNXqouzh4P
        ZFJj3uW8ZCmWVQjTcMqTLuvqZOJvzMGtDV4WNw82LpvHWqJxUbFsnzVrSGLMrv7DD0YOZnbyz6YLB
        ItHQ48GA==;
Received: from 213-225-14-48.nat.highway.a1.net ([213.225.14.48] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h93Yf-0005vx-TP; Wed, 27 Mar 2019 08:05:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/21] arm64/iommu: improve mmap bounds checking
Date:   Wed, 27 Mar 2019 09:04:29 +0100
Message-Id: <20190327080448.5500-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327080448.5500-1-hch@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nr_pages checks should be done for all mmap requests, not just those
using remap_pfn_range.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/mm/dma-mapping.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index be88beb2e377..e54288921e72 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -73,19 +73,9 @@ static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
 static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
 			      unsigned long pfn, size_t size)
 {
-	int ret = -ENXIO;
-	unsigned long nr_vma_pages = vma_pages(vma);
-	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long off = vma->vm_pgoff;
-
-	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
-		ret = remap_pfn_range(vma, vma->vm_start,
-				      pfn + off,
-				      vma->vm_end - vma->vm_start,
-				      vma->vm_page_prot);
-	}
-
-	return ret;
+	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
+			      vma->vm_end - vma->vm_start,
+			      vma->vm_page_prot);
 }
 #endif /* CONFIG_IOMMU_DMA */
 
@@ -241,6 +231,8 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 			      void *cpu_addr, dma_addr_t dma_addr, size_t size,
 			      unsigned long attrs)
 {
+	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned long off = vma->vm_pgoff;
 	struct vm_struct *area;
 	int ret;
 
@@ -249,6 +241,9 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
 
+	if (off >= nr_pages || vma_pages(vma) > nr_pages - off)
+		return -ENXIO;
+
 	if (!is_vmalloc_addr(cpu_addr)) {
 		unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
 		return __swiotlb_mmap_pfn(vma, pfn, size);
-- 
2.20.1

