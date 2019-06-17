Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5347FC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238602063F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfFQVjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:39:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56534 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfFQVjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:39:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id 3987B260D9A
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
        Matt Roper <matthew.d.roper@intel.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v9 1/2] drm/i915: Introduce async plane update to i915
Date:   Mon, 17 Jun 2019 18:38:53 -0300
Message-Id: <20190617213854.32330-1-helen.koike@collabora.com>
X-Mailer: git-send-email 2.20.1
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

I tested this patch set with igt (ksm_cursor_legacy and plane_cursor_legacy)
and found no regressions.

This patch depends on [1] "[PATCH] drm: don't block fb changes for async plane updates",
which is already on drm-misc, otherwise there will be a regression on igt tests:

        cursor-vs-flip-atomic-transitions-varying-size
        cursor-vs-flip-toggle
        cursor-vs-flip-varying-size

with errors of type:

"CRITICAL: completed 97 cursor updated in a period of 30 flips, we
expect to complete approximately 15360 updates, with the threshold set
at 7680"

When picking this patch, please backmerge [1] into drm-intel tree.

[1] https://cgit.freedesktop.org/drm/drm-misc/commit/?h=drm-misc-fixes&id=89a4aac0ab0e6f5eea10d7bf4869dd15c3de2cd4

Thanks
Helen

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
 drivers/gpu/drm/i915/display/intel_display.c  |  9 +++
 2 files changed, 80 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_atomic_plane.c b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
index 30bd4e76fff9..56881a7ec48e 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
@@ -348,8 +348,79 @@ void i9xx_update_planes_on_crtc(struct intel_atomic_state *state,
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
+	i915_gem_track_fb(intel_fb_obj(plane->state->fb),
+			  intel_fb_obj(new_state->fb),
+			  intel_plane->frontbuffer_bit);
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
index 8d7e4c8b60bc..bf505b70a037 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -14007,6 +14007,15 @@ static int intel_atomic_commit(struct drm_device *dev,
 	struct drm_i915_private *dev_priv = to_i915(dev);
 	int ret = 0;
 
+	if (state->async_update) {
+		ret = drm_atomic_helper_prepare_planes(dev, state);
+		if (ret)
+			return ret;
+		drm_atomic_helper_async_commit(dev, state);
+		drm_atomic_helper_cleanup_planes(dev, state);
+		return 0;
+	}
+
 	intel_state->wakeref = intel_runtime_pm_get(&dev_priv->runtime_pm);
 
 	drm_atomic_state_get(state);
-- 
2.20.1

