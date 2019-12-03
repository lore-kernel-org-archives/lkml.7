Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3A6C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C0A2073C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfLCUPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 15:15:23 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:39386 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbfLCUPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 15:15:11 -0500
Received: by mail-io1-f70.google.com with SMTP id u13so3298954iol.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 12:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0gd16BcLnxoQDcUHfvdMRR4Bdp1gWQG0XmUMMbLF+V8=;
        b=tAvJAO5eaaAYb2IVG+DjGf50RkU4iV3J2hrC4kyaqZ7Zhr6fO9SF52NHevnkNQT5tv
         N6Uk8Jf7pAmyuOVJuIDoGbeoqm3SwhNf2VUgsTrMzwdhlod1P+6MeuX1cCEJXdufgHkV
         gT2hloDAy4l61qJFWXgb5cVZM3n76Pj94UcG0ASaEOO5dZwGHR2NzcUqWiBxlQ3pdc54
         o5x2F2jb7Dzw2AIeHkzsBI02JJeRO3NyEV5lSJir70W9PsvurVt/htRg6VhBjH0zkXZp
         cSBc6eQwCxdp5XBASwSsMonFLH1kuRWJ7KVpeXqRuMItgEgzMSp2aEJlw02yY0tQGh4d
         arbQ==
X-Gm-Message-State: APjAAAVNE0paDJXsKO1G0+QM5LiD71mCNB4NDwXG8dcL/zmZatkhu8sb
        0nrBfwdi5pkGj1L9vguJ6rMgP5tbyrSzGnYFddWwKYoG9n/8
X-Google-Smtp-Source: APXvYqwNFNTJ1WYTiJTv72iNEoj5CdIIjqcklyGmJS99WmuvwGtpJ5gF1Kc7x4awLVACLd84qCxX6JfrPrBInNmW5Txb3RDzu1VQ
MIME-Version: 1.0
X-Received: by 2002:a05:6602:156:: with SMTP id v22mr3647414iot.180.1575404110763;
 Tue, 03 Dec 2019 12:15:10 -0800 (PST)
Date:   Tue, 03 Dec 2019 12:15:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006663de0598d25ab1@google.com>
Subject: KASAN: use-after-free Write in release_tty
From:   syzbot <syzbot+522643ab5729b0421998@syzkaller.appspotmail.com>
To:     daniel.vetter@ffwll.ch, ghalat@redhat.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, nico@fluxnic.net, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com, textshell@uchuujin.de,
        tomli@tomli.me
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    596cf45c Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13dc7aeae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d8ab2e0e09c2a82
dashboard link: https://syzkaller.appspot.com/bug?extid=522643ab5729b0421998
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f5d59ce00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1214042ae00000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17b01edae00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14701edae00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10701edae00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+522643ab5729b0421998@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in con_shutdown+0x85/0x90  
drivers/tty/vt/vt.c:3278
Write of size 8 at addr ffff88809b797108 by task syz-executor613/9470

CPU: 0 PID: 9470 Comm: syz-executor613 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:638
  __asan_report_store8_noabort+0x17/0x20 mm/kasan/generic_report.c:140
  con_shutdown+0x85/0x90 drivers/tty/vt/vt.c:3278
  release_tty+0xd3/0x470 drivers/tty/tty_io.c:1511
  tty_release_struct+0x3c/0x50 drivers/tty/tty_io.c:1626
  tty_release+0xbcb/0xe90 drivers/tty/tty_io.c:1786
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x8e7/0x2ef0 kernel/exit.c:797
  do_group_exit+0x135/0x360 kernel/exit.c:895
  __do_sys_exit_group kernel/exit.c:906 [inline]
  __se_sys_exit_group kernel/exit.c:904 [inline]
  __x64_sys_exit_group+0x44/0x50 kernel/exit.c:904
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x443c38
Code: 00 00 be 3c 00 00 00 eb 19 66 0f 1f 84 00 00 00 00 00 48 89 d7 89 f0  
0f 05 48 3d 00 f0 ff ff 77 21 f4 48 89 d7 44 89 c0 0f 05 <48> 3d 00 f0 ff  
ff 76 e0 f7 d8 64 41 89 01 eb d8 0f 1f 84 00 00 00
RSP: 002b:00007ffd7eba55f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000443c38
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004c37b0 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 000000000000000f R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d5180 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 9465:
  save_stack+0x23/0x90 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_kmalloc mm/kasan/common.c:512 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:485
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:526
  kmem_cache_alloc_trace+0x158/0x790 mm/slab.c:3551
  kmalloc include/linux/slab.h:556 [inline]
  kzalloc include/linux/slab.h:670 [inline]
  vc_allocate drivers/tty/vt/vt.c:1085 [inline]
  vc_allocate+0x1fc/0x760 drivers/tty/vt/vt.c:1066
  con_install+0x52/0x410 drivers/tty/vt/vt.c:3229
  tty_driver_install_tty drivers/tty/tty_io.c:1228 [inline]
  tty_init_dev drivers/tty/tty_io.c:1341 [inline]
  tty_init_dev+0xf7/0x460 drivers/tty/tty_io.c:1318
  tty_open_by_driver drivers/tty/tty_io.c:1985 [inline]
  tty_open+0x4a5/0xbb0 drivers/tty/tty_io.c:2033
  chrdev_open+0x245/0x6b0 fs/char_dev.c:414
  do_dentry_open+0x4e6/0x1380 fs/open.c:797
  vfs_open+0xa0/0xd0 fs/open.c:914
  do_last fs/namei.c:3412 [inline]
  path_openat+0x10e4/0x4710 fs/namei.c:3529
  do_filp_open+0x1a1/0x280 fs/namei.c:3559
  do_sys_open+0x3fe/0x5d0 fs/open.c:1097
  __do_sys_open fs/open.c:1115 [inline]
  __se_sys_open fs/open.c:1110 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1110
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 9471:
  save_stack+0x23/0x90 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  kasan_set_free_info mm/kasan/common.c:334 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:473
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:482
  __cache_free mm/slab.c:3426 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3757
  vt_disallocate_all+0x2bd/0x3e0 drivers/tty/vt/vt_ioctl.c:323
  vt_ioctl+0xc38/0x26d0 drivers/tty/vt/vt_ioctl.c:816
  tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2658
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:539 [inline]
  do_vfs_ioctl+0xdb6/0x13e0 fs/ioctl.c:726
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:743
  __do_sys_ioctl fs/ioctl.c:750 [inline]
  __se_sys_ioctl fs/ioctl.c:748 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:748
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88809b797000
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 264 bytes inside of
  2048-byte region [ffff88809b797000, ffff88809b797800)
The buggy address belongs to the page:
page:ffffea00026de5c0 refcount:1 mapcount:0 mapping:ffff8880aa400e00  
index:0x0
raw: 00fffe0000000200 ffffea00025c8248 ffffea00023a9a88 ffff8880aa400e00
raw: 0000000000000000 ffff88809b797000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88809b797000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88809b797080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88809b797100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                       ^
  ffff88809b797180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88809b797200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
