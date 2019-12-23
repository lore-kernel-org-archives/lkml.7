Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0A0C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8402073A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfLWRbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 12:31:09 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:57304 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfLWRbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 12:31:09 -0500
Received: by mail-io1-f70.google.com with SMTP id d13so2181128ioo.23
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 09:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TAi4de50NFw+IXqEFchz0vmbBrv1YgEgchSV6bFsoAI=;
        b=uEgHY9Nz4iLVdlG5fngbJLmanA3aRPPNNjep5+ahMy4qg448uomK16D4F4hYiIWfC/
         slLtcoLUhxjAzhew+D8JR07X4axDlqj7dzN45YQusXp64ut1073szJv37SR+vyetXaZ3
         3moTBDjzgocxXicwI/6fM0iafFXuWDJ/EAsxL6GHDW9AXBbUxugrDjHgiCBG319RjlG5
         oxokLR3/vzKCDzkr8cupZx2bbzkZ+a7Sl1c2e8v6tSLRsxkFT+BxzKdC9XNIJ0o3IEGE
         czEEFNqvVZ6yQmyp+xLicL/6+q6BQxGNZ4NfX6y7RjPnRDl+F4bznRAkI2vh/75VTQ+J
         X+Pw==
X-Gm-Message-State: APjAAAUSNvZUbFdvJwEetpt9lIDcstpE4rNqZjAGImvGGzGJ+EQobBGd
        Mb4rn0+Bs75Fm8xe8dJ6COoQpN4c+GYDCcS7yerPKa4egRqj
X-Google-Smtp-Source: APXvYqzQk74CAFnDNTJ0OuyhHEXCR+xpxVjzWKW88kZg7k1pY1jgVBXNbdo0GAON/w9WngpUOU9dDE6KMRytHeDrbXVmPw9u2Gxj
MIME-Version: 1.0
X-Received: by 2002:a05:6638:97c:: with SMTP id o28mr24930342jaj.8.1577122268176;
 Mon, 23 Dec 2019 09:31:08 -0800 (PST)
Date:   Mon, 23 Dec 2019 09:31:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008fea66059a6264eb@google.com>
Subject: KASAN: use-after-free Read in tty_buffer_cancel_work
From:   syzbot <syzbot+bd5f8de9deae03ace6a6@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7e0165b2 Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154494c1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b59a3066828ac4c
dashboard link: https://syzkaller.appspot.com/bug?extid=bd5f8de9deae03ace6a6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+bd5f8de9deae03ace6a6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in atomic64_read  
include/asm-generic/atomic-instrumented.h:836 [inline]
BUG: KASAN: use-after-free in atomic_long_read  
include/asm-generic/atomic-long.h:28 [inline]
BUG: KASAN: use-after-free in work_is_canceling kernel/workqueue.c:751  
[inline]
BUG: KASAN: use-after-free in __cancel_work_timer+0x433/0x540  
kernel/workqueue.c:3113
Read of size 8 at addr ffff8880a77fc008 by task syz-executor.0/16211

CPU: 1 PID: 16211 Comm: syz-executor.0 Not tainted 5.5.0-rc2-syzkaller #0
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
  work_is_canceling kernel/workqueue.c:751 [inline]
  __cancel_work_timer+0x433/0x540 kernel/workqueue.c:3113
  cancel_work_sync+0x18/0x20 kernel/workqueue.c:3164
  tty_buffer_cancel_work+0x16/0x20 drivers/tty/tty_buffer.c:613
  release_tty+0x261/0x470 drivers/tty/tty_io.c:1520
  tty_release_struct+0x3c/0x50 drivers/tty/tty_io.c:1629
  tty_release+0xbcb/0xe90 drivers/tty/tty_io.c:1789
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x316/0x380 arch/x86/entry/common.c:164
  prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
  do_syscall_64+0x676/0x790 arch/x86/entry/common.c:304
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4144b1
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 1b 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007fff1f1c15d0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 00000000004144b1
RDX: 0000001b30420000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000001 R08: 00000000b81729f0 R09: 00000000b81729f4
R10: 00007fff1f1c16b0 R11: 0000000000000293 R12: 000000000075bf20
R13: 000000000005bac3 R14: 0000000000760180 R15: 000000000075bf2c

Allocated by task 16213:
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

Freed by task 16188:
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

The buggy address belongs to the object at ffff8880a77fc000
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 8 bytes inside of
  2048-byte region [ffff8880a77fc000, ffff8880a77fc800)
The buggy address belongs to the page:
page:ffffea00029dff00 refcount:1 mapcount:0 mapping:ffff8880aa400e00  
index:0x0
raw: 00fffe0000000200 ffffea000251ef08 ffffea00029b5008 ffff8880aa400e00
raw: 0000000000000000 ffff8880a77fc000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a77fbf00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8880a77fbf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8880a77fc000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                       ^
  ffff8880a77fc080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880a77fc100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
