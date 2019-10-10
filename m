Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79164C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 03:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50685218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 03:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732879AbfJJDpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 23:45:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46758 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfJJDpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 23:45:06 -0400
Received: by mail-pl1-f196.google.com with SMTP id q24so2069556plr.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 20:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=amRpcIpCSIzpI9qw9JunLNMzTja2mT7Cd8T4RQ8vtAc=;
        b=j8srwIa9MuZqD8+L4WSKDn0mvQzcmGWXvC0SyMiRX/BsL1j3GRNxb0UxeBT7fWhJCt
         IUJE0s4xOttK5eDOwAwewqkek8HV0DDQMr1JZ81IpRr+QEELuEvrN40wWyEpb+lsJZL0
         gAO2r/jrhnesK3yEfH1WFMJn2ydLIYJ9+78Ky4oIjbymtfgbri0RkR6qkG8y8X7ylCc1
         358y2jVqfbdjSiphwRUQ6GBnlP8jCGVYI6t8zkOZaGaXul3n67n1x2DKxivgjcR3gJsc
         UkZRn9u3EIb9A+0uaiOcQZcdRN22hr7L+aRv3UoSCSkcWpz3R3W5AybQWXg8Rjg8khOD
         Px0Q==
X-Gm-Message-State: APjAAAUL2PctRBndxzUCuoKKzQmcKiCK+tc8MYKAxrFWEe7Mr33oyqts
        v4H+FiEQv6NlZF5apeVpHYE=
X-Google-Smtp-Source: APXvYqw2GNqZw03SMzQITAg2WvD8DqeOWPJsN6GbPLbca485yPtQMH+MpYuHXiYyGBI2Bl4KbCj0zw==
X-Received: by 2002:a17:902:8c92:: with SMTP id t18mr6636599plo.76.1570679105381;
        Wed, 09 Oct 2019 20:45:05 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id z13sm4552188pfq.121.2019.10.09.20.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 20:45:04 -0700 (PDT)
From:   Nickey Yang <nickey.yang@rock-chips.com>
To:     heiko@sntech.de, hjc@rock-chips.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, nickey.yang@rock-chips.com,
        seanpaul@chromium.org, laurent.pinchart@ideasonboard.com
Subject: [PATCH 1/1] drm/rockchip: vop: add the definition of dclk_pol
Date:   Thu, 10 Oct 2019 11:44:52 +0800
Message-Id: <20191010034452.20260-2-nickey.yang@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010034452.20260-1-nickey.yang@rock-chips.com>
References: <20191010034452.20260-1-nickey.yang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some VOP's (such as px30) dclk_pol bit is at the last.
So it is necessary to distinguish dclk_pol and pin_pol.

Signed-off-by: Nickey Yang <nickey.yang@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 12 +++---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  8 +++-
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 45 ++++++++++++++-------
 3 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 613404f86668..0d6682ed9e15 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1085,9 +1085,7 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
 		DRM_DEV_ERROR(vop->dev, "Failed to enable vop (%d)\n", ret);
 		return;
 	}
-
-	pin_pol = BIT(DCLK_INVERT);
-	pin_pol |= (adjusted_mode->flags & DRM_MODE_FLAG_PHSYNC) ?
+	pin_pol = (adjusted_mode->flags & DRM_MODE_FLAG_PHSYNC) ?
 		   BIT(HSYNC_POSITIVE) : 0;
 	pin_pol |= (adjusted_mode->flags & DRM_MODE_FLAG_PVSYNC) ?
 		   BIT(VSYNC_POSITIVE) : 0;
@@ -1096,25 +1094,29 @@ static void vop_crtc_atomic_enable(struct drm_crtc *crtc,
 
 	switch (s->output_type) {
 	case DRM_MODE_CONNECTOR_LVDS:
-		VOP_REG_SET(vop, output, rgb_en, 1);
+		VOP_REG_SET(vop, output, rgb_dclk_pol, 1);
 		VOP_REG_SET(vop, output, rgb_pin_pol, pin_pol);
+		VOP_REG_SET(vop, output, rgb_en, 1);
 		break;
 	case DRM_MODE_CONNECTOR_eDP:
+		VOP_REG_SET(vop, output, edp_dclk_pol, 1);
 		VOP_REG_SET(vop, output, edp_pin_pol, pin_pol);
 		VOP_REG_SET(vop, output, edp_en, 1);
 		break;
 	case DRM_MODE_CONNECTOR_HDMIA:
+		VOP_REG_SET(vop, output, hdmi_dclk_pol, 1);
 		VOP_REG_SET(vop, output, hdmi_pin_pol, pin_pol);
 		VOP_REG_SET(vop, output, hdmi_en, 1);
 		break;
 	case DRM_MODE_CONNECTOR_DSI:
+		VOP_REG_SET(vop, output, mipi_dclk_pol, 1);
 		VOP_REG_SET(vop, output, mipi_pin_pol, pin_pol);
 		VOP_REG_SET(vop, output, mipi_en, 1);
 		VOP_REG_SET(vop, output, mipi_dual_channel_en,
 			    !!(s->output_flags & ROCKCHIP_OUTPUT_DSI_DUAL));
 		break;
 	case DRM_MODE_CONNECTOR_DisplayPort:
-		pin_pol &= ~BIT(DCLK_INVERT);
+		VOP_REG_SET(vop, output, dp_dclk_pol, 0);
 		VOP_REG_SET(vop, output, dp_pin_pol, pin_pol);
 		VOP_REG_SET(vop, output, dp_en, 1);
 		break;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 2149a889c29d..ea1f97a5aa5d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -46,10 +46,15 @@ struct vop_modeset {
 struct vop_output {
 	struct vop_reg pin_pol;
 	struct vop_reg dp_pin_pol;
+	struct vop_reg dp_dclk_pol;
 	struct vop_reg edp_pin_pol;
+	struct vop_reg edp_dclk_pol;
 	struct vop_reg hdmi_pin_pol;
+	struct vop_reg hdmi_dclk_pol;
 	struct vop_reg mipi_pin_pol;
+	struct vop_reg mipi_dclk_pol;
 	struct vop_reg rgb_pin_pol;
+	struct vop_reg rgb_dclk_pol;
 	struct vop_reg dp_en;
 	struct vop_reg edp_en;
 	struct vop_reg hdmi_en;
@@ -294,8 +299,7 @@ enum dither_down_mode_sel {
 enum vop_pol {
 	HSYNC_POSITIVE = 0,
 	VSYNC_POSITIVE = 1,
-	DEN_NEGATIVE   = 2,
-	DCLK_INVERT    = 3
+	DEN_NEGATIVE   = 2
 };
 
 #define FRAC_16_16(mult, div)    (((mult) << 16) / (div))
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index d1494be14471..f92c899d656c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -214,9 +214,11 @@ static const struct vop_modeset px30_modeset = {
 };
 
 static const struct vop_output px30_output = {
-	.rgb_pin_pol = VOP_REG(PX30_DSP_CTRL0, 0xf, 1),
-	.mipi_pin_pol = VOP_REG(PX30_DSP_CTRL0, 0xf, 25),
+	.rgb_dclk_pol = VOP_REG(PX30_DSP_CTRL0, 0x1, 1),
+	.rgb_pin_pol = VOP_REG(PX30_DSP_CTRL0, 0x7, 2),
 	.rgb_en = VOP_REG(PX30_DSP_CTRL0, 0x1, 0),
+	.mipi_dclk_pol = VOP_REG(PX30_DSP_CTRL0, 0x1, 25),
+	.mipi_pin_pol = VOP_REG(PX30_DSP_CTRL0, 0x7, 26),
 	.mipi_en = VOP_REG(PX30_DSP_CTRL0, 0x1, 24),
 };
 
@@ -717,10 +719,14 @@ static const struct vop_win_data rk3368_vop_win_data[] = {
 };
 
 static const struct vop_output rk3368_output = {
-	.rgb_pin_pol = VOP_REG(RK3368_DSP_CTRL1, 0xf, 16),
-	.hdmi_pin_pol = VOP_REG(RK3368_DSP_CTRL1, 0xf, 20),
-	.edp_pin_pol = VOP_REG(RK3368_DSP_CTRL1, 0xf, 24),
-	.mipi_pin_pol = VOP_REG(RK3368_DSP_CTRL1, 0xf, 28),
+	.rgb_dclk_pol = VOP_REG(RK3368_DSP_CTRL1, 0x1, 19),
+	.hdmi_dclk_pol = VOP_REG(RK3368_DSP_CTRL1, 0x1, 23),
+	.edp_dclk_pol = VOP_REG(RK3368_DSP_CTRL1, 0x1, 27),
+	.mipi_dclk_pol = VOP_REG(RK3368_DSP_CTRL1, 0x1, 31),
+	.rgb_pin_pol = VOP_REG(RK3368_DSP_CTRL1, 0x7, 16),
+	.hdmi_pin_pol = VOP_REG(RK3368_DSP_CTRL1, 0x7, 20),
+	.edp_pin_pol = VOP_REG(RK3368_DSP_CTRL1, 0x7, 24),
+	.mipi_pin_pol = VOP_REG(RK3368_DSP_CTRL1, 0x7, 28),
 	.rgb_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 12),
 	.hdmi_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 13),
 	.edp_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 14),
@@ -764,11 +770,16 @@ static const struct vop_data rk3366_vop = {
 };
 
 static const struct vop_output rk3399_output = {
-	.dp_pin_pol = VOP_REG(RK3399_DSP_CTRL1, 0xf, 16),
-	.rgb_pin_pol = VOP_REG(RK3368_DSP_CTRL1, 0xf, 16),
-	.hdmi_pin_pol = VOP_REG(RK3368_DSP_CTRL1, 0xf, 20),
-	.edp_pin_pol = VOP_REG(RK3368_DSP_CTRL1, 0xf, 24),
-	.mipi_pin_pol = VOP_REG(RK3368_DSP_CTRL1, 0xf, 28),
+	.dp_dclk_pol = VOP_REG(RK3399_DSP_CTRL1, 0x1, 19),
+	.rgb_dclk_pol = VOP_REG(RK3368_DSP_CTRL1, 0x1, 19),
+	.hdmi_dclk_pol = VOP_REG(RK3368_DSP_CTRL1, 0x1, 23),
+	.edp_dclk_pol = VOP_REG(RK3368_DSP_CTRL1, 0x1, 27),
+	.mipi_dclk_pol = VOP_REG(RK3368_DSP_CTRL1, 0x1, 31),
+	.dp_pin_pol = VOP_REG(RK3399_DSP_CTRL1, 0x7, 16),
+	.rgb_pin_pol = VOP_REG(RK3368_DSP_CTRL1, 0x7, 16),
+	.hdmi_pin_pol = VOP_REG(RK3368_DSP_CTRL1, 0x7, 20),
+	.edp_pin_pol = VOP_REG(RK3368_DSP_CTRL1, 0x7, 24),
+	.mipi_pin_pol = VOP_REG(RK3368_DSP_CTRL1, 0x7, 28),
 	.dp_en = VOP_REG(RK3399_SYS_CTRL, 0x1, 11),
 	.rgb_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 12),
 	.hdmi_en = VOP_REG(RK3288_SYS_CTRL, 0x1, 13),
@@ -872,14 +883,18 @@ static const struct vop_modeset rk3328_modeset = {
 };
 
 static const struct vop_output rk3328_output = {
+	.rgb_dclk_pol = VOP_REG(RK3328_DSP_CTRL1, 0x1, 19),
+	.hdmi_dclk_pol = VOP_REG(RK3328_DSP_CTRL1, 0x1, 23),
+	.edp_dclk_pol = VOP_REG(RK3328_DSP_CTRL1, 0x1, 27),
+	.mipi_dclk_pol = VOP_REG(RK3328_DSP_CTRL1, 0x1, 31),
 	.rgb_en = VOP_REG(RK3328_SYS_CTRL, 0x1, 12),
 	.hdmi_en = VOP_REG(RK3328_SYS_CTRL, 0x1, 13),
 	.edp_en = VOP_REG(RK3328_SYS_CTRL, 0x1, 14),
 	.mipi_en = VOP_REG(RK3328_SYS_CTRL, 0x1, 15),
-	.rgb_pin_pol = VOP_REG(RK3328_DSP_CTRL1, 0xf, 16),
-	.hdmi_pin_pol = VOP_REG(RK3328_DSP_CTRL1, 0xf, 20),
-	.edp_pin_pol = VOP_REG(RK3328_DSP_CTRL1, 0xf, 24),
-	.mipi_pin_pol = VOP_REG(RK3328_DSP_CTRL1, 0xf, 28),
+	.rgb_pin_pol = VOP_REG(RK3328_DSP_CTRL1, 0x7, 16),
+	.hdmi_pin_pol = VOP_REG(RK3328_DSP_CTRL1, 0x7, 20),
+	.edp_pin_pol = VOP_REG(RK3328_DSP_CTRL1, 0x7, 24),
+	.mipi_pin_pol = VOP_REG(RK3328_DSP_CTRL1, 0x7, 28),
 };
 
 static const struct vop_misc rk3328_misc = {
-- 
2.17.1

