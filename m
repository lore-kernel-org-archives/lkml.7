Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5F2CA9EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72A021920
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMnqqgrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388887AbfJWGZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 02:25:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42648 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727194AbfJWGZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 02:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571811948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e5qrmu4lA/33yMhhY8eqqHcwG1Y/E2lbnUfcnug30Pk=;
        b=cMnqqgrjv9LFZBrJoA3Qw/k+mUbcB4zqcRWQy7/n1am+ltGS0L/YbZzLjL2axGiaUCD2iv
        MTWB1B3q98+0wOyWW8HI5Qm4zzOvfqSxTecXpziYNb86nFH50WqkGYzNgrhpxYjWnfx3HV
        hjutIbkbyCn3iCFTbvTrz73QMXWjvQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-HaOHJZxdM5u-YLv4NgN0Ag-1; Wed, 23 Oct 2019 02:25:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B19BC800D54;
        Wed, 23 Oct 2019 06:25:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9B335C240;
        Wed, 23 Oct 2019 06:25:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id EB4A19D72; Wed, 23 Oct 2019 08:25:39 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gurchetan Singh <gurchetansingh@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/3] drm/virtio: fix byteorder handling in virtio_gpu_cmd_transfer_{from,to}_host_3d functions
Date:   Wed, 23 Oct 2019 08:25:37 +0200
Message-Id: <20191023062539.11728-2-kraxel@redhat.com>
In-Reply-To: <20191023062539.11728-1-kraxel@redhat.com>
References: <20191023062539.11728-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: HaOHJZxdM5u-YLv4NgN0Ag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Be consistent with the rest of the code base.
No functional change.

v2:
 - fix sparse warnings for virtio_gpu_cmd_transfer_to_host_2d call.
 - move convert_to_hw_box helper function.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  5 +++--
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 22 +++-------------------
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 19 +++++++++++++++----
 3 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index 0b56ba005e25..eedae2a7b532 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -38,6 +38,7 @@
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_ioctl.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/virtgpu_drm.h>
=20
 #define DRIVER_NAME "virtio_gpu"
 #define DRIVER_DESC "virtio GPU"
@@ -312,13 +313,13 @@ void virtio_gpu_cmd_submit(struct virtio_gpu_device *=
vgdev,
 void virtio_gpu_cmd_transfer_from_host_3d(struct virtio_gpu_device *vgdev,
 =09=09=09=09=09  uint32_t ctx_id,
 =09=09=09=09=09  uint64_t offset, uint32_t level,
-=09=09=09=09=09  struct virtio_gpu_box *box,
+=09=09=09=09=09  struct drm_virtgpu_3d_box *box,
 =09=09=09=09=09  struct virtio_gpu_object_array *objs,
 =09=09=09=09=09  struct virtio_gpu_fence *fence);
 void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
 =09=09=09=09=09uint32_t ctx_id,
 =09=09=09=09=09uint64_t offset, uint32_t level,
-=09=09=09=09=09struct virtio_gpu_box *box,
+=09=09=09=09=09struct drm_virtgpu_3d_box *box,
 =09=09=09=09=09struct virtio_gpu_object_array *objs,
 =09=09=09=09=09struct virtio_gpu_fence *fence);
 void
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virti=
o/virtgpu_ioctl.c
index 9af1ec62434f..205ec4abae2b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -33,17 +33,6 @@
=20
 #include "virtgpu_drv.h"
=20
-static void convert_to_hw_box(struct virtio_gpu_box *dst,
-=09=09=09      const struct drm_virtgpu_3d_box *src)
-{
-=09dst->x =3D cpu_to_le32(src->x);
-=09dst->y =3D cpu_to_le32(src->y);
-=09dst->z =3D cpu_to_le32(src->z);
-=09dst->w =3D cpu_to_le32(src->w);
-=09dst->h =3D cpu_to_le32(src->h);
-=09dst->d =3D cpu_to_le32(src->d);
-}
-
 static int virtio_gpu_map_ioctl(struct drm_device *dev, void *data,
 =09=09=09=09struct drm_file *file_priv)
 {
@@ -304,7 +293,6 @@ static int virtio_gpu_transfer_from_host_ioctl(struct d=
rm_device *dev,
 =09struct virtio_gpu_fence *fence;
 =09int ret;
 =09u32 offset =3D args->offset;
-=09struct virtio_gpu_box box;
=20
 =09if (vgdev->has_virgl_3d =3D=3D false)
 =09=09return -ENOSYS;
@@ -317,8 +305,6 @@ static int virtio_gpu_transfer_from_host_ioctl(struct d=
rm_device *dev,
 =09if (ret !=3D 0)
 =09=09goto err_put_free;
=20
-=09convert_to_hw_box(&box, &args->box);
-
 =09fence =3D virtio_gpu_fence_alloc(vgdev);
 =09if (!fence) {
 =09=09ret =3D -ENOMEM;
@@ -326,7 +312,7 @@ static int virtio_gpu_transfer_from_host_ioctl(struct d=
rm_device *dev,
 =09}
 =09virtio_gpu_cmd_transfer_from_host_3d
 =09=09(vgdev, vfpriv->ctx_id, offset, args->level,
-=09=09 &box, objs, fence);
+=09=09 &args->box, objs, fence);
 =09dma_fence_put(&fence->f);
 =09return 0;
=20
@@ -345,7 +331,6 @@ static int virtio_gpu_transfer_to_host_ioctl(struct drm=
_device *dev, void *data,
 =09struct drm_virtgpu_3d_transfer_to_host *args =3D data;
 =09struct virtio_gpu_object_array *objs;
 =09struct virtio_gpu_fence *fence;
-=09struct virtio_gpu_box box;
 =09int ret;
 =09u32 offset =3D args->offset;
=20
@@ -353,11 +338,10 @@ static int virtio_gpu_transfer_to_host_ioctl(struct d=
rm_device *dev, void *data,
 =09if (objs =3D=3D NULL)
 =09=09return -ENOENT;
=20
-=09convert_to_hw_box(&box, &args->box);
 =09if (!vgdev->has_virgl_3d) {
 =09=09virtio_gpu_cmd_transfer_to_host_2d
 =09=09=09(vgdev, offset,
-=09=09=09 box.w, box.h, box.x, box.y,
+=09=09=09 args->box.w, args->box.h, args->box.x, args->box.y,
 =09=09=09 objs, NULL);
 =09} else {
 =09=09ret =3D virtio_gpu_array_lock_resv(objs);
@@ -372,7 +356,7 @@ static int virtio_gpu_transfer_to_host_ioctl(struct drm=
_device *dev, void *data,
 =09=09virtio_gpu_cmd_transfer_to_host_3d
 =09=09=09(vgdev,
 =09=09=09 vfpriv ? vfpriv->ctx_id : 0, offset,
-=09=09=09 args->level, &box, objs, fence);
+=09=09=09 args->level, &args->box, objs, fence);
 =09=09dma_fence_put(&fence->f);
 =09}
 =09return 0;
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/v=
irtgpu_vq.c
index 74ad3bc3ebe8..9274c4063c70 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -40,6 +40,17 @@
 =09=09=09       + MAX_INLINE_CMD_SIZE=09=09 \
 =09=09=09       + MAX_INLINE_RESP_SIZE)
=20
+static void convert_to_hw_box(struct virtio_gpu_box *dst,
+=09=09=09      const struct drm_virtgpu_3d_box *src)
+{
+=09dst->x =3D cpu_to_le32(src->x);
+=09dst->y =3D cpu_to_le32(src->y);
+=09dst->z =3D cpu_to_le32(src->z);
+=09dst->w =3D cpu_to_le32(src->w);
+=09dst->h =3D cpu_to_le32(src->h);
+=09dst->d =3D cpu_to_le32(src->d);
+}
+
 void virtio_gpu_ctrl_ack(struct virtqueue *vq)
 {
 =09struct drm_device *dev =3D vq->vdev->priv;
@@ -965,7 +976,7 @@ virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_dev=
ice *vgdev,
 void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
 =09=09=09=09=09uint32_t ctx_id,
 =09=09=09=09=09uint64_t offset, uint32_t level,
-=09=09=09=09=09struct virtio_gpu_box *box,
+=09=09=09=09=09struct drm_virtgpu_3d_box *box,
 =09=09=09=09=09struct virtio_gpu_object_array *objs,
 =09=09=09=09=09struct virtio_gpu_fence *fence)
 {
@@ -987,7 +998,7 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_g=
pu_device *vgdev,
 =09cmd_p->hdr.type =3D cpu_to_le32(VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D);
 =09cmd_p->hdr.ctx_id =3D cpu_to_le32(ctx_id);
 =09cmd_p->resource_id =3D cpu_to_le32(bo->hw_res_handle);
-=09cmd_p->box =3D *box;
+=09convert_to_hw_box(&cmd_p->box, box);
 =09cmd_p->offset =3D cpu_to_le64(offset);
 =09cmd_p->level =3D cpu_to_le32(level);
=20
@@ -997,7 +1008,7 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_=
gpu_device *vgdev,
 void virtio_gpu_cmd_transfer_from_host_3d(struct virtio_gpu_device *vgdev,
 =09=09=09=09=09  uint32_t ctx_id,
 =09=09=09=09=09  uint64_t offset, uint32_t level,
-=09=09=09=09=09  struct virtio_gpu_box *box,
+=09=09=09=09=09  struct drm_virtgpu_3d_box *box,
 =09=09=09=09=09  struct virtio_gpu_object_array *objs,
 =09=09=09=09=09  struct virtio_gpu_fence *fence)
 {
@@ -1013,7 +1024,7 @@ void virtio_gpu_cmd_transfer_from_host_3d(struct virt=
io_gpu_device *vgdev,
 =09cmd_p->hdr.type =3D cpu_to_le32(VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D);
 =09cmd_p->hdr.ctx_id =3D cpu_to_le32(ctx_id);
 =09cmd_p->resource_id =3D cpu_to_le32(bo->hw_res_handle);
-=09cmd_p->box =3D *box;
+=09convert_to_hw_box(&cmd_p->box, box);
 =09cmd_p->offset =3D cpu_to_le64(offset);
 =09cmd_p->level =3D cpu_to_le32(level);
=20
--=20
2.18.1

