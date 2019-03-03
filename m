Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48475C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 10:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8FA20863
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 10:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfCCKWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 05:22:06 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:53287 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCCKWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 05:22:06 -0500
Received: by mail-io1-f70.google.com with SMTP id z14so2082588ioh.20
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 02:22:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xZ9s5q2OITHgByZHYni8Oqg5Vb0fLq1SNy5Td6ttjYY=;
        b=WwzFrqwSb5uUb/eHYAKe+pUr8bTYDImCY3EPxmG6ofzKKOxYmRwskq0zEZNK5avYTu
         k26MAK9KVp9mwurt4SlF74i7jezQa5nieJjjZpdpINgTDvIQjwJzyy1aAnmRN3J2WVND
         BHSMtsCiBjouU91uMk0Xipk92xZdeb5lMrjf/g6JQHw3QiUFvvSUvuVj5xRsNP6PI16R
         G2Gyl7qGH6l+XRPhI7Qy666wFGD4HTrObhO37af4sCQSjUD5ew1M6YaqIR+KPgNktm6a
         XrsKZJQcTIcgSwlF0Sd0hTNS+lgQb6SNcZFwmHUwCwMmggIVJhgxNrlZ2r6n2Hvc8JFh
         70qQ==
X-Gm-Message-State: APjAAAX8CfPok08nwk+Qm4O3EYY6Oopkv0Hu3C6mzr+4vwK7HI76+Yjw
        kfzo5hDenKGgz6XjFqG4pwK8a6Es6+himPAKHYlY/8AY5Tnt
X-Google-Smtp-Source: APXvYqxhj6TDZt1iSZq+dQwfb6212duoSOPaFVLz1KBuSJMZbRir+iKJNIhTpMDOqtA+CnOqqTpkedAH5QRz6K1GZLib6GjeuL0w
MIME-Version: 1.0
X-Received: by 2002:a6b:f717:: with SMTP id k23mr8473129iog.28.1551608524803;
 Sun, 03 Mar 2019 02:22:04 -0800 (PST)
Date:   Sun, 03 Mar 2019 02:22:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f39c7b05832e0219@google.com>
Subject: KASAN: use-after-free Read in unix_dgram_poll
From:   syzbot <syzbot+503d4cc169fcec1cb18c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jbaron@akamai.com, kgraul@linux.ibm.com,
        ktkhai@virtuozzo.com, kyeongdon.kim@lge.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7d762d69145a afs: Fix manually set volume location server ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=131d832ac00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b76ec970784287c
dashboard link: https://syzkaller.appspot.com/bug?extid=503d4cc169fcec1cb18c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11934262c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+503d4cc169fcec1cb18c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in unix_dgram_poll+0x5e1/0x690  
net/unix/af_unix.c:2695
Read of size 4 at addr ffff88809292aae0 by task syz-executor.1/18946

CPU: 0 PID: 18946 Comm: syz-executor.1 Not tainted 5.0.0-rc8+ #88
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/generic_report.c:134
  unix_dgram_poll+0x5e1/0x690 net/unix/af_unix.c:2695
  sock_poll+0x291/0x340 net/socket.c:1127
  vfs_poll include/linux/poll.h:86 [inline]
  aio_poll fs/aio.c:1766 [inline]
  __io_submit_one fs/aio.c:1876 [inline]
  io_submit_one+0xe3e/0x1cf0 fs/aio.c:1909
  __do_sys_io_submit fs/aio.c:1954 [inline]
  __se_sys_io_submit fs/aio.c:1924 [inline]
  __x64_sys_io_submit+0x1bd/0x580 fs/aio.c:1924
  ? 0xffffffff81000000
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457e29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fd43ca93c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457e29
RDX: 0000000020000600 RSI: 1ffffffffffffd70 RDI: 00007fd43ca73000
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd43ca946d4
R13: 00000000004bf02f R14: 00000000004d09b0 R15: 00000000ffffffff

Allocated by task 18946:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_kmalloc mm/kasan/common.c:495 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:468
  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:503
  slab_post_alloc_hook mm/slab.h:440 [inline]
  slab_alloc mm/slab.c:3388 [inline]
  kmem_cache_alloc+0x11a/0x6f0 mm/slab.c:3548
  sk_prot_alloc+0x67/0x2e0 net/core/sock.c:1471
  sk_alloc+0x39/0xf70 net/core/sock.c:1531
  unix_create1+0xc3/0x530 net/unix/af_unix.c:764
  unix_create+0x103/0x1e0 net/unix/af_unix.c:825
  __sock_create+0x3e6/0x750 net/socket.c:1275
  sock_create net/socket.c:1315 [inline]
  __sys_socketpair+0x272/0x5e0 net/socket.c:1407
  __do_sys_socketpair net/socket.c:1456 [inline]
  __se_sys_socketpair net/socket.c:1453 [inline]
  __x64_sys_socketpair+0x97/0xf0 net/socket.c:1453
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 18944:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:457
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:465
  __cache_free mm/slab.c:3494 [inline]
  kmem_cache_free+0x86/0x260 mm/slab.c:3754
  sk_prot_free net/core/sock.c:1512 [inline]
  __sk_destruct+0x4b6/0x6d0 net/core/sock.c:1596
  sk_destruct+0x7b/0x90 net/core/sock.c:1604
  __sk_free+0xce/0x300 net/core/sock.c:1615
  sk_free+0x42/0x50 net/core/sock.c:1626
  sock_put include/net/sock.h:1707 [inline]
  unix_release_sock+0x921/0xbb0 net/unix/af_unix.c:573
  unix_release+0x44/0x90 net/unix/af_unix.c:835
  __sock_release+0xd3/0x250 net/socket.c:579
  sock_close+0x1b/0x30 net/socket.c:1139
  __fput+0x2df/0x8d0 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x14a/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x273/0x2c0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88809292a740
  which belongs to the cache UNIX(49:syz1) of size 1728
The buggy address is located 928 bytes inside of
  1728-byte region [ffff88809292a740, ffff88809292ae00)
The buggy address belongs to the page:
page:ffffea00024a4a80 count:1 mapcount:0 mapping:ffff8880920c0800 index:0x0
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea00028223c8 ffffea0002581248 ffff8880920c0800
raw: 0000000000000000 ffff88809292a000 0000000100000002 ffff8880a9718ec0
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff8880a9718ec0

Memory state around the buggy address:
  ffff88809292a980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88809292aa00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88809292aa80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                        ^
  ffff88809292ab00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88809292ab80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
