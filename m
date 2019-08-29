Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AC6C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC1221726
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfH2Ox1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:53:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51287 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727908AbfH2OvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:51:15 -0400
X-UUID: 7e2ebb16762f484cb37fb2a6fb3e3f7c-20190829
X-UUID: 7e2ebb16762f484cb37fb2a6fb3e3f7c-20190829
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 7019671; Thu, 29 Aug 2019 22:51:09 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 29 Aug 2019 22:51:13 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 29 Aug 2019 22:51:13 +0800
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
Subject: [PATCH v5, 07/32] drm/mediatek: add mutex mod into ddp private data
Date:   Thu, 29 Aug 2019 22:50:29 +0800
Message-ID: <1567090254-15566-8-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1567090254-15566-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1567090254-15566-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 85B84C80FA8B58E7D9595F6ED56BBABC1B5B2AC0C62B849178FF5199DEE532772000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

except mutex mod, mutex mod reg,mutex sof reg,
and mutex sof id will be ddp private data

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 41 +++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 8106a71..b6cc3d8 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -139,12 +139,16 @@ struct mtk_disp_mutex {
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
@@ -194,6 +198,18 @@ struct mtk_ddp {
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
@@ -456,15 +472,15 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
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
@@ -494,15 +510,15 @@ void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
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
@@ -577,7 +593,7 @@ static int mtk_ddp_probe(struct platform_device *pdev)
 		return PTR_ERR(ddp->regs);
 	}
 
-	ddp->mutex_mod = of_device_get_match_data(dev);
+	ddp->data = of_device_get_match_data(dev);
 
 	platform_set_drvdata(pdev, ddp);
 
@@ -590,9 +606,12 @@ static int mtk_ddp_remove(struct platform_device *pdev)
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

