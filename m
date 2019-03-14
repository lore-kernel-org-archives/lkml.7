Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA61C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77ACC21852
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfCNMpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:45:09 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:9580 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727677AbfCNMpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:45:03 -0400
X-UUID: 6bb27d9d136e4ef9a5558c13497bd1be-20190314
X-UUID: 6bb27d9d136e4ef9a5558c13497bd1be-20190314
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 877253246; Thu, 14 Mar 2019 20:44:51 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Mar 2019 20:44:50 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 14 Mar 2019 20:44:49 +0800
From:   <yongqiang.niu@mediatek.com>
To:     <ck.hu@mediatek.com>, <p.zabel@pengutronix.de>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <airlied@linux.ie>, <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>, Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [RESEND PATCH v1 18/18] drm/mediatek: add support for mediatek SOC MT8183
Date:   Thu, 14 Mar 2019 20:05:20 +0800
Message-ID: <1552565120-24329-19-git-send-email-yongqiang.niu@mediatek.com>
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

This patch add support for mediatek SOC MT8183

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c  |  18 +++++
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c |   7 ++
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c   | 131 ++++++++++++++++++++++++++++++-
 drivers/gpu/drm/mediatek/mtk_drm_ddp.h   |   1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c   |  44 +++++++++++
 5 files changed, 197 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 3b2ce77..5bda3dd 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -372,11 +372,29 @@ static int mtk_disp_ovl_remove(struct platform_device *pdev)
 	.fmt_rgb565_is_0 = true,
 };
 
+static const struct mtk_disp_ovl_data mt8183_ovl_driver_data = {
+	.addr = DISP_REG_OVL_ADDR_MT8173,
+	.gmc_bits = 10,
+	.layer_nr = 4,
+	.fmt_rgb565_is_0 = true,
+};
+
+static const struct mtk_disp_ovl_data mt8183_ovl_2l_driver_data = {
+	.addr = DISP_REG_OVL_ADDR_MT8173,
+	.gmc_bits = 10,
+	.layer_nr = 2,
+	.fmt_rgb565_is_0 = true,
+};
+
 static const struct of_device_id mtk_disp_ovl_driver_dt_match[] = {
 	{ .compatible = "mediatek,mt2701-disp-ovl",
 	  .data = &mt2701_ovl_driver_data},
 	{ .compatible = "mediatek,mt8173-disp-ovl",
 	  .data = &mt8173_ovl_driver_data},
+	{ .compatible = "mediatek,mt8183-disp-ovl",
+	  .data = &mt8183_ovl_driver_data},
+	{ .compatible = "mediatek,mt8183-disp-ovl-2l",
+	  .data = &mt8183_ovl_2l_driver_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_disp_ovl_driver_dt_match);
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 3f9b4d4..5fffe91 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -350,11 +350,18 @@ static int mtk_disp_rdma_remove(struct platform_device *pdev)
 	.fifo_size1 = SZ_8K,
 };
 
+static const struct mtk_disp_rdma_data mt8183_rdma_driver_data = {
+	.fifo_size = 5 * SZ_1K,
+	.fifo_size1 = SZ_2K,
+};
+
 static const struct of_device_id mtk_disp_rdma_driver_dt_match[] = {
 	{ .compatible = "mediatek,mt2701-disp-rdma",
 	  .data = &mt2701_rdma_driver_data},
 	{ .compatible = "mediatek,mt8173-disp-rdma",
 	  .data = &mt8173_rdma_driver_data},
+	{ .compatible = "mediatek,mt8183-disp-rdma",
+	  .data = &mt8183_rdma_driver_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_disp_rdma_driver_dt_match);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 4be3c11..165843d 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -11,6 +11,7 @@
  * GNU General Public License for more details.
  */
 
+#include <drm/drmP.h>
 #include <linux/clk.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
@@ -41,8 +42,36 @@
 #define DISP_REG_CONFIG_DSI_SEL			0x050
 #define DISP_REG_CONFIG_DPI_SEL			0x064
 
+#define MT8183_DISP_OVL0_MOUT_EN		0xF00
+#define OVL0_MOUT_EN_DISP_PATH0			BIT(0)
+#define OVL0_MOUT_EN_OVL0_2L			BIT(4)
+#define MT8183_DISP_OVL0_2L_MOUT_EN		0xF04
+#define OVL0_2L_MOUT_EN_DISP_PATH0		BIT(0)
+#define MT8183_DISP_OVL1_2L_MOUT_EN		0xF08
+#define OVL1_2L_MOUT_EN_RDMA1			BIT(4)
+#define MT8183_DISP_DITHER0_MOUT_EN		0xF0C
+#define DITHER0_MOUT_IN_DSI0			BIT(0)
+#define MT8183_DISP_PATH0_SEL_IN		0xF24
+#define DISP_PATH0_SEL_IN_OVL0			0x0
+#define DISP_PATH0_SEL_IN_OVL0_2L		0x1
+#define MT8183_DISP_DSI0_SEL_IN			0xF2C
+#define DSI0_SEL_IN_DITHER			0x0
+#define DSI0_SEL_IN_RDMA0			0x1
+#define MT8183_DSI0_SEL_IN_RDMA1		0x3
+#define MT8183_DISP_DPI0_SEL_IN			0xF30
+#define MT8183_DPI0_SEL_IN_RDMA0		0x1
+#define MT8183_DPI0_SEL_IN_RDMA1		0x2
+#define MT8183_DISP_RDMA0_SOUT_SEL_IN		0xF50
+#define MT8183_RDMA0_SOUT_DSI0			0x0
+#define MT8183_RDMA0_SOUT_COLOR0		0x1
+#define MT8183_DISP_RDMA1_SOUT_SEL_IN		0xF54
+#define MT8183_RDMA1_SOUT_DPI0			0x0
+#define MT8183_RDMA1_SOUT_DSI0			0x1
+
 #define MT2701_DISP_MUTEX0_MOD0 0x2C
 #define MT2701_DISP_MUTEX0_SOF0  0x30
+#define MT8183_DISP_MUTEX0_MOD0 0x30
+#define MT8183_DISP_MUTEX0_SOF  0x2C
 
 #define DISP_REG_MUTEX_EN(n)	(0x20 + 0x20 * (n))
 #define DISP_REG_MUTEX(n)	(0x24 + 0x20 * (n))
@@ -53,6 +82,18 @@
 
 #define INT_MUTEX				BIT(1)
 
+#define MT8183_MUTEX_MOD_DISP_RDMA0		0
+#define MT8183_MUTEX_MOD_DISP_RDMA1		1
+#define MT8183_MUTEX_MOD_DISP_OVL0	        9
+#define MT8183_MUTEX_MOD_DISP_OVL0_2L	        10
+#define MT8183_MUTEX_MOD_DISP_OVL1_2L		11
+#define MT8183_MUTEX_MOD_DISP_WDMA0		12
+#define MT8183_MUTEX_MOD_DISP_COLOR0		13
+#define MT8183_MUTEX_MOD_DISP_CCORR0		14
+#define MT8183_MUTEX_MOD_DISP_AAL0		15
+#define MT8183_MUTEX_MOD_DISP_GAMMA0		16
+#define MT8183_MUTEX_MOD_DISP_DITHER0		17
+
 #define MT8173_MUTEX_MOD_DISP_OVL0		11
 #define MT8173_MUTEX_MOD_DISP_OVL1		12
 #define MT8173_MUTEX_MOD_DISP_RDMA0		13
@@ -102,6 +143,10 @@
 #define MUTEX_SOF_DSI2			5
 #define MUTEX_SOF_DSI3			6
 
+#define MT8183_MUTEX_SOF_DPI0			2
+#define MT8183_MUTEX_EOF_DSI0			(MUTEX_SOF_DSI0 << 6)
+#define MT8183_MUTEX_EOF_DPI0			(MT8183_MUTEX_SOF_DPI0 << 6)
+
 #define OVL0_MOUT_EN_COLOR0		0x1
 #define OD_MOUT_EN_RDMA0		0x1
 #define OD1_MOUT_EN_RDMA1		BIT(16)
@@ -247,6 +292,20 @@ struct mtk_mmsys_reg_data {
 	[DDP_COMPONENT_WDMA1] = MT8173_MUTEX_MOD_DISP_WDMA1,
 };
 
+static const unsigned int mt8183_mutex_mod[DDP_COMPONENT_ID_MAX] = {
+	[DDP_COMPONENT_AAL0] = MT8183_MUTEX_MOD_DISP_AAL0,
+	[DDP_COMPONENT_CCORR] = MT8183_MUTEX_MOD_DISP_CCORR0,
+	[DDP_COMPONENT_COLOR0] = MT8183_MUTEX_MOD_DISP_COLOR0,
+	[DDP_COMPONENT_DITHER] = MT8183_MUTEX_MOD_DISP_DITHER0,
+	[DDP_COMPONENT_GAMMA] = MT8183_MUTEX_MOD_DISP_GAMMA0,
+	[DDP_COMPONENT_OVL0] = MT8183_MUTEX_MOD_DISP_OVL0,
+	[DDP_COMPONENT_OVL0_2L] = MT8183_MUTEX_MOD_DISP_OVL0_2L,
+	[DDP_COMPONENT_OVL1_2L] = MT8183_MUTEX_MOD_DISP_OVL1_2L,
+	[DDP_COMPONENT_RDMA0] = MT8183_MUTEX_MOD_DISP_RDMA0,
+	[DDP_COMPONENT_RDMA1] = MT8183_MUTEX_MOD_DISP_RDMA1,
+	[DDP_COMPONENT_WDMA0] = MT8183_MUTEX_MOD_DISP_WDMA0,
+};
+
 static const unsigned int mt2701_mutex_sof[DDP_MUTEX_SOF_MAX] = {
 	[DDP_MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
 	[DDP_MUTEX_SOF_DSI0] = MUTEX_SOF_DSI0,
@@ -271,6 +330,12 @@ struct mtk_mmsys_reg_data {
 	[DDP_MUTEX_SOF_DPI0] = MUTEX_SOF_DPI0,
 };
 
+static const unsigned int mt8183_mutex_sof[DDP_MUTEX_SOF_MAX] = {
+	[DDP_MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
+	[DDP_MUTEX_SOF_DSI0] = MUTEX_SOF_DSI0 | MT8183_MUTEX_EOF_DSI0,
+	[DDP_MUTEX_SOF_DPI0] = MT8183_MUTEX_SOF_DPI0 | MT8183_MUTEX_EOF_DPI0,
+};
+
 static const struct mtk_ddp_data mt2701_ddp_driver_data = {
 	.mutex_mod = mt2701_mutex_mod,
 	.mutex_sof = mt2701_mutex_sof,
@@ -292,6 +357,13 @@ struct mtk_mmsys_reg_data {
 	.mutex_sof_reg = MT2701_DISP_MUTEX0_SOF0,
 };
 
+static const struct mtk_ddp_data mt8183_ddp_driver_data = {
+	.mutex_mod = mt8183_mutex_mod,
+	.mutex_sof = mt8183_mutex_sof,
+	.mutex_mod_reg = MT8183_DISP_MUTEX0_MOD0,
+	.mutex_sof_reg = MT8183_DISP_MUTEX0_SOF,
+};
+
 const struct mtk_mmsys_reg_data mt2701_mmsys_reg_data = {
 	.ovl0_mout_en = DISP_REG_CONFIG_DISP_OVL_MOUT_EN,
 	.dsi0_sel_in = DISP_REG_CONFIG_DSI_SEL,
@@ -308,6 +380,17 @@ struct mtk_mmsys_reg_data {
 	.dsi0_sel_in_rdma1 = DSI0_SEL_IN_RDMA1,
 };
 
+const struct mtk_mmsys_reg_data mt8183_mmsys_reg_data = {
+	.ovl0_mout_en = MT8183_DISP_OVL0_MOUT_EN,
+	.rdma0_sout_sel_in = MT8183_DISP_RDMA0_SOUT_SEL_IN,
+	.rdma0_sout_color0 = MT8183_RDMA0_SOUT_COLOR0,
+	.rdma1_sout_sel_in = MT8183_DISP_RDMA1_SOUT_SEL_IN,
+	.rdma1_sout_dpi0 = MT8183_RDMA1_SOUT_DPI0,
+	.rdma1_sout_dsi0 = MT8183_RDMA1_SOUT_DSI0,
+	.dpi0_sel_in = MT8183_DISP_DPI0_SEL_IN,
+	.dpi0_sel_in_rdma1 = MT8183_DPI0_SEL_IN_RDMA1,
+};
+
 static unsigned int mtk_ddp_mout_en(const struct mtk_mmsys_reg_data *data,
 				    enum mtk_ddp_comp_id cur,
 				    enum mtk_ddp_comp_id next,
@@ -336,6 +419,20 @@ static unsigned int mtk_ddp_mout_en(const struct mtk_mmsys_reg_data *data,
 	} else if (cur == DDP_COMPONENT_OD1 && next == DDP_COMPONENT_RDMA1) {
 		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
 		value = OD1_MOUT_EN_RDMA1;
+	} else if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_OVL0_2L) {
+		*addr = DISP_REG_OVL0_MOUT_EN(data);
+		value = OVL0_MOUT_EN_OVL0_2L;
+	} else if (cur == DDP_COMPONENT_OVL0_2L &&
+		   next == DDP_COMPONENT_RDMA0) {
+		*addr = MT8183_DISP_OVL0_2L_MOUT_EN;
+		value = OVL0_2L_MOUT_EN_DISP_PATH0;
+	} else if (cur == DDP_COMPONENT_OVL1_2L &&
+		   next == DDP_COMPONENT_RDMA1) {
+		*addr = MT8183_DISP_OVL1_2L_MOUT_EN;
+		value = OVL1_2L_MOUT_EN_RDMA1;
+	} else if (cur == DDP_COMPONENT_DITHER && next == DDP_COMPONENT_DSI0) {
+		*addr = MT8183_DISP_DITHER0_MOUT_EN;
+		value = DITHER0_MOUT_IN_DSI0;
 	} else {
 		value = 0;
 	}
@@ -395,6 +492,19 @@ static unsigned int mtk_ddp_sel_in(const struct mtk_mmsys_reg_data *data,
 	} else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
 		*addr = DISP_REG_CONFIG_DSI_SEL;
 		value = DSI_SEL_IN_BLS;
+	} else if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_RDMA0) {
+		*addr = MT8183_DISP_PATH0_SEL_IN;
+		value = DISP_PATH0_SEL_IN_OVL0;
+	} else if (cur == DDP_COMPONENT_OVL0_2L &&
+		   next == DDP_COMPONENT_RDMA0) {
+		*addr = MT8183_DISP_PATH0_SEL_IN;
+		value = DISP_PATH0_SEL_IN_OVL0_2L;
+	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DSI0) {
+		*addr = MT8183_DISP_DSI0_SEL_IN;
+		value = DSI0_SEL_IN_RDMA0;
+	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI0) {
+		*addr = MT8183_DISP_DSI0_SEL_IN;
+		value = DSI0_SEL_IN_RDMA1;
 	} else {
 		value = 0;
 	}
@@ -460,6 +570,12 @@ static unsigned int mtk_ddp_sout_sel(const struct mtk_mmsys_reg_data *data,
 	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DSI3) {
 		*addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
 		value = RDMA2_SOUT_DSI3;
+	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_COLOR0) {
+		*addr = DISP_REG_RDMA0_SOUT_SEL_IN(data);
+		value = DISP_REG_RDMA0_SOUT_COLOR0(data);
+	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI0) {
+		*addr = DISP_REG_RDMA1_SOUT_SEL_IN(data);
+		value = DISP_REG_RDMA1_SOUT_DSI0(data);
 	} else {
 		value = 0;
 	}
@@ -525,6 +641,9 @@ const struct mtk_mmsys_reg_data *mtk_ddp_get_mmsys_data(enum mtk_mmsys_id id)
 	case MMSYS_MT8173:
 		data = &mt8173_mmsys_reg_data;
 		break;
+	case MMSYS_MT8183:
+		data = &mt8183_mmsys_reg_data;
+		break;
 	default:
 		pr_info("mtk drm not support mmsys id %d\n",
 			id);
@@ -712,10 +831,12 @@ static int mtk_ddp_probe(struct platform_device *pdev)
 	for (i = 0; i < 10; i++)
 		ddp->mutex[i].id = i;
 
-	ddp->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(ddp->clk)) {
-		dev_err(dev, "Failed to get clock\n");
-		return PTR_ERR(ddp->clk);
+	if (of_find_property(dev->of_node, "clocks", &i)) {
+		ddp->clk = devm_clk_get(dev, NULL);
+		if (IS_ERR(ddp->clk)) {
+			dev_err(dev, "Failed to get clock\n");
+			return PTR_ERR(ddp->clk);
+		}
 	}
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -744,6 +865,8 @@ static int mtk_ddp_remove(struct platform_device *pdev)
 	  .data = &mt2712_ddp_driver_data},
 	{ .compatible = "mediatek,mt8173-disp-mutex",
 	  .data = &mt8173_ddp_driver_data},
+	{ .compatible = "mediatek,mt8183-disp-mutex",
+	  .data = &mt8183_ddp_driver_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ddp_driver_dt_match);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
index ed2b702..b05ed53 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
@@ -24,6 +24,7 @@ enum mtk_mmsys_id {
 	MMSYS_MT2701,
 	MMSYS_MT2712,
 	MMSYS_MT8173,
+	MMSYS_MT8183,
 	MMSYS_MAX,
 };
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index be6b142..b054654 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -191,6 +191,24 @@ static int mtk_atomic_commit(struct drm_device *drm,
 	DDP_COMPONENT_DPI0,
 };
 
+static const enum mtk_ddp_comp_id mt8183_mtk_ddp_main[] = {
+	DDP_COMPONENT_OVL0,
+	DDP_COMPONENT_OVL0_2L,
+	DDP_COMPONENT_RDMA0,
+	DDP_COMPONENT_COLOR0,
+	DDP_COMPONENT_CCORR,
+	DDP_COMPONENT_AAL0,
+	DDP_COMPONENT_GAMMA,
+	DDP_COMPONENT_DITHER,
+	DDP_COMPONENT_DSI0,
+};
+
+static const enum mtk_ddp_comp_id mt8183_mtk_ddp_ext[] = {
+	DDP_COMPONENT_OVL1_2L,
+	DDP_COMPONENT_RDMA1,
+	DDP_COMPONENT_DPI0,
+};
+
 static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
 	.main_path = mt2701_mtk_ddp_main,
 	.main_len = ARRAY_SIZE(mt2701_mtk_ddp_main),
@@ -218,6 +236,14 @@ static int mtk_atomic_commit(struct drm_device *drm,
 	.mmsys_id = MMSYS_MT8173,
 };
 
+static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
+	.main_path = mt8183_mtk_ddp_main,
+	.main_len = ARRAY_SIZE(mt8183_mtk_ddp_main),
+	.ext_path = mt8183_mtk_ddp_ext,
+	.ext_len = ARRAY_SIZE(mt8183_mtk_ddp_ext),
+	.mmsys_id = MMSYS_MT8183,
+};
+
 static int mtk_drm_kms_init(struct drm_device *drm)
 {
 	struct mtk_drm_private *private = drm->dev_private;
@@ -407,12 +433,20 @@ static void mtk_drm_unbind(struct device *dev)
 	  .data = (void *)MTK_DISP_OVL },
 	{ .compatible = "mediatek,mt8173-disp-ovl",
 	  .data = (void *)MTK_DISP_OVL },
+	{ .compatible = "mediatek,mt8183-disp-ovl",
+	  .data = (void *)MTK_DISP_OVL },
+	{ .compatible = "mediatek,mt8183-disp-ovl-2l",
+	  .data = (void *)MTK_DISP_OVL },
 	{ .compatible = "mediatek,mt2701-disp-rdma",
 	  .data = (void *)MTK_DISP_RDMA },
 	{ .compatible = "mediatek,mt8173-disp-rdma",
 	  .data = (void *)MTK_DISP_RDMA },
+	{ .compatible = "mediatek,mt8183-disp-rdma",
+	  .data = (void *)MTK_DISP_RDMA },
 	{ .compatible = "mediatek,mt8173-disp-wdma",
 	  .data = (void *)MTK_DISP_WDMA },
+	{ .compatible = "mediatek,mt8183-disp-ccorr",
+	  .data = (void *)MTK_DISP_CCORR },
 	{ .compatible = "mediatek,mt2701-disp-color",
 	  .data = (void *)MTK_DISP_COLOR },
 	{ .compatible = "mediatek,mt8173-disp-color",
@@ -421,22 +455,30 @@ static void mtk_drm_unbind(struct device *dev)
 	  .data = (void *)MTK_DISP_AAL},
 	{ .compatible = "mediatek,mt8173-disp-gamma",
 	  .data = (void *)MTK_DISP_GAMMA, },
+	{ .compatible = "mediatek,mt8183-disp-dither",
+	  .data = (void *)MTK_DISP_DITHER },
 	{ .compatible = "mediatek,mt8173-disp-ufoe",
 	  .data = (void *)MTK_DISP_UFOE },
 	{ .compatible = "mediatek,mt2701-dsi",
 	  .data = (void *)MTK_DSI },
 	{ .compatible = "mediatek,mt8173-dsi",
 	  .data = (void *)MTK_DSI },
+	{ .compatible = "mediatek,mt8183-dsi",
+	  .data = (void *)MTK_DSI },
 	{ .compatible = "mediatek,mt2701-dpi",
 	  .data = (void *)MTK_DPI },
 	{ .compatible = "mediatek,mt8173-dpi",
 	  .data = (void *)MTK_DPI },
+	{ .compatible = "mediatek,mt8183-dpi",
+	  .data = (void *)MTK_DPI },
 	{ .compatible = "mediatek,mt2701-disp-mutex",
 	  .data = (void *)MTK_DISP_MUTEX },
 	{ .compatible = "mediatek,mt2712-disp-mutex",
 	  .data = (void *)MTK_DISP_MUTEX },
 	{ .compatible = "mediatek,mt8173-disp-mutex",
 	  .data = (void *)MTK_DISP_MUTEX },
+	{ .compatible = "mediatek,mt8183-disp-mutex",
+	  .data = (void *)MTK_DISP_MUTEX },
 	{ .compatible = "mediatek,mt2701-disp-pwm",
 	  .data = (void *)MTK_DISP_BLS },
 	{ .compatible = "mediatek,mt8173-disp-pwm",
@@ -624,6 +666,8 @@ static SIMPLE_DEV_PM_OPS(mtk_drm_pm_ops, mtk_drm_sys_suspend,
 	  .data = &mt2712_mmsys_driver_data},
 	{ .compatible = "mediatek,mt8173-mmsys",
 	  .data = &mt8173_mmsys_driver_data},
+	{ .compatible = "mediatek,mt8183-display",
+	  .data = &mt8183_mmsys_driver_data},
 	{ }
 };
 
-- 
1.8.1.1.dirty

