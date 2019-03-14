Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D63BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDC821852
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="sWNKIa3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfCNM0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:26:37 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:56986 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727449AbfCNM0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1552566391; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Jw+ycHAh/5+AZWuxM1OQ5dDXraOB17p3NUHrMl/Tnpw=;
        b=sWNKIa3g0IqRFuK70zgCvEVHb5rLfIhgJ2JSGZ4FzjaFEQm/i53CNBwU7W9CbdCmDLV5RN
        d+o7qzVDlV0nK2HSNFLU+G4oNBZlYU50tWhz8mprHDouGrzWvvdXsY0Oz2OzaHi9GxwrX9
        ZSpc1DrFuuPYX4Di6llWYengHYKxKv8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 4/5] drm/panel: simple: Add Sharp LS020B1DD01D panel support
Date:   Thu, 14 Mar 2019 13:26:21 +0100
Message-Id: <20190314122622.7597-4-paul@crapouillou.net>
In-Reply-To: <20190314122622.7597-1-paul@crapouillou.net>
References: <20190314122622.7597-1-paul@crapouillou.net>
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

 drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 9e8218f6a3f2..3ab604f5477e 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2278,6 +2278,31 @@ static const struct panel_desc sharp_lq150x1lg11 = {
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
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_NEGEDGE,
+};
+
 static const struct drm_display_mode shelly_sca07010_bfn_lnn_mode = {
 	.clock = 33300,
 	.hdisplay = 800,
@@ -2767,6 +2792,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "sharp,lq150x1lg11",
 		.data = &sharp_lq150x1lg11,
 	}, {
+		.compatible = "sharp,ls020b1dd01d",
+		.data = &sharp_ls020b1dd01d,
+	}, {
 		.compatible = "shelly,sca07010-bfn-lnn",
 		.data = &shelly_sca07010_bfn_lnn,
 	}, {
-- 
2.11.0

