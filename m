Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FED0C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484392815B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfFCLlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 07:41:11 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:55059 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbfFCLlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 07:41:07 -0400
Received: by mail-io1-f72.google.com with SMTP id n8so2941639ioo.21
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 04:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=llk4KQSR4weJE8Tlb35uxLSikoiZt/2LrtzUUWH3cm4=;
        b=Tv7MaJtFgRpSwgaSXOHvWc0zgkzOQLLok45KUTDX79LsJqidWVtrW/vmJuXvH8AjEB
         DD/ObHDKZhV0OryMZP9NJ36BEtYnybLXswVFoSrl3Nqit5wHkxO4OvlyGx+P9Xm+BjkN
         OQ3vkBDBabacDyZo7cNKLQ/NNyMcOvCPxWya0VV9Klad0ecw6m/KQ6SHLy5knrzoU8LN
         t2ZM9WRqhIHWHn/4n5i7xC0GVP3Gm1MrX1SXt5RiEAaUa1pc5Uag3uOSrxyTR5NW33GP
         xdverKiQA7YACKLQGzJWnb8YupLxvO5IgUwZypzWqhi1Crr5j2qa5SG+zS2+S4jfli5p
         171Q==
X-Gm-Message-State: APjAAAUPTpRp70KFFigXNy0cqwGBw84VvlfwUis7NWkGrE46xXb3p/11
        pAdDMShGgKPgSpD10v0tzT6Nt+vhn2chWANX0gLjl1EECoEl
X-Google-Smtp-Source: APXvYqwbeDl84W2sbUqtg7Lcx8Foi0ow7SuhxjJ40/O6utVeNE9tSTMCWCo8vRQmOtInx8kubiHVmcg8GB2a5npFH/72Kehpjvmm
MIME-Version: 1.0
X-Received: by 2002:a05:660c:107:: with SMTP id w7mr15548865itj.59.1559562066462;
 Mon, 03 Jun 2019 04:41:06 -0700 (PDT)
Date:   Mon, 03 Jun 2019 04:41:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa11f3058a69d67b@google.com>
Subject: KASAN: use-after-free Read in device_del
From:   syzbot <syzbot+93f2f45b19519b289613@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    69bbe8c7 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1684d87ca00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=193d8457178b3229
dashboard link: https://syzkaller.appspot.com/bug?extid=93f2f45b19519b289613
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+93f2f45b19519b289613@syzkaller.appspotmail.com

  worker_thread+0x96/0xe20 kernel/workqueue.c:2414
  kthread+0x30b/0x410 kernel/kthread.c:254
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
hso 3-1:0.2: Failed to find BULK IN ep
==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x3a5d/0x5340  
kernel/locking/lockdep.c:3664
Read of size 8 at addr ffff8881d98a4d60 by task kworker/0:0/5

CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.2.0-rc1+ #10
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x67/0x231 mm/kasan/report.c:188
  __kasan_report.cold+0x1a/0x32 mm/kasan/report.c:317
  kasan_report+0xe/0x20 mm/kasan/common.c:614
  __lock_acquire+0x3a5d/0x5340 kernel/locking/lockdep.c:3664
  lock_acquire+0x100/0x2b0 kernel/locking/lockdep.c:4302
  __mutex_lock_common kernel/locking/mutex.c:925 [inline]
  __mutex_lock+0xf9/0x12b0 kernel/locking/mutex.c:1072
  device_lock include/linux/device.h:1207 [inline]
  device_del+0xa2/0xb80 drivers/base/core.c:2240
  device_unregister drivers/base/core.c:2306 [inline]
  device_destroy+0x90/0xd0 drivers/base/core.c:2864
  tty_unregister_device+0x7e/0x1a0 drivers/tty/tty_io.c:3189
  hso_serial_tty_unregister drivers/net/usb/hso.c:2245 [inline]
  hso_create_bulk_serial_device drivers/net/usb/hso.c:2682 [inline]
  hso_probe.cold+0xc8/0x120 drivers/net/usb/hso.c:2948
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x660 drivers/base/dd.c:509
  driver_probe_device+0x104/0x210 drivers/base/dd.c:670
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:777
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:843
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2111
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x660 drivers/base/dd.c:509
  driver_probe_device+0x104/0x210 drivers/base/dd.c:670
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:777
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:843
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2111
  usb_new_device.cold+0x8c1/0x1016 drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x1ada/0x3590 drivers/usb/core/hub.c:5432
  process_one_work+0x905/0x1570 kernel/workqueue.c:2268
  worker_thread+0x96/0xe20 kernel/workqueue.c:2414
  kthread+0x30b/0x410 kernel/kthread.c:254
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Allocated by task 3910:
  save_stack+0x1b/0x80 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_kmalloc mm/kasan/common.c:489 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:462
  kmalloc include/linux/slab.h:547 [inline]
  kzalloc include/linux/slab.h:742 [inline]
  tty_register_device_attr+0x1b6/0x6f0 drivers/tty/tty_io.c:3128
  hso_serial_common_create+0x113/0x710 drivers/net/usb/hso.c:2279
  hso_create_bulk_serial_device drivers/net/usb/hso.c:2652 [inline]
  hso_probe+0xc93/0x1a46 drivers/net/usb/hso.c:2948
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x660 drivers/base/dd.c:509
  driver_probe_device+0x104/0x210 drivers/base/dd.c:670
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:777
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:843
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2111
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x660 drivers/base/dd.c:509
  driver_probe_device+0x104/0x210 drivers/base/dd.c:670
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:777
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:843
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2111
  usb_new_device.cold+0x8c1/0x1016 drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x1ada/0x3590 drivers/usb/core/hub.c:5432
  process_one_work+0x905/0x1570 kernel/workqueue.c:2268
  process_scheduled_works kernel/workqueue.c:2330 [inline]
  worker_thread+0x7ab/0xe20 kernel/workqueue.c:2416
  kthread+0x30b/0x410 kernel/kthread.c:254
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 3910:
  save_stack+0x1b/0x80 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:451
  slab_free_hook mm/slub.c:1421 [inline]
  slab_free_freelist_hook mm/slub.c:1448 [inline]
  slab_free mm/slub.c:2994 [inline]
  kfree+0xd7/0x280 mm/slub.c:3949
  device_release+0x71/0x200 drivers/base/core.c:1064
  kobject_cleanup lib/kobject.c:691 [inline]
  kobject_release lib/kobject.c:720 [inline]
  kref_put include/linux/kref.h:67 [inline]
  kobject_put+0x171/0x280 lib/kobject.c:737
  put_device drivers/base/core.c:2210 [inline]
  device_unregister drivers/base/core.c:2307 [inline]
  device_destroy+0x98/0xd0 drivers/base/core.c:2864
  tty_unregister_device+0x7e/0x1a0 drivers/tty/tty_io.c:3189
  hso_serial_tty_unregister drivers/net/usb/hso.c:2245 [inline]
  hso_create_bulk_serial_device drivers/net/usb/hso.c:2682 [inline]
  hso_probe.cold+0xc8/0x120 drivers/net/usb/hso.c:2948
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x660 drivers/base/dd.c:509
  driver_probe_device+0x104/0x210 drivers/base/dd.c:670
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:777
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:843
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2111
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x660 drivers/base/dd.c:509
  driver_probe_device+0x104/0x210 drivers/base/dd.c:670
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:777
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:843
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2111
  usb_new_device.cold+0x8c1/0x1016 drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x1ada/0x3590 drivers/usb/core/hub.c:5432
  process_one_work+0x905/0x1570 kernel/workqueue.c:2268
  process_scheduled_works kernel/workqueue.c:2330 [inline]
  worker_thread+0x7ab/0xe20 kernel/workqueue.c:2416
  kthread+0x30b/0x410 kernel/kthread.c:254
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8881d98a4c80
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 224 bytes inside of
  2048-byte region [ffff8881d98a4c80, ffff8881d98a5480)
The buggy address belongs to the page:
page:ffffea0007662800 refcount:1 mapcount:0 mapping:ffff8881dac02800  
index:0x0 compound_mapcount: 0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 dead000000000100 dead000000000200 ffff8881dac02800
raw: 0000000000000000 00000000800f000f 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d98a4c00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881d98a4c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881d98a4d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                        ^
  ffff8881d98a4d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d98a4e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
