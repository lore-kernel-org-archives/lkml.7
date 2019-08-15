Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2019C32757
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B362063F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BeH2wPF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbfHOH1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 03:27:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39326 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730615AbfHOH1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HhO4/D/NaNM06KJjZWx26/cJBBtl+T/HbPuQrHkNthA=; b=BeH2wPF+BkgHdS7k0Gkpdes7m5
        PdK1UQndHXyoYXvPjG4BilaU7+yAYLiNWHbvH6JhGutgEBzVm9YCF1tK0B9LYYpKOuyYyLNfe0vLc
        uyE2OvhWnBLb+HOWDtb+BK6EveoXzwq8dh7V0bHdKuR0guDWJ2WdQ7fsr0X1/2iZlbhvurksLz436
        0og0iCFAX8iEU3yj4jOguZzh+GzDBE7VaInj14HfybLqVdDmxionFRDHqj9wAJQN50+H+i8g24BDn
        4jaF72La75LTC36QPH+vYd1QugRnNHBsSGnVG4RXDgFU+p+RLY6H577syjyAuY7/eDql6Z1y3H8Oc
        EYU311lg==;
Received: from [2001:4bb8:18c:28b5:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hyAAA-00010f-6d; Thu, 15 Aug 2019 07:27:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] drm/amdgpu: handle PCIe root ports with addressing limitations
Date:   Thu, 15 Aug 2019 09:27:01 +0200
Message-Id: <20190815072703.7010-3-hch@lst.de>
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

amdgpu uses a need_dma32 flag to indicate to the drm core that some
allocations need to be done using GFP_DMA32, but it only checks the
device addressing capabilities to make that decision.  Unfortunately
PCIe root ports that have limited addressing exist as well.  Use the
dma_addressing_limited instead to also take those into account.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e51b48ac48eb..91f128b43b6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1728,7 +1728,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	r = ttm_bo_device_init(&adev->mman.bdev,
 			       &amdgpu_bo_driver,
 			       adev->ddev->anon_inode->i_mapping,
-			       adev->need_dma32);
+			       dma_addressing_limited(adev->dev));
 	if (r) {
 		DRM_ERROR("failed initializing buffer object driver(%d).\n", r);
 		return r;
-- 
2.20.1

