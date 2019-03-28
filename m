Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C50AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2F3206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ahyaqNIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfC1RSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:18:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45261 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbfC1RSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:18:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id bf11so5267245plb.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 10:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9+yEi+eZPRH+2tNF2bctolAJluO+BQKUE1OpVezDcSA=;
        b=ahyaqNIJ3nvuHeJExphO1VeO7qSbhDDfzZtyX0NUYDMICqgtM1FMOHWoIt8X0eVJkU
         sLIofNxE3B9lS+QfPHYljZI1B1UYHuR68sEnfynCLhiB3wVJ8yRVOiXJEw4BYJV6qkUG
         cHD4O/9ddvUdyqk70Dzc5xW17c2feKrQKBSE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+yEi+eZPRH+2tNF2bctolAJluO+BQKUE1OpVezDcSA=;
        b=p7X1ltIq1yThq78MO6K/xVJOMpIjLsgCn9t0FRCo9STIlWNo7xdk9W3y5urK+JQJsv
         wE9wo3IDZUOpxyOTEq7+xfgqXYs49xUAIggh3Q4yh1v1O0fOeY5WGOHwPfGx4WqMStpd
         cC0b7j2504beRQ0uyNHC/g4ncK5ln573n0rudrEGr93xdKvpq4tLmivjowURTLnIdHlV
         RbYTfkldSbG9xwLnLtMiRUPGf84+takuZ7x+gYgaEkhx5VdxlQOZKozYLvyNNQakfZrp
         xtZoomrgwsrIqLxidwhByTA0io1gksq5mbY6as1suWnMbHY9kjev6aEBDrhgIoclj6xK
         u0rg==
X-Gm-Message-State: APjAAAU1mT3vRegp9FQ4eX50sCToPS6yF1yAGSTR/Zt0fJw/zKsMX/Wc
        sndPXNLTgx/9RoynMXqGohPHTg==
X-Google-Smtp-Source: APXvYqz+Bkkp+PP/tk6oZi4XfOa5OgocGBwGFvtt3gL1hPkppHgW5RmeCuO7qgvi9MsMhPiTQjbjlA==
X-Received: by 2002:a17:902:b181:: with SMTP id s1mr43707502plr.321.1553793481001;
        Thu, 28 Mar 2019 10:18:01 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id r10sm31699414pfn.188.2019.03.28.10.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 10:18:00 -0700 (PDT)
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
Subject: [PATCH v4 5/7] drm/panel: simple: Use display_timing for AUO b101ean01
Date:   Thu, 28 Mar 2019 10:17:08 -0700
Message-Id: <20190328171710.31949-6-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190328171710.31949-1-dianders@chromium.org>
References: <20190328171710.31949-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the AUO b101ean01 from using a fixed mode to specifying a
display timing with min/typ/max values.

The AUO b101ean01's datasheet says:
* Vertical blanking min is 12
* Horizontal blanking min is 60
* Pixel clock is between 65.3 MHz and 75 MHz

The goal here is to be able to specify the proper timing in device
tree to use on rk3288-veyron-minnie to match what the downstream
kernel is using so that it can used the fixed PLL.

Changes in v4:
 - display_timing for AUO b101ean01 new for v4.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-simple.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 7d407fab3628..c6c0625e1684 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -568,22 +568,21 @@ static const struct panel_desc auo_b101aw03 = {
 	},
 };
 
-static const struct drm_display_mode auo_b101ean01_mode = {
-	.clock = 72500,
-	.hdisplay = 1280,
-	.hsync_start = 1280 + 119,
-	.hsync_end = 1280 + 119 + 32,
-	.htotal = 1280 + 119 + 32 + 21,
-	.vdisplay = 800,
-	.vsync_start = 800 + 4,
-	.vsync_end = 800 + 4 + 20,
-	.vtotal = 800 + 4 + 20 + 8,
-	.vrefresh = 60,
+static const struct display_timing auo_b101ean01_timing = {
+	.pixelclock = { 65300000, 72500000, 75000000 },
+	.hactive = { 1280, 1280, 1280 },
+	.hfront_porch = { 18, 119, 119 },
+	.hback_porch = { 21, 21, 21 },
+	.hsync_len = { 32, 32, 32 },
+	.vactive = { 800, 800, 800 },
+	.vfront_porch = { 4, 4, 4 },
+	.vback_porch = { 8, 8, 8 },
+	.vsync_len = { 18, 20, 20 },
 };
 
 static const struct panel_desc auo_b101ean01 = {
-	.modes = &auo_b101ean01_mode,
-	.num_modes = 1,
+	.timings = &auo_b101ean01_timing,
+	.num_timings = 1,
 	.bpc = 6,
 	.size = {
 		.width = 217,
-- 
2.21.0.392.gf8f6787159e-goog

