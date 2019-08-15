Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A0DC31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7592063F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eSruVy8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbfHOH1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 03:27:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39340 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfHOH1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AwFuGumE9IIrj++t8nZcW7NCG+hmEZXmZtXnY+EyQlc=; b=eSruVy8fiuD0VoyLhPcSRQPk9F
        NIojc0tW9vHqVAu2hAyQE1A57YHqiQawsj8cuciY0huP/QX26VCycXkpIjWYkOzGetJ5IkFrSEs8w
        PSbpbKg6jNHT8+McLYWFjOur3MK4wjQGiXRK3QjevcSHnKXx777te+UNz/freT+jZnnR4lwvLoE8d
        8/cDGXeVnEj/GXT59EwabEChV+XUxvgxFEcMvwaowfJSg/0H/L7kgZDKoPMDr5HB9UTakaokrbvNR
        oHdPQVo3lUkOAeUsUPCs9d2td6xsNS81t4mqlZTHxJ8eaS6RBdSD8c5683r/DVOVmT08NU8Ol77qW
        q1PzIzPw==;
Received: from [2001:4bb8:18c:28b5:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hyAAC-00010m-JV; Thu, 15 Aug 2019 07:27:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] drm/radeon: simplify and cleanup setting the dma mask
Date:   Thu, 15 Aug 2019 09:27:02 +0200
Message-Id: <20190815072703.7010-4-hch@lst.de>
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

Use dma_set_mask_and_coherent to set both masks in one go, and remove
the no longer required fallback, as the kernel now always accepts
larger than required DMA masks.  Fail the driver probe if we can't
set the DMA mask, as that means the system can only support a larger
mask.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/radeon/radeon_device.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index b8cc05826667..88eb7cb522bb 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -1382,15 +1382,10 @@ int radeon_device_init(struct radeon_device *rdev,
 		dma_bits = 32;
 #endif
 
-	r = pci_set_dma_mask(rdev->pdev, DMA_BIT_MASK(dma_bits));
+	r = dma_set_mask_and_coherent(&rdev->pdev->dev, DMA_BIT_MASK(dma_bits));
 	if (r) {
-		dma_bits = 32;
 		pr_warn("radeon: No suitable DMA available\n");
-	}
-	r = pci_set_consistent_dma_mask(rdev->pdev, DMA_BIT_MASK(dma_bits));
-	if (r) {
-		pci_set_consistent_dma_mask(rdev->pdev, DMA_BIT_MASK(32));
-		pr_warn("radeon: No coherent DMA available\n");
+		return r;
 	}
 	rdev->need_swiotlb = drm_need_swiotlb(dma_bits);
 
-- 
2.20.1

