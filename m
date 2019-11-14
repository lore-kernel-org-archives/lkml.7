Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0834BC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE25F206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZdVr8Kef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfKNRGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:06:36 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43822 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfKNRGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:06:36 -0500
Received: by mail-lf1-f66.google.com with SMTP id q5so5654490lfo.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 09:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LUshx25ptyYHMcSI3qBArBPZRmtiuT1b7sUSIZ582Mk=;
        b=ZdVr8Kefhung4i+R4Al9a1AzRSpC7dEEu/I59uddd99N3XirlBFUi9OSV3ELUSWDxw
         UoWQwG3YcudsiX15JyNbSjYh/EG3of68leKVPHFykLWcYOgho7myxA017IkFhVFC53cg
         R21Jk6/a5sltnjpbjdNKMJvijPKDhGFBx3/WROBc2hHu+breKXDdjer+JszSaP5edtux
         nYpofgB3tOI59ar9Y3O0iE2lhFaxR+QoPmQp/+xH9G6liobJ04rxUs1XhlHmEN3KFD/g
         C5lfSagG/vzzUxlaHE6oTk5RLo60qZh1p5QHs2BOm2L9y8VAaY3lPLvZjoIFGkd0oRDF
         OAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LUshx25ptyYHMcSI3qBArBPZRmtiuT1b7sUSIZ582Mk=;
        b=PtxPWBXsnbhq5BUopFMvNhzJAd7T9X5vBnqKy/NZR1v+HFMpxLb2Y+R8wWcevx+RNW
         eFj8haGsMOpi81FM+/K0teJAZXhYfLnfadNA2OyLHmfgliV8sGh08X5UddFJA7uhO1ij
         8KHyzNQ/HUEZ2BVuvkSFyD8G/itbzMGbZDzWX4g82bVCfILisUhJwSeKRaBrhVCrBZcO
         eaNOk/9BDvLqK5ofYofYz5FIlRmd2RUBVR0xEP/miSEZh+qlHVSdBIlaVadlSygRXTzy
         kIP3Z9JaaoQxs0CtMCHrZftiWtofLaRwW1h54MHGaGBEucCBQ+bBtoDkUT8lUo1rzX8N
         YV9Q==
X-Gm-Message-State: APjAAAUzbnQSEpJfMqM5y9IsEAx8k7GR/0HBAderuOcCq9HR6Yfk+xqE
        4f33zJlZwfAiaSOUsVtP6AIc21rT/q+rrxkN0GWPeQ==
X-Google-Smtp-Source: APXvYqyfyZhD8eJoEGu/UwZt7xr5QhuiQJHFQjPAqTi7V65rDkU7hj41uZK2ShCgxorX5yNo7CPl3tyra5v20g5ErFk=
X-Received: by 2002:a19:c215:: with SMTP id l21mr6878085lfc.125.1573751192728;
 Thu, 14 Nov 2019 09:06:32 -0800 (PST)
MIME-Version: 1.0
References: <1573676461-7990-1-git-send-email-vincent.guittot@linaro.org> <5a56358b-83f5-09db-17f0-dbdeecba2ff3@arm.com>
In-Reply-To: <5a56358b-83f5-09db-17f0-dbdeecba2ff3@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 14 Nov 2019 18:06:20 +0100
Message-ID: <CAKfTPtDmr8BY3uy6twPM2e8mcEs+-oaKnMtRt6DEyX4Z8F_Vbw@mail.gmail.com>
Subject: Re: [PATCH v3] sched/freq: move call to cpufreq_update_util
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Doug Smythies <dsmythies@telus.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019 at 17:23, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 13.11.19 21:21, Vincent Guittot wrote:
> > update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pelt decays,
> > which might be inefficient when cpufreq driver has rate limitation.
> >
> > When a task is attached on a CPU, we have call path:
> >
> > update_load_avg()
> >   update_cfs_rq_load_avg()
> >     cfs_rq_util_change -- > trig frequency update
> >   attach_entity_load_avg()
> >     cfs_rq_util_change -- > trig frequency update
> >
> > The 1st frequency update will not take into account the utilization of the
> > newly attached task and the 2nd one might be discard because of rate
> > limitation of the cpufreq driver.
> >
> > update_cfs_rq_load_avg() is only called by update_blocked_averages()
> > and update_load_avg() so we can move the call to
> > cfs_rq_util_change/cpufreq_update_util() into these 2 functions. It's also
> > interesting to notice that update_load_avg() already calls directly
> > cfs_rq_util_change() for !SMP case.
> >
> > This changes will also ensure that cpufreq_update_util() is called even
> > when there is no more CFS rq in the leaf_cfs_rq_list to update but only
> > irq, rt or dl pelt signals.
> >
> > Reported-by: Doug Smythies <dsmythies@telus.net>
> > Fixes: 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing path")
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>
> > ---
> >
> > changes for v3:
> > - fix typo
> > - test the decay of root cfs_rq even for !CONFIG_FAIR_GROUP_SCHED case
>
> nit: s/!CONFIG_FAIR_GROUP_SCHED/CONFIG_FAIR_GROUP_SCHED
>
> [...]
>
> > @@ -7543,6 +7544,7 @@ static void update_blocked_averages(int cpu)
> >       const struct sched_class *curr_class;
> >       struct rq_flags rf;
> >       bool done = true;
> > +     int decayed;
> >
> >       rq_lock_irqsave(rq, &rf);
> >       update_rq_clock(rq);
> > @@ -7552,9 +7554,9 @@ static void update_blocked_averages(int cpu)
> >        * that RT, DL and IRQ signals have been updated before updating CFS.
> >        */
>
> tip/sched/urgent's b90f7c9d2198 ("sched/pelt: Fix update of blocked PELT
> ordering") adds this comment to both update_blocked_averages()
> implementations. It mentions explicitly that update_cfs_rq_load_avg()
> can call cpufreq_update_util(). Something this patch changes. Might be
> good to update the comments with this patch as well.

yes.

>
> [...]
