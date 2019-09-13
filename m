Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCA4C4CEC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 12:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFBC2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 12:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbfIMM3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 08:29:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729811AbfIMM3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:29:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0177C308218D;
        Fri, 13 Sep 2019 12:29:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 738B36013A;
        Fri, 13 Sep 2019 12:29:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 9998231F62; Fri, 13 Sep 2019 14:29:09 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 6/8] drm/vram: switch vram helper to &drm_gem_object_funcs.mmap()
Date:   Fri, 13 Sep 2019 14:29:06 +0200
Message-Id: <20190913122908.784-7-kraxel@redhat.com>
In-Reply-To: <20190913122908.784-1-kraxel@redhat.com>
References: <20190913122908.784-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 13 Sep 2019 12:29:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up the new drm_gem_ttm_mmap() helper function,
use generic drm_gem_mmap for &fops.mmap and
delete dead drm_vram_mm_file_operations_mmap().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem_vram_helper.h     |  9 +------
 drivers/gpu/drm/drm_gem_vram_helper.c | 34 +--------------------------
 2 files changed, 2 insertions(+), 41 deletions(-)

diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index 9aaef4f8c327..9d5526650291 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -180,13 +180,6 @@ struct drm_vram_mm *drm_vram_helper_alloc_mm(
 	struct drm_device *dev, uint64_t vram_base, size_t vram_size);
 void drm_vram_helper_release_mm(struct drm_device *dev);
 
-/*
- * Helpers for &struct file_operations
- */
-
-int drm_vram_mm_file_operations_mmap(
-	struct file *filp, struct vm_area_struct *vma);
-
 /**
  * define DRM_VRAM_MM_FILE_OPERATIONS - default callback functions for \
 	&struct file_operations
@@ -200,7 +193,7 @@ int drm_vram_mm_file_operations_mmap(
 	.poll		= drm_poll, \
 	.unlocked_ioctl = drm_ioctl, \
 	.compat_ioctl	= drm_compat_ioctl, \
-	.mmap		= drm_vram_mm_file_operations_mmap, \
+	.mmap		= drm_gem_mmap, \
 	.open		= drm_open, \
 	.release	= drm_release \
 
diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 7bee80c6b6e8..e100b97ea6e3 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -681,6 +681,7 @@ static const struct drm_gem_object_funcs drm_gem_vram_object_funcs = {
 	.unpin	= drm_gem_vram_object_unpin,
 	.vmap	= drm_gem_vram_object_vmap,
 	.vunmap	= drm_gem_vram_object_vunmap,
+	.mmap   = drm_gem_ttm_mmap,
 	.print_info = drm_gem_ttm_print_info,
 };
 
@@ -915,12 +916,6 @@ static void drm_vram_mm_cleanup(struct drm_vram_mm *vmm)
 	ttm_bo_device_release(&vmm->bdev);
 }
 
-static int drm_vram_mm_mmap(struct file *filp, struct vm_area_struct *vma,
-			    struct drm_vram_mm *vmm)
-{
-	return ttm_bo_mmap(filp, vma, &vmm->bdev);
-}
-
 /*
  * Helpers for integration with struct drm_device
  */
@@ -976,30 +971,3 @@ void drm_vram_helper_release_mm(struct drm_device *dev)
 	dev->vram_mm = NULL;
 }
 EXPORT_SYMBOL(drm_vram_helper_release_mm);
-
-/*
- * Helpers for &struct file_operations
- */
-
-/**
- * drm_vram_mm_file_operations_mmap() - \
-	Implements &struct file_operations.mmap()
- * @filp:	the mapping's file structure
- * @vma:	the mapping's memory area
- *
- * Returns:
- * 0 on success, or
- * a negative error code otherwise.
- */
-int drm_vram_mm_file_operations_mmap(
-	struct file *filp, struct vm_area_struct *vma)
-{
-	struct drm_file *file_priv = filp->private_data;
-	struct drm_device *dev = file_priv->minor->dev;
-
-	if (WARN_ONCE(!dev->vram_mm, "VRAM MM not initialized"))
-		return -EINVAL;
-
-	return drm_vram_mm_mmap(filp, vma, dev->vram_mm);
-}
-EXPORT_SYMBOL(drm_vram_mm_file_operations_mmap);
-- 
2.18.1

