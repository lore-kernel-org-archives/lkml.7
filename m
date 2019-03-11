Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDD2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD272087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XErLydjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfCKNhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:37:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45700 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfCKNhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:37:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id v21so3706602pfm.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MkagwlmaneGvabM0zWKgTIFVY3fD3rJzVWmLGOw3QRg=;
        b=XErLydjXMg/QyI27+lL8zd+GEF4hndh+xt4uFSI2FPJ8nxjLniWmr6+TVkvdqJjfmi
         CPWuViuINP+DP7WSAjjC17T8nQ3bsTAms8GEl+PBZ5MlGIji/OhpNwwYT54Dq+wwQf8p
         7J1a88YNyCChcBjq6esKarAOf4z9EmKUQmmoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MkagwlmaneGvabM0zWKgTIFVY3fD3rJzVWmLGOw3QRg=;
        b=ct7woLE57JJkkzcSoUqtlc5XU4u9i0l0mm2tRzqda/1UTAg94b/NAP70zbinccPNpC
         FSDEPbF8VOJBWgCsLXTf+9uAMJ3qfE43pq8FTS7fvAm6JDCy0j77FWDepOb0xM+svTWi
         VLNBT3wy62/Z41fVfmQGhd88xzIizLVOawT3eOdMIKsc3k/2APkgbAZrOd4S1aXfdYzk
         3DSslNgzOycq86z3ZwoKf2dUpz0nwZgQqjEeZiSuoHNNd5DbYejKEFhSAz+0oQ47S4yG
         bKd+5Yd+8G7qKrUcZqhr62Mw5rexKZFAV5zeYohLlWtLGIqqci05kmw4YiI3vKrDPDc0
         ZlkA==
X-Gm-Message-State: APjAAAVTWHVnty/KMnCvEt+P4Nr5U6X+oHNYLyqu7m1s9fpkntCf6Vkj
        XxWbJbwaDvgvy07g4yuY8EgUQw==
X-Google-Smtp-Source: APXvYqzgDkRmYbgZGTC2UrWOeicCqY4vApUX7An7J715NGniYxmfJNivATrHauH7tdqmvXkAa9wkDg==
X-Received: by 2002:a17:902:aa92:: with SMTP id d18mr3697807plr.278.1552311434067;
        Mon, 11 Mar 2019 06:37:14 -0700 (PDT)
Received: from localhost.localdomain ([183.82.224.199])
        by smtp.gmail.com with ESMTPSA id s79sm9960397pfa.61.2019.03.11.06.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 06:37:13 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v8 01/15] drm/sun4i: dsi: Fix video start delay computation
Date:   Mon, 11 Mar 2019 19:06:23 +0530
Message-Id: <20190311133637.18334-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190311133637.18334-1-jagan@amarulasolutions.com>
References: <20190311133637.18334-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vertical video start delay is computed by excluding vertical front
porch value from total vertical timings.

This clearly confirmed from BSP code and here how it computed,

(drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
u32 vfp = panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
=> (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
=> (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
   - panel->lcd_y - (panel->lcd_vbp)
=> timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
  			     - panel->lcd_y - panel->lcd_vbp
=> timmings->ver_front_porch

But the current driver is assuming it can exclude vertical front
porch along with vertical sync values from total vertical timings,
which resulting wrong start delay indeed wrong picture rendering
in the panel.

Example: timings, where it produces the issue.
{
	.vdisplay	= 600,
	.vsync_start	= 600 + 12,
	.vsync_end	= 600 + 12 + 2,
	.vtotal		= 600 + 12 + 2 + 21,
}

It produces the desired start delay value as 19 but the correct working
value should be 513.

So, Fix it by computing proper video start delay.

Fixes: 69006ef0ecb1 ("drm/sun4i: dsi: Change the start delay calculation")
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 62a508420227..8d6292c0158b 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -364,8 +364,14 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
 static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 					   struct drm_display_mode *mode)
 {
-	u16 start = clamp(mode->vtotal - mode->vdisplay - 10, 8, 100);
-	u16 delay = mode->vtotal - (mode->vsync_end - mode->vdisplay) + start;
+	u16 delay = mode->vtotal - (mode->vsync_start - mode->vdisplay);
+
+	/**
+	 * BSP comment:
+	 * put start_delay to tcon. set ready sync early to dramfreq,
+	 * so set start_delay 1
+	 */
+	delay += 1;
 
 	if (delay > mode->vtotal)
 		delay = delay % mode->vtotal;
-- 
2.18.0.321.gffc6fa0e3

