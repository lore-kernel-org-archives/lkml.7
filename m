Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB97EC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 11:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CEF72073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 11:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m3E8NfRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfKOL7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 06:59:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55214 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfKOL7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 06:59:40 -0500
Received: by mail-wm1-f66.google.com with SMTP id z26so9376216wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 03:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=S09UPwfYdKcUezowJYA1vALnj/JQzhaEMYLsBOToWeQ=;
        b=m3E8NfRrNLmGCSR7e4N3uG3jFwgQYxFnQiO3oWd0VwmF+Hbypk5kjB2qoybt/FWbzq
         BP7J+Mk36PYa6MXtlmgaAvavokx053jglYBfipIwhaYJR6ccqW3CjN/Z9TDCQVxcGH/9
         Iu7ApOXj1jVzLVGhrZjkeK9Os4Yi8+Xc5exvbsv5irJyCsM/yN3kPbNyiBuY4F96sA8g
         Y21zmvUS8iJ+EQe2BvkVVbmPLI9Lfn31PaXSK8AVqiO5+X0dM3lGVrdh3thgbSeVwQGA
         czGUeSyDJiNj61cbDCvca48ZAer6Nx5TGLgYwAykZ+vxx5/EF99EiVE8zuN/xIBw+kTV
         8gmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=S09UPwfYdKcUezowJYA1vALnj/JQzhaEMYLsBOToWeQ=;
        b=NOaJj12Hx+Z0b9DnazgLHuMUMOC0iXp6/dU1O5CSX5LjOxBbXNH4bteJ1Vxq3hX5Ee
         62My8JnkDVYNiGoyRYJ9pUnqx/gzR5dcFRJeIPjtWQ/4NyWwYthv7IR+8vXA7PvmQ6AE
         9QET+5V4lQ3vhfgDQO88esmQh4/PrYXk4diuq/WLRfr0TJq9q/qR8Ecc05kBQkgJMLec
         KECQrsVYMbE94owN32yO16K7pSjQ+dNZgDE+qw/Znetn2E94bSTl/5bamdsNCUR08u4i
         ZBcCsR5qX9G8/8m4VQ9F1UjcofQ+yZorjuBGr332tRXUn401MbUt/Edipsg3QLrqNDXo
         AC0g==
X-Gm-Message-State: APjAAAV+3qv5DFiJWzs9RMO5A1dd+zX+feBDUjqr/LfraN5jjZ9GgfQ1
        KQAdb1O2nLONJLYCrc57sQM4/A==
X-Google-Smtp-Source: APXvYqxst3BhX0IeqkRSGbe+Y73UM/qJeySFUU1ZxqctuDXAx9pwmCBCWl1sONm0kcAaKjrJA67nSA==
X-Received: by 2002:a1c:67d7:: with SMTP id b206mr13710368wmc.68.1573819177937;
        Fri, 15 Nov 2019 03:59:37 -0800 (PST)
Received: from linaro.org ([2a01:e0a:f:6020:2cf9:d654:7aae:c016])
        by smtp.gmail.com with ESMTPSA id b186sm9022720wmb.21.2019.11.15.03.59.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 03:59:36 -0800 (PST)
Date:   Fri, 15 Nov 2019 12:59:35 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
Subject: Re: [PATCH v4] sched/freq: move call to cpufreq_update_util
Message-ID: <20191115115935.GA27454@linaro.org>
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
 <20191115095447.GU4114@hirez.programming.kicks-ass.net>
 <CAKfTPtCTcrq1E1H8A3TL1xvALUrQ7ybPoERJ+C2O2+QXpVEZGQ@mail.gmail.com>
 <CAKfTPtA-up_9WHfTka33WRxXCatUZioYS0v5gY9jjzOGT98oLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtA-up_9WHfTka33WRxXCatUZioYS0v5gY9jjzOGT98oLQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Friday 15 Nov 2019 à 11:29:03 (+0100), Vincent Guittot a écrit :
> On Fri, 15 Nov 2019 at 11:18, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Fri, 15 Nov 2019 at 10:55, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, Nov 14, 2019 at 06:07:31PM +0100, Vincent Guittot wrote:
> > > > update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pelt decays,
> > > > which might be inefficient when cpufreq driver has rate limitation.
> > > >
> > > > When a task is attached on a CPU, we have call path:
> > > >
> > > > update_load_avg()
> > > >   update_cfs_rq_load_avg()
> > > >     cfs_rq_util_change -- > trig frequency update
> > > >   attach_entity_load_avg()
> > > >     cfs_rq_util_change -- > trig frequency update
> > > >
> > > > The 1st frequency update will not take into account the utilization of the
> > > > newly attached task and the 2nd one might be discard because of rate
> > > > limitation of the cpufreq driver.
> > >
> > > Doesn't this just show that a dumb rate limit in the driver is broken?
> >
> > But the rate limit may come from HW constraints that forces to wait
> > let say 4ms or even 10ms between each frequency update.
> >
> > >
> > > > update_cfs_rq_load_avg() is only called by update_blocked_averages()
> > > > and update_load_avg() so we can move the call to
> > > > cfs_rq_util_change/cpufreq_update_util() into these 2 functions. It's also
> > > > interesting to notice that update_load_avg() already calls directly
> > > > cfs_rq_util_change() for !SMP case.
> > > >
> > > > This changes will also ensure that cpufreq_update_util() is called even
> > > > when there is no more CFS rq in the leaf_cfs_rq_list to update but only
> > > > irq, rt or dl pelt signals.
> > >
> > > I don't think it does that; that is, iirc the return value of
> > > ___update_load_sum() is 1 every time a period lapses. So even if the avg
> > > is 0 and doesn't change, it'll still return 1 on every period.
> > >
> > > Which is what that dumb rate-limit thing wants of course. But I'm still
> > > thinking that it's stupid to do. If nothing changes, don't generate
> > > events.
> >
> > When everything (irq, dl, rt, cfs) is 0, we don't generate events
> > because update_blocked_averages is no more called because
> > rq->has_blocked_load is clear
> >
> > With current implementation, if cfs is 0 but not irq, dl or rt, we
> > don't call cpufreq_update_util because it is only called through cfs
> >
> > >
> > > If anything, update_blocked_avgerages() should look at
> > > @done/others_have_blocked() to emit events for rt,dl,irq.
> >
> > other_have_blocked can be set but no decay happened during the update
> > and we don't need to call cpufreq_update_util
> >
> > >
> > > So why are we making the scheduler code more ugly instead of fixing that
> > > driver?
> 
> Also, I think that calling cfs_rq_util_change in
> attach_entity_load_avg is not optimal because the attach can happen at
> a child level before it has been propagated down to root
> So I'm working on trying to remove it from attach_entity_load_avg and
> keep it in update_load_avg. this would help cleaning the ugly
> 
> -       } else if (decayed && (flags & UPDATE_TG))
> -               update_tg_load_avg(cfs_rq, 0);
> +       } else if (decayed) {
> +               cfs_rq_util_change(cfs_rq, 0);
> +
> +               if (flags & UPDATE_TG)
> +                       update_tg_load_avg(cfs_rq, 0);
> +       }
>  }
>

we can also do this instead :

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d377a3f..550b6bc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3614,15 +3614,15 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
                 *
                 * IOW we're enqueueing a task on a new CPU.
                 */
-               attach_entity_load_avg(cfs_rq, se, SCHED_CPUFREQ_MIGRATION);
+               attach_entity_load_avg(cfs_rq, se, 0);
                update_tg_load_avg(cfs_rq, 0);
+               decayed = 1;
 
-       } else if (decayed) {
-               cfs_rq_util_change(cfs_rq, 0);
+       } else if (decayed && (flags & UPDATE_TG))
+               update_tg_load_avg(cfs_rq, 0);
 
-               if (flags & UPDATE_TG)
-                       update_tg_load_avg(cfs_rq, 0);
-       }
+       if (decayed)
+               cfs_rq_util_change(cfs_rq, 0);
 }



>
