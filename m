Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D17C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FD222CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0oN9KfCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbfHTIlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:41:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53220 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbfHTIlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:41:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id o4so1861934wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ecwbnitdiOv4GNJMlaQYE3q8EXMkI0eb0YmQtYFZpyw=;
        b=0oN9KfCgtlO6Fg0pLmVaOu8bb5Xnlza1CkqRkD5lz/aIbUP82APa1908Vrpz9x3f50
         vZq9cT3wbjmn/onMOlykMl3WOauVS8YCNBdsqt7SW3G5pWHpTmq3oNdM02053B1IiW3U
         H8M0eMor5Zh4Wvw8qK0fU9+SLL+fYCzI++wVsZhNOlulbyE1mo3qknbs0xLaXCQI0zD7
         WRwCelBUJZw8nVmN8uGWkIjlyfq4PBaj+tqGPF1O3lEjASVVDFfDijFeGkx9kF96D5Fn
         VFr9aORWvvgE+Tb6N6L1Xp7CjI+GVc2zIP0N9N8yTTz6UaQP6kVtNiHS1vGYPFN5JMea
         9dGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ecwbnitdiOv4GNJMlaQYE3q8EXMkI0eb0YmQtYFZpyw=;
        b=p5c8UFr0c/RTPgWZxTP95jRjtDsR6PG5qXfIGxIZjCZYBclAprlTIqM8W+qh+CBB4d
         5svwsXWLXxDyu+2ShA7VniI+I+4IUHo9ctn1Pb7NI228ZIFppZ6X5bmrbPVILIEjKPAF
         rXeZNTZMci3FRDG4WrcWtizfdaolFtwCSwQ78R9hBf5yxAHb3mEENis8WZvTcoFUdAK2
         3J4owd9NIw7quXm1xocVz2MqDE8xs7S4LniHceNtJdYa2lukkgVEe0yIdass8Q/lMll3
         I1yLNSOdjtbXH26TH5+nBvJJFAdxjzj/T5q3BjqH1XUnWK8Hq6yNEfOcryiqmG0tstDD
         xkZA==
X-Gm-Message-State: APjAAAU4Vu55kCq4qINzfgPo3G6DiGJn1AC3ehm0cH7DyMtIWymsJp15
        8VwsTiDefS+f9Cky+9QhX3wtaQ==
X-Google-Smtp-Source: APXvYqwQ4da5rpbUSTUs9ZIZMRsQGsu7wIFZMWvm+TOalIMoawh4Z8UCunL3BDDxlisCvn7PHe2kkQ==
X-Received: by 2002:a05:600c:22c7:: with SMTP id 7mr25158111wmg.129.1566290475940;
        Tue, 20 Aug 2019 01:41:15 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g2sm34275648wru.27.2019.08.20.01.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 01:41:14 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 03/11] drm/meson: meson_dw_hdmi: switch to drm_bridge_funcs
Date:   Tue, 20 Aug 2019 10:41:01 +0200
Message-Id: <20190820084109.24616-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820084109.24616-1-narmstrong@baylibre.com>
References: <20190820084109.24616-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the dw-hdmi driver to drm_bridge_funcs, and add the default supported
YUV444 bus format to the encoder output_bus_caps.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 37 +++++++++++++++++----------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 9f0b08eaf003..9a99d3920610 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -368,7 +368,7 @@ static inline void meson_dw_hdmi_phy_reset(struct meson_dw_hdmi *dw_hdmi)
 }
 
 static void dw_hdmi_set_vclk(struct meson_dw_hdmi *dw_hdmi,
-			     struct drm_display_mode *mode)
+			     const struct drm_display_mode *mode)
 {
 	struct meson_drm *priv = dw_hdmi->priv;
 	int vic = drm_match_cea_mode(mode);
@@ -670,15 +670,17 @@ static const struct drm_encoder_funcs meson_venc_hdmi_encoder_funcs = {
 	.destroy        = meson_venc_hdmi_encoder_destroy,
 };
 
-static int meson_venc_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
+static int meson_venc_hdmi_encoder_atomic_check(struct drm_bridge *bridge,
+					struct drm_bridge_state *bridge_state,
 					struct drm_crtc_state *crtc_state,
 					struct drm_connector_state *conn_state)
 {
 	return 0;
 }
 
-static void meson_venc_hdmi_encoder_disable(struct drm_encoder *encoder)
+static void meson_venc_hdmi_encoder_disable(struct drm_bridge *bridge)
 {
+	struct drm_encoder *encoder = bridge_to_encoder(bridge);
 	struct meson_dw_hdmi *dw_hdmi = encoder_to_meson_dw_hdmi(encoder);
 	struct meson_drm *priv = dw_hdmi->priv;
 
@@ -691,8 +693,9 @@ static void meson_venc_hdmi_encoder_disable(struct drm_encoder *encoder)
 	writel_relaxed(0, priv->io_base + _REG(ENCP_VIDEO_EN));
 }
 
-static void meson_venc_hdmi_encoder_enable(struct drm_encoder *encoder)
+static void meson_venc_hdmi_encoder_enable(struct drm_bridge *bridge)
 {
+	struct drm_encoder *encoder = bridge_to_encoder(bridge);
 	struct meson_dw_hdmi *dw_hdmi = encoder_to_meson_dw_hdmi(encoder);
 	struct meson_drm *priv = dw_hdmi->priv;
 
@@ -704,10 +707,11 @@ static void meson_venc_hdmi_encoder_enable(struct drm_encoder *encoder)
 		writel_relaxed(1, priv->io_base + _REG(ENCP_VIDEO_EN));
 }
 
-static void meson_venc_hdmi_encoder_mode_set(struct drm_encoder *encoder,
-				   struct drm_display_mode *mode,
-				   struct drm_display_mode *adjusted_mode)
+static void meson_venc_hdmi_encoder_mode_set(struct drm_bridge *bridge,
+				   const struct drm_display_mode *mode,
+				   const struct drm_display_mode *adjusted_mode)
 {
+	struct drm_encoder *encoder = bridge_to_encoder(bridge);
 	struct meson_dw_hdmi *dw_hdmi = encoder_to_meson_dw_hdmi(encoder);
 	struct meson_drm *priv = dw_hdmi->priv;
 	int vic = drm_match_cea_mode(mode);
@@ -724,11 +728,10 @@ static void meson_venc_hdmi_encoder_mode_set(struct drm_encoder *encoder,
 	writel_relaxed(0, priv->io_base + _REG(VPU_HDMI_FMT_CTRL));
 }
 
-static const struct drm_encoder_helper_funcs
-				meson_venc_hdmi_encoder_helper_funcs = {
-	.atomic_check	= meson_venc_hdmi_encoder_atomic_check,
-	.disable	= meson_venc_hdmi_encoder_disable,
+static const struct drm_bridge_funcs meson_venc_hdmi_encoder_bridge_funcs = {
 	.enable		= meson_venc_hdmi_encoder_enable,
+	.disable	= meson_venc_hdmi_encoder_disable,
+	.atomic_check	= meson_venc_hdmi_encoder_atomic_check,
 	.mode_set	= meson_venc_hdmi_encoder_mode_set,
 };
 
@@ -800,6 +803,10 @@ static bool meson_hdmi_connector_is_available(struct device *dev)
 	return false;
 }
 
+static const u32 meson_dw_hdmi_out_bus_fmts[] = {
+	MEDIA_BUS_FMT_YUV8_1X24,
+};
+
 static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 				void *data)
 {
@@ -810,6 +817,7 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	struct meson_drm *priv = drm->dev_private;
 	struct dw_hdmi_plat_data *dw_plat_data;
 	struct drm_encoder *encoder;
+	struct drm_bus_caps *bus_caps;
 	struct resource *res;
 	int irq;
 	int ret;
@@ -837,6 +845,7 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	meson_dw_hdmi->data = match;
 	dw_plat_data = &meson_dw_hdmi->dw_plat_data;
 	encoder = &meson_dw_hdmi->encoder;
+	bus_caps = &encoder->bridge.output_bus_caps;
 
 	meson_dw_hdmi->hdmi_supply = devm_regulator_get_optional(dev, "hdmi");
 	if (IS_ERR(meson_dw_hdmi->hdmi_supply)) {
@@ -910,8 +919,7 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 
 	/* Encoder */
 
-	drm_encoder_helper_add(encoder, &meson_venc_hdmi_encoder_helper_funcs);
-
+	encoder->bridge.funcs = &meson_venc_hdmi_encoder_bridge_funcs;
 	ret = drm_encoder_init(drm, encoder, &meson_venc_hdmi_encoder_funcs,
 			       DRM_MODE_ENCODER_TMDS, "meson_hdmi");
 	if (ret) {
@@ -919,6 +927,9 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 		return ret;
 	}
 
+	bus_caps->supported_fmts = meson_dw_hdmi_out_bus_fmts;
+	bus_caps->num_supported_fmts = ARRAY_SIZE(meson_dw_hdmi_out_bus_fmts);
+
 	encoder->possible_crtcs = BIT(0);
 
 	DRM_DEBUG_DRIVER("encoder initialized\n");
-- 
2.22.0

