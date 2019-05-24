Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9F3C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E192184B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Wz3jED3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390158AbfEXIyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:54:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44457 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390046AbfEXIy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id b8so13303541edm.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NyywHSxKSH9rbkQEVW1bm0OZNGSWaexy3bIHHkDY0kE=;
        b=Wz3jED3s1edTRWNDeaM5Rm4rK/0qjkWQb4ojq16+nzFJvA1l63U1vMUWvqjuSh+U61
         18s3GxLSXxQBDnPLr5aroa7HYa6jO09GWpQWB4pgsh7QNL7rK41P4MBi8vOSFgL5bKIY
         mun19+DRBDj7FQcSQIJYIYEzA75m3wzcq/6jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NyywHSxKSH9rbkQEVW1bm0OZNGSWaexy3bIHHkDY0kE=;
        b=dinhJ4tkvZEe9TNoeMUI/e3F6xfhKO70ZQJ23T0R/YfI++e1Dq9YCZUMC3mlBAWhhX
         yFaPNIrckprahDy4RwaoUerChiNCfb/6djQYT/0QQABuiJcCCwyleGExdLLhnbJiSyf5
         rWJ+ya7UYBZ65arJKGpTOE3UVrbnlE55MXNE/J5UzHCj79u9hYeEZWUcpy4B40ZQ32W7
         REiQkROTfNeAIs1nOAqDg59xqPKh/RYGK+ij8QhN7KjFUiwD11q8s7aZRz//q3J9yjgk
         G5EDAUokJHZTOiniYpUGMzJpn79ByCm4VMNNVxq7p8WjY1bwHcRGc8O2KpxzPkNXHEqP
         zOYQ==
X-Gm-Message-State: APjAAAVuN57UXkXu7+VKU5bPf+CwxAeYWkmHVEoy6NAel6BrSbjQLazK
        w3IYMK6SZICYj7p+Kct/P48mii/980I=
X-Google-Smtp-Source: APXvYqy8nQ6bPqZUOgLBxI8b048mVlS0CkyrXVYKquODpFSZ2z52RRZ6sBweNIA0DpeVh2fM84FcFg==
X-Received: by 2002:a50:86c9:: with SMTP id 9mr101372796edu.216.1558688065530;
        Fri, 24 May 2019 01:54:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:24 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Peter Rosin <peda@axentia.se>,
        Hans de Goede <hdegoede@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 18/33] fbdev: make unregister/unlink functions not fail
Date:   Fri, 24 May 2019 10:53:39 +0200
Message-Id: <20190524085354.27411-19-daniel.vetter@ffwll.ch>
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

Except for driver bugs (which we'll catch with a WARN_ON) this is only
to report failures of the new driver taking over the console. There's
nothing the outgoing driver can do about that, and no one ever
bothered to actually look at these return values. So remove them all.

v2: fixup unregister_framebuffer in savagefb, fbtft, ivtvfb, and neofb
drivers, reported by kbuild.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Peter Rosin <peda@axentia.se>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/media/pci/ivtv/ivtvfb.c              |  6 +-
 drivers/staging/fbtft/fbtft-core.c           |  4 +-
 drivers/video/fbdev/core/fbmem.c             | 73 ++++++--------------
 drivers/video/fbdev/neofb.c                  |  9 +--
 drivers/video/fbdev/savage/savagefb_driver.c |  9 +--
 include/linux/fb.h                           |  4 +-
 6 files changed, 31 insertions(+), 74 deletions(-)

diff --git a/drivers/media/pci/ivtv/ivtvfb.c b/drivers/media/pci/ivtv/ivtvfb.c
index cfd21040d0e3..6435c72ff58e 100644
--- a/drivers/media/pci/ivtv/ivtvfb.c
+++ b/drivers/media/pci/ivtv/ivtvfb.c
@@ -1258,11 +1258,7 @@ static int ivtvfb_callback_cleanup(struct device *dev, void *p)
 	struct osd_info *oi = itv->osd_info;
 
 	if (itv->v4l2_cap & V4L2_CAP_VIDEO_OUTPUT) {
-		if (unregister_framebuffer(&itv->osd_info->ivtvfb_info)) {
-			IVTVFB_WARN("Framebuffer %d is in use, cannot unload\n",
-				       itv->instance);
-			return 0;
-		}
+		unregister_framebuffer(&itv->osd_info->ivtvfb_info);
 		IVTVFB_INFO("Unregister framebuffer %d\n", itv->instance);
 		itv->ivtvfb_restore = NULL;
 		ivtvfb_blank(FB_BLANK_VSYNC_SUSPEND, &oi->ivtvfb_info);
diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 9b07badf4c6c..7cbc1bdd2d8a 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -891,7 +891,9 @@ int fbtft_unregister_framebuffer(struct fb_info *fb_info)
 	if (par->fbtftops.unregister_backlight)
 		par->fbtftops.unregister_backlight(par);
 	fbtft_sysfs_exit(par);
-	return unregister_framebuffer(fb_info);
+	unregister_framebuffer(fb_info);
+
+	return 0;
 }
 EXPORT_SYMBOL(fbtft_unregister_framebuffer);
 
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index f3fc2e5b193c..f3bcad30d3ba 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1590,13 +1590,13 @@ static bool fb_do_apertures_overlap(struct apertures_struct *gena,
 	return false;
 }
 
-static int do_unregister_framebuffer(struct fb_info *fb_info);
+static void do_unregister_framebuffer(struct fb_info *fb_info);
 
 #define VGA_FB_PHYS 0xA0000
-static int do_remove_conflicting_framebuffers(struct apertures_struct *a,
-					      const char *name, bool primary)
+static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
+					       const char *name, bool primary)
 {
-	int i, ret;
+	int i;
 
 	/* check all firmware fbs and kick off if the base addr overlaps */
 	for_each_registered_fb(i) {
@@ -1612,13 +1612,9 @@ static int do_remove_conflicting_framebuffers(struct apertures_struct *a,
 
 			printk(KERN_INFO "fb%d: switching to %s from %s\n",
 			       i, name, registered_fb[i]->fix.id);
-			ret = do_unregister_framebuffer(registered_fb[i]);
-			if (ret)
-				return ret;
+			do_unregister_framebuffer(registered_fb[i]);
 		}
 	}
-
-	return 0;
 }
 
 static bool lockless_register_fb;
@@ -1634,11 +1630,9 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	if (fb_check_foreignness(fb_info))
 		return -ENOSYS;
 
-	ret = do_remove_conflicting_framebuffers(fb_info->apertures,
-						 fb_info->fix.id,
-						 fb_is_primary_device(fb_info));
-	if (ret)
-		return ret;
+	do_remove_conflicting_framebuffers(fb_info->apertures,
+					   fb_info->fix.id,
+					   fb_is_primary_device(fb_info));
 
 	if (num_registered_fb == FB_MAX)
 		return -ENXIO;
@@ -1714,32 +1708,25 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	return ret;
 }
 
-static int unbind_console(struct fb_info *fb_info)
+static void unbind_console(struct fb_info *fb_info)
 {
 	int i = fb_info->node;
 
-	if (i < 0 || i >= FB_MAX || registered_fb[i] != fb_info)
-		return -EINVAL;
+	if (WARN_ON(i < 0 || i >= FB_MAX || registered_fb[i] != fb_info))
+		return;
 
 	console_lock();
 	lock_fb_info(fb_info);
 	fbcon_fb_unbind(fb_info);
 	unlock_fb_info(fb_info);
 	console_unlock();
-
-	return 0;
 }
 
-static int __unlink_framebuffer(struct fb_info *fb_info);
+static void __unlink_framebuffer(struct fb_info *fb_info);
 
-static int do_unregister_framebuffer(struct fb_info *fb_info)
+static void do_unregister_framebuffer(struct fb_info *fb_info)
 {
-	int ret;
-
-	ret = unbind_console(fb_info);
-
-	if (ret)
-		return -EINVAL;
+	unbind_console(fb_info);
 
 	pm_vt_switch_unregister(fb_info->dev);
 
@@ -1764,36 +1751,27 @@ static int do_unregister_framebuffer(struct fb_info *fb_info)
 
 	/* this may free fb info */
 	put_fb_info(fb_info);
-	return 0;
 }
 
-static int __unlink_framebuffer(struct fb_info *fb_info)
+static void __unlink_framebuffer(struct fb_info *fb_info)
 {
 	int i;
 
 	i = fb_info->node;
-	if (i < 0 || i >= FB_MAX || registered_fb[i] != fb_info)
-		return -EINVAL;
+	if (WARN_ON(i < 0 || i >= FB_MAX || registered_fb[i] != fb_info))
+		return;
 
 	if (fb_info->dev) {
 		device_destroy(fb_class, MKDEV(FB_MAJOR, i));
 		fb_info->dev = NULL;
 	}
-
-	return 0;
 }
 
-int unlink_framebuffer(struct fb_info *fb_info)
+void unlink_framebuffer(struct fb_info *fb_info)
 {
-	int ret;
-
-	ret = __unlink_framebuffer(fb_info);
-	if (ret)
-		return ret;
+	__unlink_framebuffer(fb_info);
 
 	unbind_console(fb_info);
-
-	return 0;
 }
 EXPORT_SYMBOL(unlink_framebuffer);
 
@@ -1810,7 +1788,6 @@ EXPORT_SYMBOL(unlink_framebuffer);
 int remove_conflicting_framebuffers(struct apertures_struct *a,
 				    const char *name, bool primary)
 {
-	int ret;
 	bool do_free = false;
 
 	if (!a) {
@@ -1824,13 +1801,13 @@ int remove_conflicting_framebuffers(struct apertures_struct *a,
 	}
 
 	mutex_lock(&registration_lock);
-	ret = do_remove_conflicting_framebuffers(a, name, primary);
+	do_remove_conflicting_framebuffers(a, name, primary);
 	mutex_unlock(&registration_lock);
 
 	if (do_free)
 		kfree(a);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(remove_conflicting_framebuffers);
 
@@ -1927,16 +1904,12 @@ EXPORT_SYMBOL(register_framebuffer);
  *      that the driver implements fb_open() and fb_release() to
  *      check that no processes are using the device.
  */
-int
+void
 unregister_framebuffer(struct fb_info *fb_info)
 {
-	int ret;
-
 	mutex_lock(&registration_lock);
-	ret = do_unregister_framebuffer(fb_info);
+	do_unregister_framebuffer(fb_info);
 	mutex_unlock(&registration_lock);
-
-	return ret;
 }
 EXPORT_SYMBOL(unregister_framebuffer);
 
diff --git a/drivers/video/fbdev/neofb.c b/drivers/video/fbdev/neofb.c
index 5d3a444083f7..b770946a0920 100644
--- a/drivers/video/fbdev/neofb.c
+++ b/drivers/video/fbdev/neofb.c
@@ -2122,14 +2122,7 @@ static void neofb_remove(struct pci_dev *dev)
 	DBG("neofb_remove");
 
 	if (info) {
-		/*
-		 * If unregister_framebuffer fails, then
-		 * we will be leaving hooks that could cause
-		 * oopsen laying around.
-		 */
-		if (unregister_framebuffer(info))
-			printk(KERN_WARNING
-			       "neofb: danger danger!  Oopsen imminent!\n");
+		unregister_framebuffer(info);
 
 		neo_unmap_video(info);
 		fb_destroy_modedb(info->monspecs.modedb);
diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index 47b78f0138c3..512789f5f884 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -2333,14 +2333,7 @@ static void savagefb_remove(struct pci_dev *dev)
 	DBG("savagefb_remove");
 
 	if (info) {
-		/*
-		 * If unregister_framebuffer fails, then
-		 * we will be leaving hooks that could cause
-		 * oopsen laying around.
-		 */
-		if (unregister_framebuffer(info))
-			printk(KERN_WARNING "savagefb: danger danger! "
-			       "Oopsen imminent!\n");
+		unregister_framebuffer(info);
 
 #ifdef CONFIG_FB_SAVAGE_I2C
 		savagefb_delete_i2c_busses(info);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index b6ce041d9e13..b90cf7d56bd8 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -634,8 +634,8 @@ extern ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
 
 /* drivers/video/fbmem.c */
 extern int register_framebuffer(struct fb_info *fb_info);
-extern int unregister_framebuffer(struct fb_info *fb_info);
-extern int unlink_framebuffer(struct fb_info *fb_info);
+extern void unregister_framebuffer(struct fb_info *fb_info);
+extern void unlink_framebuffer(struct fb_info *fb_info);
 extern int remove_conflicting_pci_framebuffers(struct pci_dev *pdev, int res_id,
 					       const char *name);
 extern int remove_conflicting_framebuffers(struct apertures_struct *a,
-- 
2.20.1

