Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6490DC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E07208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568973760;
	bh=q0+WwVxFVYOBe1bzOQvjTCz58Ih+FW9HTK2zTIoctsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TOXg2YYY3L+UOHtvY4AQuFbTaGo3tsUOhQAT3K3syzOpv7cfpbnDhFu9FcmYECHgZ
	 4YWBOiMBafdaOaZ82dC2h7Gx8Vc4HwogfBqrllY6PRCgPuY2xtBReD8N36XERgVUAU
	 GUu86o4RN7M5IrdX/DdKsC1C9tOKZEhXRBHFXAl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408627AbfITKCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 06:02:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46648 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405821AbfITKCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 06:02:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id t8so4582395lfc.13;
        Fri, 20 Sep 2019 03:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E623j+nt7XQE/wklHqBHR6f+nP+m665/hNZVcK3I0a4=;
        b=DusCc2wrnCdg8UhMS309PbrwRGp+IuPANdp6rg4NN7yo2dLy74isXhe6hk3B27ZNCJ
         OruTKoXQnwx7J0XS3915ISUvBwB9GQbBrSR/WrfiAH5G9WOVScoRh5N3VWT4Q2aS1J8K
         t5j1Qt4Ug0ZPIubhYphx1MX+UrPW71G/Ilx0zq7a/qzHTaDaWQRZ5XAZ0BDLdYw6gCrp
         GhstNS2MnItpJjSOqBjkjOi8XD2QWLJ1q4aTUuonMHATpe2R0StiNmpZ/f7MWTfpwkrZ
         0O+ppVGZSddGZ7x3kmoaSBX1ziwHqsfgY2RQaf96GFkiG9gfU8UWUbPRGW1kuvWDWJcf
         YnWg==
X-Gm-Message-State: APjAAAW+61sqctNs9E0z2XrXFjIljJ7GNI1K0swVf/2s16zb9KIOl/yh
        tX0NAeh809Zern6cym9La54=
X-Google-Smtp-Source: APXvYqypbSOPNHNXKQ+yYU7zs71GuyvRN9Vs7lv+5nnlZCQZZfcCVUBJJ73NXdOfhr3GwrCB6T85+g==
X-Received: by 2002:a19:c7d3:: with SMTP id x202mr8217235lff.124.1568973754175;
        Fri, 20 Sep 2019 03:02:34 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id m25sm322038ljg.35.2019.09.20.03.02.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 03:02:33 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iBFkH-0003jG-B1; Fri, 20 Sep 2019 12:02:34 +0200
Date:   Fri, 20 Sep 2019 12:02:33 +0200
From:   Johan Hovold <johan@kernel.org>
To:     syzbot <syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, dmg@turingmachine.org,
        gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in adu_disconnect
Message-ID: <20190920100233.GP30545@localhost>
References: <20190920090803.GM30545@localhost>
 <000000000000174fe60592f893e1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000174fe60592f893e1@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 02:20:00AM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer still triggered  
> crash:
> KASAN: use-after-free Read in adu_interrupt_in_callback
> 
> ==================================================================
> BUG: KASAN: use-after-free in __lock_acquire+0x302a/0x3b50  
> kernel/locking/lockdep.c:3753
> Read of size 8 at addr ffff8881cd4d0358 by task kworker/0:6/3051
> 
> CPU: 0 PID: 3051 Comm: kworker/0:6 Not tainted 5.3.0-rc2+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>   <IRQ>
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xca/0x13e lib/dump_stack.c:113
>   print_address_description+0x6a/0x32c mm/kasan/report.c:351
>   __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
>   kasan_report+0xe/0x12 mm/kasan/common.c:612
>   __lock_acquire+0x302a/0x3b50 kernel/locking/lockdep.c:3753
>   lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4412
>   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>   _raw_spin_lock_irqsave+0x32/0x50 kernel/locking/spinlock.c:159
>   adu_interrupt_in_callback+0x77/0x380 drivers/usb/misc/adutux.c:163
>   __usb_hcd_giveback_urb+0x1f2/0x470 drivers/usb/core/hcd.c:1757
>   usb_hcd_giveback_urb+0x368/0x420 drivers/usb/core/hcd.c:1822
>   dummy_timer+0x120f/0x2fa2 drivers/usb/gadget/udc/dummy_hcd.c:1965
>   call_timer_fn+0x179/0x650 kernel/time/timer.c:1322
>   expire_timers kernel/time/timer.c:1366 [inline]
>   __run_timers kernel/time/timer.c:1685 [inline]
>   __run_timers kernel/time/timer.c:1653 [inline]
>   run_timer_softirq+0x5cc/0x14b0 kernel/time/timer.c:1698
>   __do_softirq+0x221/0x912 kernel/softirq.c:292
>   invoke_softirq kernel/softirq.c:373 [inline]
>   irq_exit+0x178/0x1a0 kernel/softirq.c:413
>   exiting_irq arch/x86/include/asm/apic.h:537 [inline]
>   smp_apic_timer_interrupt+0x12f/0x500 arch/x86/kernel/apic/apic.c:1095
>   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:828
>   </IRQ>
> RIP: 0010:arch_local_irq_restore arch/x86/include/asm/irqflags.h:85 [inline]
> RIP: 0010:console_unlock+0xa2a/0xc40 kernel/printk/printk.c:2471
> Code: 00 89 ee 48 c7 c7 20 88 d3 86 e8 81 ad 03 00 65 ff 0d 72 a1 d9 7e e9  
> db f9 ff ff e8 70 a1 15 00 e8 1b cb 1a 00 ff 74 24 30 9d <e9> 18 fe ff ff  
> e8 5c a1 15 00 48 8d 7d 08 48 89 f8 48 c1 e8 03 42
> RSP: 0018:ffff8881cd20f200 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
> RAX: 0000000000000007 RBX: 0000000000000200 RCX: 0000000000000006
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff8881ccd8d044
> RBP: 0000000000000000 R08: ffff8881ccd8c800 R09: fffffbfff11acd91
> R10: fffffbfff11acd90 R11: ffffffff88d66c87 R12: 0000000000000047
> R13: dffffc0000000000 R14: ffffffff82909100 R15: ffffffff87077190
>   vprintk_emit+0x171/0x3e0 kernel/printk/printk.c:1986
>   vprintk_func+0x75/0x113 kernel/printk/printk_safe.c:386
>   printk+0xba/0xed kernel/printk/printk.c:2046
>   really_probe.cold+0x81/0x13a drivers/base/dd.c:616
>   driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
>   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
>   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
>   __device_attach+0x217/0x360 drivers/base/dd.c:882
>   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
>   device_add+0xae6/0x16f0 drivers/base/core.c:2114
>   usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
>   generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
>   usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
>   really_probe+0x281/0x650 drivers/base/dd.c:548
>   driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
>   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
>   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
>   __device_attach+0x217/0x360 drivers/base/dd.c:882
>   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
>   device_add+0xae6/0x16f0 drivers/base/core.c:2114
>   usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
>   hub_port_connect drivers/usb/core/hub.c:5098 [inline]
>   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
>   port_event drivers/usb/core/hub.c:5359 [inline]
>   hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
>   process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
>   worker_thread+0x96/0xe20 kernel/workqueue.c:2415
>   kthread+0x318/0x420 kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> 
> Allocated by task 3051:
>   save_stack+0x1b/0x80 mm/kasan/common.c:69
>   set_track mm/kasan/common.c:77 [inline]
>   __kasan_kmalloc mm/kasan/common.c:487 [inline]
>   __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:460
>   kmalloc include/linux/slab.h:552 [inline]
>   kzalloc include/linux/slab.h:748 [inline]
>   adu_probe+0x7d/0x6e0 drivers/usb/misc/adutux.c:660
>   usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
>   really_probe+0x281/0x650 drivers/base/dd.c:548
>   driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
>   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
>   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
>   __device_attach+0x217/0x360 drivers/base/dd.c:882
>   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
>   device_add+0xae6/0x16f0 drivers/base/core.c:2114
>   usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
>   generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
>   usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
>   really_probe+0x281/0x650 drivers/base/dd.c:548
>   driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
>   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
>   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
>   __device_attach+0x217/0x360 drivers/base/dd.c:882
>   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
>   device_add+0xae6/0x16f0 drivers/base/core.c:2114
>   usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
>   hub_port_connect drivers/usb/core/hub.c:5098 [inline]
>   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
>   port_event drivers/usb/core/hub.c:5359 [inline]
>   hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
>   process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
>   worker_thread+0x96/0xe20 kernel/workqueue.c:2415
>   kthread+0x318/0x420 kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> 
> Freed by task 3051:
>   save_stack+0x1b/0x80 mm/kasan/common.c:69
>   set_track mm/kasan/common.c:77 [inline]
>   __kasan_slab_free+0x130/0x180 mm/kasan/common.c:449
>   slab_free_hook mm/slub.c:1423 [inline]
>   slab_free_freelist_hook mm/slub.c:1470 [inline]
>   slab_free mm/slub.c:3012 [inline]
>   kfree+0xe4/0x2f0 mm/slub.c:3953
>   adu_probe+0x5de/0x6e0 drivers/usb/misc/adutux.c:750
>   usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
>   really_probe+0x281/0x650 drivers/base/dd.c:548
>   driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
>   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
>   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
>   __device_attach+0x217/0x360 drivers/base/dd.c:882
>   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
>   device_add+0xae6/0x16f0 drivers/base/core.c:2114
>   usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
>   generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
>   usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
>   really_probe+0x281/0x650 drivers/base/dd.c:548
>   driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
>   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
>   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
>   __device_attach+0x217/0x360 drivers/base/dd.c:882
>   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
>   device_add+0xae6/0x16f0 drivers/base/core.c:2114
>   usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
>   hub_port_connect drivers/usb/core/hub.c:5098 [inline]
>   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
>   port_event drivers/usb/core/hub.c:5359 [inline]
>   hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
>   process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
>   worker_thread+0x96/0xe20 kernel/workqueue.c:2415
>   kthread+0x318/0x420 kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

This looks like a separate issue, which should be fixed by a separate
patch. Not sure how to tell syzbot that. Dmitry?

There's is indeed another bug in the driver, which could lead to crashes
in the completion handler after clearing the struct usb_device pointer,
but possibly also to the above use-after-free if a new device is probed
immediately after a disconnect.

The below patch addresses both bugs, let's see if that helps.

#syz test: https://github.com/google/kasan.git e96407b4

Johan

From c68eda0c6aae5b233fbd583afbfd3ea15acbc62f Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 19 Sep 2019 11:48:38 +0200
Subject: [PATCH] USB: adutux: fix use-after-free on disconnect + more

FIXME: separate stopping URBs

The driver was clearing its struct usb_device pointer, which it uses as
an inverted disconnected flag, before deregistering the character device
and without serialising against racing release().

This could lead to a use-after-free if a racing release() callback
observes the cleared pointer and frees the driver data before
disconnect() is finished with it.

This could also lead to NULL-pointer dereferences in a racing open().

Fixes: f08812d5eb8f ("USB: FIx locks and urb->status in adutux (updated)")
Reported-by: syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com
Cc: stable <stable@vger.kernel.org>     # 2.6.24
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/misc/adutux.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/misc/adutux.c b/drivers/usb/misc/adutux.c
index 344d523b0502..a6996772745e 100644
--- a/drivers/usb/misc/adutux.c
+++ b/drivers/usb/misc/adutux.c
@@ -762,14 +762,18 @@ static void adu_disconnect(struct usb_interface *interface)
 
 	dev = usb_get_intfdata(interface);
 
-	mutex_lock(&dev->mtx);	/* not interruptible */
-	dev->udev = NULL;	/* poison */
 	usb_deregister_dev(interface, &adu_class);
-	mutex_unlock(&dev->mtx);
+
+	usb_poison_urb(dev->interrupt_in_urb);
+	usb_poison_urb(dev->interrupt_out_urb);
 
 	mutex_lock(&adutux_mutex);
 	usb_set_intfdata(interface, NULL);
 
+	mutex_lock(&dev->mtx);	/* not interruptible */
+	dev->udev = NULL;	/* poison */
+	mutex_unlock(&dev->mtx);
+
 	/* if the device is not opened, then we clean up right now */
 	if (!dev->open_count)
 		adu_delete(dev);
-- 
2.23.0

