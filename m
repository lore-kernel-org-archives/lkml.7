Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9077C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6992063F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfDHL4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:56:10 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39326 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726678AbfDHLzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:55:37 -0400
X-UUID: f7ce6149d30e44f28ce5ddc27a55c6c4-20190408
X-UUID: f7ce6149d30e44f28ce5ddc27a55c6c4-20190408
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1323180490; Mon, 08 Apr 2019 19:55:31 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 8 Apr 2019 19:55:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 8 Apr 2019 19:55:25 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Stu Hsieh <stu.hsieh@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH 06/14] [media] mtk-mipicsi: add mipicsi reg setting for mt2712
Date:   Mon, 8 Apr 2019 19:54:57 +0800
Message-ID: <1554724505-19882-7-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1554724505-19882-1-git-send-email-stu.hsieh@mediatek.com>
References: <1554724505-19882-1-git-send-email-stu.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A634257497D25F324E6F2FAC43FBA1C8C31E6314247CDC55D3E0561011F9BDEE2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add mipicsi register setting to HW for mt2712

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 .../media/platform/mtk-mipicsi/mtk_mipicsi.c  | 189 ++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
index 899cf17df480..c2f75d9b64b8 100644
--- a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
+++ b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
@@ -65,6 +65,51 @@
 #define MAX_BUFFER_NUM			32U
 #define VID_LIMIT_BYTES			(100U * 1024U * 1024U)
 
+#define MIPI_RX_ANA00_CSI				0x00
+#define MIPI_RX_ANA04_CSI				0x04
+#define MIPI_RX_ANA08_CSI				0x08
+#define MIPI_RX_ANA0C_CSI				0x0c
+#define MIPI_RX_ANA10_CSI				0x10
+#define MIPI_RX_ANA20_CSI				0x20
+#define MIPI_RX_ANA24_CSI				0x24
+#define MIPI_RX_ANA4C_CSI				0x4c
+#define MIPI_RX_ANA50_CSI				0x50
+
+#define SENINF_CTRL					0x00
+
+#define SENINF_NCSI2_CAL_24				0x24
+#define SENINF_NCSI2_CAL_38				0x38
+#define SENINF_NCSI2_CAL_3C				0x3C
+#define SENINF_NCSI2_CTL				0xA0
+#define SENINF_NCSI2_LNRD_TIMING			0xA8
+#define SENINF_NCSI2_INT_EN				0xB0
+#define SENINF_NCSI2_INT_STATUS				0xB4
+#define SENINF_NCSI2_DBG_SEL				0xB8
+#define SENINF_NCSI2_HSRX_DBG				0xD8
+#define SENINF_NCSI2_DI					0xDC
+#define SENINF_NCSI2_DI_CTRL				0xE4
+
+#define SENINF_TOP_CTRL					0x00
+#define SENINF_TOP_CMODEL_PAR				0x04
+#define SENINF_TOP_MUX					0x08
+
+#define SENINF_MUX_CTRL					0x00
+
+#define CAMSV_MODULE_EN					0x10
+#define CAMSV_FMT_SEL					0x14
+#define CAMSV_INT_EN					0x18
+#define CAMSV_CLK_EN					0x30
+
+#define CAMSV_TG_SEN_MODE				0x500
+#define CAMSV_TG_SEN_GRAB_PXL				0x508
+#define CAMSV_TG_SEN_GRAB_LIN				0x50C
+#define CAMSV_TG_PATH_CFG				0x510
+
+#define IMGO_XSIZE					0x230
+#define IMGO_YSIZE					0x234
+#define IMGO_STRIDE					0x238
+#define DMA_FRAME_HEADER_EN				0xE00
+
 #define SerDes_support 1
 
 /* buffer for one video frame */
@@ -593,6 +638,149 @@ static struct soc_camera_host_ops mtk_soc_camera_host_ops = {
 	.set_bus_param		= mtk_mipicsi_set_bus_param,
 };
 
+static void mtk_mipicsi_ana_init(void __iomem *base)
+{
+	writel(0xFEFBEFBEU & readl(base + MIPI_RX_ANA4C_CSI),
+		base + MIPI_RX_ANA4C_CSI);
+	writel(0xFEFBEFBEU & readl(base + MIPI_RX_ANA50_CSI),
+		base + MIPI_RX_ANA50_CSI);
+
+	/* clock lane and lane0-lane3 input select */
+	writel(8UL | readl(base + MIPI_RX_ANA00_CSI),
+		base + MIPI_RX_ANA00_CSI);
+	writel(8UL | readl(base + MIPI_RX_ANA04_CSI),
+		base + MIPI_RX_ANA04_CSI);
+	writel(8UL | readl(base + MIPI_RX_ANA08_CSI),
+		base + MIPI_RX_ANA08_CSI);
+	writel(8UL | readl(base + MIPI_RX_ANA0C_CSI),
+		base + MIPI_RX_ANA0C_CSI);
+	writel(8UL | readl(base + MIPI_RX_ANA10_CSI),
+		base + MIPI_RX_ANA10_CSI);
+
+	/* BG chopper clock and CSI BG enable */
+	writel(11UL | readl(base + MIPI_RX_ANA24_CSI),
+		base + MIPI_RX_ANA24_CSI);
+	mdelay(1);
+
+	/* LDO core bias enable */
+	writel(0xFF030003U | readl(base + MIPI_RX_ANA20_CSI),
+		base + MIPI_RX_ANA20_CSI);
+	mdelay(1);
+}
+
+static void mtk_mipicsi_seninf_ctrl_init(void __iomem *base)
+{
+	/*seninf enable. select NCSI2 as seninif input source */
+	writel(0x8001U, base + SENINF_CTRL);
+}
+
+static void mtk_mipicsi_seninf_init(void __iomem *base)
+{
+	writel(1U, base + SENINF_NCSI2_CAL_38);
+	writel(0x00051545U, base + SENINF_NCSI2_CAL_3C);
+	writel(5U, base + SENINF_NCSI2_CAL_38);
+	mdelay(1);
+	writel(4U, base + SENINF_NCSI2_CAL_38);
+	writel(0U, base + SENINF_NCSI2_CAL_3C);
+	writel(0x11U, base + SENINF_NCSI2_DBG_SEL);
+	writel(0x189617FU, base + SENINF_NCSI2_CTL);
+	writel(~(1UL << 27) & readl(base + SENINF_NCSI2_CTL),
+		base + SENINF_NCSI2_CTL);
+	writel((1UL << 27) | readl(base + SENINF_NCSI2_CTL),
+		base + SENINF_NCSI2_CTL);
+	writel(0x2800U, base + SENINF_NCSI2_LNRD_TIMING);
+	writel(0x7FFFU, base + SENINF_NCSI2_INT_STATUS);
+	writel(0x7FCFFFFEU, base + SENINF_NCSI2_INT_EN);
+	writel(0xE4000000U, base + SENINF_NCSI2_CAL_24);
+	writel(0xFFFFFF00U & readl(base + SENINF_NCSI2_DBG_SEL),
+		base + SENINF_NCSI2_DBG_SEL);
+	writel(0xFFFFFF45U | readl(base + SENINF_NCSI2_DBG_SEL),
+		base + SENINF_NCSI2_DBG_SEL);
+	writel(0xFFFFFFEFU & readl(base + SENINF_NCSI2_HSRX_DBG),
+		base + SENINF_NCSI2_HSRX_DBG);
+	writel(0x01010101U, base + SENINF_NCSI2_DI_CTRL);
+	writel(0x03020100U, base + SENINF_NCSI2_DI);
+	writel(0x10, base + SENINF_NCSI2_DBG_SEL);
+}
+
+static void mtk_mipicsi_seninf_top_init(struct regmap *regmap)
+{
+	(void)regmap_write(regmap, SENINF_TOP_CTRL, 0x00010C00U);
+	(void)regmap_write(regmap, SENINF_TOP_CMODEL_PAR, 0x00079871);
+	(void)regmap_write(regmap, SENINF_TOP_MUX, 0x11110000);
+}
+
+static void mtk_mipicsi_seninf_mux_init(void __iomem *base, unsigned int ch)
+{
+	unsigned int mux_ctrl_val = (((0x9EFF8U + ch) << 12U) | 0x180U);
+
+	/* select seninf_mux1-4 as input for NCSI2 VC0-3*/
+	writel(mux_ctrl_val, base + SENINF_MUX_CTRL);
+}
+
+static void mtk_mipicsi_camsv_csr_init(void __iomem *base)
+{
+	/* double buffer enable. IMGO enable. PAK sel. TG enable */
+	writel(0x40000019U, base + CAMSV_MODULE_EN);
+	/* IMGO DP, PAK DP and TG clk enable */
+	writel(0x00008005U, base + CAMSV_CLK_EN);
+	/* 0: raw8, 1:raw10, 2:raw12, 3:YUV422, 4:raw14, 7:JPEG */
+	writel(0x00000003U, base + CAMSV_FMT_SEL);
+	/* write clear enable. pass1 down interrupt enable */
+	writel(0x80000400U, base + CAMSV_INT_EN);
+}
+
+static void mtk_mipicsi_camsv_tg_init(void __iomem *base, u32 b, u32 h)
+{
+	/* bit[30:16] grab end pixel clock number.
+	 * bit[14:0] grab start pixel clock number
+	 */
+	writel(b << 16U, base + CAMSV_TG_SEN_GRAB_PXL);
+	/* bit[29:16] end line number. bit[13:0] start line number */
+	writel(h << 16U, base + CAMSV_TG_SEN_GRAB_LIN);
+	/* YUV sensor unsigned to signed enable */
+	writel(0x1000U, base + CAMSV_TG_PATH_CFG);
+	/* cmos enable YUV422 mode */
+	writel(3U, base + CAMSV_TG_SEN_MODE);
+}
+
+static void mtk_mipicsi_camsv_dma_init(void __iomem *base, u32 b, u32 h)
+{
+	/* enable SW format setting. YUV format. 16bit */
+	writel(0x01810000U | b, base + IMGO_STRIDE);
+	/* b -1 bytes per line to write */
+	writel(b - 1U, base + IMGO_XSIZE);
+	/* w - 1 lines to write */
+	writel(h - 1U, base + IMGO_YSIZE);
+	/* disable frame header function */
+	writel(0U, base + DMA_FRAME_HEADER_EN);
+}
+
+static void mtk_mipicsi_camsv_init(void __iomem *base, u32 b, u32 h)
+{
+	mtk_mipicsi_camsv_csr_init(base);
+	mtk_mipicsi_camsv_tg_init(base, b, h);
+	mtk_mipicsi_camsv_dma_init(base, b, h);
+}
+
+static void mtk_mipicsi_reg_init(struct mtk_mipicsi_dev *mipicsi)
+{
+	unsigned int i;
+
+	mtk_mipicsi_ana_init(mipicsi->ana);
+	mtk_mipicsi_seninf_ctrl_init(mipicsi->seninf_ctrl);
+	mtk_mipicsi_seninf_init(mipicsi->seninf);
+	mtk_mipicsi_seninf_top_init(mipicsi->seninf_top);
+
+	for (i = 0U; i < mipicsi->camsv_num; ++i) {
+		u32 b = mipicsi->bytesperline;
+		u32 h = mipicsi->height;
+
+		mtk_mipicsi_seninf_mux_init(mipicsi->seninf_mux[i], i);
+		mtk_mipicsi_camsv_init(mipicsi->camsv[i], b, h);
+	}
+}
+
 static int mtk_mipicsi_pm_suspend(struct device *dev)
 {
 	struct soc_camera_host *ici = to_soc_camera_host(dev);
@@ -655,6 +843,7 @@ static int mtk_mipicsi_pm_resume(struct device *dev)
 	for (i = 0; i < mipicsi->clk_num; ++i)
 		(void)clk_prepare_enable(mipicsi->clk[i]);
 
+	mtk_mipicsi_reg_init(mipicsi);
 	return ret;
 }
 
-- 
2.18.0

