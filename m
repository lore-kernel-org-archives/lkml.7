Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B704C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D7920717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380827;
	bh=GKnfwEze/EKWNvYHf5ttos1pfYiQrzdGMKsqzNQSfvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oB4Yhaiyyn0cvVlixGZC2iIi/VFq0P6/ixxwhLQGA92Qb723mehlUBWZr2uNDxFZF
	 autBFFehLmZk57v+cfb6jxC7wGh9JKLcvlnP0lKRYvWTgVOyUQyT3fvdjXaCKQTKIH
	 VLVzSk6yT44DmendNtDMSHyRUBWo2Pon6tH2mvp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390575AbfIMNU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:20:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390004AbfIMNUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:20:23 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7564206BB;
        Fri, 13 Sep 2019 13:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380821;
        bh=GKnfwEze/EKWNvYHf5ttos1pfYiQrzdGMKsqzNQSfvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bmRx9rsm6EX05l6dAfbdoaROp9FDCa4GZUShN91tZaHZK8zNSK9u6OqtD3QfpF7aJ
         xxCBnAy64p9xFz3LptOPNTXGuqBtoltPvAVqYjCUPoqWiYO8vWExfz+c5VtNY+DW9c
         kap5ZDNVAoruUppsQmCaxyfRv6udQaIZmCErsjas=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 167/190] drm/panel: Add support for Armadeus ST0700 Adapt
Date:   Fri, 13 Sep 2019 14:07:02 +0100
Message-Id: <20190913130613.205709423@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c479450f61c7f1f248c9a54aedacd2a6ca521ff8 ]

This patch adds support for the Armadeus ST0700 Adapt. It comes with a
Santek ST0700I5Y-RBSLW 7.0" WVGA (800x480) TFT and an adapter board so
that it can be connected on the TFT header of Armadeus Dev boards.

Cc: stable@vger.kernel.org # v4.19
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20190507152713.27494-1-sebastien.szymanski@armadeus.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../display/panel/armadeus,st0700-adapt.txt   |  9 ++++++
 drivers/gpu/drm/panel/panel-simple.c          | 29 +++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt

diff --git a/Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt b/Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt
new file mode 100644
index 0000000000000..a30d63db3c8f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt
@@ -0,0 +1,9 @@
+Armadeus ST0700 Adapt. A Santek ST0700I5Y-RBSLW 7.0" WVGA (800x480) TFT with
+an adapter board.
+
+Required properties:
+- compatible: "armadeus,st0700-adapt"
+- power-supply: see panel-common.txt
+
+Optional properties:
+- backlight: see panel-common.txt
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index b1d41c4921dd5..5fd94e2060297 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -436,6 +436,32 @@ static const struct panel_desc ampire_am800480r3tmqwa1h = {
 	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
 };
 
+static const struct display_timing santek_st0700i5y_rbslw_f_timing = {
+	.pixelclock = { 26400000, 33300000, 46800000 },
+	.hactive = { 800, 800, 800 },
+	.hfront_porch = { 16, 210, 354 },
+	.hback_porch = { 45, 36, 6 },
+	.hsync_len = { 1, 10, 40 },
+	.vactive = { 480, 480, 480 },
+	.vfront_porch = { 7, 22, 147 },
+	.vback_porch = { 22, 13, 3 },
+	.vsync_len = { 1, 10, 20 },
+	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
+		DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE
+};
+
+static const struct panel_desc armadeus_st0700_adapt = {
+	.timings = &santek_st0700i5y_rbslw_f_timing,
+	.num_timings = 1,
+	.bpc = 6,
+	.size = {
+		.width = 154,
+		.height = 86,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDGE,
+};
+
 static const struct drm_display_mode auo_b101aw03_mode = {
 	.clock = 51450,
 	.hdisplay = 1024,
@@ -2330,6 +2356,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "ampire,am800480r3tmqwa1h",
 		.data = &ampire_am800480r3tmqwa1h,
+	}, {
+		.compatible = "armadeus,st0700-adapt",
+		.data = &armadeus_st0700_adapt,
 	}, {
 		.compatible = "auo,b101aw03",
 		.data = &auo_b101aw03,
-- 
2.20.1



