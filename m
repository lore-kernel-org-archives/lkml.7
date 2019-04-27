Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866DCC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3B0206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfD0PRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:17:49 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34392 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727719AbfD0PPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:41 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP3D-000144-Rl; Sat, 27 Apr 2019 16:15:39 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0004PY-MB; Sat, 27 Apr 2019 16:15:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        "Ivan Mironov" <mironov.ivan@gmail.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.8048438@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 025/202] drm/fb-helper: Ignore the value of
 fb_var_screeninfo.pixclock
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Mironov <mironov.ivan@gmail.com>

commit 66a8d5bfb518f9f12d47e1d2dce1732279f9451e upstream.

Strict requirement of pixclock to be zero breaks support of SDL 1.2
which contains hardcoded table of supported video modes with non-zero
pixclock values[1].

To better understand which pixclock values are considered valid and how
driver should handle these values, I briefly examined few existing fbdev
drivers and documentation in Documentation/fb/. And it looks like there
are no strict rules on that and actual behaviour varies:

	* some drivers treat (pixclock == 0) as "use defaults" (uvesafb.c);
	* some treat (pixclock == 0) as invalid value which leads to
	  -EINVAL (clps711x-fb.c);
	* some pass converted pixclock value to hardware (uvesafb.c);
	* some are trying to find nearest value from predefined table
          (vga16fb.c, video_gx.c).

Given this, I believe that it should be safe to just ignore this value if
changing is not supported. It seems that any portable fbdev application
which was not written only for one specific device working under one
specific kernel version should not rely on any particular behaviour of
pixclock anyway.

However, while enabling SDL1 applications to work out of the box when
there is no /etc/fb.modes with valid settings, this change affects the
video mode choosing logic in SDL. Depending on current screen
resolution, contents of /etc/fb.modes and resolution requested by
application, this may lead to user-visible difference (not always):
image will be displayed in a right way, but it will be aligned to the
left instead of center. There is no "right behaviour" here as well, as
emulated fbdev, opposing to old fbdev drivers, simply ignores any
requsts of video mode changes with resolutions smaller than current.

The easiest way to reproduce this problem is to install sdl-sopwith[2],
remove /etc/fb.modes file if it exists, and then try to run sopwith
from console without X. At least in Fedora 29, sopwith may be simply
installed from standard repositories.

[1] SDL 1.2.15 source code, src/video/fbcon/SDL_fbvideo.c, vesa_timings
[2] http://sdl-sopwith.sourceforge.net/

Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
Fixes: 79e539453b34e ("DRM: i915: add mode setting support")
Fixes: 771fe6b912fca ("drm/radeon: introduce kernel modesetting for radeon hardware")
Fixes: 785b93ef8c309 ("drm/kms: move driver specific fb common code to helper functions (v2)")
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20190108072353.28078-3-mironov.ivan@gmail.com
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/drm_fb_helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -838,9 +838,14 @@ int drm_fb_helper_check_var(struct fb_va
 	struct drm_fb_helper *fb_helper = info->par;
 	struct drm_framebuffer *fb = fb_helper->fb;
 
-	if (var->pixclock != 0 || in_dbg_master())
+	if (in_dbg_master())
 		return -EINVAL;
 
+	if (var->pixclock != 0) {
+		DRM_DEBUG("fbdev emulation doesn't support changing the pixel clock, value of pixclock is ignored\n");
+		var->pixclock = 0;
+	}
+
 	/* Need to resize the fb object !!! */
 	if (var->bits_per_pixel > fb->bits_per_pixel ||
 	    var->xres > fb->width || var->yres > fb->height ||

