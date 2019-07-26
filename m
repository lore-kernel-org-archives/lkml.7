Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52268C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355EA22C97
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfGZJVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:21:48 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:59352 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfGZJVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:21:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 12041FB04;
        Fri, 26 Jul 2019 11:21:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZwHT3MJlLXlW; Fri, 26 Jul 2019 11:21:45 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 47E3346AA1; Fri, 26 Jul 2019 11:21:43 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm/panel: jh057n00900: Print error code on all DRM_DEV_ERROR()s
Date:   Fri, 26 Jul 2019 11:21:43 +0200
Message-Id: <85e8899f8091c7466283d42a510042ef55882c97.1564132646.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1564132646.git.agx@sigxcpu.org>
References: <cover.1564132646.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of them had these already but two mere missing. This eases
debugging.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
index cc89831e30a6..a182ca7de701 100644
--- a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
+++ b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
@@ -127,7 +127,7 @@ static int jh057n_init_sequence(struct jh057n *ctx)
 
 	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
 	if (ret < 0) {
-		DRM_DEV_ERROR(dev, "Failed to exit sleep mode\n");
+		DRM_DEV_ERROR(dev, "Failed to exit sleep mode: %d\n", ret);
 		return ret;
 	}
 	/* Panel is operational 120 msec after reset */
@@ -355,7 +355,9 @@ static int jh057n_probe(struct mipi_dsi_device *dsi)
 
 	ret = mipi_dsi_attach(dsi);
 	if (ret < 0) {
-		DRM_DEV_ERROR(dev, "mipi_dsi_attach failed. Is host ready?\n");
+		DRM_DEV_ERROR(dev,
+			      "mipi_dsi_attach failed (%d). Is host ready?\n",
+			      ret);
 		drm_panel_remove(&ctx->panel);
 		return ret;
 	}
-- 
2.20.1

