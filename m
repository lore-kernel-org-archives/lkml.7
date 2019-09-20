Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125B2C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 17:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C885420C01
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 17:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391941AbfITRJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 13:09:08 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:50592 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389470AbfITRJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 13:09:08 -0400
Received: by mail-io1-f72.google.com with SMTP id f5so11520645iob.17
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 10:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OQsEoxCAV2ALcu9jbEuZ49uIVeXRi17fF2hkdqax6qE=;
        b=aCvgux5hToI02whSe1wFgijCzutDnImzM3On1lrm6tv0O6zW7I+FcephqgN21Zpsf1
         U1qdr1Hb4EWSgkFINgwjW9YGhC1udZy1+0bA+B7EkUT/Do48wGx7AM7PZSrj/NyzMInB
         /LEZ36W0vgh1ZIKyUJl+QptIGKniEcQcX5Q3n1CBKdsfJQDiPSkRAjrDQEyoKfIcTaN9
         ZkJhnFKZBELF46frgHEAPVwsrIf4dRVPOMbnhWofK0Bk4ouKFD0iF3DEYBaDC6V0AWtp
         2d/QPUmMxAAhgEapTl4fJRbvW4t2nQwTNLd1IV7iWrIPyC+fB6SYIUi0ShKtSjN4gbY7
         T9LA==
X-Gm-Message-State: APjAAAX56NjRQWDVkWCXZb7ZRwWxIjCRelPeZ1s2OK3gTzbnzg+rMwgI
        9E0PdtNML/y+PG6cAjs1P0RZAhKEYnSgfRPmsXfK5Zfww6iV
X-Google-Smtp-Source: APXvYqw6XdExvPG+3jejDSvWF7r/0VIFDv4UY657dPvgImmRevTtM2UKEq2sBPLBVqK9+fV9pz2FnebS6EsONExWetGtPcnYNyLP
MIME-Version: 1.0
X-Received: by 2002:a02:cdd0:: with SMTP id m16mr20051545jap.45.1568999347562;
 Fri, 20 Sep 2019 10:09:07 -0700 (PDT)
Date:   Fri, 20 Sep 2019 10:09:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3b23f0592ff2089@google.com>
Subject: KASAN: use-after-free Read in usbvision_release
From:   syzbot <syzbot+d8c25680ec62d91f78fe@syzkaller.appspotmail.com>
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

HEAD commit:    e0bd8d79 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=12f037c9600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8847e5384a16f66a
dashboard link: https://syzkaller.appspot.com/bug?extid=d8c25680ec62d91f78fe
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d8c25680ec62d91f78fe@syzkaller.appspotmail.com

usb 6-1: usbvision_write_reg: failed: error -2
usbvision_audio_off: can't write reg
usbvision_radio_close: Final disconnect
==================================================================
BUG: KASAN: use-after-free in sysfs_remove_file_ns+0x5f/0x70  
fs/sysfs/file.c:467
Read of size 8 at addr ffff8881d42b03c0 by task v4l_id/7021

CPU: 1 PID: 7021 Comm: v4l_id Not tainted 5.3.0+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x6a/0x32c mm/kasan/report.c:351
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
  kasan_report+0xe/0x12 mm/kasan/common.c:618
  sysfs_remove_file_ns+0x5f/0x70 fs/sysfs/file.c:467
  sysfs_remove_file include/linux/sysfs.h:536 [inline]
  device_remove_file+0x25/0x30 drivers/base/core.c:1611
  usbvision_remove_sysfs drivers/media/usb/usbvision/usbvision-video.c:288  
[inline]
  usbvision_release+0x97/0x1c0  
drivers/media/usb/usbvision/usbvision-video.c:1339
  usbvision_radio_close.cold+0x6f/0x74  
drivers/media/usb/usbvision/usbvision-video.c:1113
  v4l2_release+0x2e7/0x390 drivers/media/v4l2-core/v4l2-dev.c:455
  __fput+0x2d7/0x840 fs/file_table.c:280
  task_work_run+0x13f/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x1d2/0x200 arch/x86/entry/common.c:163
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x45f/0x580 arch/x86/entry/common.c:300
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f0392c7d2b0
Code: 40 75 0b 31 c0 48 83 c4 08 e9 0c ff ff ff 48 8d 3d c5 32 08 00 e8 c0  
07 02 00 83 3d 45 a3 2b 00 00 75 10 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 31 c3 48 83 ec 08 e8 ce 8a 01 00 48 89 04 24
RSP: 002b:00007fff61410398 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00007f0392c7d2b0
RDX: 00007f0392f33df0 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007f0392f33df0 R09: 000000000000000a
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000400884
R13: 00007fff614104f0 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 101:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:493 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:466
  kmalloc include/linux/slab.h:552 [inline]
  kzalloc include/linux/slab.h:748 [inline]
  usbvision_alloc drivers/media/usb/usbvision/usbvision-video.c:1298 [inline]
  usbvision_probe.cold+0x5c5/0x1f1f  
drivers/media/usb/usbvision/usbvision-video.c:1452
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0xae6/0x16f0 drivers/base/core.c:2201
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
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

Freed by task 2734:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:455
  slab_free_hook mm/slub.c:1423 [inline]
  slab_free_freelist_hook mm/slub.c:1474 [inline]
  slab_free mm/slub.c:3016 [inline]
  kfree+0xe4/0x2f0 mm/slub.c:3957
  usbvision_release+0x181/0x1c0  
drivers/media/usb/usbvision/usbvision-video.c:1347
  usbvision_disconnect+0x16c/0x1d0  
drivers/media/usb/usbvision/usbvision-video.c:1570
  usb_unbind_interface+0x1bd/0x8a0 drivers/usb/core/driver.c:423
  __device_release_driver drivers/base/dd.c:1134 [inline]
  device_release_driver_internal+0x42f/0x500 drivers/base/dd.c:1165
  bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:532
  device_del+0x420/0xb10 drivers/base/core.c:2375
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

The buggy address belongs to the object at ffff8881d42b0000
  which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 960 bytes inside of
  8192-byte region [ffff8881d42b0000, ffff8881d42b2000)
The buggy address belongs to the page:
page:ffffea000750ac00 refcount:1 mapcount:0 mapping:ffff8881da00c500  
index:0x0 compound_mapcount: 0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 0000000000000000 0000000100000001 ffff8881da00c500
raw: 0000000000000000 0000000080030003 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d42b0280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d42b0300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881d42b0380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                            ^
  ffff8881d42b0400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d42b0480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
