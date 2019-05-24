Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE04C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DB821851
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LyYiPBST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390328AbfEXIzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:55:09 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35129 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390197AbfEXIyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id p26so13358542edr.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9WmBFbeYFeGRWKNmknfE/Bb5tv4OUq/PF0i+TdgrZY4=;
        b=LyYiPBSTFv3OUCUoeoroCwhzZ/RaA0umPdg8dObLgnRRY0DijDF12FDHQLqes/8NyL
         2QV99bVKfdY5KNeiJNoo1U0HXMzWNW+EImHJNI0M8xyQ2zkR/Crk7dXqqvsb1Alxc5zT
         ykO92Ivoi2fmBpk/r3xhdVuzsyDaD+X27aeoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9WmBFbeYFeGRWKNmknfE/Bb5tv4OUq/PF0i+TdgrZY4=;
        b=R1KlKPtcY3AejFhZ16K9jquQafaBisAtfUipN6zC+eKAUEfrwMDS8QARNNfr6fWFPc
         1KhywG6ahZ777WgiHQeYzkkWAwV7BN7WqvsOwXleDWc4Sz9zGStqD579jN1aBJAGmj1P
         MOvaOw1FlUcTZsShZJnckfNWxX8zwuRQVs2F2CO/EQtu9ZH1Sv2U4AWKyiJxWkY3oiy0
         NdsoSKiNv74YeDkQjZ3timgTw9fJNJ6lpfW1SEb/WgYsNnVrGI9/ZhiOuPrsNj0fRCgs
         6drqHu57AmykMTVvIFi2gIBWBWF05ewIrbgGWMNMNY1TSaeHRDpLQsCFeVEsWr9O36Jd
         37lQ==
X-Gm-Message-State: APjAAAXHH4eyjlUpbxPpmeIfVnkj2/bJmzkI0JspZR5864qGDg3baXLn
        vGcTFUYMImBcRTF97yHLkilHxAPxKRY=
X-Google-Smtp-Source: APXvYqyzSTT8rIwJRkrY6jqOelfUKRrLonlK4Yyn5esX/fQUYCbVfe9V08S/v03u29cTQLOs2oRkQQ==
X-Received: by 2002:a50:e40f:: with SMTP id d15mr103664967edm.0.1558688078635;
        Fri, 24 May 2019 01:54:38 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:37 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
Subject: [PATCH 28/33] fbcon: replace FB_EVENT_MODE_CHANGE/_ALL with direct calls
Date:   Fri, 24 May 2019 10:53:49 +0200
Message-Id: <20190524085354.27411-29-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
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

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
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
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 11 +----------
 include/linux/fb.h                     |  2 --
 include/linux/fbcon.h                  |  2 ++
 6 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
index 4b40c6a4d441..a758039475d0 100644
--- a/drivers/video/backlight/lcd.c
+++ b/drivers/video/backlight/lcd.c
@@ -33,7 +33,6 @@ static int fb_notifier_callback(struct notifier_block *self,
 	switch (event) {
 	case FB_EVENT_BLANK:
 	case FB_EVENT_MODE_CHANGE:
-	case FB_EVENT_MODE_CHANGE_ALL:
 	case FB_EARLY_EVENT_BLANK:
 	case FB_R_EARLY_EVENT_BLANK:
 		break;
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 8a67505167ae..a07c261da53a 100644
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

