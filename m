Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF46C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A7A205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r7EvXQYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438036AbfITKIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 06:08:47 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42782 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438024AbfITKIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 06:08:44 -0400
Received: by mail-qt1-f193.google.com with SMTP id w14so3543839qto.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 03:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KyduHUR/pFwKdJnhMzDJkKlw/SznYjqdRRxhh5G40Jg=;
        b=r7EvXQYjq7Wio7UbF8QgM/1icqvPF1ZnSEVNGR4JVR0BG6Wl0x6fH6xtaKeUxDsi71
         wkgEPkPcc0VkVjKgzro+WkV5xUkTFSSRT/Aak6Mw157pQSN917a8NdFb0TZm+seaHKK7
         hHTQZ1A63vFt7GSPnAZlqpZ9rm6BCWvsd18JUW9njZwbIrJisrI6UYKEPXJ/uSYL1sby
         HB6HT5CiezEo19rFc/LYAM7FRsfnKYSpPFG9m3+A+q29Lsm8RGijOTpCY89xt+Av7m0H
         wmuqXYSeK7CLCwYyidprNbJaZpAXVEqqpfBtBlqzlr3LxeRqEWKCdNiNIwBTcawdmsSS
         JjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KyduHUR/pFwKdJnhMzDJkKlw/SznYjqdRRxhh5G40Jg=;
        b=LUmHHaxu4+H6CDGpS5HIRVJ2DX89MIBJC19lKYDdumHRkp47LJx4zWk0B5ufVrTvHP
         GELtFcyvhxZ6DTMoAhaQNcCeqoFt8IBblQhdSCvfK3cNpnYvo0b5LMXImqpehxYiWUS0
         KaDHMUsKaVQ/bUQqWl5zngXw1Vs4ep71X9WWvEhU3VMnxqmmVCXQmajMT5fC6wADW2za
         jx4KNdtQCa9rFcN0dMTin4Lp1BWoaa0wlt2E9ImLz/YylZteso6sSNX+WbgwOD3v0x0d
         +IT1N49w5NwTlKS+Daz19c0TH+IqLrF3rBJM1XMlM8IfH3n8OYHwGWijhkDRZULjuQKD
         JtTg==
X-Gm-Message-State: APjAAAUmwRlcgNSwabbdVp5UtGjGdMMk6umGbrT6QBI1uwRscf7JVsIa
        jc+zqIY/Z/PfDVVd0HsABqH/WZRvxiTCYD8EoOMxiw==
X-Google-Smtp-Source: APXvYqws3o5jgB56X/8l4G6e6jj4tzoSyh6unnq51NfW0nRt2hBna89u1fBBU/i10fnIPmzliSsKhpFBKGTShPVyWCE=
X-Received: by 2002:ac8:2c50:: with SMTP id e16mr2331898qta.257.1568974122036;
 Fri, 20 Sep 2019 03:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190920090803.GM30545@localhost> <000000000000174fe60592f893e1@google.com>
 <20190920100233.GP30545@localhost>
In-Reply-To: <20190920100233.GP30545@localhost>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 20 Sep 2019 12:08:30 +0200
Message-ID: <CACT4Y+a18nm92r889vJNrwq2518FYMV-cOqiKPQ53VwqwK0oMA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in adu_disconnect
To:     Johan Hovold <johan@kernel.org>
Cc:     syzbot <syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        dmg@turingmachine.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 12:02 PM Johan Hovold <johan@kernel.org> wrote:
>
> On Fri, Sep 20, 2019 at 02:20:00AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot has tested the proposed patch but the reproducer still triggered
> > crash:
> > KASAN: use-after-free Read in adu_interrupt_in_callback
> >
> > ==================================================================
> > BUG: KASAN: use-after-free in __lock_acquire+0x302a/0x3b50
> > kernel/locking/lockdep.c:3753
> > Read of size 8 at addr ffff8881cd4d0358 by task kworker/0:6/3051
> >
> > CPU: 0 PID: 3051 Comm: kworker/0:6 Not tainted 5.3.0-rc2+ #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Workqueue: usb_hub_wq hub_event
> > Call Trace:
> >   <IRQ>
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0xca/0x13e lib/dump_stack.c:113
> >   print_address_description+0x6a/0x32c mm/kasan/report.c:351
> >   __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
> >   kasan_report+0xe/0x12 mm/kasan/common.c:612
> >   __lock_acquire+0x302a/0x3b50 kernel/locking/lockdep.c:3753
> >   lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4412
> >   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >   _raw_spin_lock_irqsave+0x32/0x50 kernel/locking/spinlock.c:159
> >   adu_interrupt_in_callback+0x77/0x380 drivers/usb/misc/adutux.c:163
> >   __usb_hcd_giveback_urb+0x1f2/0x470 drivers/usb/core/hcd.c:1757
> >   usb_hcd_giveback_urb+0x368/0x420 drivers/usb/core/hcd.c:1822
> >   dummy_timer+0x120f/0x2fa2 drivers/usb/gadget/udc/dummy_hcd.c:1965
> >   call_timer_fn+0x179/0x650 kernel/time/timer.c:1322
> >   expire_timers kernel/time/timer.c:1366 [inline]
> >   __run_timers kernel/time/timer.c:1685 [inline]
> >   __run_timers kernel/time/timer.c:1653 [inline]
> >   run_timer_softirq+0x5cc/0x14b0 kernel/time/timer.c:1698
> >   __do_softirq+0x221/0x912 kernel/softirq.c:292
> >   invoke_softirq kernel/softirq.c:373 [inline]
> >   irq_exit+0x178/0x1a0 kernel/softirq.c:413
> >   exiting_irq arch/x86/include/asm/apic.h:537 [inline]
> >   smp_apic_timer_interrupt+0x12f/0x500 arch/x86/kernel/apic/apic.c:1095
> >   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:828
> >   </IRQ>
> > RIP: 0010:arch_local_irq_restore arch/x86/include/asm/irqflags.h:85 [inline]
> > RIP: 0010:console_unlock+0xa2a/0xc40 kernel/printk/printk.c:2471
> > Code: 00 89 ee 48 c7 c7 20 88 d3 86 e8 81 ad 03 00 65 ff 0d 72 a1 d9 7e e9
> > db f9 ff ff e8 70 a1 15 00 e8 1b cb 1a 00 ff 74 24 30 9d <e9> 18 fe ff ff
> > e8 5c a1 15 00 48 8d 7d 08 48 89 f8 48 c1 e8 03 42
> > RSP: 0018:ffff8881cd20f200 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
> > RAX: 0000000000000007 RBX: 0000000000000200 RCX: 0000000000000006
> > RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff8881ccd8d044
> > RBP: 0000000000000000 R08: ffff8881ccd8c800 R09: fffffbfff11acd91
> > R10: fffffbfff11acd90 R11: ffffffff88d66c87 R12: 0000000000000047
> > R13: dffffc0000000000 R14: ffffffff82909100 R15: ffffffff87077190
> >   vprintk_emit+0x171/0x3e0 kernel/printk/printk.c:1986
> >   vprintk_func+0x75/0x113 kernel/printk/printk_safe.c:386
> >   printk+0xba/0xed kernel/printk/printk.c:2046
> >   really_probe.cold+0x81/0x13a drivers/base/dd.c:616
> >   driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
> >   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
> >   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
> >   __device_attach+0x217/0x360 drivers/base/dd.c:882
> >   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
> >   device_add+0xae6/0x16f0 drivers/base/core.c:2114
> >   usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
> >   generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
> >   usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
> >   really_probe+0x281/0x650 drivers/base/dd.c:548
> >   driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
> >   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
> >   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
> >   __device_attach+0x217/0x360 drivers/base/dd.c:882
> >   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
> >   device_add+0xae6/0x16f0 drivers/base/core.c:2114
> >   usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
> >   hub_port_connect drivers/usb/core/hub.c:5098 [inline]
> >   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
> >   port_event drivers/usb/core/hub.c:5359 [inline]
> >   hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
> >   process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
> >   worker_thread+0x96/0xe20 kernel/workqueue.c:2415
> >   kthread+0x318/0x420 kernel/kthread.c:255
> >   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> >
> > Allocated by task 3051:
> >   save_stack+0x1b/0x80 mm/kasan/common.c:69
> >   set_track mm/kasan/common.c:77 [inline]
> >   __kasan_kmalloc mm/kasan/common.c:487 [inline]
> >   __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:460
> >   kmalloc include/linux/slab.h:552 [inline]
> >   kzalloc include/linux/slab.h:748 [inline]
> >   adu_probe+0x7d/0x6e0 drivers/usb/misc/adutux.c:660
> >   usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
> >   really_probe+0x281/0x650 drivers/base/dd.c:548
> >   driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
> >   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
> >   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
> >   __device_attach+0x217/0x360 drivers/base/dd.c:882
> >   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
> >   device_add+0xae6/0x16f0 drivers/base/core.c:2114
> >   usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
> >   generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
> >   usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
> >   really_probe+0x281/0x650 drivers/base/dd.c:548
> >   driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
> >   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
> >   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
> >   __device_attach+0x217/0x360 drivers/base/dd.c:882
> >   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
> >   device_add+0xae6/0x16f0 drivers/base/core.c:2114
> >   usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
> >   hub_port_connect drivers/usb/core/hub.c:5098 [inline]
> >   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
> >   port_event drivers/usb/core/hub.c:5359 [inline]
> >   hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
> >   process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
> >   worker_thread+0x96/0xe20 kernel/workqueue.c:2415
> >   kthread+0x318/0x420 kernel/kthread.c:255
> >   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> >
> > Freed by task 3051:
> >   save_stack+0x1b/0x80 mm/kasan/common.c:69
> >   set_track mm/kasan/common.c:77 [inline]
> >   __kasan_slab_free+0x130/0x180 mm/kasan/common.c:449
> >   slab_free_hook mm/slub.c:1423 [inline]
> >   slab_free_freelist_hook mm/slub.c:1470 [inline]
> >   slab_free mm/slub.c:3012 [inline]
> >   kfree+0xe4/0x2f0 mm/slub.c:3953
> >   adu_probe+0x5de/0x6e0 drivers/usb/misc/adutux.c:750
> >   usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
> >   really_probe+0x281/0x650 drivers/base/dd.c:548
> >   driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
> >   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
> >   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
> >   __device_attach+0x217/0x360 drivers/base/dd.c:882
> >   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
> >   device_add+0xae6/0x16f0 drivers/base/core.c:2114
> >   usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
> >   generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
> >   usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
> >   really_probe+0x281/0x650 drivers/base/dd.c:548
> >   driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
> >   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
> >   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
> >   __device_attach+0x217/0x360 drivers/base/dd.c:882
> >   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
> >   device_add+0xae6/0x16f0 drivers/base/core.c:2114
> >   usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
> >   hub_port_connect drivers/usb/core/hub.c:5098 [inline]
> >   hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
> >   port_event drivers/usb/core/hub.c:5359 [inline]
> >   hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
> >   process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
> >   worker_thread+0x96/0xe20 kernel/workqueue.c:2415
> >   kthread+0x318/0x420 kernel/kthread.c:255
> >   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
>
> This looks like a separate issue, which should be fixed by a separate
> patch. Not sure how to tell syzbot that. Dmitry?

There is no way, but also no need. There is nothing it can do with that info.
If you think it's a separate one and you fixed the first one, mail the
patch with the first fix.
Optionally, you can fix the second one as well, and then ask it to
test a patch with 2 fixes (but you will need either to squash them or
point to a git tree with both commits).

> There's is indeed another bug in the driver, which could lead to crashes
> in the completion handler after clearing the struct usb_device pointer,
> but possibly also to the above use-after-free if a new device is probed
> immediately after a disconnect.
>
> The below patch addresses both bugs, let's see if that helps.
>
> #syz test: https://github.com/google/kasan.git e96407b4
>
> Johan
>
> From c68eda0c6aae5b233fbd583afbfd3ea15acbc62f Mon Sep 17 00:00:00 2001
> From: Johan Hovold <johan@kernel.org>
> Date: Thu, 19 Sep 2019 11:48:38 +0200
> Subject: [PATCH] USB: adutux: fix use-after-free on disconnect + more
>
> FIXME: separate stopping URBs
>
> The driver was clearing its struct usb_device pointer, which it uses as
> an inverted disconnected flag, before deregistering the character device
> and without serialising against racing release().
>
> This could lead to a use-after-free if a racing release() callback
> observes the cleared pointer and frees the driver data before
> disconnect() is finished with it.
>
> This could also lead to NULL-pointer dereferences in a racing open().
>
> Fixes: f08812d5eb8f ("USB: FIx locks and urb->status in adutux (updated)")
> Reported-by: syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com
> Cc: stable <stable@vger.kernel.org>     # 2.6.24
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/usb/misc/adutux.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/misc/adutux.c b/drivers/usb/misc/adutux.c
> index 344d523b0502..a6996772745e 100644
> --- a/drivers/usb/misc/adutux.c
> +++ b/drivers/usb/misc/adutux.c
> @@ -762,14 +762,18 @@ static void adu_disconnect(struct usb_interface *interface)
>
>         dev = usb_get_intfdata(interface);
>
> -       mutex_lock(&dev->mtx);  /* not interruptible */
> -       dev->udev = NULL;       /* poison */
>         usb_deregister_dev(interface, &adu_class);
> -       mutex_unlock(&dev->mtx);
> +
> +       usb_poison_urb(dev->interrupt_in_urb);
> +       usb_poison_urb(dev->interrupt_out_urb);
>
>         mutex_lock(&adutux_mutex);
>         usb_set_intfdata(interface, NULL);
>
> +       mutex_lock(&dev->mtx);  /* not interruptible */
> +       dev->udev = NULL;       /* poison */
> +       mutex_unlock(&dev->mtx);
> +
>         /* if the device is not opened, then we clean up right now */
>         if (!dev->open_count)
>                 adu_delete(dev);
> --
> 2.23.0
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20190920100233.GP30545%40localhost.
