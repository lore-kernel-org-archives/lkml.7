Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB04BC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 20:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B915D21019
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 20:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nTUelCMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfIJUG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 16:06:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45681 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfIJUG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 16:06:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id y72so12149698pfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 13:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0QByh7nMUE4DnF1EZmnVCO0LesBewegKmGWKg2jdIyE=;
        b=nTUelCMWT/OF5pwZR9T+jGu510zTnmwud9l5EN0tgRovfWW3EYCEcVjRSwfD8F+hPw
         yAIdumgV1m7JRyUG7aabeXsBuJzUH71TonbwfImsqF5M8kj+jUqR8e83DIwTd/uGBLma
         /lCZB6Hq4zwK53E1k9KIQDRF0+VKGvwzIwlyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0QByh7nMUE4DnF1EZmnVCO0LesBewegKmGWKg2jdIyE=;
        b=rn6XZLGMLGADdflrN5X0v+4YgnuAfykA9slk9MM1urqoFsNt9vZNyueujZ0KewA0eR
         tnKTdQ5CgLFfGrhCDAxjtI2t3RuyJYc2kjsUIBgXh561V+e7Y+FFoAF5pwSug4xQ7m3e
         oR9Eke0tZUX960ey+61XNt1l38XsGM/8UcJG9lCeYqv70he8fj2F4XEB0bhuFSQst1zM
         OMjidROqjZHNyiHDpRPkW47jAY095S8G/Oy/Gfms77ojTthBvQPGb02XJk25rLiNd9If
         rZj+w+N/H3f6r3tDGs1e3TYAJERPuwCxGfRTJeDQiXxQ32eOoqRNpvfuQB2RMTdZz7pl
         WAdg==
X-Gm-Message-State: APjAAAVtYydy8lz+JkbNgB7jloLBSJMxdB7t630vNakUVkRWyysg9Vx+
        1JJUhkO3fDyMUv3ZxJLEBJZ85g==
X-Google-Smtp-Source: APXvYqwY8ZIVNVGdt/gxFNSdRhnyOwo46cUOwbhh5f13J3xXT4X/se8iTQ5/XLLxoCcy8JMm8lWmtg==
X-Received: by 2002:a63:1:: with SMTP id 1mr29256800pga.162.1568146018680;
        Tue, 10 Sep 2019 13:06:58 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:e9ae:bd45:1bd9:e60d])
        by smtp.gmail.com with ESMTPSA id q20sm35751990pfg.85.2019.09.10.13.06.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2019 13:06:58 -0700 (PDT)
From:   David Riley <davidriley@chromium.org>
To:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        linux-kernel@vger.kernel.org, David Riley <davidriley@chromium.org>
Subject: [PATCH v3 1/2] drm/virtio: Rewrite virtio_gpu_queue_ctrl_buffer using fenced version.
Date:   Tue, 10 Sep 2019 13:06:50 -0700
Message-Id: <20190910200651.118628-1-davidriley@chromium.org>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
In-Reply-To: <20190829212417.257397-1-davidriley@chromium.org>
References: <20190829212417.257397-1-davidriley@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor function in preparation to generating scatterlist prior to locking.

Signed-off-by: David Riley <davidriley@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 981ee16e3ee9..bf5a4a50b002 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -299,17 +299,6 @@ static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
 	return ret;
 }
 
-static int virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
-					struct virtio_gpu_vbuffer *vbuf)
-{
-	int rc;
-
-	spin_lock(&vgdev->ctrlq.qlock);
-	rc = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
-	spin_unlock(&vgdev->ctrlq.qlock);
-	return rc;
-}
-
 static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 					       struct virtio_gpu_vbuffer *vbuf,
 					       struct virtio_gpu_ctrl_hdr *hdr,
@@ -335,13 +324,19 @@ static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 		goto again;
 	}
 
-	if (fence)
+	if (hdr && fence)
 		virtio_gpu_fence_emit(vgdev, hdr, fence);
 	rc = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
 	spin_unlock(&vgdev->ctrlq.qlock);
 	return rc;
 }
 
+static int virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
+					struct virtio_gpu_vbuffer *vbuf)
+{
+	return virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, NULL, NULL);
+}
+
 static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 				   struct virtio_gpu_vbuffer *vbuf)
 {
-- 
2.23.0.162.g0b9fbb3734-goog

