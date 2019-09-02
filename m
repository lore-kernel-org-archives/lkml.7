Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62215C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DDA217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbfIBMld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 08:41:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730311AbfIBMlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:41:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3414C81F0E;
        Mon,  2 Sep 2019 12:41:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-67.ams2.redhat.com [10.36.117.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C87AD5C207;
        Mon,  2 Sep 2019 12:41:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D6AC431EAD; Mon,  2 Sep 2019 14:41:26 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/5] drm/ttm: add drm_gem_ttm_print_info()
Date:   Mon,  2 Sep 2019 14:41:22 +0200
Message-Id: <20190902124126.7700-2-kraxel@redhat.com>
In-Reply-To: <20190902124126.7700-1-kraxel@redhat.com>
References: <20190902124126.7700-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 02 Sep 2019 12:41:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now with ttm_buffer_object being a subclass of drm_gem_object we can
easily lookup ttm_buffer_object for a given drm_gem_object, which in
turm allows to create common helper functions.

This patch starts off with a drm_gem_ttm_print_info() helper function
which prints adds some ttm specific lines to the debug output.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem_ttm_helper.h     | 19 ++++++++
 drivers/gpu/drm/drm_gem_ttm_helper.c | 67 ++++++++++++++++++++++++++++
 Documentation/gpu/drm-mm.rst         | 12 +++++
 drivers/gpu/drm/Kconfig              |  7 +++
 drivers/gpu/drm/Makefile             |  3 ++
 5 files changed, 108 insertions(+)
 create mode 100644 include/drm/drm_gem_ttm_helper.h
 create mode 100644 drivers/gpu/drm/drm_gem_ttm_helper.c

diff --git a/include/drm/drm_gem_ttm_helper.h b/include/drm/drm_gem_ttm_helper.h
new file mode 100644
index 000000000000..6268f89c5a48
--- /dev/null
+++ b/include/drm/drm_gem_ttm_helper.h
@@ -0,0 +1,19 @@
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
+#define drm_gem_ttm_of_gem(gem_obj) \
+	container_of(gem_obj, struct ttm_buffer_object, base)
+
+void drm_gem_ttm_print_info(struct drm_printer *p, unsigned int indent,
+			    const struct drm_gem_object *gem);
+
+#endif
diff --git a/drivers/gpu/drm/drm_gem_ttm_helper.c b/drivers/gpu/drm/drm_gem_ttm_helper.c
new file mode 100644
index 000000000000..cd6ac2cc8fdd
--- /dev/null
+++ b/drivers/gpu/drm/drm_gem_ttm_helper.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/module.h>
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
+ * drm_gem_ttm_print_info() - Print &ttm_buffer_object info for debugfs
+ * @p: DRM printer
+ * @indent: Tab indentation level
+ * @gem: GEM object
+ *
+ * This function can be used as the &drm_driver->gem_print_info callback.
+ */
+void drm_gem_ttm_print_info(struct drm_printer *p, unsigned int indent,
+			    const struct drm_gem_object *gem)
+{
+	static const char *plname[] = {
+		[ TTM_PL_SYSTEM ] = "system",
+		[ TTM_PL_TT     ] = "tt",
+		[ TTM_PL_VRAM   ] = "vram",
+		[ TTM_PL_PRIV   ] = "priv",
+
+		[ 16 ]            = "cached",
+		[ 17 ]            = "uncached",
+		[ 18 ]            = "wc",
+		[ 19 ]            = "contig",
+
+		[ 21 ]            = "pinned", /* NO_EVICT */
+		[ 22 ]            = "topdown",
+	};
+	const struct ttm_buffer_object *bo = drm_gem_ttm_of_gem(gem);
+	bool first = true;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(plname); i++) {
+		if (!(bo->mem.placement & (1 << i)))
+			continue;
+		if (!plname[i])
+			continue;
+		if (first) {
+			first = false;
+			drm_printf_indent(p, indent, "placement=%s", plname[i]);
+		} else
+			drm_printf(p, ",%s", plname[i]);
+	}
+	if (!first)
+		drm_printf(p, "\n");
+
+	if (bo->mem.bus.is_iomem) {
+		drm_printf_indent(p, indent, "bus.base=%lx\n",
+				  (unsigned long)bo->mem.bus.base);
+		drm_printf_indent(p, indent, "bus.offset=%lx\n",
+				  (unsigned long)bo->mem.bus.offset);
+	}
+}
+EXPORT_SYMBOL(drm_gem_ttm_print_info);
+
+MODULE_DESCRIPTION("DRM gem ttm helpers");
+MODULE_LICENSE("GPL");
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

