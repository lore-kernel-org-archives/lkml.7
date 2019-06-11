Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3CCC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D282089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406020AbfFKRZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:25:07 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:37201 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405718AbfFKRZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:25:06 -0400
Received: by mail-it1-f197.google.com with SMTP id q20so2860481itq.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 10:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=I1aBIdZwz6RxeJUUWVYQOdlkCBuyA19TmFs+D1pr88A=;
        b=B+KFWQTeLVhPXc78XLgngjHYfzXzl9SkwBdyw6lH3XamGbi/5ToYhmn+fa072XJJyE
         l2q/6Z/Cigqym6kcNcFc/CKCFCQAS80UAjNkMF5+JyAWql+0MlZoNiHeas5twePpU14p
         rgmWYYLJxu/6nfKpySApN7bwSd8VvYgaX7Pccq3vbYtQhgnMZW4ctjYjE2nDA/Ezfpe3
         wrSH+aPNSE7eWHJ516euvFPAmFp73hALjojmffbAv/zdr50aayel2J+0k37vqoJuhR7i
         oXOUA9rZP5kjPsyk4Nd5Vr8teR7HezP1rYhncKP2uzMEzhOfn0r7pGla1Z6UQh+pQFsm
         OqFA==
X-Gm-Message-State: APjAAAVNCtD0BtN99u0SrOJzK2OmmHeRtbLf1tUyjwdt8Im3DmGna9Tk
        C8c/udrcLn3Ua1YuaiDeVduwzVVOnc4Zk7bxk1jLCn+NM/BY
X-Google-Smtp-Source: APXvYqxQH8tdbqCQlll2DNLltI7CdXtwxnxV6c/iUdc0mRjdvUvhAH+W+THvwSmXFMFZR+ZuC6nN83qPMisubOwGQoB2527z+THW
MIME-Version: 1.0
X-Received: by 2002:a24:1c9:: with SMTP id 192mr18289568itk.79.1560273905794;
 Tue, 11 Jun 2019 10:25:05 -0700 (PDT)
Date:   Tue, 11 Jun 2019 10:25:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e84a3a058b0f9307@google.com>
Subject: KASAN: use-after-free Read in usb_kill_anchored_urbs
From:   syzbot <syzbot+eb6ab607626fd1dac0f1@syzkaller.appspotmail.com>
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

HEAD commit:    69bbe8c7 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=15df4ecaa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=193d8457178b3229
dashboard link: https://syzkaller.appspot.com/bug?extid=eb6ab607626fd1dac0f1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11847e7aa00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ef5f2ea00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+eb6ab607626fd1dac0f1@syzkaller.appspotmail.com

mcba_usb 1-1:0.116 can0: Failed to send cmd (169)
mcba_usb 1-1:0.116 can0: failed tx_urb -2
mcba_usb 1-1:0.116 can0: Failed to send cmd (169)
mcba_usb 1-1:0.116: Microchip CAN BUS Analyzer connected
usb 1-1: USB disconnect, device number 2
mcba_usb 1-1:0.116 can0: device disconnected
==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x3a5d/0x5340  
kernel/locking/lockdep.c:3664
Read of size 8 at addr ffff8881d44c63c8 by task kworker/0:1/12

CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.2.0-rc1+ #10
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
  __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
  _raw_spin_lock_irq+0x2d/0x40 kernel/locking/spinlock.c:167
  spin_lock_irq include/linux/spinlock.h:363 [inline]
  usb_kill_anchored_urbs+0x1e/0x110 drivers/usb/core/urb.c:787
  mcba_urb_unlink drivers/net/can/usb/mcba_usb.c:722 [inline]
  mcba_usb_disconnect+0xd6/0xe4 drivers/net/can/usb/mcba_usb.c:892
  usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:423
  __device_release_driver drivers/base/dd.c:1081 [inline]
  device_release_driver_internal+0x404/0x4c0 drivers/base/dd.c:1112
  bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:556
  device_del+0x460/0xb80 drivers/base/core.c:2274
  usb_disable_device+0x211/0x690 drivers/usb/core/message.c:1237
  usb_disconnect+0x284/0x830 drivers/usb/core/hub.c:2197
  hub_port_connect drivers/usb/core/hub.c:4940 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x1409/0x3590 drivers/usb/core/hub.c:5432
  process_one_work+0x905/0x1570 kernel/workqueue.c:2268
  worker_thread+0x96/0xe20 kernel/workqueue.c:2414
  kthread+0x30b/0x410 kernel/kthread.c:254
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Allocated by task 12:
  save_stack+0x1b/0x80 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_kmalloc mm/kasan/common.c:489 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:462
  kmalloc_node include/linux/slab.h:590 [inline]
  kvmalloc_node+0x61/0xf0 mm/util.c:430
  kvmalloc include/linux/mm.h:637 [inline]
  kvzalloc include/linux/mm.h:645 [inline]
  alloc_netdev_mqs+0x97/0xce0 net/core/dev.c:9154
  alloc_candev_mqs+0x58/0x320 drivers/net/can/dev.c:738
  mcba_usb_probe+0xaf/0xbca drivers/net/can/usb/mcba_usb.c:810
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

Freed by task 12:
  save_stack+0x1b/0x80 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:451
  slab_free_hook mm/slub.c:1421 [inline]
  slab_free_freelist_hook mm/slub.c:1448 [inline]
  slab_free mm/slub.c:2994 [inline]
  kfree+0xd7/0x280 mm/slub.c:3949
  kvfree+0x59/0x60 mm/util.c:459
  device_release+0x71/0x200 drivers/base/core.c:1064
  kobject_cleanup lib/kobject.c:691 [inline]
  kobject_release lib/kobject.c:720 [inline]
  kref_put include/linux/kref.h:67 [inline]
  kobject_put+0x171/0x280 lib/kobject.c:737
  put_device+0x1b/0x30 drivers/base/core.c:2210
  free_netdev+0x317/0x420 net/core/dev.c:9265
  mcba_usb_disconnect+0xca/0xe4 drivers/net/can/usb/mcba_usb.c:890
  usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:423
  __device_release_driver drivers/base/dd.c:1081 [inline]
  device_release_driver_internal+0x404/0x4c0 drivers/base/dd.c:1112
  bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:556
  device_del+0x460/0xb80 drivers/base/core.c:2274
  usb_disable_device+0x211/0x690 drivers/usb/core/message.c:1237
  usb_disconnect+0x284/0x830 drivers/usb/core/hub.c:2197
  hub_port_connect drivers/usb/core/hub.c:4940 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x1409/0x3590 drivers/usb/core/hub.c:5432
  process_one_work+0x905/0x1570 kernel/workqueue.c:2268
  worker_thread+0x96/0xe20 kernel/workqueue.c:2414
  kthread+0x30b/0x410 kernel/kthread.c:254
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8881d44c5500
  which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 3784 bytes inside of
  4096-byte region [ffff8881d44c5500, ffff8881d44c6500)
The buggy address belongs to the page:
page:ffffea0007513000 refcount:1 mapcount:0 mapping:ffff8881dac02600  
index:0x0 compound_mapcount: 0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 dead000000000100 dead000000000200 ffff8881dac02600
raw: 0000000000000000 0000000000070007 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d44c6280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d44c6300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881d44c6380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                               ^
  ffff8881d44c6400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d44c6480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
