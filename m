Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA16C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692D621E70
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388232AbfHGO2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:28:08 -0400
Received: from mail-ot1-f69.google.com ([209.85.210.69]:53642 "EHLO
        mail-ot1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730060AbfHGO2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:28:06 -0400
Received: by mail-ot1-f69.google.com with SMTP id d13so55084453oth.20
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 07:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nTpkYGDn4Bl3q+QTgKy5GvIk30dvkO15r6mMytpJlPM=;
        b=PN5wJDy/+CDYLqn/s9Fq79bHoD8WADtztj3QS4oPlivU2yo9vkZk31mjafBReWIq3K
         5BgWSgsmAqyIyg0BC8Swo4LN62gdBHd22CH2EH5hnrrfDLBV5GxbpXaFK2PIDcpXQwiL
         KePy73S8Qx4OCP01hz/U9bahH8+6DOq4nr/PWDOxa6jFTVy2BH0kgbEtjii0csEC6X+K
         4kKahi+9sar6+O5v6D9uhD43JSWixiVu8aF2c1+9jyk/FHw6hauwrURJo+DwK9jUi5HA
         RkQNoFXIQPXnDYBTP4dOmFPvsoP3tDT7MDogO9lBR9cy6B9GC67s4UjMDFgNumoqaeDq
         Vgpw==
X-Gm-Message-State: APjAAAWtlM01phvnTSYBtZgAKCFWOi6OUpOZhk8gLNrIdj3VAeYs6pHP
        wSyrguWD0bHFvO7q8VfFPs/eNaI1EG+jwjVx21oW7xIzXWtv
X-Google-Smtp-Source: APXvYqxndjf3fZsYwT4yi7J2cZpkVBc2/FOlkjZP/oOuP0WviN5WRchP6AzsLS9ufU+ohl/wInYROmMmRc8pU4URqEV7Lt/MF0CM
MIME-Version: 1.0
X-Received: by 2002:a02:ca19:: with SMTP id i25mr10528250jak.6.1565188085957;
 Wed, 07 Aug 2019 07:28:05 -0700 (PDT)
Date:   Wed, 07 Aug 2019 07:28:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dece03058f87bf11@google.com>
Subject: KASAN: use-after-free Read in wdm_int_callback
From:   syzbot <syzbot+1a3765ef3c0d49d36a75@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, baijiaju1990@gmail.com,
        bigeasy@linutronix.de, colin.king@canonical.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=162e6352600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
dashboard link: https://syzkaller.appspot.com/bug?extid=1a3765ef3c0d49d36a75
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1a3765ef3c0d49d36a75@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in wdm_int_callback+0x459/0x4c0  
drivers/usb/class/cdc-wdm.c:239
Read of size 8 at addr ffff8881cf42e410 by task udevd/6344

CPU: 0 PID: 6344 Comm: udevd Not tainted 5.3.0-rc2+ #25
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x6a/0x32c mm/kasan/report.c:351
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
  kasan_report+0xe/0x12 mm/kasan/common.c:612
  wdm_int_callback+0x459/0x4c0 drivers/usb/class/cdc-wdm.c:239
  __usb_hcd_giveback_urb+0x1f2/0x470 drivers/usb/core/hcd.c:1757
  usb_hcd_giveback_urb+0x368/0x420 drivers/usb/core/hcd.c:1822
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
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:828
  </IRQ>
RIP: 0010:rb_prev+0xbd/0x130 lib/rbtree.c:550
Code: 75 20 48 89 d8 48 c1 e8 03 42 80 3c 28 00 75 67 4c 8b 23 48 89 dd 4c  
89 e3 48 83 e3 fc 48 89 d8 75 c8 48 83 c4 08 5b 5d 41 5c <41> 5d c3 48 89  
d0 48 8d 78 08 48 89 fa 48 c1 ea 03 80 3c 1a 00 75
RSP: 0018:ffff8881a447fba0 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: ffff8881d6651920 RBX: 0000000000000004 RCX: ffffffff812666d0
RDX: 1ffff1103acca326 RSI: ffffffff815ab46e RDI: ffff8881d6651930
RBP: ffff8881d6651a20 R08: ffff8881cfdce000 R09: ffffed103a910587
R10: ffffed103a910586 R11: ffff8881d4882c33 R12: 0000000000000005
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
  browse_rb mm/mmap.c:365 [inline]
  validate_mm+0x3dd/0x610 mm/mmap.c:418
  mmap_region+0xfbc/0x13c0 mm/mmap.c:1811
  do_mmap+0x831/0x1070 mm/mmap.c:1561
  do_mmap_pgoff include/linux/mm.h:2374 [inline]
  vm_mmap_pgoff+0x195/0x1f0 mm/util.c:391
  ksys_mmap_pgoff+0xd8/0x5b0 mm/mmap.c:1611
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f2c0f046d0a
Code: b8 ff ff ff ff e9 fa fe ff ff 48 63 fb b8 03 00 00 00 0f 05 b8 ff ff  
ff ff e9 e6 fe ff ff 90 90 49 89 ca b8 09 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 01 c3 48 8b 0d fe c0 2a 00 31 d2 48 29 c2 64
RSP: 002b:00007ffe7106e018 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 000000000137e6b0 RCX: 00007f2c0f046d0a
RDX: 0000000000000003 RSI: 0000000000001000 RDI: 0000000000000000
RBP: 0000000000001000 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000420724
R13: 0000000000000002 R14: 0000000000420724 R15: 0000000000420724

Allocated by task 21732:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:487 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:460
  kmalloc include/linux/slab.h:552 [inline]
  kzalloc include/linux/slab.h:748 [inline]
  wdm_create+0x56/0x1720 drivers/usb/class/cdc-wdm.c:786
  wdm_probe+0x220/0x2d0 drivers/usb/class/cdc-wdm.c:922
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x650 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:882
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2114
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x650 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:882
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2114
  usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x7ab/0xe20 kernel/workqueue.c:2417
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 21732:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:449
  slab_free_hook mm/slub.c:1423 [inline]
  slab_free_freelist_hook mm/slub.c:1470 [inline]
  slab_free mm/slub.c:3012 [inline]
  kfree+0xe4/0x2f0 mm/slub.c:3953
  wdm_create+0x542/0x1720 drivers/usb/class/cdc-wdm.c:884
  wdm_probe+0x220/0x2d0 drivers/usb/class/cdc-wdm.c:922
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x650 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:882
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2114
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x650 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:882
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2114
  usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x7ab/0xe20 kernel/workqueue.c:2417
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8881cf42e400
  which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 16 bytes inside of
  1024-byte region [ffff8881cf42e400, ffff8881cf42e800)
The buggy address belongs to the page:
page:ffffea00073d0b00 refcount:1 mapcount:0 mapping:ffff8881da002280  
index:0x0 compound_mapcount: 0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 0000000000000000 0000000600000001 ffff8881da002280
raw: 0000000000000000 00000000000e000e 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881cf42e300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881cf42e380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8881cf42e400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                          ^
  ffff8881cf42e480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881cf42e500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
