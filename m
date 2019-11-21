Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C010BC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94225206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PvPm0N/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfKUPai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:30:38 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56193 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfKUPai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:30:38 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so4176385wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 07:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fwUMKfMJE5zmhfeOZVzrKhaAfjtqUIOOXfyEnwGW3wU=;
        b=PvPm0N/j1KirLROnANazbtECjIY2qt9Tmhg3vNHz25x+U4Z0MyTr0EQeUxt2vnEe4E
         8uzFls12r/9gOBEhgW/7x10kOIWY7q2lmXbuiEA5ooqUDmq7LF852Vg6omho1SUv7UjQ
         0d3hMZKj25dMcTFD3CsH5t/QFKNxywnAVeUTEIK+zxLk57f4GR9UNx8xjXJ0VnqrwwDR
         2Imc+H/6m0jUnXciJpX+AL4SQTxo0VVQOlV2KUjpvysfqvxRQCCkjqXczk2v4URkKQ3y
         d4bYu0bDAHYsQ4j0HM1G8Youxkpe3wFmDHaDS9ugmaIxc8lR6s76FW3Smah51TfZciti
         iuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fwUMKfMJE5zmhfeOZVzrKhaAfjtqUIOOXfyEnwGW3wU=;
        b=QRBkprk7okGgT1DywiBQUA/kFjvZXEdCPPlRZPLa7kl12QDCmb5GNOv0JoVSXlq750
         Nj6HaKBBQAeiPtOdvY2KTV791VIA0LgawWynO2xYmY9kYtPv+N0TPOrMj1Dub2gyYNPK
         iG/Ebqga/eqBgdA8eDqGl7Hu6pbOvcwzRldTAfxZPqSgAN5JhB+TlRWbsxFvoTeovoCc
         NTaQISaZvfv2K8qvH7DymaQJ7LcyVO1q4bvJcZvl6/2cYJhYjwSF/yjVZW3AymOrBJn2
         su0dn6D2shsmR70b3JXfIHl1hYP77tmMIIjGtJBQ0aev4986WKhbzP89O75yVZm3qo6k
         VIxw==
X-Gm-Message-State: APjAAAXjIKQWk6HbrqH7G8qdqp94oOCRWi9ioIzzfyagi1AKpadXqTZd
        FngtmIl54dUDiGaMaXofuuEyFg==
X-Google-Smtp-Source: APXvYqxZosL6fF2YBCeoGPIUdrdxtjHo46UiCr1XponLO3gwtklqPpXNxfsI8bwt1nBRwpqaLWCO5w==
X-Received: by 2002:a1c:750f:: with SMTP id o15mr9686762wmc.161.1574350234738;
        Thu, 21 Nov 2019 07:30:34 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id w7sm3678802wru.62.2019.11.21.07.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 07:30:33 -0800 (PST)
Date:   Thu, 21 Nov 2019 15:30:29 +0000
From:   Quentin Perret <qperret@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        qais.yousef@arm.com, morten.rasmussen@arm.com
Subject: Re: [PATCH 3/3] sched/fair: Consider uclamp for "task fits capacity"
 checks
Message-ID: <20191121153029.GA105938@google.com>
References: <20191120175533.4672-1-valentin.schneider@arm.com>
 <20191120175533.4672-4-valentin.schneider@arm.com>
 <20191121115602.GA213296@google.com>
 <f7e5dabb-a7e6-d110-abca-de7d4533bcc5@arm.com>
 <20191121133043.GA46904@google.com>
 <09e234a2-ea65-4d09-5215-9b0fe4ec09fe@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09e234a2-ea65-4d09-5215-9b0fe4ec09fe@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 Nov 2019 at 14:51:06 (+0000), Valentin Schneider wrote:
> On 21/11/2019 13:30, Quentin Perret wrote:
> > On Thursday 21 Nov 2019 at 12:56:39 (+0000), Valentin Schneider wrote:
> >>> @@ -6274,6 +6274,15 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >>>  			if (!fits_capacity(util, cpu_cap))
> >>>  				continue;
> >>>  
> >>> +			/*
> >>> +			 * Skip CPUs that don't satisfy uclamp requests. Note
> >>> +			 * that the above already ensures the CPU has enough
> >>> +			 * spare capacity for the task; this is only really for
> >>> +			 * uclamp restrictions.
> >>> +			 */
> >>> +			if (!task_fits_capacity(p, capacity_orig_of(cpu)))
> >>> +				continue;
> >>
> >> This is partly redundant with the above, I think. What we really want here
> >> is just
> >>
> >> fits_capacity(uclamp_eff_value(p, UCLAMP_MIN), capacity_orig_of(cpu))
> >>
> >> but this would require some inline #ifdeffery.
> > 
> > This suggested change lacks the UCLAMP_MAX part, which is a shame
> > because this is precisely in the EAS path that we should try and
> > down-migrate tasks if they have an appropriate max_clamp. So, your first
> > proposal made sense, IMO.
> > 
>  
> Hm right, had to let that spin in my head for a while but I think I got it.
> 
> I was only really thinking of:
> 
>   (h960: LITTLE = 462 cap, big = 1024)
>   p.uclamp.min = 512 -> skip LITTLEs regardless of the actual util_est
> 
> but your point is we also want stuff like:
> 
>   p.uclamp.max = 300 -> accept LITTLEs regardless of the actual util_est

Right, sorry if my message wasn't clear.

> I'll keep the feec() change as-is and add something like the above in the
> changelog for v2.
> 
> > Another option to avoid the redundancy would be to do something along
> > the lines of the totally untested diff below.
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 69a81a5709ff..38cb5fe7ba65 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6372,9 +6372,12 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >                         if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> >                                 continue;
> >  
> > -                       /* Skip CPUs that will be overutilized. */
> >                         util = cpu_util_next(cpu, p, cpu);
> >                         cpu_cap = capacity_of(cpu);
> > +                       spare_cap = cpu_cap - util;
> > +                       util = uclamp_util_with(cpu_rq(cpu), util, p);
> > +
> > +                       /* Skip CPUs that will be overutilized. */
> >                         if (!fits_capacity(util, cpu_cap))
> >                                 continue;
> >  
> > @@ -6389,7 +6392,6 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >                          * Find the CPU with the maximum spare capacity in
> >                          * the performance domain
> >                          */
> > -                       spare_cap = cpu_cap - util;
> >                         if (spare_cap > max_spare_cap) {
> >                                 max_spare_cap = spare_cap;
> >                                 max_spare_cap_cpu = cpu;
> > 
> > Thoughts ?
> > 
> 
> uclamp_util_with() (or uclamp_rq_util_with() ;)) picks the max between the
> rq-aggregated clamps and the task clamps, which isn't what we want. If the
> task has a low-ish uclamp.max (e.g. the 300 example from above) but the
> rq-wide max-aggregated uclamp.max is ~800, we'd clamp using that 800. It
> makes sense for frequency selection, but not for task placement IMO.

Right, but you could argue that this is in fact a correct behaviour.
What we want to know is 'is this CPU big enough to meet the capacity
request if I enqueue p there ?'. And the 'capacity request' is the
aggregated rq-wide clamped util, IMO.

If enqueuing 'p' on a given CPU will cause the rq-wide clamped util to
go above the CPU capacity, we want to skip that CPU.

The obvious case is if p's min_clamp is larger than the CPU capacity.

But similarly, if p's max_clamp is going to be ignored because of
another task with a larger max_clamp on the same rq, this is relevant
information too --  the resulting capacity request might be above the
CPU capacity if p's util_avg is large, so we should probably skip the
CPU too no ?

Are we gaining anything if we decide to not align the EAS path and the
sugov path ?

Thanks,
Quentin
