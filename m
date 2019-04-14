Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2420C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A669120850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfDNUGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:06:25 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:38695 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfDNUGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:06:08 -0400
Received: by mail-io1-f72.google.com with SMTP id b16so12631043iot.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 13:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xzpplSQc0IF1EBkBs4nXasllUCC6NwB9+uu6J8wjItI=;
        b=ah5eNQNaraSwx8aF6uwseJbVpJdkvnv7yLR5Di9xkk6MBTu3vqH7s3Vc2fDqhuqEgS
         HUvieyAOJOk3etclc0WD8Rq97rdDUHxtVg7lcGzq+x7NRrrod9Ui+cEXoA4LBp/2KMlQ
         1IIKEm7+b0Gd8T2/OsO/jZy9vjfj8wVdxjWh0gkAb8GA6kUCdNuoEVwpqbHARPVH72Fe
         KsLb26JNV1La5W5B60jFqBxeTg/EGPX7Tz8lOsYHMN/rNtus5vzYPzAlwRz17F18ZZ/A
         Aypgx0Bj3r0aGxfHX5tEKxWaGZuBgW4sN61gzCoN6v/e34Jzon0ewCowWpY68jOtsa1e
         vAew==
X-Gm-Message-State: APjAAAWyT4HfJ9dXAgAl5n/zYf/p6rUxfXviBTFni+wfZMNitl8a0Mu2
        6UZHMBCIou0zKY+c9qrhkEg/qpxtsne0aR56Loi/bqAyrEah
X-Google-Smtp-Source: APXvYqytLQqlAfBn6iUUUTvmDEXJjBpuTqAKN3QoyShXadfLvQeI4yHIiNJuBHx2T8Iin6izyX0T9IS8qB7qcH9KGRZDE8yCUHd9
MIME-Version: 1.0
X-Received: by 2002:a5d:899a:: with SMTP id m26mr12618248iol.5.1555272367828;
 Sun, 14 Apr 2019 13:06:07 -0700 (PDT)
Date:   Sun, 14 Apr 2019 13:06:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003799c05868311b9@google.com>
Subject: KASAN: use-after-free Read in v4l2_ioctl
From:   syzbot <syzbot+d587871cd33a9bc7c086@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, ezequiel@collabora.com,
        hans.verkuil@cisco.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, niklas.soderlund+renesas@ragnatech.se,
        sakari.ailus@linux.intel.com, sque@chromium.org,
        syzkaller-bugs@googlegroups.com, tfiga@chromium.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=137d8a2d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
dashboard link: https://syzkaller.appspot.com/bug?extid=d587871cd33a9bc7c086
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e878f3200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102432e3200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d587871cd33a9bc7c086@syzkaller.appspotmail.com

usb 6-1: USB disconnect, device number 19
radio-raremono 6-1:0.210: Thanko's Raremono disconnected
radio-si470x 2-1:0.210: could not find interrupt in endpoint
radio-si470x 3-1:0.210: could not find interrupt in endpoint
==================================================================
BUG: KASAN: use-after-free in v4l2_ioctl+0x187/0x1a0  
drivers/media/v4l2-core/v4l2-dev.c:362
Read of size 8 at addr ffff88809b3645e0 by task v4l_id/5799
radio-si470x 4-1:0.210: could not find interrupt in endpoint

CPU: 0 PID: 5799 Comm: v4l_id Not tainted 5.1.0-rc4-319354-g9a33b36 #3
radio-si470x: probe of 4-1:0.210 failed with error -5
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xe8/0x16e lib/dump_stack.c:113
  print_address_description+0x6c/0x236 mm/kasan/report.c:187
radio-si470x: probe of 2-1:0.210 failed with error -5
  kasan_report.cold+0x1a/0x3c mm/kasan/report.c:317
  v4l2_ioctl+0x187/0x1a0 drivers/media/v4l2-core/v4l2-dev.c:362
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xced/0x12f0 fs/ioctl.c:696
usb 5-1: new high-speed USB device number 19 using dummy_hcd
radio-si470x: probe of 3-1:0.210 failed with error -5
  ksys_ioctl+0xa0/0xc0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x74/0xb0 fs/ioctl.c:718
  do_syscall_64+0xcf/0x4f0 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f435c835347
Code: 90 90 90 48 8b 05 f1 fa 2a 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff  
ff c3 90 90 90 90 90 90 90 90 90 90 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 01 c3 48 8b 0d c1 fa 2a 00 31 d2 48 29 c2 64
radio-raremono 2-1:0.210: Thanko's Raremono connected: (10C4:818A)
RSP: 002b:00007ffeca71fda8 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f435c835347
RDX: 00007ffeca71fdb0 RSI: 0000000080685600 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000400884
R13: 00007ffeca71ff00 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 12:
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:470
  slab_post_alloc_hook mm/slab.h:437 [inline]
  slab_alloc_node mm/slub.c:2756 [inline]
  __kmalloc_node_track_caller+0xf3/0x320 mm/slub.c:4372
  alloc_dr drivers/base/devres.c:103 [inline]
  devm_kmalloc+0x8c/0x190 drivers/base/devres.c:793
  devm_kzalloc include/linux/device.h:679 [inline]
  usb_raremono_probe+0x34/0x235 drivers/media/radio/radio-raremono.c:298
radio-raremono 3-1:0.210: Thanko's Raremono connected: (10C4:818A)
  usb_probe_interface+0x31d/0x820 drivers/usb/core/driver.c:361
  really_probe+0x2da/0xb10 drivers/base/dd.c:509
radio-raremono 4-1:0.210: Thanko's Raremono connected: (10C4:818A)
  driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
  __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
  __device_attach+0x223/0x3a0 drivers/base/dd.c:844
usb 1-1: new high-speed USB device number 19 using dummy_hcd
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
usb 5-1: Using ep0 maxpacket: 8
  device_add+0xad2/0x16e0 drivers/base/core.c:2106
  usb_new_device.cold+0x537/0xccf drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x138e/0x3b00 drivers/usb/core/hub.c:5432
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
radio-raremono 2-1:0.210: raremono_cmd_main failed (-71)
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x7b0/0xe20 kernel/workqueue.c:2417
radio-raremono 4-1:0.210: raremono_cmd_main failed (-71)
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Freed by task 12:
radio-raremono 2-1:0.210: V4L2 device registered as radio33
  set_track mm/kasan/common.c:87 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:459
radio-raremono 4-1:0.210: V4L2 device registered as radio34
  slab_free_hook mm/slub.c:1429 [inline]
  slab_free_freelist_hook+0x5e/0x140 mm/slub.c:1456
  slab_free mm/slub.c:3003 [inline]
  kfree+0xce/0x290 mm/slub.c:3958
  release_nodes+0x4ac/0x920 drivers/base/devres.c:508
  devres_release_all+0x79/0xc8 drivers/base/devres.c:529
  __device_release_driver drivers/base/dd.c:1086 [inline]
  device_release_driver_internal+0x23a/0x4f0 drivers/base/dd.c:1113
  bus_remove_device+0x302/0x5c0 drivers/base/bus.c:556
  device_del+0x467/0xb90 drivers/base/core.c:2269
  usb_disable_device+0x242/0x790 drivers/usb/core/message.c:1235
  usb_disconnect+0x298/0x870 drivers/usb/core/hub.c:2197
  hub_port_connect drivers/usb/core/hub.c:4940 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0xcd2/0x3b00 drivers/usb/core/hub.c:5432
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x7b0/0xe20 kernel/workqueue.c:2417
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff88809b364400
  which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 480 bytes inside of
  4096-byte region [ffff88809b364400, ffff88809b365400)
The buggy address belongs to the page:
page:ffffea00026cd800 count:1 mapcount:0 mapping:ffff88812c3f4600 index:0x0  
compound_mapcount: 0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 dead000000000100 dead000000000200 ffff88812c3f4600
radio-raremono 3-1:0.210: raremono_cmd_main failed (-71)
raw: 0000000000000000 0000000000070007 00000001ffffffff 0000000000000000
radio-raremono 3-1:0.210: V4L2 device registered as radio35
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88809b364480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88809b364500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88809b364580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                        ^
  ffff88809b364600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88809b364680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
