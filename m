Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B190C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63C52186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfDLM7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:59:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34544 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfDLM7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:59:16 -0400
Received: from localhost.localdomain (unknown [IPv6:2804:431:9718:a5e8:c168:522a:50d5:d06d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: koike)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7785B2811D1;
        Fri, 12 Apr 2019 13:59:09 +0100 (BST)
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
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH RFC v3 3/4] drm/atomic: add ATOMIC_AMEND flag to the Atomic IOCTL.
Date:   Fri, 12 Apr 2019 09:58:26 -0300
Message-Id: <20190412125827.5877-4-helen.koike@collabora.com>
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

This flag tells core to jump ahead the queued update if the conditions
in drm_atomic_amend_check() are met. That means we are only able to do an
amend update if no modeset is pending and update for the same plane is
not queued.

It uses the already in place infrastructure for amend updates.

It is useful for cursor updates over the atomic ioctl.
Otherwise in some cases updates may be delayed to the point the
user will notice it.
Note that for now it's only enabled for cursor planes.

DRM_MODE_ATOMIC_AMEND should be passed to the Atomic IOCTL to use this
feature.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
[updated for upstream]
Signed-off-by: Helen Koike <helen.koike@collabora.com>
---
Hi,

This is the third attempt to introduce the new ATOMIC_AMEND flag for atomic
operations, see the commit message for a more detailed description.
I am sending this patch in the series as an RFC as I still have things
to define/discuss.

The main reasons to expose this through atomic api is to avoid mixing legacy
with modern/atomic API (since their interactions are not well defined)
and to be able to explicitly manage the cursor plane.

The way I envision it working is:

1) userspace just use DRM_MODE_PAGE_FLIP_ASYNC if true async is desired.
2) if it fails, then userspace can try DRM_MODE_ATOMIC_AMEND if true async is
not required, but a legacy cursor behavior is required
3) if amend is not possible, we can or:
        A) fallback to a non amend update
        B) fail
        C) add another flag to define what it should do.

Right now the code does A for legacy cursor and B for atomic api using
the DRM_MODE_ATOMIC_AMEND flag.
Discussing with some people it seems that failing is better for Xorg,
but Ozone (chrome compositor) doesn't expect the amend to fail, but I
think it could just retry the same atomic commit without the AMEND flag
if it wants to fallback.

Alexandros also did a proof-of-concept to use this flag and draw cursors
using atomic if possible on ozone (Chrome compositor) [1].

I'm sending this as an RFC for now as I still need to verify the
requirements from other compositors and make some tests (and also to
justify the s/async/amend renaming).

Please, let me know if you detect issues with this.
If not, I'll start implementing tests in igt and push the adoption in
other compositors.

Thanks
Helen

[1] https://chromium-review.googlesource.com/c/chromium/src/+/1092711
[2] https://gitlab.collabora.com/eballetbo/drm-cursor/commits/async-capability


Changes in v3:
- rebase tree
- rebase on top of renaming async_update to amend_update
- improve documentation
- don't fall back to a normal commit if amend is not possible when
requested through the atomic api

Changes in v2:
- rebase tree
- do not fall back to a non-async update if if there isn't any
pending commit to amend

Changes in v1:
- https://patchwork.freedesktop.org/patch/243088/
- Only enable it if userspace requests it.
- Only allow async update for cursor type planes.
- Rename ASYNC_UPDATE for ATOMIC_AMEND.

 drivers/gpu/drm/drm_atomic_helper.c | 39 +++++++++++++++++++++++------
 drivers/gpu/drm/drm_atomic_uapi.c   |  8 ++++++
 include/uapi/drm/drm_mode.h         |  9 ++++++-
 3 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index eb5dcd84fea7..9b0df08836c3 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -947,10 +947,18 @@ int drm_atomic_helper_check(struct drm_device *dev,
 	if (ret)
 		return ret;
 
+	/*
+	 * If amend was explicitly requested, but it is not possible,
+	 * return error instead of falling back to a normal commit.
+	 */
+	if (state->amend_update)
+		return drm_atomic_helper_amend_check(dev, state);
+
+	/* Legacy mode falls back to a normal commit if amend isn't possible. */
 	if (state->legacy_cursor_update)
 		state->amend_update = !drm_atomic_helper_amend_check(dev, state);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(drm_atomic_helper_check);
 
@@ -1574,12 +1582,20 @@ static void commit_work(struct work_struct *work)
  * The amend feature provides a way to perform 1000 updates to be applied as
  * soon as possible without waiting for 1000 vblanks.
 
- * Currently, only the legacy cursor update uses amend mode, where historically,
+ * Legacy cursor update uses amend mode, where historically,
  * userspace performs several updates before the next vblank and don't want to
  * see a delay in the cursor's movement.
  * If amend is not supported, legacy cursor falls back to a normal sync update.
  *
- * To implement the legacy cursor update, drivers should provide
+ * Amend can also be performed through the atomic API using the flag
+ * DRM_MODE_ATOMIC_AMEND. The atomic commit will fail if this flag is set but
+ * the driver doesn't support it.
+ * Amend can't perform modeset, thus atomic API will fail if
+ * DRM_MODE_ATOMIC_AMEND is used in conjunction with
+ * DRM_MODE_ATOMIC_ALLOW_MODESET flag.
+ *
+ * To implement the legacy cursor update and amend mode through atomic, drivers
+ * should provide:
  * &drm_plane_helper_funcs.atomic_amend_check() and
  * &drm_plane_helper_funcs.atomic_amend_update()
  *
@@ -1601,16 +1617,21 @@ static void commit_work(struct work_struct *work)
  *
  * Notes / highlights:
  *
- * - amend update is performed on legacy cursor updates.
+ * - amend update is performed on legacy cursor updates, but it will fallback to
+ *   a normal commit if amend is not possible. However, if amend was requested
+ *   through atomic, the ioctl will fail instead of fall back if it can't be
+ *   amended.
+ *
+ * - atomic api will reject amend if DRM_MODE_ATOMIC_ALLOW_MODESET flag is used.
+ *
+ * - If DRM_MODE_PAGE_FLIP_ASYNC is set, then the DRM_MODE_ATOMIC_AMEND flag
+ *   will be ignored.
  *
  * - amend update won't happen if there is an outstanding commit modifying the
  *   same plane.
  *
  * - amend update won't happen if atomic_amend_check() returns false.
  *
- * - if atomic_amend_check() fails, it falls back to a normal synchronous
- *   update.
- *
  * - if userspace wants to ensure an asynchronous page flip, i.e. change hw
  *   state immediately, see DRM_MODE_PAGE_FLIP_ASYNC flag
  *   (asynchronous page flip maintains the amend property by definition).
@@ -1673,6 +1694,10 @@ int drm_atomic_helper_amend_check(struct drm_device *dev,
 	if (new_plane_state->fence)
 		return -EINVAL;
 
+	/* Only allow amend update for cursor type planes. */
+	if (plane->type != DRM_PLANE_TYPE_CURSOR)
+		return -EINVAL;
+
 	/*
 	 * Don't do an amend update if there is an outstanding commit modifying
 	 * the plane.
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 4eb81f10bc54..d1962cdea602 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -28,6 +28,7 @@
 
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_atomic.h>
+#include <drm/drm_atomic_uapi.h>
 #include <drm/drm_print.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_writeback.h>
@@ -1300,6 +1301,10 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 			(arg->flags & DRM_MODE_PAGE_FLIP_EVENT))
 		return -EINVAL;
 
+	if ((arg->flags & DRM_MODE_ATOMIC_ALLOW_MODESET) &&
+			(arg->flags & DRM_MODE_ATOMIC_AMEND))
+		return -EINVAL;
+
 	state = drm_atomic_state_alloc(dev);
 	if (!state)
 		return -ENOMEM;
@@ -1307,6 +1312,9 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
 	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
 	state->acquire_ctx = &ctx;
 	state->allow_modeset = !!(arg->flags & DRM_MODE_ATOMIC_ALLOW_MODESET);
+	/* async takes precedence over amend */
+	state->amend_update = arg->flags & DRM_MODE_PAGE_FLIP_ASYNC ? 0 :
+					!!(arg->flags & DRM_MODE_ATOMIC_AMEND);
 
 retry:
 	copied_objs = 0;
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 88ef2cf04d13..3831d04f3b38 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -743,19 +743,26 @@ struct drm_mode_destroy_dumb {
  *
  * DRM_MODE_ATOMIC_ALLOW_MODESET
  * Indicates whether a full modeset is acceptable or not.
+ *
+ * DRM_MODE_ATOMIC_AMEND
+ * Used to perform an atomic amend. See "DOC: amend mode atomic commit" in
+ * drm_atomic_helper.c for more details.
+ * This flag can't be used with DRM_MODE_ATOMIC_ALLOW_MODESET.
  */
 
 /*  */
 #define DRM_MODE_ATOMIC_TEST_ONLY 0x0100
 #define DRM_MODE_ATOMIC_NONBLOCK  0x0200
 #define DRM_MODE_ATOMIC_ALLOW_MODESET 0x0400
+#define DRM_MODE_ATOMIC_AMEND 0x0800
 
 #define DRM_MODE_ATOMIC_FLAGS (\
 		DRM_MODE_PAGE_FLIP_EVENT |\
 		DRM_MODE_PAGE_FLIP_ASYNC |\
 		DRM_MODE_ATOMIC_TEST_ONLY |\
 		DRM_MODE_ATOMIC_NONBLOCK |\
-		DRM_MODE_ATOMIC_ALLOW_MODESET)
+		DRM_MODE_ATOMIC_ALLOW_MODESET |\
+		DRM_MODE_ATOMIC_AMEND)
 
 struct drm_mode_atomic {
 	__u32 flags;
-- 
2.20.1

