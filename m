Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B200DC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87310216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UluEH/75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfHAJvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 05:51:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59302 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfHAJvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 05:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/RCQXkoLdx1Dap2zHV/paZLxYVJHeWju5RP8ynoxTPI=; b=UluEH/75fC5+qgudhOiGsRDkg
        Dmv3F33wa/UY2uDdoFibQqQZ/AqqbiXyF/wqMePOsemH4nmb1rKJpHHfYVfEv3f3ai4nBEp7Ug+sL
        SWzd5y8YOKyQ/tSuRq0AiUJXLq4NeSuDbMiZURN9ycAr1WLCUOUT5OizKLOhC9xB/AVC02rjw3CtK
        Wax8iH9jNoLz0U6pypJXmZ8HPc5NNfEIKf4EOPSG1OTeIXbzBGbcVP41xY+kvR+e+I/f8rggEFydN
        eqt4MyjaUuiqqF6LW21UPHkR1sy64DUUDe4i1To53kp8ma1FLTaZT+7cLoi8LygcrYfmuoqz0PCAh
        nXgvvDuHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1ht7ju-0003e9-F5; Thu, 01 Aug 2019 09:51:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 149A52029F4CD; Thu,  1 Aug 2019 11:51:12 +0200 (CEST)
Date:   Thu, 1 Aug 2019 11:51:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, lizefan@huawei.com,
        Johannes Weiner <hannes@cmpxchg.org>, axboe@kernel.dk,
        Dennis Zhou <dennis@kernel.org>,
        Dennis Zhou <dennisszhou@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Nick Kralevich <nnk@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/1] psi: do not require setsched permission from the
 trigger creator
Message-ID: <20190801095112.GA31381@hirez.programming.kicks-ass.net>
References: <20190730013310.162367-1-surenb@google.com>
 <20190730081122.GH31381@hirez.programming.kicks-ass.net>
 <CAJuCfpH7NpuYKv-B9-27SpQSKhkzraw0LZzpik7_cyNMYcqB2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpH7NpuYKv-B9-27SpQSKhkzraw0LZzpik7_cyNMYcqB2Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 10:44:51AM -0700, Suren Baghdasaryan wrote:
> On Tue, Jul 30, 2019 at 1:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Jul 29, 2019 at 06:33:10PM -0700, Suren Baghdasaryan wrote:
> > > When a process creates a new trigger by writing into /proc/pressure/*
> > > files, permissions to write such a file should be used to determine whether
> > > the process is allowed to do so or not. Current implementation would also
> > > require such a process to have setsched capability. Setting of psi trigger
> > > thread's scheduling policy is an implementation detail and should not be
> > > exposed to the user level. Remove the permission check by using _nocheck
> > > version of the function.
> > >
> > > Suggested-by: Nick Kralevich <nnk@google.com>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  kernel/sched/psi.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > > index 7acc632c3b82..ed9a1d573cb1 100644
> > > --- a/kernel/sched/psi.c
> > > +++ b/kernel/sched/psi.c
> > > @@ -1061,7 +1061,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
> > >                       mutex_unlock(&group->trigger_lock);
> > >                       return ERR_CAST(kworker);
> > >               }
> > > -             sched_setscheduler(kworker->task, SCHED_FIFO, &param);
> > > +             sched_setscheduler_nocheck(kworker->task, SCHED_FIFO, &param);
> >
> > ARGGH, wtf is there a FIFO-99!! thread here at all !?
> 
> We need psi poll_kworker to be an rt-priority thread so that psi

There is a giant difference between 'needs to be higher than OTHER' and
FIFO-99.

> notifications are delivered to the userspace without delay even when
> the CPUs are very congested. Otherwise it's easy to delay psi
> notifications by running a simple CPU hogger executing "chrt -f 50 dd
> if=/dev/zero of=/dev/null". Because these notifications are

So what; at that point that's exactly what you're asking for. Using RT
is for those who know what they're doing.

> time-critical for reacting to memory shortages we can't allow for such
> delays.

Furthermore, actual RT programs will have pre-allocated and locked any
memory they rely on. They don't give a crap about your pressure
nonsense.

> Notice that this kworker is created only if userspace creates a psi
> trigger. So unless you are using psi triggers you will never see this
> kthread created.

By marking it FIFO-99 you're in effect saying that your stupid
statistics gathering is more important than your life. It will preempt
the task that's in control of the band-saw emergency break, it will
preempt the task that's adjusting the electromagnetic field containing
this plasma flow.

That's insane.

I'm going to queue a patch to reduce this to FIFO-1, that will preempt
regular OTHER tasks but will not perturb (much) actual RT bits.

