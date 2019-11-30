Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CA6C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 07:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF5B2075C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 07:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfK3HfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 02:35:09 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:46278 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfK3HfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 02:35:09 -0500
Received: by mail-il1-f200.google.com with SMTP id i74so26728027ild.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 23:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ppVt2/zZT34S9FgjsO9lab8N4guOTyuRYSNb6nKjia8=;
        b=JxB2W9jALFFaJbTV4gTGZzeCKFJomguHw0uqtCcsDsaO1h2bB5mkF5vn2nhzflMEOO
         +WCmKJvBgbDYtaS2I3MdtwwIxh54MMuP3PQJSv+13d9UzDM2ePvXtcykSgLL6/I7ymgr
         m6ub4HDAF5JvZ53fXcdcmMfKMZxncpcG61p6j8UbtcHRPuZ0xH7GZgVg/AeELYirLYjn
         IfhtCHcbnRcuTRij7wLDkqDv+u0POgmdvkpbRlEUuwvh40FMdFz8j9ibqJjPWmtPr36A
         lvR2OuQZl6PnyqYwIIhFoTD0rh4poFAehqCIhqbgzFFjl1O8zM92nr5vcFLIT6wt/qu8
         CCPw==
X-Gm-Message-State: APjAAAVo7sKsUNy+EQRjgYYWCgQd7RQx1HAMHfoSH1mxvCbPKKGZ1/59
        6n6bATpp7u2vrcILjGfLKo4VeWgTghMliSDd32L0qlIaXnNl
X-Google-Smtp-Source: APXvYqzGoJF8Tn+qIVwVVNycKuRIQgR4kvwzmPwJFl+A9SEYTuBPsb+yZo+kaEJfHr813lud8h7iqRcbe8ef+of/rh8dYi8AE6+D
MIME-Version: 1.0
X-Received: by 2002:a92:5bdd:: with SMTP id c90mr1609881ilg.78.1575099308340;
 Fri, 29 Nov 2019 23:35:08 -0800 (PST)
Date:   Fri, 29 Nov 2019 23:35:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c280ba05988b6242@google.com>
Subject: BUG: sleeping function called from invalid context in __alloc_pages_nodemask
From:   syzbot <syzbot+4925d60532bf4c399608@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    419593da Add linux-next specific files for 20191129
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12cc369ce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c04b0959e75c206
dashboard link: https://syzkaller.appspot.com/bug?extid=4925d60532bf4c399608
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4925d60532bf4c399608@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at mm/page_alloc.c:4681
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2710, name:  
kworker/0:2
4 locks held by kworker/0:2/2710:
  #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at: __write_once_size  
include/linux/compiler.h:247 [inline]
  #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at: arch_atomic64_set  
arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:868 [inline]
  #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at: atomic_long_set  
include/asm-generic/atomic-long.h:40 [inline]
  #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at: set_work_data  
kernel/workqueue.c:615 [inline]
  #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
  #0: ffff8880aa026d28 ((wq_completion)events){+.+.}, at:  
process_one_work+0x88b/0x1740 kernel/workqueue.c:2235
  #1: ffffc9000802fdc0 (pcpu_balance_work){+.+.}, at:  
process_one_work+0x8c1/0x1740 kernel/workqueue.c:2239
  #2: ffffffff8983ff20 (pcpu_alloc_mutex){+.+.}, at:  
pcpu_balance_workfn+0xb7/0x1310 mm/percpu.c:1845
  #3: ffffffff89851b18 (vmap_area_lock){+.+.}, at: spin_lock  
include/linux/spinlock.h:338 [inline]
  #3: ffffffff89851b18 (vmap_area_lock){+.+.}, at:  
pcpu_get_vm_areas+0x3b27/0x3f00 mm/vmalloc.c:3431
Preemption disabled at:
[<ffffffff81a89ce7>] spin_lock include/linux/spinlock.h:338 [inline]
[<ffffffff81a89ce7>] pcpu_get_vm_areas+0x3b27/0x3f00 mm/vmalloc.c:3431
CPU: 0 PID: 2710 Comm: kworker/0:2 Not tainted  
5.4.0-next-20191129-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events pcpu_balance_workfn
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  ___might_sleep.cold+0x1fb/0x23e kernel/sched/core.c:6800
  __might_sleep+0x95/0x190 kernel/sched/core.c:6753
  prepare_alloc_pages mm/page_alloc.c:4681 [inline]
  __alloc_pages_nodemask+0x523/0x910 mm/page_alloc.c:4730
  alloc_pages_current+0x107/0x210 mm/mempolicy.c:2211
  alloc_pages include/linux/gfp.h:532 [inline]
  __get_free_pages+0xc/0x40 mm/page_alloc.c:4786
  kasan_populate_vmalloc_pte mm/kasan/common.c:762 [inline]
  kasan_populate_vmalloc_pte+0x2f/0x1c0 mm/kasan/common.c:753
  apply_to_pte_range mm/memory.c:2041 [inline]
  apply_to_pmd_range mm/memory.c:2068 [inline]
  apply_to_pud_range mm/memory.c:2088 [inline]
  apply_to_p4d_range mm/memory.c:2108 [inline]
  apply_to_page_range+0x445/0x700 mm/memory.c:2133
  kasan_populate_vmalloc+0x68/0x90 mm/kasan/common.c:791
  pcpu_get_vm_areas+0x3c77/0x3f00 mm/vmalloc.c:3439
  pcpu_create_chunk+0x24e/0x7f0 mm/percpu-vm.c:340
  pcpu_balance_workfn+0xf1b/0x1310 mm/percpu.c:1934
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2264
  worker_thread+0x98/0xe40 kernel/workqueue.c:2410
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
