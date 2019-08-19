Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F17C3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7242082A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfHSOsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:48:15 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:37909 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbfHSOsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:48:09 -0400
Received: by mail-io1-f72.google.com with SMTP id h4so4326158iol.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 07:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zynOBBCom8qaE6I5ngaX5045fPPAfetZ1Bt6lprgz6c=;
        b=AjaPtjixkBD2Yfk5gb21PUNiOw9ac8VRoYXuybtvM5j63HPtvN13wI8K0oQpjFSDsb
         zcnlEQ1tlWGlwjITn3CDQCd+8ZR41y0HQh5K2ZyUf3VMUPYWno5xJsxAnj4lgxsZFRp1
         hbJ+oN8eNXpmubwCjDdksg7XUQqIdkDDi80vwaBkZON2OH04KHdibzpg9jcSvzN+Q0R+
         IebEwpEp17BNPabm1iZg31/Xrf/wNgM/1ArLIRecy9foTOGwfPZqQBOf1gfqbY7BpZq/
         yrBTB06zEds89EHaOO5jkhl1cor/rkwLHPeGN1jttKYgeFahWLoKoZknLsnzAn530WwC
         cJmA==
X-Gm-Message-State: APjAAAUzueof35BKadMiqyhzE82RurkbNQqrbYIxn8Gg8zNbo5QMiQPc
        FN5yJ0aWSd1azRkVs4VoE8EtHi1HLp9u1gXVHlk1aZqoEUHh
X-Google-Smtp-Source: APXvYqxYkBNZrfTlJKPTsKZNZGmXaWGjGPBJMXB7EjjnrkwuOQeVy91juMafe1sfDBnZOX3aekil48H+mSn2D1FAv0Shx4PvxtCE
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2508:: with SMTP id i8mr10512511ioe.91.1566226087950;
 Mon, 19 Aug 2019 07:48:07 -0700 (PDT)
Date:   Mon, 19 Aug 2019 07:48:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c42670590796d1d@google.com>
Subject: KASAN: invalid-free in iowarrior_disconnect
From:   syzbot <syzbot+68a449e448766880a109@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=15fb03ba600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dbc9c80cc095da19
dashboard link: https://syzkaller.appspot.com/bug?extid=68a449e448766880a109
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+68a449e448766880a109@syzkaller.appspotmail.com

usb 1-1: USB disconnect, device number 99
==================================================================
BUG: KASAN: double-free or invalid-free in iowarrior_delete  
drivers/usb/misc/iowarrior.c:243 [inline]
BUG: KASAN: double-free or invalid-free in iowarrior_disconnect+0x1f8/0x2c0  
drivers/usb/misc/iowarrior.c:894

CPU: 1 PID: 3267 Comm: kworker/1:6 Not tainted 5.3.0-rc4+ #26
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x6a/0x32c mm/kasan/report.c:351
  kasan_report_invalid_free+0x61/0xa0 mm/kasan/report.c:444
  __kasan_slab_free+0x162/0x180 mm/kasan/common.c:428
  slab_free_hook mm/slub.c:1423 [inline]
  slab_free_freelist_hook mm/slub.c:1474 [inline]
  slab_free mm/slub.c:3016 [inline]
  kfree+0xe4/0x2f0 mm/slub.c:3957
  iowarrior_delete drivers/usb/misc/iowarrior.c:243 [inline]
  iowarrior_disconnect+0x1f8/0x2c0 drivers/usb/misc/iowarrior.c:894
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

Allocated by task 2745:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:487 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:460
  kmalloc include/linux/slab.h:557 [inline]
  iowarrior_probe+0x526/0x10b2 drivers/usb/misc/iowarrior.c:800
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

Freed by task 4897:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:449
  slab_free_hook mm/slub.c:1423 [inline]
  slab_free_freelist_hook mm/slub.c:1474 [inline]
  slab_free mm/slub.c:3016 [inline]
  kfree+0xe4/0x2f0 mm/slub.c:3957
  iowarrior_delete drivers/usb/misc/iowarrior.c:243 [inline]
  iowarrior_release+0x123/0x280 drivers/usb/misc/iowarrior.c:670
  __fput+0x2d7/0x840 fs/file_table.c:280
  task_work_run+0x13f/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x1d2/0x200 arch/x86/entry/common.c:163
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x45f/0x580 arch/x86/entry/common.c:299
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881da290558
  which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes inside of
  8-byte region [ffff8881da290558, ffff8881da290560)
The buggy address belongs to the page:
page:ffffea000768a400 refcount:1 mapcount:0 mapping:ffff8881da003900  
index:0xffff8881da290de0
flags: 0x200000000000200(slab)
raw: 0200000000000200 ffffea0007343c00 0000000600000006 ffff8881da003900
raw: ffff8881da290de0 0000000080aa002f 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881da290400: fc fb fc fc fb fc fc fb fc fc fb fc fc fb fc fc
  ffff8881da290480: fb fc fc fb fc fc fb fc fc fb fc fc fb fc fc fb
> ffff8881da290500: fc fc fb fc fc fb fc fc fb fc fc fb fc fc fb fc
                                                     ^
  ffff8881da290580: fc fb fc fc fb fc fc fb fc fc fb fc fc fb fc fc
  ffff8881da290600: fb fc fc fb fc fc fb fc fc fb fc fc fb fc fc fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
