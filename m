Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C9FC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B852218EA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfGZKzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 06:55:08 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:51153 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfGZKzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 06:55:07 -0400
Received: by mail-io1-f69.google.com with SMTP id m26so58329057ioh.17
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 03:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7LlGVmHhS3OGfBGijMWUGYUfIVh/vBZiyJcoK0xbtls=;
        b=JYcyGfi7hWuth27cyp+Iauid9lgD0cfZ4jY+sVP/b+WIrRBuE86oMcl1EX2tfY+ql+
         lB4SyrO8vQX5tgNEIoIGzE4NntnMComjLyFWLUCj9OmzJPGJT0wbhUSSmve9owc+rj7Y
         VlHR+kuouw+vjOCVUI64G2QwBA3sMdj+pZbWUoJZHVtNqw5u67nj1w9Z3s8E3mvjuI/B
         JDRFt0HWIzBxasMxYWjeMWSTX316vLoQrNRh0uJLxbs1he3aiMj47+m3ko4FYA9efgqW
         1P1dR4ZR4Wef6Ew1aXyiX+RuXFHPySNk46x9xoA0Whfs3EUA1WtMdmuJYJZAp4SqISpl
         kuyA==
X-Gm-Message-State: APjAAAUImnKSMY/AWTn+ivq2R3TcUhLmIGd7XcmC+MQJ+qFKTOVdWmwJ
        rTcI5xBhUNq1xUn1GWof4vRzB6lcmbYjqYvimYMeUsJx/6sG
X-Google-Smtp-Source: APXvYqzsC+HanwYlOZ+7qEuAy9dQ3DGFWI9LuYPCukXPBPWJARF5xKMarMx8reMwcZFQ06KiPnCAFxBvjrPdzNabigzQvlp88ERr
MIME-Version: 1.0
X-Received: by 2002:a02:3904:: with SMTP id l4mr95712957jaa.81.1564138506671;
 Fri, 26 Jul 2019 03:55:06 -0700 (PDT)
Date:   Fri, 26 Jul 2019 03:55:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011e277058e93607d@google.com>
Subject: BUG: soft lockup in tcp_write_timer
From:   syzbot <syzbot+97ff1b2561a76fa6c8f1@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    13bf6d6a Add linux-next specific files for 20190725
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12b1c1f0600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ae987d803395886
dashboard link: https://syzkaller.appspot.com/bug?extid=97ff1b2561a76fa6c8f1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+97ff1b2561a76fa6c8f1@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 123s! [swapper/0:0]
Modules linked in:
irq event stamp: 90712
hardirqs last  enabled at (90711): [<ffffffff8166a741>]  
tick_nohz_idle_exit+0x181/0x2e0 kernel/time/tick-sched.c:1180
hardirqs last disabled at (90712): [<ffffffff873dfe1d>]  
__schedule+0x1dd/0x1580 kernel/sched/core.c:3821
softirqs last  enabled at (89822): [<ffffffff876006cd>]  
__do_softirq+0x6cd/0x98c kernel/softirq.c:319
softirqs last disabled at (89807): [<ffffffff8145c19b>] invoke_softirq  
kernel/softirq.c:373 [inline]
softirqs last disabled at (89807): [<ffffffff8145c19b>]  
irq_exit+0x19b/0x1e0 kernel/softirq.c:413
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.3.0-rc1-next-20190725 #52
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:cpu_relax arch/x86/include/asm/processor.h:656 [inline]
RIP: 0010:virt_spin_lock arch/x86/include/asm/qspinlock.h:84 [inline]
RIP: 0010:native_queued_spin_lock_slowpath+0x132/0x9f0  
kernel/locking/qspinlock.c:325
Code: 00 00 00 48 8b 45 d0 65 48 33 04 25 28 00 00 00 0f 85 37 07 00 00 48  
81 c4 98 00 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d c3 f3 90 <e9> 73 ff ff ff  
8b 45 98 4c 8d 65 d8 3d 00 01 00 00 0f 84 e5 00 00
RSP: 0018:ffff8880ae809b48 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000000 RBX: ffff888060b8a208 RCX: ffffffff81599777
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff888060b8a208
RBP: ffff8880ae809c08 R08: 1ffff1100c171441 R09: ffffed100c171442
R10: ffffed100c171441 R11: ffff888060b8a20b R12: 0000000000000001
R13: 0000000000000003 R14: ffffed100c171441 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000021000000 CR3: 000000009fa30000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:642 [inline]
  queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:50 [inline]
  queued_spin_lock include/asm-generic/qspinlock.h:81 [inline]
  do_raw_spin_lock+0x20e/0x2e0 kernel/locking/spinlock_debug.c:113
  __raw_spin_lock include/linux/spinlock_api_smp.h:143 [inline]
  _raw_spin_lock+0x37/0x40 kernel/locking/spinlock.c:151
  spin_lock include/linux/spinlock.h:338 [inline]
  tcp_write_timer+0x2b/0x1e0 net/ipv4/tcp_timer.c:610
  call_timer_fn+0x1ac/0x780 kernel/time/timer.c:1322
  expire_timers kernel/time/timer.c:1366 [inline]
  __run_timers kernel/time/timer.c:1685 [inline]
  __run_timers kernel/time/timer.c:1653 [inline]
  run_timer_softirq+0x697/0x17a0 kernel/time/timer.c:1698
  __do_softirq+0x262/0x98c kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x19b/0x1e0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:537 [inline]
  smp_apic_timer_interrupt+0x1a3/0x610 arch/x86/kernel/apic/apic.c:1095
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:828
  </IRQ>
RIP: 0010:native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:61
Code: 78 d2 6d fa eb 8a 90 90 90 90 90 90 e9 07 00 00 00 0f 00 2d 84 14 49  
00 f4 c3 66 90 e9 07 00 00 00 0f 00 2d 74 14 49 00 fb f4 <c3> 90 55 48 89  
e5 41 57 41 56 41 55 41 54 53 e8 9e 5d 21 fa e8 69
RSP: 0018:ffffffff88c07ce8 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff11a5e5b RBX: ffffffff88c7a1c0 RCX: 1ffffffff134bc46
RDX: dffffc0000000000 RSI: ffffffff817831be RDI: ffffffff873f168c
RBP: ffffffff88c07d18 R08: ffffffff88c7a1c0 R09: fffffbfff118f439
R10: fffffbfff118f438 R11: ffffffff88c7a1c7 R12: dffffc0000000000
R13: ffffffff89a5b040 R14: 0000000000000000 R15: 0000000000000000
  arch_cpu_idle+0xa/0x10 arch/x86/kernel/process.c:571
  default_idle_call+0x84/0xb0 kernel/sched/idle.c:94
  cpuidle_idle_call kernel/sched/idle.c:154 [inline]
  do_idle+0x413/0x760 kernel/sched/idle.c:263
  cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:354
  rest_init+0x245/0x37b init/main.c:451
  arch_call_rest_init+0xe/0x1b
  start_kernel+0x912/0x951 init/main.c:785
  x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:472
  x86_64_start_kernel+0x77/0x7b arch/x86/kernel/head64.c:453
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241
Sending NMI from CPU 0 to CPUs 1:
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.136  
msecs
NMI backtrace for cpu 1
CPU: 1 PID: 23415 Comm: syz-executor.2 Not tainted 5.3.0-rc1-next-20190725  
#52
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:31 [inline]
RIP: 0010:atomic_read include/asm-generic/atomic-instrumented.h:27 [inline]
RIP: 0010:virt_spin_lock arch/x86/include/asm/qspinlock.h:83 [inline]
RIP: 0010:native_queued_spin_lock_slowpath+0xb7/0x9f0  
kernel/locking/qspinlock.c:325
Code: 01 00 00 00 49 c1 ee 03 41 83 e5 07 48 b8 00 00 00 00 00 fc ff df 49  
01 c6 41 83 c5 03 be 04 00 00 00 48 89 df e8 e9 32 53 00 <41> 0f b6 06 41  
38 c5 7c 08 84 c0 0f 85 4e 07 00 00 44 8b 3b 45 85
RSP: 0018:ffff8880ae909210 EFLAGS: 00000246
RAX: 0000000000000001 RBX: ffff888060b8a208 RCX: ffffffff81599777
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff888060b8a208
RBP: ffff8880ae9092d0 R08: 1ffff1100c171441 R09: ffffed100c171442
R10: ffffed100c171441 R11: ffff888060b8a20b R12: 0000000000000001
R13: 0000000000000003 R14: ffffed100c171441 R15: 0000000000000001
FS:  0000555556dd4940(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2fa2a000 CR3: 000000009a159000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:642 [inline]
  queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:50 [inline]
  queued_spin_lock include/asm-generic/qspinlock.h:81 [inline]
  do_raw_spin_lock+0x20e/0x2e0 kernel/locking/spinlock_debug.c:113
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:136 [inline]
  _raw_spin_lock_bh+0x3b/0x50 kernel/locking/spinlock.c:175
  spin_lock_bh include/linux/spinlock.h:343 [inline]
  release_sock+0x20/0x1c0 net/core/sock.c:2932
  wait_on_pending_writer+0x20f/0x420 net/tls/tls_main.c:91
  tls_sk_proto_cleanup+0x2c5/0x3e0 net/tls/tls_main.c:295
  tls_sk_proto_unhash+0x90/0x3f0 net/tls/tls_main.c:330
  tcp_set_state+0x5b9/0x7d0 net/ipv4/tcp.c:2235
  tcp_done+0xe2/0x320 net/ipv4/tcp.c:3824
  tcp_reset+0x132/0x500 net/ipv4/tcp_input.c:4080
  tcp_validate_incoming+0xa2d/0x1660 net/ipv4/tcp_input.c:5440
  tcp_rcv_established+0x6b5/0x1e70 net/ipv4/tcp_input.c:5648
  tcp_v6_do_rcv+0x41e/0x12c0 net/ipv6/tcp_ipv6.c:1356
  tcp_v6_rcv+0x31f1/0x3500 net/ipv6/tcp_ipv6.c:1588
  ip6_protocol_deliver_rcu+0x2fe/0x1660 net/ipv6/ip6_input.c:397
  ip6_input_finish+0x84/0x170 net/ipv6/ip6_input.c:438
  NF_HOOK include/linux/netfilter.h:305 [inline]
  NF_HOOK include/linux/netfilter.h:299 [inline]
  ip6_input+0xe4/0x3f0 net/ipv6/ip6_input.c:447
  dst_input include/net/dst.h:442 [inline]
  ip6_rcv_finish+0x1de/0x2f0 net/ipv6/ip6_input.c:76
  NF_HOOK include/linux/netfilter.h:305 [inline]
  NF_HOOK include/linux/netfilter.h:299 [inline]
  ipv6_rcv+0x10e/0x420 net/ipv6/ip6_input.c:272
  __netif_receive_skb_one_core+0x113/0x1a0 net/core/dev.c:4999
  __netif_receive_skb+0x2c/0x1d0 net/core/dev.c:5113
  process_backlog+0x206/0x750 net/core/dev.c:5924
  napi_poll net/core/dev.c:6347 [inline]
  net_rx_action+0x508/0x10c0 net/core/dev.c:6413
  __do_softirq+0x262/0x98c kernel/softirq.c:292
  do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:1080
  </IRQ>
  do_softirq.part.0+0x11a/0x170 kernel/softirq.c:337
  do_softirq kernel/softirq.c:329 [inline]
  __local_bh_enable_ip+0x211/0x270 kernel/softirq.c:189
  local_bh_enable include/linux/bottom_half.h:32 [inline]
  inet_csk_listen_stop+0x1e0/0x850 net/ipv4/inet_connection_sock.c:993
  tcp_close+0xd5b/0x10e0 net/ipv4/tcp.c:2338
  inet_release+0xed/0x200 net/ipv4/af_inet.c:427
  inet6_release+0x53/0x80 net/ipv6/af_inet6.c:470
  __sock_release+0xce/0x280 net/socket.c:590
  sock_close+0x1e/0x30 net/socket.c:1268
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x316/0x380 arch/x86/entry/common.c:163
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x65f/0x760 arch/x86/entry/common.c:300
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x413511
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 1b 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffd72454c50 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000006 RCX: 0000000000413511
RDX: 0000000000000000 RSI: 00000000000017f5 RDI: 0000000000000005
RBP: 0000000000000001 R08: 000000002f60b7f5 R09: 000000002f60b7f9
R10: 00007ffd72454d30 R11: 0000000000000293 R12: 000000000075c9a0
R13: 000000000075c9a0 R14: 0000000000761370 R15: ffffffffffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
