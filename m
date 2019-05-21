Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3680C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A342173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 12:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DtBIhv9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfEUMro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 08:47:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfEUMrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 08:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t44lpcwx19L5UDwyIPITlcCA4k6gsZYQdQG/sxyJ2pY=; b=DtBIhv9e08a1olEgFKggeYxbti
        geB3szMrp6RCfQBPsRqouPDWJUwaR4UJpQbqFLvhFts/wEOVUZE5dCsun1jtncXIr1Yycgkw876/q
        mFBaDK/Im1WBy7o3+qaN0h7z2Z2COsM+8YWqgwt4RycyhM3+E9KZUg+gSpSRoeixFHUz3K28rcoLO
        67mtIirk1i6ifdd10g5onXTj1PRrbCJsFkPEi8aUvf7P/autmFa08mXjasYDmTTf7aOAFI5lTB06v
        k4P7O/yPJeEd0rCppoBDcbpCiDXPHiWG6sYyid7mZxApTrH8FV5Ehajg/Uz0cxP3srmVPvBN/W3ec
        EGCtishQ==;
Received: from 089144214035.atnat0023.highway.a1.net ([89.144.214.35] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hT4B7-0004Hu-5Q; Tue, 21 May 2019 12:47:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dma-mapping: truncate dma masks to what dma_addr_t can hold
Date:   Tue, 21 May 2019 14:47:28 +0200
Message-Id: <20190521124729.23559-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190521124729.23559-1-hch@lst.de>
References: <20190521124729.23559-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dma masks in struct device are always 64-bits wide.  But for builds
using a 32-bit dma_addr_t we need to ensure we don't store an
unsupportable value.  Before Linux 5.0 this was handled at least by
the ARM dma mapping code by never allowing to set a larger dma_mask,
but these days we allow the driver to just set the largest supported
value and never fall back to a smaller one.  Ensure this always works
by truncating the value.

Fixes: 9eb9e96e97b3 ("Documentation/DMA-API-HOWTO: update dma_mask sections")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/mapping.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index f7afdadb6770..1f628e7ac709 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -317,6 +317,12 @@ void arch_dma_set_mask(struct device *dev, u64 mask);
 
 int dma_set_mask(struct device *dev, u64 mask)
 {
+	/*
+	 * Truncate the mask to the actually supported dma_addr_t width to
+	 * avoid generating unsupportable addresses.
+	 */
+	mask = (dma_addr_t)mask;
+
 	if (!dev->dma_mask || !dma_supported(dev, mask))
 		return -EIO;
 
@@ -330,6 +336,12 @@ EXPORT_SYMBOL(dma_set_mask);
 #ifndef CONFIG_ARCH_HAS_DMA_SET_COHERENT_MASK
 int dma_set_coherent_mask(struct device *dev, u64 mask)
 {
+	/*
+	 * Truncate the mask to the actually supported dma_addr_t width to
+	 * avoid generating unsupportable addresses.
+	 */
+	mask = (dma_addr_t)mask;
+
 	if (!dma_supported(dev, mask))
 		return -EIO;
 
-- 
2.20.1

