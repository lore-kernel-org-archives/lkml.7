Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035CDC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09B1206E1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I7qqQUgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfLBNv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 08:51:57 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:32837 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfLBNv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 08:51:56 -0500
Received: by mail-lf1-f68.google.com with SMTP id n25so2997565lfl.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 05:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XtfrhDtdzCxL3Xb03lgcl6ONk0p14oDVPbfrCoLCTMU=;
        b=I7qqQUgIRQI7EvMDT1n9KA9WL1pREVLQG4Gy1MMgNgkHkI6mI8NkY8tAcgJEyeN1EI
         Tvq5XCwrx+YayBLix/B7JoMLMfsQRB6/o6h/nLbRqfAJHwo+l8pvb3nPInFItyzQahw0
         yli8WLpCd1GTRxgD53W2iUjZMqHKZe7ZQ+czZDzMucz54z3ffRnxYB0nZ7sbpRHJ+N/b
         kWXGgf7/+fkOY3JhmJSJ+XgnfO9HHj7XbJtv9udwWBff2Vg6vM34UY1VkZtFhG5T10lY
         tJ0GZhsoTnhPdki/eZ7IhFt81RWn/95wb+MnTVxdjgWQ2Qwb6GAfhEwPFkzQWb4S6MLR
         laLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XtfrhDtdzCxL3Xb03lgcl6ONk0p14oDVPbfrCoLCTMU=;
        b=FXGXPg10ciG8S2l4tPUDQE8/b6x9FhB+GQJrhav1HQD4ujXS0YPQCPdTxeOPYU8/rR
         7I0CScRUiKXVWTql8hEmfapJ8O5sfEbMqjeoB95Vi+LB1/uqWbVk9DCnAEhJ1PpIpEGZ
         rbpwtBLIuju9Xl1RLWhkgfwwiSOQJw5Y8ZBfXO3rjbvxqy+H7MNawognq1L2TdMm566w
         KhrvckhWuTZYn5tt32NrNcUQClhV9QqOIcRn5i0KREEbKFDNBXI7+ec7lzN0KHzxLit3
         /ktv/jgQUfOHDGF3LDyinSDVWxyNs9CiC2hIToZ/zrOlM4d0mvhP3sL/ieEhcX+iFCJk
         5bKA==
X-Gm-Message-State: APjAAAVQtdR32OIGMj630LzalHTTesy3+qXowlsBdyNWfJ940J8nDr/B
        oJ2qmBrw18uZg0C+YJ4ky5zc8g08Ng3D+AbahBd5lg==
X-Google-Smtp-Source: APXvYqxv39zeUzBPjDccuBFGveDJk4YfxKmPUP3c+dQ3y0cUEEzwQitLsma2s/6tRgHQzP+bFJA9NMzIsOR96I5mLoc=
X-Received: by 2002:ac2:4c8e:: with SMTP id d14mr37142463lfl.32.1575294714613;
 Mon, 02 Dec 2019 05:51:54 -0800 (PST)
MIME-Version: 1.0
References: <1575036287-6052-1-git-send-email-vincent.guittot@linaro.org> <20191202132204.GK2844@hirez.programming.kicks-ass.net>
In-Reply-To: <20191202132204.GK2844@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 2 Dec 2019 14:51:43 +0100
Message-ID: <CAKfTPtBgZZWUonqdkOMJCyJSxSkGtbiWji=bR4LaZZJ=mVW-zQ@mail.gmail.com>
Subject: Re: [PATCH] sched/cfs: fix spurious active migration
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2019 at 14:22, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 29, 2019 at 03:04:47PM +0100, Vincent Guittot wrote:
> > The load balance can fail to find a suitable task during the periodic check
> > because  the imbalance is smaller than half of the load of the waiting
> > tasks. This results in the increase of the number of failed load balance,
> > which can end up to start an active migration. This active migration is
> > useless because the current running task is not a better choice than the
> > waiting ones. In fact, the current task was probably not running but
> > waiting for the CPU during one of the previous attempts and it had already
> > not been selected.
> >
> > When load balance fails too many times to migrate a task, we should relax
> > the contraint on the maximum load of the tasks that can be migrated
> > similarly to what is done with cache hotness.
> >
> > Before the rework, load balance used to set the imbalance to the average
> > load_per_task in order to mitigate such situation. This increased the
> > likelihood of migrating a task but also of selecting a larger task than
> > needed while more appropriate ones were in the list.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >
> > I haven't seen any noticable performance changes on the benchmarks that I
> > usually run but the problem can be easily highlight with a simple test
> > with 9 always running tasks on 8 cores.
> >
> >  kernel/sched/fair.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e0d662a..d1b4fa7 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7433,7 +7433,14 @@ static int detach_tasks(struct lb_env *env)
> >                           load < 16 && !env->sd->nr_balance_failed)
> >                               goto next;
> >
> > -                     if (load/2 > env->imbalance)
> > +                     /*
> > +                      * Make sure that we don't migrate too much load.
> > +                      * Nevertheless, let relax the constraint if
> > +                      * scheduler fails to find a good waiting task to
> > +                      * migrate.
> > +                      */
> > +                     if (load/2 > env->imbalance &&
> > +                         env->sd->nr_balance_failed <= env->sd->cache_nice_tries)
> >                               goto next;
> >
> >                       env->imbalance -= load;
>
> The alternative is carrying a flag that inhibits incrementing
> nr_balance_failed.
>
> Not migrating anything when doing so would make the imbalance worse is
> not a failure after all.

Yeah I thought about this possibility but this behavior will make a
big difference compared to legacy load balance and i'm not sure about
the impact on performance because we can generate significant
unfairness with 2 tasks sharing a CPU while others have a full CPU in
the example that I mentioned above.
