Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A7BC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A466C2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lFYiUCpf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbfEWHBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:01:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38166 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730225AbfEWHBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=N84thTlHZj/26jcyj6eUXZdZHkPD/VelftIOQc0tBI4=; b=lFYiUCpfyqKArCjAYm+KvG88rt
        q8epoS6JcXki02C6ceOC27IFgGSmFEaWEZLhxq/wybWdiyAqd4id58XlhHeSXXxSSod7qak7e2lVH
        vvQW3i8Kg1LxUTL/Vm/2i2LZftNW6EfZvnCMu6R+q0R1Y4mW5kAqr0JoJvKjfuMu133a2SVlTiZSL
        y6gwTZRdb5X8Kj3aYVrB/1wVYQP63jhYW0WGGzBY/cGYV6a+JccVkMZMODb+MJlC6nAduP6ZNYAeq
        xgYrC86sZ/gKJcc7aSwZ/KXycm0BZwntwvtBpw6KXlp/nVZ6QdOwLhCnSyh1Z74vpFu8t9tfPZ7J0
        gWmb3CPQ==;
Received: from 213-225-10-46.nat.highway.a1.net ([213.225.10.46] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hThiz-0005e1-Pi; Thu, 23 May 2019 07:01:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Tom Murphy <tmurphy@arista.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 15/23] iommu/dma: Split iommu_dma_free
Date:   Thu, 23 May 2019 09:00:20 +0200
Message-Id: <20190523070028.7435-16-hch@lst.de>
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

From: Robin Murphy <robin.murphy@arm.com>

Most of it can double up to serve the failure cleanup path for
iommu_dma_alloc().

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 6b8cedae7cff..33d1ce8cc640 100644
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

