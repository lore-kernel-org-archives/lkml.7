Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68665C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3632133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbfDJLmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:42:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731223AbfDJLmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:42:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F882308213B;
        Wed, 10 Apr 2019 11:42:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-65.ams2.redhat.com [10.36.116.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A2D86013A;
        Wed, 10 Apr 2019 11:42:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5BE261747B; Wed, 10 Apr 2019 13:42:27 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, virtio@lists.oasis-open.org
Cc:     David Airlie <airlied@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO CORE, NET
        AND BLOCK DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] virtio-gpu api: VIRTIO_GPU_F_MEMORY
Date:   Wed, 10 Apr 2019 13:42:26 +0200
Message-Id: <20190410114227.25846-3-kraxel@redhat.com>
In-Reply-To: <20190410114227.25846-1-kraxel@redhat.com>
References: <20190410114227.25846-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 10 Apr 2019 11:42:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the concept of memory regions to virtio-gpu.  Initially only
memory regions composed of guest pages are supported (pretty much like
current backing storage for resources).  I expect support for other
memory types will be added later on.

VIRTIO_GPU_CMD_MEMORY_CREATE:
    creates a new memory region.

VIRTIO_GPU_CMD_MEMORY_UNREF:
    destroys a memory region.

VIRTIO_GPU_CMD_RESOURCE_ATTACH_MEMORY:
    Use memory region as backing storage for the given resource.
    The existing VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING command
    can be used to detach.

Motivation: This separates storage management from resource management.
It allows memory pooling (vulkan support will most likely need this).
It makes things a bit more flexible in general, for example we can
represent gem objects as memory regions even if we don't know the format
yet (happens on dma-buf import for example).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/uapi/linux/virtio_gpu.h | 38 +++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index 0c85914d9369..732bb16a39f8 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -51,6 +51,13 @@
  */
 #define VIRTIO_GPU_F_EDID                1
 
+/*
+ * VIRTIO_GPU_CMD_MEMORY_CREATE
+ * VIRTIO_GPU_CMD_MEMORY_UNREF
+ * VIRTIO_GPU_CMD_RESOURCE_ATTACH_MEMORY
+ */
+#define VIRTIO_GPU_F_MEMORY              2
+
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
 
@@ -66,6 +73,9 @@ enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_CMD_GET_CAPSET_INFO,
 	VIRTIO_GPU_CMD_GET_CAPSET,
 	VIRTIO_GPU_CMD_GET_EDID,
+	VIRTIO_GPU_CMD_MEMORY_CREATE,
+	VIRTIO_GPU_CMD_MEMORY_UNREF,
+	VIRTIO_GPU_CMD_RESOURCE_ATTACH_MEMORY,
 
 	/* 3d commands */
 	VIRTIO_GPU_CMD_CTX_CREATE = 0x0200,
@@ -95,6 +105,7 @@ enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID,
 	VIRTIO_GPU_RESP_ERR_INVALID_CONTEXT_ID,
 	VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER,
+	VIRTIO_GPU_RESP_ERR_INVALID_MEMORY_ID,
 };
 
 #define VIRTIO_GPU_FLAG_FENCE (1 << 0)
@@ -187,6 +198,7 @@ struct virtio_gpu_resource_attach_backing {
 	struct virtio_gpu_ctrl_hdr hdr;
 	__le32 resource_id;
 	__le32 nr_entries;
+	/* struct virtio_gpu_mem_entry entries follow here */
 };
 
 /* VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING */
@@ -270,6 +282,32 @@ struct virtio_gpu_cmd_submit {
 	__le32 padding;
 };
 
+/* VIRTIO_GPU_CMD_MEMORY_CREATE */
+struct virtio_gpu_cmd_memory_create {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le64 size;
+	__le32 memory_id;
+	__le32 nr_entries;
+	__le32 flags;
+	__le32 padding;
+	/* struct virtio_gpu_mem_entry entries follow here */
+};
+
+/* VIRTIO_GPU_CMD_MEMORY_UNREF */
+struct virtio_gpu_cmd_memory_unref {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 memory_id;
+	__le32 padding;
+};
+
+/* VIRTIO_GPU_CMD_RESOURCE_ATTACH_MEMORY */
+struct virtio_gpu_cmd_resource_attach_memory {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 resource_id;
+	__le32 memory_id;
+	__le64 offset[4];
+};
+
 #define VIRTIO_GPU_CAPSET_VIRGL 1
 #define VIRTIO_GPU_CAPSET_VIRGL2 2
 
-- 
2.18.1

