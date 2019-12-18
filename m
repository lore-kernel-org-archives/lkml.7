Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA38EC2D0D1
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF9B21D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z/kLD0eo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfLRAsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 19:48:37 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33064 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfLRAse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:48:34 -0500
Received: by mail-pj1-f67.google.com with SMTP id u63so540662pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 16:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5I5RsOjGn6AIw10awvPPmKNOIBhCgMn63qgGQLogkT0=;
        b=Z/kLD0eoZedWUdTEDSVJ6kbPawHJOoiVPCNRGbgQQgKOAw7fzhYDSK3K02mAbNdlQq
         Fr0oNSrqzR9oqMNnsCr8ULdLH02KZAFfz2cypDlJkWrPbgZ+koWO0EFsgvgaya0R9qXw
         ZlvpV3CLhTTS4eAvXf4/9iFbM0UzmmsU5A7t0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5I5RsOjGn6AIw10awvPPmKNOIBhCgMn63qgGQLogkT0=;
        b=raBDmuw+DcPNkoAhUwEEO5pi4c81ynMPAK0oM3g/b3vYIrXEb3bD4AW3+zNY6ZKh1Y
         LXFywwPtvxxPdgF+jcOXk2wIutRlQXXj4lTvNB02s8JVGgXV7A4WOB9WEMeyRXz3dD1z
         Nv8eCEAkfkr7IVUSROrNvB6YPva3TMo3yMAwATmw7tz+rt2mTqDApB8rbAMVfusIitzW
         A/ehIVWYn29NZuanOyRgNsLQejvGfFR6OuxWMycU6M+GTusMKnGyKh2m0jOc2F4zHQVI
         S3xPS4nUR6yn4t+HL5+Bpi6xplFeGN1OgHZEOcCIyfffCvkAR4MFfnD0gXTzX68N1cRy
         fiNg==
X-Gm-Message-State: APjAAAUyCxaF5xnDjzPgTAD3dcgWKJL12ERtlcB9LSpZDVPwVwyWtVvu
        m7dAmMQaOEtN92gZg0nrGT3XJA==
X-Google-Smtp-Source: APXvYqzlYuY6Q06NylLwmoyVjvz5Q+yRFHQQVef1ISO7bP+Gy7Ho4kEkiZtVedpDN3oy9tmnzGorAg==
X-Received: by 2002:a17:902:9302:: with SMTP id bc2mr1101734plb.148.1576630112269;
        Tue, 17 Dec 2019 16:48:32 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id v72sm139885pjb.25.2019.12.17.16.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 16:48:31 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     robdclark@chromium.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, seanpaul@chromium.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 5/9] drm/bridge: ti-sn65dsi86: Read num lanes from the DP sink
Date:   Tue, 17 Dec 2019 16:47:37 -0800
Message-Id: <20191217164702.v2.5.Idbd0051d0de53f7e9d18a291ea33011c0854fcc6@changeid>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191218004741.102067-1-dianders@chromium.org>
References: <20191218004741.102067-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least one panel hooked up to the bridge (AUO B116XAK01) only
supports 1 lane of DP.  Let's read this information and stop
hardcoding 4 DP lanes.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Rob Clark <robdclark@gmail.com>
Reviewed-by: Rob Clark <robdclark@gmail.com>
---

Changes in v2: None

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 32 +++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index d55d19759796..0fc9e97b2d98 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -313,8 +313,7 @@ static int ti_sn_bridge_attach(struct drm_bridge *bridge)
 		goto err_dsi_host;
 	}
 
-	/* TODO: setting to 4 lanes always for now */
-	pdata->dp_lanes = 4;
+	/* TODO: setting to 4 MIPI lanes always for now */
 	dsi->lanes = 4;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO;
@@ -511,12 +510,41 @@ static void ti_sn_bridge_set_video_timings(struct ti_sn_bridge *pdata)
 	usleep_range(10000, 10500); /* 10ms delay recommended by spec */
 }
 
+static unsigned int ti_sn_get_max_lanes(struct ti_sn_bridge *pdata)
+{
+	u8 data;
+	int ret;
+
+	ret = drm_dp_dpcd_readb(&pdata->aux, DP_MAX_LANE_COUNT, &data);
+	if (ret != 1) {
+		DRM_DEV_ERROR(pdata->dev,
+			      "Can't read lane count (%d); assuming 4\n", ret);
+		return 4;
+	}
+
+	return data & DP_LANE_COUNT_MASK;
+}
+
 static void ti_sn_bridge_enable(struct drm_bridge *bridge)
 {
 	struct ti_sn_bridge *pdata = bridge_to_ti_sn_bridge(bridge);
 	unsigned int val;
 	int ret;
 
+	/*
+	 * Run with the maximum number of lanes that the DP sink supports.
+	 *
+	 * Depending use cases, we might want to revisit this later because:
+	 * - It's plausible that someone may have run fewer lines to the
+	 *   sink than the sink actually supports, assuming that the lines
+	 *   will just be driven at a higher rate.
+	 * - The DP spec seems to indicate that it's more important to minimize
+	 *   the number of lanes than the link rate.
+	 *
+	 * If we do revisit, it would be important to measure the power impact.
+	 */
+	pdata->dp_lanes = ti_sn_get_max_lanes(pdata);
+
 	/* DSI_A lane config */
 	val = CHA_DSI_LANES(4 - pdata->dsi->lanes);
 	regmap_update_bits(pdata->regmap, SN_DSI_LANES_REG,
-- 
2.24.1.735.g03f4e72817-goog

