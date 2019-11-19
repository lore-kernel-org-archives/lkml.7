Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66099C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328EB206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t/otujsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfKSNqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 08:46:53 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44344 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfKSNqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 08:46:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id f2so23911104wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 05:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ycVz9jT/xyCychkTP5k91pUKRo9agocE7JrLYq5Uclk=;
        b=t/otujsYxGdmka7RW/VNeXmbwoOEJideyZH2EJmRbfbidUTlm1gLyspxLkKPKa6e5B
         B3h21u7XcMl4X0Fir4serdVHTxeNlmIzzZq/B+OCAfb01FXUlsXtXHFtm7xq5cKDxMN1
         2hRG4skNPUA5/sNlU/K5aSYQGTkBf/CJjf/la4e0FxuySUGpyYs3RZgY5zwO+QJHdsAZ
         ewWeuM0p2fRRAv6IchbnkEOfL7opTQcEh8GY0/MhOmKi1Q1drqZmKvCmx9zIiSZTu2bp
         Qmmtb9HVRJeKMUlzsZuferiOMXHMEMFF4qgHY+zoOAVefJfG6N8Sks8hj0rKMZcCQS0B
         sT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ycVz9jT/xyCychkTP5k91pUKRo9agocE7JrLYq5Uclk=;
        b=t1HRjx4fvpqzxkrHqskCK0mARiBmDmDvJ2kX6+pgdRwabYW/WVL0/yQ8XBqYod2eWr
         GpQqXdM+OTZQMJ8X1eVU5JO3t/uk4dwRU/XxoZzGgwUgTNhsi7Wp88fKM4QeaFJE7gZ7
         PBa0KVsGeZ+HLvv0HbjRYPfjjMoIbrSydxWJtk1NkRP0/exAUhKX/TxMaLYVYUep9BFl
         a2kQZVqP/dmYcyCCanHVH3AynS3q2f5YneKhLZ9CpPJZRSp+PEVfz0LcryHY5L3x4jEP
         ewP0ywX/dDW7i1xrXprQKhvtquCly/yHkLs/f9htrWvanNiCMs6BYnTOKfHzBH0sRjh4
         iV8w==
X-Gm-Message-State: APjAAAUutXxnfSt79xiS2v85Dbtu0CplXKUrSmsg9Hah1dSTfOhXcB4h
        Q3S8pQKocn9ku73PYIDLmficXukwqLKS1QUa43sLnQ==
X-Google-Smtp-Source: APXvYqyOETAaxBKPB3b4gkqLLgqu6c1bFglrJYRIWqbsUaZYYk8XOPI6B60VGm3PocjLIxkBV/PNXD2jTscehv1QwdY=
X-Received: by 2002:a05:6000:354:: with SMTP id e20mr40497544wre.17.1574171208528;
 Tue, 19 Nov 2019 05:46:48 -0800 (PST)
MIME-Version: 1.0
References: <000000000000dece03058f87bf11@google.com> <00000000000091301a058fabc3f1@google.com>
In-Reply-To: <00000000000091301a058fabc3f1@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 19 Nov 2019 14:46:37 +0100
Message-ID: <CAAeHK+zV2TXWtdmLj8Fjpfg9DPNNWrZXnbtLJ_bEhMJUjiua9Q@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in wdm_int_callback
To:     syzbot <syzbot+1a3765ef3c0d49d36a75@syzkaller.appspotmail.com>
Cc:     baijiaju1990@gmail.com, bigeasy@linutronix.de,
        Colin Ian King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 11:26 AM syzbot
<syzbot+1a3765ef3c0d49d36a75@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following crash on:
>
> HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=15b5018c600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
> dashboard link: https://syzkaller.appspot.com/bug?extid=1a3765ef3c0d49d36a75
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d9a9c2600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f1a18c600000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+1a3765ef3c0d49d36a75@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: use-after-free in wdm_int_callback+0x459/0x4c0
> drivers/usb/class/cdc-wdm.c:239
> Read of size 8 at addr ffff8881cf909690 by task kworker/1:2/1742
>
> CPU: 1 PID: 1742 Comm: kworker/1:2 Not tainted 5.3.0-rc2+ #25
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
>   wdm_int_callback+0x459/0x4c0 drivers/usb/class/cdc-wdm.c:239
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
> RSP: 0018:ffff8881d29feea8 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
> RAX: 0000000000000007 RBX: 0000000000000200 RCX: 0000000000000006
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff8881d3478844
> RBP: 0000000000000000 R08: ffff8881d3478000 R09: fffffbfff11acd91
> R10: fffffbfff11acd90 R11: ffffffff88d66c87 R12: 0000000000000061
> R13: dffffc0000000000 R14: ffffffff82909100 R15: ffffffff87077190
>   vprintk_emit+0x171/0x3e0 kernel/printk/printk.c:1986
>   dev_vprintk_emit+0x4fc/0x541 drivers/base/core.c:3232
>   dev_printk_emit+0xba/0xf1 drivers/base/core.c:3243
>   __dev_printk+0x1db/0x203 drivers/base/core.c:3255
>   _dev_err+0xd7/0x109 drivers/base/core.c:3298
>   usbvision_probe.cold+0x1c1/0x1e57
> drivers/media/usb/usbvision/usbvision-video.c:1442
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
> Allocated by task 1742:
>   save_stack+0x1b/0x80 mm/kasan/common.c:69
>   set_track mm/kasan/common.c:77 [inline]
>   __kasan_kmalloc mm/kasan/common.c:487 [inline]
>   __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:460
>   kmalloc include/linux/slab.h:552 [inline]
>   kzalloc include/linux/slab.h:748 [inline]
>   wdm_create+0x56/0x1720 drivers/usb/class/cdc-wdm.c:786
>   wdm_probe+0x220/0x2d0 drivers/usb/class/cdc-wdm.c:922
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
> Freed by task 1742:
>   save_stack+0x1b/0x80 mm/kasan/common.c:69
>   set_track mm/kasan/common.c:77 [inline]
>   __kasan_slab_free+0x130/0x180 mm/kasan/common.c:449
>   slab_free_hook mm/slub.c:1423 [inline]
>   slab_free_freelist_hook mm/slub.c:1470 [inline]
>   slab_free mm/slub.c:3012 [inline]
>   kfree+0xe4/0x2f0 mm/slub.c:3953
>   wdm_create+0x542/0x1720 drivers/usb/class/cdc-wdm.c:884
>   wdm_probe+0x220/0x2d0 drivers/usb/class/cdc-wdm.c:922
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
> The buggy address belongs to the object at ffff8881cf909680
>   which belongs to the cache kmalloc-1k of size 1024
> The buggy address is located 16 bytes inside of
>   1024-byte region [ffff8881cf909680, ffff8881cf909a80)
> The buggy address belongs to the page:
> page:ffffea00073e4200 refcount:1 mapcount:0 mapping:ffff8881da002280
> index:0x0 compound_mapcount: 0
> flags: 0x200000000010200(slab|head)
> raw: 0200000000010200 ffffea00073eb800 0000000200000002 ffff8881da002280
> raw: 0000000000000000 00000000000e000e 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   ffff8881cf909580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff8881cf909600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > ffff8881cf909680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                           ^
>   ffff8881cf909700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff8881cf909780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
>

#syz dup: WARNING in wdm_write/usb_submit_urb

https://syzkaller.appspot.com/bug?extid=d232cca6ec42c2edb3fc
