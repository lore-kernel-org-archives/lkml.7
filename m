Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28072C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF54B20842
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Q8DwfqBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbfCCRgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 12:36:22 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34480 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfCCRgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 12:36:20 -0500
Received: by mail-pg1-f196.google.com with SMTP id i130so1369177pgd.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 09:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D+mNFlao6tHpPYybFt0Tr/cBREXotgdAIz+jZKUMM8c=;
        b=Q8DwfqBNMv5PqaAtlE0XmZxgdpp/cRJy5iNPf8b3ivLstJdfrhcCcaWdYGko5ulXzr
         9WHzPMpHLrbhfgp71WTn91Nqke6SKxrsrSoI4IQa/wOST9+8m3ry4ld60oJV3luDkTW4
         0bCHt/xqh/DhxGPwSZr6BZKnmuPhL7+pGT6aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D+mNFlao6tHpPYybFt0Tr/cBREXotgdAIz+jZKUMM8c=;
        b=pgZMsvy2Ryr04eIkpQi1mRNZjtEuAyPdd37mdziOpWL8Kb3mFgNYK9PV4Sd7AgHBfC
         ON/TxfTSMQvj8JVGItGToEdf+3H+wqulOUKBQU9Wdnfs7O8JwatkVbW2E6n3AsFJFG4z
         ISzuc8CDca2ZbInJSWFgaTh6uu3g64HBaK4fjvTzGr2+tnq8XogSohz8wMdUYJErQ6JW
         w1NptULqsX29NxSoiYnBMelgZ3fFpqh2ThDgmTK+Ewjd6QCvDi/xad99g7zRVEiHz5NB
         h6WSL13/hu8zcHPXfQOd0lIr5pp+jr0fdp9Ld6qoiXNoD0LVs2uRa8XfeILMY5Lw9jl7
         Nuog==
X-Gm-Message-State: APjAAAU9YO5bRsYxAl5NVwNhLN575XQFWFyk6SAo9YNVuY1zSw9WnX2M
        tCBVB4/307/j9V+3e590N7tfWg==
X-Google-Smtp-Source: APXvYqw/rVw52JfOtprvCQ9ajiMytcLnTP3ioHWwc0DoRpGUzVox9uFCiT03q1KAGX5Vu5OA3vgNcw==
X-Received: by 2002:a63:eb56:: with SMTP id b22mr14828169pgk.287.1551634579844;
        Sun, 03 Mar 2019 09:36:19 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id d129sm5614737pgc.59.2019.03.03.09.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 09:36:19 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v9 2/5] drm/sun4i: sun6i_mipi_dsi: Fix TCON DRQ set bits
Date:   Sun,  3 Mar 2019 23:05:24 +0530
Message-Id: <20190303173527.31055-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190303173527.31055-1-jagan@amarulasolutions.com>
References: <20190303173527.31055-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TCON DRQ for non-burst DSI mode can computed based on horizontal
front porch value, but the current driver trying to include sync
timings along with front porch resulting wrong drq.

This patch is trying to update the drq by subtracting hsync_start
with hdisplay, which is horizontal front porch.

Current code:
------------
mode->hsync_end - mode->hdisplay => horizontal front porch + sync

With this patch:
----------------
mode->hsync_start - mode->hdisplay => horizontal front porch

BSP code form BPI-M64-bsp is computing TCON DRQ set bits
for non-burts as (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

=> panel->lcd_ht -    panel->lcd_x - panel->lcd_hbp
=> (timmings->hor_front_porch + panel->lcd_hbp + panel->lcd_x)
   - panel->lcd_x - panel->hbp
=> timmings->hor_front_porch
=> mode->hsync_start - mode->hdisplay

So, update the DRQ set bits accordingly.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 465e7fc57899..140e55f5ed2e 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -436,9 +436,9 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 			     SUN6I_DSI_BURST_LINE_SYNC_POINT(SUN6I_DSI_SYNC_POINT));
 
 		val = SUN6I_DSI_TCON_DRQ_ENABLE_MODE;
-	} else if ((mode->hsync_end - mode->hdisplay) > 20) {
+	} else if ((mode->hsync_start - mode->hdisplay) > 20) {
 		/* Maaaaaagic */
-		u16 drq = (mode->hsync_end - mode->hdisplay) - 20;
+		u16 drq = (mode->hsync_start - mode->hdisplay) - 20;
 
 		drq *= mipi_dsi_pixel_format_to_bpp(device->format);
 		drq /= 32;
-- 
2.18.0.321.gffc6fa0e3

