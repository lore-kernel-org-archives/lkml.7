Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60469C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D332075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfFELqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 07:46:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:15352 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727692AbfFELns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:43:48 -0400
X-UUID: 8082b2029f8c4d95ae7e212162aa0e3c-20190605
X-UUID: 8082b2029f8c4d95ae7e212162aa0e3c-20190605
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1600541998; Wed, 05 Jun 2019 19:43:42 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 5 Jun 2019 19:43:42 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 5 Jun 2019 19:43:41 +0800
From:   <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v3, 06/27] drm/mediatek: add mutex mod into ddp private data
Date:   Wed, 5 Jun 2019 19:42:45 +0800
Message-ID: <1559734986-7379-7-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1559734986-7379-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1559734986-7379-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

except mutex mod, mutex mod reg,mutex sof reg,
and mutex sof id will be ddp private data

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 53 +++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 579ce28..ae94d44 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -41,12 +41,12 @@
 #define DISP_REG_CONFIG_DSI_SEL			0x050
 #define DISP_REG_CONFIG_DPI_SEL			0x064
 
-#define DISP_REG_MUTEX_EN(n)	(0x20 + 0x20 * (n))
-#define DISP_REG_MUTEX(n)	(0x24 + 0x20 * (n))
-#define DISP_REG_MUTEX_RST(n)	(0x28 + 0x20 * (n))
-#define DISP_REG_MUTEX_MOD(n)	(0x2c + 0x20 * (n))
-#define DISP_REG_MUTEX_SOF(n)	(0x30 + 0x20 * (n))
-#define DISP_REG_MUTEX_MOD2(n)	(0x34 + 0x20 * (n))
+#define DISP_REG_MUTEX_EN(n)			(0x20 + 0x20 * (n))
+#define DISP_REG_MUTEX(n)			(0x24 + 0x20 * (n))
+#define DISP_REG_MUTEX_RST(n)			(0x28 + 0x20 * (n))
+#define DISP_REG_MUTEX_MOD(n)			(0x2c + 0x20 * (n))
+#define DISP_REG_MUTEX_SOF(n)			(0x30 + 0x20 * (n))
+#define DISP_REG_MUTEX_MOD2(n)			(0x34 + 0x20 * (n))
 
 #define INT_MUTEX				BIT(1)
 
@@ -147,12 +147,16 @@ struct mtk_disp_mutex {
 	bool claimed;
 };
 
+struct mtk_ddp_data {
+	const unsigned int *mutex_mod;
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
@@ -202,6 +206,18 @@ struct mtk_ddp {
 	[DDP_COMPONENT_WDMA1] = MT8173_MUTEX_MOD_DISP_WDMA1,
 };
 
+static const struct mtk_ddp_data mt2701_ddp_driver_data = {
+	.mutex_mod = mt2701_mutex_mod,
+};
+
+static const struct mtk_ddp_data mt2712_ddp_driver_data = {
+	.mutex_mod = mt2712_mutex_mod,
+};
+
+static const struct mtk_ddp_data mt8173_ddp_driver_data = {
+	.mutex_mod = mt8173_mutex_mod,
+};
+
 static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
 				    enum mtk_ddp_comp_id next,
 				    unsigned int *addr)
@@ -464,15 +480,15 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
 		reg = MUTEX_SOF_DPI1;
 		break;
 	default:
-		if (ddp->mutex_mod[id] < 32) {
+		if (ddp->data->mutex_mod[id] < 32) {
 			offset = DISP_REG_MUTEX_MOD(mutex->id);
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
@@ -502,15 +518,15 @@ void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
 			       ddp->regs + DISP_REG_MUTEX_SOF(mutex->id));
 		break;
 	default:
-		if (ddp->mutex_mod[id] < 32) {
+		if (ddp->data->mutex_mod[id] < 32) {
 			offset = DISP_REG_MUTEX_MOD(mutex->id);
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
@@ -585,7 +601,7 @@ static int mtk_ddp_probe(struct platform_device *pdev)
 		return PTR_ERR(ddp->regs);
 	}
 
-	ddp->mutex_mod = of_device_get_match_data(dev);
+	ddp->data = of_device_get_match_data(dev);
 
 	platform_set_drvdata(pdev, ddp);
 
@@ -598,9 +614,12 @@ static int mtk_ddp_remove(struct platform_device *pdev)
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

