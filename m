Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DATE_IN_PAST_03_06,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9CCC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAC020652
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfDSS2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:28:06 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:41674 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfDSS2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:28:06 -0400
Received: by mail-io1-f72.google.com with SMTP id e126so5197620ioa.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=tFKuCP5sWc3Lw1+DiSI04bLvA52hIWgjARkMR8y4QLc=;
        b=d3hXRZ57yC9sPg3ldjrAynBM2pafWqSGSdR2t60dKSHIMeW2+bWbtgxFNepwtHIZex
         5KH4X2qlZrueKXBeMoPFU2ptVgibmqHRGNzh4Ff3ZRjtMnGz30UXYNbPgxXCJJYGsYCt
         zPXph23fjMetSwe8BKtw8Fz8dt51An+VJLPMZhofZeUFxLj3TmcyQJGIiIO5+h2qo2tD
         IjokJWjCftkWVQM21VZczJNFsn7hh9gpjM9kmAbaCtCC8phiJ6ltNpDm8Vqvn+mmvR4s
         /oZxFgo2n/LBflz+DVg9WeyNoDOab3WKMxcoofqi0Q70GmZZk/DBolm2ipV4wJub7qc/
         +9sg==
X-Gm-Message-State: APjAAAV/7Y7V3Q1778GeXcXOY/qFsFn8MiUbzKmrYQdb6KF86WsALObM
        0HTfgpBheBl9HsAKd7R+eJE9ZsqEuR7S2TRnQSgZA9bOw3ez
X-Google-Smtp-Source: APXvYqw603Z0rIRcAIvSGSxVl7pXCqLPjmimWzd9Gz02pUh89kkfG2GJpdpETTeFWdAhVSxYQaomna+K1vN7v3vJAc5nOs1wWfIZ
MIME-Version: 1.0
X-Received: by 2002:a24:70d5:: with SMTP id f204mr3014431itc.32.1555684565732;
 Fri, 19 Apr 2019 07:36:05 -0700 (PDT)
Date:   Fri, 19 Apr 2019 07:36:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec53de0586e309fc@google.com>
Subject: KASAN: use-after-free Read in v4l2_fh_init
From:   syzbot <syzbot+c025d34b8eaa54c571b8@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, hans.verkuil@cisco.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, sakari.ailus@linux.intel.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d34f9519 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=125bbb5b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c73d1bb5aeaeae20
dashboard link: https://syzkaller.appspot.com/bug?extid=c025d34b8eaa54c571b8
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1513ac1d200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13555c1d200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c025d34b8eaa54c571b8@syzkaller.appspotmail.com

em28xx 1-1:5.176: failed to create media graph
em28xx 1-1:5.176: V4L2 device video32 deregistered
em28xx 1-1:5.176: Binding DVB extension
==================================================================
em28xx 1-1:5.176: no endpoint for DVB mode and transfer type 0
BUG: KASAN: use-after-free in v4l2_fh_init+0x24c/0x290  
drivers/media/v4l2-core/v4l2-fh.c:33
Read of size 8 at addr ffff8880a4f149d0 by task v4l_id/5313

CPU: 1 PID: 5313 Comm: v4l_id Not tainted 5.1.0-rc5-319617-gd34f951 #4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
em28xx 1-1:5.176: failed to pre-allocate USB transfer buffers for DVB.
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xe8/0x16e lib/dump_stack.c:113
  print_address_description+0x6c/0x236 mm/kasan/report.c:187
em28xx 1-1:5.176: Registering input extension
  kasan_report.cold+0x1a/0x3c mm/kasan/report.c:317
  v4l2_fh_init+0x24c/0x290 drivers/media/v4l2-core/v4l2-fh.c:33
  v4l2_fh_open+0x8d/0xd0 drivers/media/v4l2-core/v4l2-fh.c:71
  em28xx_v4l2_open+0x11f/0x470 drivers/media/usb/em28xx/em28xx-video.c:2184
  v4l2_open+0x1b6/0x360 drivers/media/v4l2-core/v4l2-dev.c:427
  chrdev_open+0x220/0x5d0 fs/char_dev.c:417
  do_dentry_open+0x49c/0x1130 fs/open.c:777
  do_last fs/namei.c:3416 [inline]
  path_openat+0x147d/0x40b0 fs/namei.c:3533
  do_filp_open+0x1a6/0x280 fs/namei.c:3563
  do_sys_open+0x3c5/0x590 fs/open.c:1069
  do_syscall_64+0xcf/0x4f0 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7fdb23b8d120
Code: 48 8b 15 1b 4d 2b 00 f7 d8 64 89 02 83 c8 ff c3 90 90 90 90 90 90 90  
90 90 90 83 3d d5 a4 2b 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 31 c3 48 83 ec 08 e8 5e 8c 01 00 48 89 04 24
RSP: 002b:00007ffc1aebde18 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007ffc1aebdf78 RCX: 00007fdb23b8d120
RDX: 00007fdb23e42138 RSI: 0000000000000000 RDI: 00007ffc1aebef17
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000400884
R13: 00007ffc1aebdf70 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 12:
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:470
  kmalloc include/linux/slab.h:547 [inline]
  kzalloc include/linux/slab.h:742 [inline]
  em28xx_v4l2_init drivers/media/usb/em28xx/em28xx-video.c:2563 [inline]
  em28xx_v4l2_init.cold+0x93/0x3112  
drivers/media/usb/em28xx/em28xx-video.c:2541
  em28xx_init_extension+0x13a/0x200  
drivers/media/usb/em28xx/em28xx-core.c:1128
  request_module_async+0x62/0x70 drivers/media/usb/em28xx/em28xx-cards.c:3300
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Freed by task 12:
  set_track mm/kasan/common.c:87 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:459
  slab_free_hook mm/slub.c:1429 [inline]
  slab_free_freelist_hook+0x5e/0x140 mm/slub.c:1456
  slab_free mm/slub.c:3003 [inline]
  kfree+0xce/0x280 mm/slub.c:3958
  em28xx_free_v4l2 drivers/media/usb/em28xx/em28xx-video.c:2149 [inline]
  kref_put include/linux/kref.h:67 [inline]
  em28xx_v4l2_init drivers/media/usb/em28xx/em28xx-video.c:2920 [inline]
  em28xx_v4l2_init.cold+0x2cf/0x3112  
drivers/media/usb/em28xx/em28xx-video.c:2541
  em28xx_init_extension+0x13a/0x200  
drivers/media/usb/em28xx/em28xx-core.c:1128
  request_module_async+0x62/0x70 drivers/media/usb/em28xx/em28xx-cards.c:3300
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8880a4f14200
  which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 2000 bytes inside of
  8192-byte region [ffff8880a4f14200, ffff8880a4f16200)
The buggy address belongs to the page:
page:ffffea000293c400 count:1 mapcount:0 mapping:ffff88812c3f4400 index:0x0  
compound_mapcount: 0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 dead000000000100 dead000000000200 ffff88812c3f4400
raw: 0000000000000000 0000000080030003 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a4f14880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880a4f14900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8880a4f14980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                  ^
  ffff8880a4f14a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880a4f14a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
