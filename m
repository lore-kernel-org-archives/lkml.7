Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02938C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 19:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80252133F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 19:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfCXTGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 15:06:22 -0400
Received: from mailoutvs30.siol.net ([185.57.226.221]:51078 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726347AbfCXTGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 15:06:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 01A40521801;
        Sun, 24 Mar 2019 20:06:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2-7ImW5wSYML; Sun, 24 Mar 2019 20:06:18 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 9BCFB520BC8;
        Sun, 24 Mar 2019 20:06:18 +0100 (CET)
Received: from localhost.localdomain (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 7C137521801;
        Sun, 24 Mar 2019 20:06:16 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, wens@csie.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] drm/sun4i: DW HDMI: Lower max. supported rate for H6
Date:   Sun, 24 Mar 2019 20:06:09 +0100
Message-Id: <20190324190609.32721-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently resolutions with pixel clock higher than 340 MHz don't work
with H6 HDMI controller. They just produce a blank screen.

Limit maximum pixel clock rate to 340 MHz until scrambling is supported.

Cc: stable@vger.kernel.org # 5.0
Fixes: 40bb9d3147b2 ("drm/sun4i: Add support for H6 DW HDMI controller")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4=
i/sun8i_dw_hdmi.c
index caea5a9f8f1d..ba4ce576b471 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -48,8 +48,13 @@ static enum drm_mode_status
 sun8i_dw_hdmi_mode_valid_h6(struct drm_connector *connector,
 			    const struct drm_display_mode *mode)
 {
-	/* This is max for HDMI 2.0b (4K@60Hz) */
-	if (mode->clock > 594000)
+	/*
+	 * Controller support maximum of 594 MHz, which correlates to
+	 * 4K@60Hz 4:4:4 or RGB. However, for frequencies greater than
+	 * 340 MHz scrambling has to be enabled. Because scrambling is
+	 * not yet implemented, just limit to 340 MHz for now.
+	 */
+	if (mode->clock > 340000)
 		return MODE_CLOCK_HIGH;
=20
 	return MODE_OK;
--=20
2.21.0

