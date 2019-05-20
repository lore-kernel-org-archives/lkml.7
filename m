Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56F6C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E9920862
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PK3f3Vx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbfETIXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:23:01 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37777 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731463AbfETIW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:22:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id w37so22553995edw.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q6P++AEHOfkI5D/k3xa/uIHx1Va0IWogL9C+chYy+0M=;
        b=PK3f3Vx3oGduWZ98IJle+zkC490p6u9MUtW5NT7k59m0xD/RLGW62SSq1cXa4+HyvR
         9s09i/sm7ZsfA8jQVdfHcNfDOUl4YNOuEmOEq4mHqED0v9IXc7M5rAOs7v0fhV3EF6Vs
         TG+33NSX7tt76hfxV8/MJG4YgU6ZMRh+hCFa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q6P++AEHOfkI5D/k3xa/uIHx1Va0IWogL9C+chYy+0M=;
        b=OP5w6vS/PnORHD2xp0s9+5HWriaq5pZq+dgTm2Dokxh4aAO4G80fhVaKyK2YzbF6nj
         00ok14gd1RLdi17WKm+v88AufL8UqjBp4zRs67qFU88I+MN++v083QNJf8f7hxc7aAG5
         lFJCMOf3KvcWqMA53pCxU7+rmbOsdoRu+b+TtQSBwDkUb9R2ltuaHWSm8TFh1Wtjhkg0
         pM9R4aO8bAswrQ+G8SMS/fpJpKrxbIegZAKEclFeksrSSnD0yAJtg0V8q6EU1S1ucUaz
         wcCQOXcplyuOivkRv26RZV+jtdLBsPI7lGzNm4EDAbo+ch0cbtc0lgd/rhQUJoxZsQxs
         eCGA==
X-Gm-Message-State: APjAAAUi2PxhFBNPOlWmaokkCI7RsFOkJxGy7TtrUbYGhwTOdIvc0kXJ
        w9y+gTOvY+qdnf6rJRsFHMxvBw==
X-Google-Smtp-Source: APXvYqxLFYQEccqbEEoz4CZU1c0rosU1RFmwQ6qoAwQYvN4E5ULWhShEPi+9ab13r9OQgEDxJDJ+rg==
X-Received: by 2002:a50:f4fb:: with SMTP id v56mr75508876edm.13.1558340576097;
        Mon, 20 May 2019 01:22:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:55 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Yisheng Xie <ysxie@foxmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Peter Rosin <peda@axentia.se>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 29/33] fbcon: replace FB_EVENT_MODE_CHANGE/_ALL with direct calls
Date:   Mon, 20 May 2019 10:22:12 +0200
Message-Id: <20190520082216.26273-30-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new wrapper function for this, feels like there's some
refactoring room here between the two modes.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Peter Rosin <peda@axentia.se>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/backlight/lcd.c          |  2 --
 drivers/video/fbdev/core/fbcon.c       | 15 +++++++++------
 drivers/video/fbdev/core/fbmem.c       | 13 ++-----------
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 11 +----------
 include/linux/fb.h                     |  4 ----
 include/linux/fbcon.h                  |  2 ++
 6 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
index 4b40c6a4d441..16298041b141 100644
--- a/drivers/video/backlight/lcd.c
+++ b/drivers/video/backlight/lcd.c
@@ -32,8 +32,6 @@ static int fb_notifier_callback(struct notifier_block *self,
 	/* If we aren't interested in this event, skip it immediately ... */
 	switch (event) {
 	case FB_EVENT_BLANK:
-	case FB_EVENT_MODE_CHANGE:
-	case FB_EVENT_MODE_CHANGE_ALL:
 	case FB_EARLY_EVENT_BLANK:
 	case FB_R_EARLY_EVENT_BLANK:
 		break;
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index c1a7476e980f..8cc62d340387 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3005,6 +3005,15 @@ static void fbcon_set_all_vcs(struct fb_info *info)
 		fbcon_modechanged(info);
 }
 
+
+void fbcon_update_vcs(struct fb_info *info, bool all)
+{
+	if (all)
+		fbcon_set_all_vcs(info);
+	else
+		fbcon_modechanged(info);
+}
+
 int fbcon_mode_deleted(struct fb_info *info,
 		       struct fb_videomode *mode)
 {
@@ -3314,12 +3323,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 	int idx, ret = 0;
 
 	switch(action) {
-	case FB_EVENT_MODE_CHANGE:
-		fbcon_modechanged(info);
-		break;
-	case FB_EVENT_MODE_CHANGE_ALL:
-		fbcon_set_all_vcs(info);
-		break;
 	case FB_EVENT_SET_CONSOLE_MAP:
 		/* called with console lock held */
 		con2fb = event->data;
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index cbd58ba8a59d..55b88163edc2 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1039,17 +1039,8 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 	    !list_empty(&info->modelist))
 		ret = fb_add_videomode(&mode, &info->modelist);
 
-	if (!ret && (flags & FBINFO_MISC_USEREVENT)) {
-		struct fb_event event;
-		int evnt = (activate & FB_ACTIVATE_ALL) ?
-			FB_EVENT_MODE_CHANGE_ALL :
-			FB_EVENT_MODE_CHANGE;
-
-		info->flags &= ~FBINFO_MISC_USEREVENT;
-		event.info = info;
-		event.data = &mode;
-		fb_notifier_call_chain(evnt, &event);
-	}
+	if (!ret && (flags & FBINFO_MISC_USEREVENT))
+		fbcon_update_vcs(info, activate & FB_ACTIVATE_ALL);
 
 	return ret;
 }
diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index 0d7a044852d7..bb1a610d0363 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1776,8 +1776,6 @@ static void sh_mobile_fb_reconfig(struct fb_info *info)
 	struct sh_mobile_lcdc_chan *ch = info->par;
 	struct fb_var_screeninfo var;
 	struct fb_videomode mode;
-	struct fb_event event;
-	int evnt = FB_EVENT_MODE_CHANGE_ALL;
 
 	if (ch->use_count > 1 || (ch->use_count == 1 && !info->fbcon_par))
 		/* More framebuffer users are active */
@@ -1799,14 +1797,7 @@ static void sh_mobile_fb_reconfig(struct fb_info *info)
 		/* Couldn't reconfigure, hopefully, can continue as before */
 		return;
 
-	/*
-	 * fb_set_var() calls the notifier change internally, only if
-	 * FBINFO_MISC_USEREVENT flag is set. Since we do not want to fake a
-	 * user event, we have to call the chain ourselves.
-	 */
-	event.info = info;
-	event.data = &ch->display.mode;
-	fb_notifier_call_chain(evnt, &event);
+	fbcon_update_vcs(info, true);
 }
 
 /*
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 4b9b882f8f52..54d6bee09121 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -124,16 +124,12 @@ struct fb_cursor_user {
  * Register/unregister for framebuffer events
  */
 
-/*	The resolution of the passed in fb_info about to change */ 
-#define FB_EVENT_MODE_CHANGE		0x01
 /*      CONSOLE-SPECIFIC: get console to framebuffer mapping */
 #define FB_EVENT_GET_CONSOLE_MAP        0x07
 /*      CONSOLE-SPECIFIC: set console to framebuffer mapping */
 #define FB_EVENT_SET_CONSOLE_MAP        0x08
 /*      A display blank is requested       */
 #define FB_EVENT_BLANK                  0x09
-/*      Private modelist is to be replaced */
-#define FB_EVENT_MODE_CHANGE_ALL	0x0B
 /*      CONSOLE-SPECIFIC: remap all consoles to new fb - for vga_switcheroo */
 #define FB_EVENT_REMAP_ALL_CONSOLE      0x0F
 /*      A hardware display blank early change occurred */
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index 90e196c835dd..daaa97b0c9e6 100644
--- a/include/linux/fbcon.h
+++ b/include/linux/fbcon.h
@@ -15,6 +15,7 @@ void fbcon_new_modelist(struct fb_info *info);
 void fbcon_get_requirement(struct fb_info *info,
 			   struct fb_blit_caps *caps);
 void fbcon_fb_blanked(struct fb_info *info, int blank);
+void fbcon_update_vcs(struct fb_info *info, bool all);
 #else
 static inline void fb_console_init(void) {}
 static inline void fb_console_exit(void) {}
@@ -29,6 +30,7 @@ void fbcon_new_modelist(struct fb_info *info) {}
 void fbcon_get_requirement(struct fb_info *info,
 			   struct fb_blit_caps *caps) {}
 void fbcon_fb_blanked(struct fb_info *info, int blank) {}
+void fbcon_update_vcs(struct fb_info *info, bool all) {}
 #endif
 
 #endif /* _LINUX_FBCON_H */
-- 
2.20.1

