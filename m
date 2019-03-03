Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494B4C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F122086A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="azB7/TKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfCCRg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 12:36:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43777 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfCCRgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 12:36:25 -0500
Received: by mail-pf1-f195.google.com with SMTP id q17so1289762pfh.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 09:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SeROb0sI2fop2jpbyKF+OkejpdGcXO+z0TOiWQ+8P+Y=;
        b=azB7/TKSI1sGpYuQu5cYJgGyV1BbHN2qWtz/jzBQNGABtiKATw+o4e8327tYUG+def
         0/CYRxPtK/mNCC4Y3vmoousXQ81+e2hr1WXOJCzBZjcPpwY7YBwuGo84AlhQThEotbVK
         Ge1jSGgvaB99KQhqtEhUh0JBFIu9lnvGB1WHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SeROb0sI2fop2jpbyKF+OkejpdGcXO+z0TOiWQ+8P+Y=;
        b=Ja6gnvboSYlezukQn6CkeGwKskRstAvFjJYtb1vgqw6fFbaHL/gfOJGliiIrZ1M7Lx
         GRDpeYGpdtCesGs5am5yi8FebQFgDyAcuOCbEZ/pGk6HS0uGBH6ZrE2O0SE109HQd5v1
         Vd65/XObZGGPV96MscuX2biYTWhURkXnvFpYSZyM7k668RWqzIHcV4rrKnc56pug5K8w
         +2nLOMVmlGDNbfXsQlx0+HZebR5UdB4YaTwJX63lntrMbAQ7a/No/yJcjE5ctMjXoDyF
         qMfLhWie30BIDMoTqoIsJpD+o0Mus9LXnkxXKthF84CJchsb2CaN3davr+iFQH4vg+07
         /uBg==
X-Gm-Message-State: AHQUAuYWueP/mJpIR6PM1OHgBtanW5wcWVNqYPq3wBh3lto7K5Mk8nXY
        jONrneveleH0uiio1oKpF71mHQ==
X-Google-Smtp-Source: AHgI3IaHgCR/5gcoWfZyzZcvwfxV9xnkUCOWuDAbEsxR5J/AtP0GFGZ49JcE+EKJuorIFBEXwivTPw==
X-Received: by 2002:a62:4188:: with SMTP id g8mr16390415pfd.205.1551634584392;
        Sun, 03 Mar 2019 09:36:24 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id d129sm5614737pgc.59.2019.03.03.09.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 09:36:23 -0800 (PST)
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
Subject: [PATCH v9 3/5] drm/sun4i: sun6i_mipi_dsi: Support vblk timing for 4-lane devices
Date:   Sun,  3 Mar 2019 23:05:25 +0530
Message-Id: <20190303173527.31055-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190303173527.31055-1-jagan@amarulasolutions.com>
References: <20190303173527.31055-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like other dsi setup timings, or hblk for that matter vblk would
also require compute the timings based payload equation along with
packet overhead.

But, on the other hand vblk computation is also depends on device
lane number.
- for 4 lane devices, it is computed based on vtotal, packet overhead
  along with hblk value.
- for others devices, it is simply 0

BSP code from BPI-M64-bsp is computing vblk as for 4-lane devices
(from linux-sunxi
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

tmp = (ht*dsi_pixel_bits[format]/8)*vt-(4+dsi_hblk+2);
dsi_vblk = (lane-tmp%lane);

So, update the vblk timing calculation to support all type of
devices.

Tested on 2-lane, 4-lane MIPI-DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 27 +++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 140e55f5ed2e..b38358465d87 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -527,6 +527,24 @@ static void sun6i_dsi_setup_format(struct sun6i_dsi *dsi,
 		     SUN6I_DSI_PIXEL_CTL0_FORMAT(fmt));
 }
 
+static u16 sun6i_dsi_get_timings_vblk(struct sun6i_dsi *dsi,
+				      struct drm_display_mode *mode, u16 hblk)
+{
+	struct mipi_dsi_device *device = dsi->device;
+	unsigned int Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
+	int tmp;
+
+	/*
+	 * The vertical blank is set using a blanking packet (4 bytes +
+	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
+	 */
+#define VBLK_PACKET_OVERHEAD	6
+	tmp = (mode->htotal * Bpp) * mode->vtotal -
+	      (hblk + VBLK_PACKET_OVERHEAD);
+
+	return (device->lanes - tmp % device->lanes);
+}
+
 static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 				    struct drm_display_mode *mode)
 {
@@ -586,13 +604,8 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 			   (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp -
 			   HBLK_PACKET_OVERHEAD);
 
-		/*
-		 * And I'm not entirely sure what vblk is about. The driver in
-		 * Allwinner BSP is using a rather convoluted calculation
-		 * there only for 4 lanes. However, using 0 (the !4 lanes
-		 * case) even with a 4 lanes screen seems to work...
-		 */
-		vblk = 0;
+		if (device->lanes == 4)
+			vblk = sun6i_dsi_get_timings_vblk(dsi, mode, hblk);
 	}
 
 	/* How many bytes do we need to send all payloads? */
-- 
2.18.0.321.gffc6fa0e3

