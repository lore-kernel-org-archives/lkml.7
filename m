Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9181CC43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F462084F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ejdJmGX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfLBPlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 10:41:53 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:40792 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfLBPlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 10:41:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1575301297; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fg/PlDK+PUoPua/OIog53C2OHM90AAbBw95IRxAF1p0=;
        b=ejdJmGX7ldTLpDtqHVBHySbEnM4HxQxgk8hJzLqcusGuaibBluoBtzu9BT0Vu4bB7wl7nQ
        MHp3AcDgEPql/L2soQ7BADjwLGQo8I85yC69JrZg/ugQ6Wer1M0mKi9Xhyfecrwscvu3/6
        aTas+GoV1wzTRWIS5AqygrMqHPT1pV8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 3/3] drm/panel: simple: Add support for the Frida FRD350H54004 panel
Date:   Mon,  2 Dec 2019 16:41:23 +0100
Message-Id: <20191202154123.64139-3-paul@crapouillou.net>
In-Reply-To: <20191202154123.64139-1-paul@crapouillou.net>
References: <20191202154123.64139-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FRD350H54004 is a simple 3.5" 320x240 24-bit TFT panel, found for
instance inside the Anbernic RG-350 handheld gaming console.

v2: Order alphabetically

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/panel/panel-simple.c | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 28fa6ba7b767..0e5e33a57f0c 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1402,6 +1402,32 @@ static const struct panel_desc foxlink_fl500wvr00_a0t = {
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 };
 
+static const struct drm_display_mode frida_frd350h54004_mode = {
+	.clock = 6777,
+	.hdisplay = 320,
+	.hsync_start = 320 + 70,
+	.hsync_end = 320 + 70 + 50,
+	.htotal = 320 + 70 + 50 + 10,
+	.vdisplay = 240,
+	.vsync_start = 240 + 5,
+	.vsync_end = 240 + 5 + 1,
+	.vtotal = 240 + 5 + 1 + 5,
+	.vrefresh = 60,
+	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
+};
+
+static const struct panel_desc frida_frd350h54004 = {
+	.modes = &frida_frd350h54004_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 77,
+		.height = 64,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDGE,
+};
+
 static const struct drm_display_mode friendlyarm_hd702e_mode = {
 	.clock		= 67185,
 	.hdisplay	= 800,
@@ -3189,6 +3215,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "foxlink,fl500wvr00-a0t",
 		.data = &foxlink_fl500wvr00_a0t,
+	}, {
+		.compatible = "frida,frd350h54004",
+		.data = &frida_frd350h54004,
 	}, {
 		.compatible = "friendlyarm,hd702e",
 		.data = &friendlyarm_hd702e,
-- 
2.24.0

