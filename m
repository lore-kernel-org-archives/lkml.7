Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DEBC606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71FA2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfGHWgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 18:36:18 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38638 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727428AbfGHWel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 18:34:41 -0400
X-UUID: 0df2b40292774c3ea0aa433a48b6b287-20190709
X-UUID: 0df2b40292774c3ea0aa433a48b6b287-20190709
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 469523390; Tue, 09 Jul 2019 06:34:35 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 9 Jul 2019 06:34:33 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 9 Jul 2019 06:34:33 +0800
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
Subject: [PATCH v4, 15/33] drm/mediatek: add ddp component CCORR
Date:   Tue, 9 Jul 2019 06:33:55 +0800
Message-ID: <1562625253-29254-16-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1562625253-29254-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1562625253-29254-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

This patch add ddp component CCORR

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 32 +++++++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  2 ++
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index ede15c9..b357b24 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -41,6 +41,12 @@
 #define DISP_AAL_EN				0x0000
 #define DISP_AAL_SIZE				0x0030
 
+#define DISP_CCORR_EN				0x0000
+#define CCORR_EN				BIT(0)
+#define DISP_CCORR_CFG				0x0020
+#define CCORR_RELAY_MODE			BIT(0)
+#define DISP_CCORR_SIZE				0x0030
+
 #define DISP_GAMMA_EN				0x0000
 #define DISP_GAMMA_CFG				0x0020
 #define DISP_GAMMA_SIZE				0x0030
@@ -131,6 +137,24 @@ static void mtk_aal_stop(struct mtk_ddp_comp *comp)
 	writel_relaxed(0x0, comp->regs + DISP_AAL_EN);
 }
 
+static void mtk_ccorr_config(struct mtk_ddp_comp *comp, unsigned int w,
+			     unsigned int h, unsigned int vrefresh,
+			     unsigned int bpc)
+{
+	writel(h << 16 | w, comp->regs + DISP_CCORR_SIZE);
+	writel(CCORR_RELAY_MODE, comp->regs + DISP_CCORR_CFG);
+}
+
+static void mtk_ccorr_start(struct mtk_ddp_comp *comp)
+{
+	writel(CCORR_EN, comp->regs + DISP_CCORR_EN);
+}
+
+static void mtk_ccorr_stop(struct mtk_ddp_comp *comp)
+{
+	writel_relaxed(0x0, comp->regs + DISP_CCORR_EN);
+}
+
 static void mtk_gamma_config(struct mtk_ddp_comp *comp, unsigned int w,
 			     unsigned int h, unsigned int vrefresh,
 			     unsigned int bpc)
@@ -179,6 +203,12 @@ static void mtk_gamma_set(struct mtk_ddp_comp *comp,
 	.stop = mtk_aal_stop,
 };
 
+static const struct mtk_ddp_comp_funcs ddp_ccorr = {
+	.config = mtk_ccorr_config,
+	.start = mtk_ccorr_start,
+	.stop = mtk_ccorr_stop,
+};
+
 static const struct mtk_ddp_comp_funcs ddp_gamma = {
 	.gamma_set = mtk_gamma_set,
 	.config = mtk_gamma_config,
@@ -200,6 +230,7 @@ static void mtk_gamma_set(struct mtk_ddp_comp *comp,
 	[MTK_DISP_RDMA] = "rdma",
 	[MTK_DISP_WDMA] = "wdma",
 	[MTK_DISP_COLOR] = "color",
+	[MTK_DISP_CCORR] = "ccorr",
 	[MTK_DISP_AAL] = "aal",
 	[MTK_DISP_GAMMA] = "gamma",
 	[MTK_DISP_UFOE] = "ufoe",
@@ -221,6 +252,7 @@ struct mtk_ddp_comp_match {
 	[DDP_COMPONENT_AAL0]	= { MTK_DISP_AAL,	0, &ddp_aal },
 	[DDP_COMPONENT_AAL1]	= { MTK_DISP_AAL,	1, &ddp_aal },
 	[DDP_COMPONENT_BLS]	= { MTK_DISP_BLS,	0, NULL },
+	[DDP_COMPONENT_CCORR]	= { MTK_DISP_CCORR,	0, &ddp_ccorr },
 	[DDP_COMPONENT_COLOR0]	= { MTK_DISP_COLOR,	0, NULL },
 	[DDP_COMPONENT_COLOR1]	= { MTK_DISP_COLOR,	1, NULL },
 	[DDP_COMPONENT_DPI0]	= { MTK_DPI,		0, NULL },
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index b8dc17e..bd5fcc9 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -28,6 +28,7 @@ enum mtk_ddp_comp_type {
 	MTK_DISP_RDMA,
 	MTK_DISP_WDMA,
 	MTK_DISP_COLOR,
+	MTK_DISP_CCORR,
 	MTK_DISP_AAL,
 	MTK_DISP_GAMMA,
 	MTK_DISP_UFOE,
@@ -44,6 +45,7 @@ enum mtk_ddp_comp_id {
 	DDP_COMPONENT_AAL0,
 	DDP_COMPONENT_AAL1,
 	DDP_COMPONENT_BLS,
+	DDP_COMPONENT_CCORR,
 	DDP_COMPONENT_COLOR0,
 	DDP_COMPONENT_COLOR1,
 	DDP_COMPONENT_DPI0,
-- 
1.8.1.1.dirty

