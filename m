Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD82C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AC620663
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FDvcEsBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfDHKzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:55:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51642 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbfDHKzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TCa5qPd5eIyKEQ2GZldrojCC+9Vfipo7mMo4WVGNtpQ=; b=FDvcEsBcdhvU/828AsgZ91xkod
        CiG40hsuBlntvbj5DW0+LC9RN+7wpIlq7Nt3iCNS6xFjpVp5216BrID/7tc0oYrPhr3/v5EmJTaKU
        a7UkCbi/0NGB+D29HlqjZ0o1wFnK0W62X2tY4FjRZo/+U1HWAhfmG5nN6w4ZsfdhcIE0r/asXh8vt
        haAA2ShUaoLfLp/f23QBpcjewrCYbNqwaW8Zh7tK20YEmKohO7PfBjwSqEDiffGwFWZSTMuoS+/gl
        P5I3dMsSpXaM0gr2LXoR26fiZToUOp4FcGFgvGd0cwO+jlh5bSkD7alJREuR0yWrKWLhEeB0VtWmp
        cMEVX37w==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDRwK-0004jr-Mj; Mon, 08 Apr 2019 10:55:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Hellstrom <thellstrom@vmware.com>
Cc:     Deepak Rawat <drawat@vmware.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "drm/vmwgfx: Improve on IOMMU detection"
Date:   Mon,  8 Apr 2019 12:55:25 +0200
Message-Id: <20190408105525.5493-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408105525.5493-1-hch@lst.de>
References: <20190408105525.5493-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9ddac734aa310c5fbc0ec93602335d2a39092451.
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 6165fe2c4504..9294b76c8084 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -26,7 +26,6 @@
  **************************************************************************/
 #include <linux/module.h>
 #include <linux/console.h>
-#include <linux/dma-mapping.h>
 
 #include <drm/drmP.h>
 #include "vmwgfx_drv.h"
@@ -35,6 +34,7 @@
 #include <drm/ttm/ttm_placement.h>
 #include <drm/ttm/ttm_bo_driver.h>
 #include <drm/ttm/ttm_module.h>
+#include <linux/intel-iommu.h>
 
 #define VMWGFX_DRIVER_DESC "Linux drm driver for VMware graphics devices"
 #define VMWGFX_CHIP_SVGAII 0
@@ -545,21 +545,6 @@ static void vmw_get_initial_size(struct vmw_private *dev_priv)
 	dev_priv->initial_height = height;
 }
 
-/**
- * vmw_assume_iommu - Figure out whether coherent dma-remapping might be
- * taking place.
- * @dev: Pointer to the struct drm_device.
- *
- * Return: true if iommu present, false otherwise.
- */
-static bool vmw_assume_iommu(struct drm_device *dev)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev->dev);
-
-	return !dma_is_direct(ops) && ops &&
-		ops->map_page != dma_direct_map_page;
-}
-
 /**
  * vmw_dma_select_mode - Determine how DMA mappings should be set up for this
  * system.
@@ -583,7 +568,7 @@ static int vmw_dma_select_mode(struct vmw_private *dev_priv)
 
 	if (vmw_force_coherent)
 		dev_priv->map_mode = vmw_dma_alloc_coherent;
-	else if (vmw_assume_iommu(dev_priv->dev))
+	else if (intel_iommu_enabled)
 		dev_priv->map_mode = vmw_dma_map_populate;
 	else if (!vmw_force_iommu)
 		dev_priv->map_mode = vmw_dma_phys;
-- 
2.20.1

