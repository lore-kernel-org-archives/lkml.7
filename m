Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C69C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D19214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407574AbfHIRsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 13:48:09 -0400
Received: from mail-ot1-f71.google.com ([209.85.210.71]:34362 "EHLO
        mail-ot1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfHIRsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 13:48:08 -0400
Received: by mail-ot1-f71.google.com with SMTP id 20so26799017oty.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 10:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Dv3lcRts14elYy2XR0RTJzguJEgWKelMzwkTwXIETNM=;
        b=ZWxoRhTZeHnav39/1/xzD8yFBdh2Cpdeufc7mUJrJWJ8AkE1FJV82kNCSqYWhlfNc9
         xI7BvYyEwIySMnuGSq8Jg9IpLrym6rZbLzwzYgroIkMiiRYHRPTF6tBE9zQyKnEE+zxG
         8riLzs8aLV8Ude3jko8fCwmysE0aGFSw7t9D+kwtxj8xpSzvIgDwhj3XlzvMLb5viDcl
         U5L4LijQsb6uMubty7tVDKAiShERE35kjSZKaS8kd4Y0DiGA/XTBYzspaAJkX9+8s9+h
         nZxd7Gc1K6FHNcl9B+6U/6UioI67IzYuYb8tyt4l2E7ZSB/SgIB+wTR3rNDTd2EAHIXq
         ILdA==
X-Gm-Message-State: APjAAAXy5EZFMq85U+pMMTzkd0Vd3unkB9ZBI5sQPWOJMJGdbvW/LUae
        FedslogSrfVmDFdCbD2zQtJfE696yJ8Dy4ffwNN5+N0Sn80A
X-Google-Smtp-Source: APXvYqx8KEmZlQMU9Zyzx/P0OH2b8F20MfKqYM/W1R2KLgf3JkrnyJLLjaM3tPIyTYI4Z4TuOlnZ4gDSN02j/GBunOPyi+Dkh8mm
MIME-Version: 1.0
X-Received: by 2002:a5d:9749:: with SMTP id c9mr12997576ioo.258.1565372887324;
 Fri, 09 Aug 2019 10:48:07 -0700 (PDT)
Date:   Fri, 09 Aug 2019 10:48:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e3e6d7058fb2c624@google.com>
Subject: KASAN: use-after-free Read in usb_kill_urb
From:   syzbot <syzbot+22ae4e3b9fcc8a5c153a@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1799392c600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
dashboard link: https://syzkaller.appspot.com/bug?extid=22ae4e3b9fcc8a5c153a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1134c802600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13278c4a600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+22ae4e3b9fcc8a5c153a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in atomic_read  
include/asm-generic/atomic-instrumented.h:26 [inline]
BUG: KASAN: use-after-free in usb_kill_urb drivers/usb/core/urb.c:695  
[inline]
BUG: KASAN: use-after-free in usb_kill_urb+0x24b/0x2c0  
drivers/usb/core/urb.c:687
Read of size 4 at addr ffff8881d635b110 by task syz-executor672/1999

CPU: 1 PID: 1999 Comm: syz-executor672 Not tainted 5.3.0-rc2+ #25
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x6a/0x32c mm/kasan/report.c:351
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
  kasan_report+0xe/0x12 mm/kasan/common.c:612
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x128/0x190 mm/kasan/generic.c:192
  atomic_read include/asm-generic/atomic-instrumented.h:26 [inline]
  usb_kill_urb drivers/usb/core/urb.c:695 [inline]
  usb_kill_urb+0x24b/0x2c0 drivers/usb/core/urb.c:687
  ld_usb_abort_transfers+0xb7/0x1d0 drivers/usb/misc/ldusb.c:196
  ld_usb_release+0x19f/0x400 drivers/usb/misc/ldusb.c:406
  __fput+0x2d7/0x840 fs/file_table.c:280
  task_work_run+0x13f/0x1c0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x8ef/0x2c50 kernel/exit.c:878
  do_group_exit+0x125/0x340 kernel/exit.c:982
  __do_sys_exit_group kernel/exit.c:993 [inline]
  __se_sys_exit_group kernel/exit.c:991 [inline]
  __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:991
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440418
Code: 00 00 be 3c 00 00 00 eb 19 66 0f 1f 84 00 00 00 00 00 48 89 d7 89 f0  
0f 05 48 3d 00 f0 ff ff 77 21 f4 48 89 d7 44 89 c0 0f 05 <48> 3d 00 f0 ff  
ff 76 e0 f7 d8 64 41 89 01 eb d8 0f 1f 84 00 00 00
RSP: 002b:00007ffe884abf88 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440418
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004bff50 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000000000064 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d2180 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 22:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:487 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:460
  kmalloc include/linux/slab.h:557 [inline]
  usb_alloc_urb+0x65/0xb0 drivers/usb/core/urb.c:73
  ld_usb_probe+0x3e1/0xa65 drivers/usb/misc/ldusb.c:708
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
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 22:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:449
  slab_free_hook mm/slub.c:1423 [inline]
  slab_free_freelist_hook mm/slub.c:1470 [inline]
  slab_free mm/slub.c:3012 [inline]
  kfree+0xe4/0x2f0 mm/slub.c:3953
  urb_destroy drivers/usb/core/urb.c:26 [inline]
  kref_put include/linux/kref.h:65 [inline]
  usb_free_urb.part.0+0x7a/0xc0 drivers/usb/core/urb.c:95
  usb_free_urb+0x1b/0x30 drivers/usb/core/urb.c:94
  ld_usb_delete+0x3f/0x130 drivers/usb/misc/ldusb.c:211
  ld_usb_probe+0x728/0xa65 drivers/usb/misc/ldusb.c:744
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
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8881d635b100
  which belongs to the cache kmalloc-192 of size 192
The buggy address is located 16 bytes inside of
  192-byte region [ffff8881d635b100, ffff8881d635b1c0)
The buggy address belongs to the page:
page:ffffea000758d6c0 refcount:1 mapcount:0 mapping:ffff8881da002a00  
index:0x0
flags: 0x200000000000200(slab)
raw: 0200000000000200 dead000000000100 dead000000000122 ffff8881da002a00
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d635b000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d635b080: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff8881d635b100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                          ^
  ffff8881d635b180: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8881d635b200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
