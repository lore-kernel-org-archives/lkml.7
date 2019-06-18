Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06961C31E5C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75AD2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hy5AZnnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfFRCmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 22:42:40 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40438 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfFRCmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 22:42:39 -0400
Received: by mail-qk1-f194.google.com with SMTP id c70so7587466qkg.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 19:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wlec/cQbN79ilcIA62j7ETPEXuZxM1Vl8+YGK7vicPE=;
        b=hy5AZnnj9Sy8oB42uxpu7r94T6qFPTL3bdSzfGdNl8zDRTzuOIiSMNibJYltHAC4cZ
         brA8MYlM3Xqz4B6k4FuYlKDKDoZzRQpYjlPZWjXqGoU6c+QbRTdHRhm8Tz1NXjDPAhiJ
         QpN2QTHVDPwH5T22gJ/H28P6Yl+U0027z0t9hO/uLwfvD4LCvjAEP6PxYzwXD9nxxpwo
         u+qsF6jc+Sah6VQNhZnjwg485T+zUWv8cP5aMlGemK0gITwQZyntGGSXX9fe6PLpgN/R
         TU43u/cN/V4snL1j8FTgxd2BYE+Ylp5S/hvp2Do69nanA1szjJziLjV3HeXikt9RXFRR
         gjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wlec/cQbN79ilcIA62j7ETPEXuZxM1Vl8+YGK7vicPE=;
        b=umAsWq7hdLcl3vMEPZwBmtUTgYyFNZEPsvUXvrfipVWPB11sHheXBdBr58+nPWTWzx
         mlg5Lx0hwi6mTGHDFkzDmW9bmv3fe8fibC9DsAGd4TzOTpLHpyJBa0f06UWnOkjRwXE3
         ZccRiWnmvJxAdfcdq2zXr8GgqS4BXK9TPYWLSfyYCAwEUsdzDMDrT5VRMEqqpPrtl21o
         qLKV7xueEYCtboJFRlZaoEd022FJ0xtcfl+H19RFVaFFKJtatV3zODGrx/9dubFCSO/R
         za0NNLrTcVxnB3X4JvJkTGiR2u9pgOSCUbrg/TamA5skkyve+lPAO5qJ2UwcrtD2CIKM
         2eWw==
X-Gm-Message-State: APjAAAVpGOf5Xib6bb3oOGGt+1Q+prwTPiiTHrlKQ9WiPn4Ax4x7JHmf
        /WMSCHBGaVRVxY4bcPGSmb0=
X-Google-Smtp-Source: APXvYqzM6+yNmUJHDTr+5nEzxYhCkjXT7NgLVxCRPMrG8gTEANWEl/fG67mArrfESOV53aARSBl54g==
X-Received: by 2002:ae9:ed0a:: with SMTP id c10mr89412855qkg.207.1560825758284;
        Mon, 17 Jun 2019 19:42:38 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.146])
        by smtp.gmail.com with ESMTPSA id c16sm2678549qke.43.2019.06.17.19.42.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 19:42:37 -0700 (PDT)
Date:   Mon, 17 Jun 2019 23:42:33 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/5] drm/vkms: Move functions from vkms_crc to
 vkms_composer
Message-ID: <408a662d504db1cfe13919688a4e9f7f7a6d8489.1560820888.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1560820888.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1560820888.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vkms_crc file has functions related to compose operations which are
not directly associated with CRC. This patch, move those function for a
new file named vkms_composer.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/vkms/Makefile        |  9 +++-
 drivers/gpu/drm/vkms/vkms_composer.c | 69 ++++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_composer.h | 12 +++++
 drivers/gpu/drm/vkms/vkms_crc.c      | 65 +-------------------------
 4 files changed, 90 insertions(+), 65 deletions(-)
 create mode 100644 drivers/gpu/drm/vkms/vkms_composer.c
 create mode 100644 drivers/gpu/drm/vkms/vkms_composer.h

diff --git a/drivers/gpu/drm/vkms/Makefile b/drivers/gpu/drm/vkms/Makefile
index 89f09bec7b23..b4c040854bd6 100644
--- a/drivers/gpu/drm/vkms/Makefile
+++ b/drivers/gpu/drm/vkms/Makefile
@@ -1,4 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
-vkms-y := vkms_drv.o vkms_plane.o vkms_output.o vkms_crtc.o vkms_gem.o vkms_crc.o
+vkms-y := \
+	vkms_drv.o \
+	vkms_plane.o \
+	vkms_output.o \
+	vkms_crtc.o \
+	vkms_gem.o \
+	vkms_composer.o \
+	vkms_crc.o
 
 obj-$(CONFIG_DRM_VKMS) += vkms.o
diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
new file mode 100644
index 000000000000..3d7c5e316d6e
--- /dev/null
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "vkms_drv.h"
+#include "vkms_composer.h"
+#include <drm/drm_gem_framebuffer_helper.h>
+
+/**
+ * blend - belnd value at vaddr_src with value at vaddr_dst
+ * @vaddr_dst: destination address
+ * @vaddr_src: source address
+ * @dest: destination framebuffer's metadata
+ * @src: source framebuffer's metadata
+ *
+ * Blend value at vaddr_src with value at vaddr_dst.
+ * Currently, this function write value at vaddr_src on value
+ * at vaddr_dst using buffer's metadata to locate the new values
+ * from vaddr_src and their distenation at vaddr_dst.
+ *
+ * Todo: Use the alpha value to blend vaddr_src with vaddr_dst
+ *	 instead of overwriting it.
+ */
+void blend(void *vaddr_dst, void *vaddr_src, struct vkms_crc_data *dest,
+	   struct vkms_crc_data *src)
+{
+	int i, j, j_dst, i_dst;
+	int offset_src, offset_dst;
+
+	int x_src = src->src.x1 >> 16;
+	int y_src = src->src.y1 >> 16;
+
+	int x_dst = src->dst.x1;
+	int y_dst = src->dst.y1;
+	int h_dst = drm_rect_height(&src->dst);
+	int w_dst = drm_rect_width(&src->dst);
+
+	int y_limit = y_src + h_dst;
+	int x_limit = x_src + w_dst;
+
+	for (i = y_src, i_dst = y_dst; i < y_limit; ++i) {
+		for (j = x_src, j_dst = x_dst; j < x_limit; ++j) {
+			offset_dst = dest->offset
+				     + (i_dst * dest->pitch)
+				     + (j_dst++ * dest->cpp);
+			offset_src = src->offset
+				     + (i * src->pitch)
+				     + (j * src->cpp);
+
+			memcpy(vaddr_dst + offset_dst,
+			       vaddr_src + offset_src, sizeof(u32));
+		}
+		i_dst++;
+	}
+}
+
+void compose_cursor(struct vkms_crc_data *cursor,
+		    struct vkms_crc_data *primary, void *vaddr_out)
+{
+	struct drm_gem_object *cursor_obj;
+	struct vkms_gem_object *cursor_vkms_obj;
+
+	cursor_obj = drm_gem_fb_get_obj(&cursor->fb, 0);
+	cursor_vkms_obj = drm_gem_to_vkms_gem(cursor_obj);
+
+	if (WARN_ON(!cursor_vkms_obj->vaddr))
+		return;
+
+	blend(vaddr_out, cursor_vkms_obj->vaddr, primary, cursor);
+}
+
diff --git a/drivers/gpu/drm/vkms/vkms_composer.h b/drivers/gpu/drm/vkms/vkms_composer.h
new file mode 100644
index 000000000000..53fdee17a632
--- /dev/null
+++ b/drivers/gpu/drm/vkms/vkms_composer.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _VKMS_COMPOSER_H_
+#define _VKMS_COMPOSER_H_
+
+void blend(void *vaddr_dst, void *vaddr_src, struct vkms_crc_data *dest,
+	   struct vkms_crc_data *src);
+
+void compose_cursor(struct vkms_crc_data *cursor,
+		    struct vkms_crc_data *primary, void *vaddr_out);
+
+#endif /* _VKMS_COMPOSER_H_ */
diff --git a/drivers/gpu/drm/vkms/vkms_crc.c b/drivers/gpu/drm/vkms/vkms_crc.c
index 4b3146d83265..3c6a35aba494 100644
--- a/drivers/gpu/drm/vkms/vkms_crc.c
+++ b/drivers/gpu/drm/vkms/vkms_crc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include "vkms_drv.h"
+#include "vkms_composer.h"
 #include <linux/crc32.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
@@ -39,70 +40,6 @@ static uint32_t compute_crc(void *vaddr_out, struct vkms_crc_data *crc_out)
 	return crc;
 }
 
-/**
- * blend - belnd value at vaddr_src with value at vaddr_dst
- * @vaddr_dst: destination address
- * @vaddr_src: source address
- * @crc_dst: destination framebuffer's metadata
- * @crc_src: source framebuffer's metadata
- *
- * Blend value at vaddr_src with value at vaddr_dst.
- * Currently, this function write value at vaddr_src on value
- * at vaddr_dst using buffer's metadata to locate the new values
- * from vaddr_src and their distenation at vaddr_dst.
- *
- * Todo: Use the alpha value to blend vaddr_src with vaddr_dst
- *	 instead of overwriting it.
- */
-static void blend(void *vaddr_dst, void *vaddr_src,
-		  struct vkms_crc_data *crc_dst,
-		  struct vkms_crc_data *crc_src)
-{
-	int i, j, j_dst, i_dst;
-	int offset_src, offset_dst;
-
-	int x_src = crc_src->src.x1 >> 16;
-	int y_src = crc_src->src.y1 >> 16;
-
-	int x_dst = crc_src->dst.x1;
-	int y_dst = crc_src->dst.y1;
-	int h_dst = drm_rect_height(&crc_src->dst);
-	int w_dst = drm_rect_width(&crc_src->dst);
-
-	int y_limit = y_src + h_dst;
-	int x_limit = x_src + w_dst;
-
-	for (i = y_src, i_dst = y_dst; i < y_limit; ++i) {
-		for (j = x_src, j_dst = x_dst; j < x_limit; ++j) {
-			offset_dst = crc_dst->offset
-				     + (i_dst * crc_dst->pitch)
-				     + (j_dst++ * crc_dst->cpp);
-			offset_src = crc_src->offset
-				     + (i * crc_src->pitch)
-				     + (j * crc_src->cpp);
-
-			memcpy(vaddr_dst + offset_dst,
-			       vaddr_src + offset_src, sizeof(u32));
-		}
-		i_dst++;
-	}
-}
-
-static void compose_cursor(struct vkms_crc_data *cursor_crc,
-			   struct vkms_crc_data *primary_crc, void *vaddr_out)
-{
-	struct drm_gem_object *cursor_obj;
-	struct vkms_gem_object *cursor_vkms_obj;
-
-	cursor_obj = drm_gem_fb_get_obj(&cursor_crc->fb, 0);
-	cursor_vkms_obj = drm_gem_to_vkms_gem(cursor_obj);
-
-	if (WARN_ON(!cursor_vkms_obj->vaddr))
-		return;
-
-	blend(vaddr_out, cursor_vkms_obj->vaddr, primary_crc, cursor_crc);
-}
-
 static uint32_t _vkms_get_crc(struct vkms_crc_data *primary_crc,
 			      struct vkms_crc_data *cursor_crc)
 {
-- 
2.21.0
