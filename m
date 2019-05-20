Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91FEC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBAB20856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i/GbF4XX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbfETHba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 03:31:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46418 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730458AbfETHb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 03:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zxzYkVmXPiGI8Zsn4DmQf0BO8hkL1x91vdl8uI+BUZ8=; b=i/GbF4XXTrgbfvNYnWZiVxMrlH
        ZZvmjucsr/x+N1/aZxqVbmtMsNv4MbnUYfLvh0YjcWbbETo4e8Ai+EZk5VZ/ci2ncI7hhp3gI+1jh
        5kS4GI47lVuhkHCXhKRX8LBrhDnPdd6vPr3ZQOjjSOLFH1Pa3g3UBPyBYSFJXSlKOrewIxrX/pjL8
        jipwaGcVzcbOnuvDuatkKzgO+3UxGWVuvRmcIu4s78hrWXH77o4ON0WcWVSptF0sVVrwh0Eak82zA
        pCLg/j7+SGYOSSYjJoc4uItMP8GwKOOWQ0uDKJkTN9st+ZU5YOzhpZfJ4lHdOVz2ozG3b+0r+NMIv
        ikkSfJyA==;
Received: from 089144206147.atnat0015.highway.bob.at ([89.144.206.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSclW-0004Zf-5Z; Mon, 20 May 2019 07:31:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Murphy <tmurphy@arista.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/24] iommu/dma: Split iommu_dma_free
Date:   Mon, 20 May 2019 09:29:40 +0200
Message-Id: <20190520072948.11412-17-hch@lst.de>
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

Most of it can double up to serve the failure cleanup path for
iommu_dma_alloc().

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ee7dcf03c304..f0cd35fd11dd 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -935,15 +935,12 @@ static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 	__iommu_dma_unmap(dev, handle, size);
 }
 
-static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
-		dma_addr_t handle, unsigned long attrs)
+static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
 {
 	size_t alloc_size = PAGE_ALIGN(size);
 	int count = alloc_size >> PAGE_SHIFT;
 	struct page *page = NULL, **pages = NULL;
 
-	__iommu_dma_unmap(dev, handle, size);
-
 	/* Non-coherent atomic allocation? Easy */
 	if (dma_free_from_pool(cpu_addr, alloc_size))
 		return;
@@ -968,6 +965,13 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		__free_pages(page, get_order(alloc_size));
 }
 
+static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
+		dma_addr_t handle, unsigned long attrs)
+{
+	__iommu_dma_unmap(dev, handle, size);
+	__iommu_dma_free(dev, size, cpu_addr);
+}
+
 static void *iommu_dma_alloc(struct device *dev, size_t size,
 		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
 {
-- 
2.20.1

