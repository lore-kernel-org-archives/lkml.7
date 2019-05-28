Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6537BC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DDD2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Ibl6oEES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfE1JDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:03:42 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36005 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfE1JDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:40 -0400
Received: by mail-ed1-f65.google.com with SMTP id a8so30639687edx.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eHI5IVXk6rbiogxAf4+pmXRYOJ0Nr3KoY/dH7aae4Ec=;
        b=Ibl6oEES5fVamIiSNWf16iUWxfJctOaeOQ5rpCQdNoJugNugOKwDZ1MekFe5TE2l8z
         XhRPIQH4qsuRcK75/K3tWSWDApqhZxftrVa6ChZqf+TY0Yzecg3SvB+F5l2KyJ+dHG2S
         HAOJPMxwQWK9Kp7/OsiRluCDPlH0dhRu2M4XM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eHI5IVXk6rbiogxAf4+pmXRYOJ0Nr3KoY/dH7aae4Ec=;
        b=QNKmDPQCHivQYKgmeEhp+Vxj42jV5fRIUpHhFIPQ/9NkuTmdPn9gPZ5iiLTmBZkSgA
         96Gvgj104TQYy8nwjh87/nHEec7p3f19xCl6U931aH6lAEYACfze9//HOdz77EdA0zkH
         /nJY9DN5WqndsdELIRBH1/FlxkPvJbnZoi/qeLTJuJ/JuoGpgka8fQN2dgoKNT7ZDzSi
         0PZSiDKbDwJFkeRape8QcK7lV9QVDehDWGjY5MoGhk56EksmKZgqVMb6kpWDdPxMnevV
         Ksfz3NZ+J7emHP9LGBUqfZjeu6kxnXl+XSpW2OJsvgIJVzmMjxF6g9X32zVdHuHR+eYJ
         X/LA==
X-Gm-Message-State: APjAAAW/sdWIBtsC8Ta42/lGgy5xptQhfMrZAue0rBSPK3TL+TpoIkoE
        JrYjyu+wVvRgg6IvmGEd/2jkNMTa3mo=
X-Google-Smtp-Source: APXvYqxugSDC57A7rPd1r24SAQm6AVxtazuuZ58on72+1pvHZZEIZnYLrALq7Zz4fkvM/USoATjllw==
X-Received: by 2002:aa7:d6d3:: with SMTP id x19mr127434171edr.67.1559034217704;
        Tue, 28 May 2019 02:03:37 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:37 -0700 (PDT)
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
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Peter Rosin <peda@axentia.se>,
        Hans de Goede <hdegoede@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 18/33] fbdev: make unregister/unlink functions not fail
Date:   Tue, 28 May 2019 11:02:49 +0200
Message-Id: <20190528090304.9388-19-daniel.vetter@ffwll.ch>
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

Except for driver bugs (which we'll catch with a WARN_ON) this is only
to report failures of the new driver taking over the console. There's
nothing the outgoing driver can do about that, and no one ever
bothered to actually look at these return values. So remove them all.

v2: fixup unregister_framebuffer in savagefb, fbtft, ivtvfb, and neofb
drivers, reported by kbuild.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
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

