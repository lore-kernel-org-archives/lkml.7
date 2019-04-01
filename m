Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AD1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926A82084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FANOS7G6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbfDAR7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:59:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46201 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731286AbfDARSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:18:01 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so4800643pll.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 10:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9+yEi+eZPRH+2tNF2bctolAJluO+BQKUE1OpVezDcSA=;
        b=FANOS7G6CCChbVSnGdD6PqovmIGZ5ltUFFDuywuZ2bdpjSSJT3VhotXLReNuTaLw2K
         +NKAbyURPQWK9gsM2c2SGXPzRt3EU8Qft3BusLKHsE9aScBUEp5c9mFhTZ1e7nu7xJDA
         N9HLmmLT97DnMSXBYZJ+aKX46+tc/3+CwDoDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+yEi+eZPRH+2tNF2bctolAJluO+BQKUE1OpVezDcSA=;
        b=TlI/Vb3/gOz6CAGpug43sYyDFH+5IU0Y/CvCPeQSeTI/zjJyQkLX7rNnuaiXayRKZs
         myVagjbwLx9vWuodtcOhWOS0A5S6UV+BLHOVjZX9pOqPzZBGclLglCoovHCxu8Km9TKe
         7DgJfcgdrVz/g55w8z8MEJrJx7eNbqKdpqPGU5tVnUgMODOkqdCaPIzr5DyPvNxryAHG
         LrPbKyU9eKNXqbX/ok9EAWhJlFYaxBxqR4r/MakrpRlWvi/5zPBfybsPLZuZjz5SKcMF
         DAperxDO5SkgWK3U/Rp6fSczb0TvQhvkEntwEDx3D2fBLiVSyif+TAiv4s3KlhgDyGUr
         LLNA==
X-Gm-Message-State: APjAAAWY3DugES+zl2HHMev3FqT8hWOs39bInFMT1OiVUJfCYJCYEWKJ
        WJFcQhPBXKq10lNBX/k9EPaCPw==
X-Google-Smtp-Source: APXvYqwsrsnX3TgFBk+xfMZJH+DRvLR+ODZiYbrm5+sGoWgrtImzbHOLY9s9TrJ/xiwEuUv4+b+nUw==
X-Received: by 2002:a17:902:b281:: with SMTP id u1mr13101656plr.30.1554139078791;
        Mon, 01 Apr 2019 10:17:58 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id y12sm31370112pgq.64.2019.04.01.10.17.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 10:17:58 -0700 (PDT)
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
Subject: [PATCH v5 5/7] drm/panel: simple: Use display_timing for AUO b101ean01
Date:   Mon,  1 Apr 2019 10:17:22 -0700
Message-Id: <20190401171724.215780-6-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190401171724.215780-1-dianders@chromium.org>
References: <20190401171724.215780-1-dianders@chromium.org>
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

