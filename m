Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F8AC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCA920854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfCGSZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:25:16 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:55482 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfCGSZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:25:06 -0500
Received: by mail-it1-f200.google.com with SMTP id y70so9485729itc.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 10:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fz8m/Sp9U72B4fniCJ25kQPn3alE3RGAi+6oCqyDdzk=;
        b=AfCol3oNtOaE74GqLHQzAFucZbt4m25Ty4nbwl6MaFRmE7eVz3RM89nPl9YSkuNRyq
         hjw0a5ICQqADTuNqu90MFwV7lW4p7KO2irKdbNSYbQ/K7SljOjrpBqbke9V+dfh3AL65
         yzFp++nLDkGncjSWZibBgD323d48J3hdUwXuE82VPNlusCjEyRRO6023BSPQrUJ7jHwM
         eZSLYCg46wYrdXm1VkcV6J3yeWJACnpUGkCx9awShw2gjbOV7I1hbPWUZp6bSfa/L+yt
         tvvKXjhcsuiFw4d24rnaF+2kezRCQTh/hwJ1J0rZcFlgVT8WoKMGUG+fhTpCLnUjVs9T
         Aepw==
X-Gm-Message-State: APjAAAXFQEwj1X8ER+WEWD8hNzaKRsHqJ8yJG/GMkgaLWMHHej6sUv8/
        dABBi7KGssvZQBDxZAYLBuzQ6mP0ZzQr9gXvxPH2GpyZUHhB
X-Google-Smtp-Source: APXvYqyZcxp7ikwDBbznQ2nBrj/t/swKKWJEKu+KKXEcMLd1jID7oOE5iu4p5dwygAIh0JSdJaR7YY2S2HHJ8H48rNNcwxOtjYXX
MIME-Version: 1.0
X-Received: by 2002:a02:86:: with SMTP id 128mr8591883jaa.21.1551983105414;
 Thu, 07 Mar 2019 10:25:05 -0800 (PST)
Date:   Thu, 07 Mar 2019 10:25:05 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b24b32058385399b@google.com>
Subject: KASAN: use-after-free Read in dst_dev_put
From:   syzbot <syzbot+dc85a3260b30f5c9a531@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7d762d69145a afs: Fix manually set volume location server ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ebb8ecc00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b76ec970784287c
dashboard link: https://syzkaller.appspot.com/bug?extid=dc85a3260b30f5c9a531
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+dc85a3260b30f5c9a531@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in dst_dev_put+0x219/0x290 net/core/dst.c:168
Read of size 8 at addr ffff88808d1f42c0 by task ksoftirqd/1/16

CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 5.0.0-rc8+ #88
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
  dst_dev_put+0x219/0x290 net/core/dst.c:168
  rt_fibinfo_free_cpus net/ipv4/fib_semantics.c:200 [inline]
  free_fib_info_rcu+0x2f4/0x4a0 net/ipv4/fib_semantics.c:217
  __rcu_reclaim kernel/rcu/rcu.h:240 [inline]
  rcu_do_batch kernel/rcu/tree.c:2452 [inline]
  invoke_rcu_callbacks kernel/rcu/tree.c:2773 [inline]
  rcu_process_callbacks+0x928/0x1390 kernel/rcu/tree.c:2754
  __do_softirq+0x266/0x95a kernel/softirq.c:292
  run_ksoftirqd kernel/softirq.c:654 [inline]
  run_ksoftirqd+0x8e/0x110 kernel/softirq.c:646
  smpboot_thread_fn+0x6ab/0xa10 kernel/smpboot.c:164
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Allocated by task 19257:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_kmalloc mm/kasan/common.c:495 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:468
  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:503
  slab_post_alloc_hook mm/slab.h:440 [inline]
  slab_alloc mm/slab.c:3388 [inline]
  kmem_cache_alloc+0x11a/0x6f0 mm/slab.c:3548
  anon_vma_chain_alloc mm/rmap.c:129 [inline]
  anon_vma_clone+0xde/0x480 mm/rmap.c:269
  anon_vma_fork+0x8f/0x4a0 mm/rmap.c:332
  dup_mmap kernel/fork.c:541 [inline]
  dup_mm kernel/fork.c:1320 [inline]
  copy_mm kernel/fork.c:1375 [inline]
  copy_process.part.0+0x350f/0x79a0 kernel/fork.c:1917
  copy_process kernel/fork.c:1710 [inline]
  _do_fork+0x257/0xfe0 kernel/fork.c:2227
  __do_sys_clone kernel/fork.c:2334 [inline]
  __se_sys_clone kernel/fork.c:2328 [inline]
  __x64_sys_clone+0xbf/0x150 kernel/fork.c:2328
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 29904:
  save_stack+0x45/0xd0 mm/kasan/common.c:73
  set_track mm/kasan/common.c:85 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:457
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:465
  __cache_free mm/slab.c:3494 [inline]
  kmem_cache_free+0x86/0x260 mm/slab.c:3754
  anon_vma_chain_free mm/rmap.c:134 [inline]
  unlink_anon_vmas+0x2ba/0x870 mm/rmap.c:401
  free_pgtables+0x1af/0x2f0 mm/memory.c:393
  exit_mmap+0x2d1/0x530 mm/mmap.c:3141
  __mmput kernel/fork.c:1047 [inline]
  mmput+0x15f/0x4c0 kernel/fork.c:1068
  exec_mmap fs/exec.c:1046 [inline]
  flush_old_exec+0x8d9/0x1c20 fs/exec.c:1279
  load_elf_binary+0x9bc/0x53f0 fs/binfmt_elf.c:869
  search_binary_handler fs/exec.c:1656 [inline]
  search_binary_handler+0x17f/0x570 fs/exec.c:1634
  exec_binprm fs/exec.c:1698 [inline]
  __do_execve_file.isra.0+0x1394/0x23f0 fs/exec.c:1818
  do_execveat_common fs/exec.c:1865 [inline]
  do_execve fs/exec.c:1882 [inline]
  __do_sys_execve fs/exec.c:1963 [inline]
  __se_sys_execve fs/exec.c:1958 [inline]
  __x64_sys_execve+0x8f/0xc0 fs/exec.c:1958
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88808d1f42a0
  which belongs to the cache anon_vma_chain of size 80
The buggy address is located 32 bytes inside of
  80-byte region [ffff88808d1f42a0, ffff88808d1f42f0)
The buggy address belongs to the page:
page:ffffea0002347d00 count:1 mapcount:0 mapping:ffff88821bc40640 index:0x0
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea00026112c8 ffffea0002439488 ffff88821bc40640
raw: 0000000000000000 ffff88808d1f4000 0000000100000024 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88808d1f4180: fb fb fb fb fc fc fc fc fb fb fb fb fb fb fb fb
  ffff88808d1f4200: fb fb fc fc fc fc fb fb fb fb fb fb fb fb fb fb
> ffff88808d1f4280: fc fc fc fc fb fb fb fb fb fb fb fb fb fb fc fc
                                            ^
  ffff88808d1f4300: fc fc fb fb fb fb fb fb fb fb fb fb fc fc fc fc
  ffff88808d1f4380: fb fb fb fb fb fb fb fb fb fb fc fc fc fc fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
