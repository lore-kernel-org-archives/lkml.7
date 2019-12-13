Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599F1C00454
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327F622527
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 23:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F6arw4C7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfLMXqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:46:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35400 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfLMXqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:46:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id b19so2300139pfo.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 15:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cA4UDUHuCTqvlIh454k1CuQ9LBQaRg6FJ8cZd003K1c=;
        b=F6arw4C77gsnO3MMZuHtdQgaIV/tPDc/9xs0Znpn4zcamJF2EiYYwM5SXXX2RsSfuE
         e9ArJWGHwqypnETr+1RR9JJD+hpKmoraaTH7+w7y7h9RaBPlrMwoSUhLrOWJq43A75T1
         YxoGhGHLaC29Halx1mNtG/A8Ea3eSPKLP/0CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cA4UDUHuCTqvlIh454k1CuQ9LBQaRg6FJ8cZd003K1c=;
        b=KPKnaHFSh2Z/Zw63hhKpX4jLrHk3nEdz7YD5Y+RHhg+4wiiMNC8vNJbM1rGuNeopAB
         llqIXVTVhIkzvxbkYLReLGsDK6HyIbvhlOHSPKLrn7G7opg/vC3188kP/VB1ijHa58r6
         J6k97RKu3GQhUrX/L7ALPOnuNYe8Ajmtd6aQTXQ0NSyb74IuTSU1HEW09qeSPzaSQqVL
         XkZYPjG3RTCGZm8WZl9vxgPOCBA6Kotbxw8C5NJ5+FFybCdufhM1BHnUtDYZrFbjqqLO
         Vqx/ARiTzqbbzqgiXI6Ubp81BfMRWHnXZ+YYASNawHHt60MajJ1zC5jructVw91oPof+
         Z4HA==
X-Gm-Message-State: APjAAAU6H4m0okzZuSSGNFqvL059vOcqSl2prjd2pcGt0aeQVh3LNMzL
        KRT0oL3we3i+1v96fZMYPtoNdg==
X-Google-Smtp-Source: APXvYqyWbcMVX6RrILQqSb7dvBaskEzzs7sYm+xMlYD7IHgX8YdOLFiBpC076Ti6YOU5glF8ziBxIQ==
X-Received: by 2002:a63:5407:: with SMTP id i7mr2453004pgb.330.1576280772173;
        Fri, 13 Dec 2019 15:46:12 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id z19sm12282905pfn.49.2019.12.13.15.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 15:46:11 -0800 (PST)
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
Subject: [PATCH 7/9] drm/bridge: ti-sn65dsi86: Group DP link training bits in a function
Date:   Fri, 13 Dec 2019 15:45:28 -0800
Message-Id: <20191213154448.7.I1fc75ad11db9048ef08cfe1ab7322753d9a219c7@changeid>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191213234530.145963-1-dianders@chromium.org>
References: <20191213234530.145963-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'll re-organize the ti_sn_bridge_enable() function a bit to group
together all the parts relating to link training and split them into a
sub-function.  This is not intended to have any functional change and
is in preparation for trying link training several times at different
rates.  One small side effect here is that if link training fails
we'll now leave the DP PLL disabled, but that seems like a sane thing
to do.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 86 ++++++++++++++++-----------
 1 file changed, 52 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index d5990a0947b9..48fb4dc72e1c 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -530,6 +530,46 @@ static unsigned int ti_sn_get_max_lanes(struct ti_sn_bridge *pdata)
 	return data & DP_LANE_COUNT_MASK;
 }
 
+static int ti_sn_link_training(struct ti_sn_bridge *pdata)
+{
+	unsigned int val;
+	int ret;
+
+	/* set dp clk frequency value */
+	ti_sn_bridge_set_dp_rate(pdata);
+
+	/* enable DP PLL */
+	regmap_write(pdata->regmap, SN_PLL_ENABLE_REG, 1);
+
+	ret = regmap_read_poll_timeout(pdata->regmap, SN_DPPLL_SRC_REG, val,
+				       val & DPPLL_SRC_DP_PLL_LOCK, 1000,
+				       50 * 1000);
+	if (ret) {
+		DRM_ERROR("DP_PLL_LOCK polling failed (%d)\n", ret);
+		goto exit;
+	}
+
+	/* Semi auto link training mode */
+	regmap_write(pdata->regmap, SN_ML_TX_MODE_REG, 0x0A);
+	ret = regmap_read_poll_timeout(pdata->regmap, SN_ML_TX_MODE_REG, val,
+				       val == ML_TX_MAIN_LINK_OFF ||
+				       val == ML_TX_NORMAL_MODE, 1000,
+				       500 * 1000);
+	if (ret) {
+		DRM_ERROR("Training complete polling failed (%d)\n", ret);
+	} else if (val == ML_TX_MAIN_LINK_OFF) {
+		DRM_ERROR("Link training failed, link is off\n");
+		ret = -EIO;
+	}
+
+exit:
+	/* Disable the PLL if we failed */
+	if (ret)
+		regmap_write(pdata->regmap, SN_PLL_ENABLE_REG, 0);
+
+	return ret;
+}
+
 static void ti_sn_bridge_enable(struct drm_bridge *bridge)
 {
 	struct ti_sn_bridge *pdata = bridge_to_ti_sn_bridge(bridge);
@@ -555,29 +595,8 @@ static void ti_sn_bridge_enable(struct drm_bridge *bridge)
 	regmap_update_bits(pdata->regmap, SN_DSI_LANES_REG,
 			   CHA_DSI_LANES_MASK, val);
 
-	/* Set the DP output format (18 bpp or 24 bpp) */
-	val = (ti_sn_bridge_get_bpp(pdata) == 18) ? BPP_18_RGB : 0;
-	regmap_update_bits(pdata->regmap, SN_DATA_FORMAT_REG, BPP_18_RGB, val);
-
-	/* DP lane config */
-	val = DP_NUM_LANES(min(pdata->dp_lanes, 3));
-	regmap_update_bits(pdata->regmap, SN_SSC_CONFIG_REG, DP_NUM_LANES_MASK,
-			   val);
-
-	/* set dsi/dp clk frequency value */
+	/* set dsi clk frequency value */
 	ti_sn_bridge_set_dsi_rate(pdata);
-	ti_sn_bridge_set_dp_rate(pdata);
-
-	/* enable DP PLL */
-	regmap_write(pdata->regmap, SN_PLL_ENABLE_REG, 1);
-
-	ret = regmap_read_poll_timeout(pdata->regmap, SN_DPPLL_SRC_REG, val,
-				       val & DPPLL_SRC_DP_PLL_LOCK, 1000,
-				       50 * 1000);
-	if (ret) {
-		DRM_ERROR("DP_PLL_LOCK polling failed (%d)\n", ret);
-		return;
-	}
 
 	/**
 	 * The SN65DSI86 only supports ASSR Display Authentication method and
@@ -588,19 +607,18 @@ static void ti_sn_bridge_enable(struct drm_bridge *bridge)
 	drm_dp_dpcd_writeb(&pdata->aux, DP_EDP_CONFIGURATION_SET,
 			   DP_ALTERNATE_SCRAMBLER_RESET_ENABLE);
 
-	/* Semi auto link training mode */
-	regmap_write(pdata->regmap, SN_ML_TX_MODE_REG, 0x0A);
-	ret = regmap_read_poll_timeout(pdata->regmap, SN_ML_TX_MODE_REG, val,
-				       val == ML_TX_MAIN_LINK_OFF ||
-				       val == ML_TX_NORMAL_MODE, 1000,
-				       500 * 1000);
-	if (ret) {
-		DRM_ERROR("Training complete polling failed (%d)\n", ret);
-		return;
-	} else if (val == ML_TX_MAIN_LINK_OFF) {
-		DRM_ERROR("Link training failed, link is off\n");
+	/* Set the DP output format (18 bpp or 24 bpp) */
+	val = (ti_sn_bridge_get_bpp(pdata) == 18) ? BPP_18_RGB : 0;
+	regmap_update_bits(pdata->regmap, SN_DATA_FORMAT_REG, BPP_18_RGB, val);
+
+	/* DP lane config */
+	val = DP_NUM_LANES(min(pdata->dp_lanes, 3));
+	regmap_update_bits(pdata->regmap, SN_SSC_CONFIG_REG, DP_NUM_LANES_MASK,
+			   val);
+
+	ret = ti_sn_link_training(pdata);
+	if (ret)
 		return;
-	}
 
 	/* config video parameters */
 	ti_sn_bridge_set_video_timings(pdata);
-- 
2.24.1.735.g03f4e72817-goog

