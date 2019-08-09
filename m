Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C4AC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501C32086D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xp6CIOgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406726AbfHISoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 14:44:22 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45656 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfHISoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:44:21 -0400
Received: by mail-qt1-f193.google.com with SMTP id f7so3897506qtq.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 11:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vEuL2EbGOVGMLn0kU1w+hsZbPb98Gl+S1kfZ1qfhHFA=;
        b=Xp6CIOgIk3oDjKzavwAl88b8bezmjuL6Genksw2JvgrEM8Z2cf2+0wHWBvZdyvc4OL
         9UUGuhUOBtJVBTWPPzwp5b9vdRV0qUlUW5YfH109IfVaaSbfsSM/76YeBCGflRe8lcTZ
         VmfX20SGtnC0CvSfpzGXdh/3aLHp4w5B0N81o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vEuL2EbGOVGMLn0kU1w+hsZbPb98Gl+S1kfZ1qfhHFA=;
        b=dYvWS7jwsy3atVb6lOYau0G7yNeOOHxSvG761JOsKjyynbFhXAb4s0C4Vklsp/7HsO
         5EON0lo3XLnWQ5Qkn+h/+xW4KAz1uudlgnJofE+Pk9xBn+4qetI8pam9WMnrjSDwQL8D
         GMxmeqJBrD9NzXy1dJuz2F+D2rdSc2P1WvVKoMOhIjcv595zhgh7TzDRj5DgFp3kdaV4
         UZYS+IOWSNcAdJy0N+kNOjezo2cyF2F18ZzgtaYqzqces4xhgK6q1EeQCdNoW6CExI8L
         ilcWued0HGgoBcfsV/vQXC58JuinYv0iaxtxiV9vRfY+MCaTE/gEdzxiXwTE7sQzaNnk
         nwVw==
X-Gm-Message-State: APjAAAVAZI73L6JFnk1aRLpjvuV/CAJ4BABqKI26gNhwOXKiSqbd7hAk
        GyUj7PaMu2RJc6BWqAxD3Y3r2nIzlos8VrVJcR4AOmqUuAI=
X-Google-Smtp-Source: APXvYqxaQ/rW76Rpp5DfBAiCzkWHmV5FzYB1SRSbWqo08gJ62yizkR/UqId4EXjNeD5gLNa2lhDCNxH6197a8vbXJUY=
X-Received: by 2002:ac8:768b:: with SMTP id g11mr19907262qtr.182.1565376260532;
 Fri, 09 Aug 2019 11:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000e3e6d7058fb2c624@google.com>
In-Reply-To: <000000000000e3e6d7058fb2c624@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Fri, 9 Aug 2019 11:44:09 -0700
Message-ID: <CACeCKafa5OkV=Mj0sBvr_oQeT5HBe9CRcT1g7BKqzECXv7ODvg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in usb_kill_urb
To:     syzbot <syzbot+22ae4e3b9fcc8a5c153a@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry for the resend, I was in HTML mode earlier :S)
Hi,

I'm trying to get up to speed on USB kernel code. Sounds like
dev->intf should have been set to NULL for the error path in
ld_usb_probe() ?

https://elixir.bootlin.com/linux/latest/source/drivers/usb/misc/ldusb.c#L666


On Fri, Aug 9, 2019 at 10:48 AM syzbot
<syzbot+22ae4e3b9fcc8a5c153a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=1799392c600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
> dashboard link: https://syzkaller.appspot.com/bug?extid=22ae4e3b9fcc8a5c153a
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1134c802600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13278c4a600000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+22ae4e3b9fcc8a5c153a@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: use-after-free in atomic_read
> include/asm-generic/atomic-instrumented.h:26 [inline]
> BUG: KASAN: use-after-free in usb_kill_urb drivers/usb/core/urb.c:695
> [inline]
> BUG: KASAN: use-after-free in usb_kill_urb+0x24b/0x2c0
> drivers/usb/core/urb.c:687
> Read of size 4 at addr ffff8881d635b110 by task syz-executor672/1999
>
> CPU: 1 PID: 1999 Comm: syz-executor672 Not tainted 5.3.0-rc2+ #25
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xca/0x13e lib/dump_stack.c:113
>   print_address_description+0x6a/0x32c mm/kasan/report.c:351
>   __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
>   kasan_report+0xe/0x12 mm/kasan/common.c:612
>   check_memory_region_inline mm/kasan/generic.c:185 [inline]
>   check_memory_region+0x128/0x190 mm/kasan/generic.c:192
>   atomic_read include/asm-generic/atomic-instrumented.h:26 [inline]
>   usb_kill_urb drivers/usb/core/urb.c:695 [inline]
>   usb_kill_urb+0x24b/0x2c0 drivers/usb/core/urb.c:687
>   ld_usb_abort_transfers+0xb7/0x1d0 drivers/usb/misc/ldusb.c:196
>   ld_usb_release+0x19f/0x400 drivers/usb/misc/ldusb.c:406
>   __fput+0x2d7/0x840 fs/file_table.c:280
>   task_work_run+0x13f/0x1c0 kernel/task_work.c:113
>   exit_task_work include/linux/task_work.h:22 [inline]
>   do_exit+0x8ef/0x2c50 kernel/exit.c:878
>   do_group_exit+0x125/0x340 kernel/exit.c:982
>   __do_sys_exit_group kernel/exit.c:993 [inline]
>   __se_sys_exit_group kernel/exit.c:991 [inline]
>   __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:991
>   do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x440418
> Code: 00 00 be 3c 00 00 00 eb 19 66 0f 1f 84 00 00 00 00 00 48 89 d7 89 f0
> 0f 05 48 3d 00 f0 ff ff 77 21 f4 48 89 d7 44 89 c0 0f 05 <48> 3d 00 f0 ff
> ff 76 e0 f7 d8 64 41 89 01 eb d8 0f 1f 84 00 00 00
> RSP: 002b:00007ffe884abf88 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440418
> RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
> RBP: 00000000004bff50 R08: 00000000000000e7 R09: ffffffffffffffd0
> R10: 0000000000000064 R11: 0000000000000246 R12: 0000000000000001
> R13: 00000000006d2180 R14: 0000000000000000 R15: 0000000000000000
>
> Allocated by task 22:
>   save_stack+0x1b/0x80 mm/kasan/common.c:69
>   set_track mm/kasan/common.c:77 [inline]
>   __kasan_kmalloc mm/kasan/common.c:487 [inline]
>   __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:460
>   kmalloc include/linux/slab.h:557 [inline]
>   usb_alloc_urb+0x65/0xb0 drivers/usb/core/urb.c:73
>   ld_usb_probe+0x3e1/0xa65 drivers/usb/misc/ldusb.c:708
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
> Freed by task 22:
>   save_stack+0x1b/0x80 mm/kasan/common.c:69
>   set_track mm/kasan/common.c:77 [inline]
>   __kasan_slab_free+0x130/0x180 mm/kasan/common.c:449
>   slab_free_hook mm/slub.c:1423 [inline]
>   slab_free_freelist_hook mm/slub.c:1470 [inline]
>   slab_free mm/slub.c:3012 [inline]
>   kfree+0xe4/0x2f0 mm/slub.c:3953
>   urb_destroy drivers/usb/core/urb.c:26 [inline]
>   kref_put include/linux/kref.h:65 [inline]
>   usb_free_urb.part.0+0x7a/0xc0 drivers/usb/core/urb.c:95
>   usb_free_urb+0x1b/0x30 drivers/usb/core/urb.c:94
>   ld_usb_delete+0x3f/0x130 drivers/usb/misc/ldusb.c:211
>   ld_usb_probe+0x728/0xa65 drivers/usb/misc/ldusb.c:744
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
> The buggy address belongs to the object at ffff8881d635b100
>   which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 16 bytes inside of
>   192-byte region [ffff8881d635b100, ffff8881d635b1c0)
> The buggy address belongs to the page:
> page:ffffea000758d6c0 refcount:1 mapcount:0 mapping:ffff8881da002a00
> index:0x0
> flags: 0x200000000000200(slab)
> raw: 0200000000000200 dead000000000100 dead000000000122 ffff8881da002a00
> raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   ffff8881d635b000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff8881d635b080: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> > ffff8881d635b100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                           ^
>   ffff8881d635b180: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>   ffff8881d635b200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
