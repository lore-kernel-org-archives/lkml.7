Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0F5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C162146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387547AbfC0GUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:20:02 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:15146 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733002AbfC0GUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:20:00 -0400
X-UUID: e8263a9b186b4106a3e0026ac831c0e0-20190327
X-UUID: e8263a9b186b4106a3e0026ac831c0e0-20190327
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 611644549; Wed, 27 Mar 2019 14:19:57 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Mar 2019 14:19:55 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Mar 2019 14:19:54 +0800
From:   <yongqiang.niu@mediatek.com>
To:     <ck.hu@mediatek.com>, <p.zabel@pengutronix.de>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <airlied@linux.ie>, <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>, Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v2 22/25] drm/mediatek: adjust ddp clock control flow
Date:   Wed, 27 Mar 2019 14:19:18 +0800
Message-ID: <1553667561-25447-23-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 322DC7B72FE93A02D912BF6759AA6BC253FB85AE38FACFDBA65666D83B3F98E82000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

display hardware clock will not unprepare when
crtc is disable, until crtc is destroyed.
with this patch, hard clock will disable and unprepare
at the same time.

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 0f97ee3..606c6e2 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -195,7 +195,7 @@ static int mtk_crtc_ddp_clk_enable(struct mtk_drm_crtc *mtk_crtc)
 
 	DRM_DEBUG_DRIVER("%s\n", __func__);
 	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
-		ret = clk_enable(mtk_crtc->ddp_comp[i]->clk);
+		ret = clk_prepare_enable(mtk_crtc->ddp_comp[i]->clk);
 		if (ret) {
 			DRM_ERROR("Failed to enable clock %d: %d\n", i, ret);
 			goto err;
@@ -205,7 +205,7 @@ static int mtk_crtc_ddp_clk_enable(struct mtk_drm_crtc *mtk_crtc)
 	return 0;
 err:
 	while (--i >= 0)
-		clk_disable(mtk_crtc->ddp_comp[i]->clk);
+		clk_disable_unprepare(mtk_crtc->ddp_comp[i]->clk);
 	return ret;
 }
 
@@ -215,7 +215,7 @@ static void mtk_crtc_ddp_clk_disable(struct mtk_drm_crtc *mtk_crtc)
 
 	DRM_DEBUG_DRIVER("%s\n", __func__);
 	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++)
-		clk_disable(mtk_crtc->ddp_comp[i]->clk);
+		clk_disable_unprepare(mtk_crtc->ddp_comp[i]->clk);
 }
 
 static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
@@ -615,15 +615,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 		if (!comp) {
 			dev_err(dev, "Component %pOF not initialized\n", node);
 			ret = -ENODEV;
-			goto unprepare;
-		}
-
-		ret = clk_prepare(comp->clk);
-		if (ret) {
-			dev_err(dev,
-				"Failed to prepare clock for component %pOF: %d\n",
-				node, ret);
-			goto unprepare;
+			return ret;
 		}
 
 		mtk_crtc->ddp_comp[i] = comp;
@@ -649,23 +641,17 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 		ret = mtk_plane_init(drm_dev, &mtk_crtc->planes[zpos],
 				     BIT(pipe), type);
 		if (ret)
-			goto unprepare;
+			return ret;
 	}
 
 	ret = mtk_drm_crtc_init(drm_dev, mtk_crtc, &mtk_crtc->planes[0],
 				mtk_crtc->layer_nr > 1 ? &mtk_crtc->planes[1] :
 				NULL, pipe);
 	if (ret < 0)
-		goto unprepare;
+		return ret;
 	drm_mode_crtc_set_gamma_size(&mtk_crtc->base, MTK_LUT_SIZE);
 	drm_crtc_enable_color_mgmt(&mtk_crtc->base, 0, false, MTK_LUT_SIZE);
 	priv->num_pipes++;
 
 	return 0;
-
-unprepare:
-	while (--i >= 0)
-		clk_unprepare(mtk_crtc->ddp_comp[i]->clk);
-
-	return ret;
 }
-- 
1.8.1.1.dirty

