Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09870C04E84
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7C920B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="D/Qm2B4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfE1JDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:03:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41402 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfE1JDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id m4so30616768edd.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qp8gYAWJCiDOhrz1RfuOYXHHnFuqBtMXvmbENgYp7nA=;
        b=D/Qm2B4Nwv9VOkhXwW2zqWA9R6pO/8mljnKNDoMbQqwe10J4DIpCovISBE10ZfmIiz
         DUfZs/QewB0L/nMLc+4gH29xMFxS8TlJqHQOMPNMiOtE5d5W6SGFISi4qVJuzIvKRILw
         UsMDYJ37BMOxsF4thN3vvqssEwWctti5fq1Os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qp8gYAWJCiDOhrz1RfuOYXHHnFuqBtMXvmbENgYp7nA=;
        b=qCHIEagAW9IDu0UR+jcfdqsOxeso9uZdJgxwXMgNXZprh4g4HCaKz+hBGIjKTVBVd1
         jAqfYsOmo8KS9ndunUWqHpoNdlSvHwKa3wAzEma5TlteZnC+1gckSAIywzEHE1lyZkkj
         eZp4oTGAYLi2zwwn/574gAkKNi2ErUFONre3hja2uagNbsMJ4dhAx7g4KchAnH30Bt7X
         DI3C5ew4FcpM116AHbgZDNucd4haOHMmVal0GFcfqzRcGgn8Z2MqC102fRjXz60RtSDu
         twLVL5UMmA7gY52ZfonB/YT2fkKH+dCM0WVSd5PfZkf8BAyZky9By7E9i06t4tuOX9+6
         waSQ==
X-Gm-Message-State: APjAAAVyuoIRfOWR9dj2G+RMvkrRbPzlBt5Ny2aF8KCiEcgWAhPpJ3Wp
        MAQzV5oUKdy7FZsYoR28KOWkfj6UDPc=
X-Google-Smtp-Source: APXvYqxWwkOmq1B5WlNL4LZsiFHjKy9tx1xdx2Sqd/9u6FMIp/LEyZi1VfAxiFE3W+jJaainnSnkzA==
X-Received: by 2002:a17:906:491b:: with SMTP id b27mr33967503ejq.234.1559034215068;
        Tue, 28 May 2019 02:03:35 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:34 -0700 (PDT)
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
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Peter Rosin <peda@axentia.se>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 16/33] fbdev: lock_fb_info cannot fail
Date:   Tue, 28 May 2019 11:02:47 +0200
Message-Id: <20190528090304.9388-17-daniel.vetter@ffwll.ch>
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

Ever since

commit c47747fde931c02455683bd00ea43eaa62f35b0e
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed May 11 14:58:34 2011 -0700

    fbmem: make read/write/ioctl use the frame buffer at open time

fbdev has gained proper refcounting for the fbinfo attached to any
open files, which means that the backing driver (stored in
fb_info->fbops) cannot untimely disappear anymore.

The only thing that can happen is that the entire device just outright
disappears and gets unregistered, but file_fb_info does check for
that. Except that it's racy - it only checks once at the start of a
file_ops, there's no guarantee that the underlying fbdev won't
untimely disappear. Aside: A proper way to fix that race is probably
to replicate the srcu trickery we've rolled out in drm.

But given that this race has existed since forever it's probably not
one we need to fix right away. do_unregister_framebuffer also nowhere
clears fb_info->fbops, hence the check in lock_fb_info can't possible
catch a disappearing fbdev later on.

Long story short: Ever since the above commit the fb_info->fbops
checks have essentially become dead code. Remove this all.

Aside from the file_ops callbacks, and stuff called from there
there's only register/unregister code left. If that goes wrong a driver
managed to register/unregister a device instance twice or in the wrong
order.  That's just a driver bug.

v2:
- fb_mmap had an open-coded version of the fbinfo->fops check, because
  it doesn't need the fbinfo->lock. Delete that too.
- Use the wrapper function in fb_open/release now, since no difference
  anymore.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: "Noralf Trønnes" <noralf@tronnes.org>
Cc: Peter Rosin <peda@axentia.se>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/core/fbcmap.c |  6 +--
 drivers/video/fbdev/core/fbcon.c  |  3 +-
 drivers/video/fbdev/core/fbmem.c  | 73 +++++++------------------------
 include/linux/fb.h                |  5 ++-
 4 files changed, 23 insertions(+), 64 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcmap.c b/drivers/video/fbdev/core/fbcmap.c
index 2811c4afde01..e5ae33c1a8e8 100644
--- a/drivers/video/fbdev/core/fbcmap.c
+++ b/drivers/video/fbdev/core/fbcmap.c
@@ -285,11 +285,7 @@ int fb_set_user_cmap(struct fb_cmap_user *cmap, struct fb_info *info)
 		goto out;
 	}
 	umap.start = cmap->start;
-	if (!lock_fb_info(info)) {
-		rc = -ENODEV;
-		goto out;
-	}
-
+	lock_fb_info(info);
 	rc = fb_set_cmap(&umap, info);
 	unlock_fb_info(info);
 out:
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 5a9fe0c0dd3c..a7e2d5b88914 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2364,8 +2364,7 @@ static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
 	}
 
 
-	if (!lock_fb_info(info))
-		return;
+	lock_fb_info(info);
 	event.info = info;
 	event.data = &blank;
 	fb_notifier_call_chain(FB_EVENT_CONBLANK, &event);
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index bed7698ad18a..d73762324ca2 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -80,17 +80,6 @@ static void put_fb_info(struct fb_info *fb_info)
 		fb_info->fbops->fb_destroy(fb_info);
 }
 
-int lock_fb_info(struct fb_info *info)
-{
-	mutex_lock(&info->lock);
-	if (!info->fbops) {
-		mutex_unlock(&info->lock);
-		return 0;
-	}
-	return 1;
-}
-EXPORT_SYMBOL(lock_fb_info);
-
 /*
  * Helpers
  */
@@ -1121,8 +1110,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 
 	switch (cmd) {
 	case FBIOGET_VSCREENINFO:
-		if (!lock_fb_info(info))
-			return -ENODEV;
+		lock_fb_info(info);
 		var = info->var;
 		unlock_fb_info(info);
 
@@ -1132,10 +1120,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		if (copy_from_user(&var, argp, sizeof(var)))
 			return -EFAULT;
 		console_lock();
-		if (!lock_fb_info(info)) {
-			console_unlock();
-			return -ENODEV;
-		}
+		lock_fb_info(info);
 		info->flags |= FBINFO_MISC_USEREVENT;
 		ret = fb_set_var(info, &var);
 		info->flags &= ~FBINFO_MISC_USEREVENT;
@@ -1145,8 +1130,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 			ret = -EFAULT;
 		break;
 	case FBIOGET_FSCREENINFO:
-		if (!lock_fb_info(info))
-			return -ENODEV;
+		lock_fb_info(info);
 		fix = info->fix;
 		if (info->flags & FBINFO_HIDE_SMEM_START)
 			fix.smem_start = 0;
@@ -1162,8 +1146,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	case FBIOGETCMAP:
 		if (copy_from_user(&cmap, argp, sizeof(cmap)))
 			return -EFAULT;
-		if (!lock_fb_info(info))
-			return -ENODEV;
+		lock_fb_info(info);
 		cmap_from = info->cmap;
 		unlock_fb_info(info);
 		ret = fb_cmap_to_user(&cmap_from, &cmap);
@@ -1172,10 +1155,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		if (copy_from_user(&var, argp, sizeof(var)))
 			return -EFAULT;
 		console_lock();
-		if (!lock_fb_info(info)) {
-			console_unlock();
-			return -ENODEV;
-		}
+		lock_fb_info(info);
 		ret = fb_pan_display(info, &var);
 		unlock_fb_info(info);
 		console_unlock();
@@ -1192,8 +1172,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 			return -EINVAL;
 		con2fb.framebuffer = -1;
 		event.data = &con2fb;
-		if (!lock_fb_info(info))
-			return -ENODEV;
+		lock_fb_info(info);
 		event.info = info;
 		fb_notifier_call_chain(FB_EVENT_GET_CONSOLE_MAP, &event);
 		unlock_fb_info(info);
@@ -1214,10 +1193,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		}
 		event.data = &con2fb;
 		console_lock();
-		if (!lock_fb_info(info)) {
-			console_unlock();
-			return -ENODEV;
-		}
+		lock_fb_info(info);
 		event.info = info;
 		ret = fb_notifier_call_chain(FB_EVENT_SET_CONSOLE_MAP, &event);
 		unlock_fb_info(info);
@@ -1225,10 +1201,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		break;
 	case FBIOBLANK:
 		console_lock();
-		if (!lock_fb_info(info)) {
-			console_unlock();
-			return -ENODEV;
-		}
+		lock_fb_info(info);
 		info->flags |= FBINFO_MISC_USEREVENT;
 		ret = fb_blank(info, arg);
 		info->flags &= ~FBINFO_MISC_USEREVENT;
@@ -1236,8 +1209,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		console_unlock();
 		break;
 	default:
-		if (!lock_fb_info(info))
-			return -ENODEV;
+		lock_fb_info(info);
 		fb = info->fbops;
 		if (fb->fb_ioctl)
 			ret = fb->fb_ioctl(info, cmd, arg);
@@ -1357,8 +1329,7 @@ static int fb_get_fscreeninfo(struct fb_info *info, unsigned int cmd,
 {
 	struct fb_fix_screeninfo fix;
 
-	if (!lock_fb_info(info))
-		return -ENODEV;
+	lock_fb_info(info);
 	fix = info->fix;
 	if (info->flags & FBINFO_HIDE_SMEM_START)
 		fix.smem_start = 0;
@@ -1418,8 +1389,6 @@ fb_mmap(struct file *file, struct vm_area_struct * vma)
 	if (!info)
 		return -ENODEV;
 	fb = info->fbops;
-	if (!fb)
-		return -ENODEV;
 	mutex_lock(&info->mm_lock);
 	if (fb->fb_mmap) {
 		int res;
@@ -1483,7 +1452,7 @@ __releases(&info->lock)
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 
-	mutex_lock(&info->lock);
+	lock_fb_info(info);
 	if (!try_module_get(info->fbops->owner)) {
 		res = -ENODEV;
 		goto out;
@@ -1499,7 +1468,7 @@ __releases(&info->lock)
 		fb_deferred_io_open(info, inode, file);
 #endif
 out:
-	mutex_unlock(&info->lock);
+	unlock_fb_info(info);
 	if (res)
 		put_fb_info(info);
 	return res;
@@ -1512,11 +1481,11 @@ __releases(&info->lock)
 {
 	struct fb_info * const info = file->private_data;
 
-	mutex_lock(&info->lock);
+	lock_fb_info(info);
 	if (info->fbops->fb_release)
 		info->fbops->fb_release(info,1);
 	module_put(info->fbops->owner);
-	mutex_unlock(&info->lock);
+	unlock_fb_info(info);
 	put_fb_info(info);
 	return 0;
 }
@@ -1734,14 +1703,10 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 		console_lock();
 	else
 		atomic_inc(&ignore_console_lock_warning);
-	if (!lock_fb_info(fb_info)) {
-		ret = -ENODEV;
-		goto unlock_console;
-	}
-
+	lock_fb_info(fb_info);
 	ret = fbcon_fb_registered(fb_info);
 	unlock_fb_info(fb_info);
-unlock_console:
+
 	if (!lockless_register_fb)
 		console_unlock();
 	else
@@ -1759,11 +1724,7 @@ static int unbind_console(struct fb_info *fb_info)
 		return -EINVAL;
 
 	console_lock();
-	if (!lock_fb_info(fb_info)) {
-		console_unlock();
-		return -ENODEV;
-	}
-
+	lock_fb_info(fb_info);
 	event.info = fb_info;
 	ret = fb_notifier_call_chain(FB_EVENT_FB_UNBIND, &event);
 	unlock_fb_info(fb_info);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 288175fafaf6..aa8f18163151 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -663,7 +663,10 @@ extern struct class *fb_class;
 	for (i = 0; i < FB_MAX; i++)		\
 		if (!registered_fb[i]) {} else
 
-extern int lock_fb_info(struct fb_info *info);
+static inline void lock_fb_info(struct fb_info *info)
+{
+	mutex_lock(&info->lock);
+}
 
 static inline void unlock_fb_info(struct fb_info *info)
 {
-- 
2.20.1

