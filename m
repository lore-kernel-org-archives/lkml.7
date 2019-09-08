Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17A1C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 07:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C9321479
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 07:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfIHHTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 03:19:08 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:45685 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfIHHTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 03:19:08 -0400
Received: by mail-io1-f70.google.com with SMTP id k4so13634631iok.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 00:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=kz0vhgRFYmThzN5JafOjW4aOMyhmABAepE/cD0jdxIQ=;
        b=khpXks7gyYYZy7VRUchqaXECSC2fM6iVD/hcmZNy/wpUCUXDvbNKllAIduXXYZumWL
         5tyhCKlZHPA2tMruGSP8ExEzqC00XJtnh9wKcsOmvBpJyQ8HipMU6hhElzT15lCJbW3Q
         W28qk5yEJLDEtaXg9VLZrYbVyZZ8J5wvAuplTyejVeV1bdxXEWYz28nnUrw/BAXumME/
         DE0xHZxGc6m4zPESp8ogXUpxUOTPckMCmPq2ahDOgnXoa+KM3iiktiClJifjAJBEQjVa
         DlYAURKdPeVwSfftCiMRGn/R/Ew/fS6BKOc5+tmjHpqF0JOFuPLe50IrylNYuP8DVj6P
         Bxxw==
X-Gm-Message-State: APjAAAXb73xmemNjdFh+QSoFPlQiB7EN7qgqW+K4I1rVQYsWKMpfIIPW
        wPkSFpBXLINjRw/xntMioCjhsqvzX5WzvosVd2K8DjOYF00A
X-Google-Smtp-Source: APXvYqzHtxztR8QiqTs1lIO91ApAAiJKG3FXkcWh0zrBCr6vV5ZtHOqspFlvf44O90NGyJcVaaDe6CiAlr6iQK4I0fp0xQIJ2jUs
MIME-Version: 1.0
X-Received: by 2002:a02:ccb3:: with SMTP id t19mr19421402jap.13.1567927147005;
 Sun, 08 Sep 2019 00:19:07 -0700 (PDT)
Date:   Sun, 08 Sep 2019 00:19:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a193cd0592057cc8@google.com>
Subject: BUG: soft lockup in rt6_probe_deferred
From:   syzbot <syzbot+73944791f9cee53358f6@syzkaller.appspotmail.com>
To:     aarcange@redhat.com, akpm@linux-foundation.org,
        arunks@codeaurora.org, christian@brauner.io,
        elena.reshetova@intel.com, guro@fb.com, joel@joelfernandes.org,
        keescook@chromium.org, ldv@altlinux.org,
        linux-kernel@vger.kernel.org, luto@amacapital.net, mhocko@suse.com,
        mingo@kernel.org, namit@vmware.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        wad@chromium.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3b47fd5c Merge tag 'nfs-for-5.3-4' of git://git.linux-nfs...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=128438d1600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b89bb446a3faaba4
dashboard link: https://syzkaller.appspot.com/bug?extid=73944791f9cee53358f6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+73944791f9cee53358f6@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 123s! [kworker/0:5:10035]
Modules linked in:
irq event stamp: 0
hardirqs last  enabled at (0): [<0000000000000000>] 0x0
hardirqs last disabled at (0): [<ffffffff81436da5>]  
copy_process+0x1815/0x6b00 kernel/fork.c:1960
softirqs last  enabled at (0): [<ffffffff81436e4c>]  
copy_process+0x18bc/0x6b00 kernel/fork.c:1963
softirqs last disabled at (0): [<0000000000000000>] 0x0
CPU: 0 PID: 10035 Comm: kworker/0:5 Not tainted 5.3.0-rc7+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events rt6_probe_deferred
RIP: 0010:cpu_relax arch/x86/include/asm/processor.h:656 [inline]
RIP: 0010:virt_spin_lock arch/x86/include/asm/qspinlock.h:84 [inline]
RIP: 0010:native_queued_spin_lock_slowpath+0x132/0x9f0  
kernel/locking/qspinlock.c:325
Code: 00 00 00 48 8b 45 d0 65 48 33 04 25 28 00 00 00 0f 85 37 07 00 00 48  
81 c4 98 00 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d c3 f3 90 <e9> 73 ff ff ff  
8b 45 98 4c 8d 65 d8 3d 00 01 00 00 0f 84 e5 00 00
RSP: 0018:ffff88805f6e6d90 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000000 RBX: ffff88808bb57328 RCX: ffffffff81595c37
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88808bb57328
RBP: ffff88805f6e6e50 R08: 1ffff1101176ae65 R09: ffffed101176ae66
R10: ffffed101176ae65 R11: ffff88808bb5732b R12: 0000000000000001
R13: 0000000000000003 R14: ffffed101176ae65 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6c537e8000 CR3: 000000009a0c6000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:654 [inline]
  queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:50 [inline]
  queued_spin_lock include/asm-generic/qspinlock.h:81 [inline]
  do_raw_spin_lock+0x20e/0x2e0 kernel/locking/spinlock_debug.c:113
  __raw_spin_lock include/linux/spinlock_api_smp.h:143 [inline]
  _raw_spin_lock+0x37/0x40 kernel/locking/spinlock.c:151
  spin_lock include/linux/spinlock.h:338 [inline]
  __dev_xmit_skb net/core/dev.c:3502 [inline]
  __dev_queue_xmit+0x14b8/0x3650 net/core/dev.c:3838
  dev_queue_xmit+0x18/0x20 net/core/dev.c:3902
  br_dev_queue_push_xmit+0x3f3/0x5c0 net/bridge/br_forward.c:52
  NF_HOOK include/linux/netfilter.h:305 [inline]
  NF_HOOK include/linux/netfilter.h:299 [inline]
  br_forward_finish+0xfa/0x400 net/bridge/br_forward.c:65
  NF_HOOK include/linux/netfilter.h:305 [inline]
  NF_HOOK include/linux/netfilter.h:299 [inline]
  __br_forward+0x641/0xb00 net/bridge/br_forward.c:109
  deliver_clone+0x61/0xc0 net/bridge/br_forward.c:125
  maybe_deliver+0x2c7/0x390 net/bridge/br_forward.c:181
  br_flood+0x13a/0x3d0 net/bridge/br_forward.c:223
  br_dev_xmit+0x98c/0x15a0 net/bridge/br_device.c:100
  __netdev_start_xmit include/linux/netdevice.h:4406 [inline]
  netdev_start_xmit include/linux/netdevice.h:4420 [inline]
  xmit_one net/core/dev.c:3280 [inline]
  dev_hard_start_xmit+0x1a3/0x9c0 net/core/dev.c:3296
  __dev_queue_xmit+0x2b15/0x3650 net/core/dev.c:3869
  dev_queue_xmit+0x18/0x20 net/core/dev.c:3902
  neigh_hh_output include/net/neighbour.h:500 [inline]
  neigh_output include/net/neighbour.h:509 [inline]
  ip6_finish_output2+0xf58/0x2520 net/ipv6/ip6_output.c:116
  __ip6_finish_output+0x444/0xa50 net/ipv6/ip6_output.c:142
  ip6_finish_output+0x38/0x1f0 net/ipv6/ip6_output.c:152
  NF_HOOK_COND include/linux/netfilter.h:294 [inline]
  ip6_output+0x235/0x7c0 net/ipv6/ip6_output.c:175
  dst_output include/net/dst.h:436 [inline]
  NF_HOOK include/linux/netfilter.h:305 [inline]
  ndisc_send_skb+0xf29/0x1450 net/ipv6/ndisc.c:504
  ndisc_send_ns+0x3a9/0x850 net/ipv6/ndisc.c:646
  rt6_probe_deferred+0xe3/0x1a0 net/ipv6/route.c:615
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 0 to CPUs 1:
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.530  
msecs
NMI backtrace for cpu 1
CPU: 1 PID: 10038 Comm: kworker/1:3 Not tainted 5.3.0-rc7+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events rt6_probe_deferred
RIP: 0010:__list_del_entry_valid+0x74/0xf5 lib/list_debug.c:51
Code: 00 48 b8 00 01 00 00 00 00 ad de 4d 8b 2e 49 39 c5 0f 84 e1 00 00 00  
48 b8 22 01 00 00 00 00 ad de 49 39 c4 0f 84 e2 00 00 00 <48> b8 00 00 00  
00 00 fc ff df 4c 89 e2 48 c1 ea 03 80 3c 02 00 75
RSP: 0018:ffff8880ae908b20 EFLAGS: 00000212
RAX: dead000000000122 RBX: ffff88808bb57538 RCX: ffffffff85c64b39
RDX: 1ffff1101176aea7 RSI: ffffffff85c65006 RDI: ffff88808bb57540
RBP: ffff8880ae908b38 R08: ffff88805c72e500 R09: 0000000000000000
R10: fffffbfff134af8f R11: ffff88805c72e500 R12: ffff88808bb575d0
R13: ffff88808bb575d0 R14: ffff88808bb57538 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6c537e8000 CR3: 000000009a0c6000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  __list_del_entry include/linux/list.h:131 [inline]
  list_move_tail include/linux/list.h:213 [inline]
  hhf_dequeue+0x5c5/0xa20 net/sched/sch_hhf.c:439
  dequeue_skb net/sched/sch_generic.c:258 [inline]
  qdisc_restart net/sched/sch_generic.c:361 [inline]
  __qdisc_run+0x1e7/0x19d0 net/sched/sch_generic.c:379
  __dev_xmit_skb net/core/dev.c:3533 [inline]
  __dev_queue_xmit+0x16f1/0x3650 net/core/dev.c:3838
  dev_queue_xmit+0x18/0x20 net/core/dev.c:3902
  br_dev_queue_push_xmit+0x3f3/0x5c0 net/bridge/br_forward.c:52
  br_nf_dev_queue_xmit+0x34e/0x1470 net/bridge/br_netfilter_hooks.c:796
  NF_HOOK include/linux/netfilter.h:305 [inline]
  NF_HOOK include/linux/netfilter.h:299 [inline]
  br_nf_post_routing+0x1502/0x1d30 net/bridge/br_netfilter_hooks.c:844
  nf_hook_entry_hookfn include/linux/netfilter.h:135 [inline]
  nf_hook_slow+0xbc/0x1e0 net/netfilter/core.c:512
  nf_hook include/linux/netfilter.h:260 [inline]
  NF_HOOK include/linux/netfilter.h:303 [inline]
  br_forward_finish+0x215/0x400 net/bridge/br_forward.c:65
  br_nf_hook_thresh+0x2e9/0x370 net/bridge/br_netfilter_hooks.c:1015
  br_nf_forward_finish+0x66c/0xa90 net/bridge/br_netfilter_hooks.c:560
  NF_HOOK include/linux/netfilter.h:305 [inline]
  NF_HOOK include/linux/netfilter.h:299 [inline]
  br_nf_forward_ip net/bridge/br_netfilter_hooks.c:630 [inline]
  br_nf_forward_ip+0xc74/0x21e0 net/bridge/br_netfilter_hooks.c:571
  nf_hook_entry_hookfn include/linux/netfilter.h:135 [inline]
  nf_hook_slow+0xbc/0x1e0 net/netfilter/core.c:512
  nf_hook include/linux/netfilter.h:260 [inline]
  NF_HOOK include/linux/netfilter.h:303 [inline]
  __br_forward+0x393/0xb00 net/bridge/br_forward.c:109
  deliver_clone+0x61/0xc0 net/bridge/br_forward.c:125
  br_flood+0x325/0x3d0 net/bridge/br_forward.c:232
  br_handle_frame_finish+0xb46/0x1670 net/bridge/br_input.c:162
  br_nf_hook_thresh+0x2e9/0x370 net/bridge/br_netfilter_hooks.c:1015
  br_nf_pre_routing_finish_ipv6+0x6fb/0xd80  
net/bridge/br_netfilter_ipv6.c:206
  NF_HOOK include/linux/netfilter.h:305 [inline]
  br_nf_pre_routing_ipv6+0x456/0x832 net/bridge/br_netfilter_ipv6.c:236
  br_nf_pre_routing+0x1743/0x2355 net/bridge/br_netfilter_hooks.c:501
  nf_hook_entry_hookfn include/linux/netfilter.h:135 [inline]
  nf_hook_bridge_pre net/bridge/br_input.c:223 [inline]
  br_handle_frame+0x806/0x133e net/bridge/br_input.c:348
  __netif_receive_skb_core+0xfc1/0x3060 net/core/dev.c:4905
  __netif_receive_skb_one_core+0xa8/0x1a0 net/core/dev.c:5002
  __netif_receive_skb+0x2c/0x1d0 net/core/dev.c:5118
  process_backlog+0x206/0x750 net/core/dev.c:5929
  napi_poll net/core/dev.c:6352 [inline]
  net_rx_action+0x4d6/0x1030 net/core/dev.c:6418
  __do_softirq+0x262/0x98c kernel/softirq.c:292
  do_softirq_own_stack+0x2a/0x40 arch/x86/entry/entry_64.S:1082
  </IRQ>
  do_softirq.part.0+0x11a/0x170 kernel/softirq.c:337
  do_softirq kernel/softirq.c:329 [inline]
  __local_bh_enable_ip+0x211/0x270 kernel/softirq.c:189
  local_bh_enable include/linux/bottom_half.h:32 [inline]
  rcu_read_unlock_bh include/linux/rcupdate.h:681 [inline]
  ip6_finish_output2+0x10a0/0x2520 net/ipv6/ip6_output.c:117
  __ip6_finish_output+0x444/0xa50 net/ipv6/ip6_output.c:142
  ip6_finish_output+0x38/0x1f0 net/ipv6/ip6_output.c:152
  NF_HOOK_COND include/linux/netfilter.h:294 [inline]
  ip6_output+0x235/0x7c0 net/ipv6/ip6_output.c:175
  dst_output include/net/dst.h:436 [inline]
  NF_HOOK include/linux/netfilter.h:305 [inline]
  ndisc_send_skb+0xf29/0x1450 net/ipv6/ndisc.c:504
  ndisc_send_ns+0x3a9/0x850 net/ipv6/ndisc.c:646
  rt6_probe_deferred+0xe3/0x1a0 net/ipv6/route.c:615
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
