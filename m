Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8995CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00BF2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QbC4r10p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388131AbfJVIFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:05:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43041 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388047AbfJVIFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571731553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVc09gtJkfw81t/CSZzvN6PZuWLwf46NNAtbbfhMjiE=;
        b=QbC4r10pzZOX22EBqMOYUnGSsnOD2K6zP7MihlJRTfAZzEFciGMMT1PMPpud4U/anY+MrU
        YFKbAtfQ/O2V3rLcVPLvuXFv8JKsRyKydxuJTLwr6TJpr9rNIgQbqBGcLLpuSaoQn1QXmR
        C6W8HfmWE/1t2mcy7eOpxAutJF4efk0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-r4AlLiXzOFqTnJCqM6tt0Q-1; Tue, 22 Oct 2019 04:05:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8135B1800D6A;
        Tue, 22 Oct 2019 08:05:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F67819481;
        Tue, 22 Oct 2019 08:05:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D7FC49D31; Tue, 22 Oct 2019 10:05:46 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gurchetan Singh <gurchetansingh@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/5] drm/virtio: Simplify virtio_gpu_primary_plane_update workflow.
Date:   Tue, 22 Oct 2019 10:05:45 +0200
Message-Id: <20191022080546.19769-5-kraxel@redhat.com>
In-Reply-To: <20191022080546.19769-1-kraxel@redhat.com>
References: <20191022080546.19769-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: r4AlLiXzOFqTnJCqM6tt0Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return early for the no framebuffer (or disabled output) case.
Results in a simpler code flow for the remaining cases.
No functional change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 62 ++++++++++++++------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virti=
o/virtgpu_plane.c
index 390524143139..0b5a760bc293 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -110,7 +110,6 @@ static void virtio_gpu_primary_plane_update(struct drm_=
plane *plane,
 =09struct virtio_gpu_output *output =3D NULL;
 =09struct virtio_gpu_framebuffer *vgfb;
 =09struct virtio_gpu_object *bo;
-=09uint32_t handle;
=20
 =09if (plane->state->crtc)
 =09=09output =3D drm_crtc_to_virtio_gpu_output(plane->state->crtc);
@@ -119,47 +118,52 @@ static void virtio_gpu_primary_plane_update(struct dr=
m_plane *plane,
 =09if (WARN_ON(!output))
 =09=09return;
=20
-=09if (plane->state->fb && output->enabled) {
-=09=09vgfb =3D to_virtio_gpu_framebuffer(plane->state->fb);
-=09=09bo =3D gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
-=09=09handle =3D bo->hw_res_handle;
-=09=09if (bo->dumb) {
-=09=09=09struct virtio_gpu_object_array *objs;
+=09if (!plane->state->fb || !output->enabled) {
+=09=09DRM_DEBUG("nofb\n");
+=09=09virtio_gpu_cmd_set_scanout(vgdev, output->index, 0,
+=09=09=09=09=09   plane->state->src_w >> 16,
+=09=09=09=09=09   plane->state->src_h >> 16,
+=09=09=09=09=09   0, 0);
+=09=09return;
+=09}
+
+=09vgfb =3D to_virtio_gpu_framebuffer(plane->state->fb);
+=09bo =3D gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
+=09if (bo->dumb) {
+=09=09struct virtio_gpu_object_array *objs;
=20
-=09=09=09objs =3D virtio_gpu_array_alloc(1);
-=09=09=09if (!objs)
-=09=09=09=09return;
-=09=09=09virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
-=09=09=09virtio_gpu_cmd_transfer_to_host_2d
-=09=09=09=09(vgdev, 0,
-=09=09=09=09 plane->state->src_w >> 16,
-=09=09=09=09 plane->state->src_h >> 16,
-=09=09=09=09 plane->state->src_x >> 16,
-=09=09=09=09 plane->state->src_y >> 16,
-=09=09=09=09 objs, NULL);
-=09=09}
-=09} else {
-=09=09handle =3D 0;
+=09=09objs =3D virtio_gpu_array_alloc(1);
+=09=09if (!objs)
+=09=09=09return;
+=09=09virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
+=09=09virtio_gpu_cmd_transfer_to_host_2d
+=09=09=09(vgdev, 0,
+=09=09=09 plane->state->src_w >> 16,
+=09=09=09 plane->state->src_h >> 16,
+=09=09=09 plane->state->src_x >> 16,
+=09=09=09 plane->state->src_y >> 16,
+=09=09=09 objs, NULL);
 =09}
=20
-=09DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n", handle,
+=09DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n",
+=09=09  bo->hw_res_handle,
 =09=09  plane->state->crtc_w, plane->state->crtc_h,
 =09=09  plane->state->crtc_x, plane->state->crtc_y,
 =09=09  plane->state->src_w >> 16,
 =09=09  plane->state->src_h >> 16,
 =09=09  plane->state->src_x >> 16,
 =09=09  plane->state->src_y >> 16);
-=09virtio_gpu_cmd_set_scanout(vgdev, output->index, handle,
+=09virtio_gpu_cmd_set_scanout(vgdev, output->index,
+=09=09=09=09   bo->hw_res_handle,
 =09=09=09=09   plane->state->src_w >> 16,
 =09=09=09=09   plane->state->src_h >> 16,
 =09=09=09=09   plane->state->src_x >> 16,
 =09=09=09=09   plane->state->src_y >> 16);
-=09if (handle)
-=09=09virtio_gpu_cmd_resource_flush(vgdev, handle,
-=09=09=09=09=09      plane->state->src_x >> 16,
-=09=09=09=09=09      plane->state->src_y >> 16,
-=09=09=09=09=09      plane->state->src_w >> 16,
-=09=09=09=09=09      plane->state->src_h >> 16);
+=09virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle,
+=09=09=09=09      plane->state->src_x >> 16,
+=09=09=09=09      plane->state->src_y >> 16,
+=09=09=09=09      plane->state->src_w >> 16,
+=09=09=09=09      plane->state->src_h >> 16);
 }
=20
 static int virtio_gpu_cursor_prepare_fb(struct drm_plane *plane,
--=20
2.18.1

