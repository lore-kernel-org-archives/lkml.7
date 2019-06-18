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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DC2C31E5C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4422089E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X91k3au1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfFRCpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 22:45:11 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42532 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFRCpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 22:45:11 -0400
Received: by mail-qt1-f196.google.com with SMTP id s15so13455545qtk.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 19:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dz+adBAPcE8qvI07dIqlmwVAtO9T/l0uCjfq3X+Fk/0=;
        b=X91k3au1269cF7ErYx0NeCBvM6Ah0m0bDU7zwKjf9avUFYCLESFuLlk50/D/RXeMrq
         /2JqZMG6vphcLLXpmpj7NL/cqGdkqb7iW2BegoVcKGGBxeKZOJ2pLa4JyEQ4H6hjgvAS
         cWsSgShoCGCRcVYm427tx+zNjoUEmqLGNSd3f47ki00cNIFvKAWXIVT+2sh3PNYFh2et
         +PMWhmS9gW5l9hhQVWyysSWGBAUBxlrWv6babpojIUT2dcJeG1lsuTiPtmZ/zX0tH0yy
         2K73o0BPF08IiR5PgonZfbavnNvLw7lwvbqe0RWKbLEw21tt6mO2fyIv/jguuwBxWGNf
         2jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dz+adBAPcE8qvI07dIqlmwVAtO9T/l0uCjfq3X+Fk/0=;
        b=WGemw/6NhDNd+GZP8MGD0qjSXMbEGV3ohZMSjYNEnwgczL7956Jt5Nl4ZYPgJMJxLC
         J8J8WAi6E9OlaWNr4/ALoJkV13LEXRJfYKTy/ItBma9eB/w25cAn5hG27uBVMj+ofYhk
         DHaaey/RQKZdB64lv7OWCHTwQliwf8OPQegBg3HFb2csxfAq3jV9sgcL4xEHGpwKqMn6
         8yhMKuB4pr+ftrdwOgQAEVzn/mb2IzqQ+o9FXTGqpRk6umEDltRr5zEBvXTDQsfaNOqH
         RYiXTOKbBRMc4E+I7kzV0QyiNrD1MHzjx3C4iXFl9D4EZptmLZluxaGrCPh+zL/8jbUi
         la7g==
X-Gm-Message-State: APjAAAVrKdaV19qqGDvZnfuvnDnHaf11elAEjo0XJt6m/aCR4x3OLwbu
        Pu7Z9dGR8CE/RSuLAWVCf9E=
X-Google-Smtp-Source: APXvYqzmE+SzilO07+hRB3nGbI8Xd8fV9brHpP1GekfSwiVKCc/8Z3fUrjCU/xxXQkeq3u3A+VAEuA==
X-Received: by 2002:ad4:5426:: with SMTP id g6mr24791223qvt.132.1560825909669;
        Mon, 17 Jun 2019 19:45:09 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.146])
        by smtp.gmail.com with ESMTPSA id f68sm8133745qtb.83.2019.06.17.19.45.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 19:45:09 -0700 (PDT)
Date:   Mon, 17 Jun 2019 23:45:04 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/5] drm/vkms: Rename vkms_crc_data to vkms_data
Message-ID: <0de57ac2d1eedf412d579796a2efedab26af7bf0.1560820888.git.rodrigosiqueiramelo@gmail.com>
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

Rename the struct vkms_crc_data to vkms_data and also remove the CRC
prefix from variables that use this struct.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c |  8 +++----
 drivers/gpu/drm/vkms/vkms_composer.h |  8 +++----
 drivers/gpu/drm/vkms/vkms_crc.c      | 14 +++++------
 drivers/gpu/drm/vkms/vkms_drv.h      |  6 ++---
 drivers/gpu/drm/vkms/vkms_plane.c    | 36 ++++++++++++++--------------
 5 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 3d7c5e316d6e..c636dc672430 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -19,8 +19,8 @@
  * Todo: Use the alpha value to blend vaddr_src with vaddr_dst
  *	 instead of overwriting it.
  */
-void blend(void *vaddr_dst, void *vaddr_src, struct vkms_crc_data *dest,
-	   struct vkms_crc_data *src)
+void blend(void *vaddr_dst, void *vaddr_src, struct vkms_data *dest,
+	   struct vkms_data *src)
 {
 	int i, j, j_dst, i_dst;
 	int offset_src, offset_dst;
@@ -52,8 +52,8 @@ void blend(void *vaddr_dst, void *vaddr_src, struct vkms_crc_data *dest,
 	}
 }
 
-void compose_cursor(struct vkms_crc_data *cursor,
-		    struct vkms_crc_data *primary, void *vaddr_out)
+void compose_cursor(struct vkms_data *cursor, struct vkms_data *primary,
+		    void *vaddr_out)
 {
 	struct drm_gem_object *cursor_obj;
 	struct vkms_gem_object *cursor_vkms_obj;
diff --git a/drivers/gpu/drm/vkms/vkms_composer.h b/drivers/gpu/drm/vkms/vkms_composer.h
index 53fdee17a632..93842b4b2eed 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.h
+++ b/drivers/gpu/drm/vkms/vkms_composer.h
@@ -3,10 +3,10 @@
 #ifndef _VKMS_COMPOSER_H_
 #define _VKMS_COMPOSER_H_
 
-void blend(void *vaddr_dst, void *vaddr_src, struct vkms_crc_data *dest,
-	   struct vkms_crc_data *src);
+void blend(void *vaddr_dst, void *vaddr_src, struct vkms_data *dest,
+	   struct vkms_data *src);
 
-void compose_cursor(struct vkms_crc_data *cursor,
-		    struct vkms_crc_data *primary, void *vaddr_out);
+void compose_cursor(struct vkms_data *cursor, struct vkms_data *primary,
+		    void *vaddr_out);
 
 #endif /* _VKMS_COMPOSER_H_ */
diff --git a/drivers/gpu/drm/vkms/vkms_crc.c b/drivers/gpu/drm/vkms/vkms_crc.c
index 8b215677581f..69d0decf14af 100644
--- a/drivers/gpu/drm/vkms/vkms_crc.c
+++ b/drivers/gpu/drm/vkms/vkms_crc.c
@@ -16,7 +16,7 @@
  * returns CRC value computed using crc32 on the visible portion of
  * the final framebuffer at vaddr_out
  */
-static uint32_t compute_crc(void *vaddr_out, struct vkms_crc_data *crc_out)
+static uint32_t compute_crc(void *vaddr_out, struct vkms_data *crc_out)
 {
 	int i, j, src_offset;
 	int x_src = crc_out->src.x1 >> 16;
@@ -40,8 +40,8 @@ static uint32_t compute_crc(void *vaddr_out, struct vkms_crc_data *crc_out)
 	return crc;
 }
 
-static uint32_t _vkms_get_crc(struct vkms_crc_data *primary_crc,
-			      struct vkms_crc_data *cursor_crc)
+static uint32_t _vkms_get_crc(struct vkms_data *primary_crc,
+			      struct vkms_data *cursor_crc)
 {
 	struct drm_framebuffer *fb = &primary_crc->fb;
 	struct drm_gem_object *gem_obj = drm_gem_fb_get_obj(fb, 0);
@@ -87,8 +87,8 @@ void vkms_crc_work_handle(struct work_struct *work)
 						crc_work);
 	struct drm_crtc *crtc = crtc_state->base.crtc;
 	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
-	struct vkms_crc_data *primary_crc = NULL;
-	struct vkms_crc_data *cursor_crc = NULL;
+	struct vkms_data *primary_crc = NULL;
+	struct vkms_data *cursor_crc = NULL;
 	u32 crc32 = 0;
 	u64 frame_start, frame_end;
 	bool crc_pending;
@@ -110,10 +110,10 @@ void vkms_crc_work_handle(struct work_struct *work)
 		return;
 
 	if (crtc_state->num_active_planes >= 1)
-		primary_crc = crtc_state->active_planes[0]->crc_data;
+		primary_crc = crtc_state->active_planes[0]->data;
 
 	if (crtc_state->num_active_planes == 2)
-		cursor_crc = crtc_state->active_planes[1]->crc_data;
+		cursor_crc = crtc_state->active_planes[1]->data;
 
 	if (primary_crc)
 		crc32 = _vkms_get_crc(primary_crc, cursor_crc);
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index a887c05ff70e..8d628d18105e 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -20,7 +20,7 @@
 
 extern bool enable_cursor;
 
-struct vkms_crc_data {
+struct vkms_data {
 	struct drm_framebuffer fb;
 	struct drm_rect src, dst;
 	unsigned int offset;
@@ -31,11 +31,11 @@ struct vkms_crc_data {
 /**
  * vkms_plane_state - Driver specific plane state
  * @base: base plane state
- * @crc_data: data required for CRC computation
+ * @data: data required for compose computation
  */
 struct vkms_plane_state {
 	struct drm_plane_state base;
-	struct vkms_crc_data *crc_data;
+	struct vkms_data *data;
 };
 
 /**
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 0fceb6258422..8cf40297cf56 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -18,20 +18,20 @@ static struct drm_plane_state *
 vkms_plane_duplicate_state(struct drm_plane *plane)
 {
 	struct vkms_plane_state *vkms_state;
-	struct vkms_crc_data *crc_data;
+	struct vkms_data *data;
 
 	vkms_state = kzalloc(sizeof(*vkms_state), GFP_KERNEL);
 	if (!vkms_state)
 		return NULL;
 
-	crc_data = kzalloc(sizeof(*crc_data), GFP_KERNEL);
-	if (!crc_data) {
-		DRM_DEBUG_KMS("Couldn't allocate crc_data\n");
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		DRM_DEBUG_KMS("Couldn't allocate vkms_data\n");
 		kfree(vkms_state);
 		return NULL;
 	}
 
-	vkms_state->crc_data = crc_data;
+	vkms_state->data = data;
 
 	__drm_atomic_helper_plane_duplicate_state(plane,
 						  &vkms_state->base);
@@ -49,12 +49,12 @@ static void vkms_plane_destroy_state(struct drm_plane *plane,
 		/* dropping the reference we acquired in
 		 * vkms_primary_plane_update()
 		 */
-		if (drm_framebuffer_read_refcount(&vkms_state->crc_data->fb))
-			drm_framebuffer_put(&vkms_state->crc_data->fb);
+		if (drm_framebuffer_read_refcount(&vkms_state->data->fb))
+			drm_framebuffer_put(&vkms_state->data->fb);
 	}
 
-	kfree(vkms_state->crc_data);
-	vkms_state->crc_data = NULL;
+	kfree(vkms_state->data);
+	vkms_state->data = NULL;
 
 	__drm_atomic_helper_plane_destroy_state(old_state);
 	kfree(vkms_state);
@@ -91,21 +91,21 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
 {
 	struct vkms_plane_state *vkms_plane_state;
 	struct drm_framebuffer *fb = plane->state->fb;
-	struct vkms_crc_data *crc_data;
+	struct vkms_data *data;
 
 	if (!plane->state->crtc || !fb)
 		return;
 
 	vkms_plane_state = to_vkms_plane_state(plane->state);
 
-	crc_data = vkms_plane_state->crc_data;
-	memcpy(&crc_data->src, &plane->state->src, sizeof(struct drm_rect));
-	memcpy(&crc_data->dst, &plane->state->dst, sizeof(struct drm_rect));
-	memcpy(&crc_data->fb, fb, sizeof(struct drm_framebuffer));
-	drm_framebuffer_get(&crc_data->fb);
-	crc_data->offset = fb->offsets[0];
-	crc_data->pitch = fb->pitches[0];
-	crc_data->cpp = fb->format->cpp[0];
+	data = vkms_plane_state->data;
+	memcpy(&data->src, &plane->state->src, sizeof(struct drm_rect));
+	memcpy(&data->dst, &plane->state->dst, sizeof(struct drm_rect));
+	memcpy(&data->fb, fb, sizeof(struct drm_framebuffer));
+	drm_framebuffer_get(&data->fb);
+	data->offset = fb->offsets[0];
+	data->pitch = fb->pitches[0];
+	data->cpp = fb->format->cpp[0];
 }
 
 static int vkms_plane_atomic_check(struct drm_plane *plane,
-- 
2.21.0
