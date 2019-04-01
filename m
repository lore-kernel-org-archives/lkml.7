Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED289C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0332084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n4war+3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbfDARSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:18:10 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40016 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731282AbfDARR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:17:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so1825599plr.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E8IUBh2t3q/gZip595rgxxfTnEAlJdLlEiDkGG8UPQc=;
        b=n4war+3TYvTWQtIFzamwi0I1IGjDuVEQajeX6wZ0m79OJvpTpOBcQxQzyz1fUVtPkA
         0Ogp7I4JAPaZPQpC0FnDR2UM1bhkLujej0eK9rLSiFSFnIucAjd7VmI8RovCbA619CiS
         51elLbTBukwi6mBA22dQ/6+eCjawtao2LjodM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E8IUBh2t3q/gZip595rgxxfTnEAlJdLlEiDkGG8UPQc=;
        b=DUveP+q+uFIYja/hK+kFueZFTw0EXwgGgI/m9eySuW4S28hsO7cwIIlBVm8uAlpiyx
         hZkBgvZO66Vi4VA9ZsgUWmyTHYGoSU61CeKiioj90YCwdiySDqXrRe3fDdPETZXk58RA
         8auW19prkp+3fILFOLNL79LlMvQ8ddyVzvOM9o8mzQyjBzVv4K5ezeaFO4yowAj40FnD
         Gd6pTotP6XY45B7VuTeMvG9/+uoEyo8npGslEeQj1IEm2wOkPHrjitZB708liObJ9/l6
         DTjZTd66XZ4U+143BY9D/Qjx+iVl7CogY7lOb/D1BNz7MtPeLg45MvxXXg5Iotp/Tpe0
         le/A==
X-Gm-Message-State: APjAAAWQ5zVYoxy+/GR3j4+y2uKrhrgwjwiRs7enqYNKXpRnAJ7xVicr
        pTOUb9M2cqZYsMxgBqoxOuWELw==
X-Google-Smtp-Source: APXvYqxng9dGnz4+/iq6MwJNWBWqwWstpaeHh6nSrd3tkiYwPL0XTYP3/67fPRrxvgHBRQJyWDu5Yw==
X-Received: by 2002:a17:902:248:: with SMTP id 66mr66531817plc.286.1554139077705;
        Mon, 01 Apr 2019 10:17:57 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id y12sm31370112pgq.64.2019.04.01.10.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 10:17:56 -0700 (PDT)
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
Subject: [PATCH v5 4/7] drm/panel: simple: Use display_timing for Innolux n116bge
Date:   Mon,  1 Apr 2019 10:17:21 -0700
Message-Id: <20190401171724.215780-5-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190401171724.215780-1-dianders@chromium.org>
References: <20190401171724.215780-1-dianders@chromium.org>
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

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Heiko Stuebner <heiko@sntech.de>
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

