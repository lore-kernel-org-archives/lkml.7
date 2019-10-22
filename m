Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DCBCA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187832184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akdZEapz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388164AbfJVIGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:06:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34989 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388134AbfJVIF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571731555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2rJJiMpAk3KTFb/8+6jAIUN/X+McNBs+lfMw6ea3i+w=;
        b=akdZEapzk4TdGVJsi27SenSj/8E/9qThWDVH+yMxIorR2XQkdTgkFsouHCwtUI4r+zVlRV
        4GDCfDG7GmPLLuyqEOXCtKjpmcPjkItw03AIZ0QDwG7ODkmYUNxuOBo2S/1XzG6g9nv7hk
        1BIX4gtlZ9GiiFHVYD9+zhJqQcuc7ZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-0lXyjkArN3yZ1gZkgNW9Bg-1; Tue, 22 Oct 2019 04:05:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F55180183D;
        Tue, 22 Oct 2019 08:05:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C2F441001B05;
        Tue, 22 Oct 2019 08:05:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id EFAAC9D34; Tue, 22 Oct 2019 10:05:46 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gurchetan Singh <gurchetansingh@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/5] drm/virtio: factor out virtio_gpu_update_dumb_bo
Date:   Tue, 22 Oct 2019 10:05:46 +0200
Message-Id: <20191022080546.19769-6-kraxel@redhat.com>
In-Reply-To: <20191022080546.19769-1-kraxel@redhat.com>
References: <20191022080546.19769-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 0lXyjkArN3yZ1gZkgNW9Bg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 36 +++++++++++++++-----------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virti=
o/virtgpu_plane.c
index 0b5a760bc293..bc4bc4475a8c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -102,6 +102,25 @@ static int virtio_gpu_plane_atomic_check(struct drm_pl=
ane *plane,
 =09return ret;
 }
=20
+static void virtio_gpu_update_dumb_bo(struct virtio_gpu_device *vgdev,
+=09=09=09=09      struct virtio_gpu_object *bo,
+=09=09=09=09      struct drm_plane_state *state)
+{
+=09struct virtio_gpu_object_array *objs;
+
+=09objs =3D virtio_gpu_array_alloc(1);
+=09if (!objs)
+=09=09return;
+=09virtio_gpu_array_add_obj(objs, &bo->base.base);
+=09virtio_gpu_cmd_transfer_to_host_2d
+=09=09(vgdev, 0,
+=09=09 state->src_w >> 16,
+=09=09 state->src_h >> 16,
+=09=09 state->src_x >> 16,
+=09=09 state->src_y >> 16,
+=09=09 objs, NULL);
+}
+
 static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 =09=09=09=09=09    struct drm_plane_state *old_state)
 {
@@ -129,21 +148,8 @@ static void virtio_gpu_primary_plane_update(struct drm=
_plane *plane,
=20
 =09vgfb =3D to_virtio_gpu_framebuffer(plane->state->fb);
 =09bo =3D gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
-=09if (bo->dumb) {
-=09=09struct virtio_gpu_object_array *objs;
-
-=09=09objs =3D virtio_gpu_array_alloc(1);
-=09=09if (!objs)
-=09=09=09return;
-=09=09virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
-=09=09virtio_gpu_cmd_transfer_to_host_2d
-=09=09=09(vgdev, 0,
-=09=09=09 plane->state->src_w >> 16,
-=09=09=09 plane->state->src_h >> 16,
-=09=09=09 plane->state->src_x >> 16,
-=09=09=09 plane->state->src_y >> 16,
-=09=09=09 objs, NULL);
-=09}
+=09if (bo->dumb)
+=09=09virtio_gpu_update_dumb_bo(vgdev, bo, plane->state);
=20
 =09DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n",
 =09=09  bo->hw_res_handle,
--=20
2.18.1

