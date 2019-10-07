Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608EFECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2705A21721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DWoXSOXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfJGNvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:51:00 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43931 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbfJGNvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:51:00 -0400
Received: by mail-qk1-f194.google.com with SMTP id h126so12571882qke.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 06:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IYTQc9pkklqWHMouyJseXYf3fIK7lEf7q4Z1ZbUboWU=;
        b=DWoXSOXJ2+WloLrHOXlt4e17wDt7AR/niWGjAZjfVMddOsQ1wyWBYBhaosgPDbnc6v
         UyMg0Ny06xFOyH1RZj47SIcL51nYf7PbPsRVTrwd6YKcgUeXlCy6yVn615HYcKIz3Kci
         1u8tIvjVXsXQLoObbMxWI8p0fSXcI473Z2JoCieUc4rg54wNoltxZjQNr+Mj6pk0o8RZ
         f/W3q6CNJJRuLphdRpMzNw86lXvJ77IqyX6pEWJMAWO7WpRL7mGAGcp+ZkCrrdKFH3i2
         lYzr5NLCTSspZ3S4Amb+3i8JgIq0YAeRqlPbRnwbOy2lxJFqVzn4NmnHDUzdKM6h3+dG
         lo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IYTQc9pkklqWHMouyJseXYf3fIK7lEf7q4Z1ZbUboWU=;
        b=tfAD/nCKY8yecgkrZwP3WNy8vRWxa0rN7WtzEYNvmcBygN8YxHGjTWHdnKIUTc61yy
         /zFJaOA0qHuGelP1D8+UCWm+cFGgef4CX/na1IOBeSblhwVK4hmI/RlNBZxyjfzb5Feu
         R3eT+2G7FpZY+Wjw3GRJz2ofWIOurz3Yal4VkpHTbZHS7Dplq5s/RWUTNyZgzEtsXMhL
         3axOVEFbNA7IE/uwnGI5cctKE2DU1JjJRSkt/HLz7o5BZdFE80CbBHcEFG9ekGZN0yD/
         2GDwvJa5Aay9ukSZImxSkhVukON8Xdhm/bhwb4u6byKSW7Pfx9PRwNH7XT0x4EPMMpxy
         aJWw==
X-Gm-Message-State: APjAAAX1SsIbF6l05QMj+6LGvuuiVct94oc9yCs+N9bTak1M7YCHjwLc
        xYfI8WV+OPMqq9vcoyg8fDpPn8cIybnoY0psHus7fw==
X-Google-Smtp-Source: APXvYqzh/OeSTjLyIs3Dc0YlIhCuQFyOlIjf37jONr3UqmFwJP6OBS+YmngvTj21e28J/XdDCSiEYCj4ZuEOOd361n0=
X-Received: by 2002:a37:985:: with SMTP id 127mr23035292qkj.43.1570456258406;
 Mon, 07 Oct 2019 06:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191007104039.GA16085@andrea.guest.corp.microsoft.com>
 <20191007110117.1096-1-christian.brauner@ubuntu.com> <20191007131804.GA19242@andrea.guest.corp.microsoft.com>
In-Reply-To: <20191007131804.GA19242@andrea.guest.corp.microsoft.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 7 Oct 2019 15:50:47 +0200
Message-ID: <CACT4Y+YG23qbL16MYH3GTK4hOPsM9tDfbLzrTZ7k_ocR2ABa6A@mail.gmail.com>
Subject: Re: [PATCH v2] taskstats: fix data-race
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        bsingharora@gmail.com, Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 3:18 PM Andrea Parri <parri.andrea@gmail.com> wrote:
>
> On Mon, Oct 07, 2019 at 01:01:17PM +0200, Christian Brauner wrote:
> > When assiging and testing taskstats in taskstats_exit() there's a race
> > when writing and reading sig->stats when a thread-group with more than
> > one thread exits:
> >
> > cpu0:
> > thread catches fatal signal and whole thread-group gets taken down
> >  do_exit()
> >  do_group_exit()
> >  taskstats_exit()
> >  taskstats_tgid_alloc()
> > The tasks reads sig->stats holding sighand lock seeing garbage.
>
> You meant "without holding sighand lock" here, right?
>
>
> >
> > cpu1:
> > task calls exit_group()
> >  do_exit()
> >  do_group_exit()
> >  taskstats_exit()
> >  taskstats_tgid_alloc()
> > The task takes sighand lock and assigns new stats to sig->stats.
> >
> > Fix this by using READ_ONCE() and smp_store_release().
> >
> > Reported-by: syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com
> > Fixes: 34ec12349c8a ("taskstats: cleanup ->signal->stats allocation")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > Link: https://lore.kernel.org/r/20191006235216.7483-1-christian.brauner@ubuntu.com
> > ---
> > /* v1 */
> > Link: https://lore.kernel.org/r/20191005112806.13960-1-christian.brauner@ubuntu.com
> >
> > /* v2 */
> > - Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>:
> >   - fix the original double-checked locking using memory barriers
> >
> > /* v3 */
> > - Andrea Parri <parri.andrea@gmail.com>:
> >   - document memory barriers to make checkpatch happy
> > ---
> >  kernel/taskstats.c | 21 ++++++++++++---------
> >  1 file changed, 12 insertions(+), 9 deletions(-)
> >
> > diff --git a/kernel/taskstats.c b/kernel/taskstats.c
> > index 13a0f2e6ebc2..978d7931fb65 100644
> > --- a/kernel/taskstats.c
> > +++ b/kernel/taskstats.c
> > @@ -554,24 +554,27 @@ static int taskstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
> >  static struct taskstats *taskstats_tgid_alloc(struct task_struct *tsk)
> >  {
> >       struct signal_struct *sig = tsk->signal;
> > -     struct taskstats *stats;
> > +     struct taskstats *stats_new, *stats;
> >
> > -     if (sig->stats || thread_group_empty(tsk))
> > -             goto ret;
> > +     /* Pairs with smp_store_release() below. */
> > +     stats = READ_ONCE(sig->stats);
>
> This pairing suggests that the READ_ONCE() is heading an address
> dependency, but I fail to identify it: what is the target memory
> access of such a (putative) dependency?

I would assume callers of this function access *stats. So the
dependency is between loading stats and accessing *stats.

> > +     if (stats || thread_group_empty(tsk))
> > +             return stats;
> >
> >       /* No problem if kmem_cache_zalloc() fails */
> > -     stats = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);
> > +     stats_new = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);
> >
> >       spin_lock_irq(&tsk->sighand->siglock);
> >       if (!sig->stats) {
> > -             sig->stats = stats;
> > -             stats = NULL;
> > +             /* Pairs with READ_ONCE() above. */
> > +             smp_store_release(&sig->stats, stats_new);
>
> This is intended to 'order' the _zalloc()  (zero initializazion)
> before the update of sig->stats, right?  what else am I missing?
>
> Thanks,
>   Andrea
>
>
> > +             stats_new = NULL;
> >       }
> >       spin_unlock_irq(&tsk->sighand->siglock);
> >
> > -     if (stats)
> > -             kmem_cache_free(taskstats_cache, stats);
> > -ret:
> > +     if (stats_new)
> > +             kmem_cache_free(taskstats_cache, stats_new);
> > +
> >       return sig->stats;
> >  }
> >
> > --
> > 2.23.0
> >
