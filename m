Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45CCC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18F021872
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389524AbfHGVdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 17:33:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389484AbfHGVdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 17:33:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A66A330C75BF;
        Wed,  7 Aug 2019 21:33:23 +0000 (UTC)
Received: from whitewolf.redhat.com (ovpn-121-222.rdu2.redhat.com [10.10.121.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5005B600C6;
        Wed,  7 Aug 2019 21:33:22 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Karol Herbst <karolherbst@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/nouveau/dispnv50: Fix runtime PM ref tracking for non-blocking modesets
Date:   Wed,  7 Aug 2019 17:33:01 -0400
Message-Id: <20190807213304.9255-3-lyude@redhat.com>
In-Reply-To: <20190807213304.9255-1-lyude@redhat.com>
References: <20190807213304.9255-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 07 Aug 2019 21:33:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is something that got noticed a while ago back when I was fixing a
large number of runtime PM related issues in nouveau, but never got
fixed:

https://patchwork.freedesktop.org/series/46815/#rev7

It's not safe to iterate the entire list of CRTCs in
nv50_disp_atomic_commit(), as we could be doing a non-blocking modeset
on one CRTC in parallel with one or more other CRTCs. Likewise, this
means it's also not safe to do so in order to track runtime PM state.
While this code is certainly wrong, so far the only issues I've seen
this cause in the wild is the occasional PM ref unbalance after an
atomic check failure + module reloading (since the PCI device will
outlive nouveau in such scenarios).

So, do this far more elegantly: grab a runtime PM ref across the modeset
and commit tail, then grab/put references for each CRTC enable/disable.
This also ends up being much simpler then the previous broken solution
we had.

Finally, since we've removed all it's users: get rid of
nouveau_drm->have_disp_power_ref.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 38 +++++++++++--------------
 drivers/gpu/drm/nouveau/nouveau_drv.h   |  3 --
 2 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 126703816794..659e6fa645cb 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1826,8 +1826,11 @@ nv50_disp_atomic_commit_tail(struct drm_atomic_state *state)
 
 		NV_ATOMIC(drm, "%s: clr %04x (set %04x)\n", crtc->name,
 			  asyh->clr.mask, asyh->set.mask);
-		if (old_crtc_state->active && !new_crtc_state->active)
+
+		if (old_crtc_state->active && !new_crtc_state->active) {
+			pm_runtime_put_noidle(dev->dev);
 			drm_crtc_vblank_off(crtc);
+		}
 
 		if (asyh->clr.mask) {
 			nv50_head_flush_clr(head, asyh, atom->flush_disable);
@@ -1913,8 +1916,10 @@ nv50_disp_atomic_commit_tail(struct drm_atomic_state *state)
 		}
 
 		if (new_crtc_state->active) {
-			if (!old_crtc_state->active)
+			if (!old_crtc_state->active) {
 				drm_crtc_vblank_on(crtc);
+				pm_runtime_get_noresume(dev->dev);
+			}
 			if (new_crtc_state->event)
 				drm_crtc_vblank_get(crtc);
 		}
@@ -1979,6 +1984,10 @@ nv50_disp_atomic_commit_tail(struct drm_atomic_state *state)
 	drm_atomic_helper_cleanup_planes(dev, state);
 	drm_atomic_helper_commit_cleanup_done(state);
 	drm_atomic_state_put(state);
+
+	/* Drop the RPM ref we got from nv50_disp_atomic_commit() */
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
 }
 
 static void
@@ -1993,11 +2002,8 @@ static int
 nv50_disp_atomic_commit(struct drm_device *dev,
 			struct drm_atomic_state *state, bool nonblock)
 {
-	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct drm_plane_state *new_plane_state;
 	struct drm_plane *plane;
-	struct drm_crtc *crtc;
-	bool active = false;
 	int ret, i;
 
 	ret = pm_runtime_get_sync(dev->dev);
@@ -2034,27 +2040,17 @@ nv50_disp_atomic_commit(struct drm_device *dev,
 
 	drm_atomic_state_get(state);
 
+	/*
+	 * Grab another RPM ref for the commit tail, which will release the
+	 * ref when it's finished
+	 */
+	pm_runtime_get_noresume(dev->dev);
+
 	if (nonblock)
 		queue_work(system_unbound_wq, &state->commit_work);
 	else
 		nv50_disp_atomic_commit_tail(state);
 
-	drm_for_each_crtc(crtc, dev) {
-		if (crtc->state->active) {
-			if (!drm->have_disp_power_ref) {
-				drm->have_disp_power_ref = true;
-				return 0;
-			}
-			active = true;
-			break;
-		}
-	}
-
-	if (!active && drm->have_disp_power_ref) {
-		pm_runtime_put_autosuspend(dev->dev);
-		drm->have_disp_power_ref = false;
-	}
-
 err_cleanup:
 	if (ret)
 		drm_atomic_helper_cleanup_planes(dev, state);
diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
index aae035816383..411352dd5390 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drv.h
+++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
@@ -204,9 +204,6 @@ struct nouveau_drm {
 	/* led management */
 	struct nouveau_led *led;
 
-	/* display power reference */
-	bool have_disp_power_ref;
-
 	struct dev_pm_domain vga_pm_domain;
 
 	struct nouveau_svm *svm;
-- 
2.21.0

