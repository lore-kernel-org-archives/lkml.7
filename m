Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0EEC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCB2218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611325;
	bh=Qjhxc18v309AJTyEdDE1sMJn6DSoEUOl+PO/FDPkik0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T1uOuWQM7E8q2z71Anf16NsQH/Hyl1VJjQaDoEwr5uS/SqBKZr2Y75hvQt4S+TVWe
	 AD9uA6QLWmlw9Sd+I99e5jSD1ghdE6GRGVJTeJ4vADXIy8TP+FDLhVIIURkobvv35m
	 7OQomawcwYD0dE9FUBWNt39yDBGfZP68kPV78W1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392072AbfDRSOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:14:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391716AbfDRSOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:14:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 138E7214DA;
        Thu, 18 Apr 2019 18:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611292;
        bh=Qjhxc18v309AJTyEdDE1sMJn6DSoEUOl+PO/FDPkik0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vSq40lMQmoX3feg3FoRJdZ9NcrdQfPBupeclm04UtPjeVhuDPeE1VceiO7WOIxAHx
         ZbLDwwxZ7U1YMVYHhA/9qFkm91SRa4+ML5e5flp+JsxoprdhuOHRqZ+bt05eRtiwH2
         118WoEen1Ag6TbYVBrbjozIFsJ+iVQoY3OTky+us=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Hsin-Yi, Wang" <hsinyi@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 093/110] drm/panel: panel-innolux: set display off in innolux_panel_unprepare
Date:   Thu, 18 Apr 2019 19:57:22 +0200
Message-Id: <20190418160446.652436596@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
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
index 72edb334d997..88c7d035ace6 100644
--- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
+++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
@@ -70,18 +70,12 @@ static inline struct innolux_panel *to_innolux_panel(struct drm_panel *panel)
 static int innolux_panel_disable(struct drm_panel *panel)
 {
 	struct innolux_panel *innolux = to_innolux_panel(panel);
-	int err;
 
 	if (!innolux->enabled)
 		return 0;
 
 	backlight_disable(innolux->backlight);
 
-	err = mipi_dsi_dcs_set_display_off(innolux->link);
-	if (err < 0)
-		DRM_DEV_ERROR(panel->dev, "failed to set display off: %d\n",
-			      err);
-
 	innolux->enabled = false;
 
 	return 0;
@@ -95,6 +89,11 @@ static int innolux_panel_unprepare(struct drm_panel *panel)
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



