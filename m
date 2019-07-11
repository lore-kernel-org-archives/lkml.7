Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E247C74A36
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 02:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B39520844
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 02:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFssXHlc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfGKCkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 22:40:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46267 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfGKCkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 22:40:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id i8so2130740pgm.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 19:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C8E8H/QOJPMLUX+Dl+OKCeAuU0VWHZNPc5/1qNNCS3A=;
        b=LFssXHlc4NksAYAhzFzgi8xTRTyRMliELywQFv9VUJVWjf2PiU9RiGZ3zV9OaXaJfz
         91HAomEa81By0LAwwOEB9poOe8UtZyfG9My4IBU8GlmxOBGbsRXNWGH0/bts96LbnjnA
         NGQkIli+cQ/8qTzQXXfwnhF7U17UASCTKYqTMo/zn/0sP6m9Z0jHm9AixzwV084y/nqx
         8y2vGNX0GfKDQ+2gYrulCSBkZ9ssbkmBgG1bxloiWpKTGlMfoHhs298oR6oIMlTW4bk4
         B98fphK+vEl3DSmUmjhZgVDft0yE5G+Vh5F41jeQl5ag1xxzkRi75cZkX6ek98V4UOHK
         PCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C8E8H/QOJPMLUX+Dl+OKCeAuU0VWHZNPc5/1qNNCS3A=;
        b=pXJPm7YlXzEbB4J/m8hP5hNLpXYLjitwdsFsWOlsMSA+yLbS9Lkav4aoByo8EWt5zF
         i7I1cQ6sMWJnG5t2jJRWerdwxs8fVrMz3IVK9CBrkv/K5ETY2x7kKuzOYP3KOL+8GZzr
         i82r5TZpKOE8lOqgvFtwXkKtw3uVXJKOxMGBcKJZL7ER7L84s+mXmBqPxsJIjhvjET6l
         pwr8iiju5s3g/J/3SPQSqg21QlzZBPCbaSpPW2C5s3RcocMGMAl8WCSXN66TAfUdf+3I
         HV8F97RfNagiKy2mrtfhZvzLaLIXh6t0NSGQ4fMjbiVT4lCpDrgf1sHmhXAR3NtbThce
         q+kg==
X-Gm-Message-State: APjAAAU/KTNfRw7hJIDVdmMSOxOYZUfLT98muIS01JYUQTCVhAXM03N2
        5f5dJkxLqXRCYAI9VAalFJ8=
X-Google-Smtp-Source: APXvYqxPMPQEVTxxbc9UReUqfnmxUCvYxChCFWNedtCSJGKTOwJRfV39HBtupRw4ZTPjT4QYQz/DMQ==
X-Received: by 2002:a63:7b4d:: with SMTP id k13mr1686080pgn.182.1562812807406;
        Wed, 10 Jul 2019 19:40:07 -0700 (PDT)
Received: from olv0.mtv.corp.google.com ([2620:15c:202:201:9649:82d6:f889:b307])
        by smtp.gmail.com with ESMTPSA id bo20sm2877077pjb.23.2019.07.10.19.40.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 19:40:06 -0700 (PDT)
From:   Chia-I Wu <olvaffe@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/virtio: kick vq outside of the vq lock
Date:   Wed, 10 Jul 2019 19:39:59 -0700
Message-Id: <20190711023959.170158-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190711022937.166015-1-olvaffe@gmail.com>
References: <20190711022937.166015-1-olvaffe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace virtqueue_kick by virtqueue_kick_prepare, which requires
serialization, and virtqueue_notify, which does not.  Repurpose the
return values to indicate whether the vq should be notified.

This fixes a bad spinlock contention when the host is qemu.  When
the guest calls virtqueue_notify, the qemu vcpu thread exits the
guest and waits for the qemu iothread to perform the MMIO.  If the
qemu iothread is still processing the prior buffer, and if the prior
buffer is cheap to GPU, the iothread will go ahead and generate an
IRQ.  A worker thread in the guest might start running
virtio_gpu_dequeue_ctrl_func.  If virtqueue_notify was called with
the vq lock held, the worker thread would have to busy wait inside
virtio_gpu_dequeue_ctrl_func.

v2: fix scrambled commit message

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 6c1a90717535..e96f88fe5c83 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -291,11 +291,9 @@ static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
 		trace_virtio_gpu_cmd_queue(vq,
 			(struct virtio_gpu_ctrl_hdr *)vbuf->buf);
 
-		virtqueue_kick(vq);
+		ret = virtqueue_kick_prepare(vq);
 	}
 
-	if (!ret)
-		ret = vq->num_free;
 	return ret;
 }
 
@@ -307,6 +305,10 @@ static int virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
 	spin_lock(&vgdev->ctrlq.qlock);
 	rc = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
 	spin_unlock(&vgdev->ctrlq.qlock);
+
+	if (rc > 0)
+		virtqueue_notify(vgdev->ctrlq.vq);
+
 	return rc;
 }
 
@@ -339,6 +341,10 @@ static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 		virtio_gpu_fence_emit(vgdev, hdr, fence);
 	rc = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
 	spin_unlock(&vgdev->ctrlq.qlock);
+
+	if (rc > 0)
+		virtqueue_notify(vgdev->ctrlq.vq);
+
 	return rc;
 }
 
@@ -369,13 +375,14 @@ static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 		trace_virtio_gpu_cmd_queue(vq,
 			(struct virtio_gpu_ctrl_hdr *)vbuf->buf);
 
-		virtqueue_kick(vq);
+		ret = virtqueue_kick_prepare(vq);
 	}
 
 	spin_unlock(&vgdev->cursorq.qlock);
 
-	if (!ret)
-		ret = vq->num_free;
+	if (ret > 0)
+		virtqueue_notify(vq);
+
 	return ret;
 }
 
-- 
2.22.0.410.gd8fdbe21b5-goog

