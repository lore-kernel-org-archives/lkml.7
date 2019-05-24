Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90240C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE9F2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NJ8OEATn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390193AbfEXIyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:54:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45585 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390133AbfEXIyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:35 -0400
Received: by mail-ed1-f66.google.com with SMTP id g57so13292365edc.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=znnLdm+yQ71WFmt7kLWZGmMLOzxs4OCBVinE6bbZA4Y=;
        b=NJ8OEATnxXWD56mTKUGRfajOhFqs3YlX2AUO2Sra8BYRTMv0Er8U0pVc7lDrLLGrCn
         WJ2RC7XaiFeAIfow+ZWqG1XLf49/jma1L8/SHHAFairjKnNcQIR/qkxjeL9gjyXWdxoI
         2LDBeP/Cfjaf59MrqHFlKTFP3FW54HcbWfuLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=znnLdm+yQ71WFmt7kLWZGmMLOzxs4OCBVinE6bbZA4Y=;
        b=ElyalJ6L7gkrZNhX1NHhh6XChsT1gfhLABfvGSBZI7XbOV02mur6qwyIngSqhctEpn
         kCJC1xGpO1qQ/XbuVmF2nrMNRIeaG5sR0Q6dDG9V1oqXUbcwqvzCwDrKhvH3AZ83Bjmi
         cPrAkz5fKoy04WwEF/3og+z3zp9qPT58l1PaVIC6wpnRzc6aFVNItQNSQgVnpv8Y9DRE
         nKw+n9U4Gze6ufIbQNZBxjYDNdtYHzOrn0O/hKh0lxMlQ35y4u3yPmCBpWEcIa9sNzlw
         oqytAQihvJ8RW5cV3p7Um6plVoHrRLOBTwQ91TDZU0L4lCXYwYeAiBPXOa/Gulp2HmsF
         7zNQ==
X-Gm-Message-State: APjAAAXnes4NNlOqXvpvcJPQNNy/YXfKEdW2ptcsB58zQLhI9wa2PLEB
        knHpN8QeXxYjQn72UIleZQsBpUxLR3E=
X-Google-Smtp-Source: APXvYqzqvuCgwWN2IJeOxAiCyiaRfFhD6ZFX9TJUZtD+BC+UcpFal9VNe+dc2+nUz2bdqCHHB9iU6Q==
X-Received: by 2002:a17:906:5a08:: with SMTP id p8mr63846987ejq.276.1558688073589;
        Fri, 24 May 2019 01:54:33 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:32 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Richard Purdie <rpurdie@rpsys.net>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Yisheng Xie <ysxie@foxmail.com>, linux-fbdev@vger.kernel.org
Subject: [PATCH 24/33] Revert "backlight/fbcon: Add FB_EVENT_CONBLANK"
Date:   Fri, 24 May 2019 10:53:45 +0200
Message-Id: <20190524085354.27411-25-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 994efacdf9a087b52f71e620b58dfa526b0cf928.

The justification is that if hw blanking fails (i.e. fbops->fb_blank)
fails, then we still want to shut down the backlight. Which is exactly
_not_ what fb_blank() does and so rather inconsistent if we end up
with different behaviour between fbcon and direct fbdev usage. Given
that the entire notifier maze is getting in the way anyway I figured
it's simplest to revert this not well justified commit.

v2: Add static inline to the dummy version.

Cc: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/backlight/backlight.c |  2 +-
 drivers/video/fbdev/core/fbcon.c    | 14 +-------------
 drivers/video/fbdev/core/fbmem.c    |  1 +
 include/linux/fb.h                  |  4 +---
 include/linux/fbcon.h               |  2 ++
 5 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index deb824bef6e2..c55590ec0057 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -46,7 +46,7 @@ static int fb_notifier_callback(struct notifier_block *self,
 	int fb_blank = 0;
 
 	/* If we aren't interested in this event, skip it immediately ... */
-	if (event != FB_EVENT_BLANK && event != FB_EVENT_CONBLANK)
+	if (event != FB_EVENT_BLANK)
 		return 0;
 
 	bd = container_of(self, struct backlight_device, fb_notif);
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 259cdd118475..d9f545f1a81b 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2350,8 +2350,6 @@ static int fbcon_switch(struct vc_data *vc)
 static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
 				int blank)
 {
-	struct fb_event event;
-
 	if (blank) {
 		unsigned short charmask = vc->vc_hi_font_mask ?
 			0x1ff : 0xff;
@@ -2362,13 +2360,6 @@ static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
 		fbcon_clear(vc, 0, 0, vc->vc_rows, vc->vc_cols);
 		vc->vc_video_erase_char = oldc;
 	}
-
-
-	lock_fb_info(info);
-	event.info = info;
-	event.data = &blank;
-	fb_notifier_call_chain(FB_EVENT_CONBLANK, &event);
-	unlock_fb_info(info);
 }
 
 static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
@@ -3240,7 +3231,7 @@ int fbcon_fb_registered(struct fb_info *info)
 	return ret;
 }
 
-static void fbcon_fb_blanked(struct fb_info *info, int blank)
+void fbcon_fb_blanked(struct fb_info *info, int blank)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct vc_data *vc;
@@ -3344,9 +3335,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 		con2fb = event->data;
 		con2fb->framebuffer = con2fb_map[con2fb->console - 1];
 		break;
-	case FB_EVENT_BLANK:
-		fbcon_fb_blanked(info, *(int *)event->data);
-		break;
 	case FB_EVENT_REMAP_ALL_CONSOLE:
 		idx = info->node;
 		fbcon_remap_all(idx);
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index ddc0c16b8bbf..9366fbe99a58 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1068,6 +1068,7 @@ fb_blank(struct fb_info *info, int blank)
 	event.data = &blank;
 
 	early_ret = fb_notifier_call_chain(FB_EARLY_EVENT_BLANK, &event);
+	fbcon_fb_blanked(info, blank);
 
 	if (info->fbops->fb_blank)
  		ret = info->fbops->fb_blank(blank, info);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 0d86aa31bf8d..1e66fac3124f 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -137,12 +137,10 @@ struct fb_cursor_user {
 #define FB_EVENT_GET_CONSOLE_MAP        0x07
 /*      CONSOLE-SPECIFIC: set console to framebuffer mapping */
 #define FB_EVENT_SET_CONSOLE_MAP        0x08
-/*      A hardware display blank change occurred */
+/*      A display blank is requested       */
 #define FB_EVENT_BLANK                  0x09
 /*      Private modelist is to be replaced */
 #define FB_EVENT_MODE_CHANGE_ALL	0x0B
-/*	A software display blank change occurred */
-#define FB_EVENT_CONBLANK               0x0C
 /*      CONSOLE-SPECIFIC: remap all consoles to new fb - for vga_switcheroo */
 #define FB_EVENT_REMAP_ALL_CONSOLE      0x0F
 /*      A hardware display blank early change occurred */
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index 305e4f2eddac..d67d7ec51ef9 100644
--- a/include/linux/fbcon.h
+++ b/include/linux/fbcon.h
@@ -14,6 +14,7 @@ int fbcon_mode_deleted(struct fb_info *info,
 void fbcon_new_modelist(struct fb_info *info);
 void fbcon_get_requirement(struct fb_info *info,
 			   struct fb_blit_caps *caps);
+void fbcon_fb_blanked(struct fb_info *info, int blank);
 #else
 static inline void fb_console_init(void) {}
 static inline void fb_console_exit(void) {}
@@ -27,6 +28,7 @@ static inline int fbcon_mode_deleted(struct fb_info *info,
 static inline void fbcon_new_modelist(struct fb_info *info) {}
 static inline void fbcon_get_requirement(struct fb_info *info,
 					 struct fb_blit_caps *caps) {}
+static inline void fbcon_fb_blanked(struct fb_info *info, int blank) {}
 #endif
 
 #endif /* _LINUX_FBCON_H */
-- 
2.20.1

