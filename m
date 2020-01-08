Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3586BC00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 06:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DAF2073A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 06:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgAHGFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 01:05:10 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:49927 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgAHGFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 01:05:09 -0500
Received: by mail-io1-f70.google.com with SMTP id c11so1391170iod.16
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 22:05:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9+uE+h3xjTwNLOiy7fyGnmVV5M7JrRHjlrnCw6T1SqQ=;
        b=XkR68xUn4/8j4aQFYE6EP9CH/BMAwdP+FTmUQqURvVB9WQihA/S+LxHZidqee8SNS4
         pr9yZP3U+N4wg6p+NFUXmmcNyIT6vFmI4udNaZs03Guh0n/jhaTYWVIKm30kpCL0fZLG
         ByMRYGGK5Xho9e+MIa5M9D7A2d1zOW9nV5lhHwxN3pP8khaU+BSAOl3cs7SfCHCm8XXx
         Ytkf/4AnIlqkmE4sSsaQ5uABw8afqVEpjTNQ2OkxyEu3ugbk/TDQPxBF21fs1k87TlFN
         CYwXtZ7feFGA+0BuoleLb4YmqHNP12eFMnb0di4COkNZ9ubgw55jPWh04/xJd1axkPYh
         wksw==
X-Gm-Message-State: APjAAAUE7i97YylDX9S1vHPctarosz0+m0ze11whFGoAdb804heJBQlU
        QnPiSkL4/4ShieOGNPiRkJ6nyWQukAWpThcYCXxIGa4tlvqe
X-Google-Smtp-Source: APXvYqxAxEReAspCJQkia412BL72vPjFbWW6JjKizFJALOVz+Kj/chWTtBYuJmPsDQa2M0ZX71lbQJC+oH4WGfqBJObnufhE+Mt8
MIME-Version: 1.0
X-Received: by 2002:a92:d34d:: with SMTP id a13mr2530438ilh.178.1578463509309;
 Tue, 07 Jan 2020 22:05:09 -0800 (PST)
Date:   Tue, 07 Jan 2020 22:05:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3717f059b9aac45@google.com>
Subject: INFO: rcu detected stall in sys_sendto (2)
From:   syzbot <syzbot+607007c8d18f132ad6f4@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, christian@brauner.io,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        luto@amacapital.net, mingo@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        wad@chromium.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ae608821 Merge tag 'trace-v5.5-rc5' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1581deb9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db5ff86cbb23b415
dashboard link: https://syzkaller.appspot.com/bug?extid=607007c8d18f132ad6f4
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+607007c8d18f132ad6f4@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-...!: (10499 ticks this GP) idle=2de/1/0x4000000000000002  
softirq=13619/13619 fqs=0
	(t=10500 jiffies g=6765 q=74)
rcu: rcu_preempt kthread starved for 10500 jiffies! g6765 f0x0  
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: RCU grace-period kthread stack dump:
rcu_preempt     R  running task    28984    10      2 0x80004000
Call Trace:
  context_switch kernel/sched/core.c:3385 [inline]
  __schedule+0x9a0/0xcc0 kernel/sched/core.c:4081
  schedule+0x181/0x210 kernel/sched/core.c:4155
  schedule_timeout+0x14f/0x240 kernel/time/timer.c:1895
  rcu_gp_fqs_loop kernel/rcu/tree.c:1661 [inline]
  rcu_gp_kthread+0xed8/0x1770 kernel/rcu/tree.c:1821
  kthread+0x332/0x350 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
NMI backtrace for cpu 0
CPU: 0 PID: 8526 Comm: syz-executor.4 Not tainted 5.5.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1fb/0x318 lib/dump_stack.c:118
  nmi_cpu_backtrace+0xaf/0x1a0 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x174/0x290 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x10/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
  rcu_dump_cpu_stacks+0x15a/0x220 kernel/rcu/tree_stall.h:254
  print_cpu_stall kernel/rcu/tree_stall.h:455 [inline]
  check_cpu_stall kernel/rcu/tree_stall.h:529 [inline]
  rcu_pending kernel/rcu/tree.c:2827 [inline]
  rcu_sched_clock_irq+0xe25/0x1ad0 kernel/rcu/tree.c:2271
  update_process_times+0x12d/0x180 kernel/time/timer.c:1726
  tick_sched_handle kernel/time/tick-sched.c:167 [inline]
  tick_sched_timer+0x263/0x420 kernel/time/tick-sched.c:1310
  __run_hrtimer kernel/time/hrtimer.c:1517 [inline]
  __hrtimer_run_queues+0x403/0x840 kernel/time/hrtimer.c:1579
  hrtimer_interrupt+0x38c/0xda0 kernel/time/hrtimer.c:1641
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1110 [inline]
  smp_apic_timer_interrupt+0x109/0x280 arch/x86/kernel/apic/apic.c:1135
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
  </IRQ>
RIP: 0010:memcg_kmem_uncharge include/linux/memcontrol.h:1402 [inline]
RIP: 0010:free_thread_stack+0x124/0x590 kernel/fork.c:284
Code: ff 48 c1 e8 06 48 83 e0 c0 48 bf 00 00 00 00 00 ea ff ff 48 01 c7 be  
03 00 00 00 e8 86 91 61 00 e9 5d 04 00 00 e8 3c 2c 2e 00 <48> 89 df 31 f6  
e8 02 8d 6f 00 43 80 3c 2e 00 74 08 4c 89 e7 e8 73
RSP: 0018:ffffc90002676da8 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
RAX: ffffffff81489244 RBX: ffffea00026354c0 RCX: ffff888094f7c080
RDX: 0000000000000000 RSI: 00000000fffffffc RDI: ffffea00026354c0
RBP: ffffc90002676de0 R08: 000000000003a728 R09: ffffed10123e36a9
R10: ffffed10123e36a9 R11: 0000000000000000 R12: ffff88808e5db7a0
R13: dffffc0000000000 R14: 1ffff11011cbb6f4 R15: ffff888091f1b538
  release_task_stack kernel/fork.c:440 [inline]
  put_task_stack+0xa3/0x130 kernel/fork.c:451
  finish_task_switch+0x3f1/0x550 kernel/sched/core.c:3256
  context_switch kernel/sched/core.c:3388 [inline]
  __schedule+0x9a8/0xcc0 kernel/sched/core.c:4081
  preempt_schedule_common kernel/sched/core.c:4236 [inline]
  preempt_schedule+0xdb/0x120 kernel/sched/core.c:4261
  ___preempt_schedule+0x16/0x18 arch/x86/entry/thunk_64.S:50
  vprintk_emit+0x36d/0x3a0 kernel/printk/printk.c:1997
  dev_vprintk_emit+0x495/0x513 drivers/base/core.c:3603
  dev_printk_emit+0x6a/0x8c drivers/base/core.c:3614
  __netdev_printk+0x301/0x3e9 net/core/dev.c:10217
  netdev_info+0xb9/0xe4 net/core/dev.c:10272
  dev_change_name+0x8a5/0x9b0 net/core/dev.c:1242
  do_setlink+0x8bf/0x3960 net/core/rtnetlink.c:2571
  __rtnl_newlink net/core/rtnetlink.c:3238 [inline]
  rtnl_newlink+0x14dd/0x1bd0 net/core/rtnetlink.c:3363
  rtnetlink_rcv_msg+0x889/0xd40 net/core/rtnetlink.c:5424
  netlink_rcv_skb+0x19e/0x3d0 net/netlink/af_netlink.c:2477
  rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:5442
  netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
  netlink_unicast+0x767/0x920 net/netlink/af_netlink.c:1328
  netlink_sendmsg+0xa31/0xd50 net/netlink/af_netlink.c:1917
  sock_sendmsg_nosec net/socket.c:639 [inline]
  sock_sendmsg net/socket.c:659 [inline]
  __sys_sendto+0x442/0x5e0 net/socket.c:1985
  __do_sys_sendto net/socket.c:1997 [inline]
  __se_sys_sendto net/socket.c:1993 [inline]
  __x64_sys_sendto+0xe5/0x100 net/socket.c:1993
  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x414c43
Code: ff 0f 83 b0 19 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00  
83 3d 2d 38 66 00 00 75 17 49 89 ca b8 2c 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 81 19 00 00 c3 48 83 ec 08 e8 87 fa ff ff
RSP: 002b:00007ffd9886f818 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000a71da0 RCX: 0000000000414c43
RDX: 0000000000000030 RSI: 0000000000a71df0 RDI: 0000000000000005
RBP: 0000000000000000 R08: 00007ffd9886f820 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000a71df0 R15: 0000000000000005


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
