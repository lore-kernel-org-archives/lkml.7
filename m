Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F62C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A6521900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca8nq4Pu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfCVD3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:29:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40812 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbfCVD3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 23:29:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so528553pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 20:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RmECaIExxqXREvIe9qEnM7qmcgOtvO67MNGpi32cy5k=;
        b=Ca8nq4PuZDgeGd1RzmpTDVuoUFHnNkGkg0pghXvTkNfCYsJk18JJm3o6HAK+QFo/ML
         drpV2Cyi/1mGCGHK2+pbDLcXc8k7oBu7QqwIpa7qPZQ2Ao8tNXquYIGmmicKNdwTOxIr
         GVXIFCua55rP9BBlXQZE2mJgHUOul+Pk4X5Vif4ERoQNowIRZKgoSOLVBwm8XDM4Ok8b
         n07PnPYIoCV+k+lXIgBG0oqKgV+n5YTPWLeKHMQOTWoYP4Xz69OHgx19oIpK1+4OGVk2
         1mgUfxOmKrzzQF3a6UYYzh5ofTLyHW282ySd13kLYro72yvo7oExNaBHY55iQ23THx8z
         ebew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RmECaIExxqXREvIe9qEnM7qmcgOtvO67MNGpi32cy5k=;
        b=H4NxQG20yRFTh44jNUg6/cy3kCExIGr0ohMxCA6d1PXAA+F0rWAqwrpxOlLI2IpR56
         DJiqhjU0iH0kZZYgcHTISXaH4k6sxElZFhlW/wDRLUWN30OWgWxcJhidF20m+oCPc3ao
         0RoOPps9MIuQFU9NoIhBqcMewWKzVQ5PWjaHfrkWwjZ43HLlPAJ/32/BpyaYl7x3GEb5
         xph5w4XW8YvDoddPyrZ2TwA/MsdlZdinLMnnmaErd3xsyRMBX7ndpnqcV/yhINldZ3y7
         o2AnXnFOF4R1YZlW4yfmtpBToOADfuStz/P9KcQqOjVoJRNFbGc/Ux+m9plm5Gebgq6N
         6VAg==
X-Gm-Message-State: APjAAAUaxX1c/JnINvFlRun3PuiBxBLNYw7MJ9GqE6kxU935RkKsTu2y
        Ix9DkHzMAmWYGjgPko42/lo=
X-Google-Smtp-Source: APXvYqyZpUCyV5o9aH0RzebR7JSszjSlXK201lqWYa73a/Ss1YLEyvGE4/90J52vBEdVGessu8NPQA==
X-Received: by 2002:a63:4287:: with SMTP id p129mr6500071pga.84.1553225359840;
        Thu, 21 Mar 2019 20:29:19 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id o76sm16154476pfa.156.2019.03.21.20.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 20:29:19 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/15] drm/bridge: tc358767: Simplify tc_set_video_mode()
Date:   Thu, 21 Mar 2019 20:28:50 -0700
Message-Id: <20190322032901.12045-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322032901.12045-1-andrew.smirnov@gmail.com>
References: <20190322032901.12045-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify tc_set_video_mode() by replacing repreated calls to
tc_write()/regmap_write() with a single call to
regmap_multi_reg_write(). While at it, simplify explicit shifting by
using macros from <linux/bitfield.h>. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 146 +++++++++++++++++-------------
 1 file changed, 85 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 38d542f553cd..d99c9f32a133 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -24,6 +24,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
@@ -56,6 +57,7 @@
 
 /* Video Path */
 #define VPCTRL0			0x0450
+#define VSDELAY			GENMASK(31, 20)
 #define OPXLFMT_RGB666			(0 << 8)
 #define OPXLFMT_RGB888			(1 << 8)
 #define FRMSYNC_DISABLED		(0 << 4) /* Video Timing Gen Disabled */
@@ -63,9 +65,17 @@
 #define MSF_DISABLED			(0 << 0) /* Magic Square FRC disabled */
 #define MSF_ENABLED			(1 << 0) /* Magic Square FRC enabled */
 #define HTIM01			0x0454
+#define HPW			GENMASK(8, 0)
+#define HBPR			GENMASK(24, 16)
 #define HTIM02			0x0458
+#define HDISPR			GENMASK(10, 0)
+#define HFPR			GENMASK(24, 16)
 #define VTIM01			0x045c
+#define VSPR			GENMASK(7, 0)
+#define VBPR			GENMASK(23, 16)
 #define VTIM02			0x0460
+#define VFPR			GENMASK(23, 16)
+#define VDISPR			GENMASK(10, 0)
 #define VFUEN0			0x0464
 #define VFUEN				BIT(0)   /* Video Frame Timing Upload */
 
@@ -100,14 +110,28 @@
 /* Main Channel */
 #define DP0_SECSAMPLE		0x0640
 #define DP0_VIDSYNCDELAY	0x0644
+#define VID_SYNC_DLY		GENMASK(15, 0)
+#define THRESH_DLY		GENMASK(31, 16)
+
 #define DP0_TOTALVAL		0x0648
+#define H_TOTAL			GENMASK(15, 0)
+#define V_TOTAL			GENMASK(31, 16)
 #define DP0_STARTVAL		0x064c
+#define H_START			GENMASK(15, 0)
+#define V_START			GENMASK(31, 16)
 #define DP0_ACTIVEVAL		0x0650
+#define H_ACT			GENMASK(15, 0)
+#define V_ACT			GENMASK(31, 16)
+
 #define DP0_SYNCVAL		0x0654
+#define VS_WIDTH		GENMASK(30, 16)
+#define HS_WIDTH		GENMASK(14, 0)
 #define SYNCVAL_HS_POL_ACTIVE_LOW	(1 << 15)
 #define SYNCVAL_VS_POL_ACTIVE_LOW	(1 << 31)
 #define DP0_MISC		0x0658
 #define TU_SIZE_RECOMMENDED		(63) /* LSCLK cycles per TU */
+#define MAX_TU_SYMBOL		GENMASK(28, 23)
+#define TU_SIZE			GENMASK(21, 16)
 #define BPC_6				(0 << 5)
 #define BPC_8				(1 << 5)
 
@@ -184,6 +208,12 @@
 
 /* Test & Debug */
 #define TSTCTL			0x0a00
+#define COLOR_R			GENMASK(31, 24)
+#define COLOR_G			GENMASK(23, 16)
+#define COLOR_B			GENMASK(15, 8)
+#define ENI2CFILTER		BIT(4)
+#define COLOR_BAR_MODE		GENMASK(1, 0)
+#define COLOR_BAR_MODE_BARS	2
 #define PLL_DBG			0x0a04
 
 static bool tc_test_pattern;
@@ -647,10 +677,6 @@ static int tc_get_display_props(struct tc_data *tc)
 
 static int tc_set_video_mode(struct tc_data *tc, struct drm_display_mode *mode)
 {
-	int ret;
-	int vid_sync_dly;
-	int max_tu_symbol;
-
 	int left_margin = mode->htotal - mode->hsync_end;
 	int right_margin = mode->hsync_start - mode->hdisplay;
 	int hsync_len = mode->hsync_end - mode->hsync_start;
@@ -659,76 +685,74 @@ static int tc_set_video_mode(struct tc_data *tc, struct drm_display_mode *mode)
 	int vsync_len = mode->vsync_end - mode->vsync_start;
 
 	/*
-	 * Recommended maximum number of symbols transferred in a transfer unit:
+	 * Recommended maximum number of symbols transferred in a
+	 * transfer unit:
 	 * DIV_ROUND_UP((input active video bandwidth in bytes) * tu_size,
 	 *              (output active video bandwidth in bytes))
 	 * Must be less than tu_size.
 	 */
-	max_tu_symbol = TU_SIZE_RECOMMENDED - 1;
-
-	dev_dbg(tc->dev, "set mode %dx%d\n",
-		mode->hdisplay, mode->vdisplay);
-	dev_dbg(tc->dev, "H margin %d,%d sync %d\n",
-		left_margin, right_margin, hsync_len);
-	dev_dbg(tc->dev, "V margin %d,%d sync %d\n",
-		upper_margin, lower_margin, vsync_len);
-	dev_dbg(tc->dev, "total: %dx%d\n", mode->htotal, mode->vtotal);
-
+	int max_tu_symbol = TU_SIZE_RECOMMENDED - 1;
 
+	/* DP Main Stream Attributes */
+	int vid_sync_dly = hsync_len + left_margin + mode->hdisplay;
 	/*
 	 * LCD Ctl Frame Size
 	 * datasheet is not clear of vsdelay in case of DPI
 	 * assume we do not need any delay when DPI is a source of
 	 * sync signals
 	 */
-	tc_write(VPCTRL0, (0 << 20) /* VSDELAY */ |
-		 OPXLFMT_RGB888 | FRMSYNC_DISABLED | MSF_DISABLED);
-	tc_write(HTIM01, (ALIGN(left_margin, 2) << 16) | /* H back porch */
-			 (ALIGN(hsync_len, 2) << 0));	 /* Hsync */
-	tc_write(HTIM02, (ALIGN(right_margin, 2) << 16) |  /* H front porch */
-			 (ALIGN(mode->hdisplay, 2) << 0)); /* width */
-	tc_write(VTIM01, (upper_margin << 16) |		/* V back porch */
-			 (vsync_len << 0));		/* Vsync */
-	tc_write(VTIM02, (lower_margin << 16) |		/* V front porch */
-			 (mode->vdisplay << 0));	/* height */
-	tc_write(VFUEN0, VFUEN);		/* update settings */
-
-	/* Test pattern settings */
-	tc_write(TSTCTL,
-		 (120 << 24) |	/* Red Color component value */
-		 (20 << 16) |	/* Green Color component value */
-		 (99 << 8) |	/* Blue Color component value */
-		 (1 << 4) |	/* Enable I2C Filter */
-		 (2 << 0) |	/* Color bar Mode */
-		 0);
-
-	/* DP Main Stream Attributes */
-	vid_sync_dly = hsync_len + left_margin + mode->hdisplay;
-	tc_write(DP0_VIDSYNCDELAY,
-		 (max_tu_symbol << 16) |	/* thresh_dly */
-		 (vid_sync_dly << 0));
+	const u32 vs_pol = mode->flags & DRM_MODE_FLAG_NVSYNC ?
+		SYNCVAL_VS_POL_ACTIVE_LOW : 0;
+	const u32 hs_pol = mode->flags & DRM_MODE_FLAG_NHSYNC ?
+		SYNCVAL_HS_POL_ACTIVE_LOW : 0;
+	const struct reg_sequence video_mode_settings[] = {
+		{ VPCTRL0, FIELD_PREP(VSDELAY, 0) |
+			   OPXLFMT_RGB888 | FRMSYNC_DISABLED | MSF_DISABLED },
+		{ HTIM01, FIELD_PREP(HBPR, ALIGN(left_margin, 2)) |
+			  FIELD_PREP(HPW, ALIGN(hsync_len, 2)) },
+		{ HTIM02, FIELD_PREP(HDISPR, ALIGN(mode->hdisplay, 2)) |
+			  FIELD_PREP(HFPR, ALIGN(right_margin, 2)) },
+		{ VTIM01, FIELD_PREP(VBPR, upper_margin) |
+			  FIELD_PREP(VSPR, vsync_len) },
+		{ VTIM02, FIELD_PREP(VFPR, lower_margin) |
+			  FIELD_PREP(VDISPR, mode->vdisplay) },
+		{ VFUEN0, VFUEN },
+		{ TSTCTL, FIELD_PREP(COLOR_R, 120) |
+			  FIELD_PREP(COLOR_G, 20) |
+			  FIELD_PREP(COLOR_B, 99) |
+			  ENI2CFILTER |
+			  FIELD_PREP(COLOR_BAR_MODE, COLOR_BAR_MODE_BARS) },
+		{ DP0_VIDSYNCDELAY, FIELD_PREP(THRESH_DLY, max_tu_symbol) |
+				    FIELD_PREP(VID_SYNC_DLY, vid_sync_dly) },
+		{ DP0_TOTALVAL, FIELD_PREP(H_TOTAL, mode->htotal) |
+				FIELD_PREP(V_TOTAL, mode->vtotal) },
+		{ DP0_STARTVAL, FIELD_PREP(H_START, left_margin + hsync_len) |
+				FIELD_PREP(V_START,
+					   upper_margin + vsync_len) },
+		{ DP0_ACTIVEVAL, FIELD_PREP(V_ACT, mode->vdisplay) |
+				 FIELD_PREP(H_ACT, mode->hdisplay) },
+		{ DP0_SYNCVAL, FIELD_PREP(VS_WIDTH, vsync_len) |
+			       FIELD_PREP(HS_WIDTH, hsync_len) |
+			       hs_pol | vs_pol },
+		{ DPIPXLFMT, VS_POL_ACTIVE_LOW | HS_POL_ACTIVE_LOW |
+			     DE_POL_ACTIVE_HIGH | SUB_CFG_TYPE_CONFIG1 |
+			     DPI_BPP_RGB888 },
+		{ DP0_MISC, FIELD_PREP(MAX_TU_SYMBOL, max_tu_symbol) |
+			    FIELD_PREP(TU_SIZE, TU_SIZE_RECOMMENDED) |
+			    BPC_8 },
+	};
 
-	tc_write(DP0_TOTALVAL, (mode->vtotal << 16) | (mode->htotal));
-
-	tc_write(DP0_STARTVAL,
-		 ((upper_margin + vsync_len) << 16) |
-		 ((left_margin + hsync_len) << 0));
-
-	tc_write(DP0_ACTIVEVAL, (mode->vdisplay << 16) | (mode->hdisplay));
-
-	tc_write(DP0_SYNCVAL, (vsync_len << 16) | (hsync_len << 0) |
-		 ((mode->flags & DRM_MODE_FLAG_NHSYNC) ? SYNCVAL_HS_POL_ACTIVE_LOW : 0) |
-		 ((mode->flags & DRM_MODE_FLAG_NVSYNC) ? SYNCVAL_VS_POL_ACTIVE_LOW : 0));
-
-	tc_write(DPIPXLFMT, VS_POL_ACTIVE_LOW | HS_POL_ACTIVE_LOW |
-		 DE_POL_ACTIVE_HIGH | SUB_CFG_TYPE_CONFIG1 | DPI_BPP_RGB888);
-
-	tc_write(DP0_MISC, (max_tu_symbol << 23) | (TU_SIZE_RECOMMENDED << 16) |
-			   BPC_8);
+	dev_dbg(tc->dev, "set mode %dx%d\n",
+		mode->hdisplay, mode->vdisplay);
+	dev_dbg(tc->dev, "H margin %d,%d sync %d\n",
+		left_margin, right_margin, hsync_len);
+	dev_dbg(tc->dev, "V margin %d,%d sync %d\n",
+		upper_margin, lower_margin, vsync_len);
+	dev_dbg(tc->dev, "total: %dx%d\n", mode->htotal, mode->vtotal);
 
-	return 0;
-err:
-	return ret;
+	return regmap_multi_reg_write(tc->regmap,
+				      video_mode_settings,
+				      ARRAY_SIZE(video_mode_settings));
 }
 
 static int tc_wait_link_training(struct tc_data *tc, u32 *error)
-- 
2.20.1

