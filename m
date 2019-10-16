Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C90FA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F1520854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392839AbfJPLwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:52:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392812AbfJPLwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:52:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AEA0D8980F1;
        Wed, 16 Oct 2019 11:52:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5587B1001B20;
        Wed, 16 Oct 2019 11:52:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8D43731EA4; Wed, 16 Oct 2019 13:52:05 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>,
        linux-kernel@vger.kernel.org (open list),
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU)
Subject: [PATCH v4 11/11] drm/vram: drop DRM_VRAM_MM_FILE_OPERATIONS
Date:   Wed, 16 Oct 2019 13:52:03 +0200
Message-Id: <20191016115203.20095-12-kraxel@redhat.com>
In-Reply-To: <20191016115203.20095-1-kraxel@redhat.com>
References: <20191016115203.20095-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Wed, 16 Oct 2019 11:52:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not needed any more because we don't have vram specific fops
any more.  DEFINE_DRM_GEM_FOPS() can be used instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/drm/drm_gem_vram_helper.h              | 18 ------------------
 drivers/gpu/drm/ast/ast_drv.c                  |  5 +----
 drivers/gpu/drm/bochs/bochs_drv.c              |  5 +----
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |  5 +----
 drivers/gpu/drm/mgag200/mgag200_drv.c          |  5 +----
 drivers/gpu/drm/vboxvideo/vbox_drv.c           |  5 +----
 6 files changed, 5 insertions(+), 38 deletions(-)

diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index 5e48fdac4a1d..b8ad4531ebb4 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -184,22 +184,4 @@ struct drm_vram_mm *drm_vram_helper_alloc_mm(
 	struct drm_device *dev, uint64_t vram_base, size_t vram_size);
 void drm_vram_helper_release_mm(struct drm_device *dev);
 
-/**
- * define DRM_VRAM_MM_FILE_OPERATIONS - default callback functions for \
-	&struct file_operations
- *
- * Drivers that use VRAM MM can use this macro to initialize
- * &struct file_operations with default functions.
- */
-#define DRM_VRAM_MM_FILE_OPERATIONS \
-	.llseek		= no_llseek, \
-	.read		= drm_read, \
-	.poll		= drm_poll, \
-	.unlocked_ioctl = drm_ioctl, \
-	.compat_ioctl	= drm_compat_ioctl, \
-	.mmap		= drm_gem_mmap, \
-	.open		= drm_open, \
-	.release	= drm_release \
-
-
 #endif
diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
index e0e8770462bc..1f17794b0890 100644
--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -200,10 +200,7 @@ static struct pci_driver ast_pci_driver = {
 	.driver.pm = &ast_pm_ops,
 };
 
-static const struct file_operations ast_fops = {
-	.owner = THIS_MODULE,
-	DRM_VRAM_MM_FILE_OPERATIONS
-};
+DEFINE_DRM_GEM_FOPS(ast_fops);
 
 static struct drm_driver driver = {
 	.driver_features = DRIVER_MODESET | DRIVER_GEM,
diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index 3b9b0d9bbc14..10460878414e 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -58,10 +58,7 @@ static int bochs_load(struct drm_device *dev)
 	return ret;
 }
 
-static const struct file_operations bochs_fops = {
-	.owner		= THIS_MODULE,
-	DRM_VRAM_MM_FILE_OPERATIONS
-};
+DEFINE_DRM_GEM_FOPS(bochs_fops);
 
 static struct drm_driver bochs_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 4f52c83b9b4c..2fd4ca91a62d 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -26,10 +26,7 @@
 #include "hibmc_drm_drv.h"
 #include "hibmc_drm_regs.h"
 
-static const struct file_operations hibmc_fops = {
-	.owner		= THIS_MODULE,
-	DRM_VRAM_MM_FILE_OPERATIONS
-};
+DEFINE_DRM_GEM_FOPS(hibmc_fops);
 
 static irqreturn_t hibmc_drm_interrupt(int irq, void *arg)
 {
diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag200/mgag200_drv.c
index 4f9df3b93598..397f8b0a9af8 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.c
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
@@ -58,10 +58,7 @@ static void mga_pci_remove(struct pci_dev *pdev)
 	drm_put_dev(dev);
 }
 
-static const struct file_operations mgag200_driver_fops = {
-	.owner = THIS_MODULE,
-	DRM_VRAM_MM_FILE_OPERATIONS
-};
+DEFINE_DRM_GEM_FOPS(mgag200_driver_fops);
 
 static struct drm_driver driver = {
 	.driver_features = DRIVER_GEM | DRIVER_MODESET,
diff --git a/drivers/gpu/drm/vboxvideo/vbox_drv.c b/drivers/gpu/drm/vboxvideo/vbox_drv.c
index 6ee308b453da..8512d970a09f 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_drv.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_drv.c
@@ -181,10 +181,7 @@ static struct pci_driver vbox_pci_driver = {
 #endif
 };
 
-static const struct file_operations vbox_fops = {
-	.owner = THIS_MODULE,
-	DRM_VRAM_MM_FILE_OPERATIONS
-};
+DEFINE_DRM_GEM_FOPS(vbox_fops);
 
 static struct drm_driver driver = {
 	.driver_features =
-- 
2.18.1

