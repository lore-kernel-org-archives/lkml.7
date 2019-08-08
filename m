Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1223AC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9EC42171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9OSEB9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732584AbfHHOXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 10:23:31 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38832 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732404AbfHHOXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:23:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id r12so56191010edo.5;
        Thu, 08 Aug 2019 07:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wrpT4pEp9tLMuoEIwtzbTdFrr/qoYwWUYKv8PLkoWvA=;
        b=H9OSEB9STtHMMGPs/m1ZJF4owjTD1eSjiP4FHPH6VLyvXafAr72F9UIrYPoaHS5PsL
         /2Kj6FWMwZmSj38F0Ko3rBSDpGg1MdWf7p8bxjOiAfPlez/jli0AtLycPS5u6AD8QlV6
         q6WqlaNoTHJLX400HORVNnPYODdTL2+ZcTzqFPtUflO4+epW12wRZpVoISsUD0owH4b+
         P3v/IUESY8QbU8HJqZ5JUu8dplGdzi33tcY3yAe+j1AkO9VuEiw7Wx4KM1SUrCeTldQh
         5xSbndopN6NjzrNXJiK+6/gF/e3pNG/1TrnTyFRWEhR1kuC4z+Wy3vpeeA6P95Iqq6Zz
         OSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wrpT4pEp9tLMuoEIwtzbTdFrr/qoYwWUYKv8PLkoWvA=;
        b=itXEnn6mUIw0ocB1xH1AKYl5Z8XCq2NJBE6mIN70cwFux3DrS0uyx7A0phTn8jFwZd
         6NOI55X6pSpnZSDR+LfuUNmO64UaSwZnJGI+P72Y/o2MLXg0YIw4oS6k3yeUSQmqeoBC
         qsTRJ1CmoK8AhPVzD+gID52T3oC6ncms0wf9nTHaxOkE5kzn3mMaz2rV/hW8BCMziyMM
         sydYiQRVPOA77d8W6lfjHgsL0N+3E+rIhV+WMsv+qHsUBMZXwjujS4P5+xCefhI/xdPt
         SaeUDFkq64aR3EKE+vdKn+Lbr3ZKhih2T6NJY7K/osrYdXKwis5lEd6qHn2u9voRsXmG
         snZw==
X-Gm-Message-State: APjAAAUC09G7XArfvr9eqiLThXxDgreBnRIe171FqDZFhRVllyqqQSik
        c3Bex6n1U/ceDJWBrOGaNNU+2tkC3rUt1lG3ZNw=
X-Google-Smtp-Source: APXvYqwBU9MD5plGi+yS1jzuMmYyqELnKlWcR2B7vqDQZHwkZRS1C49xrTYOLQf5wFVbALncQERaC2LPTwSIgrtTmcQ=
X-Received: by 2002:a17:906:8313:: with SMTP id j19mr13559997ejx.276.1565274208225;
 Thu, 08 Aug 2019 07:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806235631.GU28441@linux.ibm.com> <20190807094504.GB169551@google.com>
 <20190807175215.GE28441@linux.ibm.com> <20190808095232.GA30401@X58A-UD3R> <20190808125607.GB261256@google.com>
In-Reply-To: <20190808125607.GB261256@google.com>
From:   Byungchul Park <max.byungchul.park@gmail.com>
Date:   Thu, 8 Aug 2019 23:23:17 +0900
Message-ID: <CANrsvRPU_u6oKpjZ1368Evto+1hGboNYeOuMdbdzaOfXhSO=5g@mail.gmail.com>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu batching
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rao Shoaib <rao.shoaib@oracle.com>, kernel-team@android.com,
        kernel-team <kernel-team@lge.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 9:56 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Thu, Aug 08, 2019 at 06:52:32PM +0900, Byungchul Park wrote:
> > On Wed, Aug 07, 2019 at 10:52:15AM -0700, Paul E. McKenney wrote:
> > > > > On Tue, Aug 06, 2019 at 05:20:40PM -0400, Joel Fernandes (Google) wrote:
> > > [ . . . ]
> > > > > > +     for (; head; head = next) {
> > > > > > +             next = head->next;
> > > > > > +             head->next = NULL;
> > > > > > +             __call_rcu(head, head->func, -1, 1);
> > > > >
> > > > > We need at least a cond_resched() here.  200,000 times through this loop
> > > > > in a PREEMPT=n kernel might not always be pretty.  Except that this is
> > > > > invoked directly from kfree_rcu() which might be invoked with interrupts
> > > > > disabled, which precludes calls to cond_resched().  So the realtime guys
> > > > > are not going to be at all happy with this loop.
> > > >
> > > > Ok, will add this here.
> > > >
> > > > > And this loop could be avoided entirely by having a third rcu_head list
> > > > > in the kfree_rcu_cpu structure.  Yes, some of the batches would exceed
> > > > > KFREE_MAX_BATCH, but given that they are invoked from a workqueue, that
> > > > > should be OK, or at least more OK than queuing 200,000 callbacks with
> > > > > interrupts disabled.  (If it turns out not to be OK, an array of rcu_head
> > > > > pointers can be used to reduce the probability of oversized batches.)
> > > > > This would also mean that the equality comparisons with KFREE_MAX_BATCH
> > > > > need to become greater-or-equal comparisons or some such.
> > > >
> > > > Yes, certainly we can do these kinds of improvements after this patch, and
> > > > then add more tests to validate the improvements.
> > >
> > > Out of pity for people bisecting, we need this fixed up front.
> > >
> > > My suggestion is to just allow ->head to grow until ->head_free becomes
> > > available.  That way you are looping with interrupts and preemption
> > > enabled in workqueue context, which is much less damaging than doing so
> > > with interrupts disabled, and possibly even from hard-irq context.
> >
> > Agree.
> >
> > Or after introducing another limit like KFREE_MAX_BATCH_FORCE(>=
> > KFREE_MAX_BATCH):
> >
> > 1. Try to drain it on hitting KFREE_MAX_BATCH as it does.
> >
> >    On success: Same as now.
> >    On fail: let ->head grow and drain if possible, until reaching to
> >             KFREE_MAX_BATCH_FORCE.

I should've explain this in more detail. This actually mean:

On fail: Let ->head grow and queue rcu_work when ->head_free == NULL,
         until reaching to _FORCE.

> > 3. On hitting KFREE_MAX_BATCH_FORCE, give up batching but handle one by
> >    one from now on to prevent too many pending requests from being
> >    queued for batching work.

This mean:

3. On hitting KFREE_MAX_BATCH_FORCE, give up batching requests to be added
   from now on but instead handle one by one to prevent too many
pending requests
   from being queued. Of course, the requests already having been
queued in ->head
   so far should be handled by rcu_work when it's possible which can
be checked by
   the monitor or kfree_rcu() inside every call.

> I also agree. But this _FORCE thing will still not solve the issue Paul is
> raising which is doing this loop possibly in irq disabled / hardirq context.

I added more explanation above. What I suggested is a way to avoid not
only heavy
work within the irq-disabled region of a single kfree_rcu() but also
too many requests
to be queued into ->head.

> We can't even cond_resched() here. In fact since _FORCE is larger, it will be
> even worse. Consider a real-time system with a lot of memory, in this case
> letting ->head grow large is Ok, but looping for long time in IRQ disabled
> would not be Ok.

Please check the explanation above.

> But I could make it something like:
> 1. Letting ->head grow if ->head_free busy
> 2. If head_free is busy, then just queue/requeue the monitor to try again.

This is exactly what Paul said. The problem with this is ->head can grow too
much. That's why I suggested the above one.

> This would even improve performance, but will still risk going out of memory.
>
> Thoughts?
>
> thanks,
>
>  - Joel
>
> >
> > This way, we can avoid both:
> >
> > 1. too many requests being queued and
> > 2. __call_rcu() bunch of requests within a single kfree_rcu().
> >
> > Thanks,
> > Byungchul
> >
> > >
> > > But please feel free to come up with a better solution!
> > >
> > > [ . . . ]



-- 
Thanks,
Byungchul
