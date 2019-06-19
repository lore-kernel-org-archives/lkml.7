Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD205C31E5D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9D3214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkdFoaLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbfFSF1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:27:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32889 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730869AbfFSF1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 01:27:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id x15so9034574pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 22:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Akle6y5Ep7rFNVGLMTSwmafUZ9qmAy4VhCdVrLXo+fY=;
        b=IkdFoaLIwjNHlfqHE/Xv8rztb4p0Q6xt8GboT8FTVbJdMfFvNC82PteS2n2XfAhqs1
         DR6+TmeWhWwF8ybOCN64+SyIbqE8p1tSbBGSAfJgws41YsBkTBjx0pELMMbOhdCAaZz6
         Z++F2KHp0cdrjNPc5lYubefUKgJf9RmizT/hmcHtb3iFvphMfuwVg63Zp6bImnyWII9O
         jg7PQn7oDbXbk4A8bzTxmkeAEUBvfJcx5qAUy8ZKce04XLv0zL2M4W2QQGodBeByn8e0
         EcsosucPH0wlH1tV5KXz2OPlJusXSNDqhF4mM9z+buLs91GjuwrgfSkIbDq4oJ6sK4+1
         iHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Akle6y5Ep7rFNVGLMTSwmafUZ9qmAy4VhCdVrLXo+fY=;
        b=YPwtw9LPjb5Gz9tCT2OA3Md97iRQZqwAWUKFq9kw/ZKQtSeCgW/GCzcVqLfdYpYixe
         4Q3OnSEoYUMyDzGspxC7kuuHcMOjzLH7NFi0AlBwbegJBP4x2jrs+uIBgJ8ZGas61chY
         T9v5n4qBSO8nGdqfH4zAzPwtgQ3hagHQYTLZ4ihBFS7wlPNI6ZeMLRYW0Hp6AiIyQ8wQ
         RkGwJHOuZl9iIefeg/SVRw3Fk9+wJKQcM7dpKofgQ9Nr1tENDBmfR00m2qC5t7xwOe2S
         d6E4bd0IihT4sdjqo39Iwm1b46mF0w8EJlnsIDTfBzgVnUvtW838UHHE/+lXQbwd/1yA
         I0gg==
X-Gm-Message-State: APjAAAWG7d0zbkTEPWg7KE2LSVESG+EyvUTVfETVYE0Rlw27+dTy6LFd
        A1O8vSAyINbw+l129Q/LGzU=
X-Google-Smtp-Source: APXvYqy7QtJbwB6udp4lh2XsJ05Xhc8YbW42jwKJTVZ4AqnXIZ56BMq1/AmfBZ6C7a12yITiyF+1lg==
X-Received: by 2002:a63:4f07:: with SMTP id d7mr5963196pgb.77.1560922058095;
        Tue, 18 Jun 2019 22:27:38 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l44sm534742pje.29.2019.06.18.22.27.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 22:27:37 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 04/15] drm/bridge: tc358767: Simplify tc_set_video_mode()
Date:   Tue, 18 Jun 2019 22:27:05 -0700
Message-Id: <20190619052716.16831-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619052716.16831-1-andrew.smirnov@gmail.com>
References: <20190619052716.16831-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify tc_set_video_mode() by replacing explicit shifting using
macros from <linux/bitfield.h>. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 106 ++++++++++++++++++++++--------
 1 file changed, 78 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 31f5045e7e42..5b78021d6c5b 100644
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
 
@@ -108,14 +118,28 @@
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
 
@@ -192,6 +216,12 @@
 
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
@@ -672,6 +702,7 @@ static int tc_set_video_mode(struct tc_data *tc,
 	int upper_margin = mode->vtotal - mode->vsync_end;
 	int lower_margin = mode->vsync_start - mode->vdisplay;
 	int vsync_len = mode->vsync_end - mode->vsync_start;
+	u32 dp0_syncval;
 
 	/*
 	 * Recommended maximum number of symbols transferred in a transfer unit:
@@ -696,50 +727,69 @@ static int tc_set_video_mode(struct tc_data *tc,
 	 * assume we do not need any delay when DPI is a source of
 	 * sync signals
 	 */
-	tc_write(VPCTRL0, (0 << 20) /* VSDELAY */ |
+	tc_write(VPCTRL0,
+		 FIELD_PREP(VSDELAY, 0) |
 		 OPXLFMT_RGB888 | FRMSYNC_DISABLED | MSF_DISABLED);
-	tc_write(HTIM01, (ALIGN(left_margin, 2) << 16) | /* H back porch */
-			 (ALIGN(hsync_len, 2) << 0));	 /* Hsync */
-	tc_write(HTIM02, (ALIGN(right_margin, 2) << 16) |  /* H front porch */
-			 (ALIGN(mode->hdisplay, 2) << 0)); /* width */
-	tc_write(VTIM01, (upper_margin << 16) |		/* V back porch */
-			 (vsync_len << 0));		/* Vsync */
-	tc_write(VTIM02, (lower_margin << 16) |		/* V front porch */
-			 (mode->vdisplay << 0));	/* height */
+	tc_write(HTIM01,
+		 FIELD_PREP(HBPR, ALIGN(left_margin, 2)) |
+		 FIELD_PREP(HPW, ALIGN(hsync_len, 2)));
+	tc_write(HTIM02,
+		 FIELD_PREP(HDISPR, ALIGN(mode->hdisplay, 2)) |
+		 FIELD_PREP(HFPR, ALIGN(right_margin, 2)));
+	tc_write(VTIM01,
+		 FIELD_PREP(VBPR, upper_margin) |
+		 FIELD_PREP(VSPR, vsync_len));
+	tc_write(VTIM02,
+		 FIELD_PREP(VFPR, lower_margin) |
+		 FIELD_PREP(VDISPR, mode->vdisplay));
 	tc_write(VFUEN0, VFUEN);		/* update settings */
 
 	/* Test pattern settings */
 	tc_write(TSTCTL,
-		 (120 << 24) |	/* Red Color component value */
-		 (20 << 16) |	/* Green Color component value */
-		 (99 << 8) |	/* Blue Color component value */
-		 (1 << 4) |	/* Enable I2C Filter */
-		 (2 << 0) |	/* Color bar Mode */
-		 0);
+		 FIELD_PREP(COLOR_R, 120) |
+		 FIELD_PREP(COLOR_G, 20) |
+		 FIELD_PREP(COLOR_B, 99) |
+		 ENI2CFILTER |
+		 FIELD_PREP(COLOR_BAR_MODE, COLOR_BAR_MODE_BARS));
 
 	/* DP Main Stream Attributes */
 	vid_sync_dly = hsync_len + left_margin + mode->hdisplay;
 	tc_write(DP0_VIDSYNCDELAY,
-		 (max_tu_symbol << 16) |	/* thresh_dly */
-		 (vid_sync_dly << 0));
+		 FIELD_PREP(THRESH_DLY, max_tu_symbol) |
+		 FIELD_PREP(VID_SYNC_DLY, vid_sync_dly));
 
-	tc_write(DP0_TOTALVAL, (mode->vtotal << 16) | (mode->htotal));
+	tc_write(DP0_TOTALVAL,
+		 FIELD_PREP(H_TOTAL, mode->htotal) |
+		 FIELD_PREP(V_TOTAL, mode->vtotal));
 
 	tc_write(DP0_STARTVAL,
-		 ((upper_margin + vsync_len) << 16) |
-		 ((left_margin + hsync_len) << 0));
+		 FIELD_PREP(H_START, left_margin + hsync_len) |
+		 FIELD_PREP(V_START, upper_margin + vsync_len));
+
+	tc_write(DP0_ACTIVEVAL,
+		 FIELD_PREP(V_ACT, mode->vdisplay) |
+		 FIELD_PREP(H_ACT, mode->hdisplay));
+
+	dp0_syncval = FIELD_PREP(VS_WIDTH, vsync_len) |
+		      FIELD_PREP(HS_WIDTH, hsync_len);
+
+	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
+		dp0_syncval |= SYNCVAL_VS_POL_ACTIVE_LOW;
 
-	tc_write(DP0_ACTIVEVAL, (mode->vdisplay << 16) | (mode->hdisplay));
+	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
+		dp0_syncval |= SYNCVAL_HS_POL_ACTIVE_LOW;
 
-	tc_write(DP0_SYNCVAL, (vsync_len << 16) | (hsync_len << 0) |
-		 ((mode->flags & DRM_MODE_FLAG_NHSYNC) ? SYNCVAL_HS_POL_ACTIVE_LOW : 0) |
-		 ((mode->flags & DRM_MODE_FLAG_NVSYNC) ? SYNCVAL_VS_POL_ACTIVE_LOW : 0));
+	tc_write(DP0_SYNCVAL, dp0_syncval);
 
-	tc_write(DPIPXLFMT, VS_POL_ACTIVE_LOW | HS_POL_ACTIVE_LOW |
-		 DE_POL_ACTIVE_HIGH | SUB_CFG_TYPE_CONFIG1 | DPI_BPP_RGB888);
+	tc_write(DPIPXLFMT,
+		 VS_POL_ACTIVE_LOW | HS_POL_ACTIVE_LOW |
+		 DE_POL_ACTIVE_HIGH | SUB_CFG_TYPE_CONFIG1 |
+		 DPI_BPP_RGB888);
 
-	tc_write(DP0_MISC, (max_tu_symbol << 23) | (TU_SIZE_RECOMMENDED << 16) |
-			   BPC_8);
+	tc_write(DP0_MISC,
+		 FIELD_PREP(MAX_TU_SYMBOL, max_tu_symbol) |
+		 FIELD_PREP(TU_SIZE, TU_SIZE_RECOMMENDED) |
+		 BPC_8);
 
 	return 0;
 err:
-- 
2.21.0

