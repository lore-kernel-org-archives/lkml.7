Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB282C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2E4208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PHQiuhYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfE1JGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:06:17 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36002 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfE1JDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id a8so30639605edx.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yaKcaql0G9W2FF9dohChSRJyBaT7k6PGxaYxbUWhNMM=;
        b=PHQiuhYmhLNnw56rd+9LC8Si1kQHN0WBjahUHUsDHHhN83rtOqqfjnBoWC0MuN6RLD
         B7WAsmRxU2r/bqlBdO+TAka9/Uotec/8FhnJNPmO9th/YkxzJqWIfMSoYbpVV0KChcvi
         uSCOUKeob0QuWCAcgtyoQhIjJpp+n21uT0MqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yaKcaql0G9W2FF9dohChSRJyBaT7k6PGxaYxbUWhNMM=;
        b=PHAz/xmWZ4EuxmLvSoxsSwf7GIlzRGQEvZvmcGm6+/xe/CObaindMDtwGZCHXBLRzV
         upytXI1HkTee8ksQv9pWi2iV139qtvhDk2wkw2IKNtRQKc46rmTaQHnULWPiLW3YWoM1
         0ZQqhUiBadYodDH7/pmLfA5uFSW6oz3gtUN/l6GDyi0APjmbBVBmqbKicfC+7EyvFgS4
         b3OaTDTCn/AFQZiq+MdpDKcoRYHCbgKq+2gs7+8BR6CUwkL0SLuyuOlW9KiIAZMAafeq
         +18kJlmnxR/7ukRxER2MuKffwvLdByrdiwuJ4SIdopoBucDfCoWc6ytldbn2H2nS98Rh
         1tsg==
X-Gm-Message-State: APjAAAXzO2szPNJukaVASBBTRQlwNWYwvq503vizmU+n9mnwtDhCSa+m
        qRQi0kO6n6RF4tQ9AF4+poruoksxWN0=
X-Google-Smtp-Source: APXvYqzKotm/46uPM24q5yoliICqC9zZiV7ou5KJH+PAaBUjF08Z+9r3Z4qj1R3JTovsspWncdiMbw==
X-Received: by 2002:a17:906:24d8:: with SMTP id f24mr8157454ejb.1.1559034216475;
        Tue, 28 May 2019 02:03:36 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:35 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Yisheng Xie <ysxie@foxmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 17/33] fbcon: call fbcon_fb_bind directly
Date:   Tue, 28 May 2019 11:02:48 +0200
Message-Id: <20190528090304.9388-18-daniel.vetter@ffwll.ch>
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

Also remove the error return value. That's all errors for either
driver bugs (trying to unbind something that isn't bound), or errors
of the new driver that will take over.

There's nothing the outgoing driver can do about this anyway, so
switch over to void.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Peter Rosin <peda@axentia.se>
Cc: Kees Cook <keescook@chromium.org>
Cc: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/core/fbcon.c | 24 +++++++-----------------
 drivers/video/fbdev/core/fbmem.c |  7 ++-----
 include/linux/fb.h               |  2 --
 include/linux/fbcon.h            |  2 ++
 4 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index a7e2d5b88914..142686953b71 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3046,7 +3046,7 @@ static int fbcon_mode_deleted(struct fb_info *info,
 }
 
 #ifdef CONFIG_VT_HW_CONSOLE_BINDING
-static int fbcon_unbind(void)
+static void fbcon_unbind(void)
 {
 	int ret;
 
@@ -3055,25 +3055,21 @@ static int fbcon_unbind(void)
 
 	if (!ret)
 		fbcon_has_console_bind = 0;
-
-	return ret;
 }
 #else
-static inline int fbcon_unbind(void)
-{
-	return -EINVAL;
-}
+static inline void fbcon_unbind(void) {}
 #endif /* CONFIG_VT_HW_CONSOLE_BINDING */
 
 /* called with console_lock held */
-static int fbcon_fb_unbind(int idx)
+void fbcon_fb_unbind(struct fb_info *info)
 {
 	int i, new_idx = -1, ret = 0;
+	int idx = info->node;
 
 	WARN_CONSOLE_UNLOCKED();
 
 	if (!fbcon_has_console_bind)
-		return 0;
+		return;
 
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
 		if (con2fb_map[i] != idx &&
@@ -3106,15 +3102,13 @@ static int fbcon_fb_unbind(int idx)
 								     idx, 0);
 					if (ret) {
 						con2fb_map[i] = idx;
-						return ret;
+						return;
 					}
 				}
 			}
 		}
-		ret = fbcon_unbind();
+		fbcon_unbind();
 	}
-
-	return ret;
 }
 
 /* called with console_lock held */
@@ -3352,10 +3346,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 		mode = event->data;
 		ret = fbcon_mode_deleted(info, mode);
 		break;
-	case FB_EVENT_FB_UNBIND:
-		idx = info->node;
-		ret = fbcon_fb_unbind(idx);
-		break;
 	case FB_EVENT_SET_CONSOLE_MAP:
 		/* called with console lock held */
 		con2fb = event->data;
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index d73762324ca2..f3fc2e5b193c 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1716,8 +1716,6 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 
 static int unbind_console(struct fb_info *fb_info)
 {
-	struct fb_event event;
-	int ret;
 	int i = fb_info->node;
 
 	if (i < 0 || i >= FB_MAX || registered_fb[i] != fb_info)
@@ -1725,12 +1723,11 @@ static int unbind_console(struct fb_info *fb_info)
 
 	console_lock();
 	lock_fb_info(fb_info);
-	event.info = fb_info;
-	ret = fb_notifier_call_chain(FB_EVENT_FB_UNBIND, &event);
+	fbcon_fb_unbind(fb_info);
 	unlock_fb_info(fb_info);
 	console_unlock();
 
-	return ret;
+	return 0;
 }
 
 static int __unlink_framebuffer(struct fb_info *fb_info);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index aa8f18163151..b6ce041d9e13 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -158,8 +158,6 @@ struct fb_cursor_user {
 #define FB_EVENT_CONBLANK               0x0C
 /*      Get drawing requirements        */
 #define FB_EVENT_GET_REQ                0x0D
-/*      Unbind from the console if possible */
-#define FB_EVENT_FB_UNBIND              0x0E
 /*      CONSOLE-SPECIFIC: remap all consoles to new fb - for vga_switcheroo */
 #define FB_EVENT_REMAP_ALL_CONSOLE      0x0F
 /*      A hardware display blank early change occurred */
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index 94a71e9e1257..38d44fdb6d14 100644
--- a/include/linux/fbcon.h
+++ b/include/linux/fbcon.h
@@ -6,11 +6,13 @@ void __init fb_console_init(void);
 void __exit fb_console_exit(void);
 int fbcon_fb_registered(struct fb_info *info);
 void fbcon_fb_unregistered(struct fb_info *info);
+void fbcon_fb_unbind(struct fb_info *info);
 #else
 static inline void fb_console_init(void) {}
 static inline void fb_console_exit(void) {}
 static inline int fbcon_fb_registered(struct fb_info *info) { return 0; }
 static inline void fbcon_fb_unregistered(struct fb_info *info) {}
+static inline void fbcon_fb_unbind(struct fb_info *info) {}
 #endif
 
 #endif /* _LINUX_FBCON_H */
-- 
2.20.1

