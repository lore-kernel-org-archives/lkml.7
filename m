Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A70C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1E22184E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jzYFxe7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390362AbfEXIz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:55:28 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40700 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390127AbfEXIyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id j12so13319916eds.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KKTKGhsbv7VsgvEL5zWhJm4bSTrXoG2quXr/om1qy0w=;
        b=jzYFxe7zbdTLFLirqyF3l84Lj/IU/QUuH8wzXWljEfiAHXHPma03OhH0jDUYnWIuJp
         rQbVOIuPkZQK1ta70ZmZ+qXTfHRS+ysFTTHfTwQQ2qPRBsmB+yMt3k9rd2/CjFbNdgIR
         hS3VFvJ9DptOsfpVsfx3AQzlb3F+CCx9ErJFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KKTKGhsbv7VsgvEL5zWhJm4bSTrXoG2quXr/om1qy0w=;
        b=NubY7A0f64B25tjDEibPVwKvVVru7S3MQNEJTU8cRmRRv4yPxIPAZlJU1anZZXo8yf
         927ijD/vLg1/aXawdU9gneVWesML9DMvhovgyrwQnKYGynANNYEHSul7OndzWFmNVuf+
         iqhsYjdYiSV1QWCJqpiB1OYJDyva4uTPZcIeqt6HaEQZCxSNIuVmjnBhh3VL8roE3+s9
         OPqO2xIJ/Go78Co+Ae/Y+7tTDTugsfJHyV/HdJwtIv+dQzCPWRfUj8YNCN10M7Pr/SWl
         GVxXb9aetuuIlu7cjyCB1so59Y+TZGYW+E3hF0dvOK7PbybZeZycs/GK48gCe5UIr0Xr
         yzOw==
X-Gm-Message-State: APjAAAUI2+6pIs6LLegE1jpIEb5i+8W5o6q0MLxqKLsG1DD7GQQzx1EU
        R9ZwSKFAFBpBZCTSQlg88dk54rphgw0=
X-Google-Smtp-Source: APXvYqyeayYhyiaDuJ1eZ78DuwtWgIdV7k/yFMRgqPrM/KMb/elL9Ha/cg/myn+iB8QVchEj153ozg==
X-Received: by 2002:a17:906:5c12:: with SMTP id e18mr14538535ejq.157.1558688071022;
        Fri, 24 May 2019 01:54:31 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:30 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Rosin <peda@axentia.se>, Yisheng Xie <ysxie@foxmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 22/33] fbcon: Call fbcon_mode_deleted/new_modelist directly
Date:   Fri, 24 May 2019 10:53:43 +0200
Message-Id: <20190524085354.27411-23-daniel.vetter@ffwll.ch>
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

I'm not entirely clear on what new_modelist actually does, it seems
exclusively for a sysfs interface. Which in the end does amount to a
normal fb_set_par to check the mode, but then takes a different path
in both fbmem.c and fbcon.c.

I have no idea why these 2 paths are different, but then I also don't
really want to find out. So just do the simple conversion to a direct
function call.

v2: static inline for the dummy versions, I forgot.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Rosin <peda@axentia.se>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/core/fbcon.c | 14 +++-----------
 drivers/video/fbdev/core/fbmem.c | 22 +++++++---------------
 include/linux/fb.h               |  5 -----
 include/linux/fbcon.h            |  6 ++++++
 4 files changed, 16 insertions(+), 31 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 24ea6e4fbee0..35ecd25b385c 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3019,8 +3019,8 @@ static void fbcon_set_all_vcs(struct fb_info *info)
 		fbcon_modechanged(info);
 }
 
-static int fbcon_mode_deleted(struct fb_info *info,
-			      struct fb_videomode *mode)
+int fbcon_mode_deleted(struct fb_info *info,
+		       struct fb_videomode *mode)
 {
 	struct fb_info *fb_info;
 	struct fbcon_display *p;
@@ -3262,7 +3262,7 @@ static void fbcon_fb_blanked(struct fb_info *info, int blank)
 	ops->blank_state = blank;
 }
 
-static void fbcon_new_modelist(struct fb_info *info)
+void fbcon_new_modelist(struct fb_info *info)
 {
 	int i;
 	struct vc_data *vc;
@@ -3324,7 +3324,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 {
 	struct fb_event *event = data;
 	struct fb_info *info = event->info;
-	struct fb_videomode *mode;
 	struct fb_con2fbmap *con2fb;
 	struct fb_blit_caps *caps;
 	int idx, ret = 0;
@@ -3336,10 +3335,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 	case FB_EVENT_MODE_CHANGE_ALL:
 		fbcon_set_all_vcs(info);
 		break;
-	case FB_EVENT_MODE_DELETE:
-		mode = event->data;
-		ret = fbcon_mode_deleted(info, mode);
-		break;
 	case FB_EVENT_SET_CONSOLE_MAP:
 		/* called with console lock held */
 		con2fb = event->data;
@@ -3353,9 +3348,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 	case FB_EVENT_BLANK:
 		fbcon_fb_blanked(info, *(int *)event->data);
 		break;
-	case FB_EVENT_NEW_MODELIST:
-		fbcon_new_modelist(info);
-		break;
 	case FB_EVENT_GET_REQ:
 		caps = event->data;
 		fbcon_get_requirement(info, caps);
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 73269dedcd45..cbdd141e7695 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -966,16 +966,11 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 		/* make sure we don't delete the videomode of current var */
 		ret = fb_mode_is_equal(&mode1, &mode2);
 
-		if (!ret) {
-		    struct fb_event event;
-
-		    event.info = info;
-		    event.data = &mode1;
-		    ret = fb_notifier_call_chain(FB_EVENT_MODE_DELETE, &event);
-		}
+		if (!ret)
+			fbcon_mode_deleted(info, &mode1);
 
 		if (!ret)
-		    fb_delete_videomode(&mode1, &info->modelist);
+			fb_delete_videomode(&mode1, &info->modelist);
 
 
 		ret = (ret) ? -EINVAL : 0;
@@ -1992,7 +1987,6 @@ subsys_initcall(fbmem_init);
 
 int fb_new_modelist(struct fb_info *info)
 {
-	struct fb_event event;
 	struct fb_var_screeninfo var = info->var;
 	struct list_head *pos, *n;
 	struct fb_modelist *modelist;
@@ -2012,14 +2006,12 @@ int fb_new_modelist(struct fb_info *info)
 		}
 	}
 
-	err = 1;
+	if (list_empty(&info->modelist))
+		return 1;
 
-	if (!list_empty(&info->modelist)) {
-		event.info = info;
-		err = fb_notifier_call_chain(FB_EVENT_NEW_MODELIST, &event);
-	}
+	fbcon_new_modelist(info);
 
-	return err;
+	return 0;
 }
 
 MODULE_LICENSE("GPL");
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 794b386415b7..7a788ed8c7b5 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -126,8 +126,6 @@ struct fb_cursor_user {
 
 /*	The resolution of the passed in fb_info about to change */ 
 #define FB_EVENT_MODE_CHANGE		0x01
-/*      An entry from the modelist was removed */
-#define FB_EVENT_MODE_DELETE            0x04
 
 #ifdef CONFIG_GUMSTIX_AM200EPD
 /* only used by mach-pxa/am200epd.c */
@@ -142,9 +140,6 @@ struct fb_cursor_user {
 /*      A hardware display blank change occurred */
 #define FB_EVENT_BLANK                  0x09
 /*      Private modelist is to be replaced */
-#define FB_EVENT_NEW_MODELIST           0x0A
-/*	The resolution of the passed in fb_info about to change and
-        all vc's should be changed         */
 #define FB_EVENT_MODE_CHANGE_ALL	0x0B
 /*	A software display blank change occurred */
 #define FB_EVENT_CONBLANK               0x0C
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index 790c42ec7b5d..c139834342f5 100644
--- a/include/linux/fbcon.h
+++ b/include/linux/fbcon.h
@@ -9,6 +9,9 @@ void fbcon_fb_unregistered(struct fb_info *info);
 void fbcon_fb_unbind(struct fb_info *info);
 void fbcon_suspended(struct fb_info *info);
 void fbcon_resumed(struct fb_info *info);
+int fbcon_mode_deleted(struct fb_info *info,
+		       struct fb_videomode *mode);
+void fbcon_new_modelist(struct fb_info *info);
 #else
 static inline void fb_console_init(void) {}
 static inline void fb_console_exit(void) {}
@@ -17,6 +20,9 @@ static inline void fbcon_fb_unregistered(struct fb_info *info) {}
 static inline void fbcon_fb_unbind(struct fb_info *info) {}
 static inline void fbcon_suspended(struct fb_info *info) {}
 static inline void fbcon_resumed(struct fb_info *info) {}
+static inline int fbcon_mode_deleted(struct fb_info *info,
+				     struct fb_videomode *mode) { return 0; }
+static inline void fbcon_new_modelist(struct fb_info *info) {}
 #endif
 
 #endif /* _LINUX_FBCON_H */
-- 
2.20.1

