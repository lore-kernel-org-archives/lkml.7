Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519E5C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7136C20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="IQPkaa9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfDYXTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 19:19:25 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:45694 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfDYXTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 19:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1556234361; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kcpMIDSrcTAueIH8snyaEpbFZUyjyZ+mVWucOz1+nV8=;
        b=IQPkaa9sQD/+htxOWcCl+mKzqVKwa+yCDTaeNMA16e7+yPE1Tv6thWTB1rvatXghx0m7GK
        v5fLxUNb/bGRoAy6cyTMzIT8spMMsNDNeEQJb0we6UokvQGMIZ17b1qzm9LCwvh1Kob1NE
        8lAP4Z1OHBRzzhPvc45x7iSZDzQoJDI=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v3 3/3] drm/panel: simple: Add Sharp LS020B1DD01D panel support
Date:   Fri, 26 Apr 2019 01:18:54 +0200
Message-Id: <20190425231854.24479-3-paul@crapouillou.net>
In-Reply-To: <20190425231854.24479-1-paul@crapouillou.net>
References: <20190425231854.24479-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sharp LS020B1DD01D is a simple 2.0" 240x160 16-bit TFT panel.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---

Notes:
    v2: No change
    
    v3: Add DRM_BUS_FLAG_SHARP_SIGNALS to the bus flags

 drivers/gpu/drm/panel/panel-simple.c | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index f5fb9fec88e3..803b91f18248 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2381,6 +2381,33 @@ static const struct panel_desc sharp_lq150x1lg11 = {
 	.bus_format = MEDIA_BUS_FMT_RGB565_1X16,
 };
 
+static const struct display_timing sharp_ls020b1dd01d_timing = {
+	.pixelclock = { 2000000, 4200000, 5000000 },
+	.hactive = { 240, 240, 240 },
+	.hfront_porch = { 66, 66, 66 },
+	.hback_porch = { 1, 1, 1 },
+	.hsync_len = { 1, 1, 1 },
+	.vactive = { 160, 160, 160 },
+	.vfront_porch = { 52, 52, 52 },
+	.vback_porch = { 6, 6, 6 },
+	.vsync_len = { 10, 10, 10 },
+	.flags = DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW,
+};
+
+static const struct panel_desc sharp_ls020b1dd01d = {
+	.timings = &sharp_ls020b1dd01d_timing,
+	.num_timings = 1,
+	.bpc = 6,
+	.size = {
+		.width = 42,
+		.height = 28,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB565_1X16,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH
+		   | DRM_BUS_FLAG_PIXDATA_NEGEDGE
+		   | DRM_BUS_FLAG_SHARP_SIGNALS,
+};
+
 static const struct drm_display_mode shelly_sca07010_bfn_lnn_mode = {
 	.clock = 33300,
 	.hdisplay = 800,
@@ -2932,6 +2959,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "sharp,lq150x1lg11",
 		.data = &sharp_lq150x1lg11,
+	}, {
+		.compatible = "sharp,ls020b1dd01d",
+		.data = &sharp_ls020b1dd01d,
 	}, {
 		.compatible = "shelly,sca07010-bfn-lnn",
 		.data = &shelly_sca07010_bfn_lnn,
-- 
2.21.0.593.g511ec345e18

