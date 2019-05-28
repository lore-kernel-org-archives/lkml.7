Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607D2C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22AE4216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="P1BhmTk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfE1JEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:04:11 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40517 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfE1JD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id s19so2500931edq.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xl+FmsN1b/Z0dRTg7/MTehgEAqXNH21CIN1ZETZQ/L8=;
        b=P1BhmTk1hbE5r2B+QiA3mLyctcrzMOPiA0FF2afph9QwuSqbe+7Vg34nWxGic2cpIp
         Dr+njroxLWdPZ8tRtVTzw7pvAOF3qky5AKxB+uMoKHv18H6B828Ycb17qHIsW/Sdilgp
         hFjFysr93tlnN9Xyxj9PNyqSg4WYWz899PxWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xl+FmsN1b/Z0dRTg7/MTehgEAqXNH21CIN1ZETZQ/L8=;
        b=hsKks9rHe/cau+dQ9QzQuguEvrO1k5aRoGC+XTgZ8qKKM6+8SniOVGj0XCH5lejRab
         xouJQC1NfKFergLgML28CKIDnVEH5Xzg8GfR9JCFvvnE47H9IfCFiNXsycrRfDB8q5/o
         9XtkSvx0I6Ut10hosyPJOE/sYZtKyxEeZmGDE9NdjXgRZ0YYWctBU61LZZOxM2YVCivL
         XEsPSak+ZqjeREE4SrznyhSG1i5a31uoFBrOJU965euzmEVeSLwYCjFuHnKumZX8y6IS
         57YUQBh01ObpBGzPbmrx2yqNlrLc43SkjgQkLLAzbo92YBeaPKcZ2Il0llqDicAyKL4u
         S5fQ==
X-Gm-Message-State: APjAAAVrHrwlx4nen2u19XYstS1i2hHHzgCIV2RiMwkZmV50hsR88pcB
        KXM8dewfzWZ0zYlAtgqIg15U28X6iMc=
X-Google-Smtp-Source: APXvYqzRA7UP0UMRngIGDlfV8DR7R4CLDWGwCYwpTvM3Dr/srd+AZ3tufkvaM/d//bxX/fxuu4blxg==
X-Received: by 2002:a50:fa4a:: with SMTP id c10mr3181724edq.35.1559034234601;
        Tue, 28 May 2019 02:03:54 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:53 -0700 (PDT)
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
        Yisheng Xie <ysxie@foxmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Peter Rosin <peda@axentia.se>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 30/33] fbcon: Call con2fb_map functions directly
Date:   Tue, 28 May 2019 11:03:01 +0200
Message-Id: <20190528090304.9388-31-daniel.vetter@ffwll.ch>
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

These are actually fbcon ioctls which just happen to be exposed
through /dev/fb*. They completely ignore which fb_info they're called
on, and I think the userspace tool even hardcodes to /dev/fb0.

Hence just forward the entire thing to fbcon.c wholesale.

Note that this patch drops the fb_lock/unlock on the set side. Since
the ioctl can operate on any fb (as passed in through
con2fb.framebuffer) this is bogus. Also note that fbcon.c in general
never calls fb_lock on anything, so this has been badly broken
already.

With this the last user of the fbcon notifier callback is gone, and we
can garbage collect that too.

v2: add missing uaccess.h include (alpha fails to compile otherwise),
reported by kbuild.

v3: Remember to also drop the #defines (Maarten)

v4: Add the static inline to dummy functions.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Peter Rosin <peda@axentia.se>
Cc: Mikulas Patocka <mpatocka@redhat.com>
---
 drivers/video/fbdev/core/fbcon.c | 59 +++++++++++++++++++-------------
 drivers/video/fbdev/core/fbmem.c | 34 ++----------------
 include/linux/fb.h               |  4 ---
 include/linux/fbcon.h            |  4 +++
 4 files changed, 42 insertions(+), 59 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 158b9d5233e1..fbd28aeff307 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -76,6 +76,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/crc32.h> /* For counting font checksums */
+#include <linux/uaccess.h>
 #include <asm/fb.h>
 #include <asm/irq.h>
 
@@ -3318,29 +3319,47 @@ void fbcon_get_requirement(struct fb_info *info,
 	}
 }
 
-static int fbcon_event_notify(struct notifier_block *self,
-			      unsigned long action, void *data)
+int fbcon_set_con2fb_map_ioctl(void __user *argp)
 {
-	struct fb_event *event = data;
-	struct fb_info *info = event->info;
-	struct fb_con2fbmap *con2fb;
-	int idx, ret = 0;
+	struct fb_con2fbmap con2fb;
+	int ret;
 
-	switch(action) {
-	case FB_EVENT_SET_CONSOLE_MAP:
-		/* called with console lock held */
-		con2fb = event->data;
-		ret = set_con2fb_map(con2fb->console - 1,
-				     con2fb->framebuffer, 1);
-		break;
-	case FB_EVENT_GET_CONSOLE_MAP:
-		con2fb = event->data;
-		con2fb->framebuffer = con2fb_map[con2fb->console - 1];
-		break;
+	if (copy_from_user(&con2fb, argp, sizeof(con2fb)))
+		return -EFAULT;
+	if (con2fb.console < 1 || con2fb.console > MAX_NR_CONSOLES)
+		return -EINVAL;
+	if (con2fb.framebuffer >= FB_MAX)
+		return -EINVAL;
+	if (!registered_fb[con2fb.framebuffer])
+		request_module("fb%d", con2fb.framebuffer);
+	if (!registered_fb[con2fb.framebuffer]) {
+		return -EINVAL;
 	}
+
+	console_lock();
+	ret = set_con2fb_map(con2fb.console - 1,
+			     con2fb.framebuffer, 1);
+	console_unlock();
+
 	return ret;
 }
 
+int fbcon_get_con2fb_map_ioctl(void __user *argp)
+{
+	struct fb_con2fbmap con2fb;
+
+	if (copy_from_user(&con2fb, argp, sizeof(con2fb)))
+		return -EFAULT;
+	if (con2fb.console < 1 || con2fb.console > MAX_NR_CONSOLES)
+		return -EINVAL;
+
+	console_lock();
+	con2fb.framebuffer = con2fb_map[con2fb.console - 1];
+	console_unlock();
+
+	return copy_to_user(argp, &con2fb, sizeof(con2fb)) ? -EFAULT : 0;
+}
+
 /*
  *  The console `switch' structure for the frame buffer based console
  */
@@ -3372,10 +3391,6 @@ static const struct consw fb_con = {
 	.con_debug_leave	= fbcon_debug_leave,
 };
 
-static struct notifier_block fbcon_event_notifier = {
-	.notifier_call	= fbcon_event_notify,
-};
-
 static ssize_t store_rotate(struct device *device,
 			    struct device_attribute *attr, const char *buf,
 			    size_t count)
@@ -3648,7 +3663,6 @@ void __init fb_console_init(void)
 	int i;
 
 	console_lock();
-	fb_register_client(&fbcon_event_notifier);
 	fbcon_device = device_create(fb_class, NULL, MKDEV(0, 0), NULL,
 				     "fbcon");
 
@@ -3684,7 +3698,6 @@ static void __exit fbcon_deinit_device(void)
 void __exit fb_console_exit(void)
 {
 	console_lock();
-	fb_unregister_client(&fbcon_event_notifier);
 	fbcon_deinit_device();
 	device_destroy(fb_class, MKDEV(0, 0));
 	fbcon_exit();
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index dd1a708df1a7..64dd732021d8 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1092,10 +1092,8 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	struct fb_ops *fb;
 	struct fb_var_screeninfo var;
 	struct fb_fix_screeninfo fix;
-	struct fb_con2fbmap con2fb;
 	struct fb_cmap cmap_from;
 	struct fb_cmap_user cmap;
-	struct fb_event event;
 	void __user *argp = (void __user *)arg;
 	long ret = 0;
 
@@ -1157,38 +1155,10 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		ret = -EINVAL;
 		break;
 	case FBIOGET_CON2FBMAP:
-		if (copy_from_user(&con2fb, argp, sizeof(con2fb)))
-			return -EFAULT;
-		if (con2fb.console < 1 || con2fb.console > MAX_NR_CONSOLES)
-			return -EINVAL;
-		con2fb.framebuffer = -1;
-		event.data = &con2fb;
-		lock_fb_info(info);
-		event.info = info;
-		fb_notifier_call_chain(FB_EVENT_GET_CONSOLE_MAP, &event);
-		unlock_fb_info(info);
-		ret = copy_to_user(argp, &con2fb, sizeof(con2fb)) ? -EFAULT : 0;
+		ret = fbcon_get_con2fb_map_ioctl(argp);
 		break;
 	case FBIOPUT_CON2FBMAP:
-		if (copy_from_user(&con2fb, argp, sizeof(con2fb)))
-			return -EFAULT;
-		if (con2fb.console < 1 || con2fb.console > MAX_NR_CONSOLES)
-			return -EINVAL;
-		if (con2fb.framebuffer >= FB_MAX)
-			return -EINVAL;
-		if (!registered_fb[con2fb.framebuffer])
-			request_module("fb%d", con2fb.framebuffer);
-		if (!registered_fb[con2fb.framebuffer]) {
-			ret = -EINVAL;
-			break;
-		}
-		event.data = &con2fb;
-		console_lock();
-		lock_fb_info(info);
-		event.info = info;
-		ret = fb_notifier_call_chain(FB_EVENT_SET_CONSOLE_MAP, &event);
-		unlock_fb_info(info);
-		console_unlock();
+		ret = fbcon_set_con2fb_map_ioctl(argp);
 		break;
 	case FBIOBLANK:
 		console_lock();
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 25e4b885f5b3..303771264644 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -133,10 +133,6 @@ struct fb_cursor_user {
 #define FB_EVENT_FB_UNREGISTERED        0x06
 #endif
 
-/*      CONSOLE-SPECIFIC: get console to framebuffer mapping */
-#define FB_EVENT_GET_CONSOLE_MAP        0x07
-/*      CONSOLE-SPECIFIC: set console to framebuffer mapping */
-#define FB_EVENT_SET_CONSOLE_MAP        0x08
 /*      A display blank is requested       */
 #define FB_EVENT_BLANK                  0x09
 /*      A hardware display blank early change occurred */
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index 69f900d289b2..ff5596dd30f8 100644
--- a/include/linux/fbcon.h
+++ b/include/linux/fbcon.h
@@ -17,6 +17,8 @@ void fbcon_get_requirement(struct fb_info *info,
 void fbcon_fb_blanked(struct fb_info *info, int blank);
 void fbcon_update_vcs(struct fb_info *info, bool all);
 void fbcon_remap_all(struct fb_info *info);
+int fbcon_set_con2fb_map_ioctl(void __user *argp);
+int fbcon_get_con2fb_map_ioctl(void __user *argp);
 #else
 static inline void fb_console_init(void) {}
 static inline void fb_console_exit(void) {}
@@ -33,6 +35,8 @@ static inline void fbcon_get_requirement(struct fb_info *info,
 static inline void fbcon_fb_blanked(struct fb_info *info, int blank) {}
 static inline void fbcon_update_vcs(struct fb_info *info, bool all) {}
 static inline void fbcon_remap_all(struct fb_info *info) {}
+static inline int fbcon_set_con2fb_map_ioctl(void __user *argp) { return 0; }
+static inline int fbcon_get_con2fb_map_ioctl(void __user *argp) { return 0; }
 #endif
 
 #endif /* _LINUX_FBCON_H */
-- 
2.20.1

