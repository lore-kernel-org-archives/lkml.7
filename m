Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A65CC00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BC822527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PaAvFfP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfLLMyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:54:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53936 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729257AbfLLMx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 07:53:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576155236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=OazNm1SaswuOWYU26q0XV70wzTUo5ZlA+zoHIAi5e+c=;
        b=PaAvFfP/BrV7CS/u0AQ/ng8CHD5wkUj4e4pZzDiKmyHq/byqG91uxikQr6OHfa8FYNatPX
        QojSkDcp7t6PmHaC22AXB1HS/eCR0ZUsukqCCPXOMtLwP40qoTsqcHlhNznlhkhDy0jdUv
        SIjB4B/Tya5GMMKPIaOQPXT75F5ic1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418--b865QCBMMKLtzJ5QN0DBQ-1; Thu, 12 Dec 2019 07:53:53 -0500
X-MC-Unique: -b865QCBMMKLtzJ5QN0DBQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAEB9802570;
        Thu, 12 Dec 2019 12:53:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.36.118.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E2E2B166B7;
        Thu, 12 Dec 2019 12:53:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 34F679C90; Thu, 12 Dec 2019 13:53:47 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     olvaffe@gmail.com, gurchetansingh@chromium.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/3] virtio-gpu: use damage info for display updates.
Date:   Thu, 12 Dec 2019 13:53:46 +0100
Message-Id: <20191212125346.8334-4-kraxel@redhat.com>
In-Reply-To: <20191212125346.8334-1-kraxel@redhat.com>
References: <20191212125346.8334-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: remove shift by src_{x,y}, drm_atomic_helper_damage_merged()
    handles that for us (Chia-I Wu).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 41 +++++++++++++++-----------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 2fb068cd680e..ecc2157ab6f2 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -24,6 +24,7 @@
  */
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_damage_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_plane_helper.h>
 
@@ -103,22 +104,26 @@ static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
 }
 
 static void virtio_gpu_update_dumb_bo(struct virtio_gpu_device *vgdev,
-				      struct virtio_gpu_object *bo,
-				      struct drm_plane_state *state)
+				      struct drm_plane_state *state,
+				      struct drm_rect *rect)
 {
+	struct virtio_gpu_object *bo =
+		gem_to_virtio_gpu_obj(state->fb->obj[0]);
 	struct virtio_gpu_object_array *objs;
+	uint32_t w = rect->x2 - rect->x1;
+	uint32_t h = rect->y2 - rect->y1;
+	uint32_t x = rect->x1;
+	uint32_t y = rect->y1;
+	uint32_t off = x * state->fb->format->cpp[0] +
+		y * state->fb->pitches[0];
 
 	objs = virtio_gpu_array_alloc(1);
 	if (!objs)
 		return;
 	virtio_gpu_array_add_obj(objs, &bo->base.base);
-	virtio_gpu_cmd_transfer_to_host_2d
-		(vgdev, 0,
-		 state->src_w >> 16,
-		 state->src_h >> 16,
-		 state->src_x >> 16,
-		 state->src_y >> 16,
-		 objs, NULL);
+
+	virtio_gpu_cmd_transfer_to_host_2d(vgdev, off, w, h, x, y,
+					   objs, NULL);
 }
 
 static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
@@ -127,8 +132,8 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 	struct drm_device *dev = plane->dev;
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_output *output = NULL;
-	struct virtio_gpu_framebuffer *vgfb;
 	struct virtio_gpu_object *bo;
+	struct drm_rect rect;
 
 	if (plane->state->crtc)
 		output = drm_crtc_to_virtio_gpu_output(plane->state->crtc);
@@ -146,12 +151,14 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 		return;
 	}
 
+	if (!drm_atomic_helper_damage_merged(old_state, plane->state, &rect))
+		return;
+
 	virtio_gpu_disable_notify(vgdev);
 
-	vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
-	bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
+	bo = gem_to_virtio_gpu_obj(plane->state->fb->obj[0]);
 	if (bo->dumb)
-		virtio_gpu_update_dumb_bo(vgdev, bo, plane->state);
+		virtio_gpu_update_dumb_bo(vgdev, plane->state, &rect);
 
 	if (plane->state->fb != old_state->fb ||
 	    plane->state->src_w != old_state->src_w ||
@@ -175,10 +182,10 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 	}
 
 	virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle,
-				      plane->state->src_x >> 16,
-				      plane->state->src_y >> 16,
-				      plane->state->src_w >> 16,
-				      plane->state->src_h >> 16);
+				      rect.x1,
+				      rect.y1,
+				      rect.x2 - rect.x1,
+				      rect.y2 - rect.y1);
 
 	virtio_gpu_enable_notify(vgdev);
 }
-- 
2.18.1

