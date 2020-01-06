Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D198C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC452467A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgAFU7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:59:35 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:42243 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgAFU7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:59:35 -0500
Received: by mail-io1-f72.google.com with SMTP id e7so31511575iog.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 12:59:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=dpjocmBEOjnd69U6qBP/r27izA7iYBgWwwnlFrDTMS8=;
        b=qPe0hL+ZY3/pDvp9/QcK8EDcoy8IsRWvhXJl7QZlntTPY85JbTByqIHtZAKkG6GopY
         O1ypFASogK533eXa+3TB2Jk5cd9GEuJtpz0dMVz7wjbIc6GiavRCiv5tQwbM0VHBKTFa
         UvHtn1gRgwkaZUtoAokNU0Zy5jKq6QHLSW4zSsgal4r6VcRdXcseRSg23TlLwO+dvEw3
         keHTEYn/GEcmoVjuIuX3nBwejblS4v/bhTP+x5kefNjBU8cbqPSvVuk3UTzQNVqc7Xk8
         BbYdN4iyJLuRNqLkDuzLzhIUoSTiy2HEtPuNcvOjPTnH/z2OttpsSOj6y3b7LRXp3RMY
         F0RA==
X-Gm-Message-State: APjAAAWHQ5dg50Z9kPEV0fkUZWJXEc0ACUmziRlOUyNipyRFWDxxL5g7
        nO/Mz+nHt/NcOyqLPyl9QOku2rMNjMxu4Pajh6c75YS1Ag3f
X-Google-Smtp-Source: APXvYqyRVhpovU4SZszjTvsHGHfa9gqYIyK6rOe8zllQ2L9v+IEWRGpfZbufhPUxUy9PMOVLm0Mlr+/2i5pKvtGORFSG8WKQQX0s
MIME-Version: 1.0
X-Received: by 2002:a92:1090:: with SMTP id 16mr84476134ilq.298.1578344052856;
 Mon, 06 Jan 2020 12:54:12 -0800 (PST)
Date:   Mon, 06 Jan 2020 12:54:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009aa09b059b7edc96@google.com>
Subject: INFO: rcu detected stall in new_sync_read
From:   syzbot <syzbot+8a95855c8a4649d98244@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bed72351 Merge tag 'kbuild-fixes-v5.5-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1747aec6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=874bac2ff63646fa
dashboard link: https://syzkaller.appspot.com/bug?extid=8a95855c8a4649d98244
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c26859e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1307e6b9e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8a95855c8a4649d98244@syzkaller.appspotmail.com

hrtimer: interrupt took 31901 ns
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
	(detected by 1, t=10502 jiffies, g=10557, q=3)
rcu: All QSes seen, last rcu_preempt kthread activity 10502  
(4295016188-4295005686), jiffies_till_next_fqs=1, root ->qsmask 0x0
syz-executor724 R  running task    23704 10332  10322 0x80004000
Call Trace:
  <IRQ>
  sched_show_task kernel/sched/core.c:5954 [inline]
  sched_show_task.cold+0x2ee/0x35d kernel/sched/core.c:5929
  print_other_cpu_stall kernel/rcu/tree_stall.h:410 [inline]
  check_cpu_stall kernel/rcu/tree_stall.h:538 [inline]
  rcu_pending kernel/rcu/tree.c:2827 [inline]
  rcu_sched_clock_irq.cold+0xaf4/0xc02 kernel/rcu/tree.c:2271
  update_process_times+0x2d/0x70 kernel/time/timer.c:1726
  tick_sched_handle+0xa2/0x190 kernel/time/tick-sched.c:167
  tick_sched_timer+0x53/0x140 kernel/time/tick-sched.c:1310
  __run_hrtimer kernel/time/hrtimer.c:1517 [inline]
  __hrtimer_run_queues+0x364/0xe40 kernel/time/hrtimer.c:1579
  hrtimer_interrupt+0x314/0x770 kernel/time/hrtimer.c:1641
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1110 [inline]
  smp_apic_timer_interrupt+0x160/0x610 arch/x86/kernel/apic/apic.c:1135
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
  </IRQ>
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:752  
[inline]
RIP: 0010:rmqueue_pcplist mm/page_alloc.c:3257 [inline]
RIP: 0010:rmqueue mm/page_alloc.c:3274 [inline]
RIP: 0010:get_page_from_freelist+0x1a6c/0x4290 mm/page_alloc.c:3692
Code: c0 d8 34 93 89 48 c1 e8 03 80 3c 18 00 0f 85 ae 25 00 00 48 83 3d 6b  
43 e9 07 00 0f 84 82 09 00 00 48 8b bd 68 fe ff ff 57 9d <0f> 1f 44 00 00  
e9 44 fc ff ff 48 8b 85 40 ff ff ff 48 8d 78 18 48
RSP: 0018:ffffc90001f1e9e8 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff132669b RBX: dffffc0000000000 RCX: 0000000000000006
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000282
RBP: ffffc90001f1eb98 R08: 1ffffffff1659dbc R09: fffffbfff1659dbd
R10: fffffbfff1659dbc R11: ffffffff8b2cede7 R12: 0000000000000004
R13: 0000000000000000 R14: 0000000000000000 R15: ffffea0000ce29c8
  __alloc_pages_nodemask+0x2d0/0x910 mm/page_alloc.c:4756
  alloc_pages_current+0x107/0x210 mm/mempolicy.c:2207
  alloc_pages include/linux/gfp.h:532 [inline]
  __page_cache_alloc+0x29d/0x490 mm/filemap.c:981
  __do_page_cache_readahead+0x1c9/0x5d0 mm/readahead.c:196
  ra_submit mm/internal.h:62 [inline]
  ondemand_readahead+0x55c/0xd30 mm/readahead.c:492
  page_cache_async_readahead mm/readahead.c:574 [inline]
  page_cache_async_readahead+0x437/0x7c0 mm/readahead.c:547
  generic_file_buffered_read mm/filemap.c:2059 [inline]
  generic_file_read_iter+0x13c0/0x2cf0 mm/filemap.c:2324
  ext4_file_read_iter fs/ext4/file.c:130 [inline]
  ext4_file_read_iter+0x1db/0x640 fs/ext4/file.c:113
  call_read_iter include/linux/fs.h:1896 [inline]
  new_sync_read+0x4d7/0x800 fs/read_write.c:414
  __vfs_read+0xe1/0x110 fs/read_write.c:427
  integrity_kernel_read+0x157/0x210 security/integrity/iint.c:200
  ima_calc_file_hash_tfm+0x2e3/0x3e0 security/integrity/ima/ima_crypto.c:360
  ima_calc_file_shash security/integrity/ima/ima_crypto.c:389 [inline]
  ima_calc_file_hash+0x1aa/0x570 security/integrity/ima/ima_crypto.c:454
  ima_collect_measurement+0x534/0x5f0 security/integrity/ima/ima_api.c:247
  process_measurement+0xd45/0x1850 security/integrity/ima/ima_main.c:326
  ima_file_check+0xc5/0x110 security/integrity/ima/ima_main.c:442
  do_last fs/namei.c:3424 [inline]
  path_openat+0x1138/0x4500 fs/namei.c:3537
  do_filp_open+0x1a1/0x280 fs/namei.c:3567
  do_sys_open+0x3fe/0x5d0 fs/open.c:1097
  __do_sys_open fs/open.c:1115 [inline]
  __se_sys_open fs/open.c:1110 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1110
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4476f9
Code: e8 3c e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 ab 06 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fe778c7edb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00000000006ddc28 RCX: 00000000004476f9
RDX: 0000000000000000 RSI: 0000000000141042 RDI: 0000000020000100
RBP: 00000000006ddc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006ddc2c
R13: 00007ffd2d04e6ff R14: 00007fe778c7f9c0 R15: 0000000000000000
rcu: rcu_preempt kthread starved for 10502 jiffies! g10557 f0x2  
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: RCU grace-period kthread stack dump:
rcu_preempt     R  running task    29264    10      2 0x80004000
Call Trace:
  context_switch kernel/sched/core.c:3385 [inline]
  __schedule+0x934/0x1f90 kernel/sched/core.c:4081
  schedule+0xdc/0x2b0 kernel/sched/core.c:4155
  schedule_timeout+0x486/0xc50 kernel/time/timer.c:1895
  rcu_gp_fqs_loop kernel/rcu/tree.c:1661 [inline]
  rcu_gp_kthread+0x9b2/0x18d0 kernel/rcu/tree.c:1821
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
