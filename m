Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0C6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B862085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387587AbfCAJZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 04:25:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732411AbfCAJZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 04:25:06 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E79483001A7C;
        Fri,  1 Mar 2019 09:25:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-211.ams2.redhat.com [10.36.116.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 505AF5D732;
        Fri,  1 Mar 2019 09:25:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 937C517515; Fri,  1 Mar 2019 10:25:02 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     intel-gfx@lists.freedesktop.org, daniel@ffwll.ch,
        Gerd Hoffmann <kraxel@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 4/4] drm/i915: switch to drm_fb_helper_remove_conflicting_pci_framebuffers
Date:   Fri,  1 Mar 2019 10:25:02 +0100
Message-Id: <20190301092502.30948-5-kraxel@redhat.com>
In-Reply-To: <20190301092502.30948-1-kraxel@redhat.com>
References: <20190301092502.30948-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 01 Mar 2019 09:25:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/i915/i915_drv.c | 38 ++------------------------------------
 1 file changed, 2 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 9df65d386d11..c6f1e0dbdd58 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -732,31 +732,6 @@ static int i915_load_modeset_init(struct drm_device *dev)
 	return ret;
 }
 
-static int i915_kick_out_firmware_fb(struct drm_i915_private *dev_priv)
-{
-	struct apertures_struct *ap;
-	struct pci_dev *pdev = dev_priv->drm.pdev;
-	struct i915_ggtt *ggtt = &dev_priv->ggtt;
-	bool primary;
-	int ret;
-
-	ap = alloc_apertures(1);
-	if (!ap)
-		return -ENOMEM;
-
-	ap->ranges[0].base = ggtt->gmadr.start;
-	ap->ranges[0].size = ggtt->mappable_end;
-
-	primary =
-		pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_SHADOW;
-
-	ret = drm_fb_helper_remove_conflicting_framebuffers(ap, "inteldrmfb", primary);
-
-	kfree(ap);
-
-	return ret;
-}
-
 static void intel_init_dpio(struct drm_i915_private *dev_priv)
 {
 	/*
@@ -1377,22 +1352,13 @@ static int i915_driver_init_hw(struct drm_i915_private *dev_priv)
 	if (ret)
 		goto err_perf;
 
-	/*
-	 * WARNING: Apparently we must kick fbdev drivers before vgacon,
-	 * otherwise the vga fbdev driver falls over.
-	 */
-	ret = i915_kick_out_firmware_fb(dev_priv);
+	ret = drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 2,
+								"inteldrmfb");
 	if (ret) {
 		DRM_ERROR("failed to remove conflicting framebuffer drivers\n");
 		goto err_ggtt;
 	}
 
-	ret = vga_remove_vgacon(pdev);
-	if (ret) {
-		DRM_ERROR("failed to remove conflicting VGA console\n");
-		goto err_ggtt;
-	}
-
 	ret = i915_ggtt_init_hw(dev_priv);
 	if (ret)
 		goto err_ggtt;
-- 
2.9.3

