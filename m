Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD27C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCB02173E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfLFPzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:55:09 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:54897 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfLFPzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 10:55:09 -0500
Received: by mail-io1-f69.google.com with SMTP id h10so3526108iov.21
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 07:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9EmtCeEEe3wX/SoiDrjViIhIi/b3ldypHBjiGgo1Vp8=;
        b=NVW6fDM+q1kptJGHFwleL+gF+HrDaajXmLQ1N7609LDarLiUW6VIHiqg73hLS8JaIM
         Zx5Jol1PoW/geZAsZ9k2POCKAXbR1vjZMPr4L4mDCXkoY+7egul7Ko0Spmg7Ty92ognt
         7sJzZYh73QgdhardszZqaJG/DlA7YzHHs2vqiJW92aOLM0UubGPTz4IwOc4hNJdAimaq
         JPqfmW00+zlpxYO2XIjVqz7bKqyP3mIa4ZP7yejgWH+Ox/zDeDUE4/iPQX0uennO0DnA
         ncLJKJyLS/0NSYxSmCZ/8HUzTza0epnR3BW9UShWufXBQMtf3h5xnJ1Rhy1/I3lQ3EZV
         wBRw==
X-Gm-Message-State: APjAAAUUQJNUjpG2cUlE8mxSKQxAlxXDEyZIKtwAhMSrGZ1IxUXUpZ5o
        42Ohh5EO1Az4uAqbLR/TZNj2CIfA+2GLxM6m/VPczq6Ethgz
X-Google-Smtp-Source: APXvYqzQAAy8Ex8a+EXsc93axIY1/K13uzm27HlZDC8ziZoJwtH+al2M5d7zrGN5AUcSCkpf+0KSd5ZDlZYaMN0ClBQegoXpbncZ
MIME-Version: 1.0
X-Received: by 2002:a92:bb4a:: with SMTP id w71mr15518729ili.112.1575647708737;
 Fri, 06 Dec 2019 07:55:08 -0800 (PST)
Date:   Fri, 06 Dec 2019 07:55:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f87bef05990b11a7@google.com>
Subject: KASAN: use-after-free Write in tty_buffer_cancel_work
From:   syzbot <syzbot+712f841d2144563deebe@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b0d4beaa Merge branch 'next.autofs' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1565a90ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f07a23020fd7d21a
dashboard link: https://syzkaller.appspot.com/bug?extid=712f841d2144563deebe
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a61edae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15617c82e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+712f841d2144563deebe@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in test_and_set_bit  
include/asm-generic/bitops-instrumented.h:143 [inline]
BUG: KASAN: use-after-free in try_to_grab_pending kernel/workqueue.c:1251  
[inline]
BUG: KASAN: use-after-free in try_to_grab_pending+0x115/0x910  
kernel/workqueue.c:1229
Write of size 8 at addr ffff888097823008 by task syz-executor659/9922

CPU: 0 PID: 9922 Comm: syz-executor659 Not tainted 5.4.0-syzkaller #0
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
  __kasan_check_write+0x14/0x20 mm/kasan/common.c:101
  test_and_set_bit include/asm-generic/bitops-instrumented.h:143 [inline]
  try_to_grab_pending kernel/workqueue.c:1251 [inline]
  try_to_grab_pending+0x115/0x910 kernel/workqueue.c:1229
  __cancel_work_timer+0xc4/0x540 kernel/workqueue.c:3087
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
RSP: 002b:00007ffd9442c538 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043ff38
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004bf950 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d2180 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 9922:
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
  do_last fs/namei.c:3412 [inline]
  path_openat+0x10e4/0x4710 fs/namei.c:3529
  do_filp_open+0x1a1/0x280 fs/namei.c:3559
  do_sys_open+0x3fe/0x5d0 fs/open.c:1097
  __do_sys_open fs/open.c:1115 [inline]
  __se_sys_open fs/open.c:1110 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1110
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 9921:
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

The buggy address belongs to the object at ffff888097823000
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 8 bytes inside of
  2048-byte region [ffff888097823000, ffff888097823800)
The buggy address belongs to the page:
page:ffffea00025e08c0 refcount:1 mapcount:0 mapping:ffff8880aa400e00  
index:0x0
raw: 00fffe0000000200 ffffea00025e1188 ffffea00025f9d48 ffff8880aa400e00
raw: 0000000000000000 ffff888097823000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888097822f00: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc
  ffff888097822f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff888097823000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                       ^
  ffff888097823080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff888097823100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
