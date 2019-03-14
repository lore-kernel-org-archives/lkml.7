Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B153C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF62C2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfCNMop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:44:45 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:62244 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727184AbfCNMoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:44:44 -0400
X-UUID: a0197ff2aeec4eec9fe1a1aed23c8e3e-20190314
X-UUID: a0197ff2aeec4eec9fe1a1aed23c8e3e-20190314
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 207265342; Thu, 14 Mar 2019 20:44:37 +0800
Received: from MTKMBS01DR.mediatek.inc (172.21.101.111) by
 mtkexhb02.mediatek.inc (172.21.101.103) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Mar 2019 20:44:36 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01dr.mediatek.inc (172.21.101.111) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Mar 2019 20:44:35 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 14 Mar 2019 20:44:35 +0800
From:   <yongqiang.niu@mediatek.com>
To:     <ck.hu@mediatek.com>, <p.zabel@pengutronix.de>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <airlied@linux.ie>, <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>, Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [RESEND PATCH v1 02/18] drm/mediatek: add mutex mod and sof into ddp private data
Date:   Thu, 14 Mar 2019 20:05:04 +0800
Message-ID: <1552565120-24329-3-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1552565120-24329-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1552565120-24329-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

This patch add mutex mod and sof into ddp private data

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 117 ++++++++++++++++++++++++++-------
 1 file changed, 94 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 579ce28..adb37e4 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -41,11 +41,14 @@
 #define DISP_REG_CONFIG_DSI_SEL			0x050
 #define DISP_REG_CONFIG_DPI_SEL			0x064
 
+#define MT2701_DISP_MUTEX0_MOD0 0x2C
+#define MT2701_DISP_MUTEX0_SOF0  0x30
+
 #define DISP_REG_MUTEX_EN(n)	(0x20 + 0x20 * (n))
 #define DISP_REG_MUTEX(n)	(0x24 + 0x20 * (n))
 #define DISP_REG_MUTEX_RST(n)	(0x28 + 0x20 * (n))
-#define DISP_REG_MUTEX_MOD(n)	(0x2c + 0x20 * (n))
-#define DISP_REG_MUTEX_SOF(n)	(0x30 + 0x20 * (n))
+#define DISP_REG_MUTEX_MOD(data, n)	((data)->mutex_mod_reg + 0x20 * (n))
+#define DISP_REG_MUTEX_SOF(data, n)	((data)->mutex_sof_reg + 0x20 * (n))
 #define DISP_REG_MUTEX_MOD2(n)	(0x34 + 0x20 * (n))
 
 #define INT_MUTEX				BIT(1)
@@ -147,12 +150,30 @@ struct mtk_disp_mutex {
 	bool claimed;
 };
 
+enum mtk_ddp_mutex_sof_id {
+	DDP_MUTEX_SOF_SINGLE_MODE,
+	DDP_MUTEX_SOF_DSI0,
+	DDP_MUTEX_SOF_DSI1,
+	DDP_MUTEX_SOF_DPI0,
+	DDP_MUTEX_SOF_DPI1,
+	DDP_MUTEX_SOF_DSI2,
+	DDP_MUTEX_SOF_DSI3,
+	DDP_MUTEX_SOF_MAX,
+};
+
+struct mtk_ddp_data {
+	const unsigned int *mutex_mod;
+	const unsigned int *mutex_sof;
+	unsigned int mutex_mod_reg;
+	unsigned int mutex_sof_reg;
+};
+
 struct mtk_ddp {
 	struct device			*dev;
 	struct clk			*clk;
 	void __iomem			*regs;
 	struct mtk_disp_mutex		mutex[10];
-	const unsigned int		*mutex_mod;
+	const struct mtk_ddp_data	*data;
 };
 
 static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
@@ -202,6 +223,51 @@ struct mtk_ddp {
 	[DDP_COMPONENT_WDMA1] = MT8173_MUTEX_MOD_DISP_WDMA1,
 };
 
+static const unsigned int mt2701_mutex_sof[DDP_MUTEX_SOF_MAX] = {
+	[DDP_MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
+	[DDP_MUTEX_SOF_DSI0] = MUTEX_SOF_DSI0,
+	[DDP_MUTEX_SOF_DSI1] = MUTEX_SOF_DSI1,
+	[DDP_MUTEX_SOF_DPI0] = MUTEX_SOF_DPI0,
+};
+
+static const unsigned int mt2712_mutex_sof[DDP_MUTEX_SOF_MAX] = {
+	[DDP_MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
+	[DDP_MUTEX_SOF_DSI0] = MUTEX_SOF_DSI0,
+	[DDP_MUTEX_SOF_DSI1] = MUTEX_SOF_DSI1,
+	[DDP_MUTEX_SOF_DPI0] = MUTEX_SOF_DPI0,
+	[DDP_MUTEX_SOF_DPI1] = MUTEX_SOF_DPI1,
+	[DDP_MUTEX_SOF_DSI2] = MUTEX_SOF_DSI2,
+	[DDP_MUTEX_SOF_DSI3] = MUTEX_SOF_DSI3,
+};
+
+static const unsigned int mt8173_mutex_sof[DDP_MUTEX_SOF_MAX] = {
+	[DDP_MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
+	[DDP_MUTEX_SOF_DSI0] = MUTEX_SOF_DSI0,
+	[DDP_MUTEX_SOF_DSI1] = MUTEX_SOF_DSI1,
+	[DDP_MUTEX_SOF_DPI0] = MUTEX_SOF_DPI0,
+};
+
+static const struct mtk_ddp_data mt2701_ddp_driver_data = {
+	.mutex_mod = mt2701_mutex_mod,
+	.mutex_sof = mt2701_mutex_sof,
+	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
+	.mutex_sof_reg = MT2701_DISP_MUTEX0_SOF0,
+};
+
+static const struct mtk_ddp_data mt2712_ddp_driver_data = {
+	.mutex_mod = mt2712_mutex_mod,
+	.mutex_sof = mt2712_mutex_sof,
+	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
+	.mutex_sof_reg = MT2701_DISP_MUTEX0_SOF0,
+};
+
+static const struct mtk_ddp_data mt8173_ddp_driver_data = {
+	.mutex_mod = mt8173_mutex_mod,
+	.mutex_sof = mt8173_mutex_sof,
+	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
+	.mutex_sof_reg = MT2701_DISP_MUTEX0_SOF0,
+};
+
 static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
 				    enum mtk_ddp_comp_id next,
 				    unsigned int *addr)
@@ -446,39 +512,40 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
 
 	switch (id) {
 	case DDP_COMPONENT_DSI0:
-		reg = MUTEX_SOF_DSI0;
+		reg = DDP_MUTEX_SOF_DSI0;
 		break;
 	case DDP_COMPONENT_DSI1:
-		reg = MUTEX_SOF_DSI0;
+		reg = DDP_MUTEX_SOF_DSI0;
 		break;
 	case DDP_COMPONENT_DSI2:
-		reg = MUTEX_SOF_DSI2;
+		reg = DDP_MUTEX_SOF_DSI2;
 		break;
 	case DDP_COMPONENT_DSI3:
-		reg = MUTEX_SOF_DSI3;
+		reg = DDP_MUTEX_SOF_DSI3;
 		break;
 	case DDP_COMPONENT_DPI0:
-		reg = MUTEX_SOF_DPI0;
+		reg = DDP_MUTEX_SOF_DPI0;
 		break;
 	case DDP_COMPONENT_DPI1:
-		reg = MUTEX_SOF_DPI1;
+		reg = DDP_MUTEX_SOF_DPI1;
 		break;
 	default:
-		if (ddp->mutex_mod[id] < 32) {
-			offset = DISP_REG_MUTEX_MOD(mutex->id);
+		if (ddp->data->mutex_mod[id] < 32) {
+			offset = DISP_REG_MUTEX_MOD(ddp->data, mutex->id);
 			reg = readl_relaxed(ddp->regs + offset);
-			reg |= 1 << ddp->mutex_mod[id];
+			reg |= 1 << ddp->data->mutex_mod[id];
 			writel_relaxed(reg, ddp->regs + offset);
 		} else {
 			offset = DISP_REG_MUTEX_MOD2(mutex->id);
 			reg = readl_relaxed(ddp->regs + offset);
-			reg |= 1 << (ddp->mutex_mod[id] - 32);
+			reg |= 1 << (ddp->data->mutex_mod[id] - 32);
 			writel_relaxed(reg, ddp->regs + offset);
 		}
 		return;
 	}
 
-	writel_relaxed(reg, ddp->regs + DISP_REG_MUTEX_SOF(mutex->id));
+	writel_relaxed(ddp->data->mutex_sof[reg],
+		       ddp->regs + DISP_REG_MUTEX_SOF(ddp->data, mutex->id));
 }
 
 void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
@@ -499,18 +566,19 @@ void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
 	case DDP_COMPONENT_DPI0:
 	case DDP_COMPONENT_DPI1:
 		writel_relaxed(MUTEX_SOF_SINGLE_MODE,
-			       ddp->regs + DISP_REG_MUTEX_SOF(mutex->id));
+			       ddp->regs +
+			       DISP_REG_MUTEX_SOF(ddp->data, mutex->id));
 		break;
 	default:
-		if (ddp->mutex_mod[id] < 32) {
-			offset = DISP_REG_MUTEX_MOD(mutex->id);
+		if (ddp->data->mutex_mod[id] < 32) {
+			offset = DISP_REG_MUTEX_MOD(ddp->data, mutex->id);
 			reg = readl_relaxed(ddp->regs + offset);
-			reg &= ~(1 << ddp->mutex_mod[id]);
+			reg &= ~(1 << ddp->data->mutex_mod[id]);
 			writel_relaxed(reg, ddp->regs + offset);
 		} else {
 			offset = DISP_REG_MUTEX_MOD2(mutex->id);
 			reg = readl_relaxed(ddp->regs + offset);
-			reg &= ~(1 << (ddp->mutex_mod[id] - 32));
+			reg &= ~(1 << (ddp->data->mutex_mod[id] - 32));
 			writel_relaxed(reg, ddp->regs + offset);
 		}
 		break;
@@ -585,7 +653,7 @@ static int mtk_ddp_probe(struct platform_device *pdev)
 		return PTR_ERR(ddp->regs);
 	}
 
-	ddp->mutex_mod = of_device_get_match_data(dev);
+	ddp->data = of_device_get_match_data(dev);
 
 	platform_set_drvdata(pdev, ddp);
 
@@ -598,9 +666,12 @@ static int mtk_ddp_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id ddp_driver_dt_match[] = {
-	{ .compatible = "mediatek,mt2701-disp-mutex", .data = mt2701_mutex_mod},
-	{ .compatible = "mediatek,mt2712-disp-mutex", .data = mt2712_mutex_mod},
-	{ .compatible = "mediatek,mt8173-disp-mutex", .data = mt8173_mutex_mod},
+	{ .compatible = "mediatek,mt2701-disp-mutex",
+	  .data = &mt2701_ddp_driver_data},
+	{ .compatible = "mediatek,mt2712-disp-mutex",
+	  .data = &mt2712_ddp_driver_data},
+	{ .compatible = "mediatek,mt8173-disp-mutex",
+	  .data = &mt8173_ddp_driver_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ddp_driver_dt_match);
-- 
1.8.1.1.dirty

