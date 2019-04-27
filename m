Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D026C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF933208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfD0P01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:26:27 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34896 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728482AbfD0P0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:26:24 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP3E-0000zO-3a; Sat, 27 Apr 2019 16:15:40 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0004PU-LV; Sat, 27 Apr 2019 16:15:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "saahriktu" <mail@saahriktu.org>,
        "Ivan Mironov" <mironov.ivan@gmail.com>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.424532012@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 024/202] drm/fb-helper: Partially bring back
 workaround for bugs of SDL 1.2
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

commit 62d85b3bf9d978ed4b6b2aeef5cf0ccf1423906e upstream.

SDL 1.2 sets all fields related to the pixel format to zero in some
cases[1]. Prior to commit db05c48197759 ("drm: fb-helper: Reject all
pixel format changing requests"), there was an unintentional workaround
for this that existed for more than a decade. First in device-specific DRM
drivers, then here in drm_fb_helper.c.

Previous code containing this workaround just ignores pixel format fields
from userspace code. Not a good thing either, as this way, driver may
silently use pixel format different from what client actually requested,
and this in turn will lead to displaying garbage on the screen. I think
that returning EINVAL to userspace in this particular case is the right
option, so I decided to left code from problematic commit untouched
instead of just reverting it entirely.

Here is the steps required to reproduce this problem exactly:
	1) Compile fceux[2] with SDL 1.2.15 and without GTK or OpenGL
	   support. SDL should be compiled with fbdev support (which is
	   on by default).
	2) Create /etc/fb.modes with following contents (values seems
	   not used, and just required to trigger problematic code in
	   SDL):

		mode "test"
		    geometry 1 1 1 1 1
		    timings 1 1 1 1 1 1 1
		endmode

	3) Create ~/.fceux/fceux.cfg with following contents:

		SDL.Hotkeys.Quit = 27
		SDL.DoubleBuffering = 1

	4) Ensure that screen resolution is at least 1280x960 (e.g.
	   append "video=Virtual-1:1280x960-32" to the kernel cmdline
	   for qemu/QXL).

	5) Try to run fceux on VT with some ROM file[3]:

		# ./fceux color_test.nes

[1] SDL 1.2.15 source code, src/video/fbcon/SDL_fbvideo.c,
    FB_SetVideoMode()
[2] http://www.fceux.com
[3] Example ROM: https://github.com/bokuweb/rustynes/blob/master/roms/color_test.nes

Reported-by: saahriktu <mail@saahriktu.org>
Suggested-by: saahriktu <mail@saahriktu.org>
Fixes: db05c48197759 ("drm: fb-helper: Reject all pixel format changing requests")
Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
[danvet: Delete misleading comment.]
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20190108072353.28078-2-mironov.ivan@gmail.com
Link: https://patchwork.freedesktop.org/patch/msgid/20190108072353.28078-2-mironov.ivan@gmail.com
[bwh: Backported to 3.16:
 - Use fb->depth instead of fb->format->depth
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/drm_fb_helper.c | 126 ++++++++++++++++++--------------
 1 file changed, 73 insertions(+), 53 deletions(-)

--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -769,6 +769,64 @@ static bool drm_fb_pixel_format_equal(co
 	       var_1->transp.msb_right == var_2->transp.msb_right;
 }
 
+static void drm_fb_helper_fill_pixel_fmt(struct fb_var_screeninfo *var,
+					 u8 depth)
+{
+	switch (depth) {
+	case 8:
+		var->red.offset = 0;
+		var->green.offset = 0;
+		var->blue.offset = 0;
+		var->red.length = 8; /* 8bit DAC */
+		var->green.length = 8;
+		var->blue.length = 8;
+		var->transp.offset = 0;
+		var->transp.length = 0;
+		break;
+	case 15:
+		var->red.offset = 10;
+		var->green.offset = 5;
+		var->blue.offset = 0;
+		var->red.length = 5;
+		var->green.length = 5;
+		var->blue.length = 5;
+		var->transp.offset = 15;
+		var->transp.length = 1;
+		break;
+	case 16:
+		var->red.offset = 11;
+		var->green.offset = 5;
+		var->blue.offset = 0;
+		var->red.length = 5;
+		var->green.length = 6;
+		var->blue.length = 5;
+		var->transp.offset = 0;
+		break;
+	case 24:
+		var->red.offset = 16;
+		var->green.offset = 8;
+		var->blue.offset = 0;
+		var->red.length = 8;
+		var->green.length = 8;
+		var->blue.length = 8;
+		var->transp.offset = 0;
+		var->transp.length = 0;
+		break;
+	case 32:
+		var->red.offset = 16;
+		var->green.offset = 8;
+		var->blue.offset = 0;
+		var->red.length = 8;
+		var->green.length = 8;
+		var->blue.length = 8;
+		var->transp.offset = 24;
+		var->transp.length = 8;
+		break;
+	default:
+		break;
+	}
+}
+
 /**
  * drm_fb_helper_check_var - implementation for ->fb_check_var
  * @var: screeninfo to check
@@ -796,6 +854,20 @@ int drm_fb_helper_check_var(struct fb_va
 	}
 
 	/*
+	 * Workaround for SDL 1.2, which is known to be setting all pixel format
+	 * fields values to zero in some cases. We treat this situation as a
+	 * kind of "use some reasonable autodetected values".
+	 */
+	if (!var->red.offset     && !var->green.offset    &&
+	    !var->blue.offset    && !var->transp.offset   &&
+	    !var->red.length     && !var->green.length    &&
+	    !var->blue.length    && !var->transp.length   &&
+	    !var->red.msb_right  && !var->green.msb_right &&
+	    !var->blue.msb_right && !var->transp.msb_right) {
+		drm_fb_helper_fill_pixel_fmt(var, fb->depth);
+	}
+
+	/*
 	 * drm fbdev emulation doesn't support changing the pixel format at all,
 	 * so reject all pixel format changing requests.
 	 */
@@ -1058,59 +1130,7 @@ void drm_fb_helper_fill_var(struct fb_in
 	info->var.height = -1;
 	info->var.width = -1;
 
-	switch (fb->depth) {
-	case 8:
-		info->var.red.offset = 0;
-		info->var.green.offset = 0;
-		info->var.blue.offset = 0;
-		info->var.red.length = 8; /* 8bit DAC */
-		info->var.green.length = 8;
-		info->var.blue.length = 8;
-		info->var.transp.offset = 0;
-		info->var.transp.length = 0;
-		break;
-	case 15:
-		info->var.red.offset = 10;
-		info->var.green.offset = 5;
-		info->var.blue.offset = 0;
-		info->var.red.length = 5;
-		info->var.green.length = 5;
-		info->var.blue.length = 5;
-		info->var.transp.offset = 15;
-		info->var.transp.length = 1;
-		break;
-	case 16:
-		info->var.red.offset = 11;
-		info->var.green.offset = 5;
-		info->var.blue.offset = 0;
-		info->var.red.length = 5;
-		info->var.green.length = 6;
-		info->var.blue.length = 5;
-		info->var.transp.offset = 0;
-		break;
-	case 24:
-		info->var.red.offset = 16;
-		info->var.green.offset = 8;
-		info->var.blue.offset = 0;
-		info->var.red.length = 8;
-		info->var.green.length = 8;
-		info->var.blue.length = 8;
-		info->var.transp.offset = 0;
-		info->var.transp.length = 0;
-		break;
-	case 32:
-		info->var.red.offset = 16;
-		info->var.green.offset = 8;
-		info->var.blue.offset = 0;
-		info->var.red.length = 8;
-		info->var.green.length = 8;
-		info->var.blue.length = 8;
-		info->var.transp.offset = 24;
-		info->var.transp.length = 8;
-		break;
-	default:
-		break;
-	}
+	drm_fb_helper_fill_pixel_fmt(&info->var, fb->depth);
 
 	info->var.xres = fb_width;
 	info->var.yres = fb_height;

