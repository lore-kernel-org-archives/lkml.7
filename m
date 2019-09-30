Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADAAC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57F820842
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbfI3WjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 18:39:20 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:37210 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfI3WjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 18:39:18 -0400
Received: by mail-io1-f69.google.com with SMTP id u18so33370078ioc.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 15:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hU4mGFOi7CEEjY3yzSb80cS25PMkN6P10n68vp3O9Cw=;
        b=GrHioJADeU+FGv8x89aj0VFbX7TWW8zwj3+Pq5OLPL3dTaSkjCWDr/3OS9tOJ+zibJ
         JP4UL5J3Km/LYUYBacZKBqm+T33y4WWEGMO3EA2+dM00QO7GDfmiK2Q3oIsiLpHU+Gqy
         9A8y/TtAdCUvGtbYEdPQldimm1vFJIILuffWIIBt8YWdJITfxmNPWS5QsR+VOroSKQgC
         jIhq2VBMF7T1AwZt3W097OZfis03TCc/wk96BJCK0M29nkmukeldjR4OCJ6suncEMt8y
         RER6JV3YPEqhzlQEXabiSoYMg7VEp1s88AbJzJpWboEsppOjzaDBXRWXL8J9o9n/F2Wn
         U5aw==
X-Gm-Message-State: APjAAAVhpAYpqi5gN4gz/HLfulxmbk5L5FNl8H2Mgytj9V+AYUBqKvYf
        PVFR8X2Wc1LrZqVo/FClUzit4GWUwqQliSYr1lgycI+u47Qn
X-Google-Smtp-Source: APXvYqy2ihl7GSaR3GLG1Wbs1QgfdL9GMmTsK5FoJVhsK/zFWrkWnWBd1D3Gb0g2t2hVuEoJ/UjF9MR7laxHl0W8+xQms4WxQTDL
MIME-Version: 1.0
X-Received: by 2002:a6b:e618:: with SMTP id g24mr2864931ioh.277.1569883155934;
 Mon, 30 Sep 2019 15:39:15 -0700 (PDT)
Date:   Mon, 30 Sep 2019 15:39:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d939fb0593cce7a8@google.com>
Subject: KASAN: use-after-free Read in hso_probe
From:   syzbot <syzbot+3930f3e416920885c9d4@syzkaller.appspotmail.com>
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

HEAD commit:    2994c077 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=104c47bd600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=69ddefac6929256a
dashboard link: https://syzkaller.appspot.com/bug?extid=3930f3e416920885c9d4
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3930f3e416920885c9d4@syzkaller.appspotmail.com

  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
hso 2-1:0.9: Failed to find BULK IN ep
==================================================================
BUG: KASAN: use-after-free in __mutex_lock_common  
kernel/locking/mutex.c:938 [inline]
BUG: KASAN: use-after-free in __mutex_lock+0xf23/0x1360  
kernel/locking/mutex.c:1103
Read of size 8 at addr ffff8881c73389d8 by task kworker/0:4/2784

CPU: 0 PID: 2784 Comm: kworker/0:4 Not tainted 5.3.0+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description.constprop.0+0x36/0x50 mm/kasan/report.c:374
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:506
  kasan_report+0xe/0x12 mm/kasan/common.c:634
  __mutex_lock_common kernel/locking/mutex.c:938 [inline]
  __mutex_lock+0xf23/0x1360 kernel/locking/mutex.c:1103
  device_lock include/linux/device.h:1462 [inline]
  device_del+0x9e/0xb10 drivers/base/core.c:2341
  device_unregister drivers/base/core.c:2407 [inline]
  device_destroy+0x96/0xe0 drivers/base/core.c:2986
  tty_unregister_device+0x7e/0x1a0 drivers/tty/tty_io.c:3185
  hso_serial_tty_unregister drivers/net/usb/hso.c:2231 [inline]
  hso_create_bulk_serial_device drivers/net/usb/hso.c:2668 [inline]
  hso_probe.cold+0xc8/0x121 drivers/net/usb/hso.c:2934
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x104/0x210 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0xae6/0x16f0 drivers/base/core.c:2201
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
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
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Allocated by task 2830:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:510 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:483
  kmalloc include/linux/slab.h:552 [inline]
  kzalloc include/linux/slab.h:686 [inline]
  tty_register_device_attr+0x1b6/0x6f0 drivers/tty/tty_io.c:3124
  hso_serial_common_create+0x113/0x710 drivers/net/usb/hso.c:2265
  hso_create_bulk_serial_device drivers/net/usb/hso.c:2638 [inline]
  hso_probe+0xc93/0x1a46 drivers/net/usb/hso.c:2934
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x104/0x210 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0xae6/0x16f0 drivers/base/core.c:2201
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
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
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 2830:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  kasan_set_free_info mm/kasan/common.c:332 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:471
  slab_free_hook mm/slub.c:1424 [inline]
  slab_free_freelist_hook mm/slub.c:1475 [inline]
  slab_free mm/slub.c:3018 [inline]
  kfree+0xe4/0x2f0 mm/slub.c:3959
  device_release+0x71/0x200 drivers/base/core.c:1100
  kobject_cleanup lib/kobject.c:693 [inline]
  kobject_release lib/kobject.c:722 [inline]
  kref_put include/linux/kref.h:65 [inline]
  kobject_put+0x171/0x280 lib/kobject.c:739
  put_device drivers/base/core.c:2300 [inline]
  device_unregister drivers/base/core.c:2408 [inline]
  device_destroy+0x9e/0xe0 drivers/base/core.c:2986
  tty_unregister_device+0x7e/0x1a0 drivers/tty/tty_io.c:3185
  hso_serial_tty_unregister drivers/net/usb/hso.c:2231 [inline]
  hso_create_bulk_serial_device drivers/net/usb/hso.c:2668 [inline]
  hso_probe.cold+0xc8/0x121 drivers/net/usb/hso.c:2934
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x104/0x210 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0xae6/0x16f0 drivers/base/core.c:2201
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
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
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8881c7338880
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 344 bytes inside of
  2048-byte region [ffff8881c7338880, ffff8881c7339080)
The buggy address belongs to the page:
page:ffffea00071cce00 refcount:1 mapcount:0 mapping:ffff8881da00c000  
index:0x0 compound_mapcount: 0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 0000000000000000 0000000100000001 ffff8881da00c000
raw: 0000000000000000 00000000000f000f 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881c7338880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881c7338900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881c7338980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                     ^
  ffff8881c7338a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881c7338a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
