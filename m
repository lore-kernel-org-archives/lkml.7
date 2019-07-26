Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B394AC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957E822CF4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfGZJtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:49:21 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:60040 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbfGZJtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:49:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id E25F2FB02;
        Fri, 26 Jul 2019 11:49:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TtfFpcmoz3Q8; Fri, 26 Jul 2019 11:49:13 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 0D36F46AA0; Fri, 26 Jul 2019 11:49:12 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Robert Chiras <robert.chiras@nxp.com>, Marek Vasut <marex@denx.de>,
        Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] drm/mxsfb: Read bus flags from bridge if present
Date:   Fri, 26 Jul 2019 11:49:12 +0200
Message-Id: <9390060f65f94722cb13101d4835d9048037f7a0.1564134488.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1564134488.git.agx@sigxcpu.org>
References: <cover.1564134488.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bridge might have special requirmentes on the input bus. This
is e.g. used by the imx-nwl bridge.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
index e84bac3a541d..3b8eb3ac13b6 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -215,7 +215,7 @@ static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
 {
 	struct drm_device *drm = mxsfb->pipe.crtc.dev;
 	struct drm_display_mode *m = &mxsfb->pipe.crtc.state->adjusted_mode;
-	const u32 bus_flags = mxsfb->connector->display_info.bus_flags;
+	u32 bus_flags = mxsfb->connector->display_info.bus_flags;
 	u32 vdctrl0, vsync_pulse_len, hsync_pulse_len;
 	int err;
 
@@ -239,6 +239,9 @@ static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
 
 	clk_set_rate(mxsfb->clk, m->crtc_clock * 1000);
 
+	if (mxsfb->bridge && mxsfb->bridge->timings)
+		bus_flags = mxsfb->bridge->timings->input_bus_flags;
+
 	DRM_DEV_DEBUG_DRIVER(drm->dev, "Pixel clock: %dkHz (actual: %dkHz)\n",
 			     m->crtc_clock,
 			     (int)(clk_get_rate(mxsfb->clk) / 1000));
-- 
2.20.1

