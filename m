Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75C1C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC43620665
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393079AbfHBNMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:12:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58437 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393022AbfHBNMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:12:38 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30F9C793C9;
        Fri,  2 Aug 2019 13:12:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-81.ams2.redhat.com [10.36.116.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FE3319D70;
        Fri,  2 Aug 2019 13:12:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C1DB09D7F; Fri,  2 Aug 2019 15:12:26 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     olvaffe@gmail.com, gurchetansingh@chromium.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 07/18] drm/virtio: add virtio_gpu_object_array & helpers
Date:   Fri,  2 Aug 2019 15:12:14 +0200
Message-Id: <20190802131225.17760-8-kraxel@redhat.com>
In-Reply-To: <20190802131225.17760-1-kraxel@redhat.com>
References: <20190802131225.17760-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 02 Aug 2019 13:12:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some helper functions to manage an array of gem objects.

v6:
 - add ticket to struct virtio_gpu_object_array.
 - add virtio_gpu_array_{lock,unlock}_resv helpers.
 - add virtio_gpu_array_add_fence helper.
v5: some small optimizations (Chia-I Wu).
v4: make them virtio-private instead of generic helpers.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h | 17 +++++
 drivers/gpu/drm/virtio/virtgpu_gem.c | 94 ++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 3473b602ec35..bafa06e69032 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -84,6 +84,12 @@ struct virtio_gpu_object {
 #define gem_to_virtio_gpu_obj(gobj) \
 	container_of((gobj), struct virtio_gpu_object, gem_base)
 
+struct virtio_gpu_object_array {
+	struct ww_acquire_ctx ticket;
+	u32 nents, total;
+	struct drm_gem_object *objs[];
+};
+
 struct virtio_gpu_vbuffer;
 struct virtio_gpu_device;
 
@@ -251,6 +257,17 @@ int virtio_gpu_mode_dumb_mmap(struct drm_file *file_priv,
 			      struct drm_device *dev,
 			      uint32_t handle, uint64_t *offset_p);
 
+struct virtio_gpu_object_array *virtio_gpu_array_alloc(u32 nents);
+struct virtio_gpu_object_array*
+virtio_gpu_array_from_handles(struct drm_file *drm_file, u32 *handles, u32 nents);
+void virtio_gpu_array_add_obj(struct virtio_gpu_object_array *objs,
+			      struct drm_gem_object *obj);
+int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs);
+void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs);
+void virtio_gpu_array_add_fence(struct virtio_gpu_object_array *objs,
+				struct dma_fence *fence);
+void virtio_gpu_array_put_free(struct virtio_gpu_object_array *objs);
+
 /* virtio vg */
 int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev);
 void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev);
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 6fe6f72f64d1..f3c9419858b7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -171,3 +171,97 @@ void virtio_gpu_gem_object_close(struct drm_gem_object *obj,
 						qobj->hw_res_handle);
 	virtio_gpu_object_unreserve(qobj);
 }
+
+struct virtio_gpu_object_array *virtio_gpu_array_alloc(u32 nents)
+{
+	struct virtio_gpu_object_array *objs;
+	size_t size = sizeof(*objs) + sizeof(objs->objs[0]) * nents;
+
+	objs = kmalloc(size, GFP_KERNEL);
+	if (!objs)
+		return NULL;
+
+	objs->nents = 0;
+	objs->total = nents;
+	return objs;
+}
+
+static void virtio_gpu_array_free(struct virtio_gpu_object_array *objs)
+{
+	kfree(objs);
+}
+
+struct virtio_gpu_object_array*
+virtio_gpu_array_from_handles(struct drm_file *drm_file, u32 *handles, u32 nents)
+{
+	struct virtio_gpu_object_array *objs;
+	u32 i;
+
+	objs = virtio_gpu_array_alloc(nents);
+	if (!objs)
+		return NULL;
+
+	for (i = 0; i < nents; i++) {
+		objs->objs[i] = drm_gem_object_lookup(drm_file, handles[i]);
+		if (!objs->objs[i]) {
+			objs->nents = i;
+			virtio_gpu_array_put_free(objs);
+			return NULL;
+		}
+	}
+	objs->nents = i;
+	return objs;
+}
+
+void virtio_gpu_array_add_obj(struct virtio_gpu_object_array *objs,
+			      struct drm_gem_object *obj)
+{
+	if (WARN_ON_ONCE(objs->nents == objs->total))
+		return;
+
+	drm_gem_object_get(obj);
+	objs->objs[objs->nents] = obj;
+	objs->nents++;
+}
+
+int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs)
+{
+	int ret;
+
+	if (objs->nents == 1) {
+		ret = reservation_object_lock(objs->objs[0]->resv, NULL);
+	} else {
+		ret = drm_gem_lock_reservations(objs->objs, objs->nents,
+						&objs->ticket);
+	}
+	return ret;
+}
+
+void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs)
+{
+	if (objs->nents == 1) {
+		reservation_object_unlock(objs->objs[0]->resv);
+	} else {
+		drm_gem_unlock_reservations(objs->objs, objs->nents,
+					    &objs->ticket);
+	}
+}
+
+void virtio_gpu_array_add_fence(struct virtio_gpu_object_array *objs,
+				struct dma_fence *fence)
+{
+	int i;
+
+	for (i = 0; i < objs->nents; i++)
+		reservation_object_add_excl_fence(objs->objs[i]->resv,
+						  fence);
+}
+
+void virtio_gpu_array_put_free(struct virtio_gpu_object_array *objs)
+{
+	u32 i;
+
+	for (i = 0; i < objs->nents; i++)
+		drm_gem_object_put_unlocked(objs->objs[i]);
+	virtio_gpu_array_free(objs);
+}
-- 
2.18.1

