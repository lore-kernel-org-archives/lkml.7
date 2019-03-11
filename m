Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5916BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A642075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfCKGTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:19:07 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:35281 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfCKGTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:19:06 -0400
Received: by mail-it1-f199.google.com with SMTP id 142so4228505itx.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 23:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=AhUJ98vwN15fF0ra1uXmQtpAempqaCp2KepccvsWWNE=;
        b=E4LuqG3YV/tFQCA6DYtj5giCGXziPNI8Ng2X+3WtWVIwFolbx0sKERnKaWfdfobYuh
         lm6/07VBT3OPMP9VbafJwXriJMGdB28UlIlMtTmJbhNzdmEwaZII3xwB0flX4cvm5qAW
         Oz3EdXitMa01+5MnEvWOc2ZZ5305B8Y5ZH1W+vh+y7YDkV/HsyfNJsj3ew7tUV/B4WWa
         DD2Q4W3CCeL1AanNMY89nB8BOLfb7xykjgoSjfMtksbBx5NPYvJGlRKwKUtylxhPX7li
         kqah4FJ/s9MiXpMgOs8MNY2CnoVySiN+hiisIG+rLU6n38Xpf+dRfUJWKt2Eoj3iBTAP
         sDhw==
X-Gm-Message-State: APjAAAXBYM7VGQn6m2hJCjjLo++XHOfS2WHoevkIMZbxRFeY0Cr+KZid
        IlRVzVJibQYQfvn35xM20DA6TD7BxYBWjDgMpsv4q8VHD5E4
X-Google-Smtp-Source: APXvYqwBvSN85ridBw+1s6RhuF72XshgZje4dkC1laAabp0Thw7mWojekXUQ49iKYmT83Xa9msVGIdxh7FLOcMt1xNrEkjDzukiy
MIME-Version: 1.0
X-Received: by 2002:a24:3ccb:: with SMTP id m194mr20748426ita.40.1552285145756;
 Sun, 10 Mar 2019 23:19:05 -0700 (PDT)
Date:   Sun, 10 Mar 2019 23:19:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b3fae80583cb8c9f@google.com>
Subject: KASAN: use-after-free Read in d_walk
From:   syzbot <syzbot+353f82569238b73a3cbe@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d9862cfb Merge tag 'mips_5.1' of git://git.kernel.org/pub/..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=115d9bc7200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73d88a42238825ad
dashboard link: https://syzkaller.appspot.com/bug?extid=353f82569238b73a3cbe
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: amd64

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+353f82569238b73a3cbe@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in d_walk+0x86c/0x950 fs/dcache.c:1281
Read of size 8 at addr ffff888095e6add0 by task syz-executor.0/7708

CPU: 1 PID: 7708 Comm: syz-executor.0 Not tainted 5.0.0+ #97
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
  d_walk+0x86c/0x950 fs/dcache.c:1281
  shrink_dcache_parent+0xa4/0x140 fs/dcache.c:1496
  d_invalidate fs/dcache.c:1590 [inline]
  d_invalidate+0xfb/0x230 fs/dcache.c:1575
  proc_flush_task_mnt fs/proc/base.c:3069 [inline]
  proc_flush_task+0x28a/0x4d0 fs/proc/base.c:3139
  release_task+0x18c/0x1620 kernel/exit.c:196
  wait_task_zombie kernel/exit.c:1164 [inline]
  wait_consider_task+0x2c95/0x3910 kernel/exit.c:1391
  do_wait_thread kernel/exit.c:1454 [inline]
  do_wait+0x439/0x9d0 kernel/exit.c:1525
  kernel_wait4+0x171/0x290 kernel/exit.c:1667
  __do_sys_wait4+0x147/0x160 kernel/exit.c:1679
  __se_sys_wait4 kernel/exit.c:1675 [inline]
  __x64_sys_wait4+0x97/0xf0 kernel/exit.c:1675
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4120ba
Code: 0f 83 1a 17 00 00 c3 66 0f 1f 84 00 00 00 00 00 8b 05 de 41 64 00 85  
c0 75 36 45 31 d2 48 63 d2 48 63 ff b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff  
ff 77 06 c3 0f 1f 44 00 00 48 c7 c2 d4 ff ff ff f7
RSP: 002b:00007ffe51c30ab8 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 0000000000031389 RCX: 00000000004120ba
RDX: 0000000040000001 RSI: 00007ffe51c30af0 RDI: ffffffffffffffff
RBP: 00000000000001cb R08: 0000000000000001 R09: 0000000001aa7940
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000009
R13: 00007ffe51c30af0 R14: 000000000003106c R15: 00007ffe51c30b00

Allocated by task 11550:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_kmalloc mm/kasan/common.c:495 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:468
  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:503
  slab_post_alloc_hook mm/slab.h:440 [inline]
  slab_alloc mm/slab.c:3388 [inline]
  kmem_cache_alloc+0x11a/0x6f0 mm/slab.c:3548
  __d_alloc+0x2e/0x8c0 fs/dcache.c:1622
  d_alloc_pseudo+0x1e/0x30 fs/dcache.c:1745
  alloc_file_pseudo+0xe2/0x280 fs/file_table.c:224
  sock_alloc_file+0x4d/0x170 net/socket.c:394
  sock_map_fd net/socket.c:417 [inline]
  __sys_socket+0x150/0x220 net/socket.c:1372
  __do_sys_socket net/socket.c:1377 [inline]
  __se_sys_socket net/socket.c:1375 [inline]
  __x64_sys_socket+0x73/0xb0 net/socket.c:1375
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 11539:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:457
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:465
  __cache_free mm/slab.c:3494 [inline]
  kmem_cache_free+0x86/0x260 mm/slab.c:3754
  __d_free fs/dcache.c:269 [inline]
  dentry_free+0xed/0x170 fs/dcache.c:348
  __dentry_kill+0x45f/0x610 fs/dcache.c:593
  dentry_kill+0xd7/0x5e0 fs/dcache.c:698
  dput+0x570/0x6a0 fs/dcache.c:859
  __fput+0x429/0x8d0 fs/file_table.c:291
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x14a/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x273/0x2c0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff888095e6ace0
  which belongs to the cache dentry(17:syz0) of size 288
The buggy address is located 240 bytes inside of
  288-byte region [ffff888095e6ace0, ffff888095e6ae00)
The buggy address belongs to the page:
page:ffffea0002579a80 count:1 mapcount:0 mapping:ffff888098f7be40 index:0x0
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea0002577cc8 ffffea000257df48 ffff888098f7be40
raw: 0000000000000000 ffff888095e6a080 000000010000000b ffff88806d9baec0
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff88806d9baec0

Memory state around the buggy address:
  ffff888095e6ac80: 00 00 00 00 fc fc fc fc fc fc fc fc fb fb fb fb
  ffff888095e6ad00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff888095e6ad80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                  ^
  ffff888095e6ae00: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
  ffff888095e6ae80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
