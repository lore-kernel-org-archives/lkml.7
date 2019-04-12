Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853D7C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E4620818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfDLM7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:59:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34540 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfDLM7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:59:11 -0400
Received: from localhost.localdomain (unknown [IPv6:2804:431:9718:a5e8:c168:522a:50d5:d06d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: koike)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 95480281296;
        Fri, 12 Apr 2019 13:58:58 +0100 (BST)
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
        linux-doc@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Maxime Ripard <maxime.ripard@bootlin.com>,
        freedreno@lists.freedesktop.org,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 2/4] drm/atomic: rename async_{update,check} to amend_{update,check}
Date:   Fri, 12 Apr 2019 09:58:25 -0300
Message-Id: <20190412125827.5877-3-helen.koike@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412125827.5877-1-helen.koike@collabora.com>
References: <20190412125827.5877-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Asynchronous update is the ability change the hw state at any time, not
only during vblank.

Amend mode is the ability to perform 1000 commits to be applied as soon
as possible without waiting for 1000 vblanks.

async updates can be seen as amend, but the opposite is not true.

&drm_plane_helper_funcs.atomic_async_{update,check}() was being used by
drivers to implement amend and not async. So rename them to amend.

Also improve docs explaining the difference.

If asynchronous is required, normal page flip can be performed using
DRM_MODE_PAGE_FLIP_ASYNC flag.

Signed-off-by: Helen Koike <helen.koike@collabora.com>

---
Hello,

I would like to officially clarify what async update means by adding it
in the docs.
Please correct me if I am wrong, but the current async_{update,check}
callbacks are being used to do amend (the legacy cursor behavior), i.e.
to allow 1000 updates without waiting for 1000 vblanks.

So I would like to clarify this in the docs and rename the current
callbacks to reflect this behaviour.

I also see that for real async updates, the flag
DRM_MODE_PAGE_FLIP_ASYNC can be used in a normal sync update (it is
already being used by some drivers actually, in the atomic path, not only
in the legacy page flip, at least is what I understood from
amdgpu_dm_atomic_commit_tail() implementation).

Please, let me know if I misunderstood anything. Otherwise renaming and
improving the docs would put us all in sync.

Thanks!
Helen

Changes in v3: None
Changes in v2: None
Changes in v1: None

 Documentation/gpu/drm-kms-helpers.rst         |   8 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  10 +-
 drivers/gpu/drm/drm_atomic_helper.c           | 111 +++++++++++++-----
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c    |   8 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c   |   8 +-
 drivers/gpu/drm/vc4/vc4_kms.c                 |   4 +-
 drivers/gpu/drm/vc4/vc4_plane.c               |   8 +-
 include/drm/drm_atomic.h                      |   4 +-
 include/drm/drm_atomic_helper.h               |   4 +-
 include/drm/drm_modeset_helper_vtables.h      |  38 +++---
 10 files changed, 139 insertions(+), 64 deletions(-)

diff --git a/Documentation/gpu/drm-kms-helpers.rst b/Documentation/gpu/drm-kms-helpers.rst
index 58b375e47615..c067a196902d 100644
--- a/Documentation/gpu/drm-kms-helpers.rst
+++ b/Documentation/gpu/drm-kms-helpers.rst
@@ -53,12 +53,18 @@ Overview
 .. kernel-doc:: drivers/gpu/drm/drm_atomic_helper.c
    :doc: overview
 
-Implementing Asynchronous Atomic Commit
+Implementing Nonblocking Atomic Commit
 ---------------------------------------
 
 .. kernel-doc:: drivers/gpu/drm/drm_atomic_helper.c
    :doc: implementing nonblocking commit
 
+Amend Mode Atomic Commit
+------------------------
+
+.. kernel-doc:: drivers/gpu/drm/drm_atomic_helper.c
+   :doc: amend mode atomic commit
+
 Helper Functions Reference
 --------------------------
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2f26581b93ff..711e7715e112 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3779,8 +3779,12 @@ static const struct drm_plane_helper_funcs dm_plane_helper_funcs = {
 	.prepare_fb = dm_plane_helper_prepare_fb,
 	.cleanup_fb = dm_plane_helper_cleanup_fb,
 	.atomic_check = dm_plane_atomic_check,
-	.atomic_async_check = dm_plane_atomic_async_check,
-	.atomic_async_update = dm_plane_atomic_async_update
+	/*
+	 * FIXME: ideally, instead of hooking async updates to amend,
+	 * we could avoid tearing by modifying the pending commit.
+	 */
+	.atomic_amend_check = dm_plane_atomic_async_check,
+	.atomic_amend_update = dm_plane_atomic_async_update
 };
 
 /*
@@ -6140,7 +6144,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		 * helper, check if it can be done asynchronously for better
 		 * performance.
 		 */
-		state->async_update = !drm_atomic_helper_async_check(dev, state);
+		state->amend_update = !drm_atomic_helper_amend_check(dev, state);
 	}
 
 	/* Must be success */
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 2453678d1186..eb5dcd84fea7 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -948,7 +948,7 @@ int drm_atomic_helper_check(struct drm_device *dev,
 		return ret;
 
 	if (state->legacy_cursor_update)
-		state->async_update = !drm_atomic_helper_async_check(dev, state);
+		state->amend_update = !drm_atomic_helper_amend_check(dev, state);
 
 	return ret;
 }
@@ -1569,19 +1569,68 @@ static void commit_work(struct work_struct *work)
 }
 
 /**
- * drm_atomic_helper_async_check - check if state can be commited asynchronously
+ * DOC: amend mode atomic commit
+ *
+ * The amend feature provides a way to perform 1000 updates to be applied as
+ * soon as possible without waiting for 1000 vblanks.
+
+ * Currently, only the legacy cursor update uses amend mode, where historically,
+ * userspace performs several updates before the next vblank and don't want to
+ * see a delay in the cursor's movement.
+ * If amend is not supported, legacy cursor falls back to a normal sync update.
+ *
+ * To implement the legacy cursor update, drivers should provide
+ * &drm_plane_helper_funcs.atomic_amend_check() and
+ * &drm_plane_helper_funcs.atomic_amend_update()
+ *
+ * Drivers just need to make sure the last state overrides the previous one, so
+ * that if X updates were performed, then, in some point in the near future,
+ * preferentially in the next vblank, the Xth state will be the hardware state.
+ *
+ * If the hardware supports asynchronous update, i.e, changing its state without
+ * waiting for vblank, then &drm_plane_helper_funcs.atomic_amend_update() can be
+ * implemented using asynchronous update (the amend mode property is held), but
+ * it can cause tearing in the image.
+ *
+ * Otherwise (if async is not supported by the hw), drivers need to override the
+ * commit to be applied in the next vblank, and also they need to take care of
+ * framebuffer references when programming a new framebuffer, as hw can still be
+ * scanning out the old framebuffer. For now drivers must implement their own
+ * workers for deferring if needed, until a common solution is created.
+ *
+ *
+ * Notes / highlights:
+ *
+ * - amend update is performed on legacy cursor updates.
+ *
+ * - amend update won't happen if there is an outstanding commit modifying the
+ *   same plane.
+ *
+ * - amend update won't happen if atomic_amend_check() returns false.
+ *
+ * - if atomic_amend_check() fails, it falls back to a normal synchronous
+ *   update.
+ *
+ * - if userspace wants to ensure an asynchronous page flip, i.e. change hw
+ *   state immediately, see DRM_MODE_PAGE_FLIP_ASYNC flag
+ *   (asynchronous page flip maintains the amend property by definition).
+ *
+ * - Asynchronous modeset doesn't make sense, only asynchronous page flip.
+ */
+
+/**
+ * drm_atomic_helper_amend_check - check if state can be amended.
  * @dev: DRM device
  * @state: the driver state object
  *
- * This helper will check if it is possible to commit the state asynchronously.
- * Async commits are not supposed to swap the states like normal sync commits
- * but just do in-place changes on the current state.
+ * This helper will check if it is possible perform a commit in amend mode.
+ * For amend mode definition see :doc: amend mode atomic commit
  *
- * It will return 0 if the commit can happen in an asynchronous fashion or error
- * if not. Note that error just mean it can't be commited asynchronously, if it
- * fails the commit should be treated like a normal synchronous commit.
+ * It will return 0 if the commit can happen in an amend fashion or error
+ * if not. Note that error just mean it can't be committed in amend mode, if it
+ * fails the commit should be treated like a normal commit.
  */
-int drm_atomic_helper_async_check(struct drm_device *dev,
+int drm_atomic_helper_amend_check(struct drm_device *dev,
 				   struct drm_atomic_state *state)
 {
 	struct drm_crtc *crtc;
@@ -1610,7 +1659,7 @@ int drm_atomic_helper_async_check(struct drm_device *dev,
 
 	/*
 	 * FIXME: Since prepare_fb and cleanup_fb are always called on
-	 * the new_plane_state for async updates we need to block framebuffer
+	 * the new_plane_state for amend updates, we need to block framebuffer
 	 * changes. This prevents use of a fb that's been cleaned up and
 	 * double cleanups from occuring.
 	 */
@@ -1618,37 +1667,43 @@ int drm_atomic_helper_async_check(struct drm_device *dev,
 		return -EINVAL;
 
 	funcs = plane->helper_private;
-	if (!funcs->atomic_async_update)
+	if (!funcs->atomic_amend_update)
 		return -EINVAL;
 
 	if (new_plane_state->fence)
 		return -EINVAL;
 
 	/*
-	 * Don't do an async update if there is an outstanding commit modifying
-	 * the plane.  This prevents our async update's changes from getting
-	 * overridden by a previous synchronous update's state.
+	 * Don't do an amend update if there is an outstanding commit modifying
+	 * the plane.
+	 * TODO: add support for modifying the outstanding commit.
 	 */
 	if (old_plane_state->commit &&
 	    !try_wait_for_completion(&old_plane_state->commit->hw_done))
 		return -EBUSY;
 
-	return funcs->atomic_async_check(plane, new_plane_state);
+	return funcs->atomic_amend_check(plane, new_plane_state);
 }
-EXPORT_SYMBOL(drm_atomic_helper_async_check);
+EXPORT_SYMBOL(drm_atomic_helper_amend_check);
 
 /**
- * drm_atomic_helper_async_commit - commit state asynchronously
+ * drm_atomic_helper_amend_commit - commit state in amend mode
  * @dev: DRM device
  * @state: the driver state object
  *
- * This function commits a state asynchronously, i.e., not vblank
- * synchronized. It should be used on a state only when
- * drm_atomic_async_check() succeeds. Async commits are not supposed to swap
- * the states like normal sync commits, but just do in-place changes on the
- * current state.
+ * This function commits a state in amend mode.
+ * For amend mode definition see :doc: amend mode atomic commit
+ *
+ * It should be used on a state only when drm_atomic_amend_check() succeeds.
+ *
+ * Amend commits are not supposed to swap the states like normal sync commits,
+ * but just do in-place changes on the current state.
+ *
+ * TODO: instead of doing in-place changes, modify the new_state and perform an
+ * immediate flip. Drivers could reuse the page_flip code and even use the
+ * DRM_MODE_PAGE_FLIP_ASYNC flag if the hardware supports asyncronous update.
  */
-void drm_atomic_helper_async_commit(struct drm_device *dev,
+void drm_atomic_helper_amend_commit(struct drm_device *dev,
 				    struct drm_atomic_state *state)
 {
 	struct drm_plane *plane;
@@ -1658,10 +1713,10 @@ void drm_atomic_helper_async_commit(struct drm_device *dev,
 
 	for_each_new_plane_in_state(state, plane, plane_state, i) {
 		funcs = plane->helper_private;
-		funcs->atomic_async_update(plane, plane_state);
+		funcs->atomic_amend_update(plane, plane_state);
 
 		/*
-		 * ->atomic_async_update() is supposed to update the
+		 * ->atomic_amend_update() is supposed to update the
 		 * plane->state in-place, make sure at least common
 		 * properties have been properly updated.
 		 */
@@ -1672,7 +1727,7 @@ void drm_atomic_helper_async_commit(struct drm_device *dev,
 		WARN_ON_ONCE(plane->state->src_y != plane_state->src_y);
 	}
 }
-EXPORT_SYMBOL(drm_atomic_helper_async_commit);
+EXPORT_SYMBOL(drm_atomic_helper_amend_commit);
 
 /**
  * drm_atomic_helper_commit - commit validated state object
@@ -1698,12 +1753,12 @@ int drm_atomic_helper_commit(struct drm_device *dev,
 {
 	int ret;
 
-	if (state->async_update) {
+	if (state->amend_update) {
 		ret = drm_atomic_helper_prepare_planes(dev, state);
 		if (ret)
 			return ret;
 
-		drm_atomic_helper_async_commit(dev, state);
+		drm_atomic_helper_amend_commit(dev, state);
 		drm_atomic_helper_cleanup_planes(dev, state);
 
 		return 0;
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
index be13140967b4..814e8230cec6 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c
@@ -531,8 +531,12 @@ static const struct drm_plane_helper_funcs mdp5_plane_helper_funcs = {
 		.cleanup_fb = mdp5_plane_cleanup_fb,
 		.atomic_check = mdp5_plane_atomic_check,
 		.atomic_update = mdp5_plane_atomic_update,
-		.atomic_async_check = mdp5_plane_atomic_async_check,
-		.atomic_async_update = mdp5_plane_atomic_async_update,
+		/*
+		 * FIXME: ideally, instead of hooking async updates to amend,
+		 * we could avoid tearing by modifying the pending commit.
+		 */
+		.atomic_amend_check = mdp5_plane_atomic_async_check,
+		.atomic_amend_update = mdp5_plane_atomic_async_update,
 };
 
 static void set_scanout_locked(struct mdp5_kms *mdp5_kms,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index a7cbf6c9a153..216ad76118dc 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -877,7 +877,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	spin_unlock(&vop->reg_lock);
 }
 
-static int vop_plane_atomic_async_check(struct drm_plane *plane,
+static int vop_plane_atomic_amend_check(struct drm_plane *plane,
 					struct drm_plane_state *state)
 {
 	struct vop_win *vop_win = to_vop_win(plane);
@@ -908,7 +908,7 @@ static int vop_plane_atomic_async_check(struct drm_plane *plane,
 						   true, true);
 }
 
-static void vop_plane_atomic_async_update(struct drm_plane *plane,
+static void vop_plane_atomic_amend_update(struct drm_plane *plane,
 					  struct drm_plane_state *new_state)
 {
 	struct vop *vop = to_vop(plane->state->crtc);
@@ -952,8 +952,8 @@ static const struct drm_plane_helper_funcs plane_helper_funcs = {
 	.atomic_check = vop_plane_atomic_check,
 	.atomic_update = vop_plane_atomic_update,
 	.atomic_disable = vop_plane_atomic_disable,
-	.atomic_async_check = vop_plane_atomic_async_check,
-	.atomic_async_update = vop_plane_atomic_async_update,
+	.atomic_amend_check = vop_plane_atomic_amend_check,
+	.atomic_amend_update = vop_plane_atomic_amend_update,
 	.prepare_fb = drm_gem_fb_prepare_fb,
 };
 
diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index 295dacc8bcb9..229032b1b315 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -216,7 +216,7 @@ static int vc4_atomic_commit(struct drm_device *dev,
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	int ret;
 
-	if (state->async_update) {
+	if (state->amend_update) {
 		ret = down_interruptible(&vc4->async_modeset);
 		if (ret)
 			return ret;
@@ -227,7 +227,7 @@ static int vc4_atomic_commit(struct drm_device *dev,
 			return ret;
 		}
 
-		drm_atomic_helper_async_commit(dev, state);
+		drm_atomic_helper_amend_commit(dev, state);
 
 		drm_atomic_helper_cleanup_planes(dev, state);
 
diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 4d918d3e4858..ea560000222d 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -1169,8 +1169,12 @@ static const struct drm_plane_helper_funcs vc4_plane_helper_funcs = {
 	.atomic_update = vc4_plane_atomic_update,
 	.prepare_fb = vc4_prepare_fb,
 	.cleanup_fb = vc4_cleanup_fb,
-	.atomic_async_check = vc4_plane_atomic_async_check,
-	.atomic_async_update = vc4_plane_atomic_async_update,
+	/*
+	 * FIXME: ideally, instead of hooking async updates to amend,
+	 * we could avoid tearing by modifying the pending commit.
+	 */
+	.atomic_amend_check = vc4_plane_atomic_async_check,
+	.atomic_amend_update = vc4_plane_atomic_async_update,
 };
 
 static void vc4_plane_destroy(struct drm_plane *plane)
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 824a5ed4e216..b1ced069ffc1 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -300,7 +300,7 @@ struct __drm_private_objs_state {
  * @ref: count of all references to this state (will not be freed until zero)
  * @dev: parent DRM device
  * @legacy_cursor_update: hint to enforce legacy cursor IOCTL semantics
- * @async_update: hint for asynchronous plane update
+ * @amend_update: hint for amend plane update
  * @planes: pointer to array of structures with per-plane data
  * @crtcs: pointer to array of CRTC pointers
  * @num_connector: size of the @connectors and @connector_states arrays
@@ -328,7 +328,7 @@ struct drm_atomic_state {
 	 */
 	bool allow_modeset : 1;
 	bool legacy_cursor_update : 1;
-	bool async_update : 1;
+	bool amend_update : 1;
 	/**
 	 * @duplicated:
 	 *
diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
index 58214be3bf3d..8ce0594ccfb9 100644
--- a/include/drm/drm_atomic_helper.h
+++ b/include/drm/drm_atomic_helper.h
@@ -55,9 +55,9 @@ void drm_atomic_helper_commit_tail_rpm(struct drm_atomic_state *state);
 int drm_atomic_helper_commit(struct drm_device *dev,
 			     struct drm_atomic_state *state,
 			     bool nonblock);
-int drm_atomic_helper_async_check(struct drm_device *dev,
+int drm_atomic_helper_amend_check(struct drm_device *dev,
 				  struct drm_atomic_state *state);
-void drm_atomic_helper_async_commit(struct drm_device *dev,
+void drm_atomic_helper_amend_commit(struct drm_device *dev,
 				    struct drm_atomic_state *state);
 
 int drm_atomic_helper_wait_for_fences(struct drm_device *dev,
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index cfb7be40bed7..d92e62dd76c4 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -1136,53 +1136,55 @@ struct drm_plane_helper_funcs {
 			       struct drm_plane_state *old_state);
 
 	/**
-	 * @atomic_async_check:
+	 * @atomic_amend_check:
 	 *
 	 * Drivers should set this function pointer to check if the plane state
-	 * can be updated in a async fashion. Here async means "not vblank
-	 * synchronized".
+	 * can be updated in amend mode.
+	 * For amend mode definition see :doc: amend mode atomic commit
 	 *
-	 * This hook is called by drm_atomic_async_check() to establish if a
-	 * given update can be committed asynchronously, that is, if it can
+	 * This hook is called by drm_atomic_amend_check() to establish if a
+	 * given update can be committed in amend mode, that is, if it can
 	 * jump ahead of the state currently queued for update.
 	 *
 	 * RETURNS:
 	 *
 	 * Return 0 on success and any error returned indicates that the update
-	 * can not be applied in asynchronous manner.
+	 * can not be applied in amend mode.
 	 */
-	int (*atomic_async_check)(struct drm_plane *plane,
+	int (*atomic_amend_check)(struct drm_plane *plane,
 				  struct drm_plane_state *state);
 
 	/**
-	 * @atomic_async_update:
+	 * @atomic_amend_update:
 	 *
-	 * Drivers should set this function pointer to perform asynchronous
-	 * updates of planes, that is, jump ahead of the currently queued
-	 * state and update the plane. Here async means "not vblank
-	 * synchronized".
+	 * Drivers should set this function pointer to perform amend
+	 * updates of planes.
+	 * The amend feature provides a way to perform 1000 commits, without
+	 * waiting for 1000 vblanks to get the last state applied.
 	 *
-	 * This hook is called by drm_atomic_helper_async_commit().
+	 * For amend mode definition see :doc: amend mode atomic commit
 	 *
-	 * An async update will happen on legacy cursor updates. An async
+	 * This hook is called by drm_atomic_helper_amend_commit().
+	 *
+	 * An amend update will happen on legacy cursor updates. An amend
 	 * update won't happen if there is an outstanding commit modifying
 	 * the same plane.
 	 *
 	 * Note that unlike &drm_plane_helper_funcs.atomic_update this hook
-	 * takes the new &drm_plane_state as parameter. When doing async_update
+	 * takes the new &drm_plane_state as parameter. When doing amend_update
 	 * drivers shouldn't replace the &drm_plane_state but update the
 	 * current one with the new plane configurations in the new
 	 * plane_state.
 	 *
 	 * FIXME:
 	 *  - It only works for single plane updates
-	 *  - Async Pageflips are not supported yet
-	 *  - Some hw might still scan out the old buffer until the next
+	 *  - If hardware don't support asyncronous update to implement amend,
+	 *    some hw might still scan out the old buffer until the next
 	 *    vblank, however we let go of the fb references as soon as
 	 *    we run this hook. For now drivers must implement their own workers
 	 *    for deferring if needed, until a common solution is created.
 	 */
-	void (*atomic_async_update)(struct drm_plane *plane,
+	void (*atomic_amend_update)(struct drm_plane *plane,
 				    struct drm_plane_state *new_state);
 };
 
-- 
2.20.1

