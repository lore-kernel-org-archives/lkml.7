Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6BAC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF62520873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbfFRN6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:58:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729395AbfFRN60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:58:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0EE35C1EB1F3;
        Tue, 18 Jun 2019 13:58:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-33.ams2.redhat.com [10.36.116.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C95660922;
        Tue, 18 Jun 2019 13:58:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D0FEA17473; Tue, 18 Jun 2019 15:58:21 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 07/12] drm/virtio: rework virtio_gpu_execbuffer_ioctl fencing
Date:   Tue, 18 Jun 2019 15:58:15 +0200
Message-Id: <20190618135821.8644-8-kraxel@redhat.com>
In-Reply-To: <20190618135821.8644-1-kraxel@redhat.com>
References: <20190618135821.8644-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 18 Jun 2019 13:58:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use gem reservation helpers and direct reservation_object_* calls
instead of ttm.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 36 ++++++++++++--------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 5cffd2e54c04..6db6a6e92dde 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -107,12 +107,11 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	struct virtio_gpu_fpriv *vfpriv = drm_file->driver_priv;
 	struct drm_gem_object *gobj;
 	struct virtio_gpu_fence *out_fence;
-	struct virtio_gpu_object *qobj;
 	int ret;
 	uint32_t *bo_handles = NULL;
 	void __user *user_bo_handles = NULL;
 	struct list_head validate_list;
-	struct ttm_validate_buffer *buflist = NULL;
+	struct drm_gem_object **buflist = NULL;
 	int i;
 	struct ww_acquire_ctx ticket;
 	struct sync_file *sync_file;
@@ -157,12 +156,11 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 
 	INIT_LIST_HEAD(&validate_list);
 	if (exbuf->num_bo_handles) {
-
 		bo_handles = kvmalloc_array(exbuf->num_bo_handles,
-					   sizeof(uint32_t), GFP_KERNEL);
+					    sizeof(uint32_t), GFP_KERNEL);
 		buflist = kvmalloc_array(exbuf->num_bo_handles,
-					   sizeof(struct ttm_validate_buffer),
-					   GFP_KERNEL | __GFP_ZERO);
+					 sizeof(struct drm_gem_object*),
+					 GFP_KERNEL | __GFP_ZERO);
 		if (!bo_handles || !buflist) {
 			ret = -ENOMEM;
 			goto out_unused_fd;
@@ -181,19 +179,15 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 				ret = -ENOENT;
 				goto out_unused_fd;
 			}
-
-			qobj = gem_to_virtio_gpu_obj(gobj);
-			buflist[i].bo = &qobj->tbo;
-
-			list_add(&buflist[i].head, &validate_list);
+			buflist[i] = gobj;
 		}
 		kvfree(bo_handles);
 		bo_handles = NULL;
 	}
 
-	ret = virtio_gpu_object_list_validate(&ticket, &validate_list);
+	ret = drm_gem_lock_reservations(buflist, exbuf->num_bo_handles, &ticket);
 	if (ret)
-		goto out_free;
+		goto out_unused_fd;
 
 	buf = memdup_user(u64_to_user_ptr(exbuf->command), exbuf->size);
 	if (IS_ERR(buf)) {
@@ -222,21 +216,25 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	virtio_gpu_cmd_submit(vgdev, buf, exbuf->size,
 			      vfpriv->ctx_id, out_fence);
 
-	ttm_eu_fence_buffer_objects(&ticket, &validate_list, &out_fence->f);
+	for (i = 0; i < exbuf->num_bo_handles; i++)
+		reservation_object_add_excl_fence(buflist[i]->resv, &out_fence->f);
+	drm_gem_unlock_reservations(buflist, exbuf->num_bo_handles, &ticket);
 
-	/* fence the command bo */
-	virtio_gpu_unref_list(&validate_list);
+	for (i = 0; i < exbuf->num_bo_handles; i++)
+		if (buflist[i])
+			drm_gem_object_put_unlocked(buflist[i]);
 	kvfree(buflist);
 	return 0;
 
 out_memdup:
 	kfree(buf);
 out_unresv:
-	ttm_eu_backoff_reservation(&ticket, &validate_list);
-out_free:
-	virtio_gpu_unref_list(&validate_list);
+	drm_gem_unlock_reservations(buflist, exbuf->num_bo_handles, &ticket);
 out_unused_fd:
 	kvfree(bo_handles);
+	for (i = 0; i < exbuf->num_bo_handles; i++)
+		if (buflist && buflist[i])
+			drm_gem_object_put_unlocked(buflist[i]);
 	kvfree(buflist);
 
 	if (out_fence_fd >= 0)
-- 
2.18.1

