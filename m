Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581ADC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294C42084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbfDJLme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:42:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbfDJLmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:42:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 917B9A457A;
        Wed, 10 Apr 2019 11:42:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-65.ams2.redhat.com [10.36.116.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21C2C5D719;
        Wed, 10 Apr 2019 11:42:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 7351C1747C; Wed, 10 Apr 2019 13:42:27 +0200 (CEST)
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
Subject: [PATCH 3/3] virtio-gpu api: VIRTIO_GPU_F_RESSOURCE_V2
Date:   Wed, 10 Apr 2019 13:42:27 +0200
Message-Id: <20190410114227.25846-4-kraxel@redhat.com>
In-Reply-To: <20190410114227.25846-1-kraxel@redhat.com>
References: <20190410114227.25846-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 10 Apr 2019 11:42:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new command VIRTIO_GPU_CMD_RESOURCE_CREATE_V2 to create resources.
It adds (a) support planar resources and (b) returns stride and size of
the resource planes.  The later will be needed in case we support
mapping host resources into the guest some day.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/uapi/linux/virtio_gpu.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index 732bb16a39f8..00010315e500 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -58,6 +58,11 @@
  */
 #define VIRTIO_GPU_F_MEMORY              2
 
+/*
+ * VIRTIO_GPU_CMD_RESOURCE_CREATE_V2 command
+ */
+#define VIRTIO_GPU_F_RESSOURCE_V2        3
+
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
 
@@ -76,6 +81,7 @@ enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_CMD_MEMORY_CREATE,
 	VIRTIO_GPU_CMD_MEMORY_UNREF,
 	VIRTIO_GPU_CMD_RESOURCE_ATTACH_MEMORY,
+	VIRTIO_GPU_CMD_RESOURCE_CREATE_V2,
 
 	/* 3d commands */
 	VIRTIO_GPU_CMD_CTX_CREATE = 0x0200,
@@ -97,6 +103,7 @@ enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_RESP_OK_CAPSET_INFO,
 	VIRTIO_GPU_RESP_OK_CAPSET,
 	VIRTIO_GPU_RESP_OK_EDID,
+	VIRTIO_GPU_RESP_OK_RESOURCE_INFO,
 
 	/* error responses */
 	VIRTIO_GPU_RESP_ERR_UNSPEC = 0x1200,
@@ -308,6 +315,30 @@ struct virtio_gpu_cmd_resource_attach_memory {
 	__le64 offset[4];
 };
 
+/* VIRTIO_GPU_CMD_RESOURCE_CREATE_V2 */
+struct virtio_gpu_cmd_resource_create_v2 {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 resource_id;
+	__le32 format;
+	__le32 width;
+	__le32 height;
+	/* 3d only */
+	__le32 target;
+	__le32 bind;
+	__le32 depth;
+	__le32 array_size;
+	__le32 last_level;
+	__le32 nr_samples;
+	__le32 flags;
+};
+
+/* VIRTIO_GPU_RESP_OK_RESOURCE_INFO */
+struct virtio_gpu_resp_resource_info {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 stride[4];
+	__le32 size[4];
+};
+
 #define VIRTIO_GPU_CAPSET_VIRGL 1
 #define VIRTIO_GPU_CAPSET_VIRGL2 2
 
-- 
2.18.1

