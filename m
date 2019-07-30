Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A3EC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71DA20693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbfG3POH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:14:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:49886 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfG3POG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:14:06 -0400
Received: by mail-io1-f71.google.com with SMTP id x24so71736368ioh.16
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 08:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=smgJFoKe+ldZ7gW1G0iQzLj7IAS951XCwzifsjT2Jno=;
        b=cUzEGnmnyYBhWvN5RChHf5aTfQewYMI9UcDXhsLbnQvUORiqJbXcwJolSOni59Myh/
         Sl13msrFKVfNDlM39peNF8yvnUMaF+KRl8PmmMGOGwXPeGi2ZHlvT3aAHce/3aAlcBCD
         4SLggVwE3IecGEg6tXo3KUArwmC1LpsjSNFSt53m7n4t85kXzsEOQpXVxkU6OBMOcXcp
         RmTMs0SUyqZzPRfNLw4aV9oKS8NQCRqMkwH6EiVQZJHCXuSAIjkmJacMQwkpA2kHEpyY
         EIDfCMCZKW43dYJd209Xs97AVEqvFbVy8/3SVHEHsNDYpWZ2i9ddqIkfVmiIVgAXSn3o
         TAQQ==
X-Gm-Message-State: APjAAAUt49ZRCCE9UoLW8LOO0Hv+ky9EnwHLsix+GI0/u1zibqyDRhfC
        S2pwC4Vn/veS7nLrrGVV/kikBg5Koj9BqtsehjBD2R5297N4
X-Google-Smtp-Source: APXvYqz7oOqJWZBo7tlxOnyJiuNHONViAWH3KPf2h+bIFxlfjlSRM5yanimxVkv3BUIggnicBC4GE89U9jUW8VR9k7p+wFlAViAs
MIME-Version: 1.0
X-Received: by 2002:a5d:904e:: with SMTP id v14mr101501310ioq.61.1564499645615;
 Tue, 30 Jul 2019 08:14:05 -0700 (PDT)
Date:   Tue, 30 Jul 2019 08:14:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0dfe9058ee77535@google.com>
Subject: BUG: soft lockup in inet6_sendmsg
From:   syzbot <syzbot+4f7a9664a6ad9deae88f@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=15870378600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b58274564b354c1
dashboard link: https://syzkaller.appspot.com/bug?extid=4f7a9664a6ad9deae88f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4f7a9664a6ad9deae88f@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 123s! [syz-executor.0:2754]
Modules linked in:
irq event stamp: 0
hardirqs last  enabled at (0): [<0000000000000000>] 0x0
hardirqs last disabled at (0): [<ffffffff81436975>]  
copy_process+0x1815/0x6b00 kernel/fork.c:1960
softirqs last  enabled at (0): [<ffffffff81436a1c>]  
copy_process+0x18bc/0x6b00 kernel/fork.c:1963
softirqs last disabled at (0): [<0000000000000000>] 0x0
CPU: 0 PID: 2754 Comm: syz-executor.0 Not tainted 5.3.0-rc1-next-20190726  
#53
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:kasan_mem_to_shadow include/linux/kasan.h:28 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:135 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:166 [inline]
RIP: 0010:check_memory_region_inline mm/kasan/generic.c:182 [inline]
RIP: 0010:check_memory_region+0x3d/0x1a0 mm/kasan/generic.c:192
Code: 55 0f b6 d2 48 39 c7 48 89 e5 41 55 41 54 53 0f 86 07 01 00 00 4c 8d  
5c 37 ff 49 89 f8 48 b8 00 00 00 00 00 fc ff df 4d 89 da <49> c1 e8 03 4d  
8d 24 00 49 c1 ea 03 49 01 c2 4c 89 e0 49 8d 5a 01
RSP: 0018:ffff88805ca2f7a8 EFLAGS: 00000216 ORIG_RAX: ffffffffffffff13
RAX: dffffc0000000000 RBX: ffff888065af3008 RCX: ffffffff8159a3d7
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff888065af3008
RBP: ffff88805ca2f7c0 R08: ffff888065af3008 R09: ffffed100cb5e602
R10: ffff888065af300b R11: ffff888065af300b R12: 0000000000000001
R13: 0000000000000003 R14: ffffed100cb5e601 R15: 0000000000000001
FS:  00007fa806939700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 0000000054cd9000 CR4: 00000000001406f0
Call Trace:
  __kasan_check_read+0x11/0x20 mm/kasan/common.c:92
  atomic_read include/asm-generic/atomic-instrumented.h:26 [inline]
  virt_spin_lock arch/x86/include/asm/qspinlock.h:83 [inline]
  native_queued_spin_lock_slowpath+0xb7/0x9f0 kernel/locking/qspinlock.c:325
  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:642 [inline]
  queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:50 [inline]
  queued_spin_lock include/asm-generic/qspinlock.h:81 [inline]
  do_raw_spin_lock+0x20e/0x2e0 kernel/locking/spinlock_debug.c:113
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:136 [inline]
  _raw_spin_lock_bh+0x3b/0x50 kernel/locking/spinlock.c:175
  spin_lock_bh include/linux/spinlock.h:343 [inline]
  lock_sock_nested+0x41/0x120 net/core/sock.c:2917
  lock_sock include/net/sock.h:1522 [inline]
  sk_stream_wait_memory+0x83f/0xfc0 net/core/stream.c:149
  tls_sw_sendmsg+0x673/0x17b0 net/tls/tls_sw.c:1054
  inet6_sendmsg+0x9e/0xe0 net/ipv6/af_inet6.c:576
  sock_sendmsg_nosec net/socket.c:637 [inline]
  sock_sendmsg+0xd7/0x130 net/socket.c:657
  __sys_sendto+0x262/0x380 net/socket.c:1952
  __do_sys_sendto net/socket.c:1964 [inline]
  __se_sys_sendto net/socket.c:1960 [inline]
  __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1960
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459829
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fa806938c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 0000000000459829
RDX: ffffffffffffffc1 RSI: 00000000200005c0 RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 1201000000003618
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa8069396d4
R13: 00000000004c77c1 R14: 00000000004dcf38 R15: 00000000ffffffff
Sending NMI from CPU 0 to CPUs 1:
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.424  
msecs
NMI backtrace for cpu 1
CPU: 1 PID: 2752 Comm: syz-executor.0 Not tainted 5.3.0-rc1-next-20190726  
#53
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:atomic_read include/asm-generic/atomic-instrumented.h:26 [inline]
RIP: 0010:virt_spin_lock arch/x86/include/asm/qspinlock.h:83 [inline]
RIP: 0010:native_queued_spin_lock_slowpath+0xaa/0x9f0  
kernel/locking/qspinlock.c:325
Code: 0f 1f 44 00 00 49 89 fe 49 89 fd 41 bc 01 00 00 00 49 c1 ee 03 41 83  
e5 07 48 b8 00 00 00 00 00 fc ff df 49 01 c6 41 83 c5 03 <be> 04 00 00 00  
48 89 df e8 89 70 53 00 41 0f b6 06 41 38 c5 7c 08
RSP: 0018:ffff8880ae909210 EFLAGS: 00000202
RAX: 0000000000000000 RBX: ffff888065af3008 RCX: ffffffff8159a3d7
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff888065af3008
RBP: ffff8880ae9092d0 R08: 1ffff1100cb5e601 R09: ffffed100cb5e602
R10: ffffed100cb5e601 R11: ffff888065af300b R12: 0000000000000001
R13: 0000000000000003 R14: ffffed100cb5e601 R15: 0000000000000001
FS:  0000555556d81940(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ca29000 CR3: 0000000054cd9000 CR4: 00000000001406e0
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
RSP: 002b:00007ffd13936640 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000413511
RDX: 0000000000000000 RSI: 000000000000059f RDI: 0000000000000004
RBP: 0000000000000001 R08: 000000000dcf459f R09: 000000000dcf45a3
R10: 00007ffd13936720 R11: 0000000000000293 R12: 000000000075c9a0
R13: 000000000075c9a0 R14: 0000000000760858 R15: ffffffffffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
