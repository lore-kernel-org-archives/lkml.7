Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B397C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22AB422BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfGZNO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:14:57 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:36338 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfGZNOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:14:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 082F9FB02;
        Fri, 26 Jul 2019 15:14:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rl7091_wxe66; Fri, 26 Jul 2019 15:14:42 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 1A20646AA0; Fri, 26 Jul 2019 15:14:40 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] drm/panel: jh057n00900: Move mipi_dsi_dcs_set_display_off to disable()
Date:   Fri, 26 Jul 2019 15:14:37 +0200
Message-Id: <e2c31d34ce1f917065d590297e5115a4ca954874.1564146727.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1564146727.git.agx@sigxcpu.org>
References: <cover.1564146727.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it symmetric with the panel init happening in enable().

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
index c6b4bfd79fde..fed24c51d48b 100644
--- a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
+++ b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
@@ -158,19 +158,19 @@ static int jh057n_enable(struct drm_panel *panel)
 static int jh057n_disable(struct drm_panel *panel)
 {
 	struct jh057n *ctx = panel_to_jh057n(panel);
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
 
-	return backlight_disable(ctx->backlight);
+	backlight_disable(ctx->backlight);
+	return mipi_dsi_dcs_set_display_off(dsi);
 }
 
 static int jh057n_unprepare(struct drm_panel *panel)
 {
 	struct jh057n *ctx = panel_to_jh057n(panel);
-	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
 
 	if (!ctx->prepared)
 		return 0;
 
-	mipi_dsi_dcs_set_display_off(dsi);
 	regulator_disable(ctx->iovcc);
 	regulator_disable(ctx->vcc);
 	ctx->prepared = false;
-- 
2.20.1

