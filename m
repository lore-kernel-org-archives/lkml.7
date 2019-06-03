Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66454C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45580274E4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbfFCQ4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:56:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35330 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfFCQ4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:56:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id 57A39284AA2
From:   Helen Koike <helen.koike@collabora.com>
To:     dri-devel@lists.freedesktop.org, nicholas.kazlauskas@amd.com
Cc:     andrey.grodzovsky@amd.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        boris.brezillon@collabora.com, David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        harry.wentland@amd.com,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@google.com>,
        Helen Koike <helen.koike@collabora.com>,
        Sandy Huang <hjc@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v4 1/5] drm/rockchip: fix fb references in async update
Date:   Mon,  3 Jun 2019 13:56:06 -0300
Message-Id: <20190603165610.24614-2-helen.koike@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190603165610.24614-1-helen.koike@collabora.com>
References: <20190603165610.24614-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of async update, modifications are done in place, i.e. in the
current plane state, so the new_state is prepared and the new_state is
cleaned up (instead of the old_state, unlike what happens in a
normal sync update).
To cleanup the old_fb properly, it needs to be placed in the new_state
in the end of async_update, so cleanup call will unreference the old_fb
correctly.

Also, the previous code had a:

	plane_state = plane->funcs->atomic_duplicate_state(plane);
	...
	swap(plane_state, plane->state);

	if (plane->state->fb && plane->state->fb != new_state->fb) {
	...
	}

Which was wrong, as the fb were just assigned to be equal, so this if
statement nevers evaluates to true.

Another details is that the function drm_crtc_vblank_get() can only be
called when vop->is_enabled is true, otherwise it has no effect and
trows a WARN_ON().

Calling drm_atomic_set_fb_for_plane() (which get a referent of the new
fb and pus the old fb) is not required, as it is taken care by
drm_mode_cursor_universal() when calling
drm_atomic_helper_update_plane().

Signed-off-by: Helen Koike <helen.koike@collabora.com>

---
Hello,

I tested on the rockchip ficus v1.1 using igt plane_cursor_legacy and
kms_cursor_legacy and I didn't see any regressions.

Changes in v4: None
Changes in v3:
- use swap() to swap old and new framebuffers in async_update
- get the reference to old_fb and set the worker after vop_plane_atomic_update()
- add a FIXME tag for when we have multiple fbs to be released when
vblank happens.
- update commit message

Changes in v2: None

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 51 +++++++++++----------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 4189ca17f381..b7c47d1153c6 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -919,29 +919,17 @@ static void vop_plane_atomic_async_update(struct drm_plane *plane,
 					  struct drm_plane_state *new_state)
 {
 	struct vop *vop = to_vop(plane->state->crtc);
-	struct drm_plane_state *plane_state;
-
-	plane_state = plane->funcs->atomic_duplicate_state(plane);
-	plane_state->crtc_x = new_state->crtc_x;
-	plane_state->crtc_y = new_state->crtc_y;
-	plane_state->crtc_h = new_state->crtc_h;
-	plane_state->crtc_w = new_state->crtc_w;
-	plane_state->src_x = new_state->src_x;
-	plane_state->src_y = new_state->src_y;
-	plane_state->src_h = new_state->src_h;
-	plane_state->src_w = new_state->src_w;
-
-	if (plane_state->fb != new_state->fb)
-		drm_atomic_set_fb_for_plane(plane_state, new_state->fb);
-
-	swap(plane_state, plane->state);
-
-	if (plane->state->fb && plane->state->fb != new_state->fb) {
-		drm_framebuffer_get(plane->state->fb);
-		WARN_ON(drm_crtc_vblank_get(plane->state->crtc) != 0);
-		drm_flip_work_queue(&vop->fb_unref_work, plane->state->fb);
-		set_bit(VOP_PENDING_FB_UNREF, &vop->pending);
-	}
+	struct drm_framebuffer *old_fb = plane->state->fb;
+
+	plane->state->crtc_x = new_state->crtc_x;
+	plane->state->crtc_y = new_state->crtc_y;
+	plane->state->crtc_h = new_state->crtc_h;
+	plane->state->crtc_w = new_state->crtc_w;
+	plane->state->src_x = new_state->src_x;
+	plane->state->src_y = new_state->src_y;
+	plane->state->src_h = new_state->src_h;
+	plane->state->src_w = new_state->src_w;
+	swap(plane->state->fb, new_state->fb);
 
 	if (vop->is_enabled) {
 		rockchip_drm_psr_inhibit_get_state(new_state->state);
@@ -950,9 +938,22 @@ static void vop_plane_atomic_async_update(struct drm_plane *plane,
 		vop_cfg_done(vop);
 		spin_unlock(&vop->reg_lock);
 		rockchip_drm_psr_inhibit_put_state(new_state->state);
-	}
 
-	plane->funcs->atomic_destroy_state(plane, plane_state);
+		/*
+		 * A scanout can still be occurring, so we can't drop the
+		 * reference to the old framebuffer. To solve this we get a
+		 * reference to old_fb and set a worker to release it later.
+		 * FIXME: if we perform 500 async_update calls before the
+		 * vblank, then we can have 500 different framebuffers waiting
+		 * to be released.
+		 */
+		if (old_fb && plane->state->fb != old_fb) {
+			drm_framebuffer_get(old_fb);
+			WARN_ON(drm_crtc_vblank_get(plane->state->crtc) != 0);
+			drm_flip_work_queue(&vop->fb_unref_work, old_fb);
+			set_bit(VOP_PENDING_FB_UNREF, &vop->pending);
+		}
+	}
 }
 
 static const struct drm_plane_helper_funcs plane_helper_funcs = {
-- 
2.20.1

