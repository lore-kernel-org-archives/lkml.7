Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16618C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6B82084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="k7N+9lWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfCYOSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:18:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34378 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbfCYOSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:18:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so10393856wrq.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 07:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WVOVDIAJ9jCj5O9l7AbR/9+NkQcoba7DP+SBL3LY7oM=;
        b=k7N+9lWt+R8lLJsMcIYVZyeslZvQy45OodH/XY8SBvhEb7lv8VbE+qdKM69aCqJDWC
         O742LBHhddcYUvfVq+lDkEcpF5hbAOaCOji/J6FC0Xg+AwS4ypqnPfHCATcL7mpmO8mM
         sQBhOk13NZ9J2uTp3fNqUKO4Y4Ue5kgZ8ma9wGMa0fVsd4Y55x4qPCj8/A/KNTwYlBnD
         1EhtnSDBGYs32TFlRDLC3IEEzGbORg3lPGiDcE2nw7MW7Vni2H3xy8TyuU3IfVBwHTZW
         yJW5Bu5yGSka2M5dycHbOCFds46dpv4aMVNwC55yaouJuM4T0sHs0tzybKs1DZ95Hjdm
         /XCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WVOVDIAJ9jCj5O9l7AbR/9+NkQcoba7DP+SBL3LY7oM=;
        b=ZXX86y2LT0zqKgIkNy5xfb4NhkutWDVCs9ufRlf7c/ciROP8P7kws5psYkpx4g26Lb
         LxNBhw8KiIbSQdbmD2Vy3vSgwFmClxXQAdcycZG8sslvfMgWWuRlJPwk+5LNKzAvb/dI
         Yu2ig/s2PZ0Gf0IYfIEzBmbciQABrnStt9GW98Jkdqh8gApH6E2GeafY8VL08yzXfQp2
         sAvFgMvlPNT7g3KHCdgIcQeuhkhSJ6Uw1zynN1BdTXIEVa05t+kVMiv/XPkwTKnFefqo
         OBYW1NtxzyjV/uOQEOdiJX2tAIm/hRb3VTH4hsCc/aepl/0NpTgMzzeKPuuqLBEJRGih
         3o8A==
X-Gm-Message-State: APjAAAX7RemthZcAT7j24fLmTx1kvg1J230cKLao/V/3p7uK8fJ22rxG
        24BJw9wat9llUsrZOBvVP2OCNQ==
X-Google-Smtp-Source: APXvYqy6Fj/205OaiaZiU1Up72Ak5oklMelTrtVWUf9LUOPdgXvikewYorH557Bn5ws+2+8noNmwWg==
X-Received: by 2002:a5d:4a8d:: with SMTP id o13mr15159121wrq.209.1553523520654;
        Mon, 25 Mar 2019 07:18:40 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id 132sm26976794wmd.30.2019.03.25.07.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 07:18:40 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] drm/meson: Add G12A support for the DW-HDMI Glue
Date:   Mon, 25 Mar 2019 15:18:24 +0100
Message-Id: <20190325141824.21259-12-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325141824.21259-1-narmstrong@baylibre.com>
References: <20190325141824.21259-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A embeds the same Synopsys DW-HDMI Controller,
but with :
- a "backport" of the HDR signaling registers from more recent
  DW-HDMI controllers, this will need a tweak since it's not
  normally present on this version of the DW-HDMI controller
- A direct mapping of TOP and DW-HDMI registers instead of an
  internal bus accessed using read/write registers
- Support for RX-SENSE, but not yet implemented
- Support for HDMI 2.1 Dynamic HDR, but not yet implemented
- Different registers mapping for the HDMI PHY setup

This patchs adds support for these changes while providing exact
same support as the previous GXBB, GXL & GXM SoCs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 163 ++++++++++++++++++++------
 drivers/gpu/drm/meson/meson_dw_hdmi.h |  32 ++++-
 2 files changed, 157 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 563953ec6ad0..779da21143b9 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/component.h>
+#include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/reset.h>
 #include <linux/clk.h>
@@ -105,6 +106,7 @@
 #define HDMITX_TOP_ADDR_REG	0x0
 #define HDMITX_TOP_DATA_REG	0x4
 #define HDMITX_TOP_CTRL_REG	0x8
+#define HDMITX_TOP_G12A_OFFSET	0x8000
 
 /* Controller Communication Channel */
 #define HDMITX_DWC_ADDR_REG	0x10
@@ -118,6 +120,8 @@
 #define HHI_HDMI_PHY_CNTL1	0x3a4 /* 0xe9 */
 #define HHI_HDMI_PHY_CNTL2	0x3a8 /* 0xea */
 #define HHI_HDMI_PHY_CNTL3	0x3ac /* 0xeb */
+#define HHI_HDMI_PHY_CNTL4	0x3b0 /* 0xec */
+#define HHI_HDMI_PHY_CNTL5	0x3b4 /* 0xed */
 
 static DEFINE_SPINLOCK(reg_lock);
 
@@ -127,12 +131,26 @@ enum meson_venc_source {
 	MESON_VENC_SOURCE_ENCP = 2,
 };
 
+struct meson_dw_hdmi;
+
+struct meson_dw_hdmi_data {
+	unsigned int	(*top_read)(struct meson_dw_hdmi *dw_hdmi,
+				    unsigned int addr);
+	void		(*top_write)(struct meson_dw_hdmi *dw_hdmi,
+				     unsigned int addr, unsigned int data);
+	unsigned int	(*dwc_read)(struct meson_dw_hdmi *dw_hdmi,
+				    unsigned int addr);
+	void		(*dwc_write)(struct meson_dw_hdmi *dw_hdmi,
+				     unsigned int addr, unsigned int data);
+};
+
 struct meson_dw_hdmi {
 	struct drm_encoder encoder;
 	struct dw_hdmi_plat_data dw_plat_data;
 	struct meson_drm *priv;
 	struct device *dev;
 	void __iomem *hdmitx;
+	const struct meson_dw_hdmi_data *data;
 	struct reset_control *hdmitx_apb;
 	struct reset_control *hdmitx_ctrl;
 	struct reset_control *hdmitx_phy;
@@ -174,6 +192,12 @@ static unsigned int dw_hdmi_top_read(struct meson_dw_hdmi *dw_hdmi,
 	return data;
 }
 
+static unsigned int dw_hdmi_g12a_top_read(struct meson_dw_hdmi *dw_hdmi,
+					  unsigned int addr)
+{
+	return readl(dw_hdmi->hdmitx + HDMITX_TOP_G12A_OFFSET + (addr << 2));
+}
+
 static inline void dw_hdmi_top_write(struct meson_dw_hdmi *dw_hdmi,
 				     unsigned int addr, unsigned int data)
 {
@@ -191,18 +215,24 @@ static inline void dw_hdmi_top_write(struct meson_dw_hdmi *dw_hdmi,
 	spin_unlock_irqrestore(&reg_lock, flags);
 }
 
+static inline void dw_hdmi_g12a_top_write(struct meson_dw_hdmi *dw_hdmi,
+					  unsigned int addr, unsigned int data)
+{
+	writel(data, dw_hdmi->hdmitx + HDMITX_TOP_G12A_OFFSET + (addr << 2));
+}
+
 /* Helper to change specific bits in PHY registers */
 static inline void dw_hdmi_top_write_bits(struct meson_dw_hdmi *dw_hdmi,
 					  unsigned int addr,
 					  unsigned int mask,
 					  unsigned int val)
 {
-	unsigned int data = dw_hdmi_top_read(dw_hdmi, addr);
+	unsigned int data = dw_hdmi->data->top_read(dw_hdmi, addr);
 
 	data &= ~mask;
 	data |= val;
 
-	dw_hdmi_top_write(dw_hdmi, addr, data);
+	dw_hdmi->data->top_write(dw_hdmi, addr, data);
 }
 
 static unsigned int dw_hdmi_dwc_read(struct meson_dw_hdmi *dw_hdmi,
@@ -226,6 +256,12 @@ static unsigned int dw_hdmi_dwc_read(struct meson_dw_hdmi *dw_hdmi,
 	return data;
 }
 
+static unsigned int dw_hdmi_g12a_dwc_read(struct meson_dw_hdmi *dw_hdmi,
+					  unsigned int addr)
+{
+	return readb(dw_hdmi->hdmitx + addr);
+}
+
 static inline void dw_hdmi_dwc_write(struct meson_dw_hdmi *dw_hdmi,
 				     unsigned int addr, unsigned int data)
 {
@@ -243,18 +279,24 @@ static inline void dw_hdmi_dwc_write(struct meson_dw_hdmi *dw_hdmi,
 	spin_unlock_irqrestore(&reg_lock, flags);
 }
 
+static inline void dw_hdmi_g12a_dwc_write(struct meson_dw_hdmi *dw_hdmi,
+					  unsigned int addr, unsigned int data)
+{
+	writeb(data, dw_hdmi->hdmitx + addr);
+}
+
 /* Helper to change specific bits in controller registers */
 static inline void dw_hdmi_dwc_write_bits(struct meson_dw_hdmi *dw_hdmi,
 					  unsigned int addr,
 					  unsigned int mask,
 					  unsigned int val)
 {
-	unsigned int data = dw_hdmi_dwc_read(dw_hdmi, addr);
+	unsigned int data = dw_hdmi->data->dwc_read(dw_hdmi, addr);
 
 	data &= ~mask;
 	data |= val;
 
-	dw_hdmi_dwc_write(dw_hdmi, addr, data);
+	dw_hdmi->data->dwc_write(dw_hdmi, addr, data);
 }
 
 /* Bridge */
@@ -300,6 +342,24 @@ static void meson_hdmi_phy_setup_mode(struct meson_dw_hdmi *dw_hdmi,
 			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, 0x33632122);
 			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL3, 0x2000115b);
 		}
+	} else if (dw_hdmi_is_compatible(dw_hdmi,
+					 "amlogic,meson-g12a-dw-hdmi")) {
+		if (pixel_clock >= 371250) {
+			/* 5.94Gbps, 3.7125Gbps */
+			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, 0x37eb65c4);
+			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL3, 0x2ab0ff3b);
+			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL5, 0x0000080b);
+		} else if (pixel_clock >= 297000) {
+			/* 2.97Gbps */
+			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, 0x33eb6262);
+			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL3, 0x2ab0ff3b);
+			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL5, 0x00000003);
+		} else {
+			/* 1.485Gbps, and below */
+			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0, 0x33eb4242);
+			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL3, 0x2ab0ff3b);
+			regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL5, 0x00000003);
+		}
 	}
 }
 
@@ -375,7 +435,7 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
 	regmap_update_bits(priv->hhi, HHI_MEM_PD_REG0, 0xff << 8, 0);
 
 	/* Bring out of reset */
-	dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_SW_RESET,  0);
+	dw_hdmi->data->top_write(dw_hdmi, HDMITX_TOP_SW_RESET,  0);
 
 	/* Enable internal pixclk, tmds_clk, spdif_clk, i2s_clk, cecclk */
 	dw_hdmi_top_write_bits(dw_hdmi, HDMITX_TOP_CLK_CNTL,
@@ -384,24 +444,25 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
 			       0x3 << 4, 0x3 << 4);
 
 	/* Enable normal output to PHY */
-	dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_BIST_CNTL, BIT(12));
+	dw_hdmi->data->top_write(dw_hdmi, HDMITX_TOP_BIST_CNTL, BIT(12));
 
 	/* TMDS pattern setup (TOFIX Handle the YUV420 case) */
 	if (mode->clock > 340000) {
-		dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_01, 0);
-		dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_23,
+		dw_hdmi->data->top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_01,
+				  0);
+		dw_hdmi->data->top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_23,
 				  0x03ff03ff);
 	} else {
-		dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_01,
+		dw_hdmi->data->top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_01,
 				  0x001f001f);
-		dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_23,
+		dw_hdmi->data->top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_23,
 				  0x001f001f);
 	}
 
 	/* Load TMDS pattern */
-	dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_CNTL, 0x1);
+	dw_hdmi->data->top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_CNTL, 0x1);
 	msleep(20);
-	dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_CNTL, 0x2);
+	dw_hdmi->data->top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_CNTL, 0x2);
 
 	/* Setup PHY parameters */
 	meson_hdmi_phy_setup_mode(dw_hdmi, mode);
@@ -412,7 +473,8 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
 
 	/* BIT_INVERT */
 	if (dw_hdmi_is_compatible(dw_hdmi, "amlogic,meson-gxl-dw-hdmi") ||
-	    dw_hdmi_is_compatible(dw_hdmi, "amlogic,meson-gxm-dw-hdmi"))
+	    dw_hdmi_is_compatible(dw_hdmi, "amlogic,meson-gxm-dw-hdmi") ||
+	    dw_hdmi_is_compatible(dw_hdmi, "amlogic,meson-g12a-dw-hdmi"))
 		regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1,
 				   BIT(17), 0);
 	else
@@ -480,7 +542,7 @@ static enum drm_connector_status dw_hdmi_read_hpd(struct dw_hdmi *hdmi,
 {
 	struct meson_dw_hdmi *dw_hdmi = (struct meson_dw_hdmi *)data;
 
-	return !!dw_hdmi_top_read(dw_hdmi, HDMITX_TOP_STAT0) ?
+	return !!dw_hdmi->data->top_read(dw_hdmi, HDMITX_TOP_STAT0) ?
 		connector_status_connected : connector_status_disconnected;
 }
 
@@ -490,11 +552,11 @@ static void dw_hdmi_setup_hpd(struct dw_hdmi *hdmi,
 	struct meson_dw_hdmi *dw_hdmi = (struct meson_dw_hdmi *)data;
 
 	/* Setup HPD Filter */
-	dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_HPD_FILTER,
+	dw_hdmi->data->top_write(dw_hdmi, HDMITX_TOP_HPD_FILTER,
 			  (0xa << 12) | 0xa0);
 
 	/* Clear interrupts */
-	dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_INTR_STAT_CLR,
+	dw_hdmi->data->top_write(dw_hdmi, HDMITX_TOP_INTR_STAT_CLR,
 			  HDMITX_TOP_INTR_HPD_RISE | HDMITX_TOP_INTR_HPD_FALL);
 
 	/* Unmask interrupts */
@@ -515,8 +577,8 @@ static irqreturn_t dw_hdmi_top_irq(int irq, void *dev_id)
 	struct meson_dw_hdmi *dw_hdmi = dev_id;
 	u32 stat;
 
-	stat = dw_hdmi_top_read(dw_hdmi, HDMITX_TOP_INTR_STAT);
-	dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_INTR_STAT_CLR, stat);
+	stat = dw_hdmi->data->top_read(dw_hdmi, HDMITX_TOP_INTR_STAT);
+	dw_hdmi->data->top_write(dw_hdmi, HDMITX_TOP_INTR_STAT_CLR, stat);
 
 	/* HPD Events, handle in the threaded interrupt handler */
 	if (stat & (HDMITX_TOP_INTR_HPD_RISE | HDMITX_TOP_INTR_HPD_FALL)) {
@@ -686,7 +748,9 @@ static const struct drm_encoder_helper_funcs
 static int meson_dw_hdmi_reg_read(void *context, unsigned int reg,
 				  unsigned int *result)
 {
-	*result = dw_hdmi_dwc_read(context, reg);
+	struct meson_dw_hdmi *dw_hdmi = context;
+
+	*result = dw_hdmi->data->dwc_read(dw_hdmi, reg);
 
 	return 0;
 
@@ -695,7 +759,9 @@ static int meson_dw_hdmi_reg_read(void *context, unsigned int reg,
 static int meson_dw_hdmi_reg_write(void *context, unsigned int reg,
 				   unsigned int val)
 {
-	dw_hdmi_dwc_write(context, reg, val);
+	struct meson_dw_hdmi *dw_hdmi = context;
+
+	dw_hdmi->data->dwc_write(dw_hdmi, reg, val);
 
 	return 0;
 }
@@ -709,6 +775,20 @@ static const struct regmap_config meson_dw_hdmi_regmap_config = {
 	.fast_io = true,
 };
 
+static const struct meson_dw_hdmi_data meson_dw_hdmi_gx_data = {
+	.top_read = dw_hdmi_top_read,
+	.top_write = dw_hdmi_top_write,
+	.dwc_read = dw_hdmi_dwc_read,
+	.dwc_write = dw_hdmi_dwc_write,
+};
+
+static const struct meson_dw_hdmi_data meson_dw_hdmi_g12a_data = {
+	.top_read = dw_hdmi_g12a_top_read,
+	.top_write = dw_hdmi_g12a_top_write,
+	.dwc_read = dw_hdmi_g12a_dwc_read,
+	.dwc_write = dw_hdmi_g12a_dwc_write,
+};
+
 static bool meson_hdmi_connector_is_available(struct device *dev)
 {
 	struct device_node *ep, *remote;
@@ -735,6 +815,7 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 				void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
+	const struct meson_dw_hdmi_data *match;
 	struct meson_dw_hdmi *meson_dw_hdmi;
 	struct drm_device *drm = data;
 	struct meson_drm *priv = drm->dev_private;
@@ -751,6 +832,12 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 		return -ENODEV;
 	}
 
+	match = of_device_get_match_data(&pdev->dev);
+	if (!match) {
+		dev_err(&pdev->dev, "failed to get match data\n");
+		return -ENODEV;
+	}
+
 	meson_dw_hdmi = devm_kzalloc(dev, sizeof(*meson_dw_hdmi),
 				     GFP_KERNEL);
 	if (!meson_dw_hdmi)
@@ -758,6 +845,7 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 
 	meson_dw_hdmi->priv = priv;
 	meson_dw_hdmi->dev = dev;
+	meson_dw_hdmi->data = match;
 	dw_plat_data = &meson_dw_hdmi->dw_plat_data;
 	encoder = &meson_dw_hdmi->encoder;
 
@@ -858,24 +946,28 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	reset_control_reset(meson_dw_hdmi->hdmitx_phy);
 
 	/* Enable APB3 fail on error */
-	writel_bits_relaxed(BIT(15), BIT(15),
-			    meson_dw_hdmi->hdmitx + HDMITX_TOP_CTRL_REG);
-	writel_bits_relaxed(BIT(15), BIT(15),
-			    meson_dw_hdmi->hdmitx + HDMITX_DWC_CTRL_REG);
+	if (!meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
+		writel_bits_relaxed(BIT(15), BIT(15),
+				    meson_dw_hdmi->hdmitx + HDMITX_TOP_CTRL_REG);
+		writel_bits_relaxed(BIT(15), BIT(15),
+				    meson_dw_hdmi->hdmitx + HDMITX_DWC_CTRL_REG);
+	}
 
 	/* Bring out of reset */
-	dw_hdmi_top_write(meson_dw_hdmi, HDMITX_TOP_SW_RESET,  0);
+	meson_dw_hdmi->data->top_write(meson_dw_hdmi,
+				       HDMITX_TOP_SW_RESET,  0);
 
 	msleep(20);
 
-	dw_hdmi_top_write(meson_dw_hdmi, HDMITX_TOP_CLK_CNTL, 0xff);
+	meson_dw_hdmi->data->top_write(meson_dw_hdmi,
+				       HDMITX_TOP_CLK_CNTL, 0xff);
 
 	/* Enable HDMI-TX Interrupt */
-	dw_hdmi_top_write(meson_dw_hdmi, HDMITX_TOP_INTR_STAT_CLR,
-			  HDMITX_TOP_INTR_CORE);
+	meson_dw_hdmi->data->top_write(meson_dw_hdmi, HDMITX_TOP_INTR_STAT_CLR,
+				       HDMITX_TOP_INTR_CORE);
 
-	dw_hdmi_top_write(meson_dw_hdmi, HDMITX_TOP_INTR_MASKN,
-			  HDMITX_TOP_INTR_CORE);
+	meson_dw_hdmi->data->top_write(meson_dw_hdmi, HDMITX_TOP_INTR_MASKN,
+				       HDMITX_TOP_INTR_CORE);
 
 	/* Bridge / Connector */
 
@@ -924,9 +1016,14 @@ static int meson_dw_hdmi_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id meson_dw_hdmi_of_table[] = {
-	{ .compatible = "amlogic,meson-gxbb-dw-hdmi" },
-	{ .compatible = "amlogic,meson-gxl-dw-hdmi" },
-	{ .compatible = "amlogic,meson-gxm-dw-hdmi" },
+	{ .compatible = "amlogic,meson-gxbb-dw-hdmi",
+	  .data = &meson_dw_hdmi_gx_data },
+	{ .compatible = "amlogic,meson-gxl-dw-hdmi",
+	  .data = &meson_dw_hdmi_gx_data },
+	{ .compatible = "amlogic,meson-gxm-dw-hdmi",
+	  .data = &meson_dw_hdmi_gx_data },
+	{ .compatible = "amlogic,meson-g12a-dw-hdmi",
+	  .data = &meson_dw_hdmi_g12a_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, meson_dw_hdmi_of_table);
diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.h b/drivers/gpu/drm/meson/meson_dw_hdmi.h
index 0b81183125e3..03e2f0c1a2d5 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.h
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.h
@@ -21,9 +21,12 @@
 #define __MESON_DW_HDMI_H
 
 /*
- * Bit 7 RW Reserved. Default 1.
- * Bit 6 RW Reserved. Default 1.
- * Bit 5 RW Reserved. Default 1.
+ * Bit 15-10: RW Reserved. Default 1 starting from G12A
+ * Bit 9 RW sw_reset_i2c starting from G12A
+ * Bit 8 RW sw_reset_axiarb starting from G12A
+ * Bit 7 RW Reserved. Default 1, sw_reset_emp starting from G12A
+ * Bit 6 RW Reserved. Default 1, sw_reset_flt starting from G12A
+ * Bit 5 RW Reserved. Default 1, sw_reset_hdcp22 starting from G12A
  * Bit 4 RW sw_reset_phyif: PHY interface. 1=Apply reset; 0=Release from reset.
  *     Default 1.
  * Bit 3 RW sw_reset_intr: interrupt module. 1=Apply reset;
@@ -39,12 +42,16 @@
 #define HDMITX_TOP_SW_RESET                     (0x000)
 
 /*
+ * Bit 31 RW free_clk_en: 0=Enable clock gating for power saving; 1= Disable
  * Bit 12 RW i2s_ws_inv:1=Invert i2s_ws; 0=No invert. Default 0.
  * Bit 11 RW i2s_clk_inv: 1=Invert i2s_clk; 0=No invert. Default 0.
  * Bit 10 RW spdif_clk_inv: 1=Invert spdif_clk; 0=No invert. Default 0.
  * Bit 9 RW tmds_clk_inv: 1=Invert tmds_clk; 0=No invert. Default 0.
  * Bit 8 RW pixel_clk_inv: 1=Invert pixel_clk; 0=No invert. Default 0.
- * Bit 4 RW cec_clk_en: 1=enable cec_clk; 0=disable. Default 0.
+ * Bit 7 RW hdcp22_skpclk_en: starting from G12A, 1=enable; 0=disable
+ * Bit 6 RW hdcp22_esmclk_en: starting from G12A, 1=enable; 0=disable
+ * Bit 5 RW hdcp22_tmdsclk_en: starting from G12A, 1=enable; 0=disable
+ * Bit 4 RW cec_clk_en: 1=enable cec_clk; 0=disable. Default 0. Reserved for G12A
  * Bit 3 RW i2s_clk_en: 1=enable i2s_clk; 0=disable. Default 0.
  * Bit 2 RW spdif_clk_en: 1=enable spdif_clk; 0=disable. Default 0.
  * Bit 1 RW tmds_clk_en: 1=enable tmds_clk;  0=disable. Default 0.
@@ -53,6 +60,8 @@
 #define HDMITX_TOP_CLK_CNTL                     (0x001)
 
 /*
+ * Bit 31:28 RW rxsense_glitch_width: starting from G12A
+ * Bit 27:16 RW rxsense_valid_width: starting from G12A
  * Bit 11: 0 RW hpd_valid_width: filter out width <= M*1024.    Default 0.
  * Bit 15:12 RW hpd_glitch_width: filter out glitch <= N.       Default 0.
  */
@@ -61,6 +70,9 @@
 /*
  * intr_maskn: MASK_N, one bit per interrupt source.
  *     1=Enable interrupt source; 0=Disable interrupt source. Default 0.
+ * [  7] rxsense_fall starting from G12A
+ * [  6] rxsense_rise starting from G12A
+ * [  5] err_i2c_timeout starting from G12A
  * [  4] hdcp22_rndnum_err
  * [  3] nonce_rfrsh_rise
  * [  2] hpd_fall_intr
@@ -73,6 +85,9 @@
  * Bit 30: 0 RW intr_stat: For each bit, write 1 to manually set the interrupt
  *     bit, read back the interrupt status.
  * Bit    31 R  IP interrupt status
+ * Bit     7 RW rxsense_fall starting from G12A
+ * Bit     6 RW rxsense_rise starting from G12A
+ * Bit     5 RW err_i2c_timeout starting from G12A
  * Bit     2 RW hpd_fall
  * Bit     1 RW hpd_rise
  * Bit     0 RW IP interrupt
@@ -80,6 +95,9 @@
 #define HDMITX_TOP_INTR_STAT                    (0x004)
 
 /*
+ * [7]    rxsense_fall starting from G12A
+ * [6]    rxsense_rise starting from G12A
+ * [5]    err_i2c_timeout starting from G12A
  * [4]	  hdcp22_rndnum_err
  * [3]	  nonce_rfrsh_rise
  * [2]	  hpd_fall
@@ -91,6 +109,8 @@
 #define HDMITX_TOP_INTR_CORE		BIT(0)
 #define HDMITX_TOP_INTR_HPD_RISE	BIT(1)
 #define HDMITX_TOP_INTR_HPD_FALL	BIT(2)
+#define HDMITX_TOP_INTR_RXSENSE_RISE	BIT(6)
+#define HDMITX_TOP_INTR_RXSENSE_FALL	BIT(7)
 
 /* Bit 14:12 RW tmds_sel: 3'b000=Output zero; 3'b001=Output normal TMDS data;
  *     3'b010=Output PRBS data; 3'b100=Output shift pattern. Default 0.
@@ -140,7 +160,9 @@
  */
 #define HDMITX_TOP_REVOCMEM_STAT                (0x00D)
 
-/* Bit     0 R  filtered HPD status. */
+/* Bit	   1 R	filtered RxSense status
+ * Bit     0 R  filtered HPD status.
+ */
 #define HDMITX_TOP_STAT0                        (0x00E)
 
 #endif /* __MESON_DW_HDMI_H */
-- 
2.21.0

