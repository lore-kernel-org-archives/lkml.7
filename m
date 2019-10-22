Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48294CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E17720684
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJn2eEha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388143AbfJVIF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:05:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47841 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388133AbfJVIFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571731555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HWju8v0ylZxHY2q8lIGnYZrlUnAZLYf6aSqluBMV1e4=;
        b=dJn2eEhau+exi4nYdLIK8NCwXRQ21q6v8wXPHAXBX11dqy266GxM+vFigK/zHtqOoip4HF
        hNrHs5KjPCv3dYAp5f3VQq+zhyp5qikBP21uyJJ/tYGRm6z+FTLGqFHEaMPQj2ckX56jTi
        boQnDgwqN9XwuaZ3nzkIvZHMIKcY9wk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-h5_LunauPA-uTd6PBDMJPg-1; Tue, 22 Oct 2019 04:05:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95E5C2B7;
        Tue, 22 Oct 2019 08:05:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5878C5DA8D;
        Tue, 22 Oct 2019 08:05:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id A75D09D72; Tue, 22 Oct 2019 10:05:46 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gurchetan Singh <gurchetansingh@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/5] drm/virtio: move byteorder handling into virtio_gpu_cmd_transfer_to_host_2d function
Date:   Tue, 22 Oct 2019 10:05:43 +0200
Message-Id: <20191022080546.19769-3-kraxel@redhat.com>
In-Reply-To: <20191022080546.19769-1-kraxel@redhat.com>
References: <20191022080546.19769-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: h5_LunauPA-uTd6PBDMJPg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Be consistent with the rest of the code base.
No functional change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  4 ++--
 drivers/gpu/drm/virtio/virtgpu_plane.c | 12 ++++++------
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 12 ++++++------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index 314e02f94d9c..0b56ba005e25 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -267,8 +267,8 @@ void virtio_gpu_cmd_unref_resource(struct virtio_gpu_de=
vice *vgdev,
 =09=09=09=09   uint32_t resource_id);
 void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 =09=09=09=09=09uint64_t offset,
-=09=09=09=09=09__le32 width, __le32 height,
-=09=09=09=09=09__le32 x, __le32 y,
+=09=09=09=09=09uint32_t width, uint32_t height,
+=09=09=09=09=09uint32_t x, uint32_t y,
 =09=09=09=09=09struct virtio_gpu_object_array *objs,
 =09=09=09=09=09struct virtio_gpu_fence *fence);
 void virtio_gpu_cmd_resource_flush(struct virtio_gpu_device *vgdev,
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virti=
o/virtgpu_plane.c
index f4b7360282ce..390524143139 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -132,10 +132,10 @@ static void virtio_gpu_primary_plane_update(struct dr=
m_plane *plane,
 =09=09=09virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
 =09=09=09virtio_gpu_cmd_transfer_to_host_2d
 =09=09=09=09(vgdev, 0,
-=09=09=09=09 cpu_to_le32(plane->state->src_w >> 16),
-=09=09=09=09 cpu_to_le32(plane->state->src_h >> 16),
-=09=09=09=09 cpu_to_le32(plane->state->src_x >> 16),
-=09=09=09=09 cpu_to_le32(plane->state->src_y >> 16),
+=09=09=09=09 plane->state->src_w >> 16,
+=09=09=09=09 plane->state->src_h >> 16,
+=09=09=09=09 plane->state->src_x >> 16,
+=09=09=09=09 plane->state->src_y >> 16,
 =09=09=09=09 objs, NULL);
 =09=09}
 =09} else {
@@ -234,8 +234,8 @@ static void virtio_gpu_cursor_plane_update(struct drm_p=
lane *plane,
 =09=09virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
 =09=09virtio_gpu_cmd_transfer_to_host_2d
 =09=09=09(vgdev, 0,
-=09=09=09 cpu_to_le32(plane->state->crtc_w),
-=09=09=09 cpu_to_le32(plane->state->crtc_h),
+=09=09=09 plane->state->crtc_w,
+=09=09=09 plane->state->crtc_h,
 =09=09=09 0, 0, objs, vgfb->fence);
 =09=09dma_fence_wait(&vgfb->fence->f, true);
 =09=09dma_fence_put(&vgfb->fence->f);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/v=
irtgpu_vq.c
index 80176f379ad5..74ad3bc3ebe8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -549,8 +549,8 @@ void virtio_gpu_cmd_resource_flush(struct virtio_gpu_de=
vice *vgdev,
=20
 void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 =09=09=09=09=09uint64_t offset,
-=09=09=09=09=09__le32 width, __le32 height,
-=09=09=09=09=09__le32 x, __le32 y,
+=09=09=09=09=09uint32_t width, uint32_t height,
+=09=09=09=09=09uint32_t x, uint32_t y,
 =09=09=09=09=09struct virtio_gpu_object_array *objs,
 =09=09=09=09=09struct virtio_gpu_fence *fence)
 {
@@ -571,10 +571,10 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio=
_gpu_device *vgdev,
 =09cmd_p->hdr.type =3D cpu_to_le32(VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D);
 =09cmd_p->resource_id =3D cpu_to_le32(bo->hw_res_handle);
 =09cmd_p->offset =3D cpu_to_le64(offset);
-=09cmd_p->r.width =3D width;
-=09cmd_p->r.height =3D height;
-=09cmd_p->r.x =3D x;
-=09cmd_p->r.y =3D y;
+=09cmd_p->r.width =3D cpu_to_le32(width);
+=09cmd_p->r.height =3D cpu_to_le32(height);
+=09cmd_p->r.x =3D cpu_to_le32(x);
+=09cmd_p->r.y =3D cpu_to_le32(y);
=20
 =09virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, &cmd_p->hdr, fence);
 }
--=20
2.18.1

