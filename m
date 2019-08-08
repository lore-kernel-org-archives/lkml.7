Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CA9C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6771218A6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389994AbfHHNoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:44:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733255AbfHHNoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:44:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 216BC30A7BBB;
        Thu,  8 Aug 2019 13:44:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com [10.36.116.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78AD060C47;
        Thu,  8 Aug 2019 13:44:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8A3B39D22; Thu,  8 Aug 2019 15:44:19 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Eric Anholt <eric@anholt.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        QEMU'S CIRRUS DEVICE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 07/17] drm/shmem: drop DEFINE_DRM_GEM_SHMEM_FOPS
Date:   Thu,  8 Aug 2019 15:44:07 +0200
Message-Id: <20190808134417.10610-8-kraxel@redhat.com>
In-Reply-To: <20190808134417.10610-1-kraxel@redhat.com>
References: <20190808134417.10610-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 08 Aug 2019 13:44:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DEFINE_DRM_GEM_SHMEM_FOPS is identical to DEFINE_DRM_GEM_FOPS now,
drop it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem_shmem_helper.h      | 26 -------------------------
 drivers/gpu/drm/cirrus/cirrus.c         |  2 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c |  2 +-
 drivers/gpu/drm/v3d/v3d_drv.c           |  2 +-
 4 files changed, 3 insertions(+), 29 deletions(-)

diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 0f7b77cdc26b..813240dcfe17 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -85,32 +85,6 @@ struct drm_gem_shmem_object {
 #define to_drm_gem_shmem_obj(obj) \
 	container_of(obj, struct drm_gem_shmem_object, base)
 
-/**
- * DEFINE_DRM_GEM_SHMEM_FOPS() - Macro to generate file operations for shmem drivers
- * @name: name for the generated structure
- *
- * This macro autogenerates a suitable &struct file_operations for shmem based
- * drivers, which can be assigned to &drm_driver.fops. Note that this structure
- * cannot be shared between drivers, because it contains a reference to the
- * current module using THIS_MODULE.
- *
- * Note that the declaration is already marked as static - if you need a
- * non-static version of this you're probably doing it wrong and will break the
- * THIS_MODULE reference by accident.
- */
-#define DEFINE_DRM_GEM_SHMEM_FOPS(name) \
-	static const struct file_operations name = {\
-		.owner		= THIS_MODULE,\
-		.open		= drm_open,\
-		.release	= drm_release,\
-		.unlocked_ioctl	= drm_ioctl,\
-		.compat_ioctl	= drm_compat_ioctl,\
-		.poll		= drm_poll,\
-		.read		= drm_read,\
-		.llseek		= noop_llseek,\
-		.mmap		= drm_gem_mmap, \
-	}
-
 struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t size);
 void drm_gem_shmem_free_object(struct drm_gem_object *obj);
 
diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/cirrus.c
index 36a69aec8a4b..9438af468331 100644
--- a/drivers/gpu/drm/cirrus/cirrus.c
+++ b/drivers/gpu/drm/cirrus/cirrus.c
@@ -510,7 +510,7 @@ static void cirrus_mode_config_init(struct cirrus_device *cirrus)
 
 /* ------------------------------------------------------------------ */
 
-DEFINE_DRM_GEM_SHMEM_FOPS(cirrus_fops);
+DEFINE_DRM_GEM_FOPS(cirrus_fops);
 
 static struct drm_driver cirrus_driver = {
 	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index b187daa4da85..1c07e1c3386e 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -386,7 +386,7 @@ static const struct drm_ioctl_desc panfrost_drm_driver_ioctls[] = {
 	PANFROST_IOCTL(PERFCNT_DUMP,	perfcnt_dump,	DRM_RENDER_ALLOW),
 };
 
-DEFINE_DRM_GEM_SHMEM_FOPS(panfrost_drm_driver_fops);
+DEFINE_DRM_GEM_FOPS(panfrost_drm_driver_fops);
 
 static struct drm_driver panfrost_drm_driver = {
 	.driver_features	= DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ,
diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index 3506ae2723ae..03e4fbe1b92b 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -169,7 +169,7 @@ v3d_postclose(struct drm_device *dev, struct drm_file *file)
 	kfree(v3d_priv);
 }
 
-DEFINE_DRM_GEM_SHMEM_FOPS(v3d_drm_fops);
+DEFINE_DRM_GEM_FOPS(v3d_drm_fops);
 
 /* DRM_AUTH is required on SUBMIT_CL for now, while we don't have GMP
  * protection between clients.  Note that render nodes would be be
-- 
2.18.1

