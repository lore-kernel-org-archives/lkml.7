Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6C4C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 11:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977DF207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 11:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfIWLw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 07:52:28 -0400
Received: from foss.arm.com ([217.140.110.172]:40928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfIWLw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 07:52:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6E51142F;
        Mon, 23 Sep 2019 04:52:27 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CC3E3F694;
        Mon, 23 Sep 2019 04:52:26 -0700 (PDT)
Date:   Mon, 23 Sep 2019 12:52:24 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Alessio Balsini <balsini@android.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: rt: Make RT capacity aware
Message-ID: <20190923115223.a5fwrrxmg5dj765q@e107158-lin.cambridge.arm.com>
References: <20190903103329.24961-1-qais.yousef@arm.com>
 <20190904072524.09de28aa@oasis.local.home>
 <20190904154052.ygbhtduzkfj3xs5d@e107158-lin.cambridge.arm.com>
 <f25c1f61-f246-22c7-e627-4c4d39301af2@arm.com>
 <20190918145233.kgntor5nb2gmnczd@e107158-lin.cambridge.arm.com>
 <d307c2f6-f16c-4e9e-0476-91d49d115480@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d307c2f6-f16c-4e9e-0476-91d49d115480@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/20/19 14:52, Dietmar Eggemann wrote:
> > 	2. The fallback mechanism means we either have to call cpupri_find()
> > 	   twice once to find filtered lowest_rq and the other to return the
> > 	   none filtered version.
> 
> This is what I have in mind. (Only compile tested! ... and the 'if
> (cpumask_any(lowest_mask) >= nr_cpu_ids)' condition has to be considered
> as well):
> 
> @@ -98,8 +103,26 @@ int cpupri_find(struct cpupri *cp, struct
> task_struct *p,
>                         continue;
> 
>                 if (lowest_mask) {
> +                       int cpu, max_cap_cpu = -1;
> +                       unsigned long max_cap = 0;
> +
>                         cpumask_and(lowest_mask, p->cpus_ptr, vec->mask);
> 
> +                       for_each_cpu(cpu, lowest_mask) {
> +                               unsigned long cap =
> arch_scale_cpu_capacity(cpu);
> +
> +                               if (!rt_task_fits_capacity(p, cpu))
> +                                       cpumask_clear_cpu(cpu, lowest_mask);
> +
> +                               if (cap > max_cap) {
> +                                       max_cap = cap;
> +                                       max_cap_cpu = cpu;
> +                               }
> +                       }
> +
> +                       if (cpumask_empty(lowest_mask) && max_cap)
> +                               cpumask_set_cpu(max_cap_cpu, lowest_mask);

I had a patch that I was testing but what I did is to continue rather than
return a max_cap_cpu.

e.g:

	if no cpu at current priority fits the task:
		continue;
	else:
		return the lowest_mask which contains fitting cpus only

	if no fitting cpu was find:
		return 0;


Or we can tweak your approach to be

	if no cpu at current priority fits the task:
		if the cpu the task is currently running on doesn't fit it:
			return lowest_mask with max_cap_cpu set;

So we either:

	1. Continue the search until we find a fitting CPU; bail out otherwise.

	2. Or we attempt to return a CPU only if the CPU the task is currently
	   running on doesn't fit it. We don't want to migrate the task from a
	   fitting to a non-fitting one.

We can also do something hybrid like:

	3. Remember the outcome of 2 but don't return immediately and attempt
	   to find a fitting CPU at a different priority level.


Personally I see 1 is the simplest and good enough solution. What do you think?

I think this is 'continue' to search makes doing it at cpupri_find() more
robust than having to deal with whatever mask we first found in
find_lowest_rq() - so I'm starting to like this approach better. Thanks for
bringing it up.


Cheers

--
Qais Yousef
