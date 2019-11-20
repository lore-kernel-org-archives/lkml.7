Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25681C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E881F20672
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKTVzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 16:55:05 -0500
Received: from mail.manjaro.org ([176.9.38.148]:47862 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfKTVzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 16:55:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id 9393836CEEA8;
        Wed, 20 Nov 2019 22:35:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ph4jUNY91zd4; Wed, 20 Nov 2019 22:35:44 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH 1/1] drm/panel: simple: Add support for BOE NV140FHM-N49 panel to panel-simple
Date:   Wed, 20 Nov 2019 22:34:40 +0100
Message-Id: <20191120213440.924563-2-t.schramm@manjaro.org>
In-Reply-To: <20191120213440.924563-1-t.schramm@manjaro.org>
References: <20191120213440.924563-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the BOE NV140FHM-N49 panel to the panel-simple
driver. The panel is used by the pine64 Pinebook Pro.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 35 ++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 5d487686d25c..6320df9765f3 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1036,6 +1036,38 @@ static const struct panel_desc boe_nv101wxmn51 = {
 	},
 };
 
+static const struct drm_display_mode boe_nv140fhmn49_modes[] = {
+	{
+		.clock = 148500,
+		.hdisplay = 1920,
+		.hsync_start = 1920 + 48,
+		.hsync_end = 1920 + 48 + 32,
+		.htotal = 2200,
+		.vdisplay = 1080,
+		.vsync_start = 1080 + 3,
+		.vsync_end = 1080 + 3 + 5,
+		.vtotal = 1125,
+		.vrefresh = 60,
+	},
+};
+
+static const struct panel_desc boe_nv140fhmn49 = {
+	.modes = boe_nv140fhmn49_modes,
+	.num_modes = ARRAY_SIZE(boe_nv140fhmn49_modes),
+	.bpc = 6,
+	.size = {
+		.width = 309,
+		.height = 174,
+	},
+	.delay = {
+		.prepare = 210,
+		.enable = 50,
+		.unprepare = 160,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+	.connector_type = DRM_MODE_CONNECTOR_eDP,
+};
+
 static const struct drm_display_mode cdtech_s043wq26h_ct7_mode = {
 	.clock = 9000,
 	.hdisplay = 480,
@@ -3161,6 +3193,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "boe,nv101wxmn51",
 		.data = &boe_nv101wxmn51,
+	}, {
+		.compatible = "boe,nv140fhmn49",
+		.data = &boe_nv140fhmn49,
 	}, {
 		.compatible = "cdtech,s043wq26h-ct7",
 		.data = &cdtech_s043wq26h_ct7,
-- 
2.24.0

