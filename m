Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BECC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67DCF2332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kQGeGiJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbfHURBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 13:01:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40748 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729744AbfHURBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:01:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id w16so1817313pfn.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 10:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFTcIsbAc0mFNb5a66/YP+GL507M7f/jgx26TK+bdAY=;
        b=kQGeGiJ42UTYWMbw/ARNI9gZAVajkzTfv3zh3VmKft0lm9Bl8nOMGGXy45hJ8KNX8G
         K7xGDeYH39S8nZcYMO/o0RExd1R6svmCLxFumAzzaw8NpavxGXHeHVui5BYH+5gA9zUd
         JdnQgNVr4rbFsW6IwxZlvO4O/r8jDeGNfvbCZdLtqYptRCV+RS8FG9aqFtgeUTjC6R4o
         gIJPmJAeeSsO4wJY1WDwXmWF3GWTouDr0cfpUTynN1eG9vSQ73P4X1iCei0CzbAsvhvy
         C2J4IBk5JfQgiPhTJjKAtJNTYeywPi8W3EkKkCFMhWPuXHzpBVuPR5DVapi3cqHY+9kF
         Gkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFTcIsbAc0mFNb5a66/YP+GL507M7f/jgx26TK+bdAY=;
        b=OmmiqF4mw+c4VUqlyBoAdyU0AfQk/a4PfLA1MZiI2Wfc0TxgoVFYU7AzBbs5ZoJe0e
         xqV20rkeyckilJLtS2yzF9PQKMIXhSYGjSDJUMgSS845fp5T/aUPWhztCMDr+ehJbc+k
         4uQ9Yh8adCMB3AtQBJjpQnw+U5U0C8GD0blPREJ/scCSf4NuWqgPoBE0VjD2uDygqt+Z
         OyZG3mMbN1EHFhGEmRJrOefX+dEg+xFKHmjM7ALjiG9uEzf6MIHeBO4Lfg/D4yT+amhT
         JEAhBwcYCWBcUJVjMLlhjauKNCuNFqpleTeKAeWJs+4hRzrIdaWzxLyhrFVvRs23rTze
         LCAg==
X-Gm-Message-State: APjAAAW7tewPYgYoyn+IdopBVmudKCtpcxIQ/qQ5YBoKTiOGuQgGz9Q0
        MtHPA0xnX2j69CSkhzXAD3w15DyJQTMY0BjYxqIUZQ==
X-Google-Smtp-Source: APXvYqzbTDAEz4+T61GcpYGPK3sbA2Om11jQRm/93gfkEXyxMz4twt/kWWE+HIDd83SG79ZZooYuVidxanp1Ixi1Cpg=
X-Received: by 2002:a17:90a:c20f:: with SMTP id e15mr921784pjt.123.1566406876254;
 Wed, 21 Aug 2019 10:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000da58ed058f72a7f1@google.com>
In-Reply-To: <000000000000da58ed058f72a7f1@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 21 Aug 2019 19:01:04 +0200
Message-ID: <CAAeHK+z8zWFxXJTBD=2-MhpHR+byD_8n3SBqeWz=JH_qm3TUUQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in hiddev_ioctl
To:     syzbot <syzbot+5e9ed50a49eb77802d0e@syzkaller.appspotmail.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 3:18 PM syzbot
<syzbot+5e9ed50a49eb77802d0e@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=1732258a600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
> dashboard link: https://syzkaller.appspot.com/bug?extid=5e9ed50a49eb77802d0e
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+5e9ed50a49eb77802d0e@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: use-after-free in __mutex_lock_common
> kernel/locking/mutex.c:912 [inline]
> BUG: KASAN: use-after-free in __mutex_lock+0xf23/0x1360
> kernel/locking/mutex.c:1077
> Read of size 8 at addr ffff8881cf955468 by task syz-executor.1/19529
>
> CPU: 0 PID: 19529 Comm: syz-executor.1 Not tainted 5.3.0-rc2+ #25
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0xca/0x13e lib/dump_stack.c:113
>   print_address_description+0x6a/0x32c mm/kasan/report.c:351
>   __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
>   kasan_report+0xe/0x12 mm/kasan/common.c:612
>   __mutex_lock_common kernel/locking/mutex.c:912 [inline]
>   __mutex_lock+0xf23/0x1360 kernel/locking/mutex.c:1077
>   hiddev_ioctl+0xea/0x1550 drivers/hid/usbhid/hiddev.c:607
>   vfs_ioctl fs/ioctl.c:46 [inline]
>   file_ioctl fs/ioctl.c:509 [inline]
>   do_vfs_ioctl+0xd2d/0x1330 fs/ioctl.c:696
>   ksys_ioctl+0x9b/0xc0 fs/ioctl.c:713
>   __do_sys_ioctl fs/ioctl.c:720 [inline]
>   __se_sys_ioctl fs/ioctl.c:718 [inline]
>   __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:718
>   do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x459829
> Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f0ec5dd7c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459829
> RDX: 0000000020000380 RSI: 0000000081044804 RDI: 0000000000000005
> RBP: 000000000075c070 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0ec5dd86d4
> R13: 00000000004c2249 R14: 00000000004d55f8 R15: 00000000ffffffff
>
> Allocated by task 2777:
>   save_stack+0x1b/0x80 mm/kasan/common.c:69
>   set_track mm/kasan/common.c:77 [inline]
>   __kasan_kmalloc mm/kasan/common.c:487 [inline]
>   __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:460
>   kmalloc include/linux/slab.h:552 [inline]
>   kzalloc include/linux/slab.h:748 [inline]
>   hiddev_connect+0x242/0x5b0 drivers/hid/usbhid/hiddev.c:900
>   hid_connect+0x239/0xbb0 drivers/hid/hid-core.c:1882
>   hid_hw_start drivers/hid/hid-core.c:1981 [inline]
>   hid_hw_start+0xa2/0x130 drivers/hid/hid-core.c:1972
>   appleir_probe+0x13e/0x1a0 drivers/hid/hid-appleir.c:308
>   hid_device_probe+0x2be/0x3f0 drivers/hid/hid-core.c:2209
>   really_probe+0x281/0x650 drivers/base/dd.c:548
>   driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
>   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
>   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
>   __device_attach+0x217/0x360 drivers/base/dd.c:882
>   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
>   device_add+0xae6/0x16f0 drivers/base/core.c:2114
>   hid_add_device+0x33c/0x990 drivers/hid/hid-core.c:2365
>   usbhid_probe+0xa81/0xfa0 drivers/hid/usbhid/hid-core.c:1386
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
>   process_scheduled_works kernel/workqueue.c:2331 [inline]
>   worker_thread+0x7ab/0xe20 kernel/workqueue.c:2417
>   kthread+0x318/0x420 kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
>
> Freed by task 2777:
>   save_stack+0x1b/0x80 mm/kasan/common.c:69
>   set_track mm/kasan/common.c:77 [inline]
>   __kasan_slab_free+0x130/0x180 mm/kasan/common.c:449
>   slab_free_hook mm/slub.c:1423 [inline]
>   slab_free_freelist_hook mm/slub.c:1470 [inline]
>   slab_free mm/slub.c:3012 [inline]
>   kfree+0xe4/0x2f0 mm/slub.c:3953
>   hiddev_connect.cold+0x45/0x5c drivers/hid/usbhid/hiddev.c:914
>   hid_connect+0x239/0xbb0 drivers/hid/hid-core.c:1882
>   hid_hw_start drivers/hid/hid-core.c:1981 [inline]
>   hid_hw_start+0xa2/0x130 drivers/hid/hid-core.c:1972
>   appleir_probe+0x13e/0x1a0 drivers/hid/hid-appleir.c:308
>   hid_device_probe+0x2be/0x3f0 drivers/hid/hid-core.c:2209
>   really_probe+0x281/0x650 drivers/base/dd.c:548
>   driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
>   __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
>   bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
>   __device_attach+0x217/0x360 drivers/base/dd.c:882
>   bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
>   device_add+0xae6/0x16f0 drivers/base/core.c:2114
>   hid_add_device+0x33c/0x990 drivers/hid/hid-core.c:2365
>   usbhid_probe+0xa81/0xfa0 drivers/hid/usbhid/hid-core.c:1386
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
>   process_scheduled_works kernel/workqueue.c:2331 [inline]
>   worker_thread+0x7ab/0xe20 kernel/workqueue.c:2417
>   kthread+0x318/0x420 kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
>
> The buggy address belongs to the object at ffff8881cf955400
>   which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 104 bytes inside of
>   512-byte region [ffff8881cf955400, ffff8881cf955600)
> The buggy address belongs to the page:
> page:ffffea00073e5500 refcount:1 mapcount:0 mapping:ffff8881da002500
> index:0x0 compound_mapcount: 0
> flags: 0x200000000010200(slab|head)
> raw: 0200000000010200 ffffea0007659680 0000000600000003 ffff8881da002500
> raw: 0000000000000000 00000000000c000c 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   ffff8881cf955300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff8881cf955380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > ffff8881cf955400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                                            ^
>   ffff8881cf955480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff8881cf955500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

Looks like the same bug:

#syz dup: general protection fault in __pm_runtime_resume
