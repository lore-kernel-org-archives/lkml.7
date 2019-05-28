Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1C4C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200C520989
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YhveFO6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfE1JD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:03:56 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37319 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfE1JDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:54 -0400
Received: by mail-ed1-f67.google.com with SMTP id w37so30611053edw.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SgQWN7Qy07XY45PDKbsaea7nHd8fOh7HY7vqc9lDDrs=;
        b=YhveFO6obxkf1L+jx+Db6oCLojH8CuDk3NDP3lgx0zz5NWc5nsbUOdsUIehgIeM1BN
         WBWnqZTWmwGNFioJLhLKku7J2HgapnGW/0sSUYT1PcRDKQ2e+WNt4i+aF9S/ndAkM4f4
         M8HqFzn+hYlkOTc0lkNvpclW85IFdksfD5yyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SgQWN7Qy07XY45PDKbsaea7nHd8fOh7HY7vqc9lDDrs=;
        b=BDvWgUm/NW5g5IfvUIZw4AWWzROy8c7Ht7Y1Kzno0+ynnhXt5P8ehXsEzSwvOIjzDA
         xoO6JYj9LM+UcsmmvlzgbEQXF1B9V+AWouPDBztuNFo1Lc3jNKCz2G4upyE2aoZNMEHv
         W/WiJU59p8DqKwQXAvFudDLxkW7/WqABrOWCm6q/rJSorcCnN+PLfX9TqqFDI/XHkcg/
         KkYRsQ4cXicglF3vuXPm0eP4s1VKxB4Ikcl8tZgYN5MqNe201P5H5ClwW6yr/rHexFBg
         cS9n1Lr55LeZbarZouTkfwM/AMS2P35JlzW7JXPO/GwxM6lt5tFww7thb2gj6XqcanQf
         DdTA==
X-Gm-Message-State: APjAAAUmM/COm4HrFCaxTlnYnPkuEk3iyztizdvUNLODdgTYU23aQo1a
        G6TawLR89slxUNUSLqx3IlqHZjM062E=
X-Google-Smtp-Source: APXvYqxVTZUIX6lxXo/QeyQ8pL9p1Nq12n0SxFCxYKtzi01dHjTvu+RQjNbAYck6bJqcamIfge9zxA==
X-Received: by 2002:a17:906:5390:: with SMTP id g16mr93483147ejo.12.1559034231783;
        Tue, 28 May 2019 02:03:51 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:51 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Yisheng Xie <ysxie@foxmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Peter Rosin <peda@axentia.se>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 28/33] fbcon: replace FB_EVENT_MODE_CHANGE/_ALL with direct calls
Date:   Tue, 28 May 2019 11:02:59 +0200
Message-Id: <20190528090304.9388-29-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new wrapper function for this, feels like there's some
refactoring room here between the two modes.

v2: backlight notifier is also interested in the mode change event,
it calls lcd->set_mode, of which there are 3 implementations. Thanks
to Maarten for spotting this. So we keep that. We can ditch the differentiation
between mode change and all mode changes (because backlight notifier
doesn't care), and we can drop the FBINFO_MISC_USEREVENT stuff too,
because that's just to prevent recursion between fbmem.c and fbcon.c.

While at it flatten the control flow a bit.

v3: Need to add a static inline to the dummy function.

v4: Add missing #include <fbcon.h> to sh_mob (Sam).

Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
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
 drivers/video/backlight/lcd.c          |  1 -
 drivers/video/fbdev/core/fbcon.c       | 15 +++++++++------
 drivers/video/fbdev/core/fbmem.c       | 21 ++++++++++-----------
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 12 ++----------
 include/linux/fb.h                     |  2 --
 include/linux/fbcon.h                  |  2 ++
 6 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
index 151b18776add..ecdda06989d0 100644
--- a/drivers/video/backlight/lcd.c
+++ b/drivers/video/backlight/lcd.c
@@ -34,7 +34,6 @@ static int fb_notifier_callback(struct notifier_block *self,
 	switch (event) {
 	case FB_EVENT_BLANK:
 	case FB_EVENT_MODE_CHANGE:
-	case FB_EVENT_MODE_CHANGE_ALL:
 	case FB_EARLY_EVENT_BLANK:
 	case FB_R_EARLY_EVENT_BLANK:
 		break;
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index b5ee89f16d6c..e98551f96138 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3009,6 +3009,15 @@ static void fbcon_set_all_vcs(struct fb_info *info)
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
@@ -3318,12 +3327,6 @@ static int fbcon_event_notify(struct notifier_block *self,
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
index 96805fe85332..dd1a708df1a7 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -957,6 +957,7 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 	u32 activate;
 	struct fb_var_screeninfo old_var;
 	struct fb_videomode mode;
+	struct fb_event event;
 
 	if (var->activate & FB_ACTIVATE_INV_MODE) {
 		struct fb_videomode mode1, mode2;
@@ -1039,19 +1040,17 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 	    !list_empty(&info->modelist))
 		ret = fb_add_videomode(&mode, &info->modelist);
 
-	if (!ret && (flags & FBINFO_MISC_USEREVENT)) {
-		struct fb_event event;
-		int evnt = (activate & FB_ACTIVATE_ALL) ?
-			FB_EVENT_MODE_CHANGE_ALL :
-			FB_EVENT_MODE_CHANGE;
+	if (ret)
+		return ret;
 
-		info->flags &= ~FBINFO_MISC_USEREVENT;
-		event.info = info;
-		event.data = &mode;
-		fb_notifier_call_chain(evnt, &event);
-	}
+	event.info = info;
+	event.data = &mode;
+	fb_notifier_call_chain(FB_EVENT_MODE_CHANGE, &event);
 
-	return ret;
+	if (flags & FBINFO_MISC_USEREVENT)
+		fbcon_update_vcs(info, activate & FB_ACTIVATE_ALL);
+
+	return 0;
 }
 EXPORT_SYMBOL(fb_set_var);
 
diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index 015a02a29d37..b8454424910d 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -15,6 +15,7 @@
 #include <linux/ctype.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
+#include <linux/fbcon.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -1757,8 +1758,6 @@ static void sh_mobile_fb_reconfig(struct fb_info *info)
 	struct sh_mobile_lcdc_chan *ch = info->par;
 	struct fb_var_screeninfo var;
 	struct fb_videomode mode;
-	struct fb_event event;
-	int evnt = FB_EVENT_MODE_CHANGE_ALL;
 
 	if (ch->use_count > 1 || (ch->use_count == 1 && !info->fbcon_par))
 		/* More framebuffer users are active */
@@ -1780,14 +1779,7 @@ static void sh_mobile_fb_reconfig(struct fb_info *info)
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
index 1e66fac3124f..f9c212f9b661 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -139,8 +139,6 @@ struct fb_cursor_user {
 #define FB_EVENT_SET_CONSOLE_MAP        0x08
 /*      A display blank is requested       */
 #define FB_EVENT_BLANK                  0x09
-/*      Private modelist is to be replaced */
-#define FB_EVENT_MODE_CHANGE_ALL	0x0B
 /*      CONSOLE-SPECIFIC: remap all consoles to new fb - for vga_switcheroo */
 #define FB_EVENT_REMAP_ALL_CONSOLE      0x0F
 /*      A hardware display blank early change occurred */
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index d67d7ec51ef9..de31eeb22c97 100644
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
@@ -29,6 +30,7 @@ static inline void fbcon_new_modelist(struct fb_info *info) {}
 static inline void fbcon_get_requirement(struct fb_info *info,
 					 struct fb_blit_caps *caps) {}
 static inline void fbcon_fb_blanked(struct fb_info *info, int blank) {}
+static inline void fbcon_update_vcs(struct fb_info *info, bool all) {}
 #endif
 
 #endif /* _LINUX_FBCON_H */
-- 
2.20.1

