Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3559EC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FAF208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfD0PbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:31:01 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60958 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727176AbfD0PPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:16 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2m-0000zK-Vv; Sat, 27 Apr 2019 16:15:13 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2k-0004Wa-KG; Sat, 27 Apr 2019 16:15:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Thomas Hellstrom" <thellstrom@vmware.com>,
        "Deepak Rawat" <drawat@vmware.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.571231670@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 102/202] drm/vmwgfx: Fix setting of dma masks
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Hellstrom <thellstrom@vmware.com>

commit 4cbfa1e6c09e98450aab3240e5119b0ab2c9795b upstream.

Previously we set only the dma mask and not the coherent mask. Fix that.
Also, for clarity, make sure both are initially set to 64 bits.

Fixes: 0d00c488f3de: ("drm/vmwgfx: Fix the driver for large dma addresses")
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Deepak Rawat <drawat@vmware.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -567,13 +567,16 @@ out_fixup:
 static int vmw_dma_masks(struct vmw_private *dev_priv)
 {
 	struct drm_device *dev = dev_priv->dev;
+	int ret = 0;
 
-	if (intel_iommu_enabled &&
+	ret = dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(64));
+	if (dev_priv->map_mode != vmw_dma_phys &&
 	    (sizeof(unsigned long) == 4 || vmw_restrict_dma_mask)) {
 		DRM_INFO("Restricting DMA addresses to 44 bits.\n");
-		return dma_set_mask(dev->dev, DMA_BIT_MASK(44));
+		return dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(44));
 	}
-	return 0;
+
+	return ret;
 }
 #else
 static int vmw_dma_masks(struct vmw_private *dev_priv)

