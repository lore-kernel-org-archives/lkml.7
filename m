Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA62C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12452063F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbfFQVj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:39:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56546 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfFQVj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:39:26 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id 0BCAD283954
From:   Helen Koike <helen.koike@collabora.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc:     tfiga@chromium.org, mcasas@google.com, zhenyu.z.wang@intel.com,
        daniel.vetter@ffwll.ch, tina.zhang@intel.com, kernel@collabora.com,
        ville.syrjala@linux.intel.com,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Helen Koike <helen.koike@collabora.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v9 2/2] drm/i915: update cursors asynchronously through atomic
Date:   Mon, 17 Jun 2019 18:38:54 -0300
Message-Id: <20190617213854.32330-2-helen.koike@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617213854.32330-1-helen.koike@collabora.com>
References: <20190617213854.32330-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo Padovan <gustavo.padovan@collabora.com>

Replace the legacy cursor implementation by the async callbacks

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Helen Koike <helen.koike@collabora.com>

---

Changes in v9:
 - v8: https://patchwork.kernel.org/patch/10843397/
 - rebased and fixed conflicts on top of drm-tip

Changes in v8:
 - v7: https://lkml.org/lkml/2018/6/8/168
 - v7 was splited in two, one that adds the async callbacks and another
 that updates the cursor.
 - Update comment in intel_pm.c that was referencing
 intel_plane_atomic_async_update()

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None

 drivers/gpu/drm/i915/display/intel_display.c | 165 +------------------
 drivers/gpu/drm/i915/intel_pm.c              |   2 +-
 2 files changed, 6 insertions(+), 161 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index bf505b70a037..8aee8f0f83cb 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -13505,6 +13505,10 @@ static int intel_atomic_check(struct drm_device *dev,
 	if (ret)
 		goto fail;
 
+	if (_state->legacy_cursor_update)
+		_state->async_update = !drm_atomic_helper_async_check(dev,
+								     _state);
+
 	intel_fbc_choose_crtc(dev_priv, state);
 	ret = calc_watermark_data(state);
 	if (ret)
@@ -14022,34 +14026,6 @@ static int intel_atomic_commit(struct drm_device *dev,
 	i915_sw_fence_init(&intel_state->commit_ready,
 			   intel_atomic_commit_ready);
 
-	/*
-	 * The intel_legacy_cursor_update() fast path takes care
-	 * of avoiding the vblank waits for simple cursor
-	 * movement and flips. For cursor on/off and size changes,
-	 * we want to perform the vblank waits so that watermark
-	 * updates happen during the correct frames. Gen9+ have
-	 * double buffered watermarks and so shouldn't need this.
-	 *
-	 * Unset state->legacy_cursor_update before the call to
-	 * drm_atomic_helper_setup_commit() because otherwise
-	 * drm_atomic_helper_wait_for_flip_done() is a noop and
-	 * we get FIFO underruns because we didn't wait
-	 * for vblank.
-	 *
-	 * FIXME doing watermarks and fb cleanup from a vblank worker
-	 * (assuming we had any) would solve these problems.
-	 */
-	if (INTEL_GEN(dev_priv) < 9 && state->legacy_cursor_update) {
-		struct intel_crtc_state *new_crtc_state;
-		struct intel_crtc *crtc;
-		int i;
-
-		for_each_new_intel_crtc_in_state(intel_state, crtc, new_crtc_state, i)
-			if (new_crtc_state->wm.need_postvbl_update ||
-			    new_crtc_state->update_wm_post)
-				state->legacy_cursor_update = false;
-	}
-
 	ret = intel_atomic_prepare_commit(dev, state);
 	if (ret) {
 		DRM_DEBUG_ATOMIC("Preparing state failed with %i\n", ret);
@@ -14555,139 +14531,8 @@ static const struct drm_plane_funcs i8xx_plane_funcs = {
 	.format_mod_supported = i8xx_plane_format_mod_supported,
 };
 
-static int
-intel_legacy_cursor_update(struct drm_plane *plane,
-			   struct drm_crtc *crtc,
-			   struct drm_framebuffer *fb,
-			   int crtc_x, int crtc_y,
-			   unsigned int crtc_w, unsigned int crtc_h,
-			   u32 src_x, u32 src_y,
-			   u32 src_w, u32 src_h,
-			   struct drm_modeset_acquire_ctx *ctx)
-{
-	struct drm_i915_private *dev_priv = to_i915(crtc->dev);
-	int ret;
-	struct drm_plane_state *old_plane_state, *new_plane_state;
-	struct intel_plane *intel_plane = to_intel_plane(plane);
-	struct drm_framebuffer *old_fb;
-	struct intel_crtc_state *crtc_state =
-		to_intel_crtc_state(crtc->state);
-	struct intel_crtc_state *new_crtc_state;
-
-	/*
-	 * When crtc is inactive or there is a modeset pending,
-	 * wait for it to complete in the slowpath
-	 */
-	if (!crtc_state->base.active || needs_modeset(&crtc_state->base) ||
-	    crtc_state->update_pipe)
-		goto slow;
-
-	old_plane_state = plane->state;
-	/*
-	 * Don't do an async update if there is an outstanding commit modifying
-	 * the plane.  This prevents our async update's changes from getting
-	 * overridden by a previous synchronous update's state.
-	 */
-	if (old_plane_state->commit &&
-	    !try_wait_for_completion(&old_plane_state->commit->hw_done))
-		goto slow;
-
-	/*
-	 * If any parameters change that may affect watermarks,
-	 * take the slowpath. Only changing fb or position should be
-	 * in the fastpath.
-	 */
-	if (old_plane_state->crtc != crtc ||
-	    old_plane_state->src_w != src_w ||
-	    old_plane_state->src_h != src_h ||
-	    old_plane_state->crtc_w != crtc_w ||
-	    old_plane_state->crtc_h != crtc_h ||
-	    !old_plane_state->fb != !fb)
-		goto slow;
-
-	new_plane_state = intel_plane_duplicate_state(plane);
-	if (!new_plane_state)
-		return -ENOMEM;
-
-	new_crtc_state = to_intel_crtc_state(intel_crtc_duplicate_state(crtc));
-	if (!new_crtc_state) {
-		ret = -ENOMEM;
-		goto out_free;
-	}
-
-	drm_atomic_set_fb_for_plane(new_plane_state, fb);
-
-	new_plane_state->src_x = src_x;
-	new_plane_state->src_y = src_y;
-	new_plane_state->src_w = src_w;
-	new_plane_state->src_h = src_h;
-	new_plane_state->crtc_x = crtc_x;
-	new_plane_state->crtc_y = crtc_y;
-	new_plane_state->crtc_w = crtc_w;
-	new_plane_state->crtc_h = crtc_h;
-
-	ret = intel_plane_atomic_check_with_state(crtc_state, new_crtc_state,
-						  to_intel_plane_state(old_plane_state),
-						  to_intel_plane_state(new_plane_state));
-	if (ret)
-		goto out_free;
-
-	ret = mutex_lock_interruptible(&dev_priv->drm.struct_mutex);
-	if (ret)
-		goto out_free;
-
-	ret = intel_plane_pin_fb(to_intel_plane_state(new_plane_state));
-	if (ret)
-		goto out_unlock;
-
-	intel_fb_obj_flush(intel_fb_obj(fb), ORIGIN_FLIP);
-
-	old_fb = old_plane_state->fb;
-	i915_gem_track_fb(intel_fb_obj(old_fb), intel_fb_obj(fb),
-			  intel_plane->frontbuffer_bit);
-
-	/* Swap plane state */
-	plane->state = new_plane_state;
-
-	/*
-	 * We cannot swap crtc_state as it may be in use by an atomic commit or
-	 * page flip that's running simultaneously. If we swap crtc_state and
-	 * destroy the old state, we will cause a use-after-free there.
-	 *
-	 * Only update active_planes, which is needed for our internal
-	 * bookkeeping. Either value will do the right thing when updating
-	 * planes atomically. If the cursor was part of the atomic update then
-	 * we would have taken the slowpath.
-	 */
-	crtc_state->active_planes = new_crtc_state->active_planes;
-
-	if (plane->state->visible)
-		intel_update_plane(intel_plane, crtc_state,
-				   to_intel_plane_state(plane->state));
-	else
-		intel_disable_plane(intel_plane, crtc_state);
-
-	intel_plane_unpin_fb(to_intel_plane_state(old_plane_state));
-
-out_unlock:
-	mutex_unlock(&dev_priv->drm.struct_mutex);
-out_free:
-	if (new_crtc_state)
-		intel_crtc_destroy_state(crtc, &new_crtc_state->base);
-	if (ret)
-		intel_plane_destroy_state(plane, new_plane_state);
-	else
-		intel_plane_destroy_state(plane, old_plane_state);
-	return ret;
-
-slow:
-	return drm_atomic_helper_update_plane(plane, crtc, fb,
-					      crtc_x, crtc_y, crtc_w, crtc_h,
-					      src_x, src_y, src_w, src_h, ctx);
-}
-
 static const struct drm_plane_funcs intel_cursor_plane_funcs = {
-	.update_plane = intel_legacy_cursor_update,
+	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = intel_plane_destroy,
 	.atomic_duplicate_state = intel_plane_duplicate_state,
diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
index d9a7a13ce32a..bf378197f59f 100644
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -825,7 +825,7 @@ static bool intel_wm_plane_visible(const struct intel_crtc_state *crtc_state,
 	 * can happen faster than the vrefresh rate, and the current
 	 * watermark code doesn't handle that correctly. Cursor updates
 	 * which set/clear the fb or change the cursor size are going
-	 * to get throttled by intel_legacy_cursor_update() to work
+	 * to get throttled by intel_plane_atomic_async_update() to work
 	 * around this problem with the watermark code.
 	 */
 	if (plane->id == PLANE_CURSOR)
-- 
2.20.1

