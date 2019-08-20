Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9892EC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2A422CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="f0FCu+Ya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfHTIlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:41:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51809 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729362AbfHTIlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:41:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id k1so1569484wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 01:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ycv/jEAcG3fpQBCVUPoq40RlT152vTGJJ9rC2v/DC0k=;
        b=f0FCu+YadoOWZOTl9Q8ohbQYHrR/ljKMMnNVHieeC41h1iNxHf8GVQge9XGOmeNHAQ
         4ZIo/RnvS/rn2ixKimc4ElXf5cZWHA7gU97MTm/HcvNnzWnzAERVaZ082klnN9fxKdGA
         cwTBAydF9wPfXYgyltwV57QcP277fVJZNEGIdppn4mCe2S3zxG9aeExprdISzUZfwnJA
         tbmmELvVM9IzDrKG6PgPV7hdzgxjEXqhsyajUz6FJEvqirxI/AWB9L33SHVNebMyYVpH
         LMwgQDGDA1onUh9PJ3imhw++67Oah+1OVTk9iOyRsZqHGbdzvbWmyqcGjZu7GqQ6I1Zj
         Eipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ycv/jEAcG3fpQBCVUPoq40RlT152vTGJJ9rC2v/DC0k=;
        b=TCQBJoa2CaP4IsI27HHPi5W30FfY4K9OeWKPUDCYz8q+Hx0wwQxSUo7xuVUkzxNI2v
         au3SrPROcmsyaa4kpKn+EmKWktJY5i7HjASYOCYeWFFaTNnPfdtQXatVKuf+dg0HtCoF
         TMbo2SWKqw1hnnJEOVZfJeRstD+DDvcnY1DXSdpxhUfEAdQx+lXBxHNhTd50VTtTxdIM
         hfiODM5ta6gAZYjJt6duCuycSlhie/Raf6PU12q/WnL3wXe15b86AD1VsFEyYso48p9Z
         W0wdjoHx5uqa9HCNT4/xhw7MWpYkOcez5Yfpm4a2Y27x0YZPaTlUhHCJ/e7P0WY4tnSf
         V+ew==
X-Gm-Message-State: APjAAAX2eoYxzJvVnBPZ/cSnHM4ZMffnAADVr4N9sIsPabdfuomjVCNI
        MG3M1lJDarEaxciG5WjXcxP+8A==
X-Google-Smtp-Source: APXvYqyJ/Fb2DsUH/6cVhm+iFgTQdtXlAWWQu27sKwrNSMuyXTmwD1BnbW+wDn/iYur4lTijf0q8dg==
X-Received: by 2002:a7b:cb8e:: with SMTP id m14mr25350146wmi.10.1566290478169;
        Tue, 20 Aug 2019 01:41:18 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g2sm34275648wru.27.2019.08.20.01.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 01:41:17 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 05/11] drm/bridge: synopsys: dw-hdmi: use negociated bus formats
Date:   Tue, 20 Aug 2019 10:41:03 +0200
Message-Id: <20190820084109.24616-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820084109.24616-1-narmstrong@baylibre.com>
References: <20190820084109.24616-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the negociated bus formats from the atomic check function if
the input and output formats are non NULL, otherwise fallback to
the plat_data->input_bus_format or the default MEDIA_BUS_FMT_RGB888_1X24
bus format.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 121c2167ee20..316823abdd00 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1968,11 +1968,10 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 	hdmi->hdmi_data.video_mode.mpixelrepetitionoutput = 0;
 	hdmi->hdmi_data.video_mode.mpixelrepetitioninput = 0;
 
-	/* TOFIX: Get input format from plat data or fallback to RGB888 */
 	if (hdmi->plat_data->input_bus_format)
 		hdmi->hdmi_data.enc_in_bus_format =
 			hdmi->plat_data->input_bus_format;
-	else
+	else if (!hdmi->hdmi_data.enc_in_bus_format)
 		hdmi->hdmi_data.enc_in_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
 
 	/* TOFIX: Get input encoding from plat data or fallback to none */
@@ -1982,8 +1981,8 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 	else
 		hdmi->hdmi_data.enc_in_encoding = V4L2_YCBCR_ENC_DEFAULT;
 
-	/* TOFIX: Default to RGB888 output format */
-	hdmi->hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
+	if (!hdmi->hdmi_data.enc_out_bus_format)
+		hdmi->hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
 
 	hdmi->hdmi_data.pix_repet_factor = 0;
 	hdmi->hdmi_data.hdcp_enable = 0;
@@ -2224,6 +2223,8 @@ static int dw_hdmi_bridge_atomic_check(struct drm_bridge *bridge,
 	dev_dbg(hdmi->dev, "selected output format %x\n",
 			bridge_state->output_bus_cfg.fmt);
 
+	hdmi->hdmi_data.enc_out_bus_format = bridge_state->output_bus_cfg.fmt;
+
 	ret = drm_atomic_bridge_choose_input_bus_cfg(bridge_state, crtc_state,
 						      conn_state);
 	if (ret)
@@ -2232,6 +2233,8 @@ static int dw_hdmi_bridge_atomic_check(struct drm_bridge *bridge,
 	dev_dbg(hdmi->dev, "selected input format %x\n",
 			bridge_state->input_bus_cfg.fmt);
 
+	hdmi->hdmi_data.enc_in_bus_format = bridge_state->input_bus_cfg.fmt;
+
 	return 0;
 }
 
-- 
2.22.0

