Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34D9C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 07:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C995E2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 07:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CRP6GQ1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfHPHMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 03:12:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34756 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfHPHMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 03:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=M7aCOncE9cdu2lm40wE0sX+3YWUOlwEH41YvffpGGBk=; b=CRP6GQ1Lw34CR/2cSWO1S3ZZo7
        e3qzMt3uC65GaHDy3QSzuRl1aPq3CtXFktR5fKF090cwLGuGBZGa6eAieGRaAnKnpuNfu5cGOn4Tf
        FVjPlPIBzyavJz1TLlKfnWsPNcl0+ZzV951/W6lBM8PV+37b/MZSD/tEOS3Wwr8m51GBht62ZOyFU
        sz7lXUAbthR+KCik65ooNskt93tJYvV69EyKiI2UMWnqSEDzM895lTxZfL/2oEOMUWlZWaQw2DyPt
        PZuyiX/vzX6bI0w3BLRkuuu7yKSXeOODuvIg9eDLOccgfkc0J/tDK1E0fF7L/hCHctEEtVKipkDnM
        aRayUKSA==;
Received: from 089144199030.atnat0008.highway.a1.net ([89.144.199.30] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hyWPO-0006sq-Qm; Fri, 16 Aug 2019 07:12:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Guan Xuetao <gxt@pku.edu.cn>, Shawn Anastasio <shawn@anastas.io>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] MIPS: remove support for DMA_ATTR_WRITE_COMBINE
Date:   Fri, 16 Aug 2019 09:07:49 +0200
Message-Id: <20190816070754.15653-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816070754.15653-1-hch@lst.de>
References: <20190816070754.15653-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mips uses the KSEG1 kernel memory segment do map dma coherent
allocations for non-coherent devices as uncachable, and does not have
any kind of special support for DMA_ATTR_WRITE_COMBINE in the allocation
path.  Thus supporting DMA_ATTR_WRITE_COMBINE in dma_mmap_attrs will
lead to multiple mappings with different caching attributes.

Fixes: 8c172467be36 ("MIPS: Add implementation of dma_map_ops.mmap()")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/Kconfig              | 1 -
 arch/mips/mm/dma-noncoherent.c | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d50fafd7bf3a..86e6760ef0d0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1119,7 +1119,6 @@ config DMA_PERDEV_COHERENT
 
 config DMA_NONCOHERENT
 	bool
-	select ARCH_HAS_DMA_MMAP_PGPROT
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_HAS_UNCACHED_SEGMENT
 	select NEED_DMA_MAP_STATE
diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index ed56c6fa7be2..1d4d57dd9acf 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -65,14 +65,6 @@ long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
 	return page_to_pfn(virt_to_page(cached_kernel_address(cpu_addr)));
 }
 
-pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
-		unsigned long attrs)
-{
-	if (attrs & DMA_ATTR_WRITE_COMBINE)
-		return pgprot_writecombine(prot);
-	return pgprot_noncached(prot);
-}
-
 static inline void dma_sync_virt(void *addr, size_t size,
 		enum dma_data_direction dir)
 {
-- 
2.20.1

