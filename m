Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BC7C072A4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306062081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ahxUG18a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfETIXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:23:05 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34415 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730557AbfETIXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:23:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id p27so22587158eda.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ptn+ekZzhb2EANVyrbPFjMvHGMqs35lbdt+VKTwDqHU=;
        b=ahxUG18a6ZrhED+Kaap9n2LcPyJx/AVZ4FHMt8VfvV2aG/SlIV8p+P2fUMBKVQPAt6
         oAJO0NT5IA5U/6kfhdEA4Ck5KPKx4KORWio+KC4U0mdQgVB2ryemPWk3YkvY8IiIJHrp
         Rl/Cab3rac+aqYK0cBsjGoQjpzxyYqhAcGDtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ptn+ekZzhb2EANVyrbPFjMvHGMqs35lbdt+VKTwDqHU=;
        b=iZK6g4CYyEq4qQ6PdXjie10AUtZiVHL7ybXFrD7u+USBWrOw/9+pr39z+Axoef1RaK
         rUkD9RbqPSZpZVaaiTdb3VwyPnC0crjbyJZmVWQlZhpwC4DJel/redYNowDHiqZkFO5L
         nMfisa0HIZhp77mJQhSFQvTZk6Eac+EnZ4vKziXzcbjV6OZRkmIRWlRpezjsaTu9c13c
         bV9Irv8gXRB8/mZRPpe/ekLsW8p+QfFdZmPv3Yuod0QgMQWb7dJl9EqVn6mqYMa4OtQi
         d/7Fc8SCaDddh9XttbpXcrVHy1x2Hpto6/5LGS7x3pcpcg6GSt7gJUoB6/v7nL5EZwUP
         F8Og==
X-Gm-Message-State: APjAAAVAeqLm3HzHF6ChTdDpuzHWnbedyDIc1/aBL7ykuK1zgfuu1UFn
        1EXXNyY7WNcdcrwLApbCZ98LhA==
X-Google-Smtp-Source: APXvYqy/d9Gji8lKFzbGJm5BP4wSEEkaVtLPzo0DeLjLhV0ZqszW1BghTiJqiFZNWq0aUSbu8mZtrg==
X-Received: by 2002:a17:906:5586:: with SMTP id y6mr16134301ejp.120.1558340578591;
        Mon, 20 May 2019 01:22:58 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:57 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Yisheng Xie <ysxie@foxmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Peter Rosin <peda@axentia.se>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 31/33] fbcon: Call con2fb_map functions directly
Date:   Mon, 20 May 2019 10:22:14 +0200
Message-Id: <20190520082216.26273-32-daniel.vetter@ffwll.ch>
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

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Peter Rosin <peda@axentia.se>
Cc: Mikulas Patocka <mpatocka@redhat.com>
---
 drivers/video/fbdev/core/fbcon.c | 62 +++++++++++++++++++-------------
 drivers/video/fbdev/core/fbmem.c | 34 ++----------------
 include/linux/fbcon.h            |  4 +++
 3 files changed, 43 insertions(+), 57 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index fd604ffb3c05..b40b56702c61 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -3315,29 +3315,47 @@ void fbcon_get_requirement(struct fb_info *info,
 	}
 }
 
-static int fbcon_event_notify(struct notifier_block *self,
-			      unsigned long action, void *data)
-{
-	struct fb_event *event = data;
-	struct fb_info *info = event->info;
-	struct fb_con2fbmap *con2fb;
-	int idx, ret = 0;
-
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
+int fbcon_set_con2fb_map_ioctl(void __user *argp)
+{
+	struct fb_con2fbmap con2fb;
+	int ret;
+
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
@@ -3369,10 +3387,6 @@ static const struct consw fb_con = {
 	.con_debug_leave	= fbcon_debug_leave,
 };
 
-static struct notifier_block fbcon_event_notifier = {
-	.notifier_call	= fbcon_event_notify,
-};
-
 static ssize_t store_rotate(struct device *device,
 			    struct device_attribute *attr, const char *buf,
 			    size_t count)
@@ -3645,7 +3659,6 @@ void __init fb_console_init(void)
 	int i;
 
 	console_lock();
-	fb_register_client(&fbcon_event_notifier);
 	fbcon_device = device_create(fb_class, NULL, MKDEV(0, 0), NULL,
 				     "fbcon");
 
@@ -3681,7 +3694,6 @@ static void __exit fbcon_deinit_device(void)
 void __exit fb_console_exit(void)
 {
 	console_lock();
-	fb_unregister_client(&fbcon_event_notifier);
 	fbcon_deinit_device();
 	device_destroy(fb_class, MKDEV(0, 0));
 	fbcon_exit();
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 55b88163edc2..c5cf02e68e25 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1084,10 +1084,8 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	struct fb_ops *fb;
 	struct fb_var_screeninfo var;
 	struct fb_fix_screeninfo fix;
-	struct fb_con2fbmap con2fb;
 	struct fb_cmap cmap_from;
 	struct fb_cmap_user cmap;
-	struct fb_event event;
 	void __user *argp = (void __user *)arg;
 	long ret = 0;
 
@@ -1149,38 +1147,10 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
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
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index 3f854e803746..8dfd1aa40483 100644
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
@@ -33,6 +35,8 @@ void fbcon_get_requirement(struct fb_info *info,
 void fbcon_fb_blanked(struct fb_info *info, int blank) {}
 void fbcon_update_vcs(struct fb_info *info, bool all) {}
 void fbcon_remap_all(struct fb_info *info) {}
+int fbcon_set_con2fb_map_ioctl(void __user *argp) { return 0; }
+int fbcon_get_con2fb_map_ioctl(void __user *argp) { return 0; }
 #endif
 
 #endif /* _LINUX_FBCON_H */
-- 
2.20.1

