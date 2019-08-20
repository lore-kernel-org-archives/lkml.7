Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D58C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6337C22CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TcWzIbs5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbfHTIlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:41:39 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:50806 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbfHTIlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:41:24 -0400
Received: by mail-wm1-f42.google.com with SMTP id v15so1862853wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iCcz7VXT3Rri0q0plV0Ks3VAIbY+L7u5e09ODRK9afA=;
        b=TcWzIbs5Rei+udJAkxpcwt14stzXHw97HeoQj79gXS/ZY41E2XJs/7vFgp/XK+eTM0
         NFCACfqCTQ8n/vElqSW4uyboi8Q8ADALAv6vSifu1BxC+TbdCe0WjHUFzbST6eHrO8Lz
         NpKJlSlaryAW5mF6/5cfwz4smy3O6FFuwaDS6ltdxwcHpVGzQ7LFhtlSfv+TGqqUohNc
         JBelFVLTIV2qsgXvugyflMbrxU51p+g2QTqw8sr0hz8DHgiyonGi7DmUmgdGYrrh97nk
         BvT/+CSERG7XYXlWb6CPp7OlLnVvdeQ3TrD+vWsPzkLUhsd8j2ezlz8Sai33AZRngEcx
         /G/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iCcz7VXT3Rri0q0plV0Ks3VAIbY+L7u5e09ODRK9afA=;
        b=S20b9y89qZ+nPGAUgBUMPNO9USeUw+BH6jkBBL1Nn6fFBE6yf0fclNWDWeCmh2uTJO
         4MDySZ5SdblFZnd7XSpDm4dGSnwNjhMAy3xQnoaRocAfdFOZWAS1FIzJrVxFprOl1jSx
         pLumPlYtm/eZqIOsZk15UL6EZyhXrTsjqhGAWR3EtdNn0Wd8vNIFb+wfT83qMLsXUUDn
         DGK/CS0sDIooNtbhnvbrlJOdP1zwfR+GLQeA0Uogd7LxObXsgzAyWS3cyEdgBWLhai+u
         QsE04FTSKDG4onVd4keESl8TnjHfdgv6qw9itGYGPanLQ100CVF/nYti0vgeRsthuM7I
         6ulw==
X-Gm-Message-State: APjAAAVy/cLhhLhr5VBb9T8J9RQjnIfCiPJN2zh86VwVPGWsxvY+xlGT
        wXdI1AAEsdvYVK1d0areWtJ2Sg==
X-Google-Smtp-Source: APXvYqyEU0PHQl+WTxPI5Y4mWZdoYQS8xETpRbqo/vMyfB2rVnuBI82wdg4WuZX2RO+0DThTBm2nhw==
X-Received: by 2002:a1c:7513:: with SMTP id o19mr15982869wmc.126.1566290482352;
        Tue, 20 Aug 2019 01:41:22 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g2sm34275648wru.27.2019.08.20.01.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 01:41:21 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 08/11] drm/bridge: synopsys: dw-hdmi: add 420 mode format negociation
Date:   Tue, 20 Aug 2019 10:41:06 +0200
Message-Id: <20190820084109.24616-9-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820084109.24616-1-narmstrong@baylibre.com>
References: <20190820084109.24616-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add special negociation case for 420 HDMI2.0 format.

In this case the DW-HDMI CSC cannot handle 420 data, and must be
in passthrought, thus input_bus_cfg must be output_bus_cfg.

Add support for handling a specific 8/10/12/16 variant in the connector
bus_formats if specified.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 45 ++++++++++++++++++-----
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index cb560b231d74..b96119c6fad2 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2213,23 +2213,50 @@ static int dw_hdmi_bridge_atomic_check(struct drm_bridge *bridge,
 				       struct drm_connector_state *conn_state)
 {
 	struct dw_hdmi *hdmi = bridge->driver_private;
+	struct drm_connector *conn = conn_state->connector;
+	struct drm_display_info *info = &conn->display_info;
+	struct drm_display_mode *mode = &crtc_state->mode;
+	bool is_hdmi2_sink = info->hdmi.scdc.supported;
 	int ret;
 
-	ret = drm_atomic_bridge_choose_output_bus_cfg(bridge_state, crtc_state,
-						      conn_state);
-	if (ret)
-		return ret;
+	/*
+	 * If the current mode enforces 4:2:0, force the output but format
+	 * or use the connector bus formats if a non 8bit 4:2:0 format
+	 * is provided.
+	 */
+	if (drm_mode_is_420_only(info, mode) ||
+		(!is_hdmi2_sink && drm_mode_is_420_also(info, mode))) {
+		if (info->num_bus_formats && info->bus_formats &&
+		    hdmi_bus_fmt_is_yuv420(info->bus_formats[0]))
+			bridge_state->output_bus_cfg.fmt = info->bus_formats[0];
+		else
+			bridge_state->output_bus_cfg.fmt =
+					MEDIA_BUS_FMT_UYYVYY8_0_5X24;
+	} else {
+		ret = drm_atomic_bridge_choose_output_bus_cfg(bridge_state,
+							      crtc_state,
+							      conn_state);
+		if (ret)
+			return ret;
+	}
+
+	if (hdmi_bus_fmt_is_yuv420(bridge_state->output_bus_cfg.fmt)) {
+		/* The DW-HDMI CSC cannot interpolate and decimate in 4:2:0 */
+		bridge_state->input_bus_cfg.fmt =
+			bridge_state->output_bus_cfg.fmt;
+	} else {
+		ret = drm_atomic_bridge_choose_input_bus_cfg(bridge_state,
+				                             crtc_state,
+							     conn_state);
+		if (ret)
+			return ret;
+	}
 
 	dev_dbg(hdmi->dev, "selected output format %x\n",
 			bridge_state->output_bus_cfg.fmt);
 
 	hdmi->hdmi_data.enc_out_bus_format = bridge_state->output_bus_cfg.fmt;
 
-	ret = drm_atomic_bridge_choose_input_bus_cfg(bridge_state, crtc_state,
-						      conn_state);
-	if (ret)
-		return ret;
-
 	dev_dbg(hdmi->dev, "selected input format %x\n",
 			bridge_state->input_bus_cfg.fmt);
 
-- 
2.22.0

