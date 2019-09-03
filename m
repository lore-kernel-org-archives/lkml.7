Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218C8C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAC8216C8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfICMIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 08:08:32 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:56036 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbfICMIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:08:14 -0400
Received: by mail-io1-f72.google.com with SMTP id i2so17120617iof.22
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 05:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wqVv3T4Kr7Dh5YLU67E7Y9Bmlv3N5Sj0lxs8749c8h4=;
        b=gf/xh/PbVD7ogH5I705VbzOBRslxAkipcrhjODWU3z/zB6m+6xFud+FskO13BJuJ/e
         2Hsl/B6wQ3w8qic846dREmW++90gDU4WvWnjrYKzSUIFGZHQzoQzYE9fTwm0OQxgPtIb
         qSGJ6n9p8lP0vlG0SW4t56R1PbjK/vg2bhQylF3hzX9BkdXmyx2Wsuw/Sz+y7TnMOupr
         bG14KD6i3yHoiSkuInd9BajKNdMgWaQSf/6oFbSu3FkaFkUST92xirDCipZNqCb9f6rr
         K9ojNIG2MXGLsc4h4Bn2nn4eKzvgvnPM9DQO5FUsQyWodKVChb8aHLpn+dcpegEiUeiO
         mWiw==
X-Gm-Message-State: APjAAAVD0CNbP2IvAAm/dKuKmMDXNV7KnkQxpmVYHsG20G+twYsMKAFK
        J6/2mDJEWG9mBU1ZT6p6hDn1OHCApXaAGirNQIqXkc1YcAnc
X-Google-Smtp-Source: APXvYqyVCSyvT6qW7OFJjrnPeMFyH/qKc2kJAezAcnffnu4a0lUryowe9LGwEJgpD+hsHXl8cK0sET/2Uj8ITU/kFoG3YerRONEa
MIME-Version: 1.0
X-Received: by 2002:a5d:974d:: with SMTP id c13mr13591904ioo.87.1567512493469;
 Tue, 03 Sep 2019 05:08:13 -0700 (PDT)
Date:   Tue, 03 Sep 2019 05:08:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ab98e0591a4f153@google.com>
Subject: KASAN: use-after-free Write in iowarrior_disconnect
From:   syzbot <syzbot+de95ceacca6fc2a4241a@syzkaller.appspotmail.com>
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

HEAD commit:    eea39f24 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=168ec156600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0c62209eedfd54e
dashboard link: https://syzkaller.appspot.com/bug?extid=de95ceacca6fc2a4241a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+de95ceacca6fc2a4241a@syzkaller.appspotmail.com

usb 5-1: USB disconnect, device number 11
==================================================================
BUG: KASAN: use-after-free in register_lock_class+0xeda/0x11d0  
kernel/locking/lockdep.c:1195
Write of size 8 at addr ffff8881cf14b030 by task kworker/1:3/2771

CPU: 1 PID: 2771 Comm: kworker/1:3 Not tainted 5.3.0-rc5+ #28
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x6a/0x32c mm/kasan/report.c:351
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
  kasan_report+0xe/0x12 mm/kasan/common.c:612
  register_lock_class+0xeda/0x11d0 kernel/locking/lockdep.c:1195
  __lock_acquire+0xfc/0x3b50 kernel/locking/lockdep.c:3762
  lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4412
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x32/0x50 kernel/locking/spinlock.c:159
  __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:122
  iowarrior_disconnect+0x1a6/0x2c0 drivers/usb/misc/iowarrior.c:891
  usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:423
  __device_release_driver drivers/base/dd.c:1134 [inline]
  device_release_driver_internal+0x42f/0x500 drivers/base/dd.c:1165
  bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:556
  device_del+0x420/0xb10 drivers/base/core.c:2339
  usb_disable_device+0x211/0x690 drivers/usb/core/message.c:1237
  usb_disconnect+0x284/0x8d0 drivers/usb/core/hub.c:2199
  hub_port_connect drivers/usb/core/hub.c:4949 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1454/0x3640 drivers/usb/core/hub.c:5441
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Allocated by task 2753:
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

Freed by task 2990:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:449
  slab_free_hook mm/slub.c:1423 [inline]
  slab_free_freelist_hook mm/slub.c:1474 [inline]
  slab_free mm/slub.c:3016 [inline]
  kfree+0xe4/0x2f0 mm/slub.c:3957
  iowarrior_delete drivers/usb/misc/iowarrior.c:246 [inline]
  iowarrior_release+0x187/0x280 drivers/usb/misc/iowarrior.c:670
  __fput+0x2d7/0x840 fs/file_table.c:280
  task_work_run+0x13f/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x1d2/0x200 arch/x86/entry/common.c:163
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x45f/0x580 arch/x86/entry/common.c:299
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881cf14af00
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 304 bytes inside of
  512-byte region [ffff8881cf14af00, ffff8881cf14b100)
The buggy address belongs to the page:
page:ffffea00073c5280 refcount:1 mapcount:0 mapping:ffff8881da002500  
index:0x0 compound_mapcount: 0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 ffffea00073f6a00 0000000800000006 ffff8881da002500
raw: 0000000000000000 00000000000c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881cf14af00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881cf14af80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881cf14b000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                      ^
  ffff8881cf14b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881cf14b100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
