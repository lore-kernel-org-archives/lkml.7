Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE61CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C4E2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 06:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YrE+4zST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388573AbfJWGZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 02:25:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33725 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725852AbfJWGZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 02:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571811947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oVc09gtJkfw81t/CSZzvN6PZuWLwf46NNAtbbfhMjiE=;
        b=YrE+4zST5AXKYTjBtjgsW87XhRENVpriYF4qhWhDYpxk/eB6kEvvsr0LUdqloFqjr6h1qm
        WTPezuBhvEjnv1KME0weBZPjQSNcPsKk1Z/0jfnKTkbGMDnFCLUYL6HS8WtVZm5SPavvyy
        dcq9VW5wz4F/oaZghyW7y4qtanIFTRo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-jmzfOARtMemy09B3Bu1Opw-1; Wed, 23 Oct 2019 02:25:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4242107AD31;
        Wed, 23 Oct 2019 06:25:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7CAD194B6;
        Wed, 23 Oct 2019 06:25:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 0FED09D76; Wed, 23 Oct 2019 08:25:40 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gurchetan Singh <gurchetansingh@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/3] drm/virtio: Simplify virtio_gpu_primary_plane_update workflow.
Date:   Wed, 23 Oct 2019 08:25:38 +0200
Message-Id: <20191023062539.11728-3-kraxel@redhat.com>
In-Reply-To: <20191023062539.11728-1-kraxel@redhat.com>
References: <20191023062539.11728-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: jmzfOARtMemy09B3Bu1Opw-1
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

