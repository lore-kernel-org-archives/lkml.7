Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834C1FA373E
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645502133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732928AbfJAILG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 04:11:06 -0400
Received: from hermes.aosc.io ([199.195.250.187]:51108 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727511AbfJAILG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 04:11:06 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 7F4E782AFC;
        Tue,  1 Oct 2019 08:03:58 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 2/3] drm/sun4i: dsi: fix DRQ calculation
Date:   Tue,  1 Oct 2019 16:02:52 +0800
Message-Id: <20191001080253.6135-3-icenowy@aosc.io>
In-Reply-To: <20191001080253.6135-1-icenowy@aosc.io>
References: <20191001080253.6135-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the BSP source code, when calculating the magic DRQ value
outside burst mode, a formula of "lcd_ht - lcd_x - lcd_hbp", which is
interpreted as right margin (HFP value). However, currently the
sun6i_mipi_dsi driver code calculates it wrongly as HFP + sync length,
which lead to timing error.

Fix the DRQ calculation by change it to use HFP.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index c86e11631ebc..2d3e822a7739 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -436,9 +436,9 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 			     SUN6I_DSI_BURST_LINE_SYNC_POINT(SUN6I_DSI_SYNC_POINT));
 
 		val = SUN6I_DSI_TCON_DRQ_ENABLE_MODE;
-	} else if ((mode->hsync_end - mode->hdisplay) > 20) {
+	} else if ((mode->hsync_start - mode->hdisplay) > 20) {
 		/* Maaaaaagic */
-		u16 drq = (mode->hsync_end - mode->hdisplay) - 20;
+		u16 drq = (mode->hsync_start - mode->hdisplay) - 20;
 
 		drq *= mipi_dsi_pixel_format_to_bpp(device->format);
 		drq /= 32;
-- 
2.21.0

