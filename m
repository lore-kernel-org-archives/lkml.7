Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E571DC2BD09
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77412077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFSYfH/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfLKIm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 03:42:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38749 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727253AbfLKIm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 03:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576053745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KtoovQXBmt77VoBhVg39A0Jd/NXJUkCNUGS6KQcNFkc=;
        b=GFSYfH/esJg01S8a5WewPmnQh8H/uJvU+a0pF+ozyaWIzI/z9lbpFDZmZBkUjyHWXnuG5h
        0d/52Os8AdLiRRBAi6UIdaIP/asGNVw/e0MMGYcgE3r2VtjUvZ91fSkazTNdbw8Iia4rW/
        iNUwwXs98vL1JufKW1AKuGWNLyOrl+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-2Jw60vDsMoSH9xfXdMSoEA-1; Wed, 11 Dec 2019 03:42:22 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94B3F800D5B;
        Wed, 11 Dec 2019 08:42:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75C0610013A1;
        Wed, 11 Dec 2019 08:42:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id AAD5617536; Wed, 11 Dec 2019 09:42:16 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     gurchetansingh@chromium.org, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] virtio-gpu: use damage info for display updates.
Date:   Wed, 11 Dec 2019 09:42:16 +0100
Message-Id: <20191211084216.25405-4-kraxel@redhat.com>
In-Reply-To: <20191211084216.25405-1-kraxel@redhat.com>
References: <20191211084216.25405-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 2Jw60vDsMoSH9xfXdMSoEA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 41 +++++++++++++++-----------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virti=
o/virtgpu_plane.c
index 2e0d14e005db..1a0fbbb91ec7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -24,6 +24,7 @@
  */
=20
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_damage_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_plane_helper.h>
=20
@@ -103,22 +104,26 @@ static int virtio_gpu_plane_atomic_check(struct drm_p=
lane *plane,
 }
=20
 static void virtio_gpu_update_dumb_bo(struct virtio_gpu_device *vgdev,
-=09=09=09=09      struct virtio_gpu_object *bo,
-=09=09=09=09      struct drm_plane_state *state)
+=09=09=09=09      struct drm_plane_state *state,
+=09=09=09=09      struct drm_rect *rect)
 {
+=09struct virtio_gpu_object *bo =3D
+=09=09gem_to_virtio_gpu_obj(state->fb->obj[0]);
 =09struct virtio_gpu_object_array *objs;
+=09uint32_t w =3D rect->x2 - rect->x1;
+=09uint32_t h =3D rect->y2 - rect->y1;
+=09uint32_t x =3D rect->x1 + (state->src_x >> 16);
+=09uint32_t y =3D rect->y1 + (state->src_y >> 16);
+=09uint32_t off =3D x * state->fb->format->cpp[0] +
+=09=09y * state->fb->pitches[0];
=20
 =09objs =3D virtio_gpu_array_alloc(1);
 =09if (!objs)
 =09=09return;
 =09virtio_gpu_array_add_obj(objs, &bo->base.base);
-=09virtio_gpu_cmd_transfer_to_host_2d
-=09=09(vgdev, 0,
-=09=09 state->src_w >> 16,
-=09=09 state->src_h >> 16,
-=09=09 state->src_x >> 16,
-=09=09 state->src_y >> 16,
-=09=09 objs, NULL);
+
+=09virtio_gpu_cmd_transfer_to_host_2d(vgdev, off, w, h, x, y,
+=09=09=09=09=09   objs, NULL);
 }
=20
 static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
@@ -127,8 +132,8 @@ static void virtio_gpu_primary_plane_update(struct drm_=
plane *plane,
 =09struct drm_device *dev =3D plane->dev;
 =09struct virtio_gpu_device *vgdev =3D dev->dev_private;
 =09struct virtio_gpu_output *output =3D NULL;
-=09struct virtio_gpu_framebuffer *vgfb;
 =09struct virtio_gpu_object *bo;
+=09struct drm_rect rect;
=20
 =09if (plane->state->crtc)
 =09=09output =3D drm_crtc_to_virtio_gpu_output(plane->state->crtc);
@@ -146,12 +151,14 @@ static void virtio_gpu_primary_plane_update(struct dr=
m_plane *plane,
 =09=09return;
 =09}
=20
+=09if (!drm_atomic_helper_damage_merged(old_state, plane->state, &rect))
+=09=09return;
+
 =09virtio_gpu_disable_notify(vgdev);
=20
-=09vgfb =3D to_virtio_gpu_framebuffer(plane->state->fb);
-=09bo =3D gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
+=09bo =3D gem_to_virtio_gpu_obj(plane->state->fb->obj[0]);
 =09if (bo->dumb)
-=09=09virtio_gpu_update_dumb_bo(vgdev, bo, plane->state);
+=09=09virtio_gpu_update_dumb_bo(vgdev, plane->state, &rect);
=20
 =09if (plane->state->fb !=3D old_state->fb) {
 =09=09DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n",
@@ -171,10 +178,10 @@ static void virtio_gpu_primary_plane_update(struct dr=
m_plane *plane,
 =09}
=20
 =09virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle,
-=09=09=09=09      plane->state->src_x >> 16,
-=09=09=09=09      plane->state->src_y >> 16,
-=09=09=09=09      plane->state->src_w >> 16,
-=09=09=09=09      plane->state->src_h >> 16);
+=09=09=09=09      (plane->state->src_x >> 16) + rect.x1,
+=09=09=09=09      (plane->state->src_y >> 16) + rect.y1,
+=09=09=09=09      rect.x2 - rect.x1,
+=09=09=09=09      rect.y2 - rect.y1);
=20
 =09virtio_gpu_enable_notify(vgdev);
 }
--=20
2.18.1

