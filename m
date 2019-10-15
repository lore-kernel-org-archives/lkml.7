Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44847ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1790F20873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733146AbfJOPvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 11:51:11 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:49760 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfJOPvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:51:10 -0400
Received: by mail-io1-f72.google.com with SMTP id e14so32605582iot.16
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 08:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6iWAXjrX3NQKqn51T418k7zm7Dix07NoPgKf3FFwRF4=;
        b=rdQ1z6kxT7QEIoev5aPQugdpSWOs3hPv282DvshQJ+xUDkxeBKO1obObxyckFacVq4
         qVex0+WYeehYHc6JOAoB5j99iY6LtYpA7THIFipzpg0TKFbdR28f3+W/uKrgDpsS0PHS
         kl/aX7wVPAxipTuArDrWxb6sQkHbMGHKu2GVszG9a76AoX0Ajixv1DoRlXw5JIbJKJ3K
         27XtJZ3hdbIvdmfpmQjDvvCD9Tcz6mGJol3YC8EpgWDpqUvLFz4254hcxVvGbUN1pr8x
         hgqIwQ3rKCMtIKGR3QTeX/zPFt1BjsZ8Psppjis0e2FQXcCL/Fn4+899nbDUvQz3Vz6K
         0Zpg==
X-Gm-Message-State: APjAAAX0l0HkqN8ZG3pACr1iewF6pCbHm9ewDi4ATvhv2tPXJeBtcHPk
        2ss/Htq4ZHes5qB2mRfkj4EUrqhapWX5wWPwh5E2rfrkHPQm
X-Google-Smtp-Source: APXvYqz7bswPx83+mEXEvlO+1TwzqszisjmX1pdx0B4dXukN8vidYzwze85YI2qwDOVjpMGBvBslHouwjezkd3hcUh7j9l2HXn05
MIME-Version: 1.0
X-Received: by 2002:a92:da47:: with SMTP id p7mr6560956ilq.184.1571154669517;
 Tue, 15 Oct 2019 08:51:09 -0700 (PDT)
Date:   Tue, 15 Oct 2019 08:51:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6ca4c0594f4f3d4@google.com>
Subject: KASAN: use-after-free Read in usb_autopm_put_interface
From:   syzbot <syzbot+cd24df4d075c319ebfc5@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        kai.heng.feng@canonical.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    22be26f7 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=174dc008e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=387eccb7ac68ec5
dashboard link: https://syzkaller.appspot.com/bug?extid=cd24df4d075c319ebfc5
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145d2e6f600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ce4473600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cd24df4d075c319ebfc5@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in usb_autopm_put_interface+0x70/0x90  
drivers/usb/core/driver.c:1629
Read of size 8 at addr ffff8881d8cdf070 by task syz-executor117/2705

CPU: 1 PID: 2705 Comm: syz-executor117 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description.constprop.0+0x36/0x50 mm/kasan/report.c:374
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:506
  kasan_report+0xe/0x20 mm/kasan/common.c:634
  usb_autopm_put_interface+0x70/0x90 drivers/usb/core/driver.c:1629
  usblp_release+0x121/0x1d0 drivers/usb/class/usblp.c:467
  __fput+0x2d7/0x840 fs/file_table.c:280
  task_work_run+0x13f/0x1c0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x8c4/0x2c00 kernel/exit.c:817
  do_group_exit+0x125/0x340 kernel/exit.c:921
  get_signal+0x466/0x23d0 kernel/signal.c:2734
  do_signal+0x88/0x14e0 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop+0x1a2/0x200 arch/x86/entry/common.c:159
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x45f/0x580 arch/x86/entry/common.c:300
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x448569
Code: Bad RIP value.
RSP: 002b:00007fcc286a6db8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00000000006ddc48 RCX: 0000000000448569
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000006ddc48
RBP: 00000000006ddc40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006ddc4c
R13: 00007fff5babd83f R14: 00007fcc286a79c0 R15: 00000000006ddc4c

Allocated by task 102:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:510 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:483
  kmalloc include/linux/slab.h:556 [inline]
  kzalloc include/linux/slab.h:690 [inline]
  usb_set_configuration+0x2c4/0x1670 drivers/usb/core/message.c:1846
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x104/0x210 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0xae6/0x16f0 drivers/base/core.c:2201
  usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5183 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5323 [inline]
  port_event drivers/usb/core/hub.c:5469 [inline]
  hub_event+0x1dd0/0x37e0 drivers/usb/core/hub.c:5551
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 102:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  kasan_set_free_info mm/kasan/common.c:332 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:471
  slab_free_hook mm/slub.c:1424 [inline]
  slab_free_freelist_hook mm/slub.c:1475 [inline]
  slab_free mm/slub.c:3018 [inline]
  kfree+0xe4/0x320 mm/slub.c:3967
  device_release+0x71/0x200 drivers/base/core.c:1100
  kobject_cleanup lib/kobject.c:693 [inline]
  kobject_release lib/kobject.c:722 [inline]
  kref_put include/linux/kref.h:65 [inline]
  kobject_put+0x171/0x280 lib/kobject.c:739
  put_device+0x1b/0x30 drivers/base/core.c:2300
  usb_disable_device+0x2ce/0x690 drivers/usb/core/message.c:1244
  usb_disconnect+0x284/0x8d0 drivers/usb/core/hub.c:2199
  hub_port_connect drivers/usb/core/hub.c:5034 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5323 [inline]
  port_event drivers/usb/core/hub.c:5469 [inline]
  hub_event+0x16ca/0x37e0 drivers/usb/core/hub.c:5551
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x7ab/0xe20 kernel/workqueue.c:2417
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8881d8cdf000
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 112 bytes inside of
  2048-byte region [ffff8881d8cdf000, ffff8881d8cdf800)
The buggy address belongs to the page:
page:ffffea0007633600 refcount:1 mapcount:0 mapping:ffff8881da00c000  
index:0x0 compound_mapcount: 0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 0000000000000000 0000000100000001 ffff8881da00c000
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d8cdef00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881d8cdef80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8881d8cdf000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                              ^
  ffff8881d8cdf080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d8cdf100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
