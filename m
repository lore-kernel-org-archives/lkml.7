Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDEFC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 03:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB6A20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 03:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfCFDwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 22:52:06 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:36139 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbfCFDwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 22:52:05 -0500
Received: by mail-io1-f72.google.com with SMTP id v3so8711148iol.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 19:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8O1gdkXxksIJT3PF3rvFfv9eH/Z4P5Ac0q8Bb0sdadk=;
        b=HrnYSWr2MVSpDGoDCBhrkxBe6Rq7kCx6607VNPYj+Gy1L6P5n3vI3sMhirdnuOJAyb
         7a5NhhZxTBykD9cQ3+0ms/HVmNly8ottCNZViHcYQ06u+yg+Rs7iWeXLCfpKa7nvp+jk
         /x2qgZ/JOw4GShT1YECSJ5nEJWOWbiYbnZ9MBoDJuEnnPVgP2QSim91AVQ7ePwUWMKdu
         Ym/irpe3Yn6loG5MVm58azXHjEbM1XaMC54nSEDJ5cG8SzQEDwrlT82VcZncj3cyLXKk
         sbHk2n8XjJqjKVSciqtbek8TbxfU9QeqZXxWLgdi6/EDekHu/pGbi987H8zgGbDyxsDf
         ai2A==
X-Gm-Message-State: APjAAAWSPerI+thR4eS4Y3qOqMIWcdhl7yAvkEynypPSmFTcplRzYsHb
        SGue4s82oe1r+u6cuFZLqxtBD4ejP6ARm1XQH0/vThdcPSzu
X-Google-Smtp-Source: APXvYqxgeeYIdO0wGOS76vOnbygMOgeh5MOzemGVRntks2m89w+BZEAHT5x3p6UDexZSbaa2QokHGOXZwuYmumjAIe1ylQ8iSDlh
MIME-Version: 1.0
X-Received: by 2002:a24:78c:: with SMTP id f134mr4456585itf.30.1551844324132;
 Tue, 05 Mar 2019 19:52:04 -0800 (PST)
Date:   Tue, 05 Mar 2019 19:52:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000afcf18058364e99e@google.com>
Subject: WARNING: locking bug in __icmp_send
From:   syzbot <syzbot+173d67242daa7ce45f85@syzkaller.appspotmail.com>
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

HEAD commit:    d9862cfbe209 Merge tag 'mips_5.1' of git://git.kernel.org/..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=10dfb0e7200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73d88a42238825ad
dashboard link: https://syzkaller.appspot.com/bug?extid=173d67242daa7ce45f85
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153d6923200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+173d67242daa7ce45f85@syzkaller.appspotmail.com

Enabling of bearer <udp:syz1> rejected, already enabled
Enabling of bearer <udp:syz1> rejected, already enabled
Enabling of bearer <udp:syz1> rejected, already enabled
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(class_idx > MAX_LOCKDEP_KEYS)
WARNING: CPU: 0 PID: 9 at kernel/locking/lockdep.c:3315  
__lock_acquire+0x13bf/0x4700 kernel/locking/lockdep.c:3315
Enabling of bearer <udp:syz1> rejected, already enabled
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 5.0.0+ #109
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
Enabling of bearer <udp:syz1> rejected, already enabled
  panic+0x2cb/0x65c kernel/panic.c:214
kobject: 'loop0' (00000000f02900e9): kobject_uevent_env
kobject: 'loop0' (00000000f02900e9): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
  __warn.cold+0x20/0x45 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  fixup_bug arch/x86/kernel/traps.c:173 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
kobject: 'loop2' (00000000763050ef): kobject_uevent_env
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:__lock_acquire+0x13bf/0x4700 kernel/locking/lockdep.c:3315
kobject: 'loop2' (00000000763050ef): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
Code: 8b 1d 69 20 06 08 45 85 db 0f 85 d6 f4 ff ff 48 c7 c6 80 a4 6b 87 48  
c7 c7 e0 78 6b 87 44 89 9c 24 98 00 00 00 e8 0f 26 ec ff <0f> 0b 44 8b 9c  
24 98 00 00 00 e9 af f4 ff ff 8b 3d bc e4 fe 08 85
RSP: 0018:ffff8880aa26f300 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000066c4c53a RCX: 0000000000000000
RDX: 0000000000000100 RSI: ffffffff815a65c6 RDI: ffffed101544de52
RBP: ffff8880aa26f4d0 R08: ffff8880aa25c240 R09: fffffbfff1133335
R10: fffffbfff1133334 R11: ffffffff889999a3 R12: ffff8880aa25cb28
R13: ffff8880aa25cb32 R14: 0000000066c4c53a R15: ffff8880aa25c240
Enabling of bearer <udp:syz1> rejected, already enabled
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:3841
kobject: 'loop5' (0000000002a93434): kobject_uevent_env
kobject: 'loop5' (0000000002a93434): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
  __raw_spin_trylock include/linux/spinlock_api_smp.h:90 [inline]
  _raw_spin_trylock+0x62/0x80 kernel/locking/spinlock.c:128
  spin_trylock include/linux/spinlock.h:339 [inline]
  icmp_xmit_lock net/ipv4/icmp.c:219 [inline]
  __icmp_send+0x553/0x1400 net/ipv4/icmp.c:666
Enabling of bearer <udp:syz1> rejected, already enabled
kobject: 'loop0' (00000000f02900e9): kobject_uevent_env
kobject: 'loop0' (00000000f02900e9): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (000000004f39548c): kobject_uevent_env
  icmp_send include/net/icmp.h:47 [inline]
  __udp4_lib_rcv+0x1fb6/0x2c50 net/ipv4/udp.c:2323
kobject: 'loop1' (000000004f39548c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
  udp_rcv+0x22/0x30 net/ipv4/udp.c:2482
  ip_protocol_deliver_rcu+0x60/0x8f0 net/ipv4/ip_input.c:208
  ip_local_deliver_finish+0x23b/0x390 net/ipv4/ip_input.c:234
kobject: 'loop2' (00000000763050ef): kobject_uevent_env
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ip_local_deliver+0x1e9/0x520 net/ipv4/ip_input.c:255
kobject: 'loop2' (00000000763050ef): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
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
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
