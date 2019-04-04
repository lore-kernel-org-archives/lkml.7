Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDA0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFA120855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfDDIsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:48:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbfDDIsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:48:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A10C2D80F;
        Thu,  4 Apr 2019 08:48:06 +0000 (UTC)
Received: from carbon (ovpn-200-46.brq.redhat.com [10.40.200.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C196C62669;
        Thu,  4 Apr 2019 08:47:57 +0000 (UTC)
Date:   Thu, 4 Apr 2019 10:47:56 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+457d3e2ffbcf31aee5c0@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        brouer@redhat.com, John Fastabend <john.fastabend@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: KASAN: use-after-free Read in __dev_map_entry_free
Message-ID: <20190404104756.6b591ad6@carbon>
In-Reply-To: <CAADnVQKbZgXDvbwSREYYGTeTX42oD-Q4UrKRjowTVsdktu4t4w@mail.gmail.com>
References: <0000000000009cd09a056f1451d1@google.com>
        <cc82200a-6374-0a87-a3e0-471d04a8306a@gmail.com>
        <CAADnVQKbZgXDvbwSREYYGTeTX42oD-Q4UrKRjowTVsdktu4t4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 04 Apr 2019 08:48:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2019 20:59:24 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Tue, Apr 2, 2019 at 1:03 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> >
> >
> >
> > On 06/20/2018 08:19 AM, syzbot wrote:  
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    f0dc7f9c6dd9 Merge git://git.kernel.org/pub/scm/linux/kern..
> > > git tree:       bpf-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=15ad7d10400000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9c20c48788d1c1
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=457d3e2ffbcf31aee5c0
> > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1195225f800000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171a7ce4400000
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+457d3e2ffbcf31aee5c0@syzkaller.appspotmail.com
> > >
> > > ==================================================================
> > > BUG: KASAN: use-after-free in dev_map_flush_old kernel/bpf/devmap.c:365 [inline]
> > > BUG: KASAN: use-after-free in __dev_map_entry_free+0x2a8/0x300 kernel/bpf/devmap.c:379
> > > Read of size 8 at addr ffff8801b8da38c8 by task ksoftirqd/1/18
> > >
> > > CPU: 1 PID: 18 Comm: ksoftirqd/1 Not tainted 4.17.0+ #39
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > Call Trace:
> > >  __dump_stack lib/dump_stack.c:77 [inline]
> > >  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
> > >  print_address_description+0x6c/0x20b mm/kasan/report.c:256
> > >  kasan_report_error mm/kasan/report.c:354 [inline]
> > >  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
> > >  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
> > >  dev_map_flush_old kernel/bpf/devmap.c:365 [inline]
> > >  __dev_map_entry_free+0x2a8/0x300 kernel/bpf/devmap.c:379
> > >  __rcu_reclaim kernel/rcu/rcu.h:178 [inline]
> > >  rcu_do_batch kernel/rcu/tree.c:2558 [inline]
> > >  invoke_rcu_callbacks kernel/rcu/tree.c:2818 [inline]
> > >  __rcu_process_callbacks kernel/rcu/tree.c:2785 [inline]
> > >  rcu_process_callbacks+0xe9d/0x1760 kernel/rcu/tree.c:2802
> > >  __do_softirq+0x2e0/0xaf5 kernel/softirq.c:284
> > >  run_ksoftirqd+0x86/0x100 kernel/softirq.c:645
> > >  smpboot_thread_fn+0x417/0x870 kernel/smpboot.c:164
> > >  kthread+0x345/0x410 kernel/kthread.c:240
> > >  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
> > >
> > > Allocated by task 6675:
> > >  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
> > >  set_track mm/kasan/kasan.c:460 [inline]
> > >  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
> > >  kmem_cache_alloc_trace+0x152/0x780 mm/slab.c:3620
> > >  kmalloc include/linux/slab.h:513 [inline]
> > >  kzalloc include/linux/slab.h:706 [inline]
> > >  dev_map_alloc+0x208/0x7f0 kernel/bpf/devmap.c:102
> > >  find_and_alloc_map kernel/bpf/syscall.c:129 [inline]
> > >  map_create+0x393/0x1010 kernel/bpf/syscall.c:453
> > >  __do_sys_bpf kernel/bpf/syscall.c:2351 [inline]
> > >  __se_sys_bpf kernel/bpf/syscall.c:2328 [inline]
> > >  __x64_sys_bpf+0x303/0x510 kernel/bpf/syscall.c:2328
> > >  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:290
> > >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > >
> > > Freed by task 26:
> > >  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
> > >  set_track mm/kasan/kasan.c:460 [inline]
> > >  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
> > >  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
> > >  __cache_free mm/slab.c:3498 [inline]
> > >  kfree+0xd9/0x260 mm/slab.c:3813
> > >  dev_map_free+0x4fa/0x670 kernel/bpf/devmap.c:191
> > >  bpf_map_free_deferred+0xba/0xf0 kernel/bpf/syscall.c:262
> > >  process_one_work+0xc64/0x1b70 kernel/workqueue.c:2153
> > >  worker_thread+0x181/0x13a0 kernel/workqueue.c:2296
> > >  kthread+0x345/0x410 kernel/kthread.c:240
> > >  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
> > >
> > > The buggy address belongs to the object at ffff8801b8da37c0
> > >  which belongs to the cache kmalloc-512 of size 512
> > > The buggy address is located 264 bytes inside of
> > >  512-byte region [ffff8801b8da37c0, ffff8801b8da39c0)
> > > The buggy address belongs to the page:
> > > page:ffffea0006e368c0 count:1 mapcount:0 mapping:ffff8801da800940 index:0xffff8801b8da3540
> > > flags: 0x2fffc0000000100(slab)
> > > raw: 02fffc0000000100 ffffea0007217b88 ffffea0006e30cc8 ffff8801da800940
> > > raw: ffff8801b8da3540 ffff8801b8da3040 0000000100000004 0000000000000000
> > > page dumped because: kasan: bad access detected
> > >
> > > Memory state around the buggy address:
> > >  ffff8801b8da3780: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
> > >  ffff8801b8da3800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb  
> > >> ffff8801b8da3880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb  
> > >                                               ^
> > >  ffff8801b8da3900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >  ffff8801b8da3980: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> > > ==================================================================
> > >
> > >
> > > ---
> > > This bug is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this bug report. See:
> > > https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
> > > syzbot can test patches for this bug, for details see:
> > > https://goo.gl/tpsmEJ#testing-patches  
> >
> >
> > What about something like :
> >
> >
> >
> > diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> > index 191b79948424f4b21b7aa120abc03801264bf0a6..1e525d70f83354e451b738ffb8e42d83b5fa932f 100644
> > --- a/kernel/bpf/devmap.c
> > +++ b/kernel/bpf/devmap.c
> > @@ -164,6 +164,9 @@ static void dev_map_free(struct bpf_map *map)
> >         bpf_clear_redirect_map(map);
> >         synchronize_rcu();
> >
> > +       /* Make sure prior __dev_map_entry_free() have completed. */
> > +       rcu_barrier();
> > +  
> 
> Eric, Thank you for looking at it. The fix makes sense to me.
> 
> Jesper, thoughts?

First I though it looked strange to have a synchronize_rcu() followed
by a rcu_barrier().  But I think the fix is actually correct.  We do
need the rcu_barrier() call as it states "Wait until all in-flight
call_rcu() callbacks complete".   I wonder if we also/still need the
synchronize_rcu(), but I think so as it functions as a memory-barrier
across all CPUs (as in bpf_clear_redirect_map we visit all CPUs and
clear any left-over per_cpu_ptr redirect_info).

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
