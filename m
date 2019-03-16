Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5FDC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 20:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41ED421019
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 20:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfCPUMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 16:12:09 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:42440 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfCPUMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 16:12:06 -0400
Received: by mail-it1-f199.google.com with SMTP id j127so11109393itj.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 13:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Qv6doneNvHkAoHyV+Pv2MG1cKRx1wOHMK88ttcp2siY=;
        b=AyQ2mxKPwjHIYmNHgjdVZZfzUsQJ77ZXkUTiwXIZRsuDu7US+COJc5Ltytpetjtt16
         opVmib5pW7M+nXUb2pizNGstM2NBe7QC26tinBdks5nGtqSCXkxfHvF/UGNGwojxtvvC
         QvFDwqsImFfKkXKAv+utFtlF/NYZvEDLlrt4BvSstOhuTPabppTetmbeLUB6sRq8PcXM
         8stOZhQO+Kp0bDOecFK+DOYhVnhCyUlRCsb0C8Ihe8aM0qY0X6QoFOHco5/nQlov0S0P
         ick/0bxriptrpnMwFn8P+mEiS2BXn5ebPvUIOkc5DZzL3sPXXNcBkZeTM5KE2/mHy84u
         ++2w==
X-Gm-Message-State: APjAAAXIajmaFKOpsR3rtpkkFMfORHPvmxzwPQO9quTLXg34Ms6BvRc7
        2aUW/4jQGGaR6/FVgpU6n/Qygh5UEj9QdmURGscWwiuuLAe1
X-Google-Smtp-Source: APXvYqzjWmjCnqMavAwfeJDZJNkvJCBzEc76R/Aj9wFH1yTaNUWqrTPukqRINhxb80iaPu2aWBpNQumyayjLKVPotjYjNp4Zs7lD
MIME-Version: 1.0
X-Received: by 2002:a24:680f:: with SMTP id v15mr5734984itb.31.1552767125460;
 Sat, 16 Mar 2019 13:12:05 -0700 (PDT)
Date:   Sat, 16 Mar 2019 13:12:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eea12405843bc43c@google.com>
Subject: KASAN: use-after-free Read in refcount_inc_not_zero_checked (2)
From:   syzbot <syzbot+eff6b596cc8194e2f029@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-hams@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ralf@linux-mips.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9c7dc824 Merge tag '5.1-rc-smb3' of git://git.samba.org/sf..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170ae6d7200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e1aaa1cfbfe1abf
dashboard link: https://syzkaller.appspot.com/bug?extid=eff6b596cc8194e2f029
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e294a3200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+eff6b596cc8194e2f029@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in atomic_read  
include/asm-generic/atomic-instrumented.h:26 [inline]
BUG: KASAN: use-after-free in refcount_inc_not_zero_checked+0x81/0x200  
lib/refcount.c:123
Read of size 4 at addr ffff8880a614c280 by task syz-executor.3/7636

CPU: 1 PID: 7636 Comm: syz-executor.3 Not tainted 5.0.0+ #25
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x123/0x190 mm/kasan/generic.c:191
  kasan_check_read+0x11/0x20 mm/kasan/common.c:102
  atomic_read include/asm-generic/atomic-instrumented.h:26 [inline]
  refcount_inc_not_zero_checked+0x81/0x200 lib/refcount.c:123
  refcount_inc_checked+0x17/0x70 lib/refcount.c:156
  sock_hold include/net/sock.h:647 [inline]
  nr_release+0x62/0x3c0 net/netrom/af_netrom.c:523
  __sock_release+0xd3/0x2b0 net/socket.c:579
  sock_close+0x1b/0x30 net/socket.c:1162
  __fput+0x2e5/0x8d0 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x14a/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x273/0x2c0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x411e31
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 e4 1a 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffcf55d0f50 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000007 RCX: 0000000000411e31
RDX: 0000000000000000 RSI: 00000000007410c8 RDI: 0000000000000006
RBP: 0000000000000000 R08: 000000000002cf1a R09: 000000000002cf1a
R10: 00007ffcf55d0e80 R11: 0000000000000293 R12: 0000000000000001
R13: 00007ffcf55d0f90 R14: 0000000000000000 R15: 00007ffcf55d0fa0

Allocated by task 7638:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:470
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:511
  __do_kmalloc mm/slab.c:3726 [inline]
  __kmalloc+0x15c/0x740 mm/slab.c:3735
  kmalloc include/linux/slab.h:550 [inline]
  sk_prot_alloc+0x19c/0x2e0 net/core/sock.c:1607
  sk_alloc+0x39/0xf70 net/core/sock.c:1661
  nr_create+0xb9/0x5e0 net/netrom/af_netrom.c:436
  __sock_create+0x3e6/0x750 net/socket.c:1298
  sock_create net/socket.c:1338 [inline]
  __sys_socket+0x103/0x220 net/socket.c:1368
  __do_sys_socket net/socket.c:1377 [inline]
  __se_sys_socket net/socket.c:1375 [inline]
  __x64_sys_socket+0x73/0xb0 net/socket.c:1375
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 7636:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:459
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:467
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3821
  sk_prot_free net/core/sock.c:1644 [inline]
  __sk_destruct+0x4f1/0x6d0 net/core/sock.c:1726
  sk_destruct+0x7b/0x90 net/core/sock.c:1734
  __sk_free+0xce/0x300 net/core/sock.c:1745
  sk_free+0x42/0x50 net/core/sock.c:1756
  sock_put include/net/sock.h:1708 [inline]
  nr_release+0x337/0x3c0 net/netrom/af_netrom.c:557
  __sock_release+0xd3/0x2b0 net/socket.c:579
  sock_close+0x1b/0x30 net/socket.c:1162
  __fput+0x2e5/0x8d0 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x14a/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x273/0x2c0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a614c200
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 128 bytes inside of
  2048-byte region [ffff8880a614c200, ffff8880a614ca00)
The buggy address belongs to the page:
page:ffffea0002985300 count:1 mapcount:0 mapping:ffff88812c3f0c40 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea00022f4408 ffffea000218f408 ffff88812c3f0c40
raw: 0000000000000000 ffff8880a614c200 0000000100000003 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a614c180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8880a614c200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8880a614c280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                    ^
  ffff8880a614c300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880a614c380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
