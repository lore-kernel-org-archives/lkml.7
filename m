Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C77C3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EC322CBB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tHMHiMgS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbfH0IO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:14:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37317 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbfH0IOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:14:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so17833495wrt.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 01:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P263Nz8GEJ4vmRFoF7UucI5AUC0r0zMRf0rnaRk+enY=;
        b=tHMHiMgSk47lpDEmrla9XXBM90OwrHN+lkL+/xh2RCq0cro5bbtsH/H12lBK+XQyPE
         Qkwk0TTJbfPh8pWIshAMztu+Kg7TiV2UFJnczaOAFCUC4w5TV7G1gSoKPC0nBMgnBMhG
         nUZqfwbwWeMOuARUiXgDZuIjYnqL2NOzdPHrmKHGYnsVH4eFXmeOcHIXlv2iIO+eOK/V
         te9YSmTZTbpJkXfnaqOgrxN4nnVDClGTXNj8cSUV920GwkyQwd+KnoUjhATe/5YC0G4p
         omwlvu9weNOdnFgeNFaKFEv894XlPbYCrB2/l01w3iBL+c0JBvedmUjvraTrgHBYF9h0
         w5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P263Nz8GEJ4vmRFoF7UucI5AUC0r0zMRf0rnaRk+enY=;
        b=pBZKRgnS5ABwv0PdbLpX9UsA7NoOefTbPOZgYhEmThqq/swS/H37GwrWHQMYx1/8qT
         tm3aFjRe/gylMI5beAYZcDc7azswkbAef0Acdrkka35Kvd+hQiVuAdbGF8Mnwronwli8
         hOkDaJaa2xrNRAIyHSFnSv0TubUC5dcja+gyj95KRdM6fUdS6A3WtC9a4TOPMjK0EEL/
         UUrnbQDwM4rFjUrJS/qXpW7iqT/iNade/83om6BlJLOPrlqyzKcDyeLurKrThzUP5nJN
         9MpzGi9qwAcdPycmYVh7secH7EUoeJgqCjhcuqEPZEF/EvfzqBJjT+AE2WumM0wlZDlM
         px1w==
X-Gm-Message-State: APjAAAVtYPPdu6g25w6+UpTda86lQKZz8oT3GFokhryRKrphXBvK1uNc
        WCqJZk4Jjd7CjXwahYMgQeTl7A==
X-Google-Smtp-Source: APXvYqwpvbZyC/pu+tVMvm17ws3ojExWy0ldiSpgNaiDeRPVrh1zPmuhZG2aTGT2a9jcu4lVoorn0w==
X-Received: by 2002:a5d:4446:: with SMTP id x6mr27380733wrr.11.1566893669899;
        Tue, 27 Aug 2019 01:14:29 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f18sm11911792wrx.85.2019.08.27.01.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 01:14:29 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 2/8] drm/meson: meson_dw_hdmi: switch to drm_bridge_funcs
Date:   Tue, 27 Aug 2019 10:14:19 +0200
Message-Id: <20190827081425.15011-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190827081425.15011-1-narmstrong@baylibre.com>
References: <20190827081425.15011-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the dw-hdmi driver to drm_bridge_funcs, and implement the
atomic_get_input_bus_fmts/atomic_get_output_bus_fmts.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 67 +++++++++++++++++++++------
 1 file changed, 54 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index f893ebd0b799..333583ef3ab9 100644
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
@@ -663,6 +663,10 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
 
 /* Encoder */
 
+static const u32 meson_dw_hdmi_out_bus_fmts[] = {
+	MEDIA_BUS_FMT_YUV8_1X24,
+};
+
 static void meson_venc_hdmi_encoder_destroy(struct drm_encoder *encoder)
 {
 	drm_encoder_cleanup(encoder);
@@ -672,15 +676,50 @@ static const struct drm_encoder_funcs meson_venc_hdmi_encoder_funcs = {
 	.destroy        = meson_venc_hdmi_encoder_destroy,
 };
 
-static int meson_venc_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
+static void
+meson_venc_hdmi_encoder_get_out_bus_fmts(struct drm_bridge *bridge,
+					 struct drm_bridge_state *bridge_state,
+					 struct drm_crtc_state *crtc_state,
+					 struct drm_connector_state *conn_state,
+					 unsigned int *num_output_fmts,
+					 u32 *output_fmts)
+{
+	*num_output_fmts = ARRAY_SIZE(meson_dw_hdmi_out_bus_fmts);
+
+	if (output_fmts)
+		memcpy(output_fmts, meson_dw_hdmi_out_bus_fmts,
+		       ARRAY_SIZE(meson_dw_hdmi_out_bus_fmts));
+}
+
+static void
+meson_venc_hdmi_encoder_get_inp_bus_fmts(struct drm_bridge *bridge,
+					struct drm_bridge_state *bridge_state,
+					struct drm_crtc_state *crtc_state,
+					struct drm_connector_state *conn_state,
+					u32 output_fmt,
+					unsigned int *num_input_fmts,
+					u32 *input_fmts)
+{
+	if (output_fmt == meson_dw_hdmi_out_bus_fmts[0]) {
+		*num_input_fmts = 1;
+		if (input_fmts)
+			input_fmts[0] = output_fmt;
+	}
+	else
+		*num_input_fmts = 0;
+}
+
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
 
@@ -693,8 +732,9 @@ static void meson_venc_hdmi_encoder_disable(struct drm_encoder *encoder)
 	writel_relaxed(0, priv->io_base + _REG(ENCP_VIDEO_EN));
 }
 
-static void meson_venc_hdmi_encoder_enable(struct drm_encoder *encoder)
+static void meson_venc_hdmi_encoder_enable(struct drm_bridge *bridge)
 {
+	struct drm_encoder *encoder = bridge_to_encoder(bridge);
 	struct meson_dw_hdmi *dw_hdmi = encoder_to_meson_dw_hdmi(encoder);
 	struct meson_drm *priv = dw_hdmi->priv;
 
@@ -706,10 +746,11 @@ static void meson_venc_hdmi_encoder_enable(struct drm_encoder *encoder)
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
@@ -726,11 +767,12 @@ static void meson_venc_hdmi_encoder_mode_set(struct drm_encoder *encoder,
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
+	.atomic_get_output_bus_fmts = meson_venc_hdmi_encoder_get_out_bus_fmts,
+	.atomic_get_input_bus_fmts = meson_venc_hdmi_encoder_get_inp_bus_fmts,
 	.mode_set	= meson_venc_hdmi_encoder_mode_set,
 };
 
@@ -912,8 +954,7 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 
 	/* Encoder */
 
-	drm_encoder_helper_add(encoder, &meson_venc_hdmi_encoder_helper_funcs);
-
+	encoder->bridge.funcs = &meson_venc_hdmi_encoder_bridge_funcs;
 	ret = drm_encoder_init(drm, encoder, &meson_venc_hdmi_encoder_funcs,
 			       DRM_MODE_ENCODER_TMDS, "meson_hdmi");
 	if (ret) {
-- 
2.22.0

