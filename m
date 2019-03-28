Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC07C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0D421773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfC1QOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:14:09 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:35032 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfC1QOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:14:07 -0400
Received: by mail-it1-f198.google.com with SMTP id n19so709502itb.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=B09Z/iqd+WXO0+yxuBZ/s9h8/2B6z/0VrC0szfGcazw=;
        b=Xf0ZM1STCmcGXA9W/X7ovceI31wQwofVx6jqe6mHW19nrS7b4V823VpX/yXA+V9zxw
         W6PxbsiyLowsDHvzV/Wr+ttxvw5bQ/NGvQJ5I29nm8R2/AqsBQLR92x+ErcggMGpZjVW
         /h+I81ZfufgEBA6y7uY6if5CpKLwzgmDA4Q/syU60tNHyn50I3RzseO7b69lvbIVmX9F
         wJEPnzjPfwQk2iPDtNhlDOI41yZDQxCDIyBSIR4elOV8V+85a6DHjQllOaTJWmtz1Wxw
         ZmdYE0VfS++wlM8+4nGdZmtJzL0FvjxhkOWJi9AwgYfOG4myIsAIwv2URNy9lomRAJE7
         k/Lg==
X-Gm-Message-State: APjAAAW0teeGIrStNkNrqkhesogCJ1SWqsGiUu+7hBN7dKcDxdUNJimc
        3ralRcXDhl0lFL8xk1MNFL/EqIvLh2Rcxgsmlchc0pmeQRAt
X-Google-Smtp-Source: APXvYqzcPahElXOJlxvvvWTgoXVSiEQjcVr2FCoR3T19M3vS3CtQYbjXKgaKsk3dlgj8qqU8iDG8toTBWXtymv32kJ7YfAOlAiNi
MIME-Version: 1.0
X-Received: by 2002:a02:8243:: with SMTP id q3mr2565648jag.6.1553789646402;
 Thu, 28 Mar 2019 09:14:06 -0700 (PDT)
Date:   Thu, 28 Mar 2019 09:14:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee01ef058529d74c@google.com>
Subject: possible deadlock in __dev_queue_xmit (2)
From:   syzbot <syzbot+f8c40b4da41f3e8049c4@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    356d71e0 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=178772cd200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3116859fdc14be5c
dashboard link: https://syzkaller.appspot.com/bug?extid=f8c40b4da41f3e8049c4
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f8c40b4da41f3e8049c4@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
5.1.0-rc2+ #112 Not tainted
--------------------------------------------
syz-executor.0/13941 is trying to acquire lock:
000000009c1e85f2 (_xmit_ETHER#2){+.-.}, at: spin_lock  
include/linux/spinlock.h:329 [inline]
000000009c1e85f2 (_xmit_ETHER#2){+.-.}, at: __netif_tx_lock  
include/linux/netdevice.h:3893 [inline]
000000009c1e85f2 (_xmit_ETHER#2){+.-.}, at: __dev_queue_xmit+0x2b65/0x36b0  
net/core/dev.c:3867

but task is already holding lock:
000000000ad63340 (_xmit_ETHER#2){+.-.}, at: spin_lock  
include/linux/spinlock.h:329 [inline]
000000000ad63340 (_xmit_ETHER#2){+.-.}, at: __netif_tx_lock  
include/linux/netdevice.h:3893 [inline]
000000000ad63340 (_xmit_ETHER#2){+.-.}, at: sch_direct_xmit+0x2de/0xf70  
net/sched/sch_generic.c:325

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(_xmit_ETHER#2);
   lock(_xmit_ETHER#2);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

7 locks held by syz-executor.0/13941:
  #0: 000000007091b59b (rcu_read_lock_bh){....}, at: lwtunnel_xmit_redirect  
include/net/lwtunnel.h:92 [inline]
  #0: 000000007091b59b (rcu_read_lock_bh){....}, at:  
ip_finish_output2+0x2af/0x1740 net/ipv4/ip_output.c:213
  #1: 000000007091b59b (rcu_read_lock_bh){....}, at:  
__dev_queue_xmit+0x20a/0x36b0 net/core/dev.c:3805
  #2: 00000000aa7d63d7 (&(&sch->seqlock)->rlock){+...}, at: spin_trylock  
include/linux/spinlock.h:339 [inline]
  #2: 00000000aa7d63d7 (&(&sch->seqlock)->rlock){+...}, at: qdisc_run_begin  
include/net/sch_generic.h:159 [inline]
  #2: 00000000aa7d63d7 (&(&sch->seqlock)->rlock){+...}, at: __dev_xmit_skb  
net/core/dev.c:3472 [inline]
  #2: 00000000aa7d63d7 (&(&sch->seqlock)->rlock){+...}, at:  
__dev_queue_xmit+0x251d/0x36b0 net/core/dev.c:3839
  #3: 00000000a23aaf2c (dev->qdisc_running_key ?: &qdisc_running_key){+...},  
at: dev_queue_xmit+0x18/0x20 net/core/dev.c:3904
  #4: 000000000ad63340 (_xmit_ETHER#2){+.-.}, at: spin_lock  
include/linux/spinlock.h:329 [inline]
  #4: 000000000ad63340 (_xmit_ETHER#2){+.-.}, at: __netif_tx_lock  
include/linux/netdevice.h:3893 [inline]
  #4: 000000000ad63340 (_xmit_ETHER#2){+.-.}, at:  
sch_direct_xmit+0x2de/0xf70 net/sched/sch_generic.c:325
  #5: 000000007091b59b (rcu_read_lock_bh){....}, at: lwtunnel_xmit_redirect  
include/net/lwtunnel.h:92 [inline]
  #5: 000000007091b59b (rcu_read_lock_bh){....}, at:  
ip_finish_output2+0x2af/0x1740 net/ipv4/ip_output.c:213
  #6: 000000007091b59b (rcu_read_lock_bh){....}, at:  
__dev_queue_xmit+0x20a/0x36b0 net/core/dev.c:3805

stack backtrace:
CPU: 1 PID: 13941 Comm: syz-executor.0 Not tainted 5.1.0-rc2+ #112
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_deadlock_bug kernel/locking/lockdep.c:2100 [inline]
  check_deadlock kernel/locking/lockdep.c:2144 [inline]
  validate_chain kernel/locking/lockdep.c:2698 [inline]
  __lock_acquire.cold+0x233/0x50d kernel/locking/lockdep.c:3701
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4211
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:144
  spin_lock include/linux/spinlock.h:329 [inline]
  __netif_tx_lock include/linux/netdevice.h:3893 [inline]
  __dev_queue_xmit+0x2b65/0x36b0 net/core/dev.c:3867
  dev_queue_xmit+0x18/0x20 net/core/dev.c:3904
  neigh_resolve_output net/core/neighbour.c:1487 [inline]
  neigh_resolve_output+0x5a7/0x970 net/core/neighbour.c:1467
  neigh_output include/net/neighbour.h:508 [inline]
  ip_finish_output2+0x949/0x1740 net/ipv4/ip_output.c:229
  ip_finish_output+0x73c/0xd50 net/ipv4/ip_output.c:317
  NF_HOOK_COND include/linux/netfilter.h:278 [inline]
  ip_mc_output+0x292/0xf70 net/ipv4/ip_output.c:390
  dst_output include/net/dst.h:433 [inline]
  ip_local_out+0xc4/0x1b0 net/ipv4/ip_output.c:124
  iptunnel_xmit+0x58e/0x980 net/ipv4/ip_tunnel_core.c:91
  ip_tunnel_xmit+0x1038/0x2bfa net/ipv4/ip_tunnel.c:831
  __gre_xmit+0x5e9/0x9a0 net/ipv4/ip_gre.c:444
  erspan_xmit+0x912/0x28b0 net/ipv4/ip_gre.c:679
  __netdev_start_xmit include/linux/netdevice.h:4409 [inline]
  netdev_start_xmit include/linux/netdevice.h:4418 [inline]
  xmit_one net/core/dev.c:3278 [inline]
  dev_hard_start_xmit+0x1b2/0x980 net/core/dev.c:3294
  sch_direct_xmit+0x370/0xf70 net/sched/sch_generic.c:327
  __dev_xmit_skb net/core/dev.c:3475 [inline]
  __dev_queue_xmit+0x282d/0x36b0 net/core/dev.c:3839
  dev_queue_xmit+0x18/0x20 net/core/dev.c:3904
  neigh_resolve_output net/core/neighbour.c:1487 [inline]
  neigh_resolve_output+0x5a7/0x970 net/core/neighbour.c:1467
  neigh_output include/net/neighbour.h:508 [inline]
  ip_finish_output2+0x949/0x1740 net/ipv4/ip_output.c:229
  ip_finish_output+0x73c/0xd50 net/ipv4/ip_output.c:317
  NF_HOOK_COND include/linux/netfilter.h:278 [inline]
  ip_mc_output+0x292/0xf70 net/ipv4/ip_output.c:390
  dst_output include/net/dst.h:433 [inline]
  ip_local_out+0xc4/0x1b0 net/ipv4/ip_output.c:124
  ip_send_skb+0x42/0xf0 net/ipv4/ip_output.c:1465
  udp_send_skb.isra.0+0x6b2/0x1180 net/ipv4/udp.c:901
  udp_sendmsg+0x1dfd/0x2820 net/ipv4/udp.c:1188
  inet_sendmsg+0x147/0x5e0 net/ipv4/af_inet.c:802
  sock_sendmsg_nosec net/socket.c:651 [inline]
  sock_sendmsg+0xdd/0x130 net/socket.c:661
  ___sys_sendmsg+0x3e2/0x930 net/socket.c:2260
  __sys_sendmmsg+0x1bf/0x4d0 net/socket.c:2355
  __do_sys_sendmmsg net/socket.c:2384 [inline]
  __se_sys_sendmmsg net/socket.c:2381 [inline]
  __x64_sys_sendmmsg+0x9d/0x100 net/socket.c:2381
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458209
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1154031c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000458209
RDX: 04000000000001a8 RSI: 0000000020007fc0 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f11540326d4
R13: 00000000004c5190 R14: 00000000004d92e0 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
