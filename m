Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB5DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7932521873
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388881AbfHGXrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 19:47:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729624AbfHGXrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 19:47:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B79F13CA0E;
        Wed,  7 Aug 2019 23:47:20 +0000 (UTC)
Received: from whitewolf.redhat.com (ovpn-121-222.rdu2.redhat.com [10.10.121.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF4EB5D9E1;
        Wed,  7 Aug 2019 23:47:19 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drm/nouveau/dispnv04: Remove runtime PM
Date:   Wed,  7 Aug 2019 19:47:05 -0400
Message-Id: <20190807234709.6076-2-lyude@redhat.com>
In-Reply-To: <20190807234709.6076-1-lyude@redhat.com>
References: <20190807234709.6076-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 07 Aug 2019 23:47:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally when trying to fix the issue of runtime PM references with
non-blocking CRTCs on nv50, I ended up stumbling on this code when
trying to remove nouveau_drm->have_disp_power_ref, and attempted to fix
it to remove the dependency on have_disp_power_ref. However, Ilia Mirkin
pointed out that this code is actually completely useless, as pre-nv50
never had runtime PM support in the first place! Go figure.

So, since it's useless just get rid of it. Note that since the only
thing nouveau_crtc_set_config() was doing was grabbing a runtime PM ref,
calling drm_crtc_helper_set_config() then dropping the ref; we can just
remove the function entirely and just call drm_crtc_helper_set_config()
directly.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv04/crtc.c | 51 +------------------------
 1 file changed, 1 insertion(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
index f22f01020625..050eb5b7dd13 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
@@ -22,8 +22,6 @@
  * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  * DEALINGS IN THE SOFTWARE.
  */
-#include <linux/pm_runtime.h>
-
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_plane_helper.h>
@@ -1031,53 +1029,6 @@ nv04_crtc_cursor_move(struct drm_crtc *crtc, int x, int y)
 	return 0;
 }
 
-static int
-nouveau_crtc_set_config(struct drm_mode_set *set,
-			struct drm_modeset_acquire_ctx *ctx)
-{
-	struct drm_device *dev;
-	struct nouveau_drm *drm;
-	int ret;
-	struct drm_crtc *crtc;
-	bool active = false;
-	if (!set || !set->crtc)
-		return -EINVAL;
-
-	dev = set->crtc->dev;
-
-	/* get a pm reference here */
-	ret = pm_runtime_get_sync(dev->dev);
-	if (ret < 0 && ret != -EACCES)
-		return ret;
-
-	ret = drm_crtc_helper_set_config(set, ctx);
-
-	drm = nouveau_drm(dev);
-
-	/* if we get here with no crtcs active then we can drop a reference */
-	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
-		if (crtc->enabled)
-			active = true;
-	}
-
-	pm_runtime_mark_last_busy(dev->dev);
-	/* if we have active crtcs and we don't have a power ref,
-	   take the current one */
-	if (active && !drm->have_disp_power_ref) {
-		drm->have_disp_power_ref = true;
-		return ret;
-	}
-	/* if we have no active crtcs, then drop the power ref
-	   we got before */
-	if (!active && drm->have_disp_power_ref) {
-		pm_runtime_put_autosuspend(dev->dev);
-		drm->have_disp_power_ref = false;
-	}
-	/* drop the power reference we got coming in here */
-	pm_runtime_put_autosuspend(dev->dev);
-	return ret;
-}
-
 struct nv04_page_flip_state {
 	struct list_head head;
 	struct drm_pending_vblank_event *event;
@@ -1293,7 +1244,7 @@ static const struct drm_crtc_funcs nv04_crtc_funcs = {
 	.cursor_set = nv04_crtc_cursor_set,
 	.cursor_move = nv04_crtc_cursor_move,
 	.gamma_set = nv_crtc_gamma_set,
-	.set_config = nouveau_crtc_set_config,
+	.set_config = drm_crtc_helper_set_config,
 	.page_flip = nv04_crtc_page_flip,
 	.destroy = nv_crtc_destroy,
 };
-- 
2.21.0

