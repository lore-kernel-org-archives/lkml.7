Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866B7C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 07:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584452071E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 07:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfLIHFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 02:05:10 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:34645 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfLIHFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 02:05:10 -0500
Received: by mail-io1-f70.google.com with SMTP id n26so5127680ioj.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 23:05:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1GgC0mI0+9WtgNdAkkuAPFMFXxxdmphE3Bk0ZQaortg=;
        b=ryRWzJN+9xY6kQ/yJdGYFZTO5v+w1e6OoQUI5xvkMuTCPqia3sBftfuksUbGDSlE/m
         nBQF84+xyhDw5KyV+fP6YSWPNlgeghBOK3DMcsB1qbYFhPtfW2MpjrDTokimLK9AYDGF
         ESbOlKcTE+RO1s0dsejAphj6RGKB0j6dRDnQvt0letnCvqgat7/xUbRAfyubgkA56ltT
         dE/r/gQNzrQdFKTjonZ7gl/fWtAwaU79IHJXfDxdRZSe8kND/fu/NhEsNLyt5ip1cK08
         f3gxxsu8VAW9yNSs3zqp72Dv+as5JGVbhcB6eCHKUPyAZSv9ZXfuN6GVi/ClwzqK/nlq
         +nDw==
X-Gm-Message-State: APjAAAWP3AFHrRbxDNFFTJHT6n5C1CAyU4ahzz5AzRq7NCEX1GvFdV7Z
        f1oL0T98aCTwT+U+p1PRmsRetOpzP5ObXUFXGcpeuVUmk+pv
X-Google-Smtp-Source: APXvYqwvRtp9AVnQZCXyyBJa3kJ+3OzNXD+XpWUDSDC1v9I/CEyn0sWnTCW6TC9MdnlFF33mRp+4SS2/G3nYrd4vLl8YxUQLYHIp
MIME-Version: 1.0
X-Received: by 2002:a92:8309:: with SMTP id f9mr3915237ild.50.1575875109156;
 Sun, 08 Dec 2019 23:05:09 -0800 (PST)
Date:   Sun, 08 Dec 2019 23:05:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001783610599400420@google.com>
Subject: KASAN: use-after-free Read in get_work_pool (2)
From:   syzbot <syzbot+6a7d71142d61b8c7c8d0@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9455d25f Merge tag 'ntb-5.5' of git://github.com/jonmason/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15fa41dae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3b8f5088d4043a
dashboard link: https://syzkaller.appspot.com/bug?extid=6a7d71142d61b8c7c8d0
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160007f2e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1476e59ce00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6a7d71142d61b8c7c8d0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in atomic64_read  
include/asm-generic/atomic-instrumented.h:836 [inline]
BUG: KASAN: use-after-free in atomic_long_read  
include/asm-generic/atomic-long.h:28 [inline]
BUG: KASAN: use-after-free in get_work_pool+0x1c/0x1b0  
kernel/workqueue.c:707
Read of size 8 at addr ffff888093492008 by task syz-executor803/9732

CPU: 1 PID: 9732 Comm: syz-executor803 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
  __kasan_check_read+0x11/0x20 mm/kasan/common.c:95
  atomic64_read include/asm-generic/atomic-instrumented.h:836 [inline]
  atomic_long_read include/asm-generic/atomic-long.h:28 [inline]
  get_work_pool+0x1c/0x1b0 kernel/workqueue.c:707
  start_flush_work kernel/workqueue.c:2979 [inline]
  __flush_work+0x153/0xa50 kernel/workqueue.c:3040
  __cancel_work_timer+0x3d9/0x540 kernel/workqueue.c:3128
  cancel_work_sync+0x18/0x20 kernel/workqueue.c:3164
  tty_buffer_cancel_work+0x16/0x20 drivers/tty/tty_buffer.c:613
  release_tty+0x261/0x470 drivers/tty/tty_io.c:1520
  tty_release_struct+0x3c/0x50 drivers/tty/tty_io.c:1629
  tty_release+0xbcb/0xe90 drivers/tty/tty_io.c:1789
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
RIP: 0033:0x43ff38
Code: Bad RIP value.
RSP: 002b:00007ffc3c6d7428 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043ff38
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004bf950 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000000000064 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d2180 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 9732:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  __kasan_kmalloc mm/kasan/common.c:513 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:486
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:527
  kmem_cache_alloc_trace+0x158/0x790 mm/slab.c:3551
  kmalloc include/linux/slab.h:556 [inline]
  kzalloc include/linux/slab.h:670 [inline]
  vc_allocate drivers/tty/vt/vt.c:1085 [inline]
  vc_allocate+0x1fc/0x760 drivers/tty/vt/vt.c:1066
  con_install+0x52/0x410 drivers/tty/vt/vt.c:3229
  tty_driver_install_tty drivers/tty/tty_io.c:1228 [inline]
  tty_init_dev drivers/tty/tty_io.c:1341 [inline]
  tty_init_dev+0xf9/0x470 drivers/tty/tty_io.c:1318
  tty_open_by_driver drivers/tty/tty_io.c:1987 [inline]
  tty_open+0x4a5/0xbb0 drivers/tty/tty_io.c:2035
  chrdev_open+0x245/0x6b0 fs/char_dev.c:414
  do_dentry_open+0x4e6/0x1380 fs/open.c:797
  vfs_open+0xa0/0xd0 fs/open.c:914
  do_last fs/namei.c:3420 [inline]
  path_openat+0x10df/0x4500 fs/namei.c:3537
  do_filp_open+0x1a1/0x280 fs/namei.c:3567
  do_sys_open+0x3fe/0x5d0 fs/open.c:1097
  __do_sys_open fs/open.c:1115 [inline]
  __se_sys_open fs/open.c:1110 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1110
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 9731:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  kasan_set_free_info mm/kasan/common.c:335 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:474
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:483
  __cache_free mm/slab.c:3426 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3757
  vt_disallocate_all+0x2bd/0x3e0 drivers/tty/vt/vt_ioctl.c:323
  vt_ioctl+0xc38/0x26d0 drivers/tty/vt/vt_ioctl.c:816
  tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2660
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff888093492000
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 8 bytes inside of
  2048-byte region [ffff888093492000, ffff888093492800)
The buggy address belongs to the page:
page:ffffea00024d2480 refcount:1 mapcount:0 mapping:ffff8880aa400e00  
index:0x0
raw: 00fffe0000000200 ffffea00027f3548 ffffea00024d45c8 ffff8880aa400e00
raw: 0000000000000000 ffff888093492000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888093491f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff888093491f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ffff888093492000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                       ^
  ffff888093492080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888093492100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
