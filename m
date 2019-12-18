Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5B1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E1324682
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FkUP63X0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfLRWgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 17:36:12 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40143 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfLRWgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 17:36:05 -0500
Received: by mail-pj1-f68.google.com with SMTP id bg7so1047418pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 14:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HWLrCBmbQYNUzFqSBsWhDuxG2CTjfW4UctSr9zQlrcM=;
        b=FkUP63X0pjdoYGeSCmX+sTsW3UjT9Iz4YMXkcnYAADSytPIkCdf3qU+AXOzHvbSTIT
         4YHXU58YEBKhpv87PiKXMPiSl3b5z9J71lpbY4YRBDpBtgH+BoYKzHUa6v/unmJRZk3J
         zR76WEhs7n5zByU++Zj9kBjfUSflVwowSoOnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HWLrCBmbQYNUzFqSBsWhDuxG2CTjfW4UctSr9zQlrcM=;
        b=RhCCyrT6CiC2HX3l5gKK3h9oO/Zg573eIE0n+NoCHcqrDeRr8ycrPl0eTHSRDSxYc9
         hTEX2M7S4BPHa/yDhmrqRsngNiX1+QWFU/sA6OyKobVnRDcPo5OalNrn8x5eH/HOgtMj
         iZTL9wz4RpT+7A9oqlnUfXdJL1BoJ87F0bEVKDHfZ1mNXhRjv6Mw3rDugrTgbyjFkeI2
         9ZWVAVFVlLJUzkE2IsYNCMxes3Zrsjy5769C50lhKYdV9QlMR+fMWXHa1iU3wBmlgnLB
         HKkQlAMtBUV0rvv3xBFU6B1ehHDrwPbrWHJGnyylw+shGFk4bElMykeEzAcH9PPMJBjK
         QB6A==
X-Gm-Message-State: APjAAAXmQJ/p1TR/LDdlQrS1M0XLgurFrbCszaSohM6mgFTd1yoxoFq0
        H+OZi9fBlYrHU1cW0+porvh5fQ==
X-Google-Smtp-Source: APXvYqyqdXK6Wz2oJpw/C/l5gEu2n1oknYoDT7ccWZpYVnogGsdlgyyemkDssR3QaspTP99E71UUgw==
X-Received: by 2002:a17:90a:c24b:: with SMTP id d11mr5970581pjx.128.1576708564377;
        Wed, 18 Dec 2019 14:36:04 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id i9sm4709919pfk.24.2019.12.18.14.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 14:36:04 -0800 (PST)
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
Subject: [PATCH v3 6/9] drm/bridge: ti-sn65dsi86: Use 18-bit DP if we can
Date:   Wed, 18 Dec 2019 14:35:27 -0800
Message-Id: <20191218143416.v3.6.Iaf8d698f4e5253d658ae283d2fd07268076a7c27@changeid>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191218223530.253106-1-dianders@chromium.org>
References: <20191218223530.253106-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current bridge driver always forced us to use 24 bits per pixel
over the DP link.  This is a waste if you are hooked up to a panel
that only supports 6 bits per color or fewer, since in that case you
ran run at 18 bits per pixel and thus end up at a lower DP clock rate.

Let's support this.

While at it, let's clean up the math in the function to avoid rounding
errors (and round in the correct direction when we have to round).
Numbers are sufficiently small (because mode->clock is in kHz) that we
don't need to worry about integer overflow.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Rob Clark <robdclark@gmail.com>
Reviewed-by: Rob Clark <robdclark@gmail.com>
---

Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 0fc9e97b2d98..d5990a0947b9 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -51,6 +51,7 @@
 #define SN_ENH_FRAME_REG			0x5A
 #define  VSTREAM_ENABLE				BIT(3)
 #define SN_DATA_FORMAT_REG			0x5B
+#define  BPP_18_RGB				BIT(0)
 #define SN_HPD_DISABLE_REG			0x5C
 #define  HPD_DISABLE				BIT(0)
 #define SN_AUX_WDATA_REG(x)			(0x64 + (x))
@@ -436,6 +437,14 @@ static void ti_sn_bridge_set_dsi_rate(struct ti_sn_bridge *pdata)
 	regmap_write(pdata->regmap, SN_DSIA_CLK_FREQ_REG, val);
 }
 
+static unsigned int ti_sn_bridge_get_bpp(struct ti_sn_bridge *pdata)
+{
+	if (pdata->connector.display_info.bpc <= 6)
+		return 18;
+	else
+		return 24;
+}
+
 /**
  * LUT index corresponds to register value and
  * LUT values corresponds to dp data rate supported
@@ -447,21 +456,17 @@ static const unsigned int ti_sn_bridge_dp_rate_lut[] = {
 
 static void ti_sn_bridge_set_dp_rate(struct ti_sn_bridge *pdata)
 {
-	unsigned int bit_rate_mhz, dp_rate_mhz;
+	unsigned int bit_rate_khz, dp_rate_mhz;
 	unsigned int i;
 	struct drm_display_mode *mode =
 		&pdata->bridge.encoder->crtc->state->adjusted_mode;
 
-	/*
-	 * Calculate minimum bit rate based on our pixel clock.  At
-	 * the moment this driver never sets the DP_18BPP_EN bit in
-	 * register 0x5b so we hardcode 24bpp.
-	 */
-	bit_rate_mhz = (mode->clock / 1000) * 24;
+	/* Calculate minimum bit rate based on our pixel clock. */
+	bit_rate_khz = mode->clock * ti_sn_bridge_get_bpp(pdata);
 
 	/* Calculate minimum DP data rate, taking 80% as per DP spec */
-	dp_rate_mhz = ((bit_rate_mhz / pdata->dp_lanes) * DP_CLK_FUDGE_NUM) /
-							DP_CLK_FUDGE_DEN;
+	dp_rate_mhz = DIV_ROUND_UP(bit_rate_khz * DP_CLK_FUDGE_NUM,
+				   1000 * pdata->dp_lanes * DP_CLK_FUDGE_DEN);
 
 	for (i = 1; i < ARRAY_SIZE(ti_sn_bridge_dp_rate_lut) - 1; i++)
 		if (ti_sn_bridge_dp_rate_lut[i] > dp_rate_mhz)
@@ -550,6 +555,10 @@ static void ti_sn_bridge_enable(struct drm_bridge *bridge)
 	regmap_update_bits(pdata->regmap, SN_DSI_LANES_REG,
 			   CHA_DSI_LANES_MASK, val);
 
+	/* Set the DP output format (18 bpp or 24 bpp) */
+	val = (ti_sn_bridge_get_bpp(pdata) == 18) ? BPP_18_RGB : 0;
+	regmap_update_bits(pdata->regmap, SN_DATA_FORMAT_REG, BPP_18_RGB, val);
+
 	/* DP lane config */
 	val = DP_NUM_LANES(min(pdata->dp_lanes, 3));
 	regmap_update_bits(pdata->regmap, SN_SSC_CONFIG_REG, DP_NUM_LANES_MASK,
-- 
2.24.1.735.g03f4e72817-goog

