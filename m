Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADD2CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A5E206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dXuRuvvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437875AbfJYILO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:11:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46027 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437822AbfJYILN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:11:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1so1015554pgj.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 01:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MvC1xa/Yv2E+4rHJhqnHKwrOhUrxM0nH05PTERSBhFE=;
        b=dXuRuvvKfs4ccP/XEcohv6Of8V/+kMjvnucXJZpVOSjyHYKF5oMlvOKWUw+8MN+d3D
         bZqgOp4WN+aR0zPuV4cKr/oPywRltjzEzOrMR9Lhq0TjxbRsqgYp2ZEgO1MiCiH0+JO7
         C1MLs96IFAevoXXT/ypKlC/Ydq9YELaRfq+qWlQ5JQ8ugPLa3smzDm0Gm2x6x9masAVC
         VqzGLKYJfdn6QIWUcMjO9ZNvIEU5utMRlOpGUk+q0+ySbs03YOsmaN4/reDnkshoEgyR
         X4jFBlH58xAx+2ry3+aiL9rX+tyC17TSqSqFhdTVtkFx7at4WVkA4AJwx7MxifdXxdNa
         fDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MvC1xa/Yv2E+4rHJhqnHKwrOhUrxM0nH05PTERSBhFE=;
        b=QeWb8mv1+3WrgR1X5GhxURACg2CVSxWc8ViHCh004QbRKE/mTFsWzvRCjjUQD58faj
         4yQBxSH+j58DGAlNRK8HNnHAaVrWkDFQFnRb05cqYfzB57SNvJ6dMxEDnjhWP0thR27p
         BeIIyvza4x2l3YNls/0JG/05th7P6/apO2eGBKqYdPTwH0Y08rle72pn5YEb7jF15ijS
         8DTsd3O0uwdXpFgdQOOZPPI19VBzqht2bmlOwFtKwVFAHJpM8uOzejyWA0KEEw4e7bvN
         rod79fYerWvtqBOHYzzAeScbMP0wnsD8UyMfN2a6Yj007/8IV9FpmVYU4gUFwaBqP/Vd
         64tA==
X-Gm-Message-State: APjAAAVSzknWEfH5/1leAiIxqRArar6+DrYQnnAT5clv1X7zxAKKYSk8
        1CerVnjdhL6m0/EZm/4rS1YrTw==
X-Google-Smtp-Source: APXvYqxGmwDVbpVbBPzldrNQ8sCg81PVOoWWJ8GUohKjD2EZ2a9Wd8Hq7QYgLa4AM5/Sl4RGA5aJgw==
X-Received: by 2002:aa7:9aa2:: with SMTP id x2mr2711820pfi.103.1571991072328;
        Fri, 25 Oct 2019 01:11:12 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id l93sm1438985pjb.6.2019.10.25.01.11.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 01:11:11 -0700 (PDT)
Date:   Fri, 25 Oct 2019 13:41:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Make sched-idle cpu selection consistent
 throughout
Message-ID: <20191025081108.6gaprbwm5fvokun6@vireshk-i7>
References: <5eba2fb4af9ebc7396101bb9bd6c8aa9c8af0710.1571899508.git.viresh.kumar@linaro.org>
 <7d3a1549-a99c-ae42-6074-8ed2ecd7074f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d3a1549-a99c-ae42-6074-8ed2ecd7074f@linux.ibm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-10-19, 12:13, Parth Shah wrote:
> Hi Viresh,
> 
> On 10/24/19 12:15 PM, Viresh Kumar wrote:
> > There are instances where we keep searching for an idle CPU despite
> > having a sched-idle cpu already (in find_idlest_group_cpu(),
> > select_idle_smt() and select_idle_cpu() and then there are places where
> > we don't necessarily do that and return a sched-idle cpu as soon as we
> > find one (in select_idle_sibling()). This looks a bit inconsistent and
> > it may be worth having the same policy everywhere.
> > 
> > On the other hand, choosing a sched-idle cpu over a idle one shall be
> > beneficial from performance point of view as well, as we don't need to
> > get the cpu online from a deep idle state which is quite a time
> > consuming process and delays the scheduling of the newly wakeup task.
> > 
> > This patch tries to simplify code around sched-idle cpu selection and
> > make it consistent throughout.
> > 
> > FWIW, tests were done with the help of rt-app (8 SCHED_OTHER and 5
> > SCHED_IDLE tasks, not bound to any cpu) on ARM platform (octa-core), and
> > no significant difference in scheduling latency of SCHED_OTHER tasks was
> > found.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> 
> [...]
> 
> > @@ -5755,13 +5749,11 @@ static int select_idle_smt(struct task_struct *p, int target)
> >  	for_each_cpu(cpu, cpu_smt_mask(target)) {
> >  		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> >  			continue;
> > -		if (available_idle_cpu(cpu))
> > +		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> >  			return cpu;
> 
> I guess this is a correct approach, but just wondering what if we still
> keep searching for a sched_idle CPU even though we have found an
> available_idle CPU?

I do believe selecting a sched-idle CPU should almost always be better
(performance wise), unless we have a strong argument against it. And
anyway, the load balancer will get triggered at a later point of time
and will pull away these newly wakeup tasks to idle CPUs. The
advantage we get out of it is that the tasks get serviced a bit
earlier when they first get queued.

It is really up to the maintainers to see what kind of policy do we
want to adapt here and not a choice I can make :)

-- 
viresh
