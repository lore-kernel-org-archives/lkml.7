Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC22C282E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A764120857
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="k0h0G2Te"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfDVJiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 05:38:03 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:36190 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfDVJiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 05:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1555925880; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SSHuRpEPChVNkw5VL/LwuRqDA8mgCfxQAZUZ16LP9Fk=;
        b=k0h0G2TeRjCZW8ZxVh6aj3SICLlCrw6SpW4qpjOUp5FVzfdwfOXKT4gurngTRtzOCgXeYw
        lEmaw/lJ2D54DiBhvTydQ2Xp0Q1gXRfCW/6PgpqANPqSx4ZduHGHYi8+t0FpWU3MivZuz2
        u2mjzWl4c/5zI/M2w0R/YbJqvlCAx40=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Hans Verkuil <hansverk@cisco.com>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v3 3/3] drm/panel: simple: Add GiantPlus GPM940B0 panel support
Date:   Mon, 22 Apr 2019 11:37:22 +0200
Message-Id: <20190422093722.4344-3-paul@crapouillou.net>
In-Reply-To: <20190422093722.4344-1-paul@crapouillou.net>
References: <20190422093722.4344-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GiantPlus GPM940B0 is a simple 3.0" 320x240 24-bit TFT panel.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---

Notes:
    v2: Change bus format to MEDIA_BUS_FMT_RGB888_3X8_BE
    
    v3: No change

 drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 569be4efd8d1..a81b35269a78 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1208,6 +1208,31 @@ static const struct panel_desc giantplus_gpg482739qs5 = {
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 };
 
+static const struct display_timing giantplus_gpm940b0_timing = {
+	.pixelclock = { 13500000, 27000000, 27500000 },
+	.hactive = { 320, 320, 320 },
+	.hfront_porch = { 14, 686, 718 },
+	.hback_porch = { 50, 70, 255 },
+	.hsync_len = { 1, 1, 1 },
+	.vactive = { 240, 240, 240 },
+	.vfront_porch = { 1, 1, 179 },
+	.vback_porch = { 1, 21, 31 },
+	.vsync_len = { 1, 1, 6 },
+	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW,
+};
+
+static const struct panel_desc giantplus_gpm940b0 = {
+	.timings = &giantplus_gpm940b0_timing,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 60,
+		.height = 45,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_3X8_BE,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_NEGEDGE,
+};
+
 static const struct display_timing hannstar_hsd070pww1_timing = {
 	.pixelclock = { 64300000, 71100000, 82000000 },
 	.hactive = { 1280, 1280, 1280 },
@@ -2666,6 +2691,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "giantplus,gpg482739qs5",
 		.data = &giantplus_gpg482739qs5
+	}, {
+		.compatible = "giantplus,gpm940b0",
+		.data = &giantplus_gpm940b0,
 	}, {
 		.compatible = "hannstar,hsd070pww1",
 		.data = &hannstar_hsd070pww1,
-- 
2.21.0.593.g511ec345e18

