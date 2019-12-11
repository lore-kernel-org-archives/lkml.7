Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D95C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D0D214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIGW18dN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfLKIm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 03:42:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31174 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728338AbfLKIm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 03:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576053744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9o29vWs9png9IbME4oN9NDlGatipOh6x0DCXnHJuIk=;
        b=NIGW18dNXPwodTeQlvFMXttrEa1AHZLHjUlfOWU4vJjPvj9ugp0kP2tWKVMPQy6C9pGlVP
        7LJeV3CxF9ynvax+NdDgheEGcg34SZWq/UMJm8KUo3SW1/EIb9v6O+IMS4U6hLwbmBM8vI
        qbLiLXxBBl3JFKdlxBMffV2yzwjWApQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-iPLJMWKoPZK38Zq5HMW8AQ-1; Wed, 11 Dec 2019 03:42:21 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88CDF18B9FC6;
        Wed, 11 Dec 2019 08:42:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 726F86364F;
        Wed, 11 Dec 2019 08:42:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 625F316E2D; Wed, 11 Dec 2019 09:42:16 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     gurchetansingh@chromium.org, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] drm/virtio: skip set_scanout if framebuffer didn't change
Date:   Wed, 11 Dec 2019 09:42:14 +0100
Message-Id: <20191211084216.25405-2-kraxel@redhat.com>
In-Reply-To: <20191211084216.25405-1-kraxel@redhat.com>
References: <20191211084216.25405-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: iPLJMWKoPZK38Zq5HMW8AQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 31 ++++++++++++++------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virti=
o/virtgpu_plane.c
index bc4bc4475a8c..a0f91658c2bc 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -151,20 +151,23 @@ static void virtio_gpu_primary_plane_update(struct dr=
m_plane *plane,
 =09if (bo->dumb)
 =09=09virtio_gpu_update_dumb_bo(vgdev, bo, plane->state);
=20
-=09DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n",
-=09=09  bo->hw_res_handle,
-=09=09  plane->state->crtc_w, plane->state->crtc_h,
-=09=09  plane->state->crtc_x, plane->state->crtc_y,
-=09=09  plane->state->src_w >> 16,
-=09=09  plane->state->src_h >> 16,
-=09=09  plane->state->src_x >> 16,
-=09=09  plane->state->src_y >> 16);
-=09virtio_gpu_cmd_set_scanout(vgdev, output->index,
-=09=09=09=09   bo->hw_res_handle,
-=09=09=09=09   plane->state->src_w >> 16,
-=09=09=09=09   plane->state->src_h >> 16,
-=09=09=09=09   plane->state->src_x >> 16,
-=09=09=09=09   plane->state->src_y >> 16);
+=09if (plane->state->fb !=3D old_state->fb) {
+=09=09DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n",
+=09=09=09  bo->hw_res_handle,
+=09=09=09  plane->state->crtc_w, plane->state->crtc_h,
+=09=09=09  plane->state->crtc_x, plane->state->crtc_y,
+=09=09=09  plane->state->src_w >> 16,
+=09=09=09  plane->state->src_h >> 16,
+=09=09=09  plane->state->src_x >> 16,
+=09=09=09  plane->state->src_y >> 16);
+=09=09virtio_gpu_cmd_set_scanout(vgdev, output->index,
+=09=09=09=09=09   bo->hw_res_handle,
+=09=09=09=09=09   plane->state->src_w >> 16,
+=09=09=09=09=09   plane->state->src_h >> 16,
+=09=09=09=09=09   plane->state->src_x >> 16,
+=09=09=09=09=09   plane->state->src_y >> 16);
+=09}
+
 =09virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle,
 =09=09=09=09      plane->state->src_x >> 16,
 =09=09=09=09      plane->state->src_y >> 16,
--=20
2.18.1

