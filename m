Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F71C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48AB2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JZT2OpHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389994AbfEXIyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:54:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36611 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389959AbfEXIyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:17 -0400
Received: by mail-ed1-f66.google.com with SMTP id a8so13341880edx.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+cL/G922tjqLUy3OnPZHGaEL6nVPepLcMmjKMw3G5so=;
        b=JZT2OpHl0QEUgO1EaibylbNdOSOIeZZtxhwpehuGoFADLOZq4qIkac0KdTcohlMuF3
         7oB/97TbAirePrEghXuDTAvweQ7MVa/TpB7jIZMuNmzy73z01kbttW/CaB83btkGgHqy
         P+1Af6OAw0m2POUOquCBaYvdvl7osuY8GOVBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+cL/G922tjqLUy3OnPZHGaEL6nVPepLcMmjKMw3G5so=;
        b=M9lU+S2sNyH6aSKrTV9MitgBAwZKcebQEwicLUx7VrprYzI9BGVO1Cw8YjfjKSW/mi
         X7tzJiq2CyGOfp2SbggIFGLeTFPfYMlUYzKeFkyNDp1qCPa/LSMLPR6VRIUizEwDibnw
         vk1L1DWMsB17sUD2hSbn2r041LOqafD0sNnUlns4emCFGj2Oljc00MpSYmTuEvP6okd3
         94T6Lw2VNAcnJ5EFbwy9oTddJ6KT6AwaDGoHgLMatt1i0nf9kbque4/hzmr3EXWnq1mT
         pVeBDrb1kFyJyccXxvpYTXyH+35yaQjRh+hZ3NdHfQ5Q14TQ/HkhJJzSW5LFPryOUypj
         qsGA==
X-Gm-Message-State: APjAAAWo1vu9dn8NVFrHcPanUecxubAhVzf0jvw/+uhk793eMtDKubyz
        zyzgJyE6xWkvTZk2If+n6edpdircZng=
X-Google-Smtp-Source: APXvYqzWMVo16zANfF7J3Oq6FD4P89i0hnoRbqiXay9P2lHgI4lAnWEJ7CWMtsUXoMHP+uuCrVraLA==
X-Received: by 2002:a17:907:20cd:: with SMTP id qq13mr55867451ejb.170.1558688055721;
        Fri, 24 May 2019 01:54:15 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:14 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Yisheng Xie <ysxie@foxmail.com>, Peter Rosin <peda@axentia.se>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-fbdev@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Steve Sakoman <sakoman@gmail.com>,
        Steve Sakoman <steve@sakoman.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/33] fbcon: call fbcon_fb_(un)registered directly
Date:   Fri, 24 May 2019 10:53:31 +0200
Message-Id: <20190524085354.27411-11-daniel.vetter@ffwll.ch>
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

With

commit 6104c37094e729f3d4ce65797002112735d49cd1
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue Aug 1 17:32:07 2017 +0200

    fbcon: Make fbcon a built-time depency for fbdev

we have a static dependency between fbcon and fbdev, and we can
replace the indirection through the notifier chain with a function
call.

v2: Sam Ravnborg noticed that mach-pxa/am200epd.c has a notifier too,
and listens to this.

...

Looking at the code it seems to wait for some fb to show up, so that
it can get the framebuffer base address from the fb_info struct. I
suspect his is some firmware fbdev. Then it uses that information to
let the real fbdev driver (metronomefb.c by the looks) get at the
framebuffer memory.

This doesn't looke like it's easy to fix (except by deleting the
entire thing, seems untouched since 2008, we might be able to get away
with that), so let's just stuff a few #ifdef into fb.h and fbmem.c and
cry over them for a bit.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Noralf Trønnes" <noralf@tronnes.org>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: Peter Rosin <peda@axentia.se>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-fbdev@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Steve Sakoman <sakoman@gmail.com>
Cc: Steve Sakoman <steve@sakoman.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/mach-pxa/am200epd.c     | 13 +++++++++++--
 drivers/video/fbdev/core/fbcon.c | 14 +++-----------
 drivers/video/fbdev/core/fbmem.c | 24 +++++++++++++++++-------
 include/linux/fb.h               |  7 +++++--
 include/linux/fbcon.h            |  4 ++++
 5 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-pxa/am200epd.c b/arch/arm/mach-pxa/am200epd.c
index 50e18ed37fa6..cac0bb09db14 100644
--- a/arch/arm/mach-pxa/am200epd.c
+++ b/arch/arm/mach-pxa/am200epd.c
@@ -347,8 +347,17 @@ int __init am200_init(void)
 {
 	int ret;
 
-	/* before anything else, we request notification for any fb
-	 * creation events */
+	/*
+	 * Before anything else, we request notification for any fb
+	 * creation events.
+	 *
+	 * FIXME: This is terrible and needs to be nuked. The notifier is used
+	 * to get at the fb base address from the boot splash fb driver, which
+	 * is then passed to metronomefb. Instaed of metronomfb or this board
+	 * support file here figuring this out on their own.
+	 *
+	 * See also the #ifdef in fbmem.c.
+	 */
 	fb_register_client(&am200_fb_notif);
 
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(am200_pin_config));
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 622d336cfc81..54d01f7284cb 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3119,14 +3119,14 @@ static int fbcon_fb_unbind(int idx)
 }
 
 /* called with console_lock held */
-static int fbcon_fb_unregistered(struct fb_info *info)
+void fbcon_fb_unregistered(struct fb_info *info)
 {
 	int i, idx;
 
 	WARN_CONSOLE_UNLOCKED();
 
 	if (deferred_takeover)
-		return 0;
+		return;
 
 	idx = info->node;
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
@@ -3155,8 +3155,6 @@ static int fbcon_fb_unregistered(struct fb_info *info)
 
 	if (!num_registered_fb)
 		do_unregister_con_driver(&fb_con);
-
-	return 0;
 }
 
 /* called with console_lock held */
@@ -3215,7 +3213,7 @@ static inline void fbcon_select_primary(struct fb_info *info)
 #endif /* CONFIG_FRAMEBUFFER_DETECT_PRIMARY */
 
 /* called with console_lock held */
-static int fbcon_fb_registered(struct fb_info *info)
+int fbcon_fb_registered(struct fb_info *info)
 {
 	int ret = 0, i, idx;
 
@@ -3359,12 +3357,6 @@ static int fbcon_event_notify(struct notifier_block *self,
 		idx = info->node;
 		ret = fbcon_fb_unbind(idx);
 		break;
-	case FB_EVENT_FB_REGISTERED:
-		ret = fbcon_fb_registered(info);
-		break;
-	case FB_EVENT_FB_UNREGISTERED:
-		ret = fbcon_fb_unregistered(info);
-		break;
 	case FB_EVENT_SET_CONSOLE_MAP:
 		/* called with console lock held */
 		con2fb = event->data;
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 8ba674ffb3c9..bed7698ad18a 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1660,7 +1660,6 @@ MODULE_PARM_DESC(lockless_register_fb,
 static int do_register_framebuffer(struct fb_info *fb_info)
 {
 	int i, ret;
-	struct fb_event event;
 	struct fb_videomode mode;
 
 	if (fb_check_foreignness(fb_info))
@@ -1723,7 +1722,14 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	fb_add_videomode(&mode, &fb_info->modelist);
 	registered_fb[i] = fb_info;
 
-	event.info = fb_info;
+#ifdef CONFIG_GUMSTIX_AM200EPD
+	{
+		struct fb_event event;
+		event.info = fb_info;
+		fb_notifier_call_chain(FB_EVENT_FB_REGISTERED, &event);
+	}
+#endif
+
 	if (!lockless_register_fb)
 		console_lock();
 	else
@@ -1732,9 +1738,8 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 		ret = -ENODEV;
 		goto unlock_console;
 	}
-	ret = 0;
 
-	fb_notifier_call_chain(FB_EVENT_FB_REGISTERED, &event);
+	ret = fbcon_fb_registered(fb_info);
 	unlock_fb_info(fb_info);
 unlock_console:
 	if (!lockless_register_fb)
@@ -1771,7 +1776,6 @@ static int __unlink_framebuffer(struct fb_info *fb_info);
 
 static int do_unregister_framebuffer(struct fb_info *fb_info)
 {
-	struct fb_event event;
 	int ret;
 
 	ret = unbind_console(fb_info);
@@ -1789,9 +1793,15 @@ static int do_unregister_framebuffer(struct fb_info *fb_info)
 	registered_fb[fb_info->node] = NULL;
 	num_registered_fb--;
 	fb_cleanup_device(fb_info);
-	event.info = fb_info;
+#ifdef CONFIG_GUMSTIX_AM200EPD
+	{
+		struct fb_event event;
+		event.info = fb_info;
+		fb_notifier_call_chain(FB_EVENT_FB_UNREGISTERED, &event);
+	}
+#endif
 	console_lock();
-	fb_notifier_call_chain(FB_EVENT_FB_UNREGISTERED, &event);
+	fbcon_fb_unregistered(fb_info);
 	console_unlock();
 
 	/* this may free fb info */
diff --git a/include/linux/fb.h b/include/linux/fb.h
index f52ef0ad6781..288175fafaf6 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -136,10 +136,13 @@ struct fb_cursor_user {
 #define FB_EVENT_RESUME			0x03
 /*      An entry from the modelist was removed */
 #define FB_EVENT_MODE_DELETE            0x04
-/*      A driver registered itself */
+
+#ifdef CONFIG_GUMSTIX_AM200EPD
+/* only used by mach-pxa/am200epd.c */
 #define FB_EVENT_FB_REGISTERED          0x05
-/*      A driver unregistered itself */
 #define FB_EVENT_FB_UNREGISTERED        0x06
+#endif
+
 /*      CONSOLE-SPECIFIC: get console to framebuffer mapping */
 #define FB_EVENT_GET_CONSOLE_MAP        0x07
 /*      CONSOLE-SPECIFIC: set console to framebuffer mapping */
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index f68a7db14165..94a71e9e1257 100644
--- a/include/linux/fbcon.h
+++ b/include/linux/fbcon.h
@@ -4,9 +4,13 @@
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE
 void __init fb_console_init(void);
 void __exit fb_console_exit(void);
+int fbcon_fb_registered(struct fb_info *info);
+void fbcon_fb_unregistered(struct fb_info *info);
 #else
 static inline void fb_console_init(void) {}
 static inline void fb_console_exit(void) {}
+static inline int fbcon_fb_registered(struct fb_info *info) { return 0; }
+static inline void fbcon_fb_unregistered(struct fb_info *info) {}
 #endif
 
 #endif /* _LINUX_FBCON_H */
-- 
2.20.1

