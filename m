Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3D5C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7918E214D8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfDHLzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:55:43 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:43027 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726642AbfDHLzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:55:35 -0400
X-UUID: c06b5862437242cf8a7c543e85329334-20190408
X-UUID: c06b5862437242cf8a7c543e85329334-20190408
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1219555545; Mon, 08 Apr 2019 19:55:28 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 8 Apr 2019 19:55:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 8 Apr 2019 19:55:27 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Stu Hsieh <stu.hsieh@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH 08/14] [media] mtk-mipicsi: enable/disable cmos for mt2712
Date:   Mon, 8 Apr 2019 19:54:59 +0800
Message-ID: <1554724505-19882-9-git-send-email-stu.hsieh@mediatek.com>
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

This patch enable/disable cmos setting for mt2712 when
vb2 start/stop streaming.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 .../media/platform/mtk-mipicsi/mtk_mipicsi.c  | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
index 99991f698edf..116fd2bfaaab 100644
--- a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
+++ b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
@@ -98,9 +98,11 @@
 #define CAMSV_MODULE_EN					0x10
 #define CAMSV_FMT_SEL					0x14
 #define CAMSV_INT_EN					0x18
+#define CAMSV_SW_CTL					0x20
 #define CAMSV_CLK_EN					0x30
 
 #define CAMSV_TG_SEN_MODE				0x500
+#define CAMSV_TG_VF_CON					0x504
 #define CAMSV_TG_SEN_GRAB_PXL				0x508
 #define CAMSV_TG_SEN_GRAB_LIN				0x50C
 #define CAMSV_TG_PATH_CFG				0x510
@@ -537,9 +539,25 @@ static int mtk_mipicsi_vb2_start_streaming(struct vb2_queue *vq,
 	struct soc_camera_device *icd = soc_camera_from_vb2q(vq);
 	struct soc_camera_host *ici = to_soc_camera_host(icd->parent);
 	struct mtk_mipicsi_dev *mipicsi = ici->priv;
+	unsigned int index = 0;
+	void __iomem *base = NULL;
 
 	icd->vdev->queue = vq;
 
+	for (index = 0U; index < MTK_CAMDMA_MAX_NUM; ++index)
+		if (((mipicsi->link_reg_val >> index) & 0x01U) == 0x01U &&
+			!mipicsi->is_enable_irq[index]) {
+			enable_irq(mipicsi->irq[index]);
+			mipicsi->is_enable_irq[index] = true;
+
+			/*enable cmos_en and vf_en*/
+			base = mipicsi->camsv[index];
+			writel(0x00000001U | readl(base + CAMSV_TG_SEN_MODE),
+				base + CAMSV_TG_SEN_MODE);
+			writel(0x00000001U | readl(base + CAMSV_TG_VF_CON),
+				base + CAMSV_TG_VF_CON);
+		}
+
 	mipicsi->streamon = true;
 	return 0;
 }
@@ -549,7 +567,29 @@ static void mtk_mipicsi_vb2_stop_streaming(struct vb2_queue *vq)
 	struct mtk_mipicsi_dev *mipicsi = vb2_get_drv_priv(vq);
 	struct mtk_mipicsi_buf *buf = NULL;
 	struct mtk_mipicsi_buf *tmp = NULL;
+	unsigned int i = 0U;
 	unsigned int index = 0;
+	void __iomem *base = NULL;
+
+	for (i = 0U; i < MTK_CAMDMA_MAX_NUM; ++i)
+		if (((mipicsi->link_reg_val >> i) & 0x01U) == 0x01U) {
+			/*disable cmos_en and vf_en*/
+			base = mipicsi->camsv[i];
+			writel(readl(base + CAMSV_TG_SEN_MODE) & 0xFFFFFFFEU,
+				base + CAMSV_TG_SEN_MODE);
+			writel(readl(base + CAMSV_TG_VF_CON) & 0xFFFFFFFEU,
+				base + CAMSV_TG_VF_CON);
+			/*camsv reset*/
+			base = mipicsi->camsv[i];
+			writel(0x00000004U | readl(base + CAMSV_SW_CTL),
+				base + CAMSV_SW_CTL);
+			writel(readl(base + CAMSV_SW_CTL) & 0xFFFFFFFBU,
+				base + CAMSV_SW_CTL);
+			disable_irq(mipicsi->irq[i]);
+			mipicsi->is_enable_irq[i] = false;
+			mipicsi->frame_cnt[i] = 0UL;
+			mipicsi->irq_status[i] = false;
+		}
 
 	spin_lock(&mipicsi->queue_lock);
 	while (list_empty(&(mipicsi->fb_list)) == 0) {
-- 
2.18.0

