Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6FFC5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0A420659
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbfKFL1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 06:27:21 -0500
Received: from gloria.sntech.de ([185.11.138.130]:53222 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfKFL1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 06:27:21 -0500
Received: from [94.134.91.181] (helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko.stuebner@theobroma-systems.com>)
        id 1iSJSo-0004nK-SH; Wed, 06 Nov 2019 12:27:02 +0100
From:   Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
To:     dri-devel@lists.freedesktop.org, a.hajda@samsung.com
Cc:     hjc@rock-chips.com, robh+dt@kernel.org, mark.rutland@arm.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, philippe.cornu@st.com,
        yannick.fertre@st.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        heiko@sntech.de, christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH 3/3] drm/rockchip: dsi: add px30 support
Date:   Wed,  6 Nov 2019 12:26:50 +0100
Message-Id: <20191106112650.8365-3-heiko.stuebner@theobroma-systems.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106112650.8365-1-heiko.stuebner@theobroma-systems.com>
References: <20191106112650.8365-1-heiko.stuebner@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible and GRF definitions for the PX30 soc.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 99ec625e0448..aeadeda0febc 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -140,6 +140,12 @@
 #define DW_MIPI_NEEDS_PHY_CFG_CLK	BIT(0)
 #define DW_MIPI_NEEDS_GRF_CLK		BIT(1)
 
+#define PX30_GRF_PD_VO_CON1		0x0438
+#define PX30_DSI_FORCETXSTOPMODE	(0xf << 7)
+#define PX30_DSI_FORCERXMODE		BIT(6)
+#define PX30_DSI_TURNDISABLE		BIT(5)
+#define PX30_DSI_LCDC_SEL		BIT(0)
+
 #define RK3288_GRF_SOC_CON6		0x025c
 #define RK3288_DSI0_LCDC_SEL		BIT(6)
 #define RK3288_DSI1_LCDC_SEL		BIT(9)
@@ -1039,6 +1045,24 @@ static int dw_mipi_dsi_rockchip_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct rockchip_dw_dsi_chip_data px30_chip_data[] = {
+	{
+		.reg = 0xff450000,
+		.lcdsel_grf_reg = PX30_GRF_PD_VO_CON1,
+		.lcdsel_big = HIWORD_UPDATE(0, PX30_DSI_LCDC_SEL),
+		.lcdsel_lit = HIWORD_UPDATE(PX30_DSI_LCDC_SEL,
+					    PX30_DSI_LCDC_SEL),
+
+		.lanecfg1_grf_reg = PX30_GRF_PD_VO_CON1,
+		.lanecfg1 = HIWORD_UPDATE(0, PX30_DSI_TURNDISABLE |
+					     PX30_DSI_FORCERXMODE |
+					     PX30_DSI_FORCETXSTOPMODE),
+
+		.max_data_lanes = 4,
+	},
+	{ /* sentinel */ }
+};
+
 static const struct rockchip_dw_dsi_chip_data rk3288_chip_data[] = {
 	{
 		.reg = 0xff960000,
@@ -1107,6 +1131,9 @@ static const struct rockchip_dw_dsi_chip_data rk3399_chip_data[] = {
 
 static const struct of_device_id dw_mipi_dsi_rockchip_dt_ids[] = {
 	{
+	 .compatible = "rockchip,px30-mipi-dsi",
+	 .data = &px30_chip_data,
+	}, {
 	 .compatible = "rockchip,rk3288-mipi-dsi",
 	 .data = &rk3288_chip_data,
 	}, {
-- 
2.23.0

