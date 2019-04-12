Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5F5C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016E1218D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfDLM72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:59:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34596 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfDLM71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:59:27 -0400
Received: from localhost.localdomain (unknown [IPv6:2804:431:9718:a5e8:c168:522a:50d5:d06d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: koike)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 533B22811D2;
        Fri, 12 Apr 2019 13:59:15 +0100 (BST)
From:   Helen Koike <helen.koike@collabora.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>
Cc:     dnicoara@chromium.org, daniels@collabora.com,
        alexandros.frantzis@collabora.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, tomasz Figa <tfiga@chromium.org>,
        tina.zhang@intel.com, boris.brezillon@collabora.com,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        nicholas.kazlauskas@amd.com,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@google.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Helen Koike <helen.koike@collabora.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-rockchip@lists.infradead.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Rob Clark <robdclark@gmail.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Eric Anholt <eric@anholt.net>, Leo Li <sunpeng.li@amd.com>,
        linux-arm-msm@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-arm-kernel@lists.infradead.org,
        David Francis <David.Francis@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        amd-gfx@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        freedreno@lists.freedesktop.org,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH RFC v3 4/4] drm/atomic: hook atomic_async_{check,update} with PAGE_FLIP_ASYNC flag
Date:   Fri, 12 Apr 2019 09:58:27 -0300
Message-Id: <20190412125827.5877-5-helen.koike@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412125827.5877-1-helen.koike@collabora.com>
References: <20190412125827.5877-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add atomic_async_{check,update} hooks in drm_plane_helper_funcs.
These hooks are called when userspace requests asyncronous page flip in
the atomic api through the flag DRM_MODE_PAGE_FLIP_ASYNC.

Update those hooks in the drivers that implement async functions, except
for amdgpu who handles the flag in the normal path, and rockchip who
doesn't support async page flip.

Signed-off-by: Helen Koike <helen.koike@collabora.com>

---
Hi,

This patch is an attempt to expose the implementation that already exist
for true async page flips updates through atomic api when the
DRM_MODE_PAGE_FLIP_ASYNC is used.

In this commit I'm re-introducing the atomic_async_{check,update} hooks.
I know it is a bit weird to remove them first and them re-add them, but
I did this in the last commit to avoid any state of inconsistency
between commits, as rockchip doesn't support async page flip and they were
being used as amend.
So I reverted to amend first and then re-introced async again
tied to the DRM_MODE_PAGE_FLIP_ASYNC flag (I also think this is easier
to read).

To use async, it is required to have
dev->mode_config.async_page_flip = true;
but I see that only amdgpu and vc4 have this, so this patch won't take
effect on mdp5.
Nouveau and radeon also have this flag, but they don't implement the
async hooks yet.

Please let me know what you think.

Thanks
Helen

Changes in v3: None
Changes in v2: None
Changes in v1: None

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 +++
 drivers/gpu/drm/drm_atomic_helper.c           | 31 ++++++++++++----
 drivers/gpu/drm/drm_atomic_uapi.c             |  3 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c    |  2 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c   |  4 ++
 drivers/gpu/drm/vc4/vc4_plane.c               |  2 +
 include/drm/drm_atomic.h                      |  2 +
 include/drm/drm_atomic_helper.h               |  9 +++--
 include/drm/drm_modeset_helper_vtables.h      | 37 +++++++++++++++++++
 9 files changed, 83 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 711e7715e112..bb8a5f1997d6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3785,6 +3785,11 @@ static const struct drm_plane_helper_funcs dm_plane_helper_funcs = {
 	 */
 	.atomic_amend_check = dm_plane_atomic_async_check,
 	.atomic_amend_update = dm_plane_atomic_async_update
+	/*
+	 * Note: amdgpu takes care of DRM_MODE_PAGE_FLIP_ASYNC flag in the
+	 * normal commit path, thus .atomic_async_check and .atomic_async_update
+	 * are not provided here.
+	 */
 };
 
 /*
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 9b0df08836c3..bfcf88359de5 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -947,16 +947,31 @@ int drm_atomic_helper_check(struct drm_device *dev,
 	if (ret)
 		return ret;
 
+	/*
+	 * If async page flip was explicitly requested, but it is not possible,
+	 * return error instead of falling back to a normal commit.
+	 * If async_amend_check returns -EOPNOTSUPP, it means
+	 * ->atomic_async_update hook doesn't exist, so fallback to normal
+	 *  commit and let the driver handle DRM_MODE_PAGE_FLIP_ASYNC flag
+	 *  through normal commit code path.
+	 */
+	if (state->async_update) {
+		ret = drm_atomic_helper_async_amend_check(dev, state, false);
+		state->async_update = !ret;
+		return !ret || ret == -EOPNOTSUPP ? 0 : ret;
+	}
+
 	/*
 	 * If amend was explicitly requested, but it is not possible,
 	 * return error instead of falling back to a normal commit.
 	 */
 	if (state->amend_update)
-		return drm_atomic_helper_amend_check(dev, state);
+		return drm_atomic_helper_async_amend_check(dev, state, true);
 
 	/* Legacy mode falls back to a normal commit if amend isn't possible. */
 	if (state->legacy_cursor_update)
-		state->amend_update = !drm_atomic_helper_amend_check(dev, state);
+		state->amend_update =
+			!drm_atomic_helper_async_amend_check(dev, state, true);
 
 	return 0;
 }
@@ -1651,8 +1666,9 @@ static void commit_work(struct work_struct *work)
  * if not. Note that error just mean it can't be committed in amend mode, if it
  * fails the commit should be treated like a normal commit.
  */
-int drm_atomic_helper_amend_check(struct drm_device *dev,
-				   struct drm_atomic_state *state)
+int drm_atomic_helper_async_amend_check(struct drm_device *dev,
+					struct drm_atomic_state *state,
+					bool amend)
 {
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *crtc_state;
@@ -1695,7 +1711,7 @@ int drm_atomic_helper_amend_check(struct drm_device *dev,
 		return -EINVAL;
 
 	/* Only allow amend update for cursor type planes. */
-	if (plane->type != DRM_PLANE_TYPE_CURSOR)
+	if (amend && plane->type != DRM_PLANE_TYPE_CURSOR)
 		return -EINVAL;
 
 	/*
@@ -1707,9 +1723,10 @@ int drm_atomic_helper_amend_check(struct drm_device *dev,
 	    !try_wait_for_completion(&old_plane_state->commit->hw_done))
 		return -EBUSY;
 
-	return funcs->atomic_amend_check(plane, new_plane_state);
+	return amend ? funcs->atomic_amend_check(plane, new_plane_state) :
+		       funcs->atomic_async_check(plane, new_plane_state);
 }
-EXPORT_SYMBOL(drm_atomic_helper_amend_check);
+EXPORT_SYMBOL(drm_atomic_helper_async_amend_check);
 
 /**
  * drm_atomic_helper_amend_commit - commit state in amend mode
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index d1962cdea602..1d9a6142218e 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1312,8 +1312,9 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
 	state->acquire_ctx = &ctx;
 	state->allow_modeset = !!(arg->flags & DRM_MODE_ATOMIC_ALLOW_MODESET);
+	state->async_update = !!(arg->flags & DRM_MODE_PAGE_FLIP_ASYNC);
 	/* async takes precedence over amend */
-	state->amend_update = arg->flags & DRM_MODE_PAGE_FLIP_ASYNC ? 0 :
+	state->amend_update = state->async_update ? 0 :
 					!!(arg->flags & DRM_MODE_ATOMIC_AMEND);
 
 retry:
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
index 814e8230cec6..e3b2a2c74852 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
@@ -531,6 +531,8 @@ static const struct drm_plane_helper_funcs mdp5_plane_helper_funcs = {
 		.cleanup_fb = mdp5_plane_cleanup_fb,
 		.atomic_check = mdp5_plane_atomic_check,
 		.atomic_update = mdp5_plane_atomic_update,
+		.atomic_async_check = mdp5_plane_atomic_async_check,
+		.atomic_async_update = mdp5_plane_atomic_async_update,
 		/*
 		 * FIXME: ideally, instead of hooking async updates to amend,
 		 * we could avoid tearing by modifying the pending commit.
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 216ad76118dc..c2f7201e52a9 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -954,6 +954,10 @@ static const struct drm_plane_helper_funcs plane_helper_funcs = {
 	.atomic_disable = vop_plane_atomic_disable,
 	.atomic_amend_check = vop_plane_atomic_amend_check,
 	.atomic_amend_update = vop_plane_atomic_amend_update,
+	/*
+	 * Note: rockchip doesn't support async page flip, thus
+	 * .atomic_async_update and .atomic_async_check are not provided.
+	 */
 	.prepare_fb = drm_gem_fb_prepare_fb,
 };
 
diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index ea560000222d..24a9befe89e6 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -1175,6 +1175,8 @@ static const struct drm_plane_helper_funcs vc4_plane_helper_funcs = {
 	 */
 	.atomic_amend_check = vc4_plane_atomic_async_check,
 	.atomic_amend_update = vc4_plane_atomic_async_update,
+	.atomic_async_check = vc4_plane_atomic_async_check,
+	.atomic_async_update = vc4_plane_atomic_async_update,
 };
 
 static void vc4_plane_destroy(struct drm_plane *plane)
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index b1ced069ffc1..05756a09e762 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -300,6 +300,7 @@ struct __drm_private_objs_state {
  * @ref: count of all references to this state (will not be freed until zero)
  * @dev: parent DRM device
  * @legacy_cursor_update: hint to enforce legacy cursor IOCTL semantics
+ * @async_update: hint for asyncronous page flip update
  * @amend_update: hint for amend plane update
  * @planes: pointer to array of structures with per-plane data
  * @crtcs: pointer to array of CRTC pointers
@@ -328,6 +329,7 @@ struct drm_atomic_state {
 	 */
 	bool allow_modeset : 1;
 	bool legacy_cursor_update : 1;
+	bool async_update : 1;
 	bool amend_update : 1;
 	/**
 	 * @duplicated:
diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
index 8ce0594ccfb9..39e57d559a30 100644
--- a/include/drm/drm_atomic_helper.h
+++ b/include/drm/drm_atomic_helper.h
@@ -55,10 +55,11 @@ void drm_atomic_helper_commit_tail_rpm(struct drm_atomic_state *state);
 int drm_atomic_helper_commit(struct drm_device *dev,
 			     struct drm_atomic_state *state,
 			     bool nonblock);
-int drm_atomic_helper_amend_check(struct drm_device *dev,
-				  struct drm_atomic_state *state);
-void drm_atomic_helper_amend_commit(struct drm_device *dev,
-				    struct drm_atomic_state *state);
+int drm_atomic_helper_async_amend_check(struct drm_device *dev,
+					struct drm_atomic_state *state,
+					bool amend);
+void drm_atomic_helper_async_amend_commit(struct drm_device *dev,
+					  struct drm_atomic_state *state);
 
 int drm_atomic_helper_wait_for_fences(struct drm_device *dev,
 					struct drm_atomic_state *state,
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index d92e62dd76c4..c2863d62f160 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -1135,6 +1135,43 @@ struct drm_plane_helper_funcs {
 	void (*atomic_disable)(struct drm_plane *plane,
 			       struct drm_plane_state *old_state);
 
+	/**
+	 * @atomic_async_check:
+	 *
+	 * Drivers should set this function pointer to check if a page flip can
+	 * be performed asynchronously, i.e., immediately without waiting for a
+	 * vblank.
+	 *
+	 * This hook is called by drm_atomic_async_check() to establish if a
+	 * given update can be committed in async mode, that is, if it can
+	 * jump ahead of the state currently queued for update.
+	 *
+	 * RETURNS:
+	 *
+	 * Return 0 on success and any error returned indicates that the update
+	 * can not be applied in asynd mode.
+	 */
+	int (*atomic_async_check)(struct drm_plane *plane,
+				  struct drm_plane_state *state);
+
+	/**
+	 * @atomic_async_update:
+	 *
+	 * Drivers should set this function pointer to perform asynchronous page
+	 * flips through the atomic api, i.e. not vblank synchronized.
+	 *
+	 * Note that unlike &drm_plane_helper_funcs.atomic_update this hook
+	 * takes the new &drm_plane_state as parameter. When doing async_update
+	 * drivers shouldn't replace the &drm_plane_state but update the
+	 * current one with the new plane configurations in the new
+	 * plane_state.
+	 *
+	 * FIXME:
+	 *  - It only works for single plane updates
+	 */
+	void (*atomic_async_update)(struct drm_plane *plane,
+				    struct drm_plane_state *new_state);
+
 	/**
 	 * @atomic_amend_check:
 	 *
-- 
2.20.1

