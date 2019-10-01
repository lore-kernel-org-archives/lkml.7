Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D70FA373A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0AF2133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732943AbfJAILH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 04:11:07 -0400
Received: from hermes.aosc.io ([199.195.250.187]:51106 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727361AbfJAILG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 04:11:06 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id B47AA82889;
        Tue,  1 Oct 2019 08:03:52 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 1/3] Revert "drm/sun4i: dsi: Change the start delay calculation"
Date:   Tue,  1 Oct 2019 16:02:51 +0800
Message-Id: <20191001080253.6135-2-icenowy@aosc.io>
In-Reply-To: <20191001080253.6135-1-icenowy@aosc.io>
References: <20191001080253.6135-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit da676c6aa6413d59ab0a80c97bbc273025e640b2.

The original commit adds a start parameter to the calculation of the
start delay according to some old BSP versions from Allwinner. However,
there're two ways to add this delay -- add it in DSI controller or add
it in the TCON. Add it in both controllers won't work.

The code before this commit is picked from new versions of BSP kernel,
which has a comment for the 1 that says "put start_delay to tcon". By
checking the sun4i_tcon0_mode_set_cpu() in sun4i_tcon driver, it has
already added this delay, so we shouldn't repeat to add the delay in DSI
controller, otherwise the timing won't match.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 1636344ba9ec..c86e11631ebc 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -365,8 +365,7 @@ static void sun6i_dsi_inst_init(struct sun6i_dsi *dsi,
 static u16 sun6i_dsi_get_video_start_delay(struct sun6i_dsi *dsi,
 					   struct drm_display_mode *mode)
 {
-	u16 start = clamp(mode->vtotal - mode->vdisplay - 10, 8, 100);
-	u16 delay = mode->vtotal - (mode->vsync_end - mode->vdisplay) + start;
+	u16 delay = mode->vtotal - (mode->vsync_end - mode->vdisplay) + 1;
 
 	if (delay > mode->vtotal)
 		delay = delay % mode->vtotal;
-- 
2.21.0

