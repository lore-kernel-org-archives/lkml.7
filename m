Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0303C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4F82147A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfCHQR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:17:27 -0500
Received: from anholt.net ([50.246.234.109]:52550 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbfCHQRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:17:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 532AB10A2E21;
        Fri,  8 Mar 2019 08:17:24 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id uj3CY7BE7wpt; Fri,  8 Mar 2019 08:17:23 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 76A5010A2E2D;
        Fri,  8 Mar 2019 08:17:17 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 27ACF2FE4655; Fri,  8 Mar 2019 08:17:16 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        david.emett@broadcom.com, thomas.spurden@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 2/4] drm/v3d: Use drm_gem_lock_reservations()/drm_gem_unlock_reservations()
Date:   Fri,  8 Mar 2019 08:17:14 -0800
Message-Id: <20190308161716.2466-3-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190308161716.2466-1-eric@anholt.net>
References: <20190308161716.2466-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have core helpers, this gets rid of a lot of boilerplate.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_gem.c | 56 ++++-------------------------------
 1 file changed, 6 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 0d1e5e0b8042..a4338d56ff9e 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -199,12 +199,8 @@ v3d_unlock_bo_reservations(struct v3d_bo **bos,
 			   int bo_count,
 			   struct ww_acquire_ctx *acquire_ctx)
 {
-	int i;
-
-	for (i = 0; i < bo_count; i++)
-		ww_mutex_unlock(&bos[i]->base.resv->lock);
-
-	ww_acquire_fini(acquire_ctx);
+	drm_gem_unlock_reservations((struct drm_gem_object **)bos, bo_count,
+				    acquire_ctx);
 }
 
 /* Takes the reservation lock on all the BOs being referenced, so that
@@ -219,52 +215,12 @@ v3d_lock_bo_reservations(struct v3d_bo **bos,
 			 int bo_count,
 			 struct ww_acquire_ctx *acquire_ctx)
 {
-	int contended_lock = -1;
 	int i, ret;
 
-	ww_acquire_init(acquire_ctx, &reservation_ww_class);
-
-retry:
-	if (contended_lock != -1) {
-		struct v3d_bo *bo = bos[contended_lock];
-
-		ret = ww_mutex_lock_slow_interruptible(&bo->base.resv->lock,
-						       acquire_ctx);
-		if (ret) {
-			ww_acquire_done(acquire_ctx);
-			return ret;
-		}
-	}
-
-	for (i = 0; i < bo_count; i++) {
-		if (i == contended_lock)
-			continue;
-
-		ret = ww_mutex_lock_interruptible(&bos[i]->base.resv->lock,
-						  acquire_ctx);
-		if (ret) {
-			int j;
-
-			for (j = 0; j < i; j++)
-				ww_mutex_unlock(&bos[j]->base.resv->lock);
-
-			if (contended_lock != -1 && contended_lock >= i) {
-				struct v3d_bo *bo = bos[contended_lock];
-
-				ww_mutex_unlock(&bo->base.resv->lock);
-			}
-
-			if (ret == -EDEADLK) {
-				contended_lock = i;
-				goto retry;
-			}
-
-			ww_acquire_done(acquire_ctx);
-			return ret;
-		}
-	}
-
-	ww_acquire_done(acquire_ctx);
+	ret = drm_gem_lock_reservations((struct drm_gem_object **)bos,
+					bo_count, acquire_ctx);
+	if (ret)
+		return ret;
 
 	/* Reserve space for our shared (read-only) fence references,
 	 * before we commit the CL to the hardware.
-- 
2.20.1

