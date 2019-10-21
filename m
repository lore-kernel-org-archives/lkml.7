Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0F4CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999732053B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfJUQkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:40:45 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:13891 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfJUQkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:40:45 -0400
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXsMv3qxU1"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.28.1 AUTH)
        with ESMTPSA id 409989v9LGedQlb
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 21 Oct 2019 18:40:39 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Hai Li <hali@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikitos.tr@gmail.com>
Subject: [PATCH] drm/msm/dsi: Implement qcom,dsi-phy-regulator-ldo-mode for 28nm PHY
Date:   Mon, 21 Oct 2019 18:34:25 +0200
Message-Id: <20191021163425.83697-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DSI PHY regulator supports two regulator modes: LDO and DCDC.
This mode can be selected using the "qcom,dsi-phy-regulator-ldo-mode"
device tree property.

However, at the moment only the 20nm PHY driver actually implements
that option. Add a check in the 28nm PHY driver to program the
registers correctly for LDO mode.

Tested-by: Nikita Travkin <nikitos.tr@gmail.com> # l8150
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
This is needed to make the display work on Longcheer L8150,
which has recently gained mainline support in:
https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?id=16e8e8072108426029f0c16dff7fbe77fae3df8f

This patch is based on code from the downstream kernel:
https://source.codeaurora.org/quic/la/kernel/msm-3.10/tree/drivers/video/msm/mdss/msm_mdss_io_8974.c?h=LA.BR.1.2.9.1-02310-8x16.0#n152

The LDO regulator configuration is taken from msm8916-qrd.dtsi:
https://source.codeaurora.org/quic/la/kernel/msm-3.10/tree/arch/arm/boot/dts/qcom/msm8916-qrd.dtsi?h=LA.BR.1.2.9.1-02310-8x16.0#n56
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
index b3f678f6c2aa..4579e6de4532 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
@@ -48,6 +48,25 @@ static void dsi_28nm_phy_regulator_ctrl(struct msm_dsi_phy *phy, bool enable)
 		return;
 	}
 
+	if (phy->regulator_ldo_mode) {
+		u32 ldo_ctrl;
+
+		if (phy->cfg->type == MSM_DSI_PHY_28NM_LP)
+			ldo_ctrl = 0x05;
+		else
+			ldo_ctrl = 0x0d;
+
+		dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_0, 0x0);
+		dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CAL_PWR_CFG, 0);
+		dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_5, 0x7);
+		dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_3, 0);
+		dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_2, 0x1);
+		dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_1, 0x1);
+		dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_4, 0x20);
+		dsi_phy_write(phy->base + REG_DSI_28nm_PHY_LDO_CNTRL, ldo_ctrl);
+		return;
+	}
+
 	dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_0, 0x0);
 	dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CAL_PWR_CFG, 1);
 	dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_5, 0);
@@ -56,6 +75,7 @@ static void dsi_28nm_phy_regulator_ctrl(struct msm_dsi_phy *phy, bool enable)
 	dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_1, 0x9);
 	dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_0, 0x7);
 	dsi_phy_write(base + REG_DSI_28nm_PHY_REGULATOR_CTRL_4, 0x20);
+	dsi_phy_write(phy->base + REG_DSI_28nm_PHY_LDO_CNTRL, 0x00);
 }
 
 static int dsi_28nm_phy_enable(struct msm_dsi_phy *phy, int src_pll_id,
@@ -77,8 +97,6 @@ static int dsi_28nm_phy_enable(struct msm_dsi_phy *phy, int src_pll_id,
 
 	dsi_28nm_phy_regulator_ctrl(phy, true);
 
-	dsi_phy_write(base + REG_DSI_28nm_PHY_LDO_CNTRL, 0x00);
-
 	dsi_28nm_dphy_set_timing(phy, timing);
 
 	dsi_phy_write(base + REG_DSI_28nm_PHY_CTRL_1, 0x00);
-- 
2.23.0

