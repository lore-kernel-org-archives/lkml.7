Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDDFC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE28218AE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730656AbfKGRX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:23:57 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51386 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKGRX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:23:56 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 69862290AB3
Received: by jupiter.universe (Postfix, from userid 1000)
        id A28D848009C; Thu,  7 Nov 2019 18:23:53 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 1/2] drm/panel: simple: Add support for AUO G121EAN01.4 panel
Date:   Thu,  7 Nov 2019 18:23:30 +0100
Message-Id: <20191107172331.14362-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add timings for the AUO G121EAN01.4 panel.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 28fa6ba7b767..46ca59db6819 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -806,6 +806,29 @@ static const struct panel_desc auo_g104sn02 = {
 	},
 };
 
+static const struct drm_display_mode auo_g121ean01_mode = {
+	.clock = 66700,
+	.hdisplay = 1280,
+	.hsync_start = 1280 + 58,
+	.hsync_end = 1280 + 58 + 8,
+	.htotal = 1280 + 58 + 8 + 70,
+	.vdisplay = 800,
+	.vsync_start = 800 + 6,
+	.vsync_end = 800 + 6 + 4,
+	.vtotal = 800 + 6 + 4 + 10,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc auo_g121ean01 = {
+	.modes = &auo_g121ean01_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 261,
+		.height = 163,
+	},
+};
+
 static const struct display_timing auo_g133han01_timings = {
 	.pixelclock = { 134000000, 141200000, 149000000 },
 	.hactive = { 1920, 1920, 1920 },
@@ -3114,6 +3137,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "auo,g104sn02",
 		.data = &auo_g104sn02,
+	}, {
+		.compatible = "auo,g121ean01.4",
+		.data = &auo_g121ean01,
 	}, {
 		.compatible = "auo,g133han01",
 		.data = &auo_g133han01,
-- 
2.24.0.rc1

