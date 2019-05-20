Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112DFC072A4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17D820815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YNbYvBWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731418AbfETIWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:22:50 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42059 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731377AbfETIWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:22:45 -0400
Received: by mail-ed1-f68.google.com with SMTP id l25so22499017eda.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NJ126eKIev+vpaWGS6bKA79Fjam4T/ElEf+qZAMI/7g=;
        b=YNbYvBWoGLxyzkX8oTfFpKGibuza0Yz/toJpp9ekQfP/wv3PaOEE6aMegl/J5lexOO
         LHcrYv0GsfJnVY87UMPRZjn7jWNBQmfdAqdG0LSq9Pd5PDEJbUTQffLS1KNy32O1qew+
         DoQbDiwlrU4Z6C+o6OcAe9QB93Auc2ub6xJp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NJ126eKIev+vpaWGS6bKA79Fjam4T/ElEf+qZAMI/7g=;
        b=cI9msLgm7RLduExfFQ/BOxqHg2UpbtZEobxVxEOeaRrcdGozg1CIndqGxYxz3iZbgX
         j/Ct1E0/WPiwtUB9GqiJgKeJ/LarJ/lvasO2iCla7pxRMtvs/tuiIzM1lwyLQRdLmefp
         1a0mpT3E1sd3DahV0JRBDlUj8Cz49CKKODuwBCoXrpE8l1JHYR8i9m9oqt+y6kqJZFFm
         R2WMh06JLjeS3qfSDoC4uZnwktMCm/Vh2/dx44GQEpqPEvPU6QStidV5/jOLANRQBS4J
         Eq65pDjPxPQ0/hK3SliCLzOFoeQ83Z4m/tjmGe++X/khXODIlHyucZhC/QgX6t20KGpT
         WncQ==
X-Gm-Message-State: APjAAAWBflz54Ovl60DI/psRa80KLBSfm08AlVelwMx3ogbNedekJz3/
        G8fHBaw17WZZ7r4D22CuG+mfQQ==
X-Google-Smtp-Source: APXvYqzG7z92/iPE6K3oJFDIArvmbDp+doQdc8RO4mK8zIir7D2yQ4RhKUJP6uJba1FYDFRz0e4V+g==
X-Received: by 2002:a50:c315:: with SMTP id a21mr73070255edb.158.1558340563703;
        Mon, 20 May 2019 01:22:43 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:43 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Peter Rosin <peda@axentia.se>,
        Hans de Goede <hdegoede@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 18/33] fbdev: make unregister/unlink functions not fail
Date:   Mon, 20 May 2019 10:22:01 +0200
Message-Id: <20190520082216.26273-19-daniel.vetter@ffwll.ch>
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

Except for driver bugs (which we'll catch with a WARN_ON) this is only
to report failures of the new driver taking over the console. There's
nothing the outgoing driver can do about that, and no one ever
bothered to actually look at these return values. So remove them all.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Peter Rosin <peda@axentia.se>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/core/fbmem.c | 73 ++++++++++----------------------
 include/linux/fb.h               |  4 +-
 2 files changed, 25 insertions(+), 52 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 156523cc48bf..032506576aa0 100644
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
@@ -1706,32 +1700,25 @@ static int do_register_framebuffer(struct fb_info *fb_info)
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
 
@@ -1749,36 +1736,27 @@ static int do_unregister_framebuffer(struct fb_info *fb_info)
 
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
 
@@ -1795,7 +1773,6 @@ EXPORT_SYMBOL(unlink_framebuffer);
 int remove_conflicting_framebuffers(struct apertures_struct *a,
 				    const char *name, bool primary)
 {
-	int ret;
 	bool do_free = false;
 
 	if (!a) {
@@ -1809,13 +1786,13 @@ int remove_conflicting_framebuffers(struct apertures_struct *a,
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
 
@@ -1891,16 +1868,12 @@ EXPORT_SYMBOL(register_framebuffer);
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
 
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 38fae1678939..44021e55b15c 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -627,8 +627,8 @@ extern ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
 
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

