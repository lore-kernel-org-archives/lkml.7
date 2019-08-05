Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C75DC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41618217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fp0Xe1C0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfHEH4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 03:56:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43446 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfHEH4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 03:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mP2CgnPK3wGe7c/LAwYezyw+0OCXX14bjF2g7MdIhRE=; b=fp0Xe1C0a+H/6nttgaF4k3uKtL
        WLfrrCtSJHXTZ4A5bGnNFtgNisOpWgEuNm9708tROs/OZfy+0RlhgUewGUorDxLlkjIYYwkGZ4DJF
        8e+FduwvByXTvEOvSIvSWhAi2nmlNeElOPHpk3d9pa9hpl/zkd0UYLMm8p3aDsssyWmkcEK8NULFy
        NiCH3y6ouOMGpuJB0glQjlQVVeGfckDR/pWytOAgFCxtw80gPdOCZgs51fKBp/QsvOY+W8pi6C/+v
        OgXoJKNRn/0ziOZtKZ6PE+yi6KcMwYqXDbyoAFhoOEL7QkjVdVXfDaGCiJVCBbqi3W74CRh3Ivv0L
        lm/9tp5g==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1huXrK-0000xQ-Dy; Mon, 05 Aug 2019 07:56:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Roger Quadros <rogerq@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH] arm: initialize the dma-remap atomic pool for LPAE configs
Date:   Mon,  5 Aug 2019 10:56:37 +0300
Message-Id: <20190805075637.5373-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190805075637.5373-1-hch@lst.de>
References: <20190805075637.5373-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we use the generic dma-direct + remap code we also need to
initialize the atomic pool that is used for GFP_ATOMIC allocations on
non-coherent devices.

Fixes: ad3c7b18c5b3 ("arm: use swiotlb for bounce buffering on LPAE configs")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mm/dma-mapping.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 6774b03aa405..e509365cc9ca 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2423,4 +2423,10 @@ void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
 {
 	__arm_dma_free(dev, size, cpu_addr, dma_handle, attrs, false);
 }
+
+static int __init atomic_pool_init(void)
+{
+	return dma_atomic_pool_init(GFP_DMA, pgprot_noncached(PAGE_KERNEL));
+}
+postcore_initcall(atomic_pool_init);
 #endif /* CONFIG_SWIOTLB */
-- 
2.20.1

