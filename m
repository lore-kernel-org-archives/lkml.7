Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DCAC47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 14:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D310B222D3
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 14:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GPw8ZMaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfJEOeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 10:34:36 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37236 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJEOef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 10:34:35 -0400
Received: by mail-ot1-f68.google.com with SMTP id k32so7637102otc.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 07:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M9slP3iKnAm63U3tuy9xEZJOMuCJBhoA1BolBatTclo=;
        b=GPw8ZMaMVaviw/cMPN6lH4cnGgCi+CWse4O9XJySKkr9jsyd+q9Z4nuRCHa7oNRRwr
         qgUL7dnweYwzG21Dm2QqiWfym5LoO93rVE25IBWjHOqOfIvr9/FzF+26FewaoZB2OZlh
         Y/adls+5weFB9FVLk8VKECXYOBFPOnRxXyu/in4xn4NMvabDokBKI+vVlh7VDXP/Tugx
         b3w0K/VGTSgbpyCQ/2No1RhVXhmBrQ1hn7vndZOgbEb6YBWtm/TJfGwxjU8oeAhN5d4r
         pT3BxJpuKtNFzrLkO7TYSAHxwqiu0yVmW8XKzIoIZWGhApRyTrgq6PR2fHu//T6XhZyw
         XtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9slP3iKnAm63U3tuy9xEZJOMuCJBhoA1BolBatTclo=;
        b=t7L2DoexSJHaqhdaP6erzgJcsbxDB/BJL1y5gCuH5tyv9HKYfwKaxV0BrIaq4/GLyc
         WXRTrvwoQflyXFIJUJc05mokhsXX1KhuS/p3f1G10uwOy46Ij6KSzX5s74l+rPtuJiGb
         U+TCqqyhI0sQyKLeA/nb6bQFpk4P9a11xsQMNCeXc3rELCqsi8/7hE7SeoFn864noJKj
         WIcNUVzhwG8ITUPURGlBX3vG2yrrD11goPTG7imtWYhHhCT9yqrZnYc8yu9XNcBSBIt0
         E60/jKRokMgkPwuwSjn/68EDYQxRGIppZI7tptLtmvOves3m0SxVWb1Y3taE/GyMzEvC
         dPkw==
X-Gm-Message-State: APjAAAWP6i9vIVJ/81r1GX/o7VxF7Sy69xnzXmlVzNSwP0G+o53/u+Yi
        kavxbjM8zW7SdxqfRRARBlwb5Tw36MXrf4wBJsN80w==
X-Google-Smtp-Source: APXvYqxMJuJ/evQKnpkqa0aSU9cTzJxDEiTUwWVJI84pge1Hh6BoYz7q416ZwBe1sIddZefth8z+gBQmtbXmmNunqxA=
X-Received: by 2002:a05:6830:101:: with SMTP id i1mr15041173otp.233.1570286073978;
 Sat, 05 Oct 2019 07:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009b403005942237bf@google.com> <20191005112806.13960-1-christian.brauner@ubuntu.com>
 <CANpmjNMqTupyPc6-PCviB1HPTHawjzNL1r1gmdQqnwCvE=BNNA@mail.gmail.com> <20191005141523.kog6il27seucy2f4@wittgenstein>
In-Reply-To: <20191005141523.kog6il27seucy2f4@wittgenstein>
From:   Marco Elver <elver@google.com>
Date:   Sat, 5 Oct 2019 16:34:22 +0200
Message-ID: <CANpmjNNc8LitzytmUD1EE-yJ1r3tE_NiZPNf05ay10tRmBzfxg@mail.gmail.com>
Subject: Re: [PATCH] taskstats: fix data-race
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com,
        bsingharora@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Oct 2019 at 16:15, Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Sat, Oct 05, 2019 at 03:33:07PM +0200, Marco Elver wrote:
> > On Sat, 5 Oct 2019 at 13:28, Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > >
> > > When assiging and testing taskstats in taskstats
> > > taskstats_exit() there's a race around writing and reading sig->stats.
> > >
> > > cpu0:
> > > task calls exit()
> > > do_exit()
> > >         -> taskstats_exit()
> > >                 -> taskstats_tgid_alloc()
> > > The task takes sighand lock and assigns new stats to sig->stats.
> > >
> > > cpu1:
> > > task catches signal
> > > do_exit()
> > >         -> taskstats_tgid_alloc()
> > >                 -> taskstats_exit()
> > > The tasks reads sig->stats __without__ holding sighand lock seeing
> > > garbage.
> >
> > Is the task seeing garbage reading the data pointed to by stats, or is
> > this just the pointer that would be garbage?
>
> I expect the pointer to be garbage.
>
> >
> > My only observation here is that the previous version was trying to do
> > double-checked locking, to avoid taking the lock if sig->stats was
> > already set. The obvious problem with the previous version is plain
> > read/write and missing memory ordering: the write inside the critical
> > section should be smp_store_release and there should only be one
> > smp_load_acquire at the start.
> >
> > Maybe I missed something somewhere, but maybe my suggestion below
> > would be an equivalent fix without always having to take the lock to
> > assign the pointer? If performance is not critical here, then it's
> > probably not worth it.
>
> The only point of contention is when the whole thread-group exits (e.g.
> via exit_group(2) since threads in a thread-group share signal struct).
> The reason I didn't do memory barriers was because we need to take the
> spinlock for the actual list manipulation anyway.
> But I don't mind incorporating the acquire/release.

Thanks for the clarification. Since you no longer do double-checked
locking, explicit memory barriers shouldn't be needed because
spin_lock/unlock already provides acquire/release ordering.

-- Marco

> Christian
>
> >
> > Thanks,
> > -- Marco
> >
> > diff --git a/kernel/taskstats.c b/kernel/taskstats.c
> > index 13a0f2e6ebc2..f58dd285a44b 100644
> > --- a/kernel/taskstats.c
> > +++ b/kernel/taskstats.c
> > @@ -554,25 +554,31 @@ static int taskstats_user_cmd(struct sk_buff
> > *skb, struct genl_info *info)
> >  static struct taskstats *taskstats_tgid_alloc(struct task_struct *tsk)
> >  {
> >   struct signal_struct *sig = tsk->signal;
> > - struct taskstats *stats;
> > + struct taskstats *stats_new, *stats;
> >
> > - if (sig->stats || thread_group_empty(tsk))
> > + /* acquire load to make pointed-to data visible */
> > + stats = smp_load_acquire(&sig->stats);
> > + if (stats || thread_group_empty(tsk))
> >   goto ret;
> >
> >   /* No problem if kmem_cache_zalloc() fails */
> > - stats = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);
> > + stats_new = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);
> >
> >   spin_lock_irq(&tsk->sighand->siglock);
> > - if (!sig->stats) {
> > - sig->stats = stats;
> > - stats = NULL;
> > + stats = sig->stats;
> > + if (!stats) {
> > + stats = stats_new;
> > + /* release store to order zalloc before */
> > + smp_store_release(&sig->stats, stats_new);
> > + stats_new = NULL;
> >   }
> >   spin_unlock_irq(&tsk->sighand->siglock);
> >
> > - if (stats)
> > - kmem_cache_free(taskstats_cache, stats);
> > + if (stats_new)
> > + kmem_cache_free(taskstats_cache, stats_new);
> > +
> >  ret:
> > - return sig->stats;
> > + return stats;
> >  }
> >
> >  /* Send pid data out on exit */
