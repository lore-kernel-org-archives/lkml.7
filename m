Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97CAC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B126E20709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbfLWGFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 01:05:10 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:42544 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfLWGFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 01:05:09 -0500
Received: by mail-io1-f72.google.com with SMTP id e7so10855477iog.9
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 22:05:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bus90OUtBJWBEdGpr5RY+BHlMyaHBzVjxVfmacaJDgc=;
        b=WA3ko7Gajy/+XdAaQFsPrn4WrdRUNWq2UmNs2KhmMPq7D/Iv6Qz7C9MbgyMnBGQqek
         fra1wfA47t24AhGJs9CHFm1/d6WNQ96VM56nWuWBGRI4yYz7w/vuC0mmQ/p2/NroJWgi
         Yzd0srkrks9u4KbpJeamqNzvXPS9PxXNcQjvqBDwAZZibrq3BUH+MtaUdipg5EBL2l9i
         SA0Ch6wsGdhAE/WM5ZD11luV5Fc33ndyGTqNXHutcSkpw8ze9pmyEQW2iVbZ33OFIKsg
         cID0zuzlHA2Jh22rEMw68asKSGkHVYH18r1K5tItRQOa6hF3LyyH2/3qJbuqQ3IjhqOH
         PXXg==
X-Gm-Message-State: APjAAAWvh2FJGOGMk36EAYvNRq1dhDmbCiV4zPVtKR52vJARacSsw2XH
        H67qWHCTjhYwtckzYEfuR9HjWKRpmBRdjKsva5NsvldeSyxi
X-Google-Smtp-Source: APXvYqzmB2RkEhBxMOAvbI77wO1r7EJetG+SCaDbWAxGFJjrY57Qy6zkDeZmpnbXDn8w92kj9qDLrf1TZzbrN3hYvLjHS12SDMmb
MIME-Version: 1.0
X-Received: by 2002:a5d:964e:: with SMTP id d14mr18401819ios.193.1577081108578;
 Sun, 22 Dec 2019 22:05:08 -0800 (PST)
Date:   Sun, 22 Dec 2019 22:05:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000424dbf059a58cf39@google.com>
Subject: INFO: rcu detected stall in bad_area
From:   syzbot <syzbot+79fe77a41f0f085ece70@syzkaller.appspotmail.com>
To:     christian@brauner.io, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2187f215 Merge tag 'for-5.5-rc2-tag' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1207cafee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ab2ae0615387ef78
dashboard link: https://syzkaller.appspot.com/bug?extid=79fe77a41f0f085ece70
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12cd2951e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144655b6e00000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16efc199e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15efc199e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11efc199e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+79fe77a41f0f085ece70@syzkaller.appspotmail.com

hrtimer: interrupt took 59918 ns
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
	(detected by 1, t=10502 jiffies, g=9705, q=83)
rcu: All QSes seen, last rcu_preempt kthread activity 10502  
(4295004244-4294993742), jiffies_till_next_fqs=1, root ->qsmask 0x0
syz-executor069 R  running task    28568 10245  10207 0x80000004
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
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160  
[inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x90/0xe0  
kernel/locking/spinlock.c:191
Code: 48 c7 c0 d8 34 93 89 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c  
10 00 75 39 48 83 3d 3f f1 ca 01 00 74 24 48 89 df 57 9d <0f> 1f 44 00 00  
bf 01 00 00 00 e8 e1 77 88 f9 65 8b 05 d2 da 39 78
RSP: 0000:ffffc90001fe7ca8 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff132669b RBX: 0000000000000286 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000006 RDI: 0000000000000286
RBP: ffffc90001fe7cb8 R08: ffff8880914ba100 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888083a2ac00
R13: ffff8880914ba820 R14: 000000000000000a R15: 000000000000000b
  spin_unlock_irqrestore include/linux/spinlock.h:393 [inline]
  force_sig_info_to_task+0x2a2/0x340 kernel/signal.c:1329
  force_sig_fault_to_task kernel/signal.c:1671 [inline]
  force_sig_fault+0xbe/0x100 kernel/signal.c:1678
  __bad_area_nosemaphore+0x32e/0x420 arch/x86/mm/fault.c:904
  __bad_area arch/x86/mm/fault.c:933 [inline]
  bad_area+0x69/0x80 arch/x86/mm/fault.c:939
  do_user_addr_fault arch/x86/mm/fault.c:1404 [inline]
  __do_page_fault+0x9eb/0xd80 arch/x86/mm/fault.c:1506
  do_page_fault+0x38/0x590 arch/x86/mm/fault.c:1530
  page_fault+0x39/0x40 arch/x86/entry/entry_64.S:1203
RIP: 0033:0x401515
Code: 00 00 00 be b4 fe 4a 00 e8 38 ee ff ff 48 85 c0 0f 85 d2 fe ff ff e9  
4a ff ff ff e8 55 d9 04 00 48 6b 44 24 28 18 8b 7c 24 38 <48> 8b 88 50 00  
00 20 48 8b 90 48 00 00 20 48 8b b0 40 00 00 20 e8
RSP: 002b:00007f35767f7b20 EFLAGS: 00010206
RAX: 0000000002ed3b50 RBX: 00000000006dcc28 RCX: 0000000000406cd7
RDX: 1482b7b55b3372eb RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00000000006dcc20 R08: 00007f35767f7b20 R09: 00000000006dcc20
R10: 0000000000000000 R11: 0000000000000000 R12: 00000000006dcc2c
R13: 00007ffc626d62cf R14: 00007f35767f89c0 R15: 00000000006dcc20
rcu: rcu_preempt kthread starved for 10502 jiffies! g9705 f0x2  
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: RCU grace-period kthread stack dump:
rcu_preempt     R  running task    29272    10      2 0x80004000
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
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
