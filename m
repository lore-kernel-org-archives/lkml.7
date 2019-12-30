Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56880C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 13:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32425206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 13:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfL3N1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 08:27:45 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:49052 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbfL3N1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 08:27:45 -0500
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id kDTf2100A5USYZQ01DTf3m; Mon, 30 Dec 2019 14:27:42 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ilv59-0001Yv-B0; Mon, 30 Dec 2019 14:27:39 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1ilv59-0001C0-8p; Mon, 30 Dec 2019 14:27:39 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Stefan Agner <stefan@agner.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] drm/fb-helper: Round up bits_per_pixel if possible
Date:   Mon, 30 Dec 2019 14:27:34 +0100
Message-Id: <20191230132734.4538-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When userspace requests a video mode parameter value that is not
supported, frame buffer device drivers should round it up to a supported
value, if possible, instead of just rejecting it.  This allows
applications to quickly scan for supported video modes.

Currently this rule is not followed for the number of bits per pixel,
causing e.g. "fbset -depth N" to fail, if N is smaller than the current
number of bits per pixel.

Fix this by returning an error only if bits per pixel is too large, and
setting it to the current value otherwise.

See also Documentation/fb/framebuffer.rst, Section 2 (Programmer's View
of /dev/fb*").

Fixes: 865afb11949e5bf4 ("drm/fb-helper: reject any changes to the fbdev")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Against drm-misc#for-linux-next.
Applies with some fuzz against v5.5-rc4.
---
 drivers/gpu/drm/drm_fb_helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index f8e9051926083373..cae8fa74781c8db0 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1267,7 +1267,7 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
 	 * Changes struct fb_var_screeninfo are currently not pushed back
 	 * to KMS, hence fail if different settings are requested.
 	 */
-	if (var->bits_per_pixel != fb->format->cpp[0] * 8 ||
+	if (var->bits_per_pixel > fb->format->cpp[0] * 8 ||
 	    var->xres > fb->width || var->yres > fb->height ||
 	    var->xres_virtual > fb->width || var->yres_virtual > fb->height) {
 		drm_dbg_kms(dev, "fb requested width/height/bpp can't fit in current fb "
@@ -1292,6 +1292,11 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
 		drm_fb_helper_fill_pixel_fmt(var, fb->format->depth);
 	}
 
+	/*
+	 * Likewise, bits_per_pixel should be rounded up to a supported value.
+	 */
+	var->bits_per_pixel = fb->format->cpp[0] * 8;
+
 	/*
 	 * drm fbdev emulation doesn't support changing the pixel format at all,
 	 * so reject all pixel format changing requests.
-- 
2.17.1

