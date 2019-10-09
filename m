Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4062FECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128C320B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kH+IeUMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbfJILeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 07:34:20 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39504 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbfJILeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 07:34:20 -0400
Received: by mail-lf1-f65.google.com with SMTP id 72so1380387lfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 04:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EG9v3kTZ0STByqKzP1n2q6Lh+2OqkwymViAjwK7ZPds=;
        b=kH+IeUMBfwMkv+Uo4/4m6ZmUuhDopta5OobVSgramulhVEyCCZxL5T5iTJOdzm2ikl
         viyWRm8qzrngXIFOEtvhZyR3IqmVVW2GF9QmXLIJgbTUyymNdFCnG0qJ4WhHUlH09bZv
         h2xcgZVPD2u3UzlBpuO2zP5Hl7+jNW5mCu13+X0Y/hE3OATs5Mwrjqk40NwJUBP+2n6i
         m76Al2ZrYxWeyVpS28DnybxabAHASJg4GFrrYQ8x7oTSsGiAyqCltQZz7Kne5lV28xfp
         RFj3OwzWPIxsZcRAmtCpYaWSMdzpoXO2EJAz9dCO1akwjDH/mC+W/blXsAhj0wn+HrN3
         TKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EG9v3kTZ0STByqKzP1n2q6Lh+2OqkwymViAjwK7ZPds=;
        b=M7zU7u94rGXZBodDMZdUc+Dh7NuEcKi5kMPowFcmcyQtGgng08pDg8k2ZGEd+wK9ZL
         YQV7IGgMyN1WYh328EH3wYF0bfy2tOMQ6tkQFRWWbTARijjz7UsXCtKsOTtbxi9Hvgh/
         js4HwZIep1NrVeaPJZTU1s4u+5qum+BJK6LplJLFzvo36AnNZsEGju5iQb2OykEUukUm
         JhAyoqvbA+hVrw/dH69uVFHBnkLOjYprAFAXK1lV4i/DnmSpZ2zAYWK/FDjEWO2MvaUl
         fsvOoq9f3jTCtn1dj4YTQLdBBdTNvyznYO8/Lsdyp+lFvKvFdaMYnjlvFcIaqAuW5z2W
         78zQ==
X-Gm-Message-State: APjAAAU0zBdTkF3WNVs+W/C3JD4wrxebG4JQAMtuMfV/Goo4jhULUFT4
        b+b6huDJ+PiBJn5jYUbl6Ux1mHyezOlNpGRI2czKBQ==
X-Google-Smtp-Source: APXvYqyE36EyOAEHFvFyThIKdgVAP3t6Zlig8jOB79kkG650s6dVZXW5xCuGRLueBvJWlgkFNY0EbbJ3Zw9MdV2E4aI=
X-Received: by 2002:a19:4f06:: with SMTP id d6mr1847743lfb.15.1570620858079;
 Wed, 09 Oct 2019 04:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191007083051.4820-1-parth@linux.ibm.com> <20191008132842.6612-1-hdanton@sina.com>
 <d4c936d9-c99f-e50d-95c9-0732ae45d1b9@linux.ibm.com>
In-Reply-To: <d4c936d9-c99f-e50d-95c9-0732ae45d1b9@linux.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 9 Oct 2019 13:34:06 +0200
Message-ID: <CAKfTPtDghQrjK=4Pd0RbvwbQTU1SP88nVp6NLkNitk+07UfadA@mail.gmail.com>
Subject: Re: [RFC v5 4/6] sched/fair: Tune task wake-up logic to pack small
 background tasks on fewer cores
To:     Parth Shah <parth@linux.ibm.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavel Machek <pavel@ucw.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Quentin Perret <qperret@qperret.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2019 at 11:23, Parth Shah <parth@linux.ibm.com> wrote:
>
>
>
> On 10/8/19 6:58 PM, Hillf Danton wrote:
> >
> > On Mon,  7 Oct 2019 14:00:49 +0530 Parth Shah wrote:
> >> +/*
> >> + * Try to find a non idle core in the system  based on few heuristics:
> >> + * - Keep track of overutilized (>80% util) and busy (>12.5% util) CPUs
> >> + * - If none CPUs are busy then do not select the core for task packing
> >> + * - If atleast one CPU is busy then do task packing unless overutilized CPUs
> >> + *   count is < busy/2 CPU count
> >> + * - Always select idle CPU for task packing
> >> + */
> >> +static int select_non_idle_core(struct task_struct *p, int prev_cpu, int target)
> >> +{
> >> +    struct cpumask *cpus = this_cpu_cpumask_var_ptr(turbo_sched_mask);
> >> +    int iter_cpu, sibling;
> >> +
> >> +    cpumask_and(cpus, cpu_online_mask, p->cpus_ptr);
> >> +
> >> +    for_each_cpu_wrap(iter_cpu, cpus, prev_cpu) {
> >> +            int idle_cpu_count = 0, non_idle_cpu_count = 0;
> >> +            int overutil_cpu_count = 0;
> >> +            int busy_cpu_count = 0;
> >> +            int best_cpu = iter_cpu;
> >> +
> >> +            for_each_cpu(sibling, cpu_smt_mask(iter_cpu)) {
> >> +                    __cpumask_clear_cpu(sibling, cpus);
> >> +                    if (idle_cpu(iter_cpu)) {
> >
> > Would you please elaborate the reasons that the iter cpu is checked idle
> > more than once for finding a busy core?
> >
>
> Thanks for looking at the patches.
> Could you please point me out where iter_cpu is checked more than once?

I think that point is that you have a sibling that there is
for_each_cpu(sibling, cpu_smt_mask(iter_cpu) but you never use sibling
in the loop except for clearing it on the cpumask cpus
All the tests are done with iter_cpu so you will test several time
iter_cpus but never the other sibling
Should you use sibling instead ?


>
> >> +                            idle_cpu_count++;
> >> +                            best_cpu = iter_cpu;
> >> +                    } else {
> >> +                            non_idle_cpu_count++;
> >> +                            if (cpu_overutilized(iter_cpu))
> >> +                                    overutil_cpu_count++;
> >> +                            if (is_cpu_busy(cpu_util(iter_cpu)))
> >> +                                    busy_cpu_count++;
> >> +                    }
> >> +            }
> >> +
> >
>
