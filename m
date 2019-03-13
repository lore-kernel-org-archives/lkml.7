Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4829C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC59820854
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WH3pACy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfCMUKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:10:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54406 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfCMUKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iKaAaR0b9zGhdda/EQDjIyXON3pypPy/3ubER9oGfxo=; b=WH3pACy1VvG9dx7UNcbbn8Y0f
        dHw9ulDgqq9wK7Zlc3xFE+oqC5yePtRb0LKvnvPphgu3BKt7ufVTzqUqEZMN3EMm2Be/g+RI5GgT0
        1uc4ZtWwejHIP8whbZYhRbQm6l8xZvQ38fEXVTuYO5LyWtM74HU5n2CBrdGKN7BM/2xQg9ViACuCU
        6GwKlbqZ5WQki0O3E6j8lPetFWPHOXV9O8h9eukRk73snDLsfT9Io0ryzYiWTAkn2eBU0yf3JMCTs
        Cu5EzOyNJZ0ivl7NafbdYgik82tN/uJtqguntPsFEdhyLqPI4LkHsin0uGJTTwmzmnlFVt+IBKOG+
        FVTBGwZUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4ACa-0008N5-NY; Wed, 13 Mar 2019 20:10:13 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D1CCC9826C0; Wed, 13 Mar 2019 21:10:10 +0100 (CET)
Date:   Wed, 13 Mar 2019 21:10:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v7 03/15] sched/core: uclamp: Add system default clamps
Message-ID: <20190313201010.GU2482@worktop.programming.kicks-ass.net>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-4-patrick.bellasi@arm.com>
 <20190313143240.GH5922@hirez.programming.kicks-ass.net>
 <20190313170940.ngiafkmiijryhl2k@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313170940.ngiafkmiijryhl2k@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 05:09:40PM +0000, Patrick Bellasi wrote:

> Yes, that should be possible... will look into splitting this out in
> v8 to have something like:
> 
> ---8<---
> struct uclamp_req {
> 	/* Clamp value "requested" by a scheduling entity */
> 	unsigned int value		: bits_per(SCHED_CAPACITY_SCALE);
> 	unsigned int bucket_id		: bits_per(UCLAMP_BUCKETS);
> 	unsigned int active		: 1;
> 	unsigned int user_defined	: 1;
> }
> 
> struct uclamp_eff {
> 	unsigned int value	        : bits_per(SCHED_CAPACITY_SCALE);
> 	unsigned int bucket_id	        : bits_per(UCLAMP_BUCKETS);
> }

No, have _1_ type. There is no point what so ever to splitting this.

Also, what's @user_defined about, I don't think I've seen that in the
parent patch.

> struct task_struct {
>         // ...
>         #ifdef CONFIG_UCLAMP_TASK
>                 struct uclamp_req uclamp_req[UCLAMP_CNT];
>                 struct uclamp_eff uclamp_eff[UCLAMP_CNT];

		struct uclamp_se uclamp[UCLAMP_CNT];
		struct uclamp_se uclamp_req[UCLAMP_CNT];

Where the first is the very same introduced in patch #1, and leaving it
in place avoids having to update the sites already using that (or start
#1 with the _eff name to avoid having to change things around?).

>         #endif
>         // ...
> }
> 
> static inline struct uclamp_eff
> uclamp_eff_get(struct task_struct *p, unsigned int clamp_id)
> {
>         struct uclamp_eff uc_eff = p->uclamp_eff[clamp_id];

just this ^, these lines seem like a superfluous duplication:

> 	uc_eff.bucket_id = p->uclamp_req[clamp_id].bucket_id;
> 	uc_eff.value = p->uclamp_req[clamp_id].value;


> 	if (unlikely(uc_eff.clamp_value > uclamp_default[clamp_id].value)) {
> 		uc_eff.clamp_value = uclamp_default[clamp_id].value;
> 		uc_eff.bucket_id = uclamp_default[clamp_id].bucket_id;

and:

		uc = uclamp_default[clamp_id];

> 	}
> 
>         return uc_eff;
> }
> 
> static inline void
> uclamp_eff_set(struct task_struct *p, unsigned int clamp_id)
> {
>         p->uclamp_eff[clamp_id] = uclamp_eff_get(p, clamp_id);
> }
> ---8<---
> 
> Is that what you mean ?

Getting there :-)
