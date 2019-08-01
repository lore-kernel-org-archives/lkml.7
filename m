Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40623C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FEA20B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=starry.com header.i=@starry.com header.b="bh/l0s65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388804AbfHATvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:51:19 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40429 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388633AbfHATvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:51:19 -0400
Received: by mail-qt1-f193.google.com with SMTP id a15so71516312qtn.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 12:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starry.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X7N5pzNs61dPalbIZgn+UP857QWN52RWTYQ6AeLmLi4=;
        b=bh/l0s65OYyk+VoKG4yqvv4mQVRp8XXbSPgnWmEzk5AJmaEWdxSmko55cNpV6ScA2r
         GhpYk7Xy5CzXYv3fmazO22f7tl7wwNhfApnPsH+xQTopVQ9NxgM491HeD40m0zLVGEqP
         mX2lVzE9kS5zHeokjLQ+ezqSb65Z1GA21+HX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X7N5pzNs61dPalbIZgn+UP857QWN52RWTYQ6AeLmLi4=;
        b=dFvEp3ZOiOxXp9hmR+PBaJbCxe38HQkkTy72qnKehjzmUQl6t5MHwk6ahXHTSXBWHA
         c24+3hDdiGBc+P9qXJU7oyxCiln21pWgZ8gcu4OOSonvf+AazgUlF0p50RAv2+oKiDYk
         ohvJwlbNkq4PJlx2cggw3gnoR2ggOgzmhA2/HpOqrHs/RuH4rhpIUJ9OuwQ3YfnQxfBh
         tqtWTgiBR2YtPIEb+7S9YRvRh7tZ9mnFm4xpsrqenOgH1Z5BRTQdH1kNZu0r70N625PK
         PPRAUYWCLrtuukD4/RJxnxc/gYhF4Dcr2+KpSurnh4T7ooC3P1Q8zSDsnqlR39vrVXY8
         H1lw==
X-Gm-Message-State: APjAAAVSPeUbrUVTOQDaTndoS52TFSWMROeY/nXDHNH6WSXucXe8TB3A
        a6C50m8CSOJSVesVms2k/bcg9ZrHUx8=
X-Google-Smtp-Source: APXvYqzO6LbWzavgn72G6A+0EOIfYy61hYzHBRFP7wsbENdfR8kCcy0NdKymncddMg560GDPBD6PTw==
X-Received: by 2002:ac8:6601:: with SMTP id c1mr85606991qtp.93.1564689077770;
        Thu, 01 Aug 2019 12:51:17 -0700 (PDT)
Received: from localhost.localdomain (205-201-16-55.starry-inc.net. [205.201.16.55])
        by smtp.gmail.com with ESMTPSA id h4sm31271944qkk.39.2019.08.01.12.51.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 12:51:17 -0700 (PDT)
From:   Matt Pelland <mpelland@starry.com>
To:     linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, antoine.tenart@bootlin.com,
        linux-arm-kernel@lists.infradead.org,
        Matt Pelland <mpelland@starry.com>
Subject: [PATCH 1/4] phy: marvell: phy-mvebu-cp110-comphy: implement RXAUI support
Date:   Thu,  1 Aug 2019 15:50:58 -0400
Message-Id: <20190801195059.24005-2-mpelland@starry.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801195059.24005-1-mpelland@starry.com>
References: <20190801195059.24005-1-mpelland@starry.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marvell's cp110 phy supports RXAUI on lanes 2, 3, 4, and 5 when
connected to port zero. When used in this mode, lanes operate in pairs
of two (2 and 3, 4 and 5).

Signed-off-by: Matt Pelland <mpelland@starry.com>
---
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 127 ++++++++++++++++++-
 1 file changed, 120 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
index d98e0451f6a1..f7f8d2bfd641 100644
--- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
@@ -22,6 +22,7 @@
 #define     MVEBU_COMPHY_SERDES_CFG0_PU_RX	BIT(11)
 #define     MVEBU_COMPHY_SERDES_CFG0_PU_TX	BIT(12)
 #define     MVEBU_COMPHY_SERDES_CFG0_HALF_BUS	BIT(14)
+#define     MVEBU_COMPHY_SERDES_CFG0_RXAUI_MODE	BIT(15)
 #define MVEBU_COMPHY_SERDES_CFG1(n)		(0x4 + (n) * 0x1000)
 #define     MVEBU_COMPHY_SERDES_CFG1_RESET	BIT(3)
 #define     MVEBU_COMPHY_SERDES_CFG1_RX_INIT	BIT(4)
@@ -111,6 +112,9 @@
 #define     MVEBU_COMPHY_SELECTOR_PHY(n)	((n) * 0x4)
 #define MVEBU_COMPHY_PIPE_SELECTOR		0x1144
 #define     MVEBU_COMPHY_PIPE_SELECTOR_PIPE(n)	((n) * 0x4)
+#define MVEBU_COMPHY_SD1_CTRL1			0x1148
+#define     MVEBU_COMPHY_SD1_CTRL1_RXAUI1_EN	BIT(26)
+#define     MVEBU_COMPHY_SD1_CTRL1_RXAUI0_EN	BIT(27)
 
 #define MVEBU_COMPHY_LANES	6
 #define MVEBU_COMPHY_PORTS	3
@@ -142,16 +146,20 @@ static const struct mvebu_comphy_conf mvebu_comphy_cp110_modes[] = {
 	/* lane 2 */
 	MVEBU_COMPHY_CONF(2, 0, PHY_INTERFACE_MODE_SGMII, 0x1),
 	MVEBU_COMPHY_CONF(2, 0, PHY_INTERFACE_MODE_2500BASEX, 0x1),
+	MVEBU_COMPHY_CONF(2, 0, PHY_INTERFACE_MODE_RXAUI, 0x1),
 	MVEBU_COMPHY_CONF(2, 0, PHY_INTERFACE_MODE_10GKR, 0x1),
 	/* lane 3 */
+	MVEBU_COMPHY_CONF(3, 0, PHY_INTERFACE_MODE_RXAUI, 0x1),
 	MVEBU_COMPHY_CONF(3, 1, PHY_INTERFACE_MODE_SGMII, 0x2),
 	MVEBU_COMPHY_CONF(3, 1, PHY_INTERFACE_MODE_2500BASEX, 0x2),
 	/* lane 4 */
 	MVEBU_COMPHY_CONF(4, 0, PHY_INTERFACE_MODE_SGMII, 0x2),
 	MVEBU_COMPHY_CONF(4, 0, PHY_INTERFACE_MODE_2500BASEX, 0x2),
+	MVEBU_COMPHY_CONF(4, 0, PHY_INTERFACE_MODE_RXAUI, 0x2),
 	MVEBU_COMPHY_CONF(4, 0, PHY_INTERFACE_MODE_10GKR, 0x2),
 	MVEBU_COMPHY_CONF(4, 1, PHY_INTERFACE_MODE_SGMII, 0x1),
 	/* lane 5 */
+	MVEBU_COMPHY_CONF(5, 0, PHY_INTERFACE_MODE_RXAUI, 0x2),
 	MVEBU_COMPHY_CONF(5, 2, PHY_INTERFACE_MODE_SGMII, 0x1),
 	MVEBU_COMPHY_CONF(5, 2, PHY_INTERFACE_MODE_2500BASEX, 0x1),
 };
@@ -193,7 +201,7 @@ static int mvebu_comphy_get_mux(int lane, int port,
 	return mvebu_comphy_cp110_modes[i].mux;
 }
 
-static void mvebu_comphy_ethernet_init_reset(struct mvebu_comphy_lane *lane)
+static int mvebu_comphy_ethernet_init_reset(struct mvebu_comphy_lane *lane)
 {
 	struct mvebu_comphy_priv *priv = lane->priv;
 	u32 val;
@@ -210,20 +218,61 @@ static void mvebu_comphy_ethernet_init_reset(struct mvebu_comphy_lane *lane)
 		 MVEBU_COMPHY_SERDES_CFG0_PU_TX |
 		 MVEBU_COMPHY_SERDES_CFG0_HALF_BUS |
 		 MVEBU_COMPHY_SERDES_CFG0_GEN_RX(0xf) |
-		 MVEBU_COMPHY_SERDES_CFG0_GEN_TX(0xf));
-	if (lane->submode == PHY_INTERFACE_MODE_10GKR)
+		 MVEBU_COMPHY_SERDES_CFG0_GEN_TX(0xf) |
+		 MVEBU_COMPHY_SERDES_CFG0_RXAUI_MODE);
+
+	switch (lane->submode) {
+	case PHY_INTERFACE_MODE_10GKR:
 		val |= MVEBU_COMPHY_SERDES_CFG0_GEN_RX(0xe) |
 		       MVEBU_COMPHY_SERDES_CFG0_GEN_TX(0xe);
-	else if (lane->submode == PHY_INTERFACE_MODE_2500BASEX)
+		break;
+	case PHY_INTERFACE_MODE_RXAUI:
+		val |= MVEBU_COMPHY_SERDES_CFG0_GEN_RX(0xb) |
+		       MVEBU_COMPHY_SERDES_CFG0_GEN_TX(0xb) |
+		       MVEBU_COMPHY_SERDES_CFG0_RXAUI_MODE;
+		break;
+	case PHY_INTERFACE_MODE_2500BASEX:
 		val |= MVEBU_COMPHY_SERDES_CFG0_GEN_RX(0x8) |
 		       MVEBU_COMPHY_SERDES_CFG0_GEN_TX(0x8) |
 		       MVEBU_COMPHY_SERDES_CFG0_HALF_BUS;
-	else if (lane->submode == PHY_INTERFACE_MODE_SGMII)
+		break;
+	case PHY_INTERFACE_MODE_SGMII:
 		val |= MVEBU_COMPHY_SERDES_CFG0_GEN_RX(0x6) |
 		       MVEBU_COMPHY_SERDES_CFG0_GEN_TX(0x6) |
 		       MVEBU_COMPHY_SERDES_CFG0_HALF_BUS;
+		break;
+	default:
+		dev_err(priv->dev,
+			"unsupported comphy submode (%d) on lane %d\n",
+			lane->submode,
+			lane->id);
+		return -ENOTSUPP;
+	}
+
 	writel(val, priv->base + MVEBU_COMPHY_SERDES_CFG0(lane->id));
 
+	if (lane->submode == PHY_INTERFACE_MODE_RXAUI) {
+		regmap_read(priv->regmap, MVEBU_COMPHY_SD1_CTRL1, &val);
+
+		switch (lane->id) {
+		case 2:
+		case 3:
+			val |= MVEBU_COMPHY_SD1_CTRL1_RXAUI0_EN;
+			break;
+		case 4:
+		case 5:
+			val |= MVEBU_COMPHY_SD1_CTRL1_RXAUI1_EN;
+			break;
+		default:
+			dev_err(priv->dev,
+				"RXAUI is not supported on comphy lane %d\n",
+				lane->id);
+			return -EINVAL;
+		}
+
+		regmap_write(priv->regmap, MVEBU_COMPHY_SD1_CTRL1, val);
+	}
+
 	/* reset */
 	val = readl(priv->base + MVEBU_COMPHY_SERDES_CFG1(lane->id));
 	val &= ~(MVEBU_COMPHY_SERDES_CFG1_RESET |
@@ -264,6 +313,8 @@ static void mvebu_comphy_ethernet_init_reset(struct mvebu_comphy_lane *lane)
 	val &= ~MVEBU_COMPHY_LOOPBACK_DBUS_WIDTH(0x7);
 	val |= MVEBU_COMPHY_LOOPBACK_DBUS_WIDTH(0x1);
 	writel(val, priv->base + MVEBU_COMPHY_LOOPBACK(lane->id));
+
+	return 0;
 }
 
 static int mvebu_comphy_init_plls(struct mvebu_comphy_lane *lane)
@@ -312,8 +363,11 @@ static int mvebu_comphy_set_mode_sgmii(struct phy *phy)
 	struct mvebu_comphy_lane *lane = phy_get_drvdata(phy);
 	struct mvebu_comphy_priv *priv = lane->priv;
 	u32 val;
+	int err;
 
-	mvebu_comphy_ethernet_init_reset(lane);
+	err = mvebu_comphy_ethernet_init_reset(lane);
+	if (err)
+		return err;
 
 	val = readl(priv->base + MVEBU_COMPHY_RX_CTRL1(lane->id));
 	val &= ~MVEBU_COMPHY_RX_CTRL1_CLK8T_EN;
@@ -337,13 +391,69 @@ static int mvebu_comphy_set_mode_sgmii(struct phy *phy)
 	return mvebu_comphy_init_plls(lane);
 }
 
+static int mvebu_comphy_set_mode_rxaui(struct phy *phy)
+{
+	struct mvebu_comphy_lane *lane = phy_get_drvdata(phy);
+	struct mvebu_comphy_priv *priv = lane->priv;
+	u32 val;
+	int err;
+
+	err = mvebu_comphy_ethernet_init_reset(lane);
+	if (err)
+		return err;
+
+	val = readl(priv->base + MVEBU_COMPHY_RX_CTRL1(lane->id));
+	val |= MVEBU_COMPHY_RX_CTRL1_RXCLK2X_SEL |
+	       MVEBU_COMPHY_RX_CTRL1_CLK8T_EN;
+	writel(val, priv->base + MVEBU_COMPHY_RX_CTRL1(lane->id));
+
+	val = readl(priv->base + MVEBU_COMPHY_DLT_CTRL(lane->id));
+	val |= MVEBU_COMPHY_DLT_CTRL_DLT_FLOOP_EN;
+	writel(val, priv->base + MVEBU_COMPHY_DLT_CTRL(lane->id));
+
+	val = readl(priv->base + MVEBU_COMPHY_SERDES_CFG2(lane->id));
+	val |= MVEBU_COMPHY_SERDES_CFG2_DFE_EN;
+	writel(val, priv->base + MVEBU_COMPHY_SERDES_CFG2(lane->id));
+
+	val = readl(priv->base + MVEBU_COMPHY_DFE_RES(lane->id));
+	val |= MVEBU_COMPHY_DFE_RES_FORCE_GEN_TBL;
+	writel(val, priv->base + MVEBU_COMPHY_DFE_RES(lane->id));
+
+	val = readl(priv->base + MVEBU_COMPHY_GEN1_S0(lane->id));
+	val &= ~MVEBU_COMPHY_GEN1_S0_TX_EMPH(0xf);
+	val |= MVEBU_COMPHY_GEN1_S0_TX_EMPH(0xd);
+	writel(val, priv->base + MVEBU_COMPHY_GEN1_S0(lane->id));
+
+	val = readl(priv->base + MVEBU_COMPHY_GEN1_S1(lane->id));
+	val &= ~(MVEBU_COMPHY_GEN1_S1_RX_MUL_PI(0x7) |
+		 MVEBU_COMPHY_GEN1_S1_RX_MUL_PF(0x7));
+	val |= MVEBU_COMPHY_GEN1_S1_RX_MUL_PI(0x1) |
+	       MVEBU_COMPHY_GEN1_S1_RX_MUL_PF(0x1) |
+	       MVEBU_COMPHY_GEN1_S1_RX_DFE_EN;
+	writel(val, priv->base + MVEBU_COMPHY_GEN1_S1(lane->id));
+
+	val = readl(priv->base + MVEBU_COMPHY_COEF(lane->id));
+	val &= ~(MVEBU_COMPHY_COEF_DFE_EN | MVEBU_COMPHY_COEF_DFE_CTRL);
+	writel(val, priv->base + MVEBU_COMPHY_COEF(lane->id));
+
+	val = readl(priv->base + MVEBU_COMPHY_GEN1_S4(lane->id));
+	val &= ~MVEBU_COMPHY_GEN1_S4_DFE_RES(0x3);
+	val |= MVEBU_COMPHY_GEN1_S4_DFE_RES(0x1);
+	writel(val, priv->base + MVEBU_COMPHY_GEN1_S4(lane->id));
+
+	return mvebu_comphy_init_plls(lane);
+}
+
 static int mvebu_comphy_set_mode_10gkr(struct phy *phy)
 {
 	struct mvebu_comphy_lane *lane = phy_get_drvdata(phy);
 	struct mvebu_comphy_priv *priv = lane->priv;
 	u32 val;
+	int err;
 
-	mvebu_comphy_ethernet_init_reset(lane);
+	err = mvebu_comphy_ethernet_init_reset(lane);
+	if (err)
+		return err;
 
 	val = readl(priv->base + MVEBU_COMPHY_RX_CTRL1(lane->id));
 	val |= MVEBU_COMPHY_RX_CTRL1_RXCLK2X_SEL |
@@ -502,6 +612,9 @@ static int mvebu_comphy_power_on(struct phy *phy)
 	case PHY_INTERFACE_MODE_2500BASEX:
 		ret = mvebu_comphy_set_mode_sgmii(phy);
 		break;
+	case PHY_INTERFACE_MODE_RXAUI:
+		ret = mvebu_comphy_set_mode_rxaui(phy);
+		break;
 	case PHY_INTERFACE_MODE_10GKR:
 		ret = mvebu_comphy_set_mode_10gkr(phy);
 		break;
-- 
2.21.0

