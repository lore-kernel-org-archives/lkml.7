Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CD2C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917A92063F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfDHLzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:55:38 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39326 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725983AbfDHLzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:55:32 -0400
X-UUID: 60bcd11c65d04a1aaf53111a6a6f8b3c-20190408
X-UUID: 60bcd11c65d04a1aaf53111a6a6f8b3c-20190408
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 676779982; Mon, 08 Apr 2019 19:55:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 8 Apr 2019 19:55:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 8 Apr 2019 19:55:28 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Stu Hsieh <stu.hsieh@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH 09/14] [media] mtk-mipicsi: add ISR for writing the data to buffer
Date:   Mon, 8 Apr 2019 19:55:00 +0800
Message-ID: <1554724505-19882-10-git-send-email-stu.hsieh@mediatek.com>
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

This patch add ISR for writing the data to buffer

When mipicsi HW complete to write the data in buffer,
the interrupt woulb be trigger.
So, the ISR need to clear interrupt status for next interrupt.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 .../media/platform/mtk-mipicsi/mtk_mipicsi.c  | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
index 116fd2bfaaab..c8ce561dcc58 100644
--- a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
+++ b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
@@ -36,6 +36,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/iommu.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <media/v4l2-common.h>
 #include <media/v4l2-dev.h>
@@ -98,6 +99,8 @@
 #define CAMSV_MODULE_EN					0x10
 #define CAMSV_FMT_SEL					0x14
 #define CAMSV_INT_EN					0x18
+#define CAMSV_INT_STATUS				0x1C
+#define PASS1_DONE_STATUS				10
 #define CAMSV_SW_CTL					0x20
 #define CAMSV_CLK_EN					0x30
 
@@ -128,6 +131,8 @@ struct mtk_mipicsi_dev {
 	unsigned int camsv_num;
 	struct v4l2_device	v4l2_dev;
 	struct device *larb_pdev;
+	unsigned int		irq[MTK_CAMDMA_MAX_NUM];
+	bool irq_status[MTK_CAMDMA_MAX_NUM];
 	void __iomem		*ana;
 	void __iomem		*seninf_ctrl;
 	void __iomem		*seninf;
@@ -141,6 +146,7 @@ struct mtk_mipicsi_dev {
 	spinlock_t		lock;
 	spinlock_t		queue_lock;
 	struct mtk_mipicsi_buf	cam_buf[MAX_BUFFER_NUM];
+	bool			is_enable_irq[MTK_CAMDMA_MAX_NUM];
 	bool streamon;
 	unsigned long frame_cnt[MTK_CAMDMA_MAX_NUM];
 	unsigned int link;
@@ -940,9 +946,98 @@ static const struct dev_pm_ops mtk_mipicsi_pm = {
 		mtk_mipicsi_pm_resume, NULL)
 };
 
+static int get_irq_channel(struct mtk_mipicsi_dev *mipicsi)
+{
+	int ch;
+	u32 int_reg_val;
+
+	for (ch = 0; ch < mipicsi->camsv_num; ++ch) {
+		int_reg_val = readl(mipicsi->camsv[ch] + CAMSV_INT_STATUS);
+		if ((int_reg_val & (1UL << PASS1_DONE_STATUS)) != 0UL)
+			return ch;
+	}
+
+	return -1;
+}
+
+static void mtk_mipicsi_irq_buf_process(struct mtk_mipicsi_dev *mipicsi)
+{
+	unsigned int i = 0U;
+	struct mtk_mipicsi_buf *new_cam_buf = NULL;
+	struct mtk_mipicsi_buf *tmp = NULL;
+	unsigned int index = 0U;
+	unsigned int next = 0U;
+
+	for (i = 0U; i < MTK_CAMDMA_MAX_NUM; ++i)
+		mipicsi->irq_status[i] = false;
+
+	i = 0;
+
+	/* only one buffer left */
+	if ((&(mipicsi->fb_list))->next->next == &(mipicsi->fb_list))
+		return;
+
+	/*for each fb_lst 2 times to get the top 2 buffer.*/
+	list_for_each_entry_safe(new_cam_buf, tmp,
+		&(mipicsi->fb_list), queue) {
+		if (i == 0U) {
+			index = new_cam_buf->vb->index;
+		} else {
+			next = new_cam_buf->vb->index;
+			break;
+		}
+		++i;
+	}
+
+	/*
+	 * fb_list has one more buffer. Free the first buffer to user
+	 * and fill the second buffer to HW.
+	 */
+	vb2_buffer_done(mipicsi->cam_buf[index].vb,
+		VB2_BUF_STATE_DONE);
+	++(mipicsi->dequeue_cnt);
+
+	list_del_init(&(mipicsi->cam_buf[index].queue));
+}
+
+static irqreturn_t mtk_mipicsi_isr(int irq, void *data)
+{
+
+	struct mtk_mipicsi_dev *mipicsi = data;
+	unsigned long flags = 0;
+	int isr_ch;
+	u8 irq_cnt = 0, i = 0;
+
+	spin_lock_irqsave(&mipicsi->lock, flags);
+
+	isr_ch = get_irq_channel(mipicsi);
+	if (isr_ch < 0) {
+		spin_unlock_irqrestore(&mipicsi->lock, flags);
+		return IRQ_HANDLED;
+	}
+
+	/* clear interrupt */
+	writel(1UL << PASS1_DONE_STATUS,
+		mipicsi->camsv[isr_ch] + CAMSV_INT_STATUS);
+	mipicsi->irq_status[isr_ch] = true;
+	++(mipicsi->frame_cnt[isr_ch]);
+	for (i = 0U; i < MTK_CAMDMA_MAX_NUM; ++i) {
+		if (mipicsi->irq_status[i])
+			++irq_cnt;
+	}
+
+	if (irq_cnt == mipicsi->link)
+		mtk_mipicsi_irq_buf_process(mipicsi);
+	spin_unlock_irqrestore(&mipicsi->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
 static int seninf_mux_camsv_node_parse(struct mtk_mipicsi_dev *mipicsi,
 		int index)
 {
+	int ret;
+	int irq;
 	struct clk *clk = NULL;
 	struct device *dev = NULL;
 	struct resource *res = NULL;
@@ -980,6 +1075,23 @@ static int seninf_mux_camsv_node_parse(struct mtk_mipicsi_dev *mipicsi,
 	}
 	mipicsi->clk[index] = clk;
 
+	irq = of_irq_get(np, 0);
+	if (irq <= 0) {
+		dev_err(dev, "get irq fail in %s node\n", np->full_name);
+		return -ENODEV;
+	}
+	mipicsi->irq[index] = irq;
+
+	ret = devm_request_irq(dev, irq,
+			mtk_mipicsi_isr, 0,
+			mipicsi->drv_name, mipicsi);
+	if (ret != 0) {
+		dev_err(dev, "%s irq register failed\n", np->full_name);
+		return -ENODEV;
+	}
+	disable_irq(mipicsi->irq[index]);
+	mipicsi->irq_status[index] = false;
+
 	res = platform_get_resource(camdma_pdev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
 		dev_err(dev, "get seninf_mux memory failed in %s node\n",
-- 
2.18.0

