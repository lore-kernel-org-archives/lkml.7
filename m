Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B39AC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1790D2085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbfKGRX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:23:57 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51400 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730509AbfKGRX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:23:56 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 6D2DC290AB6
Received: by jupiter.universe (Postfix, from userid 1000)
        id A4F654800A1; Thu,  7 Nov 2019 18:23:53 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 2/2] drm/panel: simple: Add support for AUO G156XTN01.0 panel
Date:   Thu,  7 Nov 2019 18:23:31 +0100
Message-Id: <20191107172331.14362-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191107172331.14362-1-sebastian.reichel@collabora.com>
References: <20191107172331.14362-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add timings for the AUO G156XTN01.0 panel.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 46ca59db6819..49a3f3b3d4be 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -858,6 +858,29 @@ static const struct panel_desc auo_g133han01 = {
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA,
 };
 
+static const struct drm_display_mode auo_g156xtn01_mode = {
+	.clock = 76000,
+	.hdisplay = 1366,
+	.hsync_start = 1366 + 33,
+	.hsync_end = 1366 + 33 + 67,
+	.htotal = 1560,
+	.vdisplay = 768,
+	.vsync_start = 768 + 4,
+	.vsync_end = 768 + 4 + 4,
+	.vtotal = 806,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc auo_g156xtn01 = {
+	.modes = &auo_g156xtn01_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 344,
+		.height = 194,
+	},
+};
+
 static const struct display_timing auo_g185han01_timings = {
 	.pixelclock = { 120000000, 144000000, 175000000 },
 	.hactive = { 1920, 1920, 1920 },
@@ -3143,6 +3166,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "auo,g133han01",
 		.data = &auo_g133han01,
+	}, {
+		.compatible = "auo,g156xtn01",
+		.data = &auo_g156xtn01,
 	}, {
 		.compatible = "auo,g185han01",
 		.data = &auo_g185han01,
-- 
2.24.0.rc1

