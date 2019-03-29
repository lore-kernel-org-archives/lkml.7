Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E58C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DED21773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eszOQgP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbfC2Km5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:42:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35563 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfC2Kmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:42:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id w1so2003047wrp.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 03:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9iPta9zPgZP3XWAC5lhX/snSUTynLHfLroArxcu7BWk=;
        b=eszOQgP58IP41nW+eG+b907BI8xIfNPpUC+HbKnK7kmgGWHJpTChTyC8wUX8H3mgur
         xfoA0acJK4EdmoXFh4WlyovylXqdyJ/s3anJGOgaJW5pUs/nl/nLTKTs4YqpLXd1VE8H
         ryhB4ryNo557UD/9U5Lf+3A0IZyZY9JNR9o/CS4xwbZcoNWZQ57UqLE/yTMtD7t1nyCN
         rqe0ZTRfh2KDfvWRaTr4PT5LIwlPKO1PWm9wkZD2iKIhuJ1ydJ8iKdPpSgIEszjnGpWH
         GJ7lyIl6hliguFtcCxVn5VMsNvlBHZAdF5exwYB0Qpj5vufJHQsc2bWA21HhOCgG7JR3
         Akog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9iPta9zPgZP3XWAC5lhX/snSUTynLHfLroArxcu7BWk=;
        b=HIdLC8Vtx0I/PdbZYGWKZ0TIoHVl8Iz9qJ78+N1zhdOucUtGM/dpRzh6qmgGlcTKp9
         q5FqGuem17PeiRLO+GxZt/DgpIl2n4gDDFOYvbMAVp7NheQcToRgon73ARIRF3xqo1wu
         V8/zBE+YL5XtMtGBEmeeGbf7lHxmk11Gr4OS1iemzQVlU12ptkd1fee6NyiRE5tfO5z8
         ilpzpDCcOdNtCAadJbeOIA7FT8Q57FoDUm2JEir4QzpHaLFM3NNHNKIck1Pj89o5j43q
         KdRos2ygK79UJeoAhuFgSSVRDi1lmyeTkYR7GbaY8g2Il21sQEIfMzqBZtUEfA/mIWy/
         mkVA==
X-Gm-Message-State: APjAAAVlz9YHkIx6++gl1XWOuoSS93o3dKEZJw43yPrSy85o4Iyf2kXJ
        cqtwV/OtNuobo9RhXotyXfq+QQ==
X-Google-Smtp-Source: APXvYqxpswm5L4dzjRqq+BvpCEIouHIZ4JdfSZOysyc0i4t58OaeUknOQKivP42lH6oxGmsIJh1RVA==
X-Received: by 2002:a5d:488d:: with SMTP id g13mr17463196wrq.119.1553856168573;
        Fri, 29 Mar 2019 03:42:48 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o15sm1632826wrj.59.2019.03.29.03.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Mar 2019 03:42:48 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, jernej.skrabec@siol.net,
        heiko@sntech.de, maxime.ripard@bootlin.com, hjc@rock-chips.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 5/5] drm/meson: Output in YUV444 if sink supports it
Date:   Fri, 29 Mar 2019 11:42:40 +0100
Message-Id: <20190329104240.29585-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190329104240.29585-1-narmstrong@baylibre.com>
References: <20190329104240.29585-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the YUV420 handling, we can dynamically setup the HDMI output
pixel format depending on the mode and connector info.
So now, we can output in YUV444, which is the native video pipeline
format, directly to the HDMI Sink if it's supported without
necessarily involving the HDMI Controller CSC.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index 5d67e2beba58..8bf9db7f39a4 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -723,12 +723,23 @@ static int meson_venc_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
 	struct drm_display_mode *mode = &crtc_state->mode;
 	bool is_hdmi2_sink =
 		conn_state->connector->display_info.hdmi.scdc.supported;
+	bool specify_out_format = false;
+	u32 out_format;
 
 	if (drm_mode_is_420_only(info, mode) ||
 	    (!is_hdmi2_sink && drm_mode_is_420_also(info, mode)))
 		dw_hdmi->input_bus_format = MEDIA_BUS_FMT_UYYVYY8_0_5X24;
-	else
+	else {
 		dw_hdmi->input_bus_format = MEDIA_BUS_FMT_YUV8_1X24;
+		if (info->color_formats & DRM_COLOR_FORMAT_YCRCB444) {
+			out_format = MEDIA_BUS_FMT_YUV8_1X24;
+			specify_out_format = true;
+		}
+	}
+
+	/* Set a connector bus format is required */
+	drm_display_info_set_bus_formats(info, &out_format,
+					 (specify_out_format ? 1 : 0));
 
 	/* Specify the encoder output format to the bridge */
 	if (!drm_bridge_format_set(encoder->bridge,
-- 
2.21.0

