Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAECC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E62214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568723050;
	bh=fvc1B25q+wpmmsBosHvZ5+1URMnECZuZln3G5v0t/zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AMIQhVBABQzWCY/Wn10GhOVlPE5LVPJu1niB1gSDpMFwiErNeNeAjxsbPx9fxPi9M
	 fV8hgAnSixVVTH+p5H+KjIr9jkq1kTQ1Ro5Zwxu22EfLUvZkX5wBaTWQadrjLbj/8t
	 Uf7VlfXM5mvzExzEhYBHajR8ekgRpvSoTDu+tI2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfIQMYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 08:24:09 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34603 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfIQMYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 08:24:08 -0400
Received: by mail-lf1-f65.google.com with SMTP id r22so2749597lfm.1;
        Tue, 17 Sep 2019 05:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ATmMm4PtOzpf5MHakWpyzAkkWvJPFHoj6oF0JiZe8g8=;
        b=RQKmgjN9tokGC8BoYzDJkJdx07U83nBgOeQN2BFR6hCvnYVzRsU7+7t0fr/4DTZaKR
         2dc2k8K0hcEFMuk3UNc8FrBqYOaCU8mRHyLJWll79ZzJ3vU3GZE0igpX4J83vz4wWHhM
         kuMihiHd70iGf4c24R9xf2Z62TJSXyn9PwfIO8UolzNR2oxNMTUlnZyQ2/QR3b803uuc
         h1juUvBmXhSV1VgAexoQ+agbkgAWfy23ts7VDigAX5GPFSjwyn7mG/RZxVIDTBaUX8xP
         F7s6WaM7IY4uuhd0GvP8qrGlgcN2+Ib/zZ1JHFwYVTT3f3i9+Y3mje9AxK9KJbkI80Y+
         2w/Q==
X-Gm-Message-State: APjAAAXS41qzOxl8wXCpbO/ImfeRDHUu/71gWJ26Hghr4euRpdIILxG6
        lp4VdjlsB+wijBannUTMAI8=
X-Google-Smtp-Source: APXvYqxlfXMRhZv/pAJAf/P+GGqfQIDe/BvUcAPJ2p/Lb2/Wc4v+Wt4K4ovTclFnoCc2P9o6u30KHA==
X-Received: by 2002:a19:f24d:: with SMTP id d13mr1953235lfk.127.1568723045984;
        Tue, 17 Sep 2019 05:24:05 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id v4sm404070lji.103.2019.09.17.05.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 05:24:05 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iACWa-0007fL-R2; Tue, 17 Sep 2019 14:24:04 +0200
Date:   Tue, 17 Sep 2019 14:24:04 +0200
From:   Johan Hovold <johan@kernel.org>
To:     syzbot <syzbot+f9549f5ee8a5416f0b95@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        Oliver Neukum <oneukum@suse.com>
Subject: Re: possible deadlock in usb_deregister_dev (2)
Message-ID: <20190917122404.GA29364@localhost>
References: <000000000000d58eb90592add24e@google.com>
 <000000000000b02ae30592b279e4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000b02ae30592b279e4@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 02:42:06PM -0700, syzbot wrote:
> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=175cdb95600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
> dashboard link: https://syzkaller.appspot.com/bug?extid=f9549f5ee8a5416f0b95
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13961369600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139c811d600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+f9549f5ee8a5416f0b95@syzkaller.appspotmail.com
> 
> usb 1-1: config 0 descriptor??
> legousbtower 1-1:0.219: LEGO USB Tower firmware version is 129.136 build  
> 65535
> legousbtower 1-1:0.219: LEGO USB Tower #-160 now attached to major 180  
> minor 0
> usb 1-1: USB disconnect, device number 2
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.3.0-rc7+ #0 Not tainted
> ------------------------------------------------------
> kworker/0:1/12 is trying to acquire lock:
> 0000000098630ee4 (minor_rwsem){++++}, at: usb_deregister_dev+0x95/0x230  
> drivers/usb/core/file.c:239
> 
> but task is already holding lock:
> 00000000d9ad5b6f (open_disc_mutex){+.+.}, at: tower_disconnect+0x45/0x300  
> drivers/usb/misc/legousbtower.c:945
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (open_disc_mutex){+.+.}:
>         __mutex_lock_common kernel/locking/mutex.c:930 [inline]
>         __mutex_lock+0x158/0x1360 kernel/locking/mutex.c:1077
>         tower_open+0xce/0x9b0 drivers/usb/misc/legousbtower.c:335
>         usb_open+0x1df/0x270 drivers/usb/core/file.c:48
>         chrdev_open+0x219/0x5c0 fs/char_dev.c:414
>         do_dentry_open+0x494/0x1120 fs/open.c:797
>         do_last fs/namei.c:3416 [inline]
>         path_openat+0x1430/0x3f50 fs/namei.c:3533
>         do_filp_open+0x1a1/0x280 fs/namei.c:3563
>         do_sys_open+0x3c0/0x580 fs/open.c:1089
>         do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> -> #0 (minor_rwsem){++++}:
>         check_prev_add kernel/locking/lockdep.c:2405 [inline]
>         check_prevs_add kernel/locking/lockdep.c:2507 [inline]
>         validate_chain kernel/locking/lockdep.c:2897 [inline]
>         __lock_acquire+0x1f7c/0x3b50 kernel/locking/lockdep.c:3880
>         lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4412
>         down_write+0x92/0x150 kernel/locking/rwsem.c:1500
>         usb_deregister_dev+0x95/0x230 drivers/usb/core/file.c:239
>         tower_disconnect+0xa8/0x300 drivers/usb/misc/legousbtower.c:951
>         usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:423
>         __device_release_driver drivers/base/dd.c:1134 [inline]
>         device_release_driver_internal+0x42f/0x500 drivers/base/dd.c:1165
>         bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:556
>         device_del+0x420/0xb10 drivers/base/core.c:2339
>         usb_disable_device+0x211/0x690 drivers/usb/core/message.c:1237
>         usb_disconnect+0x284/0x8d0 drivers/usb/core/hub.c:2199
>         hub_port_connect drivers/usb/core/hub.c:4949 [inline]
>         hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
>         port_event drivers/usb/core/hub.c:5359 [inline]
>         hub_event+0x1454/0x3640 drivers/usb/core/hub.c:5441
>         process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
>         worker_thread+0x96/0xe20 kernel/workqueue.c:2415
>         kthread+0x318/0x420 kernel/kthread.c:255
>         ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> 
> other info that might help us debug this:
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(open_disc_mutex);
>                                 lock(minor_rwsem);
>                                 lock(open_disc_mutex);
>    lock(minor_rwsem);
> 
>   *** DEADLOCK ***

This should be fixed by the below patch. Looks like we may have a
similar issue in a few more drivers. Fixing them up next.

Johan

#syz test: https://github.com/google/kasan.git f0df5c1b


From c2c2800f2687be963acc222045c8fd89f3877642 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 17 Sep 2019 12:32:22 +0200
Subject: [PATCH] USB: legousbtower: fix deadlock on disconnect

Fix a potential deadlock if disconnect races with open.

Since commit d4ead16f50f9 ("USB: prevent char device open/deregister
race") core holds an rw-semaphore while open is called and when
releasing the minor number during deregistration. This can lead to an
ABBA deadlock if a driver takes a lock in open which it also holds
during deregistration.

This effectively reverts commit 78663ecc344b ("USB: disconnect open race
in legousbtower") which needlessly introduced this issue after a generic
fix for this race had been added to core by commit d4ead16f50f9 ("USB:
prevent char device open/deregister race").

Fixes: 78663ecc344b ("USB: disconnect open race in legousbtower")
Cc: stable <stable@vger.kernel.org>	# 2.6.24
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oneukum@suse.com>
Reported-by: syzbot+f9549f5ee8a5416f0b95@syzkaller.appspotmail.com
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/misc/legousbtower.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/misc/legousbtower.c b/drivers/usb/misc/legousbtower.c
index 006cf13b2199..c125f03436a1 100644
--- a/drivers/usb/misc/legousbtower.c
+++ b/drivers/usb/misc/legousbtower.c
@@ -179,7 +179,6 @@ static const struct usb_device_id tower_table[] = {
 };
 
 MODULE_DEVICE_TABLE (usb, tower_table);
-static DEFINE_MUTEX(open_disc_mutex);
 
 #define LEGO_USB_TOWER_MINOR_BASE	160
 
@@ -332,18 +331,14 @@ static int tower_open (struct inode *inode, struct file *file)
 		goto exit;
 	}
 
-	mutex_lock(&open_disc_mutex);
 	dev = usb_get_intfdata(interface);
-
 	if (!dev) {
-		mutex_unlock(&open_disc_mutex);
 		retval = -ENODEV;
 		goto exit;
 	}
 
 	/* lock this device */
 	if (mutex_lock_interruptible(&dev->lock)) {
-		mutex_unlock(&open_disc_mutex);
 	        retval = -ERESTARTSYS;
 		goto exit;
 	}
@@ -351,12 +346,10 @@ static int tower_open (struct inode *inode, struct file *file)
 
 	/* allow opening only once */
 	if (dev->open_count) {
-		mutex_unlock(&open_disc_mutex);
 		retval = -EBUSY;
 		goto unlock_exit;
 	}
 	dev->open_count = 1;
-	mutex_unlock(&open_disc_mutex);
 
 	/* reset the tower */
 	result = usb_control_msg (dev->udev,
@@ -423,10 +416,9 @@ static int tower_release (struct inode *inode, struct file *file)
 
 	if (dev == NULL) {
 		retval = -ENODEV;
-		goto exit_nolock;
+		goto exit;
 	}
 
-	mutex_lock(&open_disc_mutex);
 	if (mutex_lock_interruptible(&dev->lock)) {
 	        retval = -ERESTARTSYS;
 		goto exit;
@@ -456,10 +448,7 @@ static int tower_release (struct inode *inode, struct file *file)
 
 unlock_exit:
 	mutex_unlock(&dev->lock);
-
 exit:
-	mutex_unlock(&open_disc_mutex);
-exit_nolock:
 	return retval;
 }
 
@@ -910,7 +899,6 @@ static int tower_probe (struct usb_interface *interface, const struct usb_device
 	if (retval) {
 		/* something prevented us from registering this driver */
 		dev_err(idev, "Not able to get a minor for this device.\n");
-		usb_set_intfdata (interface, NULL);
 		goto error;
 	}
 	dev->minor = interface->minor;
@@ -942,16 +930,13 @@ static void tower_disconnect (struct usb_interface *interface)
 	int minor;
 
 	dev = usb_get_intfdata (interface);
-	mutex_lock(&open_disc_mutex);
-	usb_set_intfdata (interface, NULL);
 
 	minor = dev->minor;
 
-	/* give back our minor */
+	/* give back our minor and prevent further open() */
 	usb_deregister_dev (interface, &tower_class);
 
 	mutex_lock(&dev->lock);
-	mutex_unlock(&open_disc_mutex);
 
 	/* if the device is not opened, then we clean up right now */
 	if (!dev->open_count) {
-- 
2.23.0

