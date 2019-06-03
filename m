Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD94BC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975C62725D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="L+Mh4oLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfFCPfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:35:25 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:58254 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfFCPfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559576121; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3rK/nnS6+itLqM9olBxKt3l4mVsf/DF5pToHX+j7u/c=;
        b=L+Mh4oLwF0s0fv/IaRPkUdpLXAdenlWhV13/WbRfH5gxIXJ+p9PJ9kIHaoG4rOo79XNfBv
        Gvrlata6T9kbRZlZRYfybovzc/Xs6X/vyxznbUe9y5IUN+WujdbZVRhHh3esRby52bBW/3
        wbndYMlrPC3fHivLvCqUdTFqXZse2lA=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Hans Verkuil <hansverk@cisco.com>
Cc:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v4 3/3] drm/panel: simple: Add GiantPlus GPM940B0 panel support
Date:   Mon,  3 Jun 2019 17:35:11 +0200
Message-Id: <20190603153511.24384-3-paul@crapouillou.net>
In-Reply-To: <20190603153511.24384-1-paul@crapouillou.net>
References: <20190603153511.24384-1-paul@crapouillou.net>
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
    
    v4: Change bus format to MEDIA_BUS_FMT_RGB888_3X8

 drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 5a93c4edf1e4..eec9a9efcc73 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1335,6 +1335,31 @@ static const struct panel_desc giantplus_gpg482739qs5 = {
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
+	.bus_format = MEDIA_BUS_FMT_RGB888_3X8,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_NEGEDGE,
+};
+
 static const struct display_timing hannstar_hsd070pww1_timing = {
 	.pixelclock = { 64300000, 71100000, 82000000 },
 	.hactive = { 1280, 1280, 1280 },
@@ -2882,6 +2907,9 @@ static const struct of_device_id platform_of_match[] = {
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

