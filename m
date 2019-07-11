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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A6CC74A41
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 02:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA42621019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 02:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBE3eLC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfGKC3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 22:29:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45385 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbfGKC3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 22:29:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so2172194plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 19:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qPWrGW+mHyz/zxrmAaiQeG6b1c+y5yhmMgQ1hyiaZR0=;
        b=qBE3eLC4RA4F+HzzOw79/Ge4/+ES1SdQUKnZaGPTDpEUF8lt0KVkrqVWOAH8gpMusV
         SG2+KBYLVfOn5pgk4W6rG1t7np0qKA+oz0CdjwjzL6gSCe9eQoYjvZZIVdVUNXG+OVVr
         D5wKYCee+xGjkEvfLuvpHpwo0W0H6JMlD2Xu1zRBuyaZOZV+gR0FFXFoSMXagudf/RdK
         uuZK4pJg5lx4taqE1//t+jWtdifCnAgF6B/cKysKRztKwrbLOjmXuxE5eZ4Ls7fV6ZIr
         GJ+N2Xakvkqq0zyfzswiAJvrKiGDfMQBsRjsuQmPA+Wk9uROukpiddb2+mkaWJHCkFKL
         6PGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qPWrGW+mHyz/zxrmAaiQeG6b1c+y5yhmMgQ1hyiaZR0=;
        b=tBVACcOswpmufRkSpSpN5XYEvwpC3N/vHdaF/RcYqMRXbAhE3xdKcBjwhUt7Rze0r6
         OSve7XOEzc0t3U3pY84KTWTHXottfyRoF9yzY8Tb1haODB+QRyR1+OkiROV1UoZDi11R
         c71qM6yBV1HEOUTygvQQh9xs0xiv0YovLvz/wRJLtQIEpZLJZ0u+tQRoWeCL16iT4K0M
         0O9KQbky92KSb1ff2hlXfo48ZARbucgerceW6tiH2lh18UF/qWA/rbcGP7YWnwsDPZ+t
         lyUgR5VTkmul4/Kia+8DmqSzsivkRXLAXAcywt1U7vDNbQm4AZVuVmRj5+qY+zbtg8Y3
         wPaQ==
X-Gm-Message-State: APjAAAVgpXsPC6qnsQFvg1x5hFlEuuZt2estZ8LxbS19EIMgMm4tEXbg
        7UFIYDHpt8zSTh8ZSq23o1M=
X-Google-Smtp-Source: APXvYqxN90cLc00cYdWJNjcMcmyHeBOPnCRonXFxzLH+4vQTsAuClh9uNnBz+kEzScj2/zJk48u0Mw==
X-Received: by 2002:a17:902:2ec5:: with SMTP id r63mr1710517plb.21.1562812190534;
        Wed, 10 Jul 2019 19:29:50 -0700 (PDT)
Received: from olv0.mtv.corp.google.com ([2620:15c:202:201:9649:82d6:f889:b307])
        by smtp.gmail.com with ESMTPSA id x25sm1929986pfa.90.2019.07.10.19.29.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 19:29:49 -0700 (PDT)
From:   Chia-I Wu <olvaffe@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/virtio: kick vq outside of the vq lock
Date:   Wed, 10 Jul 2019 19:29:37 -0700
Message-Id: <20190711022937.166015-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace virtqueue_kick by virtqueue_kick_prepare, which requires
serialization, and virtqueue_notify, which does not.  Repurpose the
return values to indicate whether the vq should be notified.

This fixes a lock contention with qemu host.  When the guest calls
vibad rtqueue_notify, the qemu vcpu thread exits the guest and waits
for the qemu iothread to perform the MMIO.  If the qemu iothread is
still processing the prior buffer, and if the prior buffer is cheap
to GPU, the iothread will go ahead and generate an IRQ for the
guest.  A worker thread in the guest will call
virtio_gpu_dequeue_ctrl_func.  If virtqueue_notify was called with
the vq lock held, the worker thread would busy wait inside
virtio_gpu_dequeue_ctrl_func.

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

