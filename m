Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1028C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786712086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfDAW1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 18:27:01 -0400
Received: from anholt.net ([50.246.234.109]:48388 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728667AbfDAW0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 18:26:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 0F9A410A28B1;
        Mon,  1 Apr 2019 15:26:54 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 1IoNiA1NqU0f; Mon,  1 Apr 2019 15:26:49 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 0E86710A2A79;
        Mon,  1 Apr 2019 15:26:38 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id C546B2FE34D6; Mon,  1 Apr 2019 15:26:35 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, david.emett@broadcom.com,
        thomas.spurden@broadcom.com, Rob Herring <robh@kernel.org>,
        Qiang Yu <yuq825@gmail.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH 5/7] drm: Add helpers for setting up an array of dma_fence dependencies.
Date:   Mon,  1 Apr 2019 15:26:33 -0700
Message-Id: <20190401222635.25013-6-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401222635.25013-1-eric@anholt.net>
References: <20190401222635.25013-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I needed to add implicit dependency support for v3d, and Rob Herring
has been working on it for panfrost, and I had recently looked at the
lima implementation so I think this will be a good intersection of
what we all want and simplify our scheduler implementations.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/drm_gem.c | 94 +++++++++++++++++++++++++++++++++++++++
 include/drm/drm_gem.h     |  5 +++
 2 files changed, 99 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 388b3742e562..7b3c73135e49 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1311,3 +1311,97 @@ drm_gem_unlock_reservations(struct drm_gem_object **objs, int count,
 	ww_acquire_fini(acquire_ctx);
 }
 EXPORT_SYMBOL(drm_gem_unlock_reservations);
+
+/**
+ * drm_gem_fence_array_add - Adds the fence to an array of fences to be
+ * waited on, deduplicating fences from the same context.
+ *
+ * @fence_array array of dma_fence * for the job to block on.
+ * @fence the dma_fence to add to the list of dependencies.
+ *
+ * Returns:
+ * 0 on success, or an error on failing to expand the array.
+ */
+int drm_gem_fence_array_add(struct xarray *fence_array,
+			    struct dma_fence *fence)
+{
+	struct dma_fence *entry;
+	unsigned long index;
+	u32 id = 0;
+	int ret;
+
+	if (!fence)
+		return 0;
+
+	/* Deduplicate if we already depend on a fence from the same context.
+	 * This lets the size of the array of deps scale with the number of
+	 * engines involved, rather than the number of BOs.
+	 */
+	xa_for_each(fence_array, index, entry) {
+		if (entry->context != fence->context)
+			continue;
+
+		if (dma_fence_is_later(fence, entry)) {
+			dma_fence_put(entry);
+			xa_store(fence_array, index, fence, GFP_KERNEL);
+		} else {
+			dma_fence_put(fence);
+		}
+		return 0;
+	}
+
+	ret = xa_alloc(fence_array, &id, UINT_MAX, fence, GFP_KERNEL);
+	if (ret != 0)
+		dma_fence_put(fence);
+
+	return ret;
+}
+EXPORT_SYMBOL(drm_gem_fence_array_add);
+
+/**
+ * drm_gem_fence_array_add_implicit - Adds the implicit dependencies tracked
+ * in the GEM object's reservation object to an array of dma_fences for use in
+ * scheduling a rendering job.
+ *
+ * This should be called after drm_gem_lock_reservations() on your array of
+ * GEM objects used in the job but before updating the reservations with your
+ * own fences.
+ *
+ * @fence_array array of dma_fence * for the job to block on.
+ * @obj the gem object to add new dependencies from.
+ * @write whether the job might write the object (so we need to depend on
+ * shared fences in the reservation object).
+ */
+int drm_gem_fence_array_add_implicit(struct xarray *fence_array,
+				     struct drm_gem_object *obj,
+				     bool write)
+{
+	int ret;
+	struct dma_fence **fences;
+	unsigned i, fence_count;
+
+	if (!write) {
+		struct dma_fence *fence =
+			reservation_object_get_excl_rcu(obj->resv);
+
+		return drm_gem_fence_array_add(fence_array, fence);
+	}
+
+	ret = reservation_object_get_fences_rcu(obj->resv, NULL,
+						&fence_count, &fences);
+	if (ret || !fence_count)
+		return ret;
+
+	for (i = 0; i < fence_count; i++) {
+		ret = drm_gem_fence_array_add(fence_array, fences[i]);
+		if (ret)
+			break;
+	}
+
+	for (; i < fence_count; i++)
+		dma_fence_put(fences[i]);
+	kfree(fences);
+	return ret;
+}
+
+EXPORT_SYMBOL(drm_gem_fence_array_add_implicit);
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 2955aaab3dca..e957753d3f94 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -388,6 +388,11 @@ int drm_gem_lock_reservations(struct drm_gem_object **objs, int count,
 			      struct ww_acquire_ctx *acquire_ctx);
 void drm_gem_unlock_reservations(struct drm_gem_object **objs, int count,
 				 struct ww_acquire_ctx *acquire_ctx);
+int drm_gem_fence_array_add(struct xarray *fence_array,
+			    struct dma_fence *fence);
+int drm_gem_fence_array_add_implicit(struct xarray *fence_array,
+				     struct drm_gem_object *obj,
+				     bool write);
 int drm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
 			    u32 handle, u64 *offset);
 int drm_gem_dumb_destroy(struct drm_file *file,
-- 
2.20.1

