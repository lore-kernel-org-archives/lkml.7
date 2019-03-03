Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B9EC10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1C620866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="m1FrEllf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfCCRgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 12:36:35 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36463 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfCCRge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 12:36:34 -0500
Received: by mail-pf1-f196.google.com with SMTP id n22so1303779pfa.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 09:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nH8G1W2EgQa6aDAZzLfPouCwgu4asZ6FIPx9/UPBlXw=;
        b=m1FrEllfMfg/suYjQdH2Ti+ra+O0Y+MXCh1/x2MHp8Aczb3+Wpnapl0qsZLfY5SXmp
         c1Yn6AP9Fxv4Gt3zu3vta8gvNg54IrM2HCRcdP3i+bUyCBTeDbdvdQshM5IrbMZ0hEFZ
         Z6SNyVr4VObWmVbRbKbQWVY8aI73f5YfjHlgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nH8G1W2EgQa6aDAZzLfPouCwgu4asZ6FIPx9/UPBlXw=;
        b=IX8JsPfIDgCe7KZxDB/khM6lYkccUQmpPUzQaq3Z3SE9q4dpRNV+lIwOw69Op296yT
         he0pt/WKUrWiE8VWH2w7je82Umhs3oU9l7uG79cHIFOWnGdACbX3YkULZ2QUV6eZx+6I
         muZlR3bAUHKLIG19Srpkv1Z0q+cWjExmkJup9nSkxYsx1qDBPEdjutQrAkdj6wliOY8G
         elXYD5C7PdvGSYSmrQ7zIv+ZpM2ZRI/IXdJ5Jt6Nc5yzyrZoo1lrtfEaGyplI05bK0K9
         YaYVLmTiFxpPIWhsyTzxNT66poxdZywQCW/SisTFHHw8kQmO8xkcfMESDSrHZ6/a84JD
         CAEg==
X-Gm-Message-State: AHQUAualLFcNHk4t2c16lblytLsjZIumv1aPL7odghsKijf2VIkRhZxM
        UQ3KsEmnWiScGsejskhjZpUbXw==
X-Google-Smtp-Source: AHgI3IagjBeD7CYWDO3mg/s0XAZehQj9szKzEtW7vEEHLwfsdUn/ST4V3eOL+zwMZQHQsdIkEImAjw==
X-Received: by 2002:a62:76c9:: with SMTP id r192mr16283667pfc.251.1551634593359;
        Sun, 03 Mar 2019 09:36:33 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id d129sm5614737pgc.59.2019.03.03.09.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 09:36:32 -0800 (PST)
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
Subject: [PATCH v9 5/5] drm/sun4i: sun6i_mipi_dsi: Simplify dsi setup timings code
Date:   Sun,  3 Mar 2019 23:05:27 +0530
Message-Id: <20190303173527.31055-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190303173527.31055-1-jagan@amarulasolutions.com>
References: <20190303173527.31055-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSI timings are varies between burst/non-burst devices and
current driver is handling this support via if, else statements
which would difficult to read.

Simplify it by using goto to make code more readable.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
Note: This change is created based on previous version burst
changes [1] by addressing comment from [2] by Maxime to make
code readable. 

[1] https://patchwork.kernel.org/cover/10813623/
[2] https://patchwork.kernel.org/patch/10666607/

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 79 ++++++++++++++------------
 1 file changed, 42 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 31ec4048804d..898f32319c2d 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -550,7 +550,8 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 {
 	struct mipi_dsi_device *device = dsi->device;
 	unsigned int Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
-	u16 hbp = 0, hfp = 0, hsa = 0, hblk = 0, vblk = 0;
+	u16 hbp, hfp, hsa, hblk;
+	u16 vblk = 0;
 	u32 basic_ctl = 0;
 	size_t bytes;
 	u8 *buffer;
@@ -558,6 +559,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	/* Do all timing calculations up front to allocate buffer space */
 
 	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
+		hbp = hfp = hsa = 0;
 		hblk = mode->hdisplay * Bpp;
 		basic_ctl = SUN6I_DSI_BASIC_CTL_VIDEO_BURST |
 			    SUN6I_DSI_BASIC_CTL_HSA_HSE_DIS |
@@ -566,48 +568,51 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 		if (device->lanes == 4)
 			basic_ctl |= SUN6I_DSI_BASIC_CTL_TRAIL_FILL |
 				     SUN6I_DSI_BASIC_CTL_TRAIL_INV(0xc);
-	} else {
-		/*
-		 * A sync period is composed of a blanking packet (4
-		 * bytes + payload + 2 bytes) and a sync event packet
-		 * (4 bytes). Its minimal size is therefore 10 bytes
-		 */
+
+		goto alloc_buf;
+	}
+
+	/*
+	 * A sync period is composed of a blanking packet (4
+	 * bytes + payload + 2 bytes) and a sync event packet
+	 * (4 bytes). Its minimal size is therefore 10 bytes
+	 */
 #define HSA_PACKET_OVERHEAD	10
-		hsa = max((unsigned int)HSA_PACKET_OVERHEAD,
-			  (mode->hsync_end - mode->hsync_start) * Bpp - HSA_PACKET_OVERHEAD);
-
-		/*
-		 * The backporch is set using a blanking packet (4
-		 * bytes + payload + 2 bytes). Its minimal size is
-		 * therefore 6 bytes
-		 */
+	hsa = max((unsigned int)HSA_PACKET_OVERHEAD,
+		  (mode->hsync_end - mode->hsync_start) * Bpp - HSA_PACKET_OVERHEAD);
+
+	/*
+	 * The backporch is set using a blanking packet (4
+	 * bytes + payload + 2 bytes). Its minimal size is
+	 * therefore 6 bytes
+	 */
 #define HBP_PACKET_OVERHEAD	6
-		hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
-			  (mode->htotal - mode->hsync_end) * Bpp - HBP_PACKET_OVERHEAD);
-
-		/*
-		 * The frontporch is set using a blanking packet (4
-		 * bytes + payload + 2 bytes). Its minimal size is
-		 * therefore 6 bytes
-		 */
+	hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
+		  (mode->htotal - mode->hsync_end) * Bpp - HBP_PACKET_OVERHEAD);
+
+	/*
+	 * The frontporch is set using a blanking packet (4
+	 * bytes + payload + 2 bytes). Its minimal size is
+	 * therefore 6 bytes
+	 */
 #define HFP_PACKET_OVERHEAD	6
-		hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
-			  (mode->hsync_start - mode->hdisplay) * Bpp - HFP_PACKET_OVERHEAD);
-
-		/*
-		 * The blanking is set using a sync event (4 bytes)
-		 * and a blanking packet (4 bytes + payload + 2
-		 * bytes). Its minimal size is therefore 10 bytes.
-		 */
+	hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
+		  (mode->hsync_start - mode->hdisplay) * Bpp - HFP_PACKET_OVERHEAD);
+
+	/*
+	 * The blanking is set using a sync event (4 bytes)
+	 * and a blanking packet (4 bytes + payload + 2
+	 * bytes). Its minimal size is therefore 10 bytes.
+	 */
 #define HBLK_PACKET_OVERHEAD	10
-		hblk = max((unsigned int)HBLK_PACKET_OVERHEAD,
-			   (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp -
-			   HBLK_PACKET_OVERHEAD);
+	hblk = max((unsigned int)HBLK_PACKET_OVERHEAD,
+		   (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp -
+		   HBLK_PACKET_OVERHEAD);
 
-		if (device->lanes == 4)
-			vblk = sun6i_dsi_get_timings_vblk(dsi, mode, hblk);
-	}
+	if (device->lanes == 4)
+		vblk = sun6i_dsi_get_timings_vblk(dsi, mode, hblk);
 
+alloc_buf:
 	/* How many bytes do we need to send all payloads? */
 	bytes = max_t(size_t, max(max(hfp, hblk), max(hsa, hbp)), vblk);
 	buffer = kmalloc(bytes, GFP_KERNEL);
-- 
2.18.0.321.gffc6fa0e3

