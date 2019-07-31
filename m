Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB94C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464422067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfGaIaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 04:30:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:38005 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfGaIaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:30:06 -0400
Received: by mail-io1-f71.google.com with SMTP id h4so74627080iol.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 01:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LigDm/EnmWJmRrBNfjzQY1Cv9OT6G/QlGkw1X6XT5z0=;
        b=P09AB/sQNlvInnudkJfeo12oDO6aybG40zOxpIGNbhNPXaXMY9Th1n8L9GWVyF9b4A
         nVXB/AI40L7RIgxZL5fE3uLvt8TIVlE+i8GckGtC/TN6EbAuFL318uFzyo3bZzl3Yv4c
         Te5PbDZB/5fa+bQ2cjv951f7jTWTUf8DvCJLsNwAXrgfD/2LhbMfB+3fxLuPTqzfviUm
         04eWKLfafqvrPDTQ3E2kddQtlC3SkVkMqlt/UmsyV0FWs2SNCQTfN7tuaBG8hdaFbfiw
         JCTimc4LjvHMXImqNSmFW9wyaLKw5keMLy98cPzYfIpAf7V+RHcAghKmGjiPJEdSYluN
         vWgA==
X-Gm-Message-State: APjAAAW5ikKdkY46ohfDv8lO31BbBcQYBJFHMYCh9gbZhiYF6Rl3N4eK
        J4j235nypRIQfs9nOvBYbYaeqNtLmvEppWXQuRd1dPxjZBLT
X-Google-Smtp-Source: APXvYqw+Uan0YgfQd0SY83erJzQmfeA/cJg7LvGvxKgwWSV55Cp72x2kBvRvpeugwcNr6C35EwHVEQlo3PjVF6Bai6TUtsPNEi+q
MIME-Version: 1.0
X-Received: by 2002:a6b:5103:: with SMTP id f3mr106674612iob.142.1564561805455;
 Wed, 31 Jul 2019 01:30:05 -0700 (PDT)
Date:   Wed, 31 Jul 2019 01:30:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a4c218058ef5eef5@google.com>
Subject: BUG: soft lockup in ipv6_rcv
From:   syzbot <syzbot+8963398ab778549744e2@syzkaller.appspotmail.com>
To:     aarcange@redhat.com, akpm@linux-foundation.org,
        christian@brauner.io, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, keescook@chromium.org,
        ldv@altlinux.org, linux-kernel@vger.kernel.org,
        luto@amacapital.net, mhocko@suse.com, mingo@kernel.org,
        namit@vmware.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        wad@chromium.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    fde50b96 Add linux-next specific files for 20190726
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1431fb94600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b58274564b354c1
dashboard link: https://syzkaller.appspot.com/bug?extid=8963398ab778549744e2
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8963398ab778549744e2@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 122s! [syz-executor.0:26574]
Modules linked in:
irq event stamp: 0
hardirqs last  enabled at (0): [<0000000000000000>] 0x0
hardirqs last disabled at (0): [<ffffffff81436975>]  
copy_process+0x1815/0x6b00 kernel/fork.c:1960
softirqs last  enabled at (0): [<ffffffff81436a1c>]  
copy_process+0x18bc/0x6b00 kernel/fork.c:1963
softirqs last disabled at (0): [<0000000000000000>] 0x0
CPU: 0 PID: 26574 Comm: syz-executor.0 Not tainted 5.3.0-rc1-next-20190726  
#53
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:cpu_relax arch/x86/include/asm/processor.h:656 [inline]
RIP: 0010:virt_spin_lock arch/x86/include/asm/qspinlock.h:84 [inline]
RIP: 0010:native_queued_spin_lock_slowpath+0x132/0x9f0  
kernel/locking/qspinlock.c:325
Code: 00 00 00 48 8b 45 d0 65 48 33 04 25 28 00 00 00 0f 85 37 07 00 00 48  
81 c4 98 00 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d c3 f3 90 <e9> 73 ff ff ff  
8b 45 98 4c 8d 65 d8 3d 00 01 00 00 0f 84 e5 00 00
RSP: 0018:ffff8880ae809210 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000000 RBX: ffff88805efd2dc8 RCX: ffffffff8159a3d7
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88805efd2dc8
RBP: ffff8880ae8092d0 R08: 1ffff1100bdfa5b9 R09: ffffed100bdfa5ba
R10: ffffed100bdfa5b9 R11: ffff88805efd2dcb R12: 0000000000000001
R13: 0000000000000003 R14: ffffed100bdfa5b9 R15: 0000000000000001
FS:  000055555716e940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31527000 CR3: 0000000055505000 CR4: 00000000001406f0
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
RSP: 002b:00007ffde3c0a440 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000413511
RDX: 0000000000000000 RSI: 0000000000000ce3 RDI: 0000000000000004
RBP: 0000000000000001 R08: 00000000cf152ce3 R09: 00000000cf152ce7
R10: 00007ffde3c0a520 R11: 0000000000000293 R12: 000000000075c9a0
R13: 000000000075c9a0 R14: 0000000000761060 R15: ffffffffffffffff
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 26610 Comm: syz-executor.3 Not tainted 5.3.0-rc1-next-20190726  
#53
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__kasan_check_read+0x8/0x20 mm/kasan/common.c:92
Code: 8b 4d d0 e9 27 ee ff ff 48 8b 73 58 89 c2 48 c7 c7 c8 a9 89 88 f7 da  
e8 7a 48 af ff e9 da ee ff ff 90 55 89 f6 31 d2 48 89 e5 <48> 8b 4d 08 e8  
cf 26 00 00 5d c3 0f 1f 00 66 2e 0f 1f 84 00 00 00
RSP: 0018:ffff8880ae909b38 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff88805efd2dc8 RCX: ffffffff8159a3d7
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88805efd2dc8
RBP: ffff8880ae909b38 R08: 1ffff1100bdfa5b9 R09: ffffed100bdfa5ba
R10: ffffed100bdfa5b9 R11: ffff88805efd2dcb R12: 0000000000000001
R13: 0000000000000003 R14: ffffed100bdfa5b9 R15: 0000000000000001
FS:  00007f26617ff700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020e00000 CR3: 0000000090fc4000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  atomic_read include/asm-generic/atomic-instrumented.h:26 [inline]
  virt_spin_lock arch/x86/include/asm/qspinlock.h:83 [inline]
  native_queued_spin_lock_slowpath+0xb7/0x9f0 kernel/locking/qspinlock.c:325
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
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x1a3/0x610 arch/x86/kernel/apic/apic.c:1095
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:828
  </IRQ>
RIP: 0010:write_comp_data+0x1e/0x70 kernel/kcov.c:123
Code: 48 89 34 d1 48 89 11 5d c3 0f 1f 00 65 4c 8b 04 25 40 fe 01 00 65 8b  
05 d8 2f 8f 7e a9 00 01 1f 00 75 51 41 8b 80 f8 12 00 00 <83> f8 03 75 45  
49 8b 80 00 13 00 00 45 8b 80 fc 12 00 00 4c 8b 08
RSP: 0018:ffff88805511fca0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000002 RBX: 0000000000000000 RCX: ffffffff84b51f3b
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: ffff88805511fca8 R08: ffff8880a9036580 R09: ffffed100aa23fa7
R10: ffffed100aa23fa6 R11: ffff88805511fd37 R12: 0000000000f79770
R13: dffffc0000000000 R14: 0000000000f79758 R15: ffff88805511fd80
  evdev_write+0x3ab/0x7b0 drivers/input/evdev.c:536
  __vfs_write+0x8a/0x110 fs/read_write.c:494
  vfs_write+0x268/0x5d0 fs/read_write.c:558
  ksys_write+0x220/0x290 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write fs/read_write.c:620 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:620
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459829
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f26617fec78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459829
RDX: 00000000fffffe82 RSI: 000000002004d000 RDI: 0000000000000003
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f26617ff6d4
R13: 00000000004c9915 R14: 00000000004e0e98 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
