Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3E3C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73623206D3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kVXlSMbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfKONbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 08:31:13 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37791 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfKONbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:31:12 -0500
Received: by mail-lj1-f196.google.com with SMTP id d5so10710575ljl.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 05:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=owEif5DDsGmkWrR2bOQw0Tu37BwJ/6VDJnctQZE/unk=;
        b=kVXlSMbmuvfa6FG0LateKEQ8kOMXjev2umGtggRjItX/o8etXqQMax/aVi5gUlo+SJ
         LWvE7FPtiv+s24wL/wTvYFq4Jjf1yf9P22MRdFv/PlPYtgsy2Jz76FaVtQmML/ROLYXR
         p40inBGxQBWyA+RIs5EEHEn6N8Ti2GI693f3tsZWC+o5UkQKJbMqqKYRkCP5U0r/RrW4
         Cm12rI/2NR/iZvXtDdvj/fGarTHEeYUl1emjCsCNh+yRG7y9TEebqqBtcnqJPSDa1s+F
         Rus3CalX7cR+p34jr7CNWa1X+v6iM7kU4LLM/K+oQR4wM3bghgJAwED4+avyRZE33c5j
         g5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owEif5DDsGmkWrR2bOQw0Tu37BwJ/6VDJnctQZE/unk=;
        b=eQqy183xjvHbOKk5n8hdj1QV440U4vQzDfTduEPtpdEhYAns7hfFm7Xf4o89cbHp2d
         0hz600mG9hRJIfWckrMmdRsT8ebM/1PVWdyV0h2xLUYDYmBqn2zCqfLyNKPbWWlp0D0p
         EohlXP7tS54He4+/OqQkQplkPzgwCOgewTqtYwiM5YUqBBKLLs1s0DflpH8kRck2In8p
         a8HnMUo4APgYPWSaqCQr3z2IiyV7or1KMzzo1DtRI3PKfTaZp84ddM8OHrko77LtMovl
         8PDq7X2Q4SNgGuJd/LC0l7bvtigqV12EkTX3HDZHo+vuEHjjE9HQVgmEBDWmaLFwGbQn
         JB0g==
X-Gm-Message-State: APjAAAVgoy59gGaim/HeLfk8NBZS1JOwAORy8cSvCDMi3X9QGRJxinnX
        Q5Uvaxnv3U7pyNbzZdrkHCaFB4YWSZ0VQEw/zP0m2SoD
X-Google-Smtp-Source: APXvYqwtqVZeOXU64f92wrWYkjlLPEKeNLzTiyg+ktWVv5LriIzng8KsjJMvxs4khm75rv2g02zmafkT3/7U0RidtbI=
X-Received: by 2002:a2e:9748:: with SMTP id f8mr9922879ljj.87.1573824670486;
 Fri, 15 Nov 2019 05:31:10 -0800 (PST)
MIME-Version: 1.0
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
 <20191115095447.GU4114@hirez.programming.kicks-ass.net> <CAKfTPtCTcrq1E1H8A3TL1xvALUrQ7ybPoERJ+C2O2+QXpVEZGQ@mail.gmail.com>
 <20191115103735.GE4131@hirez.programming.kicks-ass.net> <CAKfTPtDi_-h6g+rhV04XXjqpWprC2vT6hgLZSrTW5rdD54PrQA@mail.gmail.com>
 <20191115105110.GG4131@hirez.programming.kicks-ass.net> <CAKfTPtC3g4iCxvAJo9Km9fZ0fPSw5Jt9TY2+xF7kxGmOZ66gxw@mail.gmail.com>
 <20191115130144.GA4097@hirez.programming.kicks-ass.net>
In-Reply-To: <20191115130144.GA4097@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Nov 2019 14:30:58 +0100
Message-ID: <CAKfTPtBrxqkoFeWkxX1J1QmhBpRfDh6nYs1wRA-WR8y15AmaYQ@mail.gmail.com>
Subject: Re: [PATCH v4] sched/freq: move call to cpufreq_update_util
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 at 14:02, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 15, 2019 at 12:03:31PM +0100, Vincent Guittot wrote:
>
> > This patch does 2 things:
> > - fix the spurious call to cpufreq just before attaching a task
>
> Right, so that one doesn't concern me too much.
>
> > - make sure cpufreq is still called when cfs is 0 but not irq/rt or dl
>
> But per the rq->has_blocked_load logic we would mostly stop sending
> events once we reach all 0s.
>
> Now, most of those updates will be through _nohz_idle_balance() ->
> update_nohz_stats(), which are remote, which means intel_pstate is
> ignoring them anyway.
>
> Now the _nohz_idle_balance() -> update_blocked_averages() thing runs
> local, and that will update the one random idle CPU we picked to run
> nohz balance, but all others will be left where they were.
>
> So why does intel_pstate care... Esp. on SKL+ with per-core P state this
> is of dubious value.

Doug mentioned some periodic timers that were running on the CPUs

>
> Also, and maybe I should go read back, why do we care what the P state
> is when we're mostly in C states anyway? These are all idle CPUs,
> otherwise we wouldkn't be running update_blocked_averages() on them
> anyway.

AFAIU, there is not 100% idle but they have periodic timers that will
fire and run at higher P state


>
>
> Much confusion..
