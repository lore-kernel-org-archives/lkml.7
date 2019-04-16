Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81430C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527AE20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aIzQcayc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbfDPSYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:24:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44874 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730313AbfDPSYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2j2HmFu8YmlQ0j4tsE2YIlfCRZXsMKP+5+Qui/H8wf0=; b=aIzQcaycSdB4P41HEWXW0jySX8
        MW29cM6HikgZAY4efC9kRBKpihdltXmP43PFgnv2QTdWrRpOwPkCorROX92GSXdfhshHxOgPETxzC
        MBDdetQh1JpLGEhDqvRiZPvB2ny9QTHhw4URO1skmWJbFLLm9LhnDLFKFFOvczK9vwtx2vYz7gvVx
        ly9Hmn2yyM1T8w4iGYKXLslWuZbT/FDuQ460Z8RcG2X1VPz9Vp6tFrWhCGp4iYquEr6sN2ZSXygh4
        MmHnrCSU8AH5SMUEdBKsa9G+JtwX6whLWylPc4/gjwqkgKqk3TylULyBAo1AvtAWPcqDwh0wQzfRZ
        EFkfxFMg==;
Received: from 213-225-15-255.nat.highway.a1.net ([213.225.15.255] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGSky-00078h-5K; Tue, 16 Apr 2019 18:24:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] sparc/iommu: fix __sbus_iommu_map_page for highmem pages
Date:   Tue, 16 Apr 2019 20:23:45 +0200
Message-Id: <20190416182347.18441-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416182347.18441-1-hch@lst.de>
References: <20190416182347.18441-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__sbus_iommu_map_page currently assumes all pages are mapped into the
kernel direct mapping.  Switch to using physical address instead of
virtual ones for all the normal mapping operations, and only use
the virtual addresses for cache flushing when not operating on
a highmem page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sparc/mm/iommu.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 7e191c8ae46a..37b5ce7657f6 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -209,24 +209,23 @@ static u32 iommu_get_one(struct device *dev, phys_addr_t paddr, int npages)
 static dma_addr_t __sbus_iommu_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t len, bool per_page_flush)
 {
-	void *vaddr = page_address(page) + offset;
-	unsigned long off = (unsigned long)vaddr & ~PAGE_MASK;
+	phys_addr_t paddr = page_to_phys(page) + offset;
+	unsigned long off = paddr & ~PAGE_MASK;
 	unsigned long npages = (off + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
 	/* XXX So what is maxphys for us and how do drivers know it? */
 	if (!len || len > 256 * 1024)
 		return DMA_MAPPING_ERROR;
 
-	if (per_page_flush) {
-		unsigned long p = (unsigned long)vaddr & PAGE_MASK;
+	if (per_page_flush && !PageHighMem(page)) {
+		unsigned long vaddr, p;
 
-		while (p < (unsigned long)vaddr + len) {
+		vaddr = (unsigned long)page_address(page) + offset;
+		for (p = vaddr & PAGE_MASK; p < vaddr + len; p += PAGE_SIZE)
 			flush_page_for_dma(p);
-			p += PAGE_SIZE;
-		}
 	}
 
-	return iommu_get_one(dev, virt_to_phys(vaddr), npages) + off;
+	return iommu_get_one(dev, paddr, npages) + off;
 }
 
 static dma_addr_t sbus_iommu_map_page_gflush(struct device *dev,
-- 
2.20.1

