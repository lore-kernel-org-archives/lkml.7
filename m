Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56899C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 07:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B69A21479
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 07:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfIHHSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 03:18:08 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:34763 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfIHHSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 03:18:08 -0400
Received: by mail-io1-f72.google.com with SMTP id m25so13766117ioo.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 00:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=BY/6N+3P9nCLLqZoNfOKAmS2V1uSSwGKatQPDkE+Bl0=;
        b=i8+RgINHJ3PsIXHKvpMDe9fo91DMWpnZswfVIjuvcituihTMHNp6qm1auUaqmAyNYX
         jiY6kMiX38t+ELs2HR2g6o7elKO64QFCwd/hGJ6MS+TDhCk7mRd/bzBtw0bTw5mKjbya
         yt9g77YjKxkf/34mN2hgcZInX1Fy5ugjs8nqVcT3TXKUtSBHxfw9H8GRjDxKGeToXK7y
         cE/DcitOevyLzYykvfQ6PlvA6/eFA4URaAwzdeRIsHMuA/VF6rag0PTO1UVniMyjDjvO
         ZA6O54WvBctO+LQXiSz73/IMjfXXS1R01VseopboZHgvNZNO8vPoLnDeADmSH+USU/Od
         u8dg==
X-Gm-Message-State: APjAAAXVyfVafNv/IcMkz7aEiWIrxIIHJ6oRTSb3g0uiOaSC8u/uTceK
        B7++4WpWsAn3iseEQGJdBZgudcqy8lINz2BL+hx0vla2ZWnN
X-Google-Smtp-Source: APXvYqzu6ffe/Ewm+HWCFDrUquUif4lqPtYkOgFiBYyiD0fWaBUeWlH++5d16LOuezFob42NvSX2+JrPnjnF1K4qFrIle/O+Rooz
MIME-Version: 1.0
X-Received: by 2002:a02:712b:: with SMTP id n43mr19055750jac.2.1567927086765;
 Sun, 08 Sep 2019 00:18:06 -0700 (PDT)
Date:   Sun, 08 Sep 2019 00:18:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a60d50592057952@google.com>
Subject: BUG: soft lockup in addrconf_rs_timer
From:   syzbot <syzbot+efa0ea0bc593cef594e1@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=15cb1ac1600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b89bb446a3faaba4
dashboard link: https://syzkaller.appspot.com/bug?extid=efa0ea0bc593cef594e1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+efa0ea0bc593cef594e1@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 122s! [syz-executor.0:11808]
Modules linked in:
irq event stamp: 0
hardirqs last  enabled at (0): [<0000000000000000>] 0x0
hardirqs last disabled at (0): [<ffffffff81436da5>]  
copy_process+0x1815/0x6b00 kernel/fork.c:1960
softirqs last  enabled at (0): [<ffffffff81436e4c>]  
copy_process+0x18bc/0x6b00 kernel/fork.c:1963
softirqs last disabled at (0): [<0000000000000000>] 0x0
CPU: 0 PID: 11808 Comm: syz-executor.0 Not tainted 5.3.0-rc7+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:cpu_relax arch/x86/include/asm/processor.h:656 [inline]
RIP: 0010:virt_spin_lock arch/x86/include/asm/qspinlock.h:84 [inline]
RIP: 0010:native_queued_spin_lock_slowpath+0x132/0x9f0  
kernel/locking/qspinlock.c:325
Code: 00 00 00 48 8b 45 d0 65 48 33 04 25 28 00 00 00 0f 85 37 07 00 00 48  
81 c4 98 00 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d c3 f3 90 <e9> 73 ff ff ff  
8b 45 98 4c 8d 65 d8 3d 00 01 00 00 0f 84 e5 00 00
RSP: 0018:ffff8880ae808d50 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000000 RBX: ffff8880a5d872e8 RCX: ffffffff81595c37
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8880a5d872e8
RBP: ffff8880ae808e10 R08: 1ffff11014bb0e5d R09: ffffed1014bb0e5e
R10: ffffed1014bb0e5d R11: ffff8880a5d872eb R12: 0000000000000001
R13: 0000000000000003 R14: ffffed1014bb0e5d R15: 0000000000000001
FS:  00007fb99bba9700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001404240 CR3: 00000000902a5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
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
  neigh_resolve_output net/core/neighbour.c:1490 [inline]
  neigh_resolve_output+0x5a5/0x970 net/core/neighbour.c:1470
  neigh_output include/net/neighbour.h:511 [inline]
  ip6_finish_output2+0x1034/0x2520 net/ipv6/ip6_output.c:116
  __ip6_finish_output+0x444/0xa50 net/ipv6/ip6_output.c:142
  ip6_finish_output+0x38/0x1f0 net/ipv6/ip6_output.c:152
  NF_HOOK_COND include/linux/netfilter.h:294 [inline]
  ip6_output+0x235/0x7c0 net/ipv6/ip6_output.c:175
  dst_output include/net/dst.h:436 [inline]
  NF_HOOK include/linux/netfilter.h:305 [inline]
  ndisc_send_skb+0xf29/0x1450 net/ipv6/ndisc.c:504
  ndisc_send_rs+0x134/0x6d0 net/ipv6/ndisc.c:698
  addrconf_rs_timer+0x30f/0x680 net/ipv6/addrconf.c:3879
  call_timer_fn+0x1ac/0x780 kernel/time/timer.c:1322
  expire_timers kernel/time/timer.c:1366 [inline]
  __run_timers kernel/time/timer.c:1685 [inline]
  __run_timers kernel/time/timer.c:1653 [inline]
  run_timer_softirq+0x697/0x17a0 kernel/time/timer.c:1698
  __do_softirq+0x262/0x98c kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x19b/0x1e0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:537 [inline]
  smp_apic_timer_interrupt+0x1a3/0x610 arch/x86/kernel/apic/apic.c:1133
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
  </IRQ>
RIP: 0010:check_memory_region_inline mm/kasan/generic.c:173 [inline]
RIP: 0010:check_memory_region+0x0/0x1a0 mm/kasan/generic.c:192
Code: 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 f2 be f8 00 00 00 48 89 e5 e8  
af ac 8f 05 5d c3 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 <48> 85 f6 0f 84  
34 01 00 00 48 b8 ff ff ff ff ff 7f ff ff 55 0f b6
RSP: 0018:ffff8880504ff2f0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: ffff88812fffc000 RBX: 0000000000000a39 RCX: ffffffff81a437c6
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88812fffc620
RBP: ffff8880504ff2f8 R08: 1ffff11025fff8b8 R09: 0000000000000a39
R10: ffffed1025fff8b8 R11: ffff88812fffc5c7 R12: 0000000000000044
R13: 0000000000000002 R14: ffff88812fffc620 R15: 0000000000002c00
  atomic64_read include/asm-generic/atomic-instrumented.h:836 [inline]
  atomic_long_read include/asm-generic/atomic-long.h:28 [inline]
  zone_page_state include/linux/vmstat.h:200 [inline]
  zone_watermark_fast mm/page_alloc.c:3481 [inline]
  get_page_from_freelist+0xfe6/0x39d0 mm/page_alloc.c:3635
  __alloc_pages_nodemask+0x2d0/0x900 mm/page_alloc.c:4714
  alloc_pages_current+0x107/0x210 mm/mempolicy.c:2153
  alloc_pages include/linux/gfp.h:509 [inline]
  __vmalloc_area_node mm/vmalloc.c:2424 [inline]
  __vmalloc_node_range+0x4a9/0x7d0 mm/vmalloc.c:2488
  vmalloc_user+0x6b/0x90 mm/vmalloc.c:2618
  vb2_vmalloc_alloc+0xca/0x280  
drivers/media/common/videobuf2/videobuf2-vmalloc.c:48
  __vb2_buf_mem_alloc drivers/media/common/videobuf2/videobuf2-core.c:215  
[inline]
  __vb2_queue_alloc+0x55b/0xf30  
drivers/media/common/videobuf2/videobuf2-core.c:370
  vb2_core_create_bufs+0x2b9/0x830  
drivers/media/common/videobuf2/videobuf2-core.c:849
  vb2_create_bufs+0x479/0x7a0  
drivers/media/common/videobuf2/videobuf2-v4l2.c:742
  v4l2_m2m_create_bufs+0x7c/0xe0 drivers/media/v4l2-core/v4l2-mem2mem.c:537
  v4l2_m2m_ioctl_create_bufs+0x6b/0x80  
drivers/media/v4l2-core/v4l2-mem2mem.c:1054
  v4l_create_bufs drivers/media/v4l2-core/v4l2-ioctl.c:1981 [inline]
  v4l_create_bufs+0xbb/0x170 drivers/media/v4l2-core/v4l2-ioctl.c:1968
  __video_do_ioctl+0xb4b/0xd40 drivers/media/v4l2-core/v4l2-ioctl.c:2878
  video_usercopy+0x4c2/0x1130 drivers/media/v4l2-core/v4l2-ioctl.c:3060
  video_ioctl2+0x2d/0x35 drivers/media/v4l2-core/v4l2-ioctl.c:3104
  v4l2_ioctl+0x1ac/0x230 drivers/media/v4l2-core/v4l2-dev.c:360
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xdb6/0x13e0 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459879
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb99bba8c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459879
RDX: 00000000200003c0 RSI: 00000000c100565c RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb99bba96d4
R13: 00000000004c49bf R14: 00000000004d8d28 R15: 00000000ffffffff
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.3.0-rc7+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__list_add_valid+0x2b/0xa0 lib/list_debug.c:23
Code: b8 00 00 00 00 00 fc ff df 55 48 89 e5 41 55 49 89 fd 48 8d 7a 08 41  
54 49 89 d4 48 89 fa 48 83 ec 08 48 c1 ea 03 80 3c 02 00 <75> 52 49 8b 54  
24 08 48 39 f2 0f 85 5a 01 00 00 48 b8 00 00 00 00
RSP: 0018:ffff8880ae9094f0 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: ffff8880a5d874f8 RCX: ffffffff85c65051
RDX: 1ffff11014bb0eb3 RSI: ffff8880a5d87590 RDI: ffff8880a5d87598
RBP: ffff8880ae909508 R08: ffff8880a98d6340 R09: 0000000000000000
R10: fffffbfff134af8f R11: ffff8880a98d6340 R12: ffff8880a5d87590
R13: ffff8880a5d874f8 R14: ffff8880a5d87598 R15: ffff8880a5d87590
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555562b5978 CR3: 0000000098025000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  __list_add include/linux/list.h:60 [inline]
  list_add_tail include/linux/list.h:93 [inline]
  list_move_tail include/linux/list.h:214 [inline]
  hhf_dequeue+0x66d/0xa20 net/sched/sch_hhf.c:439
  dequeue_skb net/sched/sch_generic.c:258 [inline]
  qdisc_restart net/sched/sch_generic.c:361 [inline]
  __qdisc_run+0x1e7/0x19d0 net/sched/sch_generic.c:379
  __dev_xmit_skb net/core/dev.c:3533 [inline]
  __dev_queue_xmit+0x16f1/0x3650 net/core/dev.c:3838
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
  ndisc_send_rs+0x134/0x6d0 net/ipv6/ndisc.c:698
  addrconf_rs_timer+0x30f/0x680 net/ipv6/addrconf.c:3879
  call_timer_fn+0x1ac/0x780 kernel/time/timer.c:1322
  expire_timers kernel/time/timer.c:1366 [inline]
  __run_timers kernel/time/timer.c:1685 [inline]
  __run_timers kernel/time/timer.c:1653 [inline]
  run_timer_softirq+0x697/0x17a0 kernel/time/timer.c:1698
  __do_softirq+0x262/0x98c kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x19b/0x1e0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:537 [inline]
  smp_apic_timer_interrupt+0x1a3/0x610 arch/x86/kernel/apic/apic.c:1133
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
  </IRQ>
RIP: 0010:native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:61
Code: 98 83 6e fa eb 8a 90 90 90 90 90 90 e9 07 00 00 00 0f 00 2d 24 2b 4a  
00 f4 c3 66 90 e9 07 00 00 00 0f 00 2d 14 2b 4a 00 fb f4 <c3> 90 55 48 89  
e5 41 57 41 56 41 55 41 54 53 e8 4e 43 22 fa e8 f9
RSP: 0018:ffff8880a98e7d68 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff11a5e8d RBX: ffff8880a98d6340 RCX: 1ffffffff134b5ce
RDX: dffffc0000000000 RSI: ffffffff8177f1ae RDI: ffffffff873df50c
RBP: ffff8880a98e7d98 R08: ffff8880a98d6340 R09: ffffed101531ac69
R10: ffffed101531ac68 R11: ffff8880a98d6347 R12: dffffc0000000000
R13: ffffffff89a57c78 R14: 0000000000000000 R15: 0000000000000001
  arch_cpu_idle+0xa/0x10 arch/x86/kernel/process.c:571
  default_idle_call+0x84/0xb0 kernel/sched/idle.c:94
  cpuidle_idle_call kernel/sched/idle.c:154 [inline]
  do_idle+0x413/0x760 kernel/sched/idle.c:263
  cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:354
  start_secondary+0x315/0x430 arch/x86/kernel/smpboot.c:264
  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
