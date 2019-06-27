Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A420BC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CE12064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="qGxfcSqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfF0SV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:21:28 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:46278 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfF0SVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1561659684; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qCrv3tbrvvRWxIKr3e7PpU42XhOUTA3WgBASRFjc4Eo=;
        b=qGxfcSqN8lH5/Lgil8GmYw4Z5ephVzOX4ZiP0zkJjyW/3tNdU9PL/mXA/kMD1nbQp95P0F
        su5ngoU0a9U5J7ShdxBzMJx23EEL1cwNDglQ/eTT7m44wCN3oNRRhsf7LULOwDuvasSFgQ
        TQfpnTaIBMfuqsS1HpzBXAolaPBh7x8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/3] DRM: ingenic: Add support for Sharp panels
Date:   Thu, 27 Jun 2019 20:21:13 +0200
Message-Id: <20190627182114.27299-2-paul@crapouillou.net>
In-Reply-To: <20190627182114.27299-1-paul@crapouillou.net>
References: <20190627182114.27299-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the LCD panels that must be driven with the
Sharp-specific signals SPL, CLS, REV, PS.

An example of such panel is the LS020B1DD01D supported by the
panel-simple DRM panel driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm.c | 64 +++++++++++++++++----------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index 02c4788ef1c7..da966f3dc1f7 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -166,6 +166,8 @@ struct ingenic_drm {
 
 	struct ingenic_dma_hwdesc *dma_hwdesc;
 	dma_addr_t dma_hwdesc_phys;
+
+	bool panel_is_sharp;
 };
 
 static const u32 ingenic_drm_primary_formats[] = {
@@ -283,6 +285,13 @@ static void ingenic_drm_crtc_update_timings(struct ingenic_drm *priv,
 	regmap_write(priv->map, JZ_REG_LCD_DAV,
 		     vds << JZ_LCD_DAV_VDS_OFFSET |
 		     vde << JZ_LCD_DAV_VDE_OFFSET);
+
+	if (priv->panel_is_sharp) {
+		regmap_write(priv->map, JZ_REG_LCD_PS, hde << 16 | (hde + 1));
+		regmap_write(priv->map, JZ_REG_LCD_CLS, hde << 16 | (hde + 1));
+		regmap_write(priv->map, JZ_REG_LCD_SPL, hpe << 16 | (hpe + 1));
+		regmap_write(priv->map, JZ_REG_LCD_REV, mode->htotal << 16);
+	}
 }
 
 static void ingenic_drm_crtc_update_ctrl(struct ingenic_drm *priv,
@@ -378,11 +387,18 @@ static void ingenic_drm_encoder_atomic_mode_set(struct drm_encoder *encoder,
 {
 	struct ingenic_drm *priv = drm_encoder_get_priv(encoder);
 	struct drm_display_mode *mode = &crtc_state->adjusted_mode;
-	struct drm_display_info *info = &conn_state->connector->display_info;
-	unsigned int cfg = JZ_LCD_CFG_PS_DISABLE
-			 | JZ_LCD_CFG_CLS_DISABLE
-			 | JZ_LCD_CFG_SPL_DISABLE
-			 | JZ_LCD_CFG_REV_DISABLE;
+	struct drm_connector *conn = conn_state->connector;
+	struct drm_display_info *info = &conn->display_info;
+	unsigned int cfg;
+
+	priv->panel_is_sharp = info->bus_flags & DRM_BUS_FLAG_SHARP_SIGNALS;
+
+	if (priv->panel_is_sharp) {
+		cfg = JZ_LCD_CFG_MODE_SPECIAL_TFT_1 | JZ_LCD_CFG_REV_POLARITY;
+	} else {
+		cfg = JZ_LCD_CFG_PS_DISABLE | JZ_LCD_CFG_CLS_DISABLE
+		    | JZ_LCD_CFG_SPL_DISABLE | JZ_LCD_CFG_REV_DISABLE;
+	}
 
 	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
 		cfg |= JZ_LCD_CFG_HSYNC_ACTIVE_LOW;
@@ -393,24 +409,26 @@ static void ingenic_drm_encoder_atomic_mode_set(struct drm_encoder *encoder,
 	if (info->bus_flags & DRM_BUS_FLAG_PIXDATA_NEGEDGE)
 		cfg |= JZ_LCD_CFG_PCLK_FALLING_EDGE;
 
-	if (conn_state->connector->connector_type == DRM_MODE_CONNECTOR_TV) {
-		if (mode->flags & DRM_MODE_FLAG_INTERLACE)
-			cfg |= JZ_LCD_CFG_MODE_TV_OUT_I;
-		else
-			cfg |= JZ_LCD_CFG_MODE_TV_OUT_P;
-	} else {
-		switch (*info->bus_formats) {
-		case MEDIA_BUS_FMT_RGB565_1X16:
-			cfg |= JZ_LCD_CFG_MODE_GENERIC_16BIT;
-			break;
-		case MEDIA_BUS_FMT_RGB666_1X18:
-			cfg |= JZ_LCD_CFG_MODE_GENERIC_18BIT;
-			break;
-		case MEDIA_BUS_FMT_RGB888_1X24:
-			cfg |= JZ_LCD_CFG_MODE_GENERIC_24BIT;
-			break;
-		default:
-			break;
+	if (!priv->panel_is_sharp) {
+		if (conn->connector_type == DRM_MODE_CONNECTOR_TV) {
+			if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+				cfg |= JZ_LCD_CFG_MODE_TV_OUT_I;
+			else
+				cfg |= JZ_LCD_CFG_MODE_TV_OUT_P;
+		} else {
+			switch (*info->bus_formats) {
+			case MEDIA_BUS_FMT_RGB565_1X16:
+				cfg |= JZ_LCD_CFG_MODE_GENERIC_16BIT;
+				break;
+			case MEDIA_BUS_FMT_RGB666_1X18:
+				cfg |= JZ_LCD_CFG_MODE_GENERIC_18BIT;
+				break;
+			case MEDIA_BUS_FMT_RGB888_1X24:
+				cfg |= JZ_LCD_CFG_MODE_GENERIC_24BIT;
+				break;
+			default:
+				break;
+			}
 		}
 	}
 
-- 
2.21.0.593.g511ec345e18

