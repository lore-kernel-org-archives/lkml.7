Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB06C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 18:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107BC21738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 18:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732820AbfFYSCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 14:02:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58790 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfFYSCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 14:02:39 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id 2ECC328626E
From:   Robert Beckett <bob.beckett@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Robert Beckett <bob.beckett@collabora.com>
Subject: [PATCH v3 2/4] drm/imx: notify drm core before sending event during crtc disable
Date:   Tue, 25 Jun 2019 18:59:13 +0100
Message-Id: <066eb916ec920e0515367548e4af2ee28f9d0a43.1561483965.git.bob.beckett@collabora.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1561483965.git.bob.beckett@collabora.com>
References: <cover.1561483965.git.bob.beckett@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Notify drm core before sending pending events during crtc disable.
This fixes the first event after disable having an old stale timestamp
by having drm_crtc_vblank_off update the timestamp to now.

This was seen while debugging weston log message:
Warning: computed repaint delay is insane: -8212 msec

This occured due to:
1. driver starts up
2. fbcon comes along and restores fbdev, enabling vblank
3. vblank_disable_fn fires via timer disabling vblank, keeping vblank
seq number and time set at current value
(some time later)
4. weston starts and does a modeset
5. atomic commit disables crtc while it does the modeset
6. ipu_crtc_atomic_disable sends vblank with old seq number and time

Fixes: a474478642d5 ("drm/imx: fix crtc vblank state regression")

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 drivers/gpu/drm/imx/ipuv3-crtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/ipuv3-crtc.c b/drivers/gpu/drm/imx/ipuv3-crtc.c
index 9cc1d678674f..e04d6efff1b5 100644
--- a/drivers/gpu/drm/imx/ipuv3-crtc.c
+++ b/drivers/gpu/drm/imx/ipuv3-crtc.c
@@ -91,14 +91,14 @@ static void ipu_crtc_atomic_disable(struct drm_crtc *crtc,
 	ipu_dc_disable(ipu);
 	ipu_prg_disable(ipu);
 
+	drm_crtc_vblank_off(crtc);
+
 	spin_lock_irq(&crtc->dev->event_lock);
 	if (crtc->state->event) {
 		drm_crtc_send_vblank_event(crtc, crtc->state->event);
 		crtc->state->event = NULL;
 	}
 	spin_unlock_irq(&crtc->dev->event_lock);
-
-	drm_crtc_vblank_off(crtc);
 }
 
 static void imx_drm_crtc_reset(struct drm_crtc *crtc)
-- 
2.18.0

