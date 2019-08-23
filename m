Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33F3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 11:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7843D21848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 11:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393230AbfHWLqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 07:46:24 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57060 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfHWLqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 07:46:23 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7NBk8pL043373;
        Fri, 23 Aug 2019 20:46:08 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Fri, 23 Aug 2019 20:46:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x7NBk7hl043365
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 23 Aug 2019 20:46:08 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
References: <1566338811-4464-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAHk-=wjFsF6zmcDaBdpYEvCWiq=x7_NuQWEm=OinZ9TuQd4ZZQ@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <5b4e0535-3b29-5165-4568-85fe75cf6736@i-love.sakura.ne.jp>
Date:   Fri, 23 Aug 2019 20:46:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjFsF6zmcDaBdpYEvCWiq=x7_NuQWEm=OinZ9TuQd4ZZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/08/23 7:08, Linus Torvalds wrote:
>> syzbot found that a thread can stall for minutes inside read_mem()
>> after that thread was killed by SIGKILL [1]. Reading 2GB at one read()
>> is legal, but delaying termination of killed thread for minutes is bad.
> 
> Side note: we might even just allow regular signals to interrupt
> /dev/mem reads. We already do that for /dev/zero, and the risk of
> breaking something is likely fairly low since nothing should use that
> thing anyway.
> 
> Also, if it takes minutes to delay killing things, that implies that
> we're probably still faulting in pages for the read_mem(). Which
> points to another possible thing we could do in general: just don't
> bother to handle page faults when a fatal signal is pending.

The cause of stall (by the reproducer) is that read_mem() continues iteration
until copy_to_user() returns -EFAULT (the userspace is asking for 2GB without
allocating 2GB of buffer to receive the result). Also, since the reproducer
concurrently calls preadv() but iteration loop in read_mem() consumes 100% of
CPU time, termination of killed threads is delayed a lot.

Thus, I can confirm that adding cond_resched() and fatal_signal_pending(current)
check into the iteration significantly reduces termination delay.

[ 1414.479373][T82148] read_mem: sz=4096 count=1070538751
[ 1414.481476][T75184] read_mem: sz=4096 count=1064574975
[ 1414.483489][T75184] read_mem: sz=4096 count=1064570879
[ 1414.483495][T82148] read_mem: sz=4096 count=1070534655
[ 1414.485517][T74318] read_mem: sz=4096 count=1060986879
[ 1414.485520][T75184] read_mem: sz=4096 count=1064566783
[ 1414.487978][T75184] read_mem: sz=4096 count=1064562687
[ 1414.487982][T74318] read_mem: sz=4096 count=1060982783
[ 1414.490011][T75184] read_mem: sz=4096 count=1064558591
[ 1414.490015][T74318] read_mem: sz=4096 count=1060978687
[ 1414.492099][T82148] read_mem: sz=4096 count=1070530559
[ 1414.492101][T75184] read_mem: sz=4096 count=1064554495
[ 1414.492104][T74497] read_mem: sz=4096 count=1062944767
[ 1414.494100][T75184] read_mem: sz=4096 count=1064550399
[ 1414.494104][T82148] read_mem: sz=4096 count=1070526463
[ 1414.494107][T74497] read_mem: sz=4096 count=1062940671
[ 1414.496112][T82148] read_mem: sz=4096 count=1070522367
[ 1414.496116][T74497] read_mem: sz=4096 count=1062936575
[ 1414.496119][T75184] read_mem: sz=4096 count=1064546303
[ 1414.498157][T75184] read_mem: sz=4096 count=1064542207
[ 1414.498169][T74497] read_mem: sz=4096 count=1062932479
[ 1414.498276][   T33] INFO: task a.out:74318 can't die for more than 30 seconds.
[ 1414.498278][   T33] a.out           R  running task    13688 74318 112832 0x80004084
[ 1414.498284][   T33] Call Trace:
[ 1414.498292][   T33]  ? __schedule+0x253/0x700
[ 1414.498296][   T33]  preempt_schedule_common+0x1b/0x3a
[ 1414.498298][   T33]  _cond_resched+0x18/0x20
[ 1414.498301][   T33]  kmem_cache_alloc_trace+0x274/0x320
[ 1414.498354][   T33]  ? reserve_memtype+0xd4/0x3e0
[ 1414.498359][   T33]  reserve_memtype+0xd4/0x3e0
[ 1414.498363][   T33]  ? memremap+0xa0/0x1a0
[ 1414.498365][   T33]  __ioremap_caller.isra.10+0xeb/0x2f0
[ 1414.498370][   T33]  memremap+0xa0/0x1a0
[ 1414.498373][   T33]  xlate_dev_mem_ptr+0x20/0x30
[ 1414.498403][   T33]  read_mem+0xf3/0x1f0
[ 1414.498409][   T33]  do_loop_readv_writev+0x47/0x160
[ 1414.498413][   T33]  do_iter_read+0xef/0x120
[ 1414.498417][   T33]  vfs_readv+0x68/0xa0
[ 1414.498423][   T33]  ? ktime_get_coarse_real_ts64+0x66/0xd0
[ 1414.498426][   T33]  ? lockdep_hardirqs_on+0x122/0x1b0
[ 1414.498429][   T33]  ? syscall_trace_enter+0x1f3/0x340
[ 1414.498431][   T33]  ? syscall_trace_enter+0x1f3/0x340
[ 1414.498433][   T33]  ? trace_hardirqs_on_thunk+0x1a/0x20
[ 1414.498436][   T33]  do_preadv+0x97/0xc0
[ 1414.498440][   T33]  do_syscall_64+0x55/0x260
[ 1414.498443][   T33]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1414.498445][   T33] RIP: 0033:0x7f63675c0349
[ 1414.498449][   T33] Code: Bad RIP value.
[ 1414.498450][   T33] RSP: 002b:00007ffd22952c18 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
[ 1414.498452][   T33] RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007f63675c0349
[ 1414.498453][   T33] RDX: 0000000000000002 RSI: 0000000020000740 RDI: 0000000000000003
[ 1414.498453][   T33] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[ 1414.498454][   T33] R10: 00000000febfffff R11: 0000000000000246 R12: 000000000014e1ab
[ 1414.498455][   T33] R13: 00007ffd22952d50 R14: 0000000000000000 R15: 0000000000000000
[ 1414.498463][   T33] INFO: task a.out:74497 can't die for more than 30 seconds.
[ 1414.498464][   T33] a.out           R  running task    13888 74497 112827 0x8000408c
[ 1414.498468][   T33] Call Trace:
[ 1414.498473][   T33]  ? __lock_acquire+0x24b/0x1090
[ 1414.498479][   T33]  ? vprintk_emit+0x19e/0x2e0
[ 1414.498484][   T33]  ? vprintk_emit+0x1d4/0x2e0
[ 1414.498485][   T33]  ? vprintk_emit+0x19e/0x2e0
[ 1414.498490][   T33]  ? printk+0x53/0x6a
[ 1414.498495][   T33]  ? read_mem+0x19a/0x1f0
[ 1414.498499][   T33]  ? do_loop_readv_writev+0x47/0x160
[ 1414.498503][   T33]  ? do_iter_read+0xef/0x120
[ 1414.498506][   T33]  ? vfs_readv+0x68/0xa0
[ 1414.498511][   T33]  ? ktime_get_coarse_real_ts64+0x66/0xd0
[ 1414.498512][   T33]  ? lockdep_hardirqs_on+0x122/0x1b0
[ 1414.498515][   T33]  ? syscall_trace_enter+0x1f3/0x340
[ 1414.498517][   T33]  ? syscall_trace_enter+0x1f3/0x340
[ 1414.498519][   T33]  ? trace_hardirqs_on_thunk+0x1a/0x20
[ 1414.498521][   T33]  ? do_preadv+0x97/0xc0
[ 1414.498525][   T33]  ? do_syscall_64+0x55/0x260
[ 1414.498527][   T33]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1414.498535][   T33] INFO: task a.out:74786 can't die for more than 30 seconds.
[ 1414.498535][   T33] a.out           R  running task    13688 74786 112831 0x80004084
[ 1414.498539][   T33] Call Trace:
[ 1414.498542][   T33]  ? __schedule+0x253/0x700
[ 1414.498546][   T33]  preempt_schedule_common+0x1b/0x3a
[ 1414.498548][   T33]  _cond_resched+0x18/0x20
[ 1414.498550][   T33]  kmem_cache_alloc_trace+0x274/0x320
[ 1414.498552][   T33]  ? reserve_memtype+0xd4/0x3e0
[ 1414.498555][   T33]  reserve_memtype+0xd4/0x3e0
[ 1414.498558][   T33]  ? memremap+0xa0/0x1a0
[ 1414.498561][   T33]  __ioremap_caller.isra.10+0xeb/0x2f0
[ 1414.498566][   T33]  memremap+0xa0/0x1a0
[ 1414.498568][   T33]  xlate_dev_mem_ptr+0x20/0x30
[ 1414.498570][   T33]  read_mem+0xf3/0x1f0
[ 1414.498574][   T33]  do_loop_readv_writev+0x47/0x160
[ 1414.498578][   T33]  do_iter_read+0xef/0x120
[ 1414.498581][   T33]  vfs_readv+0x68/0xa0
[ 1414.498586][   T33]  ? ktime_get_coarse_real_ts64+0x66/0xd0
[ 1414.498588][   T33]  ? lockdep_hardirqs_on+0x122/0x1b0
[ 1414.498590][   T33]  ? syscall_trace_enter+0x1f3/0x340
[ 1414.498592][   T33]  ? syscall_trace_enter+0x1f3/0x340
[ 1414.498594][   T33]  ? trace_hardirqs_on_thunk+0x1a/0x20
[ 1414.498596][   T33]  do_preadv+0x97/0xc0
[ 1414.498600][   T33]  do_syscall_64+0x55/0x260
[ 1414.498602][   T33]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1414.498603][   T33] RIP: 0033:0x7f63675c0349
[ 1414.498605][   T33] Code: Bad RIP value.
[ 1414.498606][   T33] RSP: 002b:00007ffd22952c18 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
[ 1414.498607][   T33] RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007f63675c0349
[ 1414.498608][   T33] RDX: 0000000000000002 RSI: 0000000020000740 RDI: 0000000000000003
[ 1414.498609][   T33] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[ 1414.498610][   T33] R10: 00000000febfffff R11: 0000000000000246 R12: 000000000014e74b
[ 1414.498610][   T33] R13: 00007ffd22952d50 R14: 0000000000000000 R15: 0000000000000000
[ 1414.498620][   T33] 
[ 1414.498620][   T33] Showing all locks held in the system:
[ 1414.498624][   T33] 1 lock held by khungtaskd/33:
[ 1414.498625][   T33]  #0: ffffffff96276b40 (rcu_read_lock){....}, at: debug_show_all_locks+0xe/0x1a0
[ 1414.498774][   T33] 2 locks held by agetty/2831:
[ 1414.498775][   T33]  #0: ffffa3a16cd84b18 (&tty->ldisc_sem){++++}, at: tty_ldisc_ref_wait+0x1f/0x50
[ 1414.498803][   T33]  #1: ffffb02b413592e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0xd3/0x930
[ 1414.498814][   T33] 2 locks held by bash/2859:
[ 1414.498814][   T33]  #0: ffffa3a16cd81338 (&tty->ldisc_sem){++++}, at: tty_ldisc_ref_wait+0x1f/0x50
[ 1414.498817][   T33]  #1: ffffb02b4135d2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0xd3/0x930
[ 1414.498823][   T33] 2 locks held by bash/2984:
[ 1414.498824][   T33]  #0: ffffa3a17453ddb8 (&tty->ldisc_sem){++++}, at: tty_ldisc_ref_wait+0x1f/0x50
[ 1414.498826][   T33]  #1: ffffb02b41fcd2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0xd3/0x930
[ 1414.498832][   T33] 2 locks held by agetty/4230:
[ 1414.498833][   T33]  #0: ffffa3a16cdf6708 (&tty->ldisc_sem){++++}, at: tty_ldisc_ref_wait+0x1f/0x50
[ 1414.498835][   T33]  #1: ffffb02b461ff2e0 (&ldata->atomic_read_lock){+.+.}, at: n_tty_read+0xd3/0x930
[ 1414.498843][   T33] 1 lock held by a.out/74497:
[ 1414.498848][   T33] 3 locks held by a.out/78162:
[ 1414.498852][   T33] 1 lock held by a.out/86204:
[ 1414.498856][   T33] 
[ 1414.498857][   T33] =============================================
[ 1414.498857][   T33] 
[ 1414.500709][T75184] read_mem: sz=4096 count=1064538111
[ 1414.505727][T75184] read_mem: sz=4096 count=1064534015
[ 1414.524668][T74318] read_mem: sz=4096 count=1060974591
[ 1414.526675][T74786] read_mem: sz=4096 count=1062191103
[ 1414.529343][T82148] read_mem: sz=4096 count=1070518271
[ 1414.529356][T78162] read_mem: sz=4096 count=1067028479
[ 1414.530675][T74318] read_mem: sz=4096 count=1060970495
[ 1414.532791][T74318] read_mem: sz=4096 count=1060966399
[ 1414.532806][T75184] read_mem: sz=4096 count=1064529919
[ 1414.534823][T75184] read_mem: sz=4096 count=1064525823

