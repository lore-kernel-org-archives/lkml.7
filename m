Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E77FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EF92147A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfCHQRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:17:24 -0500
Received: from anholt.net ([50.246.234.109]:52528 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbfCHQRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:17:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 7AA1A10A2E21;
        Fri,  8 Mar 2019 08:17:21 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id kK1gm7M7Otlv; Fri,  8 Mar 2019 08:17:19 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 5CF1510A2E2B;
        Fri,  8 Mar 2019 08:17:17 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 243682FE4654; Fri,  8 Mar 2019 08:17:16 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        david.emett@broadcom.com, thomas.spurden@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 1/4] drm: Add helpers for locking an array of BO reservations.
Date:   Fri,  8 Mar 2019 08:17:13 -0800
Message-Id: <20190308161716.2466-2-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190308161716.2466-1-eric@anholt.net>
References: <20190308161716.2466-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have the reservation object in the GEM object, it's easy
to provide a helper for this common case.  Noticed while reviewing
panfrost and lima drivers.  This particular version came out of v3d,
which in turn was a copy from vc4.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/drm_gem.c | 76 +++++++++++++++++++++++++++++++++++++++
 include/drm/drm_gem.h     |  4 +++
 2 files changed, 80 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index ad124f5a6f4d..9fd804f7d7ca 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1233,3 +1233,79 @@ void drm_gem_vunmap(struct drm_gem_object *obj, void *vaddr)
 		obj->dev->driver->gem_prime_vunmap(obj, vaddr);
 }
 EXPORT_SYMBOL(drm_gem_vunmap);
+
+/**
+ * drm_gem_lock_bo_reservations - Sets up the ww context and acquires
+ * the lock on an array of GEM objects.
+ *
+ * Once you've locked your reservations, you'll want to set up space
+ * for your shared fences (if applicable), submit your job, then
+ * drm_gem_unlock_reservations().
+ *
+ * @acquire_ctx - struct ww_acquire_ctx that will be initialized as
+ * part of tracking this set of locked reservations.
+ */
+int
+drm_gem_lock_reservations(struct drm_gem_object **objs, int count,
+			  struct ww_acquire_ctx *acquire_ctx)
+{
+	int contended = -1;
+	int i, ret;
+
+	ww_acquire_init(acquire_ctx, &reservation_ww_class);
+
+retry:
+	if (contended != -1) {
+		struct drm_gem_object *obj = objs[contended];
+
+		ret = ww_mutex_lock_slow_interruptible(&obj->resv->lock,
+						       acquire_ctx);
+		if (ret) {
+			ww_acquire_done(acquire_ctx);
+			return ret;
+		}
+	}
+
+	for (i = 0; i < count; i++) {
+		if (i == contended)
+			continue;
+
+		ret = ww_mutex_lock_interruptible(&objs[i]->resv->lock,
+						  acquire_ctx);
+		if (ret) {
+			int j;
+
+			for (j = 0; j < i; j++)
+				ww_mutex_unlock(&objs[j]->resv->lock);
+
+			if (contended != -1 && contended >= i)
+				ww_mutex_unlock(&objs[contended]->resv->lock);
+
+			if (ret == -EDEADLK) {
+				contended = i;
+				goto retry;
+			}
+
+			ww_acquire_done(acquire_ctx);
+			return ret;
+		}
+	}
+
+	ww_acquire_done(acquire_ctx);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_gem_lock_reservations);
+
+void
+drm_gem_unlock_reservations(struct drm_gem_object **objs, int count,
+			    struct ww_acquire_ctx *acquire_ctx)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		ww_mutex_unlock(&objs[i]->resv->lock);
+
+	ww_acquire_fini(acquire_ctx);
+}
+EXPORT_SYMBOL(drm_gem_unlock_reservations);
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 25f1ff2df464..2955aaab3dca 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -384,6 +384,10 @@ void drm_gem_put_pages(struct drm_gem_object *obj, struct page **pages,
 struct drm_gem_object *drm_gem_object_lookup(struct drm_file *filp, u32 handle);
 long drm_gem_reservation_object_wait(struct drm_file *filep, u32 handle,
 				    bool wait_all, unsigned long timeout);
+int drm_gem_lock_reservations(struct drm_gem_object **objs, int count,
+			      struct ww_acquire_ctx *acquire_ctx);
+void drm_gem_unlock_reservations(struct drm_gem_object **objs, int count,
+				 struct ww_acquire_ctx *acquire_ctx);
 int drm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
 			    u32 handle, u64 *offset);
 int drm_gem_dumb_destroy(struct drm_file *file,
-- 
2.20.1

