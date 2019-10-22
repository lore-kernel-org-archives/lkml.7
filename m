Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36B4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FEB21783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732183AbfJVOyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 10:54:16 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:56021 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732116AbfJVOyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 10:54:08 -0400
Received: by mail-io1-f70.google.com with SMTP id c67so7839640iof.22
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 07:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hlECRNMF9/Dcog0fXQwfMguK+dd6dHC2mY/0ASSq8Ao=;
        b=MOm+29ecftHwhef7sGbaszRbPcKKFuIq8VAy0oqpWM3tcps3SbXFYw6mYvMkxdC28r
         T4rJyUM5gxxRQibxrDwQCZOsmzFRGJYOitsKNi4+j62dulljBxO7E4MqpDJpP7WZyAwU
         g6QO+y1Z4KxLelHzHOVyjXmWfxhIaB2haM0aS5cj1RAtr836Hvc3lh1VP7cCjIW25bzK
         11Qg/A93pOBJ8kiKPbg3kYX6F/6Q1MC9W/LcKjKFtlbn9INxSL7alT+ucQcIGT1KrXac
         feYdyV0ROy0nDwvDwyHSnc4Dik1LU/hO0VF50nB0ynKJSHVgQ257uY5zZpUt0wLgGSIC
         qPcA==
X-Gm-Message-State: APjAAAWVUDLGLHDzLMljSMIrZNgedo2VI8kwxUN3cp0uKd3/jAOl8eaP
        9QlEN6Qt03eVZZm/jSpMb/7L1SKvKzW0v0Gd7vh+y+BZLqfG
X-Google-Smtp-Source: APXvYqwTTQwDtRAqy2PAr5hfmI9vhO9a0aixCe27mrULHDqHaHGfgJbfaN4pNHQ7EHRZSdHF2z/aEiac8HHNfM2UvghiA5VECB8y
MIME-Version: 1.0
X-Received: by 2002:a6b:2c89:: with SMTP id s131mr3988950ios.276.1571756047686;
 Tue, 22 Oct 2019 07:54:07 -0700 (PDT)
Date:   Tue, 22 Oct 2019 07:54:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e56434059580f86e@google.com>
Subject: KASAN: slab-out-of-bounds Read in read_descriptors
From:   syzbot <syzbot+11eed0a63c4f31acd096@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        kai.heng.feng@canonical.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tweek@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    22be26f7 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=17bf83e8e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=387eccb7ac68ec5
dashboard link: https://syzkaller.appspot.com/bug?extid=11eed0a63c4f31acd096
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+11eed0a63c4f31acd096@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in read_descriptors+0x256/0x270  
drivers/usb/core/sysfs.c:903
Read of size 8 at addr ffff8881ce6e4350 by task udevd/9454

CPU: 1 PID: 9454 Comm: udevd Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description.constprop.0+0x36/0x50 mm/kasan/report.c:374
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:506
  kasan_report+0xe/0x20 mm/kasan/common.c:634
  read_descriptors+0x256/0x270 drivers/usb/core/sysfs.c:903
  sysfs_kf_bin_read+0x196/0x270 fs/sysfs/file.c:99
  kernfs_file_direct_read fs/kernfs/file.c:213 [inline]
  kernfs_fop_read+0x2eb/0x560 fs/kernfs/file.c:253
  __vfs_read+0x76/0x100 fs/read_write.c:425
  vfs_read+0x1ea/0x430 fs/read_write.c:461
  ksys_read+0x127/0x250 fs/read_write.c:587
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f10f2702310
Code: 73 01 c3 48 8b 0d 28 4b 2b 00 31 d2 48 29 c2 64 89 11 48 83 c8 ff eb  
ea 90 90 83 3d e5 a2 2b 00 00 75 10 b8 00 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 31 c3 48 83 ec 08 e8 6e 8a 01 00 48 89 04 24
RSP: 002b:00007ffd6a810e48 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f10f2702310
RDX: 0000000000010011 RSI: 00007ffd6a810e80 RDI: 0000000000000005
RBP: 000000000174e640 R08: 000000000000000c R09: 75642f6d726f6674
R10: 2e6463685f796d6d R11: 0000000000000246 R12: 00007ffd6a821590
R13: 0000000001741250 R14: 0000000000000000 R15: 00000000017421c0

Allocated by task 22:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:510 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:483
  kmalloc include/linux/slab.h:561 [inline]
  kzalloc include/linux/slab.h:690 [inline]
  usb_get_configuration+0x184/0x3050 drivers/usb/core/config.c:825
  usb_enumerate_device drivers/usb/core/hub.c:2369 [inline]
  usb_new_device+0xd3/0x160 drivers/usb/core/hub.c:2505
  hub_port_connect drivers/usb/core/hub.c:5183 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5323 [inline]
  port_event drivers/usb/core/hub.c:5469 [inline]
  hub_event+0x1dd0/0x37e0 drivers/usb/core/hub.c:5551
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 2807:
  save_stack+0x1b/0x80 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  kasan_set_free_info mm/kasan/common.c:332 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:471
  slab_free_hook mm/slub.c:1424 [inline]
  slab_free_freelist_hook mm/slub.c:1475 [inline]
  slab_free mm/slub.c:3018 [inline]
  kfree+0xe4/0x320 mm/slub.c:3967
  usb_set_configuration+0xba8/0x1670 drivers/usb/core/message.c:1962
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

The buggy address belongs to the object at ffff8881ce6e4348
  which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of
  8-byte region [ffff8881ce6e4348, ffff8881ce6e4350)
The buggy address belongs to the page:
page:ffffea000739b900 refcount:1 mapcount:0 mapping:ffff8881da003900  
index:0x0
flags: 0x200000000000200(slab)
raw: 0200000000000200 ffffea0007632e40 0000000a0000000a ffff8881da003900
raw: 0000000000000000 0000000000aa00aa 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881ce6e4200: fc fc fb fc fc fb fc fc fb fc fc fb fc fc fb fc
  ffff8881ce6e4280: fc fb fc fc fb fc fc fb fc fc fb fc fc fb fc fc
> ffff8881ce6e4300: fb fc fc fb fc fc fb fc fc 00 fc fc fb fc fc fb
                                                  ^
  ffff8881ce6e4380: fc fc fb fc fc fb fc fc fb fc fc fb fc fc fb fc
  ffff8881ce6e4400: fc fb fc fc fb fc fc fb fc fc fb fc fc fb fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
