Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4BFC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE2821927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389228AbfISKCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 06:02:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389185AbfISKCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:02:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CEB591DA3;
        Thu, 19 Sep 2019 10:02:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CA4B5C1B5;
        Thu, 19 Sep 2019 10:02:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id DE1719CAA; Thu, 19 Sep 2019 12:02:24 +0200 (CEST)
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
Subject: [PATCH v3 09/11] drm/vram: switch vram helper to &drm_gem_object_funcs.mmap()
Date:   Thu, 19 Sep 2019 12:02:21 +0200
Message-Id: <20190919100223.13309-10-kraxel@redhat.com>
In-Reply-To: <20190919100223.13309-1-kraxel@redhat.com>
References: <20190919100223.13309-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Thu, 19 Sep 2019 10:02:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up the new drm_gem_ttm_mmap() helper function,
use generic drm_gem_mmap for &fops.mmap and
delete dead drm_vram_mm_file_operations_mmap().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/drm/drm_gem_vram_helper.h     |  9 +------
 drivers/gpu/drm/drm_gem_vram_helper.c | 34 +--------------------------
 2 files changed, 2 insertions(+), 41 deletions(-)

diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index 418eb1122861..05a762c87305 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -183,13 +183,6 @@ struct drm_vram_mm *drm_vram_helper_alloc_mm(
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
@@ -203,7 +196,7 @@ int drm_vram_mm_file_operations_mmap(
 	.poll		= drm_poll, \
 	.unlocked_ioctl = drm_ioctl, \
 	.compat_ioctl	= drm_compat_ioctl, \
-	.mmap		= drm_vram_mm_file_operations_mmap, \
+	.mmap		= drm_gem_mmap, \
 	.open		= drm_open, \
 	.release	= drm_release \
 
diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 49588de88959..bc37c4651766 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -725,6 +725,7 @@ static const struct drm_gem_object_funcs drm_gem_vram_object_funcs = {
 	.unpin	= drm_gem_vram_object_unpin,
 	.vmap	= drm_gem_vram_object_vmap,
 	.vunmap	= drm_gem_vram_object_vunmap,
+	.mmap   = drm_gem_ttm_mmap,
 	.print_info = drm_gem_ttm_print_info,
 };
 
@@ -959,12 +960,6 @@ static void drm_vram_mm_cleanup(struct drm_vram_mm *vmm)
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
@@ -1020,30 +1015,3 @@ void drm_vram_helper_release_mm(struct drm_device *dev)
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

