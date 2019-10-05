Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC998C3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 14:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8948E222D3
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 14:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfJEOPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 10:15:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41508 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfJEOPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 10:15:30 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iGkqD-0003fV-3P; Sat, 05 Oct 2019 14:15:25 +0000
Date:   Sat, 5 Oct 2019 16:15:24 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Marco Elver <elver@google.com>
Cc:     syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com,
        bsingharora@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] taskstats: fix data-race
Message-ID: <20191005141523.kog6il27seucy2f4@wittgenstein>
References: <0000000000009b403005942237bf@google.com>
 <20191005112806.13960-1-christian.brauner@ubuntu.com>
 <CANpmjNMqTupyPc6-PCviB1HPTHawjzNL1r1gmdQqnwCvE=BNNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNMqTupyPc6-PCviB1HPTHawjzNL1r1gmdQqnwCvE=BNNA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2019 at 03:33:07PM +0200, Marco Elver wrote:
> On Sat, 5 Oct 2019 at 13:28, Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > When assiging and testing taskstats in taskstats
> > taskstats_exit() there's a race around writing and reading sig->stats.
> >
> > cpu0:
> > task calls exit()
> > do_exit()
> >         -> taskstats_exit()
> >                 -> taskstats_tgid_alloc()
> > The task takes sighand lock and assigns new stats to sig->stats.
> >
> > cpu1:
> > task catches signal
> > do_exit()
> >         -> taskstats_tgid_alloc()
> >                 -> taskstats_exit()
> > The tasks reads sig->stats __without__ holding sighand lock seeing
> > garbage.
> 
> Is the task seeing garbage reading the data pointed to by stats, or is
> this just the pointer that would be garbage?

I expect the pointer to be garbage.

> 
> My only observation here is that the previous version was trying to do
> double-checked locking, to avoid taking the lock if sig->stats was
> already set. The obvious problem with the previous version is plain
> read/write and missing memory ordering: the write inside the critical
> section should be smp_store_release and there should only be one
> smp_load_acquire at the start.
> 
> Maybe I missed something somewhere, but maybe my suggestion below
> would be an equivalent fix without always having to take the lock to
> assign the pointer? If performance is not critical here, then it's
> probably not worth it.

The only point of contention is when the whole thread-group exits (e.g.
via exit_group(2) since threads in a thread-group share signal struct).
The reason I didn't do memory barriers was because we need to take the
spinlock for the actual list manipulation anyway.
But I don't mind incorporating the acquire/release.

Christian

> 
> Thanks,
> -- Marco
> 
> diff --git a/kernel/taskstats.c b/kernel/taskstats.c
> index 13a0f2e6ebc2..f58dd285a44b 100644
> --- a/kernel/taskstats.c
> +++ b/kernel/taskstats.c
> @@ -554,25 +554,31 @@ static int taskstats_user_cmd(struct sk_buff
> *skb, struct genl_info *info)
>  static struct taskstats *taskstats_tgid_alloc(struct task_struct *tsk)
>  {
>   struct signal_struct *sig = tsk->signal;
> - struct taskstats *stats;
> + struct taskstats *stats_new, *stats;
> 
> - if (sig->stats || thread_group_empty(tsk))
> + /* acquire load to make pointed-to data visible */
> + stats = smp_load_acquire(&sig->stats);
> + if (stats || thread_group_empty(tsk))
>   goto ret;
> 
>   /* No problem if kmem_cache_zalloc() fails */
> - stats = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);
> + stats_new = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);
> 
>   spin_lock_irq(&tsk->sighand->siglock);
> - if (!sig->stats) {
> - sig->stats = stats;
> - stats = NULL;
> + stats = sig->stats;
> + if (!stats) {
> + stats = stats_new;
> + /* release store to order zalloc before */
> + smp_store_release(&sig->stats, stats_new);
> + stats_new = NULL;
>   }
>   spin_unlock_irq(&tsk->sighand->siglock);
> 
> - if (stats)
> - kmem_cache_free(taskstats_cache, stats);
> + if (stats_new)
> + kmem_cache_free(taskstats_cache, stats_new);
> +
>  ret:
> - return sig->stats;
> + return stats;
>  }
> 
>  /* Send pid data out on exit */
