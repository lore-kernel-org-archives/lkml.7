Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9321BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A39C20854
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="dfPG8wH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733159AbfB1S7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:59:18 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:60932 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732948AbfB1S7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1551380354; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XsIYjbm4bDDRIq/OhgStYAH9uxCsKUcgdpaA3fYuJTQ=;
        b=dfPG8wH/TgUKB0Vh4hcLVRG1QrlTxYHETpNDk1BUQCuz070PZt8HuZybbjU6hlfk1gY9IF
        /qb0emJORQzQO4DgC9XhDCwii0crcJzFtWiQ/sKAdHYu9HIRge50EVQ0tTLIrgvOsgC3to
        mpom/U+AK48xSHoJavfS99rTaEsKlR8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/2] drm/panel: simple: Add GiantPlus GPM940B0 panel support
Date:   Thu, 28 Feb 2019 15:58:54 -0300
Message-Id: <20190228185854.11824-3-paul@crapouillou.net>
In-Reply-To: <20190228185854.11824-1-paul@crapouillou.net>
References: <20190228185854.11824-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GiantPlus GPM940B0 is a simple 3.0" 320x240 24-bit TFT panel.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---
 drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 3ab604f5477e..a66aade78073 100644
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
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_NEGEDGE,
+};
+
 static const struct display_timing hannstar_hsd070pww1_timing = {
 	.pixelclock = { 64300000, 71100000, 82000000 },
 	.hactive = { 1280, 1280, 1280 },
@@ -2666,6 +2691,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "giantplus,gpg482739qs5",
 		.data = &giantplus_gpg482739qs5
 	}, {
+		.compatible = "giantplus,gpm940b0",
+		.data = &giantplus_gpm940b0,
+	}, {
 		.compatible = "hannstar,hsd070pww1",
 		.data = &hannstar_hsd070pww1,
 	}, {
-- 
2.11.0

