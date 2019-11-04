Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCE5CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A6920848
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="leVdZVkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbfKDRJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:09:21 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39655 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbfKDRJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:09:21 -0500
Received: by mail-oi1-f194.google.com with SMTP id v138so14754498oif.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 09:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9hCDOD9jYdub8j8LO03N0Lz3rHBhX6pXfVge7y2+FRg=;
        b=leVdZVkBgGzcp9Xh8Fhz3It8o8fqRcRy3LXXTiGuFnekVMECsSjoGtuFRQmxqNIkDe
         7viDwj9jRv4EDOiFhkbYey1rtTvi02eOzyNthIjDYUZ7vGpi2PkYmeXUR5mQXmY2FQC8
         SJghVdy7YZIVmmtPh2EM+jrk+6X8MtDnZC9769smEAVhg49xat4YYjWXtdO1z44Gyrln
         5ob5P87gGZDnjwTcT7MIjz4e2dnCQQGmcP0ahPlxWvj1KQIA1uehYaVDJzE7rsN0kITA
         IWZppvbaaGNgewZde2okF2CYq7Ft8vVhNWXmDxQwOwwML3U9fd2Hw5jUvw7s5P2NvPJb
         dERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9hCDOD9jYdub8j8LO03N0Lz3rHBhX6pXfVge7y2+FRg=;
        b=uWFk0c2vGxInP10DA3OcCrmuIkQ0OrkJ4nMjWL1lnDz7bOlHh44sA3DOV9kIOp+3JB
         +lRJLXsS5z8AmqDkKPuXXQxAjXfnzrW0SARX4d9Qn/5/xMaoUJk1pK1PVjidvh6VVruX
         7NjiXmcySZ50P7nA3DObkZtlmjNtMZDkUJTMarp6thlK8VqXEcXMhqTjUsCbQPux7sPG
         Y8pj+QY3kMTtbYBwEvD9sHfZ+prFbPWowl7GKDxS+y5r3rzM2VJhGLBGdglUqiEh08fO
         zXH4gfQIHvJDqLVHqbS1w7QVSbEcmc4qWsURqLRfzHHUjNHlY4UoWZp0GaUDjbEz2RsA
         HRhw==
X-Gm-Message-State: APjAAAWT3tbOer+8g1+YOt7ycvIvQYGq3acBb8sH/9NoDM87K31gNnP/
        LCHGHXYpz5uLOKR/xWtz/HyYWR0Svyd77+yVN7PJJw==
X-Google-Smtp-Source: APXvYqzzDHBsH5W/FSO1ymmxtYGQW60/quiwqfHQJoA2U5kzvebWsLGCgV6RauqRzhQohBYD1Fyb5QUsM1klzCMA8ds=
X-Received: by 2002:aca:4dcc:: with SMTP id a195mr99083oib.172.1572887359359;
 Mon, 04 Nov 2019 09:09:19 -0800 (PST)
MIME-Version: 1.0
References: <000000000000411e4b059683a39c@google.com> <CANpmjNMegMA6d5n1cV5JLmMbbe-3TkH5q3sNt9+E+wb8esjvoA@mail.gmail.com>
 <20191104162652.GC20975@paulmck-ThinkPad-P72>
In-Reply-To: <20191104162652.GC20975@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Mon, 4 Nov 2019 18:09:07 +0100
Message-ID: <CANpmjNOO3N1gWJC+edDTGcDHbRZisvfDk4TA3tBW6nV9cmukKw@mail.gmail.com>
Subject: Re: KCSAN: data-race in __rcu_read_unlock / sync_rcu_exp_select_cpus
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     syzbot <syzbot+99f4ddade3c22ab0cf23@syzkaller.appspotmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, amir73il@gmail.com,
        darrick.wong@oracle.com, Johannes Weiner <hannes@cmpxchg.org>,
        jack@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Nov 2019 at 17:26, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Nov 04, 2019 at 12:32:57PM +0100, Marco Elver wrote:
> > +RCU folks
> >
> > On Mon, 4 Nov 2019 at 12:30, syzbot
> > <syzbot+99f4ddade3c22ab0cf23@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    05f22368 x86, kcsan: Enable KCSAN for x86
> > > git tree:       https://github.com/google/ktsan.git kcsan
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1296ff50e00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=87d111955f40591f
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=99f4ddade3c22ab0cf23
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+99f4ddade3c22ab0cf23@syzkaller.appspotmail.com
> > >
> > > ==================================================================
> > > BUG: KCSAN: data-race in __rcu_read_unlock / sync_rcu_exp_select_cpus
> > >
> > > read to 0xffffffff85a7d440 of 8 bytes by task 7624 on cpu 0:
> > >   rcu_read_unlock_special kernel/rcu/tree_plugin.h:615 [inline]
> > >   __rcu_read_unlock+0x381/0x3c0 kernel/rcu/tree_plugin.h:383
> > >   rcu_read_unlock include/linux/rcupdate.h:652 [inline]
> > >   filemap_map_pages+0x5b3/0x990 mm/filemap.c:2687
> > >   do_fault_around mm/memory.c:3450 [inline]
> > >   do_read_fault mm/memory.c:3484 [inline]
> > >   do_fault mm/memory.c:3618 [inline]
> > >   handle_pte_fault mm/memory.c:3849 [inline]
> > >   __handle_mm_fault+0x2554/0x2cb0 mm/memory.c:3973
> > >   handle_mm_fault+0x21b/0x530 mm/memory.c:4010
> > >   do_user_addr_fault arch/x86/mm/fault.c:1441 [inline]
> > >   __do_page_fault+0x3fb/0x9e0 arch/x86/mm/fault.c:1506
> > >   do_page_fault+0x54/0x233 arch/x86/mm/fault.c:1530
> > >   page_fault+0x34/0x40 arch/x86/entry/entry_64.S:1202
> > >
> > > write to 0xffffffff85a7d440 of 8 bytes by task 7353 on cpu 1:
> > >   sync_exp_reset_tree kernel/rcu/tree_exp.h:137 [inline]
> > >   sync_rcu_exp_select_cpus+0xd5/0x590 kernel/rcu/tree_exp.h:427
> > >   rcu_exp_sel_wait_wake kernel/rcu/tree_exp.h:575 [inline]
> > >   wait_rcu_exp_gp+0x25/0x40 kernel/rcu/tree_exp.h:589
> > >   process_one_work+0x3d4/0x890 kernel/workqueue.c:2269
> > >   worker_thread+0xa0/0x800 kernel/workqueue.c:2415
> > >   kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
> > >   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352
> > >
> > > Reported by Kernel Concurrency Sanitizer on:
> > > CPU: 1 PID: 7353 Comm: kworker/1:0 Not tainted 5.4.0-rc3+ #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > Google 01/01/2011
> > > Workqueue: rcu_gp wait_rcu_exp_gp
> > > ==================================================================
> > > Kernel panic - not syncing: panic_on_warn set ...
> > > CPU: 1 PID: 7353 Comm: kworker/1:0 Not tainted 5.4.0-rc3+ #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > Google 01/01/2011
> > > Workqueue: rcu_gp wait_rcu_exp_gp
> > > Call Trace:
> > >   __dump_stack lib/dump_stack.c:77 [inline]
> > >   dump_stack+0xf5/0x159 lib/dump_stack.c:113
> > >   panic+0x210/0x640 kernel/panic.c:221
> > >   kcsan_report.cold+0xc/0x10 kernel/kcsan/report.c:302
> > >   __kcsan_setup_watchpoint+0x32e/0x4a0 kernel/kcsan/core.c:411
> > >   __tsan_write8 kernel/kcsan/kcsan.c:36 [inline]
> > >   __tsan_write8+0x32/0x40 kernel/kcsan/kcsan.c:36
> > >   sync_exp_reset_tree kernel/rcu/tree_exp.h:137 [inline]
> > >   sync_rcu_exp_select_cpus+0xd5/0x590 kernel/rcu/tree_exp.h:427
> > >   rcu_exp_sel_wait_wake kernel/rcu/tree_exp.h:575 [inline]
> > >   wait_rcu_exp_gp+0x25/0x40 kernel/rcu/tree_exp.h:589
> > >   process_one_work+0x3d4/0x890 kernel/workqueue.c:2269
> > >   worker_thread+0xa0/0x800 kernel/workqueue.c:2415
> > >   kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
> > >   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352
> > > Shutting down cpus with NMI
> > > Kernel Offset: disabled
> > > Rebooting in 86400 seconds..
> > >
> > >
> > > ---
> > > This bug is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this bug report. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> Again, good catch!  Does the patch shown below fix this?

Assuming writers will follow in another patch:

Acked-by: Marco Elver <elver@google.com>

Thanks,
-- Marco


>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit c3c182aa501c13faccf5f2c168004a5c98a89d74
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Mon Nov 4 08:22:45 2019 -0800
>
>     rcu: Use READ_ONCE() for ->expmask in rcu_read_unlock_special()
>
>     The rcu_node structure's ->expmask field is updated only when holding the
>     ->lock, but is also accessed locklessly.  This means that all ->expmask
>     updates must use WRITE_ONCE() and all reads carried out without holding
>     ->lock must use READ_ONCE().  This commit therefore changes the lockless
>     ->expmask read in rcu_read_unlock_special() to use READ_ONCE().
>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 6d54fd4..9a1b4b2 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -601,7 +601,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
>                 struct rcu_node *rnp = rdp->mynode;
>
>                 exp = (t->rcu_blocked_node && t->rcu_blocked_node->exp_tasks) ||
> -                     (rdp->grpmask & rnp->expmask) ||
> +                     (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
>                       tick_nohz_full_cpu(rdp->cpu);
>                 // Need to defer quiescent state until everything is enabled.
>                 if (irqs_were_disabled && use_softirq &&
