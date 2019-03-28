Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD98C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5193C206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gQTAHz+S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfC1RSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:18:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41066 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbfC1RSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:18:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so7788012pgs.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nsRpfsdyMTkMnFUNu1Wp8cUGd1lKidfD+mYO4oqqgyQ=;
        b=gQTAHz+SMdXUUM060+YKchvBNQp42HjJxGxbWacDzG9NBvJ2UK19OaYEySWAkzMhK/
         xapUYIalwcpv93qzwrs0HifL0mXjIq7pqADKLvGgOdqGqKMUmRzVTbs61Zz+igcPuUy9
         wjY4L52bMSa9pCwUyVmsxUIohmN9VexNycJ3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nsRpfsdyMTkMnFUNu1Wp8cUGd1lKidfD+mYO4oqqgyQ=;
        b=CpItaxnV/iSIe43vwMwCuYS7dcAMC0J6j1xn7AXj0Tk2PoRlWab4+G1CoqVFjm5Z20
         tQ26zMZsuB7htkJeCWoZb7sfuemLwqJeAYys8xW2obo0TgG0zcRwcjCkayQgIzmV0KaE
         oubGeSJPTdPDlF5O7zcX4Db6aGMQF70UEuTKm5dKIIAStvvXJ1XFELKGkL/VtrIoBdkk
         FaNE5xvlYuvk54wbnG0SNWjbmMuIxbawpQNrhEpYBx+8fsDeJK4XXSDsLC3P8LIkxNN/
         5A9906fSUz/qOe0ka4N03KcLM6Y03ZpeZdu295DNTjwcvAGpVZaMZxWRKXR3G/aoHvFj
         wsUA==
X-Gm-Message-State: APjAAAWr17Uk9ziKV7K6UO5YGzXlWJ1+CwGtCMXQTEzNErzD0w4zdgld
        Mo60Nwdzrz5xhTZASSjwrZnisA==
X-Google-Smtp-Source: APXvYqwrs35yhWJPH4h/TmTr4EHdltzyfib+v4BdQLi4vulH6ML05v+urVuN/FQFV7ec9W/ryiy/9Q==
X-Received: by 2002:a62:19c3:: with SMTP id 186mr41029603pfz.172.1553793479936;
        Thu, 28 Mar 2019 10:17:59 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id r10sm31699414pfn.188.2019.03.28.10.17.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 10:17:59 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>
Cc:     linux-rockchip@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        =?UTF-8?q?Enric=20Balletb=C3=B2?= <enric.balletbo@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, mka@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v4 4/7] drm/panel: simple: Use display_timing for Innolux n116bge
Date:   Thu, 28 Mar 2019 10:17:07 -0700
Message-Id: <20190328171710.31949-5-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190328171710.31949-1-dianders@chromium.org>
References: <20190328171710.31949-1-dianders@chromium.org>
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

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-simple.c | 37 +++++++++++++++++-----------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index ad4f4aac2d44..7d407fab3628 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1550,23 +1550,32 @@ static const struct panel_desc innolux_g121x1_l03 = {
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
2.21.0.392.gf8f6787159e-goog

