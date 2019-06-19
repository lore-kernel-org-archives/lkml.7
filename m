Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1702C43613
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C699215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iC9Di/9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbfFSVLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 17:11:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35334 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFSVLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 17:11:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id d126so328603pfd.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 14:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UqQ12c8oFg0dcVTOrMLNZkNDHBR+LaLcBh/sRyeBypc=;
        b=iC9Di/9ZfP4OrwV3ZKuhmT3/TWXjDaE8BipQuK4Mc8V4Wac6ZYwuWY88MLeJ+H8/GD
         GLMqFmf7buOvo4UFZFCCfc2Kj8U9iWaZAmw4FhQ/NSKRbb79uNm6j5a9ssPg++X1A0vO
         HmyVHVARdgLUPpYi/WEw4emKtf9OdEifHXQ0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UqQ12c8oFg0dcVTOrMLNZkNDHBR+LaLcBh/sRyeBypc=;
        b=uh5QB6p7JqaBTpea9jnxLBokI8P16kF9gssc6TcGcgnCLVEU2JdKbKbOPvK6AZxJI9
         n/RdaBaxngiuyvFf/epshOWepK3knNTO7GA9eR6/+oPyhvHMoYw+AlQl6PLLJxOUBJbL
         NDuqO6ZVtuNzM8QFxcSOid1PROKRRa+bp5CZ69duXyILpktcoyR8HdpCYMDs4bggpc1a
         5ufLEL3B/FkDMKKwSM1DsM5wg8EAYiqONfH4wO/P8gj6lr1H3lq0Jc07xIRrhSrqlI2V
         sDcI1EC5rFozrKYdED3L/q58MkbnREAeM3AxCFa7E/aEN9oY9CJKXLGRdmj9z0HZrZVO
         gsFg==
X-Gm-Message-State: APjAAAWBtpAmwLldJzhVzm3G6iAOi7Nsqiv5luLewOkTt00AXDzE84Iw
        Ij2J5c/a2cmFEQm6hVvI++i7Cg==
X-Google-Smtp-Source: APXvYqx/c2t5NAwX8FA7Uq82W2txp2Rp4HlmYnUIfyHTrU/eW2XjahPhf+pM0HN78yZeg0mPG3pJhg==
X-Received: by 2002:a63:4e10:: with SMTP id c16mr9364838pgb.214.1560978707695;
        Wed, 19 Jun 2019 14:11:47 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id p7sm35319117pfp.131.2019.06.19.14.11.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 14:11:46 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        seanpaul@chromium.org
Cc:     jernej.skrabec@siol.net, heiko@sntech.de, jonas@kwiboo.se,
        maxime.ripard@bootlin.com, narmstrong@baylibre.com,
        linux-rockchip@lists.infradead.org, dgreid@chromium.org,
        cychiang@chromium.org, jbrunet@baylibre.com,
        Douglas Anderson <dianders@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 1/2] drm/bridge/synopsys: dw-hdmi: Handle audio for more clock rates
Date:   Wed, 19 Jun 2019 14:07:17 -0700
Message-Id: <20190619210718.134951-1-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's add some better support for HDMI audio to dw_hdmi.
Specifically:

1. For 44.1 kHz audio the old code made the assumption that an N of
6272 was right most of the time.  That wasn't true and the new table
should pick a more ideal value.

2. The new table has values from the HDMI spec for 297 MHz and 594
MHz.

3. There is now code to try to come up with a more idea N/CTS for
clock rates that aren't in the table.  This code is a bit slow because
it iterates over every possible value of N and picks the best one, but
it should make a good fallback.

NOTES:
- The oddest part of this patch comes about because computing the
  ideal N/CTS means knowing the _exact_ clock rate, not a rounded
  version of it.  The drm framework makes this harder by rounding
  rates to kHz, but even if it didn't there might be cases where the
  ideal rate could only be calculated if we knew the real
  (non-integral) rate.  This means that in cases where we know (or
  believe) that the true rate is something other than the rate we are
  told by drm.
- This patch makes much less of a difference after the patch
  ("drm/bridge: dw-hdmi: Use automatic CTS generation mode when using
  non-AHB audio"), at least if you're using I2S audio.  The main goal
  of picking a good N is to make it possible to get a nice integral
  CTS value, but if CTS is automatic then that's much less critical.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Atop ("drm/bridge: dw-hdmi: Use automatic CTS generation mode when
  using non-AHB audio").
- Split out the ability of a platform to provide custom tables.

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 203 +++++++++++++++++-----
 1 file changed, 162 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index de4c3669c83f..7cdffebcc7cb 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -60,6 +60,82 @@ enum hdmi_datamap {
 	YCbCr422_12B = 0x12,
 };
 
+struct dw_hdmi_audio_tmds_n {
+	unsigned long tmds;
+	unsigned int n_32k;
+	unsigned int n_44k1;
+	unsigned int n_48k;
+};
+
+/*
+ * Unless otherwise noted, entries in this table are 100% optimization.
+ * Values can be obtained from hdmi_compute_n() but that function is
+ * slow so we pre-compute values we expect to see.
+ *
+ * All 32k and 48k values are expected to be the same (due to the way
+ * the math works) for any rate that's an exact kHz.
+ *
+ * If a particular platform knows that it makes a rate slightly
+ * differently then it should add a platform-specific match.
+ */
+static const struct dw_hdmi_audio_tmds_n common_tmds_n_table[] = {
+	/* Doesn't match computations, assumes real clock = 25.2 MHz / 1.001 */
+	{ .tmds = 25175000, .n_32k = 4576, .n_44k1 = 7007, .n_48k = 6864, },
+
+	{ .tmds = 25200000, .n_32k = 4096, .n_44k1 = 5656, .n_48k = 6144, },
+	{ .tmds = 27000000, .n_32k = 4096, .n_44k1 = 5488, .n_48k = 6144, },
+	{ .tmds = 27027000, .n_32k = 4096, .n_44k1 = 6272, .n_48k = 6144, },
+	{ .tmds = 28320000, .n_32k = 4096, .n_44k1 = 5586, .n_48k = 6144, },
+	{ .tmds = 30240000, .n_32k = 4096, .n_44k1 = 5642, .n_48k = 6144, },
+	{ .tmds = 31500000, .n_32k = 4096, .n_44k1 = 5600, .n_48k = 6144, },
+	{ .tmds = 32000000, .n_32k = 4096, .n_44k1 = 5733, .n_48k = 6144, },
+	{ .tmds = 33750000, .n_32k = 4096, .n_44k1 = 6272, .n_48k = 6144, },
+	{ .tmds = 36000000, .n_32k = 4096, .n_44k1 = 5684, .n_48k = 6144, },
+	{ .tmds = 40000000, .n_32k = 4096, .n_44k1 = 5733, .n_48k = 6144, },
+	{ .tmds = 49500000, .n_32k = 4096, .n_44k1 = 5488, .n_48k = 6144, },
+	{ .tmds = 50000000, .n_32k = 4096, .n_44k1 = 5292, .n_48k = 6144, },
+	{ .tmds = 54000000, .n_32k = 4096, .n_44k1 = 5684, .n_48k = 6144, },
+	{ .tmds = 65000000, .n_32k = 4096, .n_44k1 = 7056, .n_48k = 6144, },
+	{ .tmds = 68250000, .n_32k = 4096, .n_44k1 = 5376, .n_48k = 6144, },
+	{ .tmds = 71000000, .n_32k = 4096, .n_44k1 = 7056, .n_48k = 6144, },
+	{ .tmds = 72000000, .n_32k = 4096, .n_44k1 = 5635, .n_48k = 6144, },
+	{ .tmds = 73250000, .n_32k = 4096, .n_44k1 = 14112, .n_48k = 6144, },
+
+	/* Doesn't match computations, assumes real clock = 74.25 MHz / 1.001 */
+	{ .tmds = 74176000, .n_32k = 11648, .n_44k1 = 17836, .n_48k = 11648, },
+
+	{ .tmds = 74250000, .n_32k = 4096, .n_44k1 = 6272, .n_48k = 6144, },
+	{ .tmds = 75000000, .n_32k = 4096, .n_44k1 = 5880, .n_48k = 6144, },
+	{ .tmds = 78750000, .n_32k = 4096, .n_44k1 = 5600, .n_48k = 6144, },
+	{ .tmds = 78800000, .n_32k = 4096, .n_44k1 = 5292, .n_48k = 6144, },
+	{ .tmds = 79500000, .n_32k = 4096, .n_44k1 = 4704, .n_48k = 6144, },
+	{ .tmds = 83500000, .n_32k = 4096, .n_44k1 = 7056, .n_48k = 6144, },
+	{ .tmds = 85500000, .n_32k = 4096, .n_44k1 = 5488, .n_48k = 6144, },
+	{ .tmds = 88750000, .n_32k = 4096, .n_44k1 = 14112, .n_48k = 6144, },
+	{ .tmds = 97750000, .n_32k = 4096, .n_44k1 = 14112, .n_48k = 6144, },
+	{ .tmds = 101000000, .n_32k = 4096, .n_44k1 = 7056, .n_48k = 6144, },
+	{ .tmds = 106500000, .n_32k = 4096, .n_44k1 = 4704, .n_48k = 6144, },
+	{ .tmds = 108000000, .n_32k = 4096, .n_44k1 = 5684, .n_48k = 6144, },
+	{ .tmds = 115500000, .n_32k = 4096, .n_44k1 = 5712, .n_48k = 6144, },
+	{ .tmds = 119000000, .n_32k = 4096, .n_44k1 = 5544, .n_48k = 6144, },
+	{ .tmds = 135000000, .n_32k = 4096, .n_44k1 = 5488, .n_48k = 6144, },
+	{ .tmds = 146250000, .n_32k = 4096, .n_44k1 = 6272, .n_48k = 6144, },
+
+	/* Doesn't match computations, assumes real clock = 148.5 MHz / 1.001 */
+	{ .tmds = 148352000, .n_32k = 11648, .n_44k1 = 8918, .n_48k = 5824, },
+
+	{ .tmds = 148500000, .n_32k = 4096, .n_44k1 = 5488, .n_48k = 6144, },
+	{ .tmds = 154000000, .n_32k = 4096, .n_44k1 = 5544, .n_48k = 6144, },
+	{ .tmds = 162000000, .n_32k = 4096, .n_44k1 = 5684, .n_48k = 6144, },
+
+	/* For 297 MHz+ HDMI spec has some other rule for setting N */
+	{ .tmds = 297000000, .n_32k = 3073, .n_44k1 = 4704, .n_48k = 5120, },
+	{ .tmds = 594000000, .n_32k = 3073, .n_44k1 = 9408, .n_48k = 10240, },
+
+	/* End of table */
+	{ .tmds = 0,         .n_32k = 0,    .n_44k1 = 0,    .n_48k = 0, },
+};
+
 static const u16 csc_coeff_default[3][4] = {
 	{ 0x2000, 0x0000, 0x0000, 0x0000 },
 	{ 0x0000, 0x2000, 0x0000, 0x0000 },
@@ -524,60 +600,105 @@ static void hdmi_set_cts_n(struct dw_hdmi *hdmi, unsigned int cts,
 	hdmi_writeb(hdmi, n & 0xff, HDMI_AUD_N1);
 }
 
-static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk)
+static int hdmi_match_tmds_n_table(struct dw_hdmi *hdmi, unsigned int freq,
+				   unsigned long pixel_clk)
 {
-	unsigned int n = (128 * freq) / 1000;
-	unsigned int mult = 1;
+	const struct dw_hdmi_audio_tmds_n *tmds_n = NULL;
+	int mult = 1;
+	int i;
 
 	while (freq > 48000) {
 		mult *= 2;
 		freq /= 2;
 	}
 
+	for (i = 0; common_tmds_n_table[i].tmds != 0; i++) {
+		if (pixel_clk == common_tmds_n_table[i].tmds) {
+			tmds_n = &common_tmds_n_table[i];
+			break;
+		}
+	}
+
+	if (tmds_n == NULL)
+		return -ENOENT;
+
 	switch (freq) {
 	case 32000:
-		if (pixel_clk == 25175000)
-			n = 4576;
-		else if (pixel_clk == 27027000)
-			n = 4096;
-		else if (pixel_clk == 74176000 || pixel_clk == 148352000)
-			n = 11648;
-		else
-			n = 4096;
-		n *= mult;
-		break;
-
+		return tmds_n->n_32k * mult;
 	case 44100:
-		if (pixel_clk == 25175000)
-			n = 7007;
-		else if (pixel_clk == 74176000)
-			n = 17836;
-		else if (pixel_clk == 148352000)
-			n = 8918;
-		else
-			n = 6272;
-		n *= mult;
-		break;
-
+		return tmds_n->n_44k1 * mult;
 	case 48000:
-		if (pixel_clk == 25175000)
-			n = 6864;
-		else if (pixel_clk == 27027000)
-			n = 6144;
-		else if (pixel_clk == 74176000)
-			n = 11648;
-		else if (pixel_clk == 148352000)
-			n = 5824;
-		else
-			n = 6144;
-		n *= mult;
-		break;
-
+		return tmds_n->n_48k * mult;
 	default:
-		break;
+		return -ENOENT;
+	}
+}
+
+static u64 hdmi_audio_math_diff(unsigned int freq, unsigned int n,
+				unsigned int pixel_clk)
+{
+	u64 final, diff;
+	u64 cts;
+
+	final = (u64)pixel_clk * n;
+
+	cts = final;
+	do_div(cts, 128 * freq);
+
+	diff = final - (u64)cts * (128 * freq);
+
+	return diff;
+}
+
+static unsigned int hdmi_compute_n(struct dw_hdmi *hdmi, unsigned int freq,
+				   unsigned long pixel_clk)
+{
+	unsigned int min_n = DIV_ROUND_UP((128 * freq), 1500);
+	unsigned int max_n = (128 * freq) / 300;
+	unsigned int ideal_n = (128 * freq) / 1000;
+	unsigned int best_n_distance = ideal_n;
+	unsigned int best_n = 0;
+	u64 best_diff = U64_MAX;
+	int n;
+
+	/* If the ideal N could satisfy the audio math, then just take it */
+	if (hdmi_audio_math_diff(freq, ideal_n, pixel_clk) == 0)
+		return ideal_n;
+
+	for (n = min_n; n <= max_n; n++) {
+		u64 diff = hdmi_audio_math_diff(freq, n, pixel_clk);
+
+		if (diff < best_diff || (diff == best_diff &&
+		    abs(n - ideal_n) < best_n_distance)) {
+			best_n = n;
+			best_diff = diff;
+			best_n_distance = abs(best_n - ideal_n);
+		}
+
+		/*
+		 * The best N already satisfy the audio math, and also be
+		 * the closest value to ideal N, so just cut the loop.
+		 */
+		if ((best_diff == 0) && (abs(n - ideal_n) > best_n_distance))
+			break;
 	}
 
-	return n;
+	return best_n;
+}
+
+static unsigned int hdmi_find_n(struct dw_hdmi *hdmi, unsigned int freq,
+				unsigned long pixel_clk)
+{
+	int n;
+
+	n = hdmi_match_tmds_n_table(hdmi, freq, pixel_clk);
+	if (n > 0)
+		return n;
+
+	dev_warn(hdmi->dev, "Rate %lu missing; compute N dynamically\n",
+		 pixel_clk);
+
+	return hdmi_compute_n(hdmi, freq, pixel_clk);
 }
 
 static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
@@ -588,7 +709,7 @@ static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
 	u8 config3;
 	u64 tmp;
 
-	n = hdmi_compute_n(sample_rate, pixel_clk);
+	n = hdmi_find_n(hdmi, sample_rate, pixel_clk);
 
 	config3 = hdmi_readb(hdmi, HDMI_CONFIG3_ID);
 
-- 
2.22.0.410.gd8fdbe21b5-goog

