Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06270C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB713206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611300;
	bh=w2ar1zzQGS+MbihlOwPDJJzFGQOf4tudb6KXMChNcrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PzxDGKstrIVeJdZ9fm66DxB9tryc+3xk4/306BJ5K2vEkvq9Y4GT2vzV8YyJlhQBH
	 5tkRKAtvNP6OFP679Tco95sRXDoCbLBUgfHD5fSWN3p44258mfckNuuCLrhXzxbJ6X
	 OH0Xc6XlLC2ubfBO8nHt59X3PCndmWJYmlfn9VXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392131AbfDRSO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:14:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392076AbfDRSOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:14:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95D6D206B6;
        Thu, 18 Apr 2019 18:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611295;
        bh=w2ar1zzQGS+MbihlOwPDJJzFGQOf4tudb6KXMChNcrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VXgXAvFUBb3r+fMgw+GEMYyU2cVKpzRzA2TGmS1+jxDDB4UwZ8hSY1JI/5SkkKE/x
         vHmIo5Ap3rSrgbK/1Wdpv8wmMy82jvI5+28EWCz16d9ICBpFB1A4kdbRug6AIhqZr2
         UQNi88WgtePfs+gUkNGLqyvDz9AxQf80pJ0OJdJs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Hsin-Yi, Wang" <hsinyi@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 61/92] drm/panel: panel-innolux: set display off in innolux_panel_unprepare
Date:   Thu, 18 Apr 2019 19:57:19 +0200
Message-Id: <20190418160435.471416028@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 46f3ceaffa81e846677bca8668e0ad40e643cffd ]

Move mipi_dsi_dcs_set_display_off() from innolux_panel_disable()
to innolux_panel_unprepare(), so they are consistent with
innolux_panel_enable() and innolux_panel_prepare().

This also fixes some mode check and irq timeout issue in MTK dsi code.

Since some dsi code (e.g. mtk_dsi) have following call trace:
1. drm_panel_disable(), which calls innolux_panel_disable()
2. switch to cmd mode
3. drm_panel_unprepare(), which calls innolux_panel_unprepare()

However, mtk_dsi needs to be in cmd mode to be able to send commands
(e.g. mipi_dsi_dcs_set_display_off() and mipi_dsi_dcs_enter_sleep_mode()),
so we need these functions to be called after the switch to cmd mode happens,
i.e. in innolux_panel_unprepare.

Signed-off-by: Hsin-Yi, Wang <hsinyi@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20190109065922.231753-1-hsinyi@chromium.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-innolux-p079zca.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
index 6ba93449fcfb..58b67e0cc385 100644
--- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
+++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
@@ -40,7 +40,6 @@ static inline struct innolux_panel *to_innolux_panel(struct drm_panel *panel)
 static int innolux_panel_disable(struct drm_panel *panel)
 {
 	struct innolux_panel *innolux = to_innolux_panel(panel);
-	int err;
 
 	if (!innolux->enabled)
 		return 0;
@@ -48,11 +47,6 @@ static int innolux_panel_disable(struct drm_panel *panel)
 	innolux->backlight->props.power = FB_BLANK_POWERDOWN;
 	backlight_update_status(innolux->backlight);
 
-	err = mipi_dsi_dcs_set_display_off(innolux->link);
-	if (err < 0)
-		DRM_DEV_ERROR(panel->dev, "failed to set display off: %d\n",
-			      err);
-
 	innolux->enabled = false;
 
 	return 0;
@@ -66,6 +60,11 @@ static int innolux_panel_unprepare(struct drm_panel *panel)
 	if (!innolux->prepared)
 		return 0;
 
+	err = mipi_dsi_dcs_set_display_off(innolux->link);
+	if (err < 0)
+		DRM_DEV_ERROR(panel->dev, "failed to set display off: %d\n",
+			      err);
+
 	err = mipi_dsi_dcs_enter_sleep_mode(innolux->link);
 	if (err < 0) {
 		DRM_DEV_ERROR(panel->dev, "failed to enter sleep mode: %d\n",
-- 
2.19.1



