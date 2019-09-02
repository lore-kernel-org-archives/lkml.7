Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB6EC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8A5216C8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbfIBMll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 08:41:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729984AbfIBMlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:41:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 076313086268;
        Mon,  2 Sep 2019 12:41:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-67.ams2.redhat.com [10.36.117.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D868F1001B01;
        Mon,  2 Sep 2019 12:41:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3263831EBF; Mon,  2 Sep 2019 14:41:27 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/5] drm/vram: add vram-mm debugfs file
Date:   Mon,  2 Sep 2019 14:41:24 +0200
Message-Id: <20190902124126.7700-4-kraxel@redhat.com>
In-Reply-To: <20190902124126.7700-1-kraxel@redhat.com>
References: <20190902124126.7700-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 02 Sep 2019 12:41:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up drm_mm_print() for vram helpers, using a new
debugfs file, so one can see how vram is used:

   # cat /sys/kernel/debug/dri/0/vram-mm
   0x0000000000000000-0x0000000000000300: 768: used
   0x0000000000000300-0x0000000000000600: 768: used
   0x0000000000000600-0x0000000000000900: 768: used
   0x0000000000000900-0x0000000000000c00: 768: used
   0x0000000000000c00-0x0000000000004000: 13312: free
   total: 16384, used 3072 free 13312

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem_vram_helper.h    |  1 +
 include/drm/drm_vram_mm_helper.h     |  1 +
 drivers/gpu/drm/drm_vram_mm_helper.c | 33 ++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index 17f160dd6e7d..d48fdf90b254 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -123,6 +123,7 @@ int drm_gem_vram_driver_dumb_mmap_offset(struct drm_file *file,
  * &struct drm_driver with default functions.
  */
 #define DRM_GEM_VRAM_DRIVER \
+	.debugfs_init             = drm_vram_mm_debugfs_init, \
 	.dumb_create		  = drm_gem_vram_driver_dumb_create, \
 	.dumb_map_offset	  = drm_gem_vram_driver_dumb_mmap_offset, \
 	.gem_prime_mmap		  = drm_gem_prime_mmap
diff --git a/include/drm/drm_vram_mm_helper.h b/include/drm/drm_vram_mm_helper.h
index 2aacfb1ccfae..9e0ac9aaac7d 100644
--- a/include/drm/drm_vram_mm_helper.h
+++ b/include/drm/drm_vram_mm_helper.h
@@ -60,6 +60,7 @@ static inline struct drm_vram_mm *drm_vram_mm_of_bdev(
 	return container_of(bdev, struct drm_vram_mm, bdev);
 }
 
+int drm_vram_mm_debugfs_init(struct drm_minor *minor);
 int drm_vram_mm_init(struct drm_vram_mm *vmm, struct drm_device *dev,
 		     uint64_t vram_base, size_t vram_size,
 		     const struct drm_vram_mm_funcs *funcs);
diff --git a/drivers/gpu/drm/drm_vram_mm_helper.c b/drivers/gpu/drm/drm_vram_mm_helper.c
index c911781d6728..486061b83a73 100644
--- a/drivers/gpu/drm/drm_vram_mm_helper.c
+++ b/drivers/gpu/drm/drm_vram_mm_helper.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#include <drm/drm_debugfs.h>
 #include <drm/drm_device.h>
 #include <drm/drm_file.h>
+#include <drm/drm_gem_ttm_helper.h>
 #include <drm/drm_vram_mm_helper.h>
 
 #include <drm/ttm/ttm_page_alloc.h>
@@ -148,6 +150,37 @@ static struct ttm_bo_driver bo_driver = {
  * struct drm_vram_mm
  */
 
+#if defined(CONFIG_DEBUG_FS)
+static int drm_vram_mm_debugfs(struct seq_file *m, void *data)
+{
+	struct drm_info_node *node = (struct drm_info_node *) m->private;
+	struct drm_vram_mm *vmm = node->minor->dev->vram_mm;
+	struct drm_mm *mm = vmm->bdev.man[TTM_PL_VRAM].priv;
+	struct ttm_bo_global *glob = vmm->bdev.glob;
+	struct drm_printer p = drm_seq_file_printer(m);
+
+	spin_lock(&glob->lru_lock);
+	drm_mm_print(mm, &p);
+	spin_unlock(&glob->lru_lock);
+	return 0;
+}
+
+static struct drm_info_list drm_vram_mm_debugfs_list[] = {
+	{ "vram-mm", drm_vram_mm_debugfs, 0, NULL },
+};
+#endif
+
+int drm_vram_mm_debugfs_init(struct drm_minor *minor)
+{
+#if defined(CONFIG_DEBUG_FS)
+	drm_debugfs_create_files(drm_vram_mm_debugfs_list,
+				 ARRAY_SIZE(drm_vram_mm_debugfs_list),
+				 minor->debugfs_root, minor);
+#endif
+	return 0;
+}
+EXPORT_SYMBOL(drm_vram_mm_debugfs_init);
+
 /**
  * drm_vram_mm_init() - Initialize an instance of VRAM MM.
  * @vmm:	the VRAM MM instance to initialize
-- 
2.18.1

