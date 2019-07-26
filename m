Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2A9C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A80622ADA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfGZNOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:14:53 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:36368 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbfGZNOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:14:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id D501CFB05;
        Fri, 26 Jul 2019 15:14:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nICvhURxg7dB; Fri, 26 Jul 2019 15:14:41 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 23A0446AA3; Fri, 26 Jul 2019 15:14:40 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] drm/panel: jh057n00900: Move panel DSI init to enable()
Date:   Fri, 26 Jul 2019 15:14:36 +0200
Message-Id: <12c3495b234952aafe11980a9e06cfd246134660.1564146727.git.agx@sigxcpu.org>
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

If the panel is wrapped in a panel_bridge it gets prepar()ed before the
upstream DSI bridge which can cause hangs (e.g. with imx-nwl since clocks
are not enabled yet). To avoid this move the panel's first DSI access to
enable() so the upstream bridge can prepare the DSI host controller in
it's pre_enable().

This is also in line with other panel drivers.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 .../gpu/drm/panel/panel-rocktech-jh057n00900.c    | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
index 1274b54f2672..c6b4bfd79fde 100644
--- a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
+++ b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
@@ -143,6 +143,14 @@ static int jh057n_init_sequence(struct jh057n *ctx)
 static int jh057n_enable(struct drm_panel *panel)
 {
 	struct jh057n *ctx = panel_to_jh057n(panel);
+	int ret;
+
+	ret = jh057n_init_sequence(ctx);
+	if (ret < 0) {
+		DRM_DEV_ERROR(ctx->dev, "Panel init sequence failed: %d\n",
+			      ret);
+		return ret;
+	}
 
 	return backlight_enable(ctx->backlight);
 }
@@ -197,13 +205,6 @@ static int jh057n_prepare(struct drm_panel *panel)
 	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
 	msleep(20);
 
-	ret = jh057n_init_sequence(ctx);
-	if (ret < 0) {
-		DRM_DEV_ERROR(ctx->dev, "Panel init sequence failed: %d\n",
-			      ret);
-		return ret;
-	}
-
 	ctx->prepared = true;
 
 	return 0;
-- 
2.20.1

