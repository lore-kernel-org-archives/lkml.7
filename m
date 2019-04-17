Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30515C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02095206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731943AbfDQL0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:26:07 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:59547 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfDQL0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:26:06 -0400
Received: by mail-it1-f198.google.com with SMTP id 75so2186579itz.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 04:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=guTkmJID0G/19PsmYWGrhUQ3zTZQr9xdQ7bmU4AFgEY=;
        b=CGCBj4SXZl9YHHktLw+3lB64bV4LrpXtAzMrLK7yjbw4HJGXmaD9decF6/k+mYXe8f
         16V3/moof2pmPTHo4EC7lrCMcXHJjklDl9G2Q2pBm1d7xWClmgVESrHtHqhlj6bfo5NA
         o5NZfZ3aSJZd5ZDQi01hkfA44uFwFWeDo39AJabVwfjEyGZRdVsfTi3+U+EdWSINza1h
         YNk9w63pNWZ0SEnBFirZzzMt8mo7TA3OBGBYR/u6kKaYutQDPtUGs1wX1UqfKqCUNgfC
         cs8qTCkZi+0gNiRUT1AefVE83mNwMSATV9BIuraaz7wlKr6nf1TfAPyu+tt1a690cRDA
         L4XQ==
X-Gm-Message-State: APjAAAXFEE3v2Vuw5ozkF+zMKqOSfkiKIKehmrBzsx4cIpLTCdeTQ7YM
        mpSn6FGBCI9ayXjeD4ogRUumVLTsWY2pkx6lrt0O6+4NjVY4
X-Google-Smtp-Source: APXvYqzv8RS9kLNHTsA1hpbidYVunrcf+k4930OijXWo/xrF5bWjdW9mwHDKfWyyW2I+mIcbJpbvz+2HCUbMJTm9OySQms7V252l
MIME-Version: 1.0
X-Received: by 2002:a24:2f42:: with SMTP id j63mr33434243itj.108.1555500365400;
 Wed, 17 Apr 2019 04:26:05 -0700 (PDT)
Date:   Wed, 17 Apr 2019 04:26:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba57420586b82623@google.com>
Subject: KASAN: slab-out-of-bounds Read in ds_probe
From:   syzbot <syzbot+d65f673b847a1a96cdba@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, florian.harbecke@fau.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, passt@h-hofmeier.de,
        syzkaller-bugs@googlegroups.com, zbr@ioremap.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=13eb726b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
dashboard link: https://syzkaller.appspot.com/bug?extid=d65f673b847a1a96cdba
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1340b55b200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e436f3200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d65f673b847a1a96cdba@syzkaller.appspotmail.com

usb 1-1: config 0 has no interface number 0
usb 1-1: New USB device found, idVendor=04fa, idProduct=2490,  
bcdDevice=74.f9
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
==================================================================
BUG: KASAN: slab-out-of-bounds in ds_probe+0x604/0x760  
drivers/w1/masters/ds2490.c:1019
Read of size 1 at addr ffff8880a7c45fe2 by task kworker/0:1/12

CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xe8/0x16e lib/dump_stack.c:113
  print_address_description+0x6c/0x236 mm/kasan/report.c:187
  kasan_report.cold+0x1a/0x3c mm/kasan/report.c:317
  ds_probe+0x604/0x760 drivers/w1/masters/ds2490.c:1019
  usb_probe_interface+0x31d/0x820 drivers/usb/core/driver.c:361
  really_probe+0x2da/0xb10 drivers/base/dd.c:509
  driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
  __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
  __device_attach+0x223/0x3a0 drivers/base/dd.c:844
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
  device_add+0xad2/0x16e0 drivers/base/core.c:2106
  usb_set_configuration+0xdf7/0x1740 drivers/usb/core/message.c:2021
  generic_probe+0xa2/0xda drivers/usb/core/generic.c:210
  usb_probe_device+0xc0/0x150 drivers/usb/core/driver.c:266
  really_probe+0x2da/0xb10 drivers/base/dd.c:509
  driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
  __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
  __device_attach+0x223/0x3a0 drivers/base/dd.c:844
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
  device_add+0xad2/0x16e0 drivers/base/core.c:2106
  usb_new_device.cold+0x537/0xccf drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x138e/0x3b00 drivers/usb/core/hub.c:5432
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Allocated by task 12:
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:470
  kmalloc include/linux/slab.h:552 [inline]
  kzalloc include/linux/slab.h:742 [inline]
  usb_parse_configuration drivers/usb/core/config.c:710 [inline]
  usb_get_configuration+0xc4c/0x32b0 drivers/usb/core/config.c:882
  usb_enumerate_device drivers/usb/core/hub.c:2367 [inline]
  usb_new_device+0x2fe/0x450 drivers/usb/core/hub.c:2503
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x138e/0x3b00 drivers/usb/core/hub.c:5432
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Freed by task 1258:
  set_track mm/kasan/common.c:87 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:459
  slab_free_hook mm/slub.c:1429 [inline]
  slab_free_freelist_hook+0x5e/0x140 mm/slub.c:1456
  slab_free mm/slub.c:3003 [inline]
  kfree+0xce/0x290 mm/slub.c:3958
  security_task_free+0x9a/0xf0 security/security.c:1470
  __put_task_struct+0xec/0x4d0 kernel/fork.c:724
  put_task_struct include/linux/sched/task.h:98 [inline]
  delayed_put_task_struct+0x189/0x290 kernel/exit.c:181
  __rcu_reclaim kernel/rcu/rcu.h:227 [inline]
  rcu_do_batch kernel/rcu/tree.c:2475 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2788 [inline]
  rcu_core+0x83b/0x1a80 kernel/rcu/tree.c:2769
  __do_softirq+0x22a/0x8cd kernel/softirq.c:293

The buggy address belongs to the object at ffff8880a7c45f60
  which belongs to the cache kmalloc-64 of size 64
The buggy address is located 66 bytes to the right of
  64-byte region [ffff8880a7c45f60, ffff8880a7c45fa0)
The buggy address belongs to the page:
page:ffffea00029f1140 count:1 mapcount:0 mapping:ffff88812c3f5600 index:0x0
flags: 0xfff00000000200(slab)
raw: 00fff00000000200 ffffea00025f69c0 0000000500000005 ffff88812c3f5600
raw: 0000000000000000 00000000802a002a 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a7c45e80: fc fc fc fc 00 00 00 00 00 00 00 fc fc fc fc fc
  ffff8880a7c45f00: fb fb fb fb fb fb fb fb fc fc fc fc 00 00 00 00
> ffff8880a7c45f80: 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                        ^
  ffff8880a7c46000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8880a7c46080: 00 00 00 00 fc fc fc fc fc fc fc fc 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
