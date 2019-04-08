Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD82C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378912087F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfDHL4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:56:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:43027 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726396AbfDHLza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:55:30 -0400
X-UUID: b3bc04c3f0ef4f249a3dacb09d7d7ab2-20190408
X-UUID: b3bc04c3f0ef4f249a3dacb09d7d7ab2-20190408
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2000701428; Mon, 08 Apr 2019 19:55:21 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 8 Apr 2019 19:55:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 8 Apr 2019 19:55:19 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Stu Hsieh <stu.hsieh@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH 01/14] [media] mtk-mipicsi: add mediatek mipicsi driver for mt2712
Date:   Mon, 8 Apr 2019 19:54:52 +0800
Message-ID: <1554724505-19882-2-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1554724505-19882-1-git-send-email-stu.hsieh@mediatek.com>
References: <1554724505-19882-1-git-send-email-stu.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add mediatek mipicsi driver for mt2712,
including probe function to get the value from device tree,
and register to v4l2 the host device.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/media/platform/mtk-mipicsi/Makefile   |   4 +
 .../media/platform/mtk-mipicsi/mtk_mipicsi.c  | 768 ++++++++++++++++++
 2 files changed, 772 insertions(+)
 create mode 100644 drivers/media/platform/mtk-mipicsi/Makefile
 create mode 100644 drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c

diff --git a/drivers/media/platform/mtk-mipicsi/Makefile b/drivers/media/platform/mtk-mipicsi/Makefile
new file mode 100644
index 000000000000..326a5e3808fa
--- /dev/null
+++ b/drivers/media/platform/mtk-mipicsi/Makefile
@@ -0,0 +1,4 @@
+mtk-mipicsi-y += mtk_mipicsi.o
+
+obj-$(CONFIG_VIDEO_MEDIATEK_MIPICSI) += mtk-mipicsi.o
+
diff --git a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
new file mode 100644
index 000000000000..2e6c3073c064
--- /dev/null
+++ b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
@@ -0,0 +1,768 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 MediaTek Inc.
+ * Author: Ricky Zhang <ricky.zhang@mediatek.com>
+ *         Baoyin Zhang <baoyin.zhang@mediatek.com>
+ *         Alan Yue <alan.yue@mediatek.com>
+ *         Stu Hsieh <stu.hsieh@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * http://www.gnu.org/licenses/gpl-2.0.html for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/pm_runtime.h>
+#include <linux/iommu.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <media/v4l2-common.h>
+#include <media/v4l2-dev.h>
+#include <media/videobuf2-dma-contig.h>
+#include <media/soc_camera.h>
+#include <media/drv-intf/soc_mediabus.h>
+#include <media/videobuf2-core.h>
+#include <linux/videodev2.h>
+#include <soc/mediatek/smi.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+
+#ifdef CONFIG_VB2_MEDIATEK_DMA_SG
+#include "mtkbuf-dma-cache-sg.h"
+#endif
+
+#define MTK_MIPICSI_DRV_NAME "mtk-mipicsi"
+#define MTK_PLATFORM_STR "platform:mt2712"
+#define MIPICSI_COMMON_CLK 2
+#define MTK_CAMDMA_MAX_NUM 4U
+#define MIPICSI_CLK (MIPICSI_COMMON_CLK + MTK_CAMDMA_MAX_NUM)
+#define MTK_DATAWIDTH_8					(0x01U << 7U)
+#define MAX_SUPPORT_WIDTH             4096U
+#define MAX_SUPPORT_HEIGHT            4096U
+#define MAX_BUFFER_NUM			32U
+#define VID_LIMIT_BYTES			(100U * 1024U * 1024U)
+
+/* buffer for one video frame */
+struct mtk_mipicsi_buf {
+	struct list_head queue;
+	struct vb2_buffer *vb;
+	dma_addr_t vb_dma_addr_phy;
+	int prepare_flag;
+};
+
+struct mtk_mipicsi_dev {
+	struct soc_camera_host	soc_host;
+	struct platform_device *pdev;
+	unsigned int camsv_num;
+	struct v4l2_device	v4l2_dev;
+	struct device *larb_pdev;
+	void __iomem		*ana;
+	void __iomem		*seninf_ctrl;
+	void __iomem		*seninf;
+	struct regmap		*seninf_top;
+	void __iomem		*seninf_mux[MTK_CAMDMA_MAX_NUM];
+	void __iomem		*camsv[MTK_CAMDMA_MAX_NUM];
+	const struct soc_camera_format_xlate *current_fmt;
+	u16				width_flags;	/* max 12 bits */
+	struct list_head	capture_list[MTK_CAMDMA_MAX_NUM];
+	struct list_head	fb_list;
+	spinlock_t		lock;
+	spinlock_t		queue_lock;
+	struct mtk_mipicsi_buf	cam_buf[MAX_BUFFER_NUM];
+	bool streamon;
+	unsigned long frame_cnt[MTK_CAMDMA_MAX_NUM];
+	unsigned int link;
+	unsigned long enqueue_cnt;
+	unsigned long dequeue_cnt;
+	struct v4l2_ctrl_handler ctrl_hdl;
+	char drv_name[16];
+	u32 id;
+	int clk_num;
+	struct clk		*clk[MIPICSI_CLK];
+};
+
+#define MTK_MIPICSI_BUS_PARAM (V4L2_MBUS_MASTER |	\
+		V4L2_MBUS_HSYNC_ACTIVE_HIGH |	\
+		V4L2_MBUS_HSYNC_ACTIVE_LOW |	\
+		V4L2_MBUS_VSYNC_ACTIVE_HIGH |	\
+		V4L2_MBUS_VSYNC_ACTIVE_LOW |	\
+		V4L2_MBUS_PCLK_SAMPLE_RISING |	\
+		V4L2_MBUS_PCLK_SAMPLE_FALLING |	\
+		V4L2_MBUS_DATA_ACTIVE_HIGH)
+
+static int mtk_mipicsi_add_device(struct soc_camera_device *icd)
+{
+	struct v4l2_subdev *sd = soc_camera_to_subdev(icd);
+	struct v4l2_subdev_format format = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	int ret;
+
+	/* Get width/height info from subdev. Then use them to set register */
+	ret = v4l2_subdev_call(sd, pad, get_fmt, NULL, &format);
+	if (ret < 0) {
+		dev_err(icd->parent, "sub device get_fmt fail\n");
+		return ret;
+	}
+
+	/*
+	 * If power domain was closed before, it will be open.
+	 * Then clock will be open and register will be set
+	 */
+	(void)pm_runtime_get_sync(icd->parent);
+	return 0;
+}
+
+static void mtk_mipicsi_remove_device(struct soc_camera_device *icd)
+{
+	(void)pm_runtime_put_sync(icd->parent);
+}
+
+static int mtk_mipicsi_set_fmt(struct soc_camera_device *icd,
+				struct v4l2_format *f)
+{
+	struct soc_camera_host *ici = to_soc_camera_host(icd->parent);
+	struct mtk_mipicsi_dev *mipicsi = ici->priv;
+	struct device *dev = &mipicsi->pdev->dev;
+	struct v4l2_subdev *sd = soc_camera_to_subdev(icd);
+	const struct soc_camera_format_xlate *xlate = NULL;
+	struct v4l2_pix_format *pix = &f->fmt.pix;
+	struct v4l2_subdev_format format = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+	};
+	struct v4l2_mbus_framefmt *mf = &format.format;
+	int ret = 0;
+
+	xlate = soc_camera_xlate_by_fourcc(icd, pix->pixelformat);
+	if (xlate == NULL) {
+		dev_err(dev, "Format 0x%x not found\n", pix->pixelformat);
+		return -EINVAL;
+	}
+
+	mf->width	= pix->width;
+	mf->height	= pix->height;
+	mf->field	= pix->field;
+	mf->colorspace	= pix->colorspace;
+	mf->code	= xlate->code;
+
+	ret = v4l2_subdev_call(sd, pad, set_fmt, NULL, &format);
+	pix->width		= mf->width;
+	pix->height		= mf->height;
+	pix->field		= mf->field;
+	pix->colorspace		= mf->colorspace;
+	icd->current_fmt	= xlate;
+	if (pix->pixelformat == V4L2_PIX_FMT_YUYV)
+		pix->sizeimage = pix->width * pix->height * 2U;
+
+	if (mf->code != xlate->code)
+		return -EINVAL;
+
+	return ret;
+}
+
+static int mtk_mipicsi_try_fmt(struct soc_camera_device *icd,
+			      struct v4l2_format *f)
+{
+	struct v4l2_subdev *sd = soc_camera_to_subdev(icd);
+	const struct soc_camera_format_xlate *xlate = NULL;
+	struct v4l2_pix_format *pix = &f->fmt.pix;
+	struct v4l2_subdev_pad_config pad_cfg;
+	struct v4l2_subdev_format format = {
+		.which = V4L2_SUBDEV_FORMAT_TRY,
+	};
+	struct v4l2_mbus_framefmt *mf = &format.format;
+	u32 pixfmt = pix->pixelformat;
+	int ret = 0;
+
+	xlate = soc_camera_xlate_by_fourcc(icd, pixfmt);
+	if (xlate == NULL) {
+		xlate = icd->current_fmt;
+		dev_dbg(icd->parent, "Format %x not found, keeping %x\n",
+			pixfmt, xlate->host_fmt->fourcc);
+		pixfmt = xlate->host_fmt->fourcc;
+		pix->pixelformat = pixfmt;
+		pix->colorspace = icd->colorspace;
+	}
+
+	/* limit to  MTK hardware capabilities */
+	pix->height = min(pix->height, MAX_SUPPORT_HEIGHT);
+	pix->width = min(pix->width, MAX_SUPPORT_WIDTH);
+
+	/* limit to sensor capabilities */
+	mf->width	= pix->width;
+	mf->height	= pix->height;
+	mf->field	= pix->field;
+	mf->colorspace	= pix->colorspace;
+	mf->code	= xlate->code;
+
+	ret = v4l2_subdev_call(sd, pad, set_fmt, &pad_cfg, &format);
+	if (ret < 0)
+		return ret;
+
+	pix->width	= mf->width;
+	pix->height	= mf->height;
+	pix->field	= mf->field;
+	pix->colorspace	= mf->colorspace;
+	pix->bytesperline = pix->width * 2U;
+	pix->sizeimage = pix->bytesperline * pix->height;
+
+	return ret;
+}
+
+static int mtk_mipicsi_vb2_queue_setup(struct vb2_queue *vq,
+		unsigned int *nbufs,
+		unsigned int *num_planes, unsigned int sizes[],
+		struct device *alloc_devs[])
+{
+	struct soc_camera_device *icd = soc_camera_from_vb2q(vq);
+	u32 sizeimage = icd->sizeimage;
+
+	if (*nbufs == 0U || *nbufs > MAX_BUFFER_NUM)
+		*nbufs = MAX_BUFFER_NUM;
+	if (sizeimage * *nbufs > VID_LIMIT_BYTES)
+		*nbufs = VID_LIMIT_BYTES / sizeimage;
+
+	/*
+	 * Called from VIDIOC_REQBUFS or in compatibility mode For YUV422P
+	 * format, even if there are 3 planes Y, U and V, we reply there is only
+	 * one plane, containing Y, U and V data, one after the other.
+	 */
+	if (*num_planes != 0U)
+		return sizes[0] < sizeimage ? -EINVAL : 0;
+	sizes[0] = sizeimage;
+	*num_planes = 1;
+	return 0;
+}
+
+static int mtk_mipicsi_vb2_init(struct vb2_buffer *vb)
+{
+	struct mtk_mipicsi_dev *mipicsi = vb2_get_drv_priv(vb->vb2_queue);
+
+	mipicsi->cam_buf[vb->index].prepare_flag = 0;
+
+	return 0;
+}
+
+static int mtk_mipicsi_vb2_prepare(struct vb2_buffer *vb)
+{
+	struct soc_camera_device *icd = NULL;
+	struct soc_camera_host *ici = NULL;
+	struct mtk_mipicsi_dev *mipicsi = NULL;
+	struct mtk_mipicsi_buf *buf;
+	u32 size = 0;
+	char *va = NULL;
+
+	/* notice that vb->vb2_queue addr equals to soc_camera_device->vb2_vidq.
+	 *  It was handled in reqbufs
+	 */
+	icd = soc_camera_from_vb2q(vb->vb2_queue);
+	ici = to_soc_camera_host(icd->parent);
+	mipicsi = ici->priv;
+	buf = &mipicsi->cam_buf[vb->index];
+	size = icd->sizeimage;
+
+	if (vb2_plane_size(vb, 0) < size) {
+		dev_err(icd->parent, "data will not fit into plane (%lu < %u)",
+			vb2_plane_size(vb, 0), size);
+		return -EINVAL;
+	}
+
+	vb2_set_plane_payload(vb, 0, size);
+
+	if ((buf->prepare_flag) == 0) {
+		buf->prepare_flag = 1;
+#ifdef CONFIG_VB2_MEDIATEK_DMA_SG
+		buf->vb_dma_addr_phy =
+			mtk_dma_sg_plane_dma_addr(vb, 0);
+#else
+		buf->vb_dma_addr_phy =
+			vb2_dma_contig_plane_dma_addr(vb, 0);
+#endif
+		va = vb2_plane_vaddr(vb, 0);
+		buf->vb = vb;
+	}
+
+	return 0;
+}
+
+static void mtk_mipicsi_vb2_queue(struct vb2_buffer *vb)
+{
+	struct soc_camera_device *icd = soc_camera_from_vb2q(vb->vb2_queue);
+	struct soc_camera_host *ici = to_soc_camera_host(icd->parent);
+	struct mtk_mipicsi_dev *mipicsi = ici->priv;
+	char *va = NULL;
+
+	spin_lock(&mipicsi->queue_lock);
+	list_add_tail(&(mipicsi->cam_buf[vb->index].queue),
+		&(mipicsi->fb_list));
+	spin_unlock(&mipicsi->queue_lock);
+
+	va = vb2_plane_vaddr(vb, 0);
+
+	++(mipicsi->enqueue_cnt);
+}
+
+static int mtk_mipicsi_vb2_start_streaming(struct vb2_queue *vq,
+		unsigned int count)
+{
+	struct soc_camera_device *icd = soc_camera_from_vb2q(vq);
+	struct soc_camera_host *ici = to_soc_camera_host(icd->parent);
+	struct mtk_mipicsi_dev *mipicsi = ici->priv;
+
+	icd->vdev->queue = vq;
+
+	mipicsi->streamon = true;
+	return 0;
+}
+
+static void mtk_mipicsi_vb2_stop_streaming(struct vb2_queue *vq)
+{
+	struct mtk_mipicsi_dev *mipicsi = vb2_get_drv_priv(vq);
+	struct mtk_mipicsi_buf *buf = NULL;
+	struct mtk_mipicsi_buf *tmp = NULL;
+	unsigned int index = 0;
+
+	spin_lock(&mipicsi->queue_lock);
+	while (list_empty(&(mipicsi->fb_list)) == 0) {
+		list_for_each_entry_safe(buf, tmp, &(mipicsi->fb_list), queue) {
+			if (buf->vb->state == VB2_BUF_STATE_ACTIVE) {
+				vb2_buffer_done(buf->vb, VB2_BUF_STATE_ERROR);
+				break;
+			}
+		}
+		buf->vb_dma_addr_phy = 0ULL;
+		buf->prepare_flag = 0;
+		index = buf->vb->index;
+		list_del_init(&(mipicsi->cam_buf[index].queue));
+	}
+	spin_unlock(&mipicsi->queue_lock);
+	mipicsi->streamon = false;
+
+	INIT_LIST_HEAD(&(mipicsi->fb_list));
+
+	mipicsi->enqueue_cnt = 0UL;
+	mipicsi->dequeue_cnt = 0UL;
+}
+
+static struct vb2_ops mtk_vb2_ops = {
+	.queue_setup		= mtk_mipicsi_vb2_queue_setup,
+	.buf_init			= mtk_mipicsi_vb2_init,
+	.buf_prepare		= mtk_mipicsi_vb2_prepare,
+	.buf_queue			= mtk_mipicsi_vb2_queue,
+	.start_streaming	= mtk_mipicsi_vb2_start_streaming,
+	.stop_streaming		= mtk_mipicsi_vb2_stop_streaming,
+	.wait_prepare		= vb2_ops_wait_prepare,
+	.wait_finish		= vb2_ops_wait_finish,
+};
+
+static int mtk_mipicsi_init_videobuf2(struct vb2_queue *q,
+			      struct soc_camera_device *icd)
+{
+	struct soc_camera_host *ici = to_soc_camera_host(icd->parent);
+	struct mtk_mipicsi_dev *mipicsi = ici->priv;
+	struct mutex *q_lock = NULL;
+
+	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+	q->io_modes = VB2_MMAP;
+	q->drv_priv = mipicsi;
+	q->buf_struct_size = sizeof(struct vb2_buffer);
+	q->ops = &mtk_vb2_ops;
+#ifdef CONFIG_VB2_MEDIATEK_DMA_SG
+	q->mem_ops = &mtk_dma_sg_memops;
+#else
+	q->mem_ops = &vb2_dma_contig_memops;
+#endif
+	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	q->dev = ici->v4l2_dev.dev;
+	q_lock = devm_kzalloc(mipicsi->soc_host.v4l2_dev.dev,
+			sizeof(*q_lock), GFP_KERNEL);
+	q->lock = q_lock;
+	mutex_init(q->lock);
+
+	return vb2_queue_init(q);
+}
+
+static int mtk_mipicsi_querycap(struct soc_camera_host *ici,
+			       struct v4l2_capability *cap)
+{
+	struct mtk_mipicsi_dev *mipicsi = ici->priv;
+
+	(void)strlcpy(cap->card, MTK_PLATFORM_STR, sizeof(cap->card));
+	(void)strlcpy(cap->driver, mipicsi->drv_name, sizeof(cap->driver));
+	(void)strlcpy(cap->bus_info, MTK_PLATFORM_STR, sizeof(cap->bus_info));
+	cap->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
+	cap->capabilities = cap->device_caps | V4L2_CAP_DEVICE_CAPS;
+
+	return 0;
+}
+
+static int mtk_mipicsi_set_bus_param(struct soc_camera_device *icd)
+{
+	struct v4l2_subdev *sd = soc_camera_to_subdev(icd);
+	struct v4l2_mbus_config cfg = {.type = V4L2_MBUS_PARALLEL,};
+	unsigned int common_flags = 0U;
+	int ret = 0;
+
+	ret = v4l2_subdev_call(sd, video, g_mbus_config, &cfg);
+	if (ret == 0) {
+		common_flags = soc_mbus_config_compatible(&cfg,
+				MTK_MIPICSI_BUS_PARAM);
+		if (common_flags == 0U) {
+			dev_err(icd->parent, "Flags incompatible: camera 0x%x",
+				cfg.flags);
+			return -EINVAL;
+		}
+	} else {
+		if (ret != -ENOIOCTLCMD)
+			return ret;
+	}
+	common_flags = MTK_MIPICSI_BUS_PARAM;
+
+	dev_dbg(icd->parent, "Flags cam: 0x%x common: 0x%x\n",
+		cfg.flags, common_flags);
+
+	cfg.flags = common_flags;
+	ret = v4l2_subdev_call(sd, video, s_mbus_config, &cfg);
+	if (ret < 0 && ret != -ENOIOCTLCMD) {
+		dev_dbg(icd->parent, "camera s_mbus_config(0x%x) returned %d\n",
+			common_flags, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct soc_camera_host_ops mtk_soc_camera_host_ops = {
+	.owner			= THIS_MODULE,
+	.add			= mtk_mipicsi_add_device,
+	.remove			= mtk_mipicsi_remove_device,
+	.set_fmt		= mtk_mipicsi_set_fmt,
+	.try_fmt		= mtk_mipicsi_try_fmt,
+	.init_videobuf2	= mtk_mipicsi_init_videobuf2,
+	.poll			= vb2_fop_poll,
+	.querycap		= mtk_mipicsi_querycap,
+	.set_bus_param		= mtk_mipicsi_set_bus_param,
+};
+
+static int seninf_mux_camsv_node_parse(struct mtk_mipicsi_dev *mipicsi,
+		int index)
+{
+	struct clk *clk = NULL;
+	struct device *dev = NULL;
+	struct resource *res = NULL;
+	struct platform_device *camdma_pdev = NULL;
+	struct platform_device *pdev = NULL;
+	struct device_node *np = NULL;
+
+	if (mipicsi == NULL)
+		return -EINVAL;
+
+	dev = &mipicsi->pdev->dev;
+	pdev = mipicsi->pdev;
+
+	np = of_parse_phandle(dev->of_node,
+		"mediatek,seninf_mux_camsv", index);
+	if (np == NULL) {
+		dev_err(dev, "no NO.%d mediatek,seninf_mux_camsv node\n",
+			index);
+		return -ENODEV;
+	}
+
+	camdma_pdev = of_find_device_by_node(np);
+	of_node_put(np);
+	if (camdma_pdev == NULL) {
+		camdma_pdev = of_platform_device_create(np, NULL,
+					platform_bus_type.dev_root);
+		if (camdma_pdev == NULL)
+			return -EPROBE_DEFER;
+	}
+
+	clk = of_clk_get(np, 0);
+	if (clk == NULL) {
+		dev_err(dev, "get clk fail in %s node\n", np->full_name);
+		return -ENODEV;
+	}
+	mipicsi->clk[index] = clk;
+
+	res = platform_get_resource(camdma_pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		dev_err(dev, "get seninf_mux memory failed in %s node\n",
+			np->full_name);
+		return -ENODEV;
+	}
+	mipicsi->seninf_mux[index] =
+		devm_ioremap_resource(&camdma_pdev->dev, res);
+
+	res = platform_get_resource(camdma_pdev, IORESOURCE_MEM, 1);
+	if (res == NULL) {
+		dev_err(dev, "get camsv memory failed in %s node\n",
+			np->full_name);
+		return -ENODEV;
+	}
+	mipicsi->camsv[index] =
+		devm_ioremap_resource(&camdma_pdev->dev, res);
+
+	INIT_LIST_HEAD(&mipicsi->capture_list[index]);
+	mipicsi->frame_cnt[index] = 0UL;
+
+	dev_info(dev, "%s parse done\n", np->full_name);
+
+	return 0;
+}
+
+static int mtk_mipicsi_common_node_parse(struct mtk_mipicsi_dev *mipicsi,
+	struct device_node *node)
+{
+	int i = 0;
+	struct regmap *seninf_top = NULL;
+	struct device *dev = NULL;
+	struct platform_device *pdev = NULL;
+	struct clk *clk = NULL;
+
+	if ((mipicsi == NULL) || (node == NULL))
+		return -EINVAL;
+
+	dev = &mipicsi->pdev->dev;
+	pdev = mipicsi->pdev;
+
+	/* All the mipicsi HW share the same seninf_top */
+	seninf_top = syscon_regmap_lookup_by_phandle(dev->of_node,
+			"mediatek,mipicsi");
+	if (seninf_top == NULL) {
+		dev_err(dev, "Missing mediadek,mipicsi in %s node\n",
+			node->full_name);
+		return -EINVAL;
+	}
+	mipicsi->seninf_top = seninf_top;
+
+	/* get IMG_SENINF_CAM_EN and IMG_SENINF_SCAM_EN clk*/
+	mipicsi->clk_num = mipicsi->camsv_num;
+
+	for (i = 0; i < MIPICSI_COMMON_CLK; ++i) {
+		clk = of_clk_get(node, i);
+		if (clk == NULL) {
+			dev_err(dev, "get clk fail in %s node\n",
+				node->full_name);
+			return -EINVAL;
+		}
+		mipicsi->clk[mipicsi->clk_num] = clk;
+		++mipicsi->clk_num;
+	}
+
+	dev_info(dev, "%s parse done\n", node->full_name);
+
+	return 0;
+}
+
+static int mtk_mipicsi_node_parse(struct mtk_mipicsi_dev *mipicsi)
+{
+	int ret;
+	int camsv_num = 0;
+	int i;
+	struct device *dev = NULL;
+	struct resource *res = NULL;
+	struct device_node *common_node = NULL;
+	struct platform_device *pdev = NULL;
+
+	if (mipicsi == NULL)
+		return -EINVAL;
+
+	dev = &mipicsi->pdev->dev;
+	pdev = mipicsi->pdev;
+
+	/* mediatek,mipicsiid is a flag to show which mipicsi HW */
+	ret = of_property_read_u32(dev->of_node, "mediatek,mipicsiid",
+		(u32 *)&mipicsi->id);
+	if (ret != 0) {
+		dev_info(dev, "not set mediatek,mipicsiid, use default id 0\n");
+		mipicsi->id = 0;
+	}
+	(void)sprintf(mipicsi->drv_name, MTK_MIPICSI_DRV_NAME"%d",
+		mipicsi->id);
+
+	/* get and parse seninf_mux_camsv */
+	camsv_num = of_count_phandle_with_args(dev->of_node,
+		"mediatek,seninf_mux_camsv", NULL);
+	if (camsv_num <= 0) {
+		dev_err(dev, "no mediatek,seninf_mux_camsv\n");
+		return -EINVAL;
+	}
+	mipicsi->camsv_num = camsv_num;
+	dev_info(dev, "there are %d camsv node\n", camsv_num);
+
+	for (i = 0; i < mipicsi->camsv_num; ++i) {
+		ret = seninf_mux_camsv_node_parse(mipicsi, i);
+		if ((ret < 0) && (ret != -EPROBE_DEFER)) {
+			dev_err(dev,
+				"NO.%d seninf_mux_camsv node parse fail\n", i);
+			return ret;
+		}
+	}
+
+	/* get mediatek,mipicsi node and its resource */
+	common_node = of_parse_phandle(dev->of_node, "mediatek,mipicsi", 0);
+	if (common_node == NULL) {
+		dev_err(dev, "no mediadek,mipicsi\n");
+		return -EINVAL;
+	}
+
+	ret = mtk_mipicsi_common_node_parse(mipicsi, common_node);
+	if (ret < 0)
+		return ret;
+
+	/*get ana and seninf reg*/
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		dev_err(dev, "get ana register failed\n");
+		return -ENODEV;
+	}
+	mipicsi->ana = devm_ioremap_resource(&pdev->dev, res);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (res == NULL) {
+		dev_err(dev, "get seninf_ctrl register failed\n");
+		return -ENODEV;
+	}
+	mipicsi->seninf_ctrl = devm_ioremap_resource(&pdev->dev, res);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	if (res == NULL) {
+		dev_err(dev, "get seninf register failed\n");
+		return -ENODEV;
+	}
+	mipicsi->seninf = devm_ioremap_resource(&pdev->dev, res);
+
+	dev_info(dev, "mipicsi node parse done\n");
+
+	return 0;
+}
+
+static int mtk_mipicsi_probe(struct platform_device *pdev)
+{
+	struct mtk_mipicsi_dev *mipicsi = NULL;
+	int ret = 0;
+	struct iommu_domain *iommu = NULL;
+	struct device_node *larb_node = NULL;
+	struct platform_device *larb_pdev = NULL;
+
+	iommu = iommu_get_domain_for_dev(&pdev->dev);
+	if (iommu == NULL) {
+		dev_err(&pdev->dev, "Waiting iommu driver ready...\n");
+		return -EPROBE_DEFER;
+	}
+
+	larb_node = of_parse_phandle(pdev->dev.of_node, "mediatek,larb", 0);
+	if (larb_node == NULL) {
+		dev_err(&pdev->dev, "Missing mediadek,larb in %s node\n",
+			pdev->dev.of_node->full_name);
+		return -EINVAL;
+	}
+
+	larb_pdev = of_find_device_by_node(larb_node);
+	if (larb_pdev == NULL || !larb_pdev->dev.driver) {
+		dev_err(&pdev->dev, "Waiting for larb device %s\n",
+			larb_node->full_name);
+		return -EPROBE_DEFER;
+	}
+	of_node_put(larb_node);
+
+	mipicsi = devm_kzalloc(&pdev->dev, sizeof(*mipicsi), GFP_KERNEL);
+	if (mipicsi == NULL)
+		return -ENOMEM;
+
+	mipicsi->pdev = pdev;
+	mipicsi->larb_pdev = &larb_pdev->dev;
+
+	ret = mtk_mipicsi_node_parse(mipicsi);
+	if (ret < 0)
+		return ret;
+
+	pm_runtime_enable(&pdev->dev);
+
+	mipicsi->soc_host.drv_name	= mipicsi->drv_name;
+	mipicsi->soc_host.ops		= &mtk_soc_camera_host_ops;
+	mipicsi->soc_host.priv		= mipicsi;
+	mipicsi->soc_host.v4l2_dev.dev	= &pdev->dev;
+	mipicsi->soc_host.nr		= mipicsi->id;
+	mipicsi->width_flags		= MTK_DATAWIDTH_8;
+	mipicsi->streamon		= false;
+
+	ret = soc_camera_host_register(&mipicsi->soc_host);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "soc camera host register fail\n");
+		pm_runtime_disable(&pdev->dev);
+		return ret;
+	}
+
+	INIT_LIST_HEAD(&mipicsi->fb_list);
+	spin_lock_init(&mipicsi->queue_lock);
+	spin_lock_init(&mipicsi->lock);
+	mipicsi->enqueue_cnt = 0UL;
+	mipicsi->dequeue_cnt = 0UL;
+
+#ifdef CONFIG_VB2_MEDIATEK_DMA_SG
+	ret = mtk_dma_sg_init_ctx(&pdev->dev);
+#else
+	ret = vb2_dma_contig_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32U));
+#endif
+	if (ret != 0) {
+		dev_err(&pdev->dev, "dma set max seg size fail\n");
+		goto clean;
+	}
+
+	dev_info(&pdev->dev, "probe done\n");
+	return ret;
+clean:
+	soc_camera_host_unregister(&mipicsi->soc_host);
+	pm_runtime_disable(&pdev->dev);
+	return ret;
+}
+
+static int mtk_mipicsi_remove(struct platform_device *pdev)
+{
+	struct soc_camera_host *soc_host = to_soc_camera_host(&pdev->dev);
+
+	soc_camera_host_unregister(soc_host);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id mtk_mipicsi_of_match[] = {
+	{ .compatible = "mediatek,mt2712-mipicsi", },
+	{},
+};
+
+static struct platform_driver mtk_mipicsi_driver = {
+	.driver		= {
+		.name	= MTK_MIPICSI_DRV_NAME,
+		.of_match_table = of_match_ptr(mtk_mipicsi_of_match),
+	},
+	.probe		= mtk_mipicsi_probe,
+	.remove		= mtk_mipicsi_remove,
+};
+
+module_platform_driver(mtk_mipicsi_driver);
+MODULE_DESCRIPTION("MediaTek SoC Camera Host driver");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0

