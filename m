Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF59C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BE9208C2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfEFJLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:11:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58976 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfEFJLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:11:02 -0400
Received: from localhost.localdomain (unknown [IPv6:2a02:2450:102f:3e0:95da:b269:747c:91b3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robertfoss)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9A482261136;
        Mon,  6 May 2019 10:10:57 +0100 (BST)
From:   Robert Foss <robert.foss@collabora.com>
To:     airlied@linux.ie, kraxel@redhat.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Chia-I Wu <olvaffe@gmail.com>
Cc:     Robert Foss <robert.foss@collabora.com>,
        Emil Velikov <emil.velikov@collabora.com>
Subject: [PATCH v2] drm/virtio: Remove redundant return type
Date:   Mon,  6 May 2019 11:10:34 +0200
Message-Id: <20190506091034.30289-1-robert.foss@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio_gpu_fence_emit() always returns 0, since it
has no error paths.

Consequently no calls for virtio_gpu_fence_emit()
use the return value, and it can be removed.

Signed-off-by: Robert Foss <robert.foss@collabora.com>
Suggested-by: Emil Velikov <emil.velikov@collabora.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
---

This patch was suggested in this email thread:

[PATCH] drm/virtio: allocate fences with GFP_KERNEL
https://www.spinics.net/lists/dri-devel/msg208536.html

Changes since v1:
 - Rebased on drm-misc-next
 - Added r-b from Chia-I Wu


 drivers/gpu/drm/virtio/virtgpu_drv.h   | 2 +-
 drivers/gpu/drm/virtio/virtgpu_fence.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 90461feeafdb..2d3e5b1debb3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -355,7 +355,7 @@ int virtio_gpu_mmap(struct file *filp, struct vm_area_struct *vma);
 bool virtio_fence_signaled(struct dma_fence *f);
 struct virtio_gpu_fence *virtio_gpu_fence_alloc(
 	struct virtio_gpu_device *vgdev);
-int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
+void virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 			  struct virtio_gpu_ctrl_hdr *cmd_hdr,
 			  struct virtio_gpu_fence *fence);
 void virtio_gpu_fence_event_process(struct virtio_gpu_device *vdev,
diff --git a/drivers/gpu/drm/virtio/virtgpu_fence.c b/drivers/gpu/drm/virtio/virtgpu_fence.c
index 8aecc36a0417..70d6c4329778 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fence.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fence.c
@@ -85,7 +85,7 @@ struct virtio_gpu_fence *virtio_gpu_fence_alloc(struct virtio_gpu_device *vgdev)
 	return fence;
 }
 
-int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
+void virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 			  struct virtio_gpu_ctrl_hdr *cmd_hdr,
 			  struct virtio_gpu_fence *fence)
 {
@@ -102,7 +102,6 @@ int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 
 	cmd_hdr->flags |= cpu_to_le32(VIRTIO_GPU_FLAG_FENCE);
 	cmd_hdr->fence_id = cpu_to_le64(fence->f.seqno);
-	return 0;
 }
 
 void virtio_gpu_fence_event_process(struct virtio_gpu_device *vgdev,
-- 
2.20.1

