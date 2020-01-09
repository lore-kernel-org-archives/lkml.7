Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0238C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AFE20678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 18:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388529AbgAISkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 13:40:51 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:40737 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388514AbgAISku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 13:40:50 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 5B4152000B;
        Thu,  9 Jan 2020 18:40:48 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, dri-devel@lists.freedesktop.org,
        <linux-kernel@vger.kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v5 2/2] drm/panel: simple: Add Satoz SAT050AT40H12R2 panel support
Date:   Thu,  9 Jan 2020 19:40:37 +0100
Message-Id: <20200109184037.9091-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200109184037.9091-1-miquel.raynal@bootlin.com>
References: <20200109184037.9091-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Satoz SAT050AT40H12R2 panel.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Changes since v4:
* None.

Changes since v3:
* Added connector type.

Changes since v2:
* Dropped two uneeded lines which would fail the build.

Changes since v1:
* Switched to display_timing's instead of display_mode.

 drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index aaa08beac13c..1aa6622abc49 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2577,6 +2577,30 @@ static const struct panel_desc samsung_ltn140at29_301 = {
 	},
 };
 
+static const struct display_timing satoz_sat050at40h12r2_timing = {
+	.pixelclock = {33300000, 33300000, 50000000},
+	.hactive = {800, 800, 800},
+	.hfront_porch = {16, 210, 354},
+	.hback_porch = {46, 46, 46},
+	.hsync_len = {1, 1, 40},
+	.vactive = {480, 480, 480},
+	.vfront_porch = {7, 22, 147},
+	.vback_porch = {23, 23, 23},
+	.vsync_len = {1, 1, 20},
+};
+
+static const struct panel_desc satoz_sat050at40h12r2 = {
+	.timings = &satoz_sat050at40h12r2_timing,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 108,
+		.height = 65,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct drm_display_mode sharp_ld_d5116z01b_mode = {
 	.clock = 168480,
 	.hdisplay = 1920,
@@ -3377,6 +3401,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "samsung,ltn140at29-301",
 		.data = &samsung_ltn140at29_301,
+	}, {
+		.compatible = "satoz,sat050at40h12r2",
+		.data = &satoz_sat050at40h12r2,
 	}, {
 		.compatible = "sharp,ld-d5116z01b",
 		.data = &sharp_ld_d5116z01b,
-- 
2.20.1

