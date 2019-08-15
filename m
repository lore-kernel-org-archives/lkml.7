Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A79C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFADD2063F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jlCfV3DA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbfHOH1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 03:27:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39318 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfHOH1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HRWpQtxV9xoLsNARYHwlXoqVEaFSd37kaecfauBfEU0=; b=jlCfV3DAoNyJiudaXiXwAUKMly
        j7oiBQwtZN2yD1e0yVSPiun4mvCtKPVz2U4aAnCFnbv6I8k7pVCr1yspmRzeZdmS+80Zdt5qKmlm1
        kvdH3whXNwr6FjKKsDlEeRx14ap1rOX5pYJFIPG1Zbga+u8p6wiJWOPHhTYl/JliGFCjSBmH/0Dgn
        ztES0EnH1TzKyL7CTEt6oBN75ZT8xSQ+///ozIGscnYMks/2Qf35TzqFhKrvIMF8mO4t4GDl4XOoY
        LNlXugpa7FlPZdDN7PletDQNyBJcArf4cjnmMNbbnEWpaJaIYzv1pT2nta0iQxpR37knQVsACilX3
        SQxclZYw==;
Received: from [2001:4bb8:18c:28b5:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hyAA7-00010W-QW; Thu, 15 Aug 2019 07:27:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] drm/radeon: handle PCIe root ports with addressing limitations
Date:   Thu, 15 Aug 2019 09:27:00 +0200
Message-Id: <20190815072703.7010-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815072703.7010-1-hch@lst.de>
References: <20190815072703.7010-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

radeon uses a need_dma32 flag to indicate to the drm core that some
allocations need to be done using GFP_DMA32, but it only checks the
device addressing capabilities to make that decision.  Unfortunately
PCIe root ports that have limited addressing exist as well.  Use the
dma_addressing_limited instead to also take those into account.

Reported-by: Atish Patra <Atish.Patra@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/radeon/radeon.h        |  1 -
 drivers/gpu/drm/radeon/radeon_device.c | 12 +++++-------
 drivers/gpu/drm/radeon/radeon_ttm.c    |  2 +-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 32808e50be12..1a0b22526a75 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -2387,7 +2387,6 @@ struct radeon_device {
 	struct radeon_wb		wb;
 	struct radeon_dummy_page	dummy_page;
 	bool				shutdown;
-	bool				need_dma32;
 	bool				need_swiotlb;
 	bool				accel_working;
 	bool				fastfb_working; /* IGP feature*/
diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index dceb554e5674..b8cc05826667 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -1365,27 +1365,25 @@ int radeon_device_init(struct radeon_device *rdev,
 	else
 		rdev->mc.mc_mask = 0xffffffffULL; /* 32 bit MC */
 
-	/* set DMA mask + need_dma32 flags.
+	/* set DMA mask.
 	 * PCIE - can handle 40-bits.
 	 * IGP - can handle 40-bits
 	 * AGP - generally dma32 is safest
 	 * PCI - dma32 for legacy pci gart, 40 bits on newer asics
 	 */
-	rdev->need_dma32 = false;
+	dma_bits = 40;
 	if (rdev->flags & RADEON_IS_AGP)
-		rdev->need_dma32 = true;
+		dma_bits = 32;
 	if ((rdev->flags & RADEON_IS_PCI) &&
 	    (rdev->family <= CHIP_RS740))
-		rdev->need_dma32 = true;
+		dma_bits = 32;
 #ifdef CONFIG_PPC64
 	if (rdev->family == CHIP_CEDAR)
-		rdev->need_dma32 = true;
+		dma_bits = 32;
 #endif
 
-	dma_bits = rdev->need_dma32 ? 32 : 40;
 	r = pci_set_dma_mask(rdev->pdev, DMA_BIT_MASK(dma_bits));
 	if (r) {
-		rdev->need_dma32 = true;
 		dma_bits = 32;
 		pr_warn("radeon: No suitable DMA available\n");
 	}
diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index fb3696bc616d..116a27b25dc4 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -794,7 +794,7 @@ int radeon_ttm_init(struct radeon_device *rdev)
 	r = ttm_bo_device_init(&rdev->mman.bdev,
 			       &radeon_bo_driver,
 			       rdev->ddev->anon_inode->i_mapping,
-			       rdev->need_dma32);
+			       dma_addressing_limited(&rdev->pdev->dev));
 	if (r) {
 		DRM_ERROR("failed initializing buffer object driver(%d).\n", r);
 		return r;
-- 
2.20.1

