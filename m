Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E8FC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 13:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A27A2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 13:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eiYUK7Ni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfHPNAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 09:00:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56888 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfHPNAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 09:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/7UWrSy9tZvy7g4jhRp+syX7wiGwkvXkNPrPT2LJB6A=; b=eiYUK7Ni6okBQZbHkMxxv5OveK
        lTRwJVeQNsHZGWEuYhgs3yiyj8Hr/gEYEnkJ3z7GUbAfBKWPvag87nQiuslng3V+RlcoGIkJdZzU+
        6TjosTLd8kJUSsYyV8JnfK6fgzXPv7cHYujLAeSGzWDlceyYIm6+3GeNiE/4/J1ye5AUp+Ic3iiXB
        H3GP8ZYc1vPE7bnz84Kg95W63+wzya/1hsufHoqvxS5sluyqkz+AL+Hp1V797Wxj91CLRSovXunpG
        JrDs4pFb7pLpZEahrp3Nn3qmrdjdn5MsdPi3/GAddSe7uTXsnQs6cSmj0wr8i8oqceUppIcaJVODB
        8GaXwY0A==;
Received: from [91.112.187.46] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hybqE-0006Nn-OA; Fri, 16 Aug 2019 13:00:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] xen/arm: pass one less argument to dma_cache_maint
Date:   Fri, 16 Aug 2019 15:00:05 +0200
Message-Id: <20190816130013.31154-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816130013.31154-1-hch@lst.de>
References: <20190816130013.31154-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of taking apart the dma address in both callers do it inside
dma_cache_maint itself.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/xen/mm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index 90574d89d0d4..d9da24fda2f7 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -43,13 +43,15 @@ static bool hypercall_cflush = false;
 
 /* functions called by SWIOTLB */
 
-static void dma_cache_maint(dma_addr_t handle, unsigned long offset,
-	size_t size, enum dma_data_direction dir, enum dma_cache_op op)
+static void dma_cache_maint(dma_addr_t handle, size_t size,
+		enum dma_data_direction dir, enum dma_cache_op op)
 {
 	struct gnttab_cache_flush cflush;
 	unsigned long xen_pfn;
+	unsigned long offset = handle & ~PAGE_MASK;
 	size_t left = size;
 
+	offset &= PAGE_MASK;
 	xen_pfn = (handle >> XEN_PAGE_SHIFT) + offset / XEN_PAGE_SIZE;
 	offset %= XEN_PAGE_SIZE;
 
@@ -86,13 +88,13 @@ static void dma_cache_maint(dma_addr_t handle, unsigned long offset,
 static void __xen_dma_page_dev_to_cpu(struct device *hwdev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir)
 {
-	dma_cache_maint(handle & PAGE_MASK, handle & ~PAGE_MASK, size, dir, DMA_UNMAP);
+	dma_cache_maint(handle, size, dir, DMA_UNMAP);
 }
 
 static void __xen_dma_page_cpu_to_dev(struct device *hwdev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir)
 {
-	dma_cache_maint(handle & PAGE_MASK, handle & ~PAGE_MASK, size, dir, DMA_MAP);
+	dma_cache_maint(handle, size, dir, DMA_MAP);
 }
 
 void __xen_dma_map_page(struct device *hwdev, struct page *page,
-- 
2.20.1

