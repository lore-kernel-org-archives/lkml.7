Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D27DC742A4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432B6216B7
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hvexTuQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfGKUpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 16:45:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41938 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbfGKUpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 16:45:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so3289679pff.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 13:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VfaHreQJcWraasyrZf5GYXDtQSYM018DK4KSurxUpUw=;
        b=hvexTuQKGLRO3Fn84YVxKLHAYdxljfkDhao9Vd9ieD5AWFmbNzn5IV1OyNsN6HXeL2
         r0ogXqxfy5s8dSmINinMnqm8OpLpSh+KQ4R1GQEoWtqjEPFgFzIqMhWsQLQUIJRkgHrB
         CsDqKbgM6S7ob7Hg0g1fTJloOZdwYjJZ36+3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VfaHreQJcWraasyrZf5GYXDtQSYM018DK4KSurxUpUw=;
        b=AS8xY47cZBJP6K3SbTkG0xP+S57bf09yTu8AxsT+MusTXLP0lnnP+y0RD5xbmb/000
         JlA2NMxdCz4ezXIUs1jZLHDlfYwLlqhwVpvuwSxKQwQuAqvuA5AEFervwksVX6sNu/Wh
         jkD3Nk+b6mpH89G0ANQIw9DpTa8eiCri9PqYUU1F8t6Q8MThryPX3zjCxp8kqle8cGHT
         Y+uPc5evx4IcP+IvSp18sQmVr9z6gfRy0fCAkkE/Bqy88bAvW35Czxr4rX4tvNcP/lNk
         B9Zs+GgnQECf4QI4XeGOF9b58q9MRrNhhWvsEULFN+zCHEkjTiCwVaYyHarhdi9PAtnM
         67TA==
X-Gm-Message-State: APjAAAXgpz1qRbyGZHp4yL+PJDbrmXs1s1J0ZjVVnE/vi5wUpSiPGu7P
        syD/BjhD4y5AZlmvRewTVbdRPw==
X-Google-Smtp-Source: APXvYqxOY3wTdInDeKC1jqap/V+JnRXP3q+NQTckRaGJIqycyvEMdNoUrVlPSb+qVZy4DvPgTChwZA==
X-Received: by 2002:a63:5823:: with SMTP id m35mr6509315pgb.329.1562877902320;
        Thu, 11 Jul 2019 13:45:02 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id f17sm5320110pgv.16.2019.07.11.13.45.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 13:45:01 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        mka@chromium.org, Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v6 2/3] drm/panel: simple: Use display_timing for Innolux n116bge
Date:   Thu, 11 Jul 2019 13:34:54 -0700
Message-Id: <20190711203455.125667-3-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190711203455.125667-1-dianders@chromium.org>
References: <20190711203455.125667-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Innolux n116bge from using a fixed mode to specifying a
display timing with min/typ/max values.

Note that the n116bge's datasheet doesn't fit too well into DRM's way
of specifying things.  Specifically the panel's datasheet just
specifies the vertical blanking period and horizontal blanking period
and doesn't break things out.  For now we'll leave everything as a
fixed value but just allow adjusting the pixel clock.  I've added a
comment on what the datasheet claims so someone could later expand
things to fit their needs if they wanted to test other blanking
periods.

The goal here is to be able to specify the panel timings in the device
tree for several rk3288 Chromebooks (like rk3288-veryon-jerry).  These
Chromebooks have all been running in the downstream kernel with the
standard porches and sync lengths but just with a slightly slower
pixel clock because the 76.42 MHz clock is not achievable from the
fixed PLL that was available.  These Chromebooks only achieve a
refresh rate of ~58 Hz.  While it's probable that we could adjust the
timings to achieve 60 Hz it's probably wisest to match what's been
running on these devices all these years.

I'll note that though the upstream kernel has always tried to achieve
76.42 MHz, it has actually been running at 74.25 MHz also since the
video processor is parented off the same fixed PLL.

Changes in v4:
 - display_timing for Innolux n116bge new for v4.
Changes in v5:
 - Added Heiko's Tested-by
Changes in v6:
 - Rebased to drm-misc next
 - Added tags

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
---

 drivers/gpu/drm/panel/panel-simple.c | 37 +++++++++++++++++-----------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 1bee197821ef..602809f6da6a 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1702,23 +1702,32 @@ static const struct panel_desc innolux_g121x1_l03 = {
 	},
 };
 
-static const struct drm_display_mode innolux_n116bge_mode = {
-	.clock = 76420,
-	.hdisplay = 1366,
-	.hsync_start = 1366 + 136,
-	.hsync_end = 1366 + 136 + 30,
-	.htotal = 1366 + 136 + 30 + 60,
-	.vdisplay = 768,
-	.vsync_start = 768 + 8,
-	.vsync_end = 768 + 8 + 12,
-	.vtotal = 768 + 8 + 12 + 12,
-	.vrefresh = 60,
-	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+/*
+ * Datasheet specifies that at 60 Hz refresh rate:
+ * - total horizontal time: { 1506, 1592, 1716 }
+ * - total vertical time: { 788, 800, 868 }
+ *
+ * ...but doesn't go into exactly how that should be split into a front
+ * porch, back porch, or sync length.  For now we'll leave a single setting
+ * here which allows a bit of tweaking of the pixel clock at the expense of
+ * refresh rate.
+ */
+static const struct display_timing innolux_n116bge_timing = {
+	.pixelclock = { 72600000, 76420000, 80240000 },
+	.hactive = { 1366, 1366, 1366 },
+	.hfront_porch = { 136, 136, 136 },
+	.hback_porch = { 60, 60, 60 },
+	.hsync_len = { 30, 30, 30 },
+	.vactive = { 768, 768, 768 },
+	.vfront_porch = { 8, 8, 8 },
+	.vback_porch = { 12, 12, 12 },
+	.vsync_len = { 12, 12, 12 },
+	.flags = DISPLAY_FLAGS_VSYNC_LOW | DISPLAY_FLAGS_HSYNC_LOW,
 };
 
 static const struct panel_desc innolux_n116bge = {
-	.modes = &innolux_n116bge_mode,
-	.num_modes = 1,
+	.timings = &innolux_n116bge_timing,
+	.num_timings = 1,
 	.bpc = 6,
 	.size = {
 		.width = 256,
-- 
2.22.0.410.gd8fdbe21b5-goog

