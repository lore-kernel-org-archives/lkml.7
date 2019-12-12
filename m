Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99568C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCE1227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OD2xnlEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbfLLMx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:53:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60835 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729221AbfLLMx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 07:53:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576155235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=VVeZNerFz0m8O8v6gQkmOYeCxlg/A2VEf1w2oz635Wg=;
        b=OD2xnlEsEd9/W/WtIenOrNVDCunxAMfStg0XHsTouXeoTaIK63q3OlYA32llEFf6kVSxDr
        qdLD4aM+y93Z781aB4ph7IS0VfIwMvS0dzujKoouYEvtFrsOgdMT4gBO23aEXr2QSPzfB2
        asfrbdU3QOH+Q0aRT4eO8bIoGSG+XoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-KWdqMaUROhClFtPph7_W8w-1; Thu, 12 Dec 2019 07:53:52 -0500
X-MC-Unique: KWdqMaUROhClFtPph7_W8w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36297A89A18;
        Thu, 12 Dec 2019 12:53:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.36.118.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA8EA5DA7D;
        Thu, 12 Dec 2019 12:53:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id E843C9DB3; Thu, 12 Dec 2019 13:53:46 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     olvaffe@gmail.com, gurchetansingh@chromium.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/3] drm/virtio: skip set_scanout if framebuffer didn't change
Date:   Thu, 12 Dec 2019 13:53:44 +0100
Message-Id: <20191212125346.8334-2-kraxel@redhat.com>
In-Reply-To: <20191212125346.8334-1-kraxel@redhat.com>
References: <20191212125346.8334-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: also check src rect (Chia-I Wu).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 35 +++++++++++++++-----------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index bc4bc4475a8c..59bf76d4a333 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -151,20 +151,27 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 	if (bo->dumb)
 		virtio_gpu_update_dumb_bo(vgdev, bo, plane->state);
 
-	DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n",
-		  bo->hw_res_handle,
-		  plane->state->crtc_w, plane->state->crtc_h,
-		  plane->state->crtc_x, plane->state->crtc_y,
-		  plane->state->src_w >> 16,
-		  plane->state->src_h >> 16,
-		  plane->state->src_x >> 16,
-		  plane->state->src_y >> 16);
-	virtio_gpu_cmd_set_scanout(vgdev, output->index,
-				   bo->hw_res_handle,
-				   plane->state->src_w >> 16,
-				   plane->state->src_h >> 16,
-				   plane->state->src_x >> 16,
-				   plane->state->src_y >> 16);
+	if (plane->state->fb != old_state->fb ||
+	    plane->state->src_w != old_state->src_w ||
+	    plane->state->src_h != old_state->src_h ||
+	    plane->state->src_x != old_state->src_x ||
+	    plane->state->src_y != old_state->src_y) {
+		DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n",
+			  bo->hw_res_handle,
+			  plane->state->crtc_w, plane->state->crtc_h,
+			  plane->state->crtc_x, plane->state->crtc_y,
+			  plane->state->src_w >> 16,
+			  plane->state->src_h >> 16,
+			  plane->state->src_x >> 16,
+			  plane->state->src_y >> 16);
+		virtio_gpu_cmd_set_scanout(vgdev, output->index,
+					   bo->hw_res_handle,
+					   plane->state->src_w >> 16,
+					   plane->state->src_h >> 16,
+					   plane->state->src_x >> 16,
+					   plane->state->src_y >> 16);
+	}
+
 	virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle,
 				      plane->state->src_x >> 16,
 				      plane->state->src_y >> 16,
-- 
2.18.1

