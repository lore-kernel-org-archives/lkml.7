Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39305C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090D52086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438069AbfITKVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 06:21:03 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:36306 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408634AbfITKVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 06:21:03 -0400
Received: by mail-io1-f71.google.com with SMTP id g126so9918093iof.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 03:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QAyn7TFozAmT6Dxvc3eS2U6QJqrBkI01cVS4WQSS6U0=;
        b=atUUMAIRWDjmloHAN/nw73RvuxU7ssRsSRQI0nAekRKja1bAdbmgLmyo0//UvvLSMe
         O0/zv3s9cW2ZUD4XKLmS0DM3PuO8B1GxcIO1jyvGH/fefcEazG/FJetCDL5rnAlSdGp7
         wGj4NM6TQNH+4sHpF/AE32yKm/oQGbbkXxQa1zDS1MnEK0anGGsI4VCsiCoEjzxZZ7sC
         VQVeNUbX8Y+OcLzgksatLfx2XizGcXoB0RszgaYCujRMpgfdEuyDnlWUfvnCA0IBJL66
         lGTyiznzXT8e/ZX2V+Hdw2vK9cFS7Z0g23NDZXnkp13nxGD8P70Ip2MrxdpT8qNJqfJf
         6dYw==
X-Gm-Message-State: APjAAAXaFBcceNjoocyHdno38zwTP5MzyxIv5eJX8eFFhxm5NdXpRY5d
        XyMlc3X+0viAwbgJ+6UWZoT9hN8hkGgn6fKaVHfcbVZcbRYD
X-Google-Smtp-Source: APXvYqwh36QL20v06MjvMxXLDdpo62jYp8Tu/DM/62kMgr5CVPr7pJ5I1nixJgv7WOeWZnQZbw5ZW2KXgRqvwsvg8uHcWXNMgODu
MIME-Version: 1.0
X-Received: by 2002:a02:3f12:: with SMTP id d18mr12128625jaa.39.1568974860439;
 Fri, 20 Sep 2019 03:21:00 -0700 (PDT)
Date:   Fri, 20 Sep 2019 03:21:00 -0700
In-Reply-To: <20190920100233.GP30545@localhost>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037dc650592f96d74@google.com>
Subject: Re: KASAN: use-after-free Read in adu_disconnect
From:   syzbot <syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, dmg@turingmachine.org,
        gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer still triggered  
crash:
KASAN: use-after-free Read in adu_release

==================================================================
BUG: KASAN: use-after-free in adu_release+0x4dc/0x590  
drivers/usb/misc/adutux.c:322
Read of size 4 at addr ffff8881d4ec4d1c by task syz-executor.5/3225

CPU: 1 PID: 3225 Comm: syz-executor.5 Not tainted 5.3.0-rc2+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x6a/0x32c mm/kasan/report.c:351
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
  kasan_report+0xe/0x12 mm/kasan/common.c:612
  adu_release+0x4dc/0x590 drivers/usb/misc/adutux.c:322
  __fput+0x2d7/0x840 fs/file_table.c:280
  task_work_run+0x13f/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x1d2/0x200 arch/x86/entry/common.c:163
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x45f/0x580 arch/x86/entry/common.c:299
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x413511
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 1b 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffddbaa5fc0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000413511
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000760130 R09: ffffffffffffffff
R10: 00007ffddbaa5ee0 R11: 0000000000000293 R12: 0000000000000001
R13: 00007ffddbaa6000 R14: 0000000000000000 R15: 00007ffddbaa6010

Allocated by task 2885:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:487 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:460
  kmalloc include/linux/slab.h:552 [inline]
  kzalloc include/linux/slab.h:748 [inline]
  adu_probe+0x7d/0x6e0 drivers/usb/misc/adutux.c:660
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

Freed by task 2885:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:449
  slab_free_hook mm/slub.c:1423 [inline]
  slab_free_freelist_hook mm/slub.c:1470 [inline]
  slab_free mm/slub.c:3012 [inline]
  kfree+0xe4/0x2f0 mm/slub.c:3953
  adu_probe+0x5de/0x6e0 drivers/usb/misc/adutux.c:750
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

The buggy address belongs to the object at ffff8881d4ec4c80
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 156 bytes inside of
  512-byte region [ffff8881d4ec4c80, ffff8881d4ec4e80)
The buggy address belongs to the page:
page:ffffea000753b100 refcount:1 mapcount:0 mapping:ffff8881da002500  
index:0xffff8881d4ec4f00 compound_mapcount: 0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 ffffea00074fea80 0000000400000004 ffff8881da002500
raw: ffff8881d4ec4f00 00000000800c0008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d4ec4c00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881d4ec4c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881d4ec4d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                             ^
  ffff8881d4ec4d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d4ec4e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         e96407b4 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1251ee8d600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
dashboard link: https://syzkaller.appspot.com/bug?extid=0243cb250a51eeefb8cc
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16ddc075600000

