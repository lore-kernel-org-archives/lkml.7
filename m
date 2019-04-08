Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC75C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7C32063F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfDHL4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:56:04 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:20405 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726708AbfDHLzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:55:37 -0400
X-UUID: 0584eef3127847eea5fb13e0e6a3ee58-20190408
X-UUID: 0584eef3127847eea5fb13e0e6a3ee58-20190408
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1042091161; Mon, 08 Apr 2019 19:55:32 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 8 Apr 2019 19:55:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 8 Apr 2019 19:55:31 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Stu Hsieh <stu.hsieh@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH 13/14] [media] mtk-mipicsi: add debug message for mipicsi driver
Date:   Mon, 8 Apr 2019 19:55:04 +0800
Message-ID: <1554724505-19882-14-git-send-email-stu.hsieh@mediatek.com>
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

This patch add debug message for mipicsi driver.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 .../media/platform/mtk-mipicsi/mtk_mipicsi.c  | 54 ++++++++++++++++++-
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
index faf9a94d5157..95d25db5e606 100644
--- a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
+++ b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
@@ -28,6 +28,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/moduleparam.h>
+#include <linux/time64.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
@@ -118,6 +119,15 @@
 
 #define SerDes_support 1
 
+static int mtk_mipicsi_dbg_level;
+#define mtk_mipicsi_dbg(level, fmt, args...)				 \
+	do {								 \
+		if (mtk_mipicsi_dbg_level >= level)			\
+			pr_info("[MTK_MIPICSI%d] L%d %s %d: " fmt "\n", \
+				mipicsi->id, level,  __func__, __LINE__, \
+				##args);	\
+	} while (0)
+
 /* buffer for one video frame */
 struct mtk_mipicsi_buf {
 	struct list_head queue;
@@ -155,6 +165,8 @@ struct mtk_mipicsi_dev {
 	unsigned long enqueue_cnt;
 	unsigned long dequeue_cnt;
 	struct v4l2_ctrl_handler ctrl_hdl;
+	struct timespec64 fps_time_cur;
+	struct timespec64 fps_time_pre;
 	char drv_name[16];
 	u32 id;
 	int clk_num;
@@ -430,6 +442,8 @@ static int mtk_mipicsi_add_device(struct soc_camera_device *icd)
 
 	mipicsi->width = width;
 	mipicsi->height = height;
+	mtk_mipicsi_dbg(1, "sub device width/height/bytesperline %d/%d/%d",
+		width, height, mipicsi->bytesperline);
 
 	/*
 	 * If power domain was closed before, it will be open.
@@ -571,6 +585,9 @@ static int mtk_mipicsi_set_fmt(struct soc_camera_device *icd,
 	if (pix->pixelformat == V4L2_PIX_FMT_YUYV)
 		pix->sizeimage = pix->width * pix->height * 2U;
 
+	mtk_mipicsi_dbg(0, "width/height/sizeimage %u/%u/%u",
+		pix->width, pix->height, pix->sizeimage);
+
 	if (mf->code != xlate->code)
 		return -EINVAL;
 
@@ -696,6 +713,9 @@ static int mtk_mipicsi_vb2_prepare(struct vb2_buffer *vb)
 			vb2_dma_contig_plane_dma_addr(vb, 0);
 #endif
 		va = vb2_plane_vaddr(vb, 0);
+		mtk_mipicsi_dbg(1, "va=%p vb_dma_addr_phy=%lx size=%d",
+			va, (unsigned long)buf->vb_dma_addr_phy,
+			vb->planes[0].bytesused);
 		buf->vb = vb;
 	}
 
@@ -741,6 +761,8 @@ static void mtk_mipicsi_vb2_queue(struct vb2_buffer *vb)
 		}
 
 	++(mipicsi->enqueue_cnt);
+	mtk_mipicsi_dbg(2, "enqueue NO.%d buffer(%p). Total %lu buffer",
+		vb->index, vb, mipicsi->enqueue_cnt);
 }
 
 static int mtk_mipicsi_vb2_start_streaming(struct vb2_queue *vq,
@@ -1125,8 +1147,10 @@ static int mtk_mipicsi_pm_resume(struct device *dev)
 
 	if (mipicsi->larb_pdev != NULL) {
 		ret = mtk_smi_larb_get(mipicsi->larb_pdev);
-		if (ret != 0)
+		if (ret != 0) {
+			mtk_mipicsi_dbg(0, "failed to get larb, err %d", ret);
 			return ret;
+		}
 	}
 
 	mtk_mipicsi_ana_clk_enable(mipicsi->ana, true);
@@ -1176,6 +1200,7 @@ static void mtk_mipicsi_irq_buf_process(struct mtk_mipicsi_dev *mipicsi)
 	unsigned int next = 0U;
 	u64 offset = 0ULL;
 	u8 link_index = 0U;
+	long time_interval;
 	void __iomem *base = NULL;
 	dma_addr_t pa;
 
@@ -1185,8 +1210,10 @@ static void mtk_mipicsi_irq_buf_process(struct mtk_mipicsi_dev *mipicsi)
 	i = 0;
 
 	/* only one buffer left */
-	if ((&(mipicsi->fb_list))->next->next == &(mipicsi->fb_list))
+	if ((&(mipicsi->fb_list))->next->next == &(mipicsi->fb_list)) {
+		mtk_mipicsi_dbg(1, "only 1 buffer left, drop frame");
 		return;
+	}
 
 	/*for each fb_lst 2 times to get the top 2 buffer.*/
 	list_for_each_entry_safe(new_cam_buf, tmp,
@@ -1219,6 +1246,27 @@ static void mtk_mipicsi_irq_buf_process(struct mtk_mipicsi_dev *mipicsi)
 	++(mipicsi->dequeue_cnt);
 
 	list_del_init(&(mipicsi->cam_buf[index].queue));
+
+	if (mtk_mipicsi_dbg_level >= 2) {
+		ktime_get_real_ts64(&(mipicsi->fps_time_cur));
+		if (mipicsi->dequeue_cnt == 1) {
+			mipicsi->fps_time_pre.tv_sec =
+				mipicsi->fps_time_cur.tv_sec;
+			mipicsi->fps_time_pre.tv_nsec =
+				mipicsi->fps_time_cur.tv_nsec;
+		} else {
+			time_interval = (mipicsi->fps_time_cur.tv_sec
+				- mipicsi->fps_time_pre.tv_sec) * 1000000000
+				+ (mipicsi->fps_time_cur.tv_nsec
+				- mipicsi->fps_time_pre.tv_nsec);
+			mtk_mipicsi_dbg(0, "time interval is %ld\n",
+				time_interval);
+			mipicsi->fps_time_pre.tv_sec =
+				mipicsi->fps_time_cur.tv_sec;
+			mipicsi->fps_time_pre.tv_nsec =
+				mipicsi->fps_time_cur.tv_nsec;
+		}
+	}
 }
 
 static irqreturn_t mtk_mipicsi_isr(int irq, void *data)
@@ -1233,6 +1281,7 @@ static irqreturn_t mtk_mipicsi_isr(int irq, void *data)
 
 	isr_ch = get_irq_channel(mipicsi);
 	if (isr_ch < 0) {
+		mtk_mipicsi_dbg(0, "no interrupt occur");
 		spin_unlock_irqrestore(&mipicsi->lock, flags);
 		return IRQ_HANDLED;
 	}
@@ -1573,5 +1622,6 @@ static struct platform_driver mtk_mipicsi_driver = {
 };
 
 module_platform_driver(mtk_mipicsi_driver);
+module_param(mtk_mipicsi_dbg_level, int, 0644);
 MODULE_DESCRIPTION("MediaTek SoC Camera Host driver");
 MODULE_LICENSE("GPL v2");
-- 
2.18.0

