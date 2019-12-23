Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56F0C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 09:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D9E20709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 09:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLWJpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 04:45:09 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:56310 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLWJpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 04:45:09 -0500
Received: by mail-il1-f200.google.com with SMTP id p8so13929375ilp.22
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 01:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Z+CQlnHVX35fvnVEwFLg2quUohMffSJb9JQx/WmSmok=;
        b=Zd/j5jMye0kpD27n+bHzjQf4REkEZ3jtLCDN8T8YY2wI3abWXnHJYqtpnhY1zhyeOd
         G2+3nchJNrk7tUp0j0kSDu/Js9DeruQaIGz2ObygMMcdPUWQsfGho+SUIAROUDbjLq4J
         4gTv304Isv4p1vOw4o1FqA9XNwtnUTffhqg3bB0BxM4LsXTOTlENObRXdBssr4RuylP7
         4Q772Jq31KH5bHBvRE2l2UgmXTYtiricFfi/VwyJHu6wRF3BCiBscuMwlfiBAkIW0GlY
         zuGPkji0u/Mc0EElXieVU2tgfDR2X0sShCjEIZC/VMqvdh2V5dm/eB79/+rCwpToJ+1/
         SNRg==
X-Gm-Message-State: APjAAAW3teBqAfCugfeGvlidhvBg4SNZqjfcN7I7FNMqNMe/wuf6Qlrk
        Yegs9DjW/Jos0S4Bbz1vVN4i5felKO+c/ErBrLpvVNPl17j/
X-Google-Smtp-Source: APXvYqxJRyiVxk8tcxfdBBk0B6QVEzMA42SWsxyRS627pqugEQqvqAwzt2X9AHxRpE6AQ9epGt8yWLt1gTJX0xkHPLSjzfrfOgh3
MIME-Version: 1.0
X-Received: by 2002:a5e:d616:: with SMTP id w22mr18472866iom.57.1577094307832;
 Mon, 23 Dec 2019 01:45:07 -0800 (PST)
Date:   Mon, 23 Dec 2019 01:45:07 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000feecd9059a5be1b7@google.com>
Subject: INFO: rcu detected stall in do_signal (4)
From:   syzbot <syzbot+7e600afa7f6059f9a30e@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=10031a8ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ab2ae0615387ef78
dashboard link: https://syzkaller.appspot.com/bug?extid=7e600afa7f6059f9a30e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163852fee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=135b43b6e00000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=123dc849e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=113dc849e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=163dc849e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7e600afa7f6059f9a30e@syzkaller.appspotmail.com

hrtimer: interrupt took 92494 ns
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
	(detected by 0, t=10502 jiffies, g=8669, q=2)
rcu: All QSes seen, last rcu_preempt kthread activity 10502  
(4295016466-4295005964), jiffies_till_next_fqs=1, root ->qsmask 0x0
syz-executor765 R  running task    28552  9407   9389 0x00000000
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
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:169  
[inline]
RIP: 0010:_raw_spin_unlock_irq+0x4f/0x80 kernel/locking/spinlock.c:199
Code: c0 e8 34 93 89 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 00  
75 33 48 83 3d 52 f5 ca 01 00 74 20 fb 66 0f 1f 44 00 00 <bf> 01 00 00 00  
e8 e7 7b 88 f9 65 8b 05 d8 de 39 78 85 c0 74 06 41
RSP: 0000:ffffc90001f47ca0 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff132669d RBX: 0000000000000000 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000006 RDI: ffff888095ca8b54
RBP: ffffc90001f47ca8 R08: ffff888095ca82c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880a8ef0b80
R13: ffff8880a8ef0cc0 R14: dffffc0000000000 R15: 000000000000000b
  spin_unlock_irq include/linux/spinlock.h:388 [inline]
  get_signal+0x1bee/0x24f0 kernel/signal.c:2737
  do_signal+0x87/0x1700 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop+0x286/0x380 arch/x86/entry/common.c:160
  prepare_exit_to_usermode+0x321/0x3a0 arch/x86/entry/common.c:195
  ret_from_intr+0x26/0x36
RIP: 0033:0x401505
Code: 00 00 00 be b4 fe 4a 00 e8 48 ee ff ff 48 85 c0 0f 85 d2 fe ff ff e9  
4a ff ff ff e8 55 d9 04 00 48 6b 44 24 28 18 8b 7c 24 38 <48> 8b 88 50 00  
00 20 48 8b 90 48 00 00 20 48 8b b0 40 00 00 20 e8
RSP: 002b:00007f51c6df1b20 EFLAGS: 00010202
RAX: 0000000002f54358 RBX: 00000000006dcc28 RCX: 0000000000406cc7
RDX: 60b237aef639e3c2 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00000000006dcc20 R08: 00007f51c6df1b20 R09: 00000000006dcc20
R10: 0000000000000000 R11: 0000000000000000 R12: 00000000006dcc2c
R13: 00007ffcd25bbb6f R14: 00007f51c6df29c0 R15: 00000000006dcc20
rcu: rcu_preempt kthread starved for 10502 jiffies! g8669 f0x2  
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
