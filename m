Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741EDC2BD09
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4708421D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnBEWmmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfLKImb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 03:42:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35766 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728365AbfLKIm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 03:42:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576053745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dsst+sWX0VFTEAJu3TuQCKDms+wHXt+MxKKJ0t44GQg=;
        b=hnBEWmmDoVf4eotYqR9LtJGzGO+oK/bIz7wX1rPiNBFt+HINkUcZMfhMxtL1hmh/PfJ0vm
        fg9KbKSL3yr10SjqB4Mj/xg3m7d/O4BVvJqyfAMgJCnMfoJIQQDNkGnqc97ETS8AeVV3Oc
        wDJdzQtZh2avLfKYUVFQLavSC0X6OUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-ZP_jTZwRNryhmIsXO6DjjQ-1; Wed, 11 Dec 2019 03:42:21 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A85EA107ACCC;
        Wed, 11 Dec 2019 08:42:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78BD960BE1;
        Wed, 11 Dec 2019 08:42:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 904E51747D; Wed, 11 Dec 2019 09:42:16 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     gurchetansingh@chromium.org, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] virtio-gpu: batch display update commands.
Date:   Wed, 11 Dec 2019 09:42:15 +0100
Message-Id: <20191211084216.25405-3-kraxel@redhat.com>
In-Reply-To: <20191211084216.25405-1-kraxel@redhat.com>
References: <20191211084216.25405-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ZP_jTZwRNryhmIsXO6DjjQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver submits multiple commands in a row it makes sense to
notify the host only after submitting the last one, so the host can
process them all at once, with a single vmexit.

Add functions to enable/disable notifications to allow that.  Use the
new functions for primary plane updates.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  6 ++++++
 drivers/gpu/drm/virtio/virtgpu_plane.c |  4 ++++
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 23 +++++++++++++++++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index eedae2a7b532..29cf005ed6b9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -183,6 +183,9 @@ struct virtio_gpu_device {
 =09struct kmem_cache *vbufs;
 =09bool vqs_ready;
=20
+=09bool disable_notify;
+=09bool pending_notify;
+
 =09struct ida=09resource_ida;
=20
 =09wait_queue_head_t resp_wq;
@@ -335,6 +338,9 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *w=
ork);
 void virtio_gpu_dequeue_cursor_func(struct work_struct *work);
 void virtio_gpu_dequeue_fence_func(struct work_struct *work);
=20
+void virtio_gpu_disable_notify(struct virtio_gpu_device *vgdev);
+void virtio_gpu_enable_notify(struct virtio_gpu_device *vgdev);
+
 /* virtio_gpu_display.c */
 int virtio_gpu_framebuffer_init(struct drm_device *dev,
 =09=09=09=09struct virtio_gpu_framebuffer *vgfb,
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virti=
o/virtgpu_plane.c
index a0f91658c2bc..2e0d14e005db 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -146,6 +146,8 @@ static void virtio_gpu_primary_plane_update(struct drm_=
plane *plane,
 =09=09return;
 =09}
=20
+=09virtio_gpu_disable_notify(vgdev);
+
 =09vgfb =3D to_virtio_gpu_framebuffer(plane->state->fb);
 =09bo =3D gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
 =09if (bo->dumb)
@@ -173,6 +175,8 @@ static void virtio_gpu_primary_plane_update(struct drm_=
plane *plane,
 =09=09=09=09      plane->state->src_y >> 16,
 =09=09=09=09      plane->state->src_w >> 16,
 =09=09=09=09      plane->state->src_h >> 16);
+
+=09virtio_gpu_enable_notify(vgdev);
 }
=20
 static int virtio_gpu_cursor_prepare_fb(struct drm_plane *plane,
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/v=
irtgpu_vq.c
index 9274c4063c70..5914e79d3429 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -404,8 +404,12 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct=
 virtio_gpu_device *vgdev,
 =09}
 =09notify =3D virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf, vout);
 =09spin_unlock(&vgdev->ctrlq.qlock);
-=09if (notify)
-=09=09virtqueue_notify(vgdev->ctrlq.vq);
+=09if (notify) {
+=09=09if (vgdev->disable_notify)
+=09=09=09vgdev->pending_notify =3D true;
+=09=09else
+=09=09=09virtqueue_notify(vgdev->ctrlq.vq);
+=09}
=20
 =09if (sgt) {
 =09=09sg_free_table(sgt);
@@ -413,6 +417,21 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct=
 virtio_gpu_device *vgdev,
 =09}
 }
=20
+void virtio_gpu_disable_notify(struct virtio_gpu_device *vgdev)
+{
+=09vgdev->disable_notify =3D true;
+}
+
+void virtio_gpu_enable_notify(struct virtio_gpu_device *vgdev)
+{
+=09vgdev->disable_notify =3D false;
+
+=09if (!vgdev->pending_notify)
+=09=09return;
+=09vgdev->pending_notify =3D false;
+=09virtqueue_notify(vgdev->ctrlq.vq);
+}
+
 static void virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
 =09=09=09=09=09 struct virtio_gpu_vbuffer *vbuf)
 {
--=20
2.18.1

