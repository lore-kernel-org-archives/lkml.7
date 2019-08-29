Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96D3C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF892080F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfH2OvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:51:23 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51287 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728010AbfH2OvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:51:21 -0400
X-UUID: 0a3efaea5a164707bcda5a7e4804e00a-20190829
X-UUID: 0a3efaea5a164707bcda5a7e4804e00a-20190829
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 560609409; Thu, 29 Aug 2019 22:51:12 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 29 Aug 2019 22:51:18 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 29 Aug 2019 22:51:17 +0800
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
Subject: [PATCH v5, 12/32] drm/mediatek: add mmsys private data for ddp path config
Date:   Thu, 29 Aug 2019 22:50:34 +0800
Message-ID: <1567090254-15566-13-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1567090254-15566-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1567090254-15566-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

This patch add mmsys private data for ddp path config
all these register offset and value will be different in future SOC
add these define into mmsys private data
	u32 ovl0_mout_en;
	u32 rdma1_sout_sel_in;
	u32 rdma1_sout_dsi0;
	u32 dpi0_sel_in;
	u32 dpi0_sel_in_rdma1;
	u32 dsi0_sel_in;
	u32 dsi0_sel_in_rdma1;

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c |  4 ++
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c  | 86 +++++++++++++++++++++++----------
 drivers/gpu/drm/mediatek/mtk_drm_ddp.h  |  5 ++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c  |  3 ++
 drivers/gpu/drm/mediatek/mtk_drm_drv.h  |  3 ++
 5 files changed, 76 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index c1e891e..c63ff2b 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -41,6 +41,7 @@ struct mtk_drm_crtc {
 	bool				pending_planes;
 
 	void __iomem			*config_regs;
+	const struct mtk_mmsys_reg_data *mmsys_reg_data;
 	struct mtk_disp_mutex		*mutex;
 	unsigned int			ddp_comp_nr;
 	struct mtk_ddp_comp		**ddp_comp;
@@ -258,6 +259,7 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
 	DRM_DEBUG_DRIVER("mediatek_ddp_ddp_path_setup\n");
 	for (i = 0; i < mtk_crtc->ddp_comp_nr - 1; i++) {
 		mtk_ddp_add_comp_to_path(mtk_crtc->config_regs,
+					 mtk_crtc->mmsys_reg_data,
 					 mtk_crtc->ddp_comp[i]->id,
 					 mtk_crtc->ddp_comp[i + 1]->id);
 		mtk_disp_mutex_add_comp(mtk_crtc->mutex,
@@ -306,6 +308,7 @@ static void mtk_crtc_ddp_hw_fini(struct mtk_drm_crtc *mtk_crtc)
 	mtk_disp_mutex_disable(mtk_crtc->mutex);
 	for (i = 0; i < mtk_crtc->ddp_comp_nr - 1; i++) {
 		mtk_ddp_remove_comp_from_path(mtk_crtc->config_regs,
+					      mtk_crtc->mmsys_reg_data,
 					      mtk_crtc->ddp_comp[i]->id,
 					      mtk_crtc->ddp_comp[i + 1]->id);
 		mtk_disp_mutex_remove_comp(mtk_crtc->mutex,
@@ -537,6 +540,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 		return -ENOMEM;
 
 	mtk_crtc->config_regs = priv->config_regs;
+	mtk_crtc->mmsys_reg_data = priv->data->reg_data;
 	mtk_crtc->ddp_comp_nr = path_len;
 	mtk_crtc->ddp_comp = devm_kmalloc_array(dev, mtk_crtc->ddp_comp_nr,
 						sizeof(*mtk_crtc->ddp_comp),
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index c93e1b7..338cc2f 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -167,6 +167,16 @@ struct mtk_ddp {
 	const struct mtk_ddp_data	*data;
 };
 
+struct mtk_mmsys_reg_data {
+	u32 ovl0_mout_en;
+	u32 rdma1_sout_sel_in;
+	u32 rdma1_sout_dpi0;
+	u32 dpi0_sel_in;
+	u32 dpi0_sel_in_rdma1;
+	u32 dsi0_sel_in;
+	u32 dsi0_sel_in_rdma1;
+};
+
 static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_BLS] = MT2701_MUTEX_MOD_DISP_BLS,
 	[DDP_COMPONENT_COLOR0] = MT2701_MUTEX_MOD_DISP_COLOR,
@@ -245,17 +255,34 @@ struct mtk_ddp {
 	.mutex_sof_reg = MT2701_DISP_MUTEX0_SOF0,
 };
 
-static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
+const struct mtk_mmsys_reg_data mt2701_mmsys_reg_data = {
+	.ovl0_mout_en = DISP_REG_CONFIG_DISP_OVL_MOUT_EN,
+	.dsi0_sel_in = DISP_REG_CONFIG_DSI_SEL,
+	.dsi0_sel_in_rdma1 = DSI_SEL_IN_RDMA,
+};
+
+const struct mtk_mmsys_reg_data mt8173_mmsys_reg_data = {
+	.ovl0_mout_en = DISP_REG_CONFIG_DISP_OVL0_MOUT_EN,
+	.rdma1_sout_sel_in = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN,
+	.rdma1_sout_dpi0 = RDMA1_SOUT_DPI0,
+	.dpi0_sel_in = DISP_REG_CONFIG_DPI_SEL_IN,
+	.dpi0_sel_in_rdma1 = DPI0_SEL_IN_RDMA1,
+	.dsi0_sel_in = DISP_REG_CONFIG_DSIE_SEL_IN,
+	.dsi0_sel_in_rdma1 = DSI0_SEL_IN_RDMA1,
+};
+
+static unsigned int mtk_ddp_mout_en(const struct mtk_mmsys_reg_data *data,
+				    enum mtk_ddp_comp_id cur,
 				    enum mtk_ddp_comp_id next,
 				    unsigned int *addr)
 {
 	unsigned int value;
 
 	if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_COLOR0) {
-		*addr = DISP_REG_CONFIG_DISP_OVL0_MOUT_EN;
+		*addr = data->ovl0_mout_en;
 		value = OVL0_MOUT_EN_COLOR0;
 	} else if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_RDMA0) {
-		*addr = DISP_REG_CONFIG_DISP_OVL_MOUT_EN;
+		*addr = data->ovl0_mout_en;
 		value = OVL_MOUT_EN_RDMA;
 	} else if (cur == DDP_COMPONENT_OD0 && next == DDP_COMPONENT_RDMA0) {
 		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
@@ -297,8 +324,8 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
 		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
 		value = RDMA1_SOUT_DSI3;
 	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
-		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
-		value = RDMA1_SOUT_DPI0;
+		*addr = data->rdma1_sout_sel_in;
+		value = data->rdma1_sout_dpi0;
 	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI1) {
 		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
 		value = RDMA1_SOUT_DPI1;
@@ -324,7 +351,8 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
 	return value;
 }
 
-static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
+static unsigned int mtk_ddp_sel_in(const struct mtk_mmsys_reg_data *data,
+				   enum mtk_ddp_comp_id cur,
 				   enum mtk_ddp_comp_id next,
 				   unsigned int *addr)
 {
@@ -334,14 +362,14 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
 		*addr = DISP_REG_CONFIG_DISP_COLOR0_SEL_IN;
 		value = COLOR0_SEL_IN_OVL0;
 	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
-		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
-		value = DPI0_SEL_IN_RDMA1;
+		*addr = data->dpi0_sel_in;
+		value = data->dpi0_sel_in_rdma1;
 	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI1) {
 		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
 		value = DPI1_SEL_IN_RDMA1;
 	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI0) {
-		*addr = DISP_REG_CONFIG_DSIE_SEL_IN;
-		value = DSI0_SEL_IN_RDMA1;
+		*addr = data->dsi0_sel_in;
+		value = data->dsi0_sel_in_rdma1;
 	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI1) {
 		*addr = DISP_REG_CONFIG_DSIO_SEL_IN;
 		value = DSI1_SEL_IN_RDMA1;
@@ -382,37 +410,44 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
 	return value;
 }
 
-static void mtk_ddp_sout_sel(void __iomem *config_regs,
-			     enum mtk_ddp_comp_id cur,
-			     enum mtk_ddp_comp_id next)
+static unsigned int mtk_ddp_sout_sel(const struct mtk_mmsys_reg_data *data,
+				     enum mtk_ddp_comp_id cur,
+				     enum mtk_ddp_comp_id next,
+				     unsigned int *addr)
 {
+	unsigned int value;
+
 	if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
-		writel_relaxed(BLS_TO_DSI_RDMA1_TO_DPI1,
-			       config_regs + DISP_REG_CONFIG_OUT_SEL);
+		*addr = DISP_REG_CONFIG_OUT_SEL;
+		value = BLS_TO_DSI_RDMA1_TO_DPI1;
 	} else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DPI0) {
-		writel_relaxed(BLS_TO_DPI_RDMA1_TO_DSI,
-			       config_regs + DISP_REG_CONFIG_OUT_SEL);
-	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI0) {
-		writel_relaxed(DSI_SEL_IN_RDMA,
-			       config_regs + DISP_REG_CONFIG_DSI_SEL);
+		*addr = DISP_REG_CONFIG_OUT_SEL;
+		value = BLS_TO_DPI_RDMA1_TO_DSI;
+	} else {
+		value = 0;
 	}
+
+	return value;
 }
 
 void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
+			      const struct mtk_mmsys_reg_data *reg_data,
 			      enum mtk_ddp_comp_id cur,
 			      enum mtk_ddp_comp_id next)
 {
 	unsigned int addr, value, reg;
 
-	value = mtk_ddp_mout_en(cur, next, &addr);
+	value = mtk_ddp_mout_en(reg_data, cur, next, &addr);
 	if (value) {
 		reg = readl_relaxed(config_regs + addr) | value;
 		writel_relaxed(reg, config_regs + addr);
 	}
 
-	mtk_ddp_sout_sel(config_regs, cur, next);
+	value = mtk_ddp_sout_sel(reg_data, cur, next, &addr);
+	if (value)
+		writel_relaxed(value, config_regs + addr);
 
-	value = mtk_ddp_sel_in(cur, next, &addr);
+	value = mtk_ddp_sel_in(reg_data, cur, next, &addr);
 	if (value) {
 		reg = readl_relaxed(config_regs + addr) | value;
 		writel_relaxed(reg, config_regs + addr);
@@ -420,18 +455,19 @@ void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
 }
 
 void mtk_ddp_remove_comp_from_path(void __iomem *config_regs,
+				   const struct mtk_mmsys_reg_data *reg_data,
 				   enum mtk_ddp_comp_id cur,
 				   enum mtk_ddp_comp_id next)
 {
 	unsigned int addr, value, reg;
 
-	value = mtk_ddp_mout_en(cur, next, &addr);
+	value = mtk_ddp_mout_en(reg_data, cur, next, &addr);
 	if (value) {
 		reg = readl_relaxed(config_regs + addr) & ~value;
 		writel_relaxed(reg, config_regs + addr);
 	}
 
-	value = mtk_ddp_sel_in(cur, next, &addr);
+	value = mtk_ddp_sel_in(reg_data, cur, next, &addr);
 	if (value) {
 		reg = readl_relaxed(config_regs + addr) & ~value;
 		writel_relaxed(reg, config_regs + addr);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
index 827be42..c55cc63 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
@@ -11,11 +11,16 @@
 struct regmap;
 struct device;
 struct mtk_disp_mutex;
+struct mtk_mmsys_reg_data;
 
+extern const struct mtk_mmsys_reg_data mt2701_mmsys_reg_data;
+extern const struct mtk_mmsys_reg_data mt8173_mmsys_reg_data;
 void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
+			      const struct mtk_mmsys_reg_data *reg_data,
 			      enum mtk_ddp_comp_id cur,
 			      enum mtk_ddp_comp_id next);
 void mtk_ddp_remove_comp_from_path(void __iomem *config_regs,
+				   const struct mtk_mmsys_reg_data *reg_data,
 				   enum mtk_ddp_comp_id cur,
 				   enum mtk_ddp_comp_id next);
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 95fdbd0..2471ce9 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -189,6 +189,7 @@ static int mtk_atomic_commit(struct drm_device *drm,
 	.main_len = ARRAY_SIZE(mt2701_mtk_ddp_main),
 	.ext_path = mt2701_mtk_ddp_ext,
 	.ext_len = ARRAY_SIZE(mt2701_mtk_ddp_ext),
+	.reg_data = &mt2701_mmsys_reg_data,
 	.shadow_register = true,
 };
 
@@ -199,6 +200,7 @@ static int mtk_atomic_commit(struct drm_device *drm,
 	.ext_len = ARRAY_SIZE(mt2712_mtk_ddp_ext),
 	.third_path = mt2712_mtk_ddp_third,
 	.third_len = ARRAY_SIZE(mt2712_mtk_ddp_third),
+	.reg_data = &mt8173_mmsys_reg_data,
 };
 
 static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
@@ -206,6 +208,7 @@ static int mtk_atomic_commit(struct drm_device *drm,
 	.main_len = ARRAY_SIZE(mt8173_mtk_ddp_main),
 	.ext_path = mt8173_mtk_ddp_ext,
 	.ext_len = ARRAY_SIZE(mt8173_mtk_ddp_ext),
+	.reg_data = &mt8173_mmsys_reg_data,
 };
 
 static int mtk_drm_kms_init(struct drm_device *drm)
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index 598ff3e..823ba40 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -7,6 +7,7 @@
 #define MTK_DRM_DRV_H
 
 #include <linux/io.h>
+#include "mtk_drm_ddp.h"
 #include "mtk_drm_ddp_comp.h"
 
 #define MAX_CRTC	3
@@ -28,6 +29,8 @@ struct mtk_mmsys_driver_data {
 	const enum mtk_ddp_comp_id *third_path;
 	unsigned int third_len;
 
+	const struct mtk_mmsys_reg_data *reg_data;
+
 	bool shadow_register;
 };
 
-- 
1.8.1.1.dirty

