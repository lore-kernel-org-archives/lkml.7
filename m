Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974E5C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EB82171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733240AbfHHNoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:44:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6607 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733223AbfHHNoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:44:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5AA3E30832E1;
        Thu,  8 Aug 2019 13:44:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-144.ams2.redhat.com [10.36.116.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2ADDA60BE1;
        Thu,  8 Aug 2019 13:44:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 7678F9D00; Thu,  8 Aug 2019 15:44:18 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 02/17] drm/ttm: add gem_ttm_bo_device_init()
Date:   Thu,  8 Aug 2019 15:44:02 +0200
Message-Id: <20190808134417.10610-3-kraxel@redhat.com>
In-Reply-To: <20190808134417.10610-1-kraxel@redhat.com>
References: <20190808134417.10610-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 08 Aug 2019 13:44:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now with ttm_buffer_object being a subclass of drm_gem_object we can
easily lookup ttm_buffer_object for a given drm_gem_object, which in
turm allows to create common helper functions.

This patch starts off with a gem_ttm_bo_device_init() helper function
which initializes ttm with the vma offset manager used by gem, to make
sure gem and ttm have the same view on vma offsets.

With that in place gem+ttm drivers don't need their private
drm_driver.dumb_map_offset implementation any more.

v3:
 - complete rewrite

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem_ttm_helper.h     | 30 +++++++++++++++++++++++
 drivers/gpu/drm/drm_gem_ttm_helper.c | 36 ++++++++++++++++++++++++++++
 Documentation/gpu/drm-mm.rst         | 12 ++++++++++
 drivers/gpu/drm/Kconfig              |  7 ++++++
 drivers/gpu/drm/Makefile             |  3 +++
 5 files changed, 88 insertions(+)
 create mode 100644 include/drm/drm_gem_ttm_helper.h
 create mode 100644 drivers/gpu/drm/drm_gem_ttm_helper.c

diff --git a/include/drm/drm_gem_ttm_helper.h b/include/drm/drm_gem_ttm_helper.h
new file mode 100644
index 000000000000..43c9db3583cc
--- /dev/null
+++ b/include/drm/drm_gem_ttm_helper.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef DRM_GEM_TTM_HELPER_H
+#define DRM_GEM_TTM_HELPER_H
+
+#include <linux/kernel.h>
+
+#include <drm/drm_gem.h>
+#include <drm/drm_device.h>
+#include <drm/ttm/ttm_bo_api.h>
+#include <drm/ttm/ttm_bo_driver.h>
+
+/**
+ * Returns the container of type &struct ttm_buffer_object
+ * for field base.
+ * @gem:	the GEM object
+ * Returns:	The containing GEM VRAM object
+ */
+static inline struct ttm_buffer_object *drm_gem_ttm_of_gem(
+	struct drm_gem_object *gem)
+{
+	return container_of(gem, struct ttm_buffer_object, base);
+}
+
+int drm_gem_ttm_bo_device_init(struct drm_device *dev,
+			       struct ttm_bo_device *bdev,
+			       struct ttm_bo_driver *driver,
+			       bool need_dma32);
+
+#endif
diff --git a/drivers/gpu/drm/drm_gem_ttm_helper.c b/drivers/gpu/drm/drm_gem_ttm_helper.c
new file mode 100644
index 000000000000..0c57e9fd50b9
--- /dev/null
+++ b/drivers/gpu/drm/drm_gem_ttm_helper.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <drm/drm_gem_ttm_helper.h>
+
+/**
+ * DOC: overview
+ *
+ * This library provides helper functions for gem objects backed by
+ * ttm.
+ */
+
+/**
+ * drm_gem_ttm_bo_device_init - ttm init for devices which use gem+ttm
+ *
+ * @dev: A pointer to a struct drm_device.
+ * @bdev: A pointer to a struct ttm_bo_device to initialize.
+ * @driver: A pointer to a struct ttm_bo_driver set up by the caller.
+ * @need_dma32: Whenever the device is limited to 32bit DMA.
+ *
+ * This initializes ttm with dev->vma_offset_manager, so gem and ttm
+ * fuction are working with the same vma_offset_manager.
+ *
+ * Returns:
+ * !0: Failure.
+ */
+int drm_gem_ttm_bo_device_init(struct drm_device *dev,
+			       struct ttm_bo_device *bdev,
+			       struct ttm_bo_driver *driver,
+			       bool need_dma32)
+{
+	return ttm_bo_device_init_with_vma_manager(bdev, driver,
+						   dev->anon_inode->i_mapping,
+						   dev->vma_offset_manager,
+						   need_dma32);
+}
+EXPORT_SYMBOL(drm_gem_ttm_bo_device_init);
diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rst
index b664f054c259..a70a1d9f30ec 100644
--- a/Documentation/gpu/drm-mm.rst
+++ b/Documentation/gpu/drm-mm.rst
@@ -412,6 +412,18 @@ VRAM MM Helper Functions Reference
 .. kernel-doc:: drivers/gpu/drm/drm_vram_mm_helper.c
    :export:
 
+GEM TTM Helper Functions Reference
+-----------------------------------
+
+.. kernel-doc:: drivers/gpu/drm/drm_gem_ttm_helper.c
+   :doc: overview
+
+.. kernel-doc:: include/drm/drm_gem_ttm_helper.h
+   :internal:
+
+.. kernel-doc:: drivers/gpu/drm/drm_gem_ttm_helper.c
+   :export:
+
 VMA Offset Manager
 ==================
 
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index e6f40fb54c9a..f7b25519f95c 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -172,6 +172,13 @@ config DRM_VRAM_HELPER
 	help
 	  Helpers for VRAM memory management
 
+config DRM_TTM_HELPER
+	tristate
+	depends on DRM
+	select DRM_TTM
+	help
+	  Helpers for ttm-based gem objects
+
 config DRM_GEM_CMA_HELPER
 	bool
 	depends on DRM
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 10f8329a8b71..545c61d6528b 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -37,6 +37,9 @@ drm_vram_helper-y := drm_gem_vram_helper.o \
 		     drm_vram_mm_helper.o
 obj-$(CONFIG_DRM_VRAM_HELPER) += drm_vram_helper.o
 
+drm_ttm_helper-y := drm_gem_ttm_helper.o
+obj-$(CONFIG_DRM_TTM_HELPER) += drm_ttm_helper.o
+
 drm_kms_helper-y := drm_crtc_helper.o drm_dp_helper.o drm_dsc.o drm_probe_helper.o \
 		drm_plane_helper.o drm_dp_mst_topology.o drm_atomic_helper.o \
 		drm_kms_helper_common.o drm_dp_dual_mode_helper.o \
-- 
2.18.1

