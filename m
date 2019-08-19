Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFA2C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859692082A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfHSOsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:48:13 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:51171 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbfHSOsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:48:09 -0400
Received: by mail-io1-f69.google.com with SMTP id l7so4291439ion.17
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 07:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Qjo/GFDuxdjJVvM5BrTeperU99qH1M/Y6Ls1Sq0DXUY=;
        b=G7t0r4Kh5vjp+HCcTsAg/q3Yn+tmuJ8rjOWHUf821ckjUMZvgDydRQV5x58F4V9+Gp
         jIiSaGsiWEjJll3DVUtV7jKYw/2wqk2xFJ8Sszig0dAgj9w+nFCMRw710GNhVQBYnS13
         dvNd8oA/EkKCtspcSSeinKJmkvZFvbuQ2u5verSzVQ2Z4pjMTtVyD6hmhHQbNaUdK9Je
         dLM6Alczgdf1in2kbSYQVeiBiBOolep5aIFLX/c6TLMHA1M6e65MFdL2cxM6lPu/gINi
         +FwWZ7tkO2hDOKhpR/6iYyWXLdpXvFXlCHHZp40xX9fpqIq8BwFjV2yI1H4+kMrKfr5j
         ddKA==
X-Gm-Message-State: APjAAAV8FWigreQR13flTkYSy6+SHnroUt3kumv5999nVSf3MGRtu4ER
        dzJpQOxCxB7sdQjrrsWApSXa6lwPXQeFKfcZEOUHzjcqwz2Z
X-Google-Smtp-Source: APXvYqydgi5dT/FOiwFLEaKbmKKhilyrsphpg0m9pInOYBzYxLwltJrgGVFbj6P9l0h2Ty6XWuKhJ52gxiaw1Zcp6f9iGJAcbsfj
MIME-Version: 1.0
X-Received: by 2002:a6b:3943:: with SMTP id g64mr20051636ioa.225.1566226088209;
 Mon, 19 Aug 2019 07:48:08 -0700 (PDT)
Date:   Mon, 19 Aug 2019 07:48:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a039300590796dc4@google.com>
Subject: KASAN: use-after-free Read in iowarrior_callback
From:   syzbot <syzbot+1c7a8a0c02f8b83f3a67@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        oneukum@suse.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d0847550 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=11605772600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dbc9c80cc095da19
dashboard link: https://syzkaller.appspot.com/bug?extid=1c7a8a0c02f8b83f3a67
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1c7a8a0c02f8b83f3a67@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in iowarrior_callback.cold+0x4f/0x51  
drivers/usb/misc/iowarrior.c:208
Read of size 8 at addr ffff8881d56b5208 by task udevd/4692

CPU: 1 PID: 4692 Comm: udevd Not tainted 5.3.0-rc4+ #26
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x6a/0x32c mm/kasan/report.c:351
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
  kasan_report+0xe/0x12 mm/kasan/common.c:612
  iowarrior_callback.cold+0x4f/0x51 drivers/usb/misc/iowarrior.c:208
  __usb_hcd_giveback_urb+0x1f2/0x470 drivers/usb/core/hcd.c:1657
  usb_hcd_giveback_urb+0x368/0x420 drivers/usb/core/hcd.c:1722
  dummy_timer+0x120f/0x2fa2 drivers/usb/gadget/udc/dummy_hcd.c:1965
  call_timer_fn+0x179/0x650 kernel/time/timer.c:1322
  expire_timers kernel/time/timer.c:1366 [inline]
  __run_timers kernel/time/timer.c:1685 [inline]
  __run_timers kernel/time/timer.c:1653 [inline]
  run_timer_softirq+0x5cc/0x14b0 kernel/time/timer.c:1698
  __do_softirq+0x221/0x912 kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x178/0x1a0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:537 [inline]
  smp_apic_timer_interrupt+0x12f/0x500 arch/x86/kernel/apic/apic.c:1095
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
  </IRQ>
RIP: 0010:__sanitizer_cov_trace_const_cmp1+0x0/0x20 kernel/kcov.c:247
Code: 66 2e 0f 1f 84 00 00 00 00 00 48 8b 0c 24 48 89 f2 48 89 fe bf 06 00  
00 00 e9 2c ff ff ff 66 90 66 2e 0f 1f 84 00 00 00 00 00 <48> 8b 0c 24 40  
0f b6 d6 40 0f b6 f7 bf 01 00 00 00 e9 0a ff ff ff
RSP: 0018:ffff8881c9397b20 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: 00000000c9397c01 RBX: ffff8881c9397c00 RCX: ffffffff816a906f
RDX: 0000000000000000 RSI: 00000000c9397c01 RDI: 0000000000000000
RBP: 00000000c9397c01 R08: ffff8881b05fc800 R09: ffffed103b0df2a5
R10: ffffed103b0df2a4 R11: ffff8881d86f9523 R12: ffff8881c9397c08
R13: ffff8881c9397c38 R14: ffff8881d86f94a0 R15: ffff8881c9397c40
  unlazy_walk+0x116/0x550 fs/namei.c:675
  complete_walk+0xc6/0x240 fs/namei.c:788
  path_parentat.isra.0+0x8c/0x160 fs/namei.c:2366
  filename_parentat.isra.0+0x19c/0x410 fs/namei.c:2386
  do_renameat2+0x193/0xbb0 fs/namei.c:4545
  __do_sys_rename fs/namei.c:4673 [inline]
  __se_sys_rename fs/namei.c:4671 [inline]
  __x64_sys_rename+0x5d/0x80 fs/namei.c:4671
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7fb52199e527
Code: 32 00 64 83 38 15 74 07 b8 ff ff ff ff 5b c3 48 89 df e8 1c c1 07 00  
85 c0 75 ed 31 c0 eb d3 90 90 90 90 b8 52 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 01 c3 48 8b 0d e1 f8 32 00 31 d2 48 29 c2 64
RSP: 002b:00007ffe94095c28 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb52199e527
RDX: 00007fb521ccfe98 RSI: 00007ffe94095c60 RDI: 00007ffe94096060
RBP: 000000000127daa0 R08: 00007fb5223117a0 R09: 0000000001278560
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000127aec0
R13: 000000000126a250 R14: 00007ffe94095c60 R15: 0000000000000001

Allocated by task 12:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:487 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:460
  kmalloc include/linux/slab.h:552 [inline]
  kzalloc include/linux/slab.h:748 [inline]
  iowarrior_probe+0x7a/0x10b2 drivers/usb/misc/iowarrior.c:753
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2165
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2165
  usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 12:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:449
  slab_free_hook mm/slub.c:1423 [inline]
  slab_free_freelist_hook mm/slub.c:1474 [inline]
  slab_free mm/slub.c:3016 [inline]
  kfree+0xe4/0x2f0 mm/slub.c:3957
  iowarrior_delete drivers/usb/misc/iowarrior.c:246 [inline]
  iowarrior_probe+0xbb4/0x10b2 drivers/usb/misc/iowarrior.c:852
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2165
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2165
  usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8881d56b5180
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 136 bytes inside of
  512-byte region [ffff8881d56b5180, ffff8881d56b5380)
The buggy address belongs to the page:
page:ffffea000755ad00 refcount:1 mapcount:0 mapping:ffff8881da002500  
index:0x0 compound_mapcount: 0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 ffffea000757ad00 0000000300000003 ffff8881da002500
raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d56b5100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881d56b5180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881d56b5200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                       ^
  ffff8881d56b5280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d56b5300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
