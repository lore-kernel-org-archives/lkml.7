Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D9BC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB5023A79
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="gefcyfqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfFDMxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:53:47 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:18309 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbfFDMxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1559652823;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=OPxHWZ0Yqa8jx7PmQiTW3yC8b4PfhAE9TVHtEW0aA74=;
        b=gefcyfqxcb/7JlcyOwuPl5fGjIZyTKfwVRFEBNgLtz9BIODOrxadnIvgw+kq58c5AJ
        Tj6QjXGG/xDogSjx0OfJMUoeFmxYDql8Qxgu7LMK9w+M89rdyNyJE0cv+6rWTvWhhM42
        zqtdCvs4wDYXV26CG+FQniTpRGXkuSdhl1PTlhd8dFNChOs0HkuC5AJ4OGfijF8PMRna
        jQtyXHRCXRq1Wf3Jftdc3fbqEPL+WfRrz0ZxCSI42RhZBbIicnoyeixE2rIRf8jeHkVU
        u4HJ/ZoNVAhkEkW3Oy+saCYWgJ63mqkrbcoOoNybeqYBqOTbdJJ+fhaktohTvqI19iH7
        6PoA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0pAzTh/eDM="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.22 DYNA|AUTH)
        with ESMTPSA id i01b98v54Cra7YC
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 4 Jun 2019 14:53:36 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, tomi.valkeinen@ti.com,
        marek.belisko@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 2/2] drm/panel: simple: Add Ortustech COM37H3M panel support
Date:   Tue,  4 Jun 2019 14:53:34 +0200
Message-Id: <de4649e5beb7a0b18357314cca11739699405c85.1559652814.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1559652814.git.hns@goldelico.com>
References: <cover.1559652814.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change adds support for the Ortustech COM37H3M05DTC/99DTC 3.7" TFT LCD panel.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 33 ++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 5b27829c5a78..1892d00be16d 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2007,6 +2007,33 @@ static const struct panel_desc ontat_yx700wv03 = {
 	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
 };
 
+static const struct drm_display_mode ortustech_com37h3m_mode  = {
+	.clock = 22153,
+	.hdisplay = 480,
+	.hsync_start = 480 + 8,
+	.hsync_end = 480 + 8 + 10,
+	.htotal = 480 + 8 + 10 + 10,
+	.vdisplay = 640,
+	.vsync_start = 640 + 4,
+	.vsync_end = 640 + 4 + 3,
+	.vtotal = 640 + 4 + 3 + 4,
+	.vrefresh = 60,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+};
+
+static const struct panel_desc ortustech_com37h3m = {
+	.modes = &ortustech_com37h3m_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 56,	/* 56.16mm */
+		.height = 75,	/* 74.88mm */
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDGE |
+		     DRM_BUS_FLAG_SYNC_DRIVE_POSEDGE,
+};
+
 static const struct drm_display_mode ortustech_com43h4m85ulc_mode  = {
 	.clock = 25000,
 	.hdisplay = 480,
@@ -2786,6 +2813,12 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "ontat,yx700wv03",
 		.data = &ontat_yx700wv03,
+	}, {
+		.compatible = "ortustech,com37h3m05dtc",
+		.data = &ortustech_com37h3m,
+	}, {
+		.compatible = "ortustech,com37h3m099dtc",
+		.data = &ortustech_com37h3m,
 	}, {
 		.compatible = "ortustech,com43h4m85ulc",
 		.data = &ortustech_com43h4m85ulc,
-- 
2.19.1

