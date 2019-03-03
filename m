Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2F7C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 18:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD85A20866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 18:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfCCSWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 13:22:06 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:42102 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfCCSWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 13:22:05 -0500
Received: by mail-it1-f198.google.com with SMTP id j127so3486630itj.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 10:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vq+coFeOZYW1Luk8hOVv2/1ejIbbUmZl8GvqxIw37iU=;
        b=ONETnP+mrh3AHRbhhvX6j2iBh1F6AVS1Nuht34m9zsCXMQ83WNptk9zIUU7nfeRpod
         TwAKrYScyF04XSS3efgcXQDOl26oBq29p+XD7cTWOru15aIwFqKr0OOp2X69eaCTVPxg
         4L3lv6BZBcAG+QCCJfxzSelgLNxeePCNTLo5sY9pIYpoNHdaUvEHgQja1p6089ufJpyD
         vxLx7CWZMXZJ5OFLKyBVQZ1mtyZYAwoIV/PgAE/eN0IOD1ZZMD2kz9/7ydApuMkj0lc5
         v+7RjilJKTu+q7DO3cMps8xN0Pa/ptv6lhigZ9VidTxa8Hpg3VXGLxj2BWNJpbjx2o0T
         c08A==
X-Gm-Message-State: AHQUAubHX5RsHhdhZyl0vl+zX0SMQObyHOnktI8JgUqCfM5n2KsPmVfh
        pyNCJ/jRqL5vZiOcQ4gypM6lLqQjjgOfnlLEZHYlVNqEblfk
X-Google-Smtp-Source: APXvYqxxFcqHngwy47FQX7SaY6NP2ZdG5CRnvy+Zoi51nxBSQK2LspDyuM4UKdfG1lSLn1Q9H1XCtz2re6ms/QOvWC012QnwJExN
MIME-Version: 1.0
X-Received: by 2002:a24:560e:: with SMTP id o14mr9372553itb.15.1551637324398;
 Sun, 03 Mar 2019 10:22:04 -0800 (PST)
Date:   Sun, 03 Mar 2019 10:22:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a8bf4058334b76e@google.com>
Subject: KASAN: use-after-free Read in alloc_workqueue
From:   syzbot <syzbot+17335689e239ce135d8b@syzkaller.appspotmail.com>
To:     danitg@mellanox.com, dledford@redhat.com, jgg@ziepe.ca,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, roland@purestorage.com,
        sean.hefty@intel.com, swise@opengridcomputing.com,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c63e9e91a254 Add linux-next specific files for 20190301
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16ac728d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5875f9dc6e009b2
dashboard link: https://syzkaller.appspot.com/bug?extid=17335689e239ce135d8b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134808fb200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1541889d200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+17335689e239ce135d8b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __read_once_size include/linux/compiler.h:197  
[inline]
BUG: KASAN: use-after-free in lockdep_register_key+0x3b9/0x490  
kernel/locking/lockdep.c:1023
Read of size 8 at addr ffff888090fc2698 by task syz-executor134/7858

CPU: 1 PID: 7858 Comm: syz-executor134 Not tainted 5.0.0-rc8-next-20190301  
#1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  __read_once_size include/linux/compiler.h:197 [inline]
  lockdep_register_key+0x3b9/0x490 kernel/locking/lockdep.c:1023
  wq_init_lockdep kernel/workqueue.c:3444 [inline]
  alloc_workqueue+0x427/0xe70 kernel/workqueue.c:4263
  ucma_open+0x76/0x290 drivers/infiniband/core/ucma.c:1732
  misc_open+0x398/0x4c0 drivers/char/misc.c:141
  chrdev_open+0x247/0x6b0 fs/char_dev.c:417
  do_dentry_open+0x488/0x1160 fs/open.c:771
  vfs_open+0xa0/0xd0 fs/open.c:880
  do_last fs/namei.c:3416 [inline]
  path_openat+0x10e9/0x46e0 fs/namei.c:3533
  do_filp_open+0x1a1/0x280 fs/namei.c:3563
  do_sys_open+0x3fe/0x5d0 fs/open.c:1063
  __do_sys_openat fs/open.c:1090 [inline]
  __se_sys_openat fs/open.c:1084 [inline]
  __x64_sys_openat+0x9d/0x100 fs/open.c:1084
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440fc9
Code: e8 0c ad 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc1cccc9c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000440fc9
RDX: 0000000000000002 RSI: 0000000020000140 RDI: ffffffffffffff9c
RBP: 00007ffc1cccc9e0 R08: 0000000000000002 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 7789:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:470
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:511
  __do_kmalloc mm/slab.c:3726 [inline]
  __kmalloc+0x15c/0x740 mm/slab.c:3735
  kmalloc include/linux/slab.h:553 [inline]
  kzalloc include/linux/slab.h:743 [inline]
  alloc_workqueue+0x13c/0xe70 kernel/workqueue.c:4236
  ucma_open+0x76/0x290 drivers/infiniband/core/ucma.c:1732
  misc_open+0x398/0x4c0 drivers/char/misc.c:141
  chrdev_open+0x247/0x6b0 fs/char_dev.c:417
  do_dentry_open+0x488/0x1160 fs/open.c:771
  vfs_open+0xa0/0xd0 fs/open.c:880
  do_last fs/namei.c:3416 [inline]
  path_openat+0x10e9/0x46e0 fs/namei.c:3533
  do_filp_open+0x1a1/0x280 fs/namei.c:3563
  do_sys_open+0x3fe/0x5d0 fs/open.c:1063
  __do_sys_openat fs/open.c:1090 [inline]
  __se_sys_openat fs/open.c:1084 [inline]
  __x64_sys_openat+0x9d/0x100 fs/open.c:1084
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 7789:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:459
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:467
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3821
  alloc_workqueue+0xc3e/0xe70 kernel/workqueue.c:4295
  ucma_open+0x76/0x290 drivers/infiniband/core/ucma.c:1732
  misc_open+0x398/0x4c0 drivers/char/misc.c:141
  chrdev_open+0x247/0x6b0 fs/char_dev.c:417
  do_dentry_open+0x488/0x1160 fs/open.c:771
  vfs_open+0xa0/0xd0 fs/open.c:880
  do_last fs/namei.c:3416 [inline]
  path_openat+0x10e9/0x46e0 fs/namei.c:3533
  do_filp_open+0x1a1/0x280 fs/namei.c:3563
  do_sys_open+0x3fe/0x5d0 fs/open.c:1063
  __do_sys_openat fs/open.c:1090 [inline]
  __se_sys_openat fs/open.c:1084 [inline]
  __x64_sys_openat+0x9d/0x100 fs/open.c:1084
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff888090fc2580
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 280 bytes inside of
  512-byte region [ffff888090fc2580, ffff888090fc2780)
The buggy address belongs to the page:
page:ffffea000243f080 count:1 mapcount:0 mapping:ffff88812c3f0940  
index:0xffff888090fc2300
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea0002417248 ffffea00024751c8 ffff88812c3f0940
raw: ffff888090fc2300 ffff888090fc2080 0000000100000004 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888090fc2580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888090fc2600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff888090fc2680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                             ^
  ffff888090fc2700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888090fc2780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
