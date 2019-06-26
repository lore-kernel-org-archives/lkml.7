Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4419EC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 01:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B519204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 01:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYqgls57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfFZBiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 21:38:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40552 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFZBiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 21:38:04 -0400
Received: by mail-qt1-f193.google.com with SMTP id a15so659173qtn.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 18:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dcji4DG1mYdfSzaoYm1b9GBfrTHcBOQ4lNkuX8kgim8=;
        b=QYqgls57UiwrwknJ+w6IfGJFDRY1zpL306MGaJVEbcPuLpkedTVidtXe12U7J8ObsL
         wbnA98tWBTOmbjCY4W6urdJT+XoYAkh1CMcVlx23yB2q185Up7fYoNTmG8kzB+1/RXnu
         1kS6yqT8hEIPPbhn6lbU7EFU1vfucpe3BpG1N0TGYR7rFzGl4nRcDpEGHVtzhuU0BUiV
         AiNtow8FBlAob7PeSyxcmPQ0fiE5FrR5FI86blq5dGPvL6wPw/dXpnyy0tFYD+hzrr+U
         BLE7As7vn5cIA+q4uxelG6GUVjGeEi4yJ6O1WqKcvlmAcbmG+pE4gulRp6NQ1AezulbF
         PRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dcji4DG1mYdfSzaoYm1b9GBfrTHcBOQ4lNkuX8kgim8=;
        b=ECTmlUtLCIPCq4db+abwwaTwCuYHFVVsCf81ME+X1Ri6rdN0jle2iwb/sQWKxGx+zj
         iaEflKAMlSTZwf/fm7aMcLuUR0U6t3D0SZlkt6UqC5sMj5bBKNi184wqlh8fFQWOeuCb
         PYSSF5clGFh7zjE06jK5IU6tbF90R2suynYZbID/G4zAXObyNYz6cYC/JVg4/R4r/EB1
         ya9esVzwXbYRISEH0zI3ICUlqtWKRWrL9nBYUWQlZ3ZzotrGR9ifF/fJPuqK8X7KUbXS
         NznXpqRZmegrwaVJeUn4bciUTmCwrvL7pTKve3U5H3xO3W4arb/MlwWj2h0FSnYIyHt7
         D9zQ==
X-Gm-Message-State: APjAAAUTGjOOHt33MxfZYLHjWJou/LKMnH3LrKejm4vhUwMpoehdg0mf
        7J2hduD2Xh1TjoRed7hiq7w=
X-Google-Smtp-Source: APXvYqwJv4ZMACGc1XJpqCZdYEetDgEmL+h2ns1p1TA6Wm0McZDXDfxD+AdQ2jcvbnMU6UqRAJyk/w==
X-Received: by 2002:aed:3747:: with SMTP id i65mr1413779qtb.166.1561513083429;
        Tue, 25 Jun 2019 18:38:03 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.146])
        by smtp.gmail.com with ESMTPSA id e18sm7441097qkm.49.2019.06.25.18.37.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 18:38:03 -0700 (PDT)
Date:   Tue, 25 Jun 2019 22:37:58 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/5] drm/vkms: Decouple crc operations from composer
Message-ID: <6e8a03dc7c666ee998ee36172a96cff39f8dd46d.1561491964.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1561491964.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1561491964.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the vkms_composer.c, some of the functions related to CRC and compose
have interdependence between each other. This patch reworks some
functions inside vkms_composer to make crc and composer computation
decoupled.

This patch is preparation work for making vkms able to support new
features.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 49 ++++++++++++++++------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index eb7ea8be1f98..51a270514219 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -105,35 +105,31 @@ static void compose_cursor(struct vkms_composer *cursor_composer,
 	      primary_composer, cursor_composer);
 }
 
-static uint32_t _vkms_get_crc(struct vkms_composer *primary_composer,
-			      struct vkms_composer *cursor_composer)
+static int compose_planes(void **vaddr_out,
+			  struct vkms_composer *primary_composer,
+			  struct vkms_composer *cursor_composer)
 {
 	struct drm_framebuffer *fb = &primary_composer->fb;
 	struct drm_gem_object *gem_obj = drm_gem_fb_get_obj(fb, 0);
 	struct vkms_gem_object *vkms_obj = drm_gem_to_vkms_gem(gem_obj);
-	void *vaddr_out = kzalloc(vkms_obj->gem.size, GFP_KERNEL);
-	u32 crc = 0;
 
-	if (!vaddr_out) {
-		DRM_ERROR("Failed to allocate memory for output frame.");
-		return 0;
+	if (!*vaddr_out) {
+		*vaddr_out = kzalloc(vkms_obj->gem.size, GFP_KERNEL);
+		if (!*vaddr_out) {
+			DRM_ERROR("Cannot allocate memory for output frame.");
+			return -ENOMEM;
+		}
 	}
 
-	if (WARN_ON(!vkms_obj->vaddr)) {
-		kfree(vaddr_out);
-		return crc;
-	}
+	if (WARN_ON(!vkms_obj->vaddr))
+		return -EINVAL;
 
-	memcpy(vaddr_out, vkms_obj->vaddr, vkms_obj->gem.size);
+	memcpy(*vaddr_out, vkms_obj->vaddr, vkms_obj->gem.size);
 
 	if (cursor_composer)
-		compose_cursor(cursor_composer, primary_composer, vaddr_out);
+		compose_cursor(cursor_composer, primary_composer, *vaddr_out);
 
-	crc = compute_crc(vaddr_out, primary_composer);
-
-	kfree(vaddr_out);
-
-	return crc;
+	return 0;
 }
 
 /**
@@ -154,9 +150,11 @@ void vkms_composer_worker(struct work_struct *work)
 	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
 	struct vkms_composer *primary_composer = NULL;
 	struct vkms_composer *cursor_composer = NULL;
+	void *vaddr_out = NULL;
 	u32 crc32 = 0;
 	u64 frame_start, frame_end;
 	bool crc_pending;
+	int ret;
 
 	spin_lock_irq(&out->composer_lock);
 	frame_start = crtc_state->frame_start;
@@ -180,14 +178,25 @@ void vkms_composer_worker(struct work_struct *work)
 	if (crtc_state->num_active_planes == 2)
 		cursor_composer = crtc_state->active_planes[1]->composer;
 
-	if (primary_composer)
-		crc32 = _vkms_get_crc(primary_composer, cursor_composer);
+	if (!primary_composer)
+		return;
+
+	ret = compose_planes(&vaddr_out, primary_composer, cursor_composer);
+	if (ret) {
+		if (ret == -EINVAL)
+			kfree(vaddr_out);
+		return;
+	}
+
+	crc32 = compute_crc(vaddr_out, primary_composer);
 
 	/*
 	 * The worker can fall behind the vblank hrtimer, make sure we catch up.
 	 */
 	while (frame_start <= frame_end)
 		drm_crtc_add_crc_entry(crtc, true, frame_start++, &crc32);
+
+	kfree(vaddr_out);
 }
 
 static const char * const pipe_crc_sources[] = {"auto"};
-- 
2.21.0
