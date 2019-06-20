Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF50C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A00B2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 06:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfFTGPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 02:15:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfFTGPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 02:15:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D9C3E3E08;
        Thu, 20 Jun 2019 06:15:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-212.ams2.redhat.com [10.36.116.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 855D0601A5;
        Thu, 20 Jun 2019 06:15:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B155317510; Thu, 20 Jun 2019 08:15:47 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Eric Anholt <eric@anholt.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] drm: switch shmem helper to drm_gem_object_funcs->mmap
Date:   Thu, 20 Jun 2019 08:15:46 +0200
Message-Id: <20190620061547.8664-3-kraxel@redhat.com>
In-Reply-To: <20190620061547.8664-1-kraxel@redhat.com>
References: <20190620061547.8664-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 20 Jun 2019 06:15:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch gem shmem helper from gem_driver->fops->mmap to
drm_gem_object_funcs->mmap.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem_shmem_helper.h      |  4 ++--
 drivers/gpu/drm/drm_gem_shmem_helper.c  | 18 +++++++-----------
 drivers/gpu/drm/panfrost/panfrost_gem.c |  1 +
 drivers/gpu/drm/v3d/v3d_bo.c            |  1 +
 4 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 038b6d313447..0f7b77cdc26b 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -108,7 +108,7 @@ struct drm_gem_shmem_object {
 		.poll		= drm_poll,\
 		.read		= drm_read,\
 		.llseek		= noop_llseek,\
-		.mmap		= drm_gem_shmem_mmap, \
+		.mmap		= drm_gem_mmap, \
 	}
 
 struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t size);
@@ -128,7 +128,7 @@ drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
 int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
 			      struct drm_mode_create_dumb *args);
 
-int drm_gem_shmem_mmap(struct file *filp, struct vm_area_struct *vma);
+int drm_gem_shmem_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma);
 
 extern const struct vm_operations_struct drm_gem_shmem_vm_ops;
 
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 1ee208c2c85e..d5a248858486 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -31,6 +31,7 @@ static const struct drm_gem_object_funcs drm_gem_shmem_funcs = {
 	.get_sg_table = drm_gem_shmem_get_sg_table,
 	.vmap = drm_gem_shmem_vmap,
 	.vunmap = drm_gem_shmem_vunmap,
+	.mmap = drm_gem_shmem_mmap,
 	.vm_ops = &drm_gem_shmem_vm_ops,
 };
 
@@ -446,30 +447,25 @@ EXPORT_SYMBOL_GPL(drm_gem_shmem_vm_ops);
 
 /**
  * drm_gem_shmem_mmap - Memory-map a shmem GEM object
- * @filp: File object
+ * @obj: gem object
  * @vma: VMA for the area to be mapped
  *
  * This function implements an augmented version of the GEM DRM file mmap
  * operation for shmem objects. Drivers which employ the shmem helpers should
- * use this function as their &file_operations.mmap handler in the DRM device file's
- * file_operations structure.
+ * use this function as their &drm_gem_object_funcs.mmap handler.
  *
- * Instead of directly referencing this function, drivers should use the
- * DEFINE_DRM_GEM_SHMEM_FOPS() macro.
+ * Instead of directly referencing this function, drivers can use
+ * drm_gem_shmem_funcs.
  *
  * Returns:
  * 0 on success or a negative error code on failure.
  */
-int drm_gem_shmem_mmap(struct file *filp, struct vm_area_struct *vma)
+int drm_gem_shmem_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
 {
 	struct drm_gem_shmem_object *shmem;
 	int ret;
 
-	ret = drm_gem_mmap(filp, vma);
-	if (ret)
-		return ret;
-
-	shmem = to_drm_gem_shmem_obj(vma->vm_private_data);
+	shmem = to_drm_gem_shmem_obj(obj);
 
 	ret = drm_gem_shmem_get_pages(shmem);
 	if (ret) {
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index 886875ae31d3..23a6f04cfade 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -36,6 +36,7 @@ static const struct drm_gem_object_funcs panfrost_gem_funcs = {
 	.get_sg_table = drm_gem_shmem_get_sg_table,
 	.vmap = drm_gem_shmem_vmap,
 	.vunmap = drm_gem_shmem_vunmap,
+	.mmap = drm_gem_shmem_mmap,
 	.vm_ops = &drm_gem_shmem_vm_ops,
 };
 
diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index a22b75a3a533..c01e2b952451 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -58,6 +58,7 @@ static const struct drm_gem_object_funcs v3d_gem_funcs = {
 	.get_sg_table = drm_gem_shmem_get_sg_table,
 	.vmap = drm_gem_shmem_vmap,
 	.vunmap = drm_gem_shmem_vunmap,
+	.mmap = drm_gem_shmem_mmap,
 	.vm_ops = &drm_gem_shmem_vm_ops,
 };
 
-- 
2.18.1

