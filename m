Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D97C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 03:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5BB20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 03:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfCFDCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 22:02:06 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:35809 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbfCFDCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 22:02:05 -0500
Received: by mail-it1-f198.google.com with SMTP id 142so4173473itx.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 19:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JUjHDIozBJ9Hm+sg+AkMXo7Y7SsLGuAF59oxoJ+s6Sw=;
        b=NHzdm6Qk0/o6qsMCLd/PYe/+popcptstd/ARisV1cMiQnN8u9S0bUYPidAk3XeI7Eb
         y4weLWdm6k4hADKLH2awEHkirRAoCRhsy/zqFrlzTJIit5aQyq2XbwuT8v+HvBm/3quN
         hU/UETWkXPhCVLwtxS8eCdAm1D/s7E3eaa4TdTCJQB49U1/IIEYcuFzwKBKnJWSfXDMg
         EFJ1nsTqCVTb2lwSJa7Icrj0PcrSpNvhkAjZZ1jsG23r2teHuYjwCoVcb//dF6JIJuUq
         OBwX4K01BlemcIriFcNKBPDIjF6wD/Akr3mEkN+5iV6gJOVkxnY1fifZGK+4D42PQVM5
         5jeA==
X-Gm-Message-State: APjAAAUJTMcajD0SsT8l3vo46PhKzyuZ4yMylJt2ExWrB5U3k+Yhoa64
        MZ1Ggo7zNtlrylZLK7foW9jozEH8jrSdlSzhatyYlZo/ViRp
X-Google-Smtp-Source: APXvYqwc16CdYNKo1Q8O+1apE/wGrxEeqZWu0y3lI+PCyWLja7deb279oBTpAF36L0BjVw9wOM20Z6RrKDW6t6Lpqs0kdLTvisPZ
MIME-Version: 1.0
X-Received: by 2002:a24:30c7:: with SMTP id q190mr4446480itq.20.1551841324070;
 Tue, 05 Mar 2019 19:02:04 -0800 (PST)
Date:   Tue, 05 Mar 2019 19:02:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de803205836436dd@google.com>
Subject: INFO: trying to register non-static key in __icmp_send
From:   syzbot <syzbot+f09d845ad631ed93737b@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    63bdf4284c38 Merge branch 'linus' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=112c679f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=872be05707464aaa
dashboard link: https://syzkaller.appspot.com/bug?extid=f09d845ad631ed93737b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1739d54f200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f09d845ad631ed93737b@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes ready
8021q: adding VLAN 0 to HW filter on device batadv0
Started in network mode
Own node identity ac1414aa, cluster identity 4711
New replicast peer: 172.20.20.187
INFO: trying to register non-static key.
Enabled bearer <udp:syz1>, priority 10
the code is fine but needs lockdep annotation.
Enabling of bearer <udp:syz1> rejected, already enabled
turning off the locking correctness validator.
Started in network mode
CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 5.0.0+ #7
Own node identity ac1414aa, cluster identity 4711
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
New replicast peer: 172.20.20.187
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  assign_lock_key kernel/locking/lockdep.c:731 [inline]
  register_lock_class+0x1bdc/0x1bf0 kernel/locking/lockdep.c:757
  __lock_acquire+0x11f/0x4700 kernel/locking/lockdep.c:3224
Enabled bearer <udp:syz1>, priority 10
Enabling of bearer <udp:syz1> rejected, already enabled
Enabling of bearer <udp:syz1> rejected, already enabled
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:3841
Enabling of bearer <udp:syz1> rejected, already enabled
  __raw_spin_trylock include/linux/spinlock_api_smp.h:90 [inline]
  _raw_spin_trylock+0x62/0x80 kernel/locking/spinlock.c:128
  spin_trylock include/linux/spinlock.h:339 [inline]
  icmp_xmit_lock net/ipv4/icmp.c:219 [inline]
  __icmp_send+0x553/0x1400 net/ipv4/icmp.c:666
Enabling of bearer <udp:syz1> rejected, already enabled
Enabling of bearer <udp:syz1> rejected, already enabled
kobject: 'loop3' (00000000853c4d7c): kobject_uevent_env
kobject: 'loop3' (00000000853c4d7c): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
  icmp_send include/net/icmp.h:47 [inline]
  __udp4_lib_rcv+0x1fb6/0x2c50 net/ipv4/udp.c:2323
Enabling of bearer <udp:syz1> rejected, already enabled
  udp_rcv+0x22/0x30 net/ipv4/udp.c:2482
Enabling of bearer <udp:syz1> rejected, already enabled
  ip_protocol_deliver_rcu+0x60/0x8f0 net/ipv4/ip_input.c:208
kobject: 'loop3' (00000000853c4d7c): kobject_uevent_env
kobject: 'loop3' (00000000853c4d7c): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
  ip_local_deliver_finish+0x23b/0x390 net/ipv4/ip_input.c:234
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ip_local_deliver+0x1e9/0x520 net/ipv4/ip_input.c:255
  dst_input include/net/dst.h:450 [inline]
  ip_rcv_finish+0x1e1/0x300 net/ipv4/ip_input.c:414
Enabling of bearer <udp:syz1> rejected, already enabled
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ip_rcv+0xe8/0x3f0 net/ipv4/ip_input.c:524
Enabling of bearer <udp:syz1> rejected, already enabled
  __netif_receive_skb_one_core+0x115/0x1a0 net/core/dev.c:4973
  __netif_receive_skb+0x2c/0x1c0 net/core/dev.c:5083
  process_backlog+0x206/0x750 net/core/dev.c:5923
  napi_poll net/core/dev.c:6346 [inline]
  net_rx_action+0x4fa/0x1070 net/core/dev.c:6412
  __do_softirq+0x266/0x95a kernel/softirq.c:292
kobject: 'loop3' (00000000853c4d7c): kobject_uevent_env
  run_ksoftirqd kernel/softirq.c:654 [inline]
  run_ksoftirqd+0x8e/0x110 kernel/softirq.c:646
  smpboot_thread_fn+0x6ab/0xa10 kernel/smpboot.c:164
Enabling of bearer <udp:syz1> rejected, already enabled
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
kasan: CONFIG_KASAN_INLINE enabled
kobject: 'loop3' (00000000853c4d7c): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 5.0.0+ #7
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__ip_append_data.isra.0+0x2e6/0x2dd0 net/ipv4/ip_output.c:898
Code: c7 85 cc fe ff ff 00 00 00 00 0f 85 28 13 00 00 e8 1f a6 99 fb 48 8b  
95 38 ff ff ff 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f  
85 73 28 00 00 48 8b 85 38 ff ff ff 48 8b 18 48 b8
RSP: 0018:ffff8880aa2c72a0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff85d63de1
RDX: 0000000000000000 RSI: ffffffff85d63e61 RDI: 0000000000000001
RBP: ffff8880aa2c7410 R08: ffff8880aa2b2440 R09: ffffffff85e694d0
R10: ffff8880aa2c7580 R11: ffff88808e459b43 R12: ffff88808e774a70
R13: ffff88808e774f10 R14: 0000000000000000 R15: dead4ead00000000
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f759ac634c0 CR3: 0000000093e6c000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  ip_append_data.part.0+0xf2/0x170 net/ipv4/ip_output.c:1220
  ip_append_data+0x6e/0x90 net/ipv4/ip_output.c:1209
  icmp_push_reply+0x189/0x510 net/ipv4/icmp.c:375
kobject: 'loop4' (000000008703cf7f): kobject_uevent_env
  __icmp_send+0xaa1/0x1400 net/ipv4/icmp.c:737
kobject: 'loop4' (000000008703cf7f): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (00000000e99d8403): kobject_uevent_env
kobject: 'loop5' (00000000e99d8403): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (00000000f5e9c027): kobject_uevent_env
  icmp_send include/net/icmp.h:47 [inline]
  __udp4_lib_rcv+0x1fb6/0x2c50 net/ipv4/udp.c:2323
kobject: 'loop2' (00000000f5e9c027): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
  udp_rcv+0x22/0x30 net/ipv4/udp.c:2482
  ip_protocol_deliver_rcu+0x60/0x8f0 net/ipv4/ip_input.c:208
  ip_local_deliver_finish+0x23b/0x390 net/ipv4/ip_input.c:234
kobject: 'loop3' (00000000853c4d7c): kobject_uevent_env
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ip_local_deliver+0x1e9/0x520 net/ipv4/ip_input.c:255
kobject: 'loop3' (00000000853c4d7c): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
  dst_input include/net/dst.h:450 [inline]
  ip_rcv_finish+0x1e1/0x300 net/ipv4/ip_input.c:414
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ip_rcv+0xe8/0x3f0 net/ipv4/ip_input.c:524
  __netif_receive_skb_one_core+0x115/0x1a0 net/core/dev.c:4973
  __netif_receive_skb+0x2c/0x1c0 net/core/dev.c:5083
  process_backlog+0x206/0x750 net/core/dev.c:5923
  napi_poll net/core/dev.c:6346 [inline]
  net_rx_action+0x4fa/0x1070 net/core/dev.c:6412
  __do_softirq+0x266/0x95a kernel/softirq.c:292
  run_ksoftirqd kernel/softirq.c:654 [inline]
  run_ksoftirqd+0x8e/0x110 kernel/softirq.c:646
  smpboot_thread_fn+0x6ab/0xa10 kernel/smpboot.c:164
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 8731dbaebb58f7f1 ]---
RIP: 0010:__ip_append_data.isra.0+0x2e6/0x2dd0 net/ipv4/ip_output.c:898
Code: c7 85 cc fe ff ff 00 00 00 00 0f 85 28 13 00 00 e8 1f a6 99 fb 48 8b  
95 38 ff ff ff 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f  
85 73 28 00 00 48 8b 85 38 ff ff ff 48 8b 18 48 b8
RSP: 0018:ffff8880aa2c72a0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff85d63de1
RDX: 0000000000000000 RSI: ffffffff85d63e61 RDI: 0000000000000001
RBP: ffff8880aa2c7410 R08: ffff8880aa2b2440 R09: ffffffff85e694d0
R10: ffff8880aa2c7580 R11: ffff88808e459b43 R12: ffff88808e774a70
R13: ffff88808e774f10 R14: 0000000000000000 R15: dead4ead00000000
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f759ac634c0 CR3: 0000000093e6c000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
32-bit node address hash set to aa1414ac


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
