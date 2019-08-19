Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23D7C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808192070D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfHSOs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:48:29 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:51164 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfHSOsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:48:08 -0400
Received: by mail-io1-f69.google.com with SMTP id l7so4291400ion.17
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 07:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6Wo+8wZdjdnx5mtnS3kpIXtrcwocG6zLVHdPDh08kuc=;
        b=puzHFKfu4kVN2CNABWPSIAEO58933tdbMLi2Hl8ejUOzmNrMnAYyIhvIT6qRnrGnGE
         fU8yj/IxZg4FYiLUBelHEQjq3oXI9sdm1A777kQGW3mLN8QxPAs7XdnqwCrdcrOD3llq
         5S/bauiUuClwxLtBRzC97m7h2N4W57yiCQYxPrTcfvDXdSX9Ce28uquy9pL643CqxiiA
         5IZkqcjdNILMagEASF7gC+89YiahudaB3CleBN8D/+8ZvHihBbHij8cVpOrSqjBJhma2
         2kCeKv/Zcux7WKqW1pe+MtLL2oNNq/a7nz2UmyGh45L98esxPnSVajbioQKhlXGD9+yA
         bZgw==
X-Gm-Message-State: APjAAAVZyVbdUxpw6cW9SXN0LykR1nPWa6GWuV9ZKkmpDtFTjHtg2VtZ
        3SYv/q+qL8UD+Ca8zp8vAIpn+Oww8YuQmKRhuCBpOF8ND5Lv
X-Google-Smtp-Source: APXvYqxYpODaQHE2uDtu3IJpl+AWeTG0yJQHE5bxE/pMrjkQj+2NXrj5rfEJZ3bFe9A8CETDBQW0n99YNNwXzivVweeXvGYqbfn6
MIME-Version: 1.0
X-Received: by 2002:a5d:980d:: with SMTP id a13mr23107761iol.240.1566226087386;
 Mon, 19 Aug 2019 07:48:07 -0700 (PDT)
Date:   Mon, 19 Aug 2019 07:48:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093a9110590796dc4@google.com>
Subject: KASAN: use-after-free Read in iowarrior_release
From:   syzbot <syzbot+fa4fa544487e9d02b211@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=14ff4372600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dbc9c80cc095da19
dashboard link: https://syzkaller.appspot.com/bug?extid=fa4fa544487e9d02b211
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16c83b36600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15cbba22600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fa4fa544487e9d02b211@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __mutex_lock_common  
kernel/locking/mutex.c:912 [inline]
BUG: KASAN: use-after-free in __mutex_lock+0xf23/0x1360  
kernel/locking/mutex.c:1077
Read of size 8 at addr ffff8881d4a716d8 by task syz-executor812/2337

CPU: 0 PID: 2337 Comm: syz-executor812 Not tainted 5.3.0-rc4+ #26
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x6a/0x32c mm/kasan/report.c:351
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
  kasan_report+0xe/0x12 mm/kasan/common.c:612
  __mutex_lock_common kernel/locking/mutex.c:912 [inline]
  __mutex_lock+0xf23/0x1360 kernel/locking/mutex.c:1077
  iowarrior_release+0x4c/0x280 drivers/usb/misc/iowarrior.c:650
  __fput+0x2d7/0x840 fs/file_table.c:280
  task_work_run+0x13f/0x1c0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x8ef/0x2c00 kernel/exit.c:879
  do_group_exit+0x125/0x340 kernel/exit.c:983
  __do_sys_exit_group kernel/exit.c:994 [inline]
  __se_sys_exit_group kernel/exit.c:992 [inline]
  __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:992
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4445f8
Code: Bad RIP value.
RSP: 002b:00007ffdf26d4508 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004445f8
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004c4450 R08: 00000000000000e7 R09: ffffffffffffffd4
R10: 0000000000027c8d R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d6180 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 1742:
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

Freed by task 1742:
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

The buggy address belongs to the object at ffff8881d4a71680
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 88 bytes inside of
  512-byte region [ffff8881d4a71680, ffff8881d4a71880)
The buggy address belongs to the page:
page:ffffea0007529c00 refcount:1 mapcount:0 mapping:ffff8881da002500  
index:0xffff8881d4a70c80 compound_mapcount: 0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 ffffea0007529500 0000000300000003 ffff8881da002500
raw: ffff8881d4a70c80 00000000800c000a 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d4a71580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d4a71600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8881d4a71680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                     ^
  ffff8881d4a71700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d4a71780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
