Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381D9C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6A922527
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZsIZN4XD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfLMXqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:46:14 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:44430 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfLMXqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:46:10 -0500
Received: by mail-pj1-f68.google.com with SMTP id w5so368282pjh.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 15:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UUJY8C2R1UDrN9sVA9Df9NEy0bvM49t/SSGj3bqxYIA=;
        b=ZsIZN4XD3zKnYDKUlFHgZN5qlLlZaKZvDA3IqUDEaZ1MKvXpxV2C0yQcyN0bwItqa9
         Rq2DzcDdb79znuQ1AwruLYFwFlCJlG7ArsO/sbIKvRxKg0y7W5KwBVO2ICkZL7a2vr8M
         0p4OgUdPIJ7z4DMmfblZ2UxMhHWhpRS36zwbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UUJY8C2R1UDrN9sVA9Df9NEy0bvM49t/SSGj3bqxYIA=;
        b=ObPE5SASzzSe+BhHEquPwl7tGSiCEDPkv4uueL29hoMMF9qV74lsBOb3SRCOOuO84f
         Swm+9qVdM7HUBFmcem72dFDXsWpXY70caux5Lh+b+KNLTvt0fF1hwpHAlVccVLwVUg/e
         i5WLqRvHm8sAo8CjRl5G8A76d9ZAtJsNCZJLNQLzPoEsOsRlFi30KbmJVVDMs5L+F59h
         PfO4vth0nRWeNMw2KoA3/eNOmi6JvXMkrLZLQLyUG9BVWluwL/1pNE1LdY9+/fpDmHuh
         aSQdPU5/FVfU+lBMXukghRIEo+48dZfVSk294w8t9kbA2E2wKSnRldFEHlGfp/NCbSmS
         zknQ==
X-Gm-Message-State: APjAAAVOmsIeEqr5u14gspmMfLmyaHEN9NEHEYU32hxKd7AkDon24FEf
        6raDrBJGl8D/OGvZPFQ1geZUEQ==
X-Google-Smtp-Source: APXvYqyclxT5JoQSvi7XSMZMqIl7nPTvJKywUFXfL73GfTko0ecOAss5ATHTnj7+cNjZej2o7vrvgw==
X-Received: by 2002:a17:90a:c790:: with SMTP id gn16mr2482321pjb.76.1576280769888;
        Fri, 13 Dec 2019 15:46:09 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id z19sm12282905pfn.49.2019.12.13.15.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 15:46:09 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     robdclark@chromium.org, linux-arm-msm@vger.kernel.org,
        seanpaul@chromium.org, bjorn.andersson@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 5/9] drm/bridge: ti-sn65dsi86: Read num lanes from the DP sink
Date:   Fri, 13 Dec 2019 15:45:26 -0800
Message-Id: <20191213154448.5.Idbd0051d0de53f7e9d18a291ea33011c0854fcc6@changeid>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191213234530.145963-1-dianders@chromium.org>
References: <20191213234530.145963-1-dianders@chromium.org>
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
---

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

