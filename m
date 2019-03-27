Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E00C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84849206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733303AbfC0GTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:19:49 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60682 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733187AbfC0GTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:19:46 -0400
X-UUID: f34f25c7110444a2ad38c06e0100689f-20190327
X-UUID: f34f25c7110444a2ad38c06e0100689f-20190327
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 506004009; Wed, 27 Mar 2019 14:19:39 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Mar 2019 14:19:38 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Mar 2019 14:19:37 +0800
From:   <yongqiang.niu@mediatek.com>
To:     <ck.hu@mediatek.com>, <p.zabel@pengutronix.de>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <airlied@linux.ie>, <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>, Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v2 09/25] drm/mediatek: add mmsys private data for ddp path config
Date:   Wed, 27 Mar 2019 14:19:05 +0800
Message-ID: <1553667561-25447-10-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E9D030E554ED0C2088D9E4A02DCEAEC037AE9AE288C383438954F9A56161DD4C2000:8
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
	u32 rdma0_sout_sel_in;
	u32 rdma0_sout_color0;
	u32 rdma1_sout_sel_in;
	u32 rdma1_sout_dpi0;
	u32 rdma1_sout_dsi0;
	u32 dpi0_sel_in;
	u32 dpi0_sel_in_rdma1;
	u32 dsi0_sel_in;
	u32 dsi0_sel_in_rdma1;

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c |   4 ++
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c  | 103 ++++++++++++++++++++++++++------
 drivers/gpu/drm/mediatek/mtk_drm_ddp.h  |  10 ++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c  |  11 ++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.h  |   4 ++
 5 files changed, 113 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index acad088..11e3404 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -50,6 +50,7 @@ struct mtk_drm_crtc {
 	bool				pending_planes;
 
 	void __iomem			*config_regs;
+	const struct mtk_mmsys_reg_data *mmsys_reg_data;
 	struct mtk_disp_mutex		*mutex;
 	unsigned int			ddp_comp_nr;
 	struct mtk_ddp_comp		**ddp_comp;
@@ -271,6 +272,7 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
 	DRM_DEBUG_DRIVER("mediatek_ddp_ddp_path_setup\n");
 	for (i = 0; i < mtk_crtc->ddp_comp_nr - 1; i++) {
 		mtk_ddp_add_comp_to_path(mtk_crtc->config_regs,
+					 mtk_crtc->mmsys_reg_data,
 					 mtk_crtc->ddp_comp[i]->id,
 					 mtk_crtc->ddp_comp[i + 1]->id);
 		mtk_disp_mutex_add_comp(mtk_crtc->mutex,
@@ -319,6 +321,7 @@ static void mtk_crtc_ddp_hw_fini(struct mtk_drm_crtc *mtk_crtc)
 	mtk_disp_mutex_disable(mtk_crtc->mutex);
 	for (i = 0; i < mtk_crtc->ddp_comp_nr - 1; i++) {
 		mtk_ddp_remove_comp_from_path(mtk_crtc->config_regs,
+					      mtk_crtc->mmsys_reg_data,
 					      mtk_crtc->ddp_comp[i]->id,
 					      mtk_crtc->ddp_comp[i + 1]->id);
 		mtk_disp_mutex_remove_comp(mtk_crtc->mutex,
@@ -561,6 +564,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 		return -ENOMEM;
 
 	mtk_crtc->config_regs = priv->config_regs;
+	mtk_crtc->mmsys_reg_data = priv->reg_data;
 	mtk_crtc->ddp_comp_nr = path_len;
 	mtk_crtc->ddp_comp = devm_kmalloc_array(dev, mtk_crtc->ddp_comp_nr,
 						sizeof(*mtk_crtc->ddp_comp),
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 5ae13b0..ee395d3 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -145,6 +145,17 @@
 #define DPI_SEL_IN_BLS			0x0
 #define DSI_SEL_IN_RDMA			0x1
 
+#define DISP_REG_OVL0_MOUT_EN(data)		((data)->ovl0_mout_en)
+#define DISP_REG_DPI0_SEL_IN(data)		((data)->dpi0_sel_in)
+#define DISP_REG_DPI0_SEL_IN_RDMA1(data)	((data)->dpi0_sel_in_rdma1)
+#define DISP_REG_DSI0_SEL_IN(data)		((data)->dsi0_sel_in)
+#define DISP_REG_DSI0_SEL_IN_RDMA1(data)	((data)->dsi0_sel_in_rdma1)
+#define DISP_REG_RDMA0_SOUT_SEL_IN(data)	((data)->rdma0_sout_sel_in)
+#define DISP_REG_RDMA0_SOUT_COLOR0(data)	((data)->rdma0_sout_color0)
+#define DISP_REG_RDMA1_SOUT_SEL_IN(data)	((data)->rdma1_sout_sel_in)
+#define DISP_REG_RDMA1_SOUT_DPI0(data)		((data)->rdma1_sout_dpi0)
+#define DISP_REG_RDMA1_SOUT_DSI0(data)		((data)->rdma1_sout_dsi0)
+
 struct mtk_disp_mutex {
 	int id;
 	bool claimed;
@@ -176,6 +187,19 @@ struct mtk_ddp {
 	const struct mtk_ddp_data	*data;
 };
 
+struct mtk_mmsys_reg_data {
+	u32 ovl0_mout_en;
+	u32 rdma0_sout_sel_in;
+	u32 rdma0_sout_color0;
+	u32 rdma1_sout_sel_in;
+	u32 rdma1_sout_dpi0;
+	u32 rdma1_sout_dsi0;
+	u32 dpi0_sel_in;
+	u32 dpi0_sel_in_rdma1;
+	u32 dsi0_sel_in;
+	u32 dsi0_sel_in_rdma1;
+};
+
 static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_BLS] = MT2701_MUTEX_MOD_DISP_BLS,
 	[DDP_COMPONENT_COLOR0] = MT2701_MUTEX_MOD_DISP_COLOR,
@@ -254,17 +278,34 @@ struct mtk_ddp {
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
+		*addr = DISP_REG_OVL0_MOUT_EN(data);
 		value = OVL0_MOUT_EN_COLOR0;
 	} else if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_RDMA0) {
-		*addr = DISP_REG_CONFIG_DISP_OVL_MOUT_EN;
+		*addr = DISP_REG_OVL0_MOUT_EN(data);
 		value = OVL_MOUT_EN_RDMA;
 	} else if (cur == DDP_COMPONENT_OD0 && next == DDP_COMPONENT_RDMA0) {
 		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
@@ -288,7 +329,8 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
 	return value;
 }
 
-static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
+static unsigned int mtk_ddp_sel_in(const struct mtk_mmsys_reg_data *data,
+				   enum mtk_ddp_comp_id cur,
 				   enum mtk_ddp_comp_id next,
 				   unsigned int *addr)
 {
@@ -298,14 +340,14 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
 		*addr = DISP_REG_CONFIG_DISP_COLOR0_SEL_IN;
 		value = COLOR0_SEL_IN_OVL0;
 	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
-		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
-		value = DPI0_SEL_IN_RDMA1;
+		*addr = DISP_REG_DPI0_SEL_IN(data);
+		value = DISP_REG_DPI0_SEL_IN_RDMA1(data);
 	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI1) {
 		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
 		value = DPI1_SEL_IN_RDMA1;
 	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI0) {
-		*addr = DISP_REG_CONFIG_DSIE_SEL_IN;
-		value = DSI0_SEL_IN_RDMA1;
+		*addr = DISP_REG_DSI0_SEL_IN(data);
+		value = DISP_REG_DSI0_SEL_IN_RDMA1(data);
 	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI1) {
 		*addr = DISP_REG_CONFIG_DSIO_SEL_IN;
 		value = DSI1_SEL_IN_RDMA1;
@@ -346,7 +388,8 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
 	return value;
 }
 
-static unsigned int mtk_ddp_sout_sel(enum mtk_ddp_comp_id cur,
+static unsigned int mtk_ddp_sout_sel(const struct mtk_mmsys_reg_data *data,
+				     enum mtk_ddp_comp_id cur,
 				     enum mtk_ddp_comp_id next,
 				     unsigned int *addr)
 {
@@ -358,9 +401,6 @@ static unsigned int mtk_ddp_sout_sel(enum mtk_ddp_comp_id cur,
 	} else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DPI0) {
 		*addr = DISP_REG_CONFIG_OUT_SEL;
                 value = BLS_TO_DPI_RDMA1_TO_DSI;
-	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI0) {
-		*addr = DISP_REG_CONFIG_DSI_SEL;
-		value = DSI_SEL_IN_RDMA;
 	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DPI0) {
 		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
 		value = RDMA0_SOUT_DPI0;
@@ -386,8 +426,8 @@ static unsigned int mtk_ddp_sout_sel(enum mtk_ddp_comp_id cur,
 		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
 		value = RDMA1_SOUT_DSI3;
 	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
-		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
-		value = RDMA1_SOUT_DPI0;
+		*addr = DISP_REG_RDMA1_SOUT_SEL_IN(data);
+		value = DISP_REG_RDMA1_SOUT_DPI0(data);
 	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI1) {
 		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
 		value = RDMA1_SOUT_DPI1;
@@ -414,22 +454,23 @@ static unsigned int mtk_ddp_sout_sel(enum mtk_ddp_comp_id cur,
 }
 
 void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
+                              const struct mtk_mmsys_reg_data *reg_data,
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
 
-	value = mtk_ddp_sout_sel(cur, next, &addr);
+	value = mtk_ddp_sout_sel(reg_data, cur, next, &addr);
 	if (value)
                 writel_relaxed(value, config_regs + addr);
 
-	value = mtk_ddp_sel_in(cur, next, &addr);
+	value = mtk_ddp_sel_in(reg_data, cur, next, &addr);
 	if (value) {
 		reg = readl_relaxed(config_regs + addr) | value;
 		writel_relaxed(reg, config_regs + addr);
@@ -437,24 +478,48 @@ void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
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
 	}
 }
 
+const struct mtk_mmsys_reg_data *mtk_ddp_get_mmsys_data(enum mtk_mmsys_id id)
+{
+	const struct mtk_mmsys_reg_data *data = NULL;
+
+	switch (id) {
+	case MMSYS_MT2701:
+		data = &mt2701_mmsys_reg_data;
+		break;
+	case MMSYS_MT2712:
+		data = &mt8173_mmsys_reg_data;
+		break;
+	case MMSYS_MT8173:
+		data = &mt8173_mmsys_reg_data;
+		break;
+	default:
+		pr_info("mtk drm not support mmsys id %d\n",
+			id);
+		break;
+	}
+
+	return data;
+}
+
 struct mtk_disp_mutex *mtk_disp_mutex_get(struct device *dev, unsigned int id)
 {
 	struct mtk_ddp *ddp = dev_get_drvdata(dev);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
index f9a7991..ed2b702 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
@@ -19,11 +19,21 @@
 struct regmap;
 struct device;
 struct mtk_disp_mutex;
+struct mtk_mmsys_reg_data;
+enum mtk_mmsys_id {
+	MMSYS_MT2701,
+	MMSYS_MT2712,
+	MMSYS_MT8173,
+	MMSYS_MAX,
+};
 
+const struct mtk_mmsys_reg_data *mtk_ddp_get_mmsys_data(enum mtk_mmsys_id id);
 void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
+			      const struct mtk_mmsys_reg_data *reg_data,
 			      enum mtk_ddp_comp_id cur,
 			      enum mtk_ddp_comp_id next);
 void mtk_ddp_remove_comp_from_path(void __iomem *config_regs,
+				   const struct mtk_mmsys_reg_data *reg_data,
 				   enum mtk_ddp_comp_id cur,
 				   enum mtk_ddp_comp_id next);
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index cf59ea9..356853c 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -196,6 +196,7 @@ static int mtk_atomic_commit(struct drm_device *drm,
 	.main_len = ARRAY_SIZE(mt2701_mtk_ddp_main),
 	.ext_path = mt2701_mtk_ddp_ext,
 	.ext_len = ARRAY_SIZE(mt2701_mtk_ddp_ext),
+	.mmsys_id = MMSYS_MT2701,
 	.shadow_register = true,
 };
 
@@ -206,6 +207,7 @@ static int mtk_atomic_commit(struct drm_device *drm,
 	.ext_len = ARRAY_SIZE(mt2712_mtk_ddp_ext),
 	.third_path = mt2712_mtk_ddp_third,
 	.third_len = ARRAY_SIZE(mt2712_mtk_ddp_third),
+	.mmsys_id = MMSYS_MT2712,
 };
 
 static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
@@ -213,6 +215,7 @@ static int mtk_atomic_commit(struct drm_device *drm,
 	.main_len = ARRAY_SIZE(mt8173_mtk_ddp_main),
 	.ext_path = mt8173_mtk_ddp_ext,
 	.ext_len = ARRAY_SIZE(mt8173_mtk_ddp_ext),
+	.mmsys_id = MMSYS_MT8173,
 };
 
 static int mtk_drm_kms_init(struct drm_device *drm)
@@ -461,6 +464,14 @@ static int mtk_drm_probe(struct platform_device *pdev)
 	INIT_WORK(&private->commit.work, mtk_atomic_work);
 	private->data = of_device_get_match_data(dev);
 
+	private->reg_data = mtk_ddp_get_mmsys_data(private->data->mmsys_id);
+	if (IS_ERR(private->reg_data)) {
+		ret = PTR_ERR(private->config_regs);
+		pr_info("Failed to get mmsys register data: %d\n",
+			ret);
+		return ret;
+	}
+
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	private->config_regs = devm_ioremap_resource(dev, mem);
 	if (IS_ERR(private->config_regs)) {
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index ecc00ca..11de7f8 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -15,6 +15,7 @@
 #define MTK_DRM_DRV_H
 
 #include <linux/io.h>
+#include "mtk_drm_ddp.h"
 #include "mtk_drm_ddp_comp.h"
 
 #define MAX_CRTC	3
@@ -36,6 +37,8 @@ struct mtk_mmsys_driver_data {
 	const enum mtk_ddp_comp_id *third_path;
 	unsigned int third_len;
 
+	enum mtk_mmsys_id mmsys_id;
+
 	bool shadow_register;
 };
 
@@ -48,6 +51,7 @@ struct mtk_drm_private {
 	struct device_node *mutex_node;
 	struct device *mutex_dev;
 	void __iomem *config_regs;
+	const struct mtk_mmsys_reg_data *reg_data;
 	struct device_node *comp_node[DDP_COMPONENT_ID_MAX];
 	struct mtk_ddp_comp *ddp_comp[DDP_COMPONENT_ID_MAX];
 	const struct mtk_mmsys_driver_data *data;
-- 
1.8.1.1.dirty

