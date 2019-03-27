Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5959FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351C52075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387665AbfC0GVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:21:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:17742 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733136AbfC0GTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:19:39 -0400
X-UUID: 8fe1ff0365a74c3eb6e51b51000bb958-20190327
X-UUID: 8fe1ff0365a74c3eb6e51b51000bb958-20190327
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1557857476; Wed, 27 Mar 2019 14:19:34 +0800
Received: from MTKMBS01DR.mediatek.inc (172.21.101.111) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Mar 2019 14:19:34 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01dr.mediatek.inc (172.21.101.111) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Mar 2019 14:19:33 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Mar 2019 14:19:32 +0800
From:   <yongqiang.niu@mediatek.com>
To:     <ck.hu@mediatek.com>, <p.zabel@pengutronix.de>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <airlied@linux.ie>, <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>, Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v2 04/25] drm/mediatek: add mutex sof into ddp private data
Date:   Wed, 27 Mar 2019 14:19:00 +0800
Message-ID: <1553667561-25447-5-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

mutex0 SOF register offset not always 0x30.
for mt8183, that offset will be 0x2C,
add this regsiter offset into private data

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 51 ++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 7f0d46e..495ebc5 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -42,12 +42,13 @@
 #define DISP_REG_CONFIG_DPI_SEL			0x064
 
 #define MT2701_DISP_MUTEX0_MOD0 0x2C
+#define MT2701_DISP_MUTEX0_SOF0  0x30
 
 #define DISP_REG_MUTEX_EN(n)	(0x20 + 0x20 * (n))
 #define DISP_REG_MUTEX(n)	(0x24 + 0x20 * (n))
 #define DISP_REG_MUTEX_RST(n)	(0x28 + 0x20 * (n))
 #define DISP_REG_MUTEX_MOD(data, n)	((data)->mutex_mod_reg + 0x20 * (n))
-#define DISP_REG_MUTEX_SOF(n)	(0x30 + 0x20 * (n))
+#define DISP_REG_MUTEX_SOF(data, n)	((data)->mutex_sof_reg + 0x20 * (n))
 #define DISP_REG_MUTEX_MOD2(n)	(0x34 + 0x20 * (n))
 
 #define INT_MUTEX				BIT(1)
@@ -149,9 +150,22 @@ struct mtk_disp_mutex {
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
 struct mtk_ddp_data {
 	const unsigned int *mutex_mod;
+	const unsigned int *mutex_sof;
 	unsigned int mutex_mod_reg;
+	unsigned int mutex_sof_reg;
 };
 
 struct mtk_ddp {
@@ -209,19 +223,35 @@ struct mtk_ddp {
 	[DDP_COMPONENT_WDMA1] = MT8173_MUTEX_MOD_DISP_WDMA1,
 };
 
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
 static const struct mtk_ddp_data mt2701_ddp_driver_data = {
 	.mutex_mod = mt2701_mutex_mod,
+	.mutex_sof = mt2712_mutex_sof,
 	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
+	.mutex_sof_reg = MT2701_DISP_MUTEX0_SOF0,
 };
 
 static const struct mtk_ddp_data mt2712_ddp_driver_data = {
 	.mutex_mod = mt2712_mutex_mod,
+	.mutex_sof = mt2712_mutex_sof,
 	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
+	.mutex_sof_reg = MT2701_DISP_MUTEX0_SOF0,
 };
 
 static const struct mtk_ddp_data mt8173_ddp_driver_data = {
 	.mutex_mod = mt8173_mutex_mod,
+	.mutex_sof = mt2712_mutex_sof,
 	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
+	.mutex_sof_reg = MT2701_DISP_MUTEX0_SOF0,
 };
 
 static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
@@ -462,28 +492,29 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
 	struct mtk_ddp *ddp = container_of(mutex, struct mtk_ddp,
 					   mutex[mutex->id]);
 	unsigned int reg;
+	unsigned int sof_id;
 	unsigned int offset;
 
 	WARN_ON(&ddp->mutex[mutex->id] != mutex);
 
 	switch (id) {
 	case DDP_COMPONENT_DSI0:
-		reg = MUTEX_SOF_DSI0;
+		sof_id = DDP_MUTEX_SOF_DSI0;
 		break;
 	case DDP_COMPONENT_DSI1:
-		reg = MUTEX_SOF_DSI0;
+		sof_id = DDP_MUTEX_SOF_DSI0;
 		break;
 	case DDP_COMPONENT_DSI2:
-		reg = MUTEX_SOF_DSI2;
+		sof_id = DDP_MUTEX_SOF_DSI2;
 		break;
 	case DDP_COMPONENT_DSI3:
-		reg = MUTEX_SOF_DSI3;
+		sof_id = DDP_MUTEX_SOF_DSI3;
 		break;
 	case DDP_COMPONENT_DPI0:
-		reg = MUTEX_SOF_DPI0;
+		sof_id = DDP_MUTEX_SOF_DPI0;
 		break;
 	case DDP_COMPONENT_DPI1:
-		reg = MUTEX_SOF_DPI1;
+		sof_id = DDP_MUTEX_SOF_DPI1;
 		break;
 	default:
 		if (ddp->data->mutex_mod[id] < 32) {
@@ -500,7 +531,8 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
 		return;
 	}
 
-	writel_relaxed(reg, ddp->regs + DISP_REG_MUTEX_SOF(mutex->id));
+	writel_relaxed(ddp->data->mutex_sof[sof_id],
+		       ddp->regs + DISP_REG_MUTEX_SOF(ddp->data, mutex->id));
 }
 
 void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
@@ -521,7 +553,8 @@ void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
 	case DDP_COMPONENT_DPI0:
 	case DDP_COMPONENT_DPI1:
 		writel_relaxed(MUTEX_SOF_SINGLE_MODE,
-			       ddp->regs + DISP_REG_MUTEX_SOF(mutex->id));
+			       ddp->regs +
+			       DISP_REG_MUTEX_SOF(ddp->data, mutex->id));
 		break;
 	default:
 		if (ddp->data->mutex_mod[id] < 32) {
-- 
1.8.1.1.dirty

