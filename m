Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A309FC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7258D2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MhC7MN/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbfIKSOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 14:14:14 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:47065 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729603AbfIKSON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 14:14:13 -0400
Received: by mail-pl1-f196.google.com with SMTP id t1so10500299plq.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 11:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L9IbDqUTGBygNy+oR2XxFsB0ml5gSNHNj1uTpRYIros=;
        b=MhC7MN/apPQSoFA8X1UHoVchEHf+GZPkz3MgJqtM2HORK887vTnLMk7NLBjfOXS+VN
         sKTuF7MuJbbC6Oxd3wYiwhBVVhjsvZB+aIaJp2v5itq3fmCByv2MaptiY/SQkI00Q8Pa
         fBeFLKUkPcVMdadxPYSsrybRpDuaP6qLeH7/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L9IbDqUTGBygNy+oR2XxFsB0ml5gSNHNj1uTpRYIros=;
        b=ahVMHw1bekOaS+WAhzYYDvoq/u+duqZInzjE/oCvTDmAEJt7WtUtn5AXbxxmRmwwmC
         QPJaERHt4yj7YM4GlXBi+luRii0nI4kQbBr+y2Us3tcW+/BREw9QJE9fncw24nlx1Mep
         eTNVmFVAQm/VGE4tfdmN39j3XwfwkybGZYQlQmxA/D4/fcBqQWIELo8jdQCrud17zuJM
         mo16jQraXMAFYnsd95BN6FXkkqOdYYhtWXZP4o0uzT7DcWCSbcOH1ULPRmGBR/8NmLcm
         GNpk2C+LwdZL8Gut3a3Rkj7xDBvZuU0Dm7raI12rcKovEO7jQ7/w2tfkGsjBFDWUNPxF
         BqXA==
X-Gm-Message-State: APjAAAWC+F86S2VhTBqcfM6YVOSxGGNhTzgGVdIcDdpJNdmR/+zpPf04
        ij0J1ODnD2eKG+DmOBV6pylMEA==
X-Google-Smtp-Source: APXvYqwrk8BaEtJFsri5kEZloNqGAXR5GggYYG0Cm6osA9TNijyLnXfzXL/Z4rcUfYAySwW+8Rlo8A==
X-Received: by 2002:a17:902:5ac3:: with SMTP id g3mr40522769plm.25.1568225652289;
        Wed, 11 Sep 2019 11:14:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:e9ae:bd45:1bd9:e60d])
        by smtp.gmail.com with ESMTPSA id s18sm29288578pfh.0.2019.09.11.11.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2019 11:14:11 -0700 (PDT)
From:   David Riley <davidriley@chromium.org>
To:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        linux-kernel@vger.kernel.org, David Riley <davidriley@chromium.org>
Subject: [PATCH v4 1/2] drm/virtio: Rewrite virtio_gpu_queue_ctrl_buffer using fenced version.
Date:   Wed, 11 Sep 2019 11:14:02 -0700
Message-Id: <20190911181403.40909-2-davidriley@chromium.org>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
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
 drivers/gpu/drm/virtio/virtgpu_vq.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 7fd2851f7b97..5a64c776138d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -302,18 +302,6 @@ static bool virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
 	return notify;
 }
 
-static void virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
-					 struct virtio_gpu_vbuffer *vbuf)
-{
-	bool notify;
-
-	spin_lock(&vgdev->ctrlq.qlock);
-	notify = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
-	spin_unlock(&vgdev->ctrlq.qlock);
-	if (notify)
-		virtqueue_notify(vgdev->ctrlq.vq);
-}
-
 static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 						struct virtio_gpu_vbuffer *vbuf,
 						struct virtio_gpu_ctrl_hdr *hdr,
@@ -339,7 +327,7 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 		goto again;
 	}
 
-	if (fence) {
+	if (hdr && fence) {
 		virtio_gpu_fence_emit(vgdev, hdr, fence);
 		if (vbuf->objs) {
 			virtio_gpu_array_add_fence(vbuf->objs, &fence->f);
@@ -352,6 +340,12 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 		virtqueue_notify(vgdev->ctrlq.vq);
 }
 
+static void virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
+					 struct virtio_gpu_vbuffer *vbuf)
+{
+	virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, NULL, NULL);
+}
+
 static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_vbuffer *vbuf)
 {
-- 
2.23.0.162.g0b9fbb3734-goog

