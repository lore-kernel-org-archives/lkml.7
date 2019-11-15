Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50CEC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED6620740
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573812214;
	bh=hGwcyc7dse7aO4c4QTH0uwqziYR/8Omebj93aT3/dfY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=u15v5GdTWPYljdUO3LIBzTYYMkmAg631+Fqb6A2L3jkhBZ9Hg87dAeCB+6wF/WgXY
	 OMDGzg7d8rwdFunNO2jinCHPakjJ1kt52m/Gps06RGoiNr0JblmCfsaVJ7PnEZHY4X
	 8v4lQCEOyDANYIEOu5Dvx1b+4I5w9RqF1ykamaPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfKOKDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:03:33 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43914 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfKOKDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:03:33 -0500
Received: by mail-oi1-f196.google.com with SMTP id l20so8111869oie.10;
        Fri, 15 Nov 2019 02:03:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SXs3HY8YTAHDWbWH1wQlCggSxa17Nb5994AEWlereo4=;
        b=F2IpUuHkBLOC/jLR/goXePgHZXrKwQojVPhKwXrb+btbPM0x3Gw6wHyuQHWd9vFEUb
         LGpLLxMbfc9+MrnDUbMoFhEWQzuI4QcRuk44rZ3LDLLclcfZ3uS9nTLFkDBRrccGgobS
         FR3Ywp5FHKmNnUBdgR2uhfVX5gPm4b4EBdjwTOSz/123vuVXjGRC2do5PfNFtAzmEOcK
         uTEJ96pviVHs4qQwkWERjHzSfNuoCsGMDYmmHaRsitY+CahrLAMA0QRkVj2N8MDicRRv
         2ckcPsHtkacb771hxwdCxa1KghjPioByijgqZ+IcY1e1cid9+qnim42f2KjjLpHXC4e0
         hr+Q==
X-Gm-Message-State: APjAAAVx5Yl5Wg8SrHOXAGz1cv0DOLs7i0xnUBwgcJGO49qMbbjYb7/P
        o7wXKhDWt2WDZEVzJcAdW5uAGyHnovDhJUIjonc=
X-Google-Smtp-Source: APXvYqwiAa8H0BnnhAV06ueQYnpFwJa+VHpNTuCaIVQesI+RmNL/91h2SB+RspBXW3ItPkDPPzqd4eu8aBOy2UvXCAI=
X-Received: by 2002:aca:530c:: with SMTP id h12mr7658865oib.110.1573812211998;
 Fri, 15 Nov 2019 02:03:31 -0800 (PST)
MIME-Version: 1.0
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org> <20191115095447.GU4114@hirez.programming.kicks-ass.net>
In-Reply-To: <20191115095447.GU4114@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Nov 2019 11:03:20 +0100
Message-ID: <CAJZ5v0hjsWM=bRg4k2qNCfcqjQ08N+6kG=1vCXpjbi5qEx7utw@mail.gmail.com>
Subject: Re: [PATCH v4] sched/freq: move call to cpufreq_update_util
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Doug Smythies <dsmythies@telus.net>,
        Linux PM <linux-pm@vger.kernel.org>,
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

On Fri, Nov 15, 2019 at 10:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 14, 2019 at 06:07:31PM +0100, Vincent Guittot wrote:
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
>
> Doesn't this just show that a dumb rate limit in the driver is broken?
>
> > update_cfs_rq_load_avg() is only called by update_blocked_averages()
> > and update_load_avg() so we can move the call to
> > cfs_rq_util_change/cpufreq_update_util() into these 2 functions. It's also
> > interesting to notice that update_load_avg() already calls directly
> > cfs_rq_util_change() for !SMP case.
> >
> > This changes will also ensure that cpufreq_update_util() is called even
> > when there is no more CFS rq in the leaf_cfs_rq_list to update but only
> > irq, rt or dl pelt signals.
>
> I don't think it does that; that is, iirc the return value of
> ___update_load_sum() is 1 every time a period lapses. So even if the avg
> is 0 and doesn't change, it'll still return 1 on every period.
>
> Which is what that dumb rate-limit thing wants of course. But I'm still
> thinking that it's stupid to do. If nothing changes, don't generate
> events.
>
> If anything, update_blocked_avgerages() should look at
> @done/others_have_blocked() to emit events for rt,dl,irq.
>
> So why are we making the scheduler code more ugly instead of fixing that
> driver?

I guess we could "fix" the driver by making it rate limit MSR writes
only, but I'm not sure if that would help.
