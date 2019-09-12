Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F88C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0917D20856
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="krDbwbOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbfILJla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:41:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43796 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbfILJl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:41:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id 4so11539352pld.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 02:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K8HzPj4CjTGqPIMExQrkFd76q28JYrYuyRqYSNyq/4c=;
        b=krDbwbOe6wjzVfF+U/pzAmXMrxhr3mUnguYMgh1Z7TqK9V/mvbvDLpDDq2aMYgpeWB
         T/ZsDxX0c8C5Pdg+UWgvKE8kCigOpvO+SYxItjUi61wMEXRogSlArgu7AfUDs3G+5/Q5
         aj60bXXpSg9XxqhtXX9cleM+9cHxoUU7fLFHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K8HzPj4CjTGqPIMExQrkFd76q28JYrYuyRqYSNyq/4c=;
        b=XtUNNylmSolG8jc6Y1WU+VUpS1qbRjY8nasv4hAiPaJIOQEOWGNQh/fdUobSLCLgm/
         qV1Zgk+fmo9vhV+I0YOIyutpnGmHfFmQ8W6ETvtrMLaSPFiUDehfZtQlbEmIRKjcq5Ei
         OLedi6/0TQ6fZI1CggfUgHP+lXp1FV8y6Xd0munTBt+vlBY+DGzSjrinl9fyAyRML52U
         eJI+YRlZUEtPO3MztWnA424I8KwjgHl4pemM/ehS1JF3ph6uFZ+sET/8RHB+5ZL5ezuW
         DJ/i039fOePFmJv72T0BLl5OHUbJddN1Q8699REqsHRcitRb+qkaHhSR5edPWKbl0Fka
         MSSg==
X-Gm-Message-State: APjAAAXKnimPSp/fwoDBEdmUSk3ffWopiNIhW7DuC4GwhYaX54sk3uK5
        bULbWh+NasvY7t1BUxZvJujDJQ==
X-Google-Smtp-Source: APXvYqzQKWP7aloYWrXlntiae1FVI/aefxFeH7mogABRe7PTrChaxwCSGskZ9qq5ospmeBNmBWjUbg==
X-Received: by 2002:a17:902:7b83:: with SMTP id w3mr12476006pll.3.1568281288738;
        Thu, 12 Sep 2019 02:41:28 -0700 (PDT)
Received: from tfiga.tok.corp.google.com ([2401:fa00:4:4:6d27:f13:a0fa:d4b6])
        by smtp.gmail.com with ESMTPSA id o195sm5695859pfg.21.2019.09.12.02.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 02:41:27 -0700 (PDT)
From:   Tomasz Figa <tfiga@chromium.org>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, stevensd@chromium.org,
        marcheu@chromium.org, zachr@chromium.org, keiichiw@chromium.org,
        posciak@chromium.org, Tomasz Figa <tfiga@chromium.org>
Subject: [RFC PATCH] drm/virtio: Export resource handles via DMA-buf API
Date:   Thu, 12 Sep 2019 18:41:21 +0900
Message-Id: <20190912094121.228435-1-tfiga@chromium.org>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is an early RFC to judge the direction we are following in
our virtualization efforts in Chrome OS. The purpose is to start a
discussion on how to handle buffer sharing between multiple virtio
devices.

On a side note, we are also working on a virtio video decoder interface
and implementation, with a V4L2 driver for Linux. Those will be posted
for review in the near future as well.

Any feedback will be appreciated! Thanks in advance.

===

With the range of use cases for virtualization expanding, there is going
to be more virtio devices added to the ecosystem. Devices such as video
decoders, encoders, cameras, etc. typically work together with the
display and GPU in a pipeline manner, which can only be implemented
efficiently by sharing the buffers between producers and consumers.

Existing buffer management framework in Linux, such as the videobuf2
framework in V4L2, implements all the DMA-buf handling inside generic
code and do not expose any low level information about the buffers to
the drivers.

To seamlessly enable buffer sharing with drivers using such frameworks,
make the virtio-gpu driver expose the resource handle as the DMA address
of the buffer returned from the DMA-buf mapping operation. Arguably, the
resource handle is a kind of DMA address already, as it is the buffer
identifier that the device needs to access the backing memory, which is
exactly the same role a DMA address provides for native devices.

A virtio driver that does memory management fully on its own would have
code similar to following. The code is identical to what a regular
driver for real hardware would do to import a DMA-buf.

static int virtio_foo_get_resource_handle(struct virtio_foo *foo,
					  struct dma_buf *dma_buf, u32 *id)
{
	struct dma_buf_attachment *attach;
	struct sg_table *sgt;
	int ret = 0;

	attach = dma_buf_attach(dma_buf, foo->dev);
	if (IS_ERR(attach))
		return PTR_ERR(attach);

	sgt = dma_buf_map_attachment(attach, DMA_BIDIRECTIONAL);
	if (IS_ERR(sgt)) {
		ret = PTR_ERR(sgt);
		goto err_detach;
	}

	if (sgt->nents != 1) {
		ret = -EINVAL;
		goto err_unmap;
	}

	*id = sg_dma_address(sgt->sgl);

err_unmap:
	dma_buf_unmap_attachment(attach, sgt, DMA_BIDIRECTIONAL);
err_detach:
	dma_buf_detach(dma_buf, attach);

	return ret;
}

On the other hand, a virtio driver that uses an existing kernel
framework to manage buffers would not need to explicitly handle anything
at all, as the framework part responsible for importing DMA-bufs would
already do the work. For example, a V4L2 driver using the videobuf2
framework would just call thee vb2_dma_contig_plane_dma_addr() function
to get what the above open-coded function would return.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c   |  2 +
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  4 ++
 drivers/gpu/drm/virtio/virtgpu_prime.c | 81 ++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 0fc32fa0b3c0..ac095f813134 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -210,6 +210,8 @@ static struct drm_driver driver = {
 #endif
 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
+	.gem_prime_export = virtgpu_gem_prime_export,
+	.gem_prime_import = virtgpu_gem_prime_import,
 	.gem_prime_get_sg_table = virtgpu_gem_prime_get_sg_table,
 	.gem_prime_import_sg_table = virtgpu_gem_prime_import_sg_table,
 	.gem_prime_vmap = virtgpu_gem_prime_vmap,
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index e28829661724..687cfce91885 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -367,6 +367,10 @@ void virtio_gpu_object_free_sg_table(struct virtio_gpu_object *bo);
 int virtio_gpu_object_wait(struct virtio_gpu_object *bo, bool no_wait);
 
 /* virtgpu_prime.c */
+struct dma_buf *virtgpu_gem_prime_export(struct drm_gem_object *obj,
+					 int flags);
+struct drm_gem_object *virtgpu_gem_prime_import(struct drm_device *dev,
+						struct dma_buf *buf);
 struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj);
 struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
 	struct drm_device *dev, struct dma_buf_attachment *attach,
diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
index dc642a884b88..562eb1a2ed5b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -22,6 +22,9 @@
  * Authors: Andreas Pokorny
  */
 
+#include <linux/dma-buf.h>
+#include <linux/dma-direction.h>
+
 #include <drm/drm_prime.h>
 
 #include "virtgpu_drv.h"
@@ -30,6 +33,84 @@
  * device that might share buffers with virtgpu
  */
 
+static struct sg_table *
+virtgpu_gem_map_dma_buf(struct dma_buf_attachment *attach,
+			enum dma_data_direction dir)
+{
+	struct drm_gem_object *obj = attach->dmabuf->priv;
+	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
+	struct sg_table *sgt;
+	int ret;
+
+	sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
+	if (!sgt)
+		return ERR_PTR(-ENOMEM);
+
+	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
+	if (ret) {
+		kfree(sgt);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	sg_dma_address(sgt->sgl) = bo->hw_res_handle;
+	sg_dma_len(sgt->sgl) = obj->size;
+	sgt->nents = 1;
+
+	return sgt;
+}
+
+static void virtgpu_gem_unmap_dma_buf(struct dma_buf_attachment *attach,
+				      struct sg_table *sgt,
+				      enum dma_data_direction dir)
+{
+	sg_free_table(sgt);
+	kfree(sgt);
+}
+
+static const struct dma_buf_ops virtgpu_dmabuf_ops =  {
+	.cache_sgt_mapping = true,
+	.attach = drm_gem_map_attach,
+	.detach = drm_gem_map_detach,
+	.map_dma_buf = virtgpu_gem_map_dma_buf,
+	.unmap_dma_buf = virtgpu_gem_unmap_dma_buf,
+	.release = drm_gem_dmabuf_release,
+	.mmap = drm_gem_dmabuf_mmap,
+	.vmap = drm_gem_dmabuf_vmap,
+	.vunmap = drm_gem_dmabuf_vunmap,
+};
+
+struct dma_buf *virtgpu_gem_prime_export(struct drm_gem_object *obj,
+					 int flags)
+{
+	struct dma_buf *buf;
+
+	buf = drm_gem_prime_export(obj, flags);
+	if (!IS_ERR(buf))
+		buf->ops = &virtgpu_dmabuf_ops;
+
+	return buf;
+}
+
+struct drm_gem_object *virtgpu_gem_prime_import(struct drm_device *dev,
+						struct dma_buf *buf)
+{
+	struct drm_gem_object *obj;
+
+	if (buf->ops == &virtgpu_dmabuf_ops) {
+		obj = buf->priv;
+		if (obj->dev == dev) {
+			/*
+			 * Importing dmabuf exported from our own gem increases
+			 * refcount on gem itself instead of f_count of dmabuf.
+			 */
+			drm_gem_object_get(obj);
+			return obj;
+		}
+	}
+
+	return drm_gem_prime_import(dev, buf);
+}
+
 struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj)
 {
 	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
-- 
2.23.0.237.gc6a4ce50a0-goog

