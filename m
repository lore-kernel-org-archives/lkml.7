Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC27C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE7E2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbfFSJEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 05:04:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731389AbfFSJE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 05:04:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A74C830C0DE3;
        Wed, 19 Jun 2019 09:04:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-86.ams2.redhat.com [10.36.116.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFE985D9D6;
        Wed, 19 Jun 2019 09:04:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 018E416E1A; Wed, 19 Jun 2019 11:04:21 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 01/12] drm: add gem array helpers
Date:   Wed, 19 Jun 2019 11:04:09 +0200
Message-Id: <20190619090420.6667-2-kraxel@redhat.com>
In-Reply-To: <20190619090420.6667-1-kraxel@redhat.com>
References: <20190619090420.6667-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 19 Jun 2019 09:04:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add struct and helper functions to manage an array of gem objects.
See added kernel docs for details.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem_array_helper.h     | 15 +++++
 drivers/gpu/drm/drm_gem_array_helper.c | 76 ++++++++++++++++++++++++++
 drivers/gpu/drm/Makefile               |  3 +-
 3 files changed, 93 insertions(+), 1 deletion(-)
 create mode 100644 include/drm/drm_gem_array_helper.h
 create mode 100644 drivers/gpu/drm/drm_gem_array_helper.c

diff --git a/include/drm/drm_gem_array_helper.h b/include/drm/drm_gem_array_helper.h
new file mode 100644
index 000000000000..adf7961247b3
--- /dev/null
+++ b/include/drm/drm_gem_array_helper.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DRM_GEM_ARRAY_HELPER_H__
+#define __DRM_GEM_ARRAY_HELPER_H__
+
+struct drm_gem_object_array {
+	u32 nents;
+	struct drm_gem_object *objs[];
+};
+
+struct drm_gem_object_array *drm_gem_array_alloc(u32 nents);
+struct drm_gem_object_array *
+drm_gem_array_from_handles(struct drm_file *drm_file, u32 *handles, u32 nents);
+void drm_gem_array_put_free(struct drm_gem_object_array *objs);
+
+#endif /* __DRM_GEM_ARRAY_HELPER_H__ */
diff --git a/drivers/gpu/drm/drm_gem_array_helper.c b/drivers/gpu/drm/drm_gem_array_helper.c
new file mode 100644
index 000000000000..d35c77c4a02d
--- /dev/null
+++ b/drivers/gpu/drm/drm_gem_array_helper.c
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <drm/drm_gem.h>
+#include <drm/drm_gem_array_helper.h>
+
+/**
+ * drm_gem_array_alloc -- allocate gem object array of the given size.
+ *
+ * @nents: number of entries needed.
+ *
+ * Returns: An array of gem objects on success, NULL on failure.
+ */
+struct drm_gem_object_array *drm_gem_array_alloc(u32 nents)
+{
+	struct drm_gem_object_array *objs;
+	size_t size = sizeof(*objs) + sizeof(objs->objs[0]) * nents;
+
+	objs = kzalloc(size, GFP_KERNEL);
+	if (!objs)
+		return NULL;
+
+	objs->nents = nents;
+	return objs;
+}
+EXPORT_SYMBOL(drm_gem_array_alloc);
+
+static void drm_gem_array_free(struct drm_gem_object_array *objs)
+{
+	kfree(objs);
+}
+
+/**
+ * drm_gem_array_from_handles -- lookup an array of gem handles.
+ *
+ * @drm_file: drm file-private structure to use for the handle look up
+ * @handles: the array of handles to lookup.
+ * @nents: the numer of handles.
+ *
+ * Returns: An array of gem objects on success, NULL on failure.
+ */
+struct drm_gem_object_array*
+drm_gem_array_from_handles(struct drm_file *drm_file, u32 *handles, u32 nents)
+{
+	struct drm_gem_object_array *objs;
+	u32 i;
+
+	objs = drm_gem_array_alloc(nents);
+	if (!objs)
+		return NULL;
+
+	for (i = 0; i < nents; i++) {
+		objs->objs[i] = drm_gem_object_lookup(drm_file, handles[i]);
+		if (!objs->objs[i]) {
+			drm_gem_array_put_free(objs);
+			return NULL;
+		}
+	}
+	return objs;
+}
+
+/**
+ * drm_gem_array_put_free -- put gem objects and free array.
+ *
+ * @objs: the gem object array.
+ */
+void drm_gem_array_put_free(struct drm_gem_object_array *objs)
+{
+	u32 i;
+
+	for (i = 0; i < objs->nents; i++) {
+		if (!objs->objs[i])
+			continue;
+		drm_gem_object_put_unlocked(objs->objs[i]);
+	}
+	drm_gem_array_free(objs);
+}
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 9d630a28a788..d32e7de0937b 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -43,7 +43,8 @@ drm_kms_helper-y := drm_crtc_helper.o drm_dp_helper.o drm_dsc.o drm_probe_helper
 		drm_simple_kms_helper.o drm_modeset_helper.o \
 		drm_scdc_helper.o drm_gem_framebuffer_helper.o \
 		drm_atomic_state_helper.o drm_damage_helper.o \
-		drm_format_helper.o drm_self_refresh_helper.o
+		drm_format_helper.o drm_self_refresh_helper.o \
+		drm_gem_array_helper.o
 
 drm_kms_helper-$(CONFIG_DRM_PANEL_BRIDGE) += bridge/panel.o
 drm_kms_helper-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fb_helper.o
-- 
2.18.1

