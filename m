Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69B8C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B3F21871
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389508AbfHGVdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 17:33:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389484AbfHGVdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 17:33:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8AE053DE02;
        Wed,  7 Aug 2019 21:33:20 +0000 (UTC)
Received: from whitewolf.redhat.com (ovpn-121-222.rdu2.redhat.com [10.10.121.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F0ED600C6;
        Wed,  7 Aug 2019 21:33:19 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/nouveau/dispnv04: Grab/put runtime PM refs on DPMS on/off
Date:   Wed,  7 Aug 2019 17:33:00 -0400
Message-Id: <20190807213304.9255-2-lyude@redhat.com>
In-Reply-To: <20190807213304.9255-1-lyude@redhat.com>
References: <20190807213304.9255-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 07 Aug 2019 21:33:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code claims to grab a runtime PM ref when at least one CRTC is
active, but that's not actually the case as we grab a runtime PM ref
whenever a CRTC is enabled regardless of it's DPMS state. Meaning that
we can end up keeping the GPU awake when there are no screens enabled,
something we don't really want to do.

Note that we fixed this same issue for nv50 a while ago in:

commit e5d54f193572 ("drm/nouveau/drm/nouveau: Fix runtime PM leak in
nv50_disp_atomic_commit()")

Since we're about to remove nouveau_drm->have_disp_power_ref in the next
commit, let's also simplify the RPM code here while we're at it: grab a
ref during a modeset, grab additional RPM refs for each CRTC enabled by
said modeset, and drop an RPM ref for each CRTC disabled by said
modeset. This allows us to keep the GPU awake whenever screens are
turned on, without needing to use nouveau_drm->have_disp_power_ref.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv04/crtc.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
index f22f01020625..08ad8e3b9cd2 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
@@ -183,6 +183,10 @@ nv_crtc_dpms(struct drm_crtc *crtc, int mode)
 		return;
 
 	nv_crtc->last_dpms = mode;
+	if (mode == DRM_MODE_DPMS_ON)
+		pm_runtime_get_noresume(dev->dev);
+	else
+		pm_runtime_put_noidle(dev->dev);
 
 	if (nv_two_heads(dev))
 		NVSetOwner(dev, nv_crtc->index);
@@ -1045,7 +1049,6 @@ nouveau_crtc_set_config(struct drm_mode_set *set,
 
 	dev = set->crtc->dev;
 
-	/* get a pm reference here */
 	ret = pm_runtime_get_sync(dev->dev);
 	if (ret < 0 && ret != -EACCES)
 		return ret;
@@ -1061,19 +1064,6 @@ nouveau_crtc_set_config(struct drm_mode_set *set,
 	}
 
 	pm_runtime_mark_last_busy(dev->dev);
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
 	pm_runtime_put_autosuspend(dev->dev);
 	return ret;
 }
-- 
2.21.0

