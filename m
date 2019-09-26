Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61184C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357D121655
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387992AbfIZBXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 21:23:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36338 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfIZBXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 21:23:12 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id 2E9E028ED0E
From:   Helen Koike <helen.koike@collabora.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc:     kernel@collabora.com, mcasas@google.com, zhenyu.z.wang@intel.com,
        airlied@linux.ie, daniel.vetter@ffwll.ch,
        joonas.lahtinen@linux.intel.com, linux-kernel@vger.kernel.org,
        jani.nikula@linux.intel.com, tfiga@chromium.org,
        gustavo.padovan@collabora.com, rodrigo.vivi@intel.com,
        enric.balletbo@collabora.com, tina.zhang@intel.com,
        ville.syrjala@linux.intel.com,
        Helen Koike <helen.koike@collabora.com>
Subject: [PATCH v11 1/2] drm/i915: Introduce async plane update to i915
Date:   Wed, 25 Sep 2019 22:22:42 -0300
Message-Id: <20190926012243.4893-1-helen.koike@collabora.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo Padovan <gustavo.padovan@collabora.com>

Add implementation for async plane update callbacks

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Signed-off-by: Helen Koike <helen.koike@collabora.com>
Tested-by: Tina Zhang <tina.zhang@intel.com>

---
Hi,

I ran the following tests and no regressions were found:

./scripts/run-tests.sh -p -s -t ".*plane_cursor_legacy.*" -t
".*kms_cursor_legacy.*" -r results-`uname -r`-v11 -v

The igt test results can be found at
https://people.collabora.com/~koike/results-5.3.0-rc3+-v11/html

Thanks
Helen

Changes in v11:
 - v10 https://patchwork.kernel.org/project/dri-devel/list/?series=147095
 - rebase on drm-intel
 - replace i915_gem_track_fb() by intel_frontbuffer_track()

Changes in v10:
 - v9: https://patchwork.kernel.org/patch/11000561/
 - rebase on drm-tip
 - call i915_sw_fence_init() in the begining of intel_atomic_commit(),
 otherwise drm_atomic_helper_prepare_planes() without initializing the
 fence object, casing errors like:
ODEBUG: assert_init not available (active state 0) object type: i915_sw_fence hint: 0x0

Changes in v9:
 - v8: https://patchwork.kernel.org/patch/10843395/
 - Added tested-by tag
 - submitted to  intel-gfx@lists.freedesktop.org to invoke CI
 - rebased and fixed conflicts on top of drm-tip

Changes in v8:
 - v7: https://lkml.org/lkml/2018/6/8/168
 - v7 was splited in two, one that adds the async callbacks and another
 that updates the cursor.
 - rebase with drm-intel
 - allow async update in all types of planes, not only cursor
 - add watermark checks in async update
 - remove bypass of intel_prepare_plane_fb() in case of async update
 - add missing drm_atomic_helper_cleanup_planes(dev, state) call in
 intel_atomic_commit().
 - use swap() function in async update to set the old_fb in the
 new_state object.
 - use helpers intel_update_plane()/intel_disable_plane()

Changes in v7:
- Rebase on top of drm-intel repository. Hopefully now will play
  nicely with autobuilders.

Changes in v6:
- Rework the intel_plane_atomic_async_update due driver changed from
  last time.
- Removed the mutex_lock/unlock as causes a deadlock.

Changes in v5:
- Call drm_atomic_helper_async_check() from the check hook

Changes in v4:
- Set correct vma to new state for cleanup
- Move size checks back to drivers (Ville Syrjälä)

Changes in v3:
- Move fb setting to core and use new state (Eric Anholt)

 .../gpu/drm/i915/display/intel_atomic_plane.c | 71 +++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_display.c  | 20 +++---
 .../drm/i915/display/intel_display_types.h    |  6 ++
 3 files changed, 89 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_atomic_plane.c b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
index d1fcdf206da4..faa5d74e3ccf 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
@@ -365,8 +365,79 @@ void i9xx_update_planes_on_crtc(struct intel_atomic_state *state,
 	}
 }
 
+static int intel_plane_atomic_async_check(struct drm_plane *plane,
+					  struct drm_plane_state *state)
+{
+	struct drm_crtc_state *crtc_state;
+
+	crtc_state = drm_atomic_get_existing_crtc_state(state->state,
+							state->crtc);
+	if (WARN_ON(!crtc_state))
+		return -EINVAL;
+
+	/*
+	 * When crtc is inactive or there is a modeset pending,
+	 * wait for it to complete in the slowpath
+	 */
+	if (!crtc_state->active || to_intel_crtc_state(crtc_state)->update_pipe)
+		return -EINVAL;
+
+	/*
+	 * If any parameters change that may affect watermarks,
+	 * take the slowpath. Only changing fb or position should be
+	 * in the fastpath.
+	 */
+	if (plane->state->crtc != state->crtc ||
+	    plane->state->src_w != state->src_w ||
+	    plane->state->src_h != state->src_h ||
+	    plane->state->crtc_w != state->crtc_w ||
+	    plane->state->crtc_h != state->crtc_h ||
+	    !plane->state->fb != !state->fb)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void intel_plane_atomic_async_update(struct drm_plane *plane,
+					    struct drm_plane_state *new_state)
+{
+	struct intel_atomic_state *intel_new_state =
+		to_intel_atomic_state(new_state->state);
+	struct intel_plane *intel_plane = to_intel_plane(plane);
+	struct drm_crtc *crtc = plane->state->crtc;
+	struct intel_crtc_state *new_crtc_state;
+	struct intel_crtc *intel_crtc;
+	int i;
+
+	for_each_new_intel_crtc_in_state(intel_new_state, intel_crtc,
+					 new_crtc_state, i)
+		WARN_ON(new_crtc_state->wm.need_postvbl_update ||
+			new_crtc_state->update_wm_post);
+
+	intel_frontbuffer_track(to_intel_frontbuffer(plane->state->fb),
+				to_intel_frontbuffer(new_state->fb),
+				intel_plane->frontbuffer_bit);
+
+	plane->state->src_x = new_state->src_x;
+	plane->state->src_y = new_state->src_y;
+	plane->state->crtc_x = new_state->crtc_x;
+	plane->state->crtc_y = new_state->crtc_y;
+
+	swap(plane->state->fb, new_state->fb);
+
+	if (plane->state->visible)
+		intel_update_plane(intel_plane,
+				   to_intel_crtc_state(crtc->state),
+				   to_intel_plane_state(plane->state));
+	else
+		intel_disable_plane(intel_plane,
+				    to_intel_crtc_state(crtc->state));
+}
+
 const struct drm_plane_helper_funcs intel_plane_helper_funcs = {
 	.prepare_fb = intel_prepare_plane_fb,
 	.cleanup_fb = intel_cleanup_plane_fb,
 	.atomic_check = intel_plane_atomic_check,
+	.atomic_async_check = intel_plane_atomic_async_check,
+	.atomic_async_update = intel_plane_atomic_async_update,
 };
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index b51d1ceb8739..8ee74cda5b45 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -3158,12 +3158,6 @@ static void intel_plane_disable_noatomic(struct intel_crtc *crtc,
 	intel_disable_plane(plane, crtc_state);
 }
 
-static struct intel_frontbuffer *
-to_intel_frontbuffer(struct drm_framebuffer *fb)
-{
-	return fb ? to_intel_framebuffer(fb)->frontbuffer : NULL;
-}
-
 static void
 intel_find_initial_plane_obj(struct intel_crtc *intel_crtc,
 			     struct intel_initial_plane_config *plane_config)
@@ -14129,11 +14123,21 @@ static int intel_atomic_commit(struct drm_device *dev,
 	struct drm_i915_private *dev_priv = to_i915(dev);
 	int ret = 0;
 
+	i915_sw_fence_init(&state->commit_ready,
+			   intel_atomic_commit_ready);
+
+	if (_state->async_update) {
+		ret = drm_atomic_helper_prepare_planes(dev, _state);
+		if (ret)
+			return ret;
+		drm_atomic_helper_async_commit(dev, _state);
+		drm_atomic_helper_cleanup_planes(dev, _state);
+		return 0;
+	}
+
 	state->wakeref = intel_runtime_pm_get(&dev_priv->runtime_pm);
 
 	drm_atomic_state_get(&state->base);
-	i915_sw_fence_init(&state->commit_ready,
-			   intel_atomic_commit_ready);
 
 	/*
 	 * The intel_legacy_cursor_update() fast path takes care
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 449abaea619f..00ebe5b99f25 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1092,6 +1092,12 @@ struct cxsr_latency {
 #define to_intel_plane_state(x) container_of(x, struct intel_plane_state, base)
 #define intel_fb_obj(x) ((x) ? to_intel_bo((x)->obj[0]) : NULL)
 
+static inline struct intel_frontbuffer *
+to_intel_frontbuffer(struct drm_framebuffer *fb)
+{
+	return fb ? to_intel_framebuffer(fb)->frontbuffer : NULL;
+}
+
 struct intel_hdmi {
 	i915_reg_t hdmi_reg;
 	int ddc_bus;
-- 
2.22.0

