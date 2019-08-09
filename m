Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8C8C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B56B2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405709AbfHIHNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 03:13:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35458 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfHIHNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 03:13:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2so4645034wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 00:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JPMru+DldOJ85ZY2JuNQlO53huOOt1b/0sJ9I75q88k=;
        b=lM0Jm0LOOcMFkp1h1wbbV7VmhMMKktxt2WZ2xr7dZtuWKABDzgSUy33P9OpQyHNzor
         WsYI0muzFr/N52EeKFTDUi2HLcQ2Iiwo8+F3JaWrIbRsCKW6W3+vIBxUtJD0ynUkRO3Q
         IDP54nZaAwowEfLcO6JGm66t+9G6AXRmu6NO5rvbe8YB5U7H01H2viK/4o0eJKgd9gtu
         JoQeMYnFIqHcYwcA7DCwvHqHRp1QmpuPMwuR8B27DCo81fxVuUO5JHe1m18s5vLtdgin
         UCUH1iAl1YMw32SrvYJ46XU2ka35dkrZbsz6aSdqN9HisllRMlzxpRGXLm54ntFrjnPX
         fprg==
X-Gm-Message-State: APjAAAXBP+fIdNqX7sLEouQ5GTYLc0zbVpZmc7tYAjkD3y6n0Mnaotfk
        oZpbSE41krbquPjTjTX0wIJhmg==
X-Google-Smtp-Source: APXvYqywjE6hw+0imzPjaJlEkA09vFA4fTJ10U5u/KPSEJCk6cBa6tIoFPfTzERohdJIc6srHR8IYw==
X-Received: by 2002:a1c:c78d:: with SMTP id x135mr8917567wmf.82.1565334791047;
        Fri, 09 Aug 2019 00:13:11 -0700 (PDT)
Received: from localhost.localdomain ([151.38.139.48])
        by smtp.gmail.com with ESMTPSA id q124sm6708226wma.33.2019.08.09.00.13.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 00:13:10 -0700 (PDT)
Date:   Fri, 9 Aug 2019 09:13:06 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        bristot@redhat.com, balsini@android.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
Subject: Re: [RFC][PATCH 12/13] sched/deadline: Introduce deadline servers
Message-ID: <20190809071306.GL29310@localhost.localdomain>
References: <20190726145409.947503076@infradead.org>
 <20190726161358.056107990@infradead.org>
 <34710762-f813-3913-0e55-fde7c91c6c2d@arm.com>
 <20190808075635.GB17205@worktop.programming.kicks-ass.net>
 <20cc05d3-0d0f-a558-2bbe-3b72527dd9bc@arm.com>
 <20190808084652.GG29310@localhost.localdomain>
 <20190808103109.GF2369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808103109.GF2369@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/19 12:31, Peter Zijlstra wrote:
> On Thu, Aug 08, 2019 at 10:46:52AM +0200, Juri Lelli wrote:
> > On 08/08/19 10:11, Dietmar Eggemann wrote:
> 
> > > What about the fast path in pick_next_task()?
> > > 
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index bffe849b5a42..f1ea6ae16052 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -3742,6 +3742,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> > >                 if (unlikely(!p))
> > >                         p = idle_sched_class.pick_next_task(rq, prev, rf);
> > >  
> > > +               if (p->sched_class == &fair_sched_class && p->server)
> > > +                       p->server = NULL;
> > > +
> > 
> > Hummm, but then who sets it back to the correct server. AFAIU
> > update_curr() needs a ->server to do the correct DL accounting?
> 
> The above looks ok.
> 
> The pick_next_task_dl() when it selects a server will set ->server.

OK. Yesterday's IRC conversation resolved my perplexity about this
point. I tried to summarize what I've got in the comment below (which we
might want to add on top of Dietmar's fix).

--->8---
 /*
  * Since we are executing the fast path it means that the DL
  * server was throttled and we'll now be scheduled w/o it. So,
  * reset p's pointer to it (accounting won't be performed, as
  * it wouldn't make sense while server is thottled).
  */
