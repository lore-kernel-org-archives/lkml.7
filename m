Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0461BC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12BA21848
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LxPXKLv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbfKHRBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:01:35 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46181 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfKHRBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:01:34 -0500
Received: by mail-lf1-f65.google.com with SMTP id o65so1314146lff.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 09:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sPByM4E4nRVwqVwMn5+6EUhkW7lmoHRAODhko03iOFw=;
        b=LxPXKLv5wTnE3FbEAhjS6DbVUO02mUYiy22/SuNjZGuxzZP0r+OrIs1eEYY1DHZgdK
         A+KHFg6kxmyGiwRPstfOYgyH9fwTLTLC/r8YrshhNF8oi6Vkh1HvxATlJu6kNq1zLvx+
         +dSuzg8gCNWcC+0m0F9o5A1k5/VwmEDB1sPVsqkbuemEJesHbTRGlg/Si+JfGF4qltpB
         d2YDy554BJ8MPmVRSds0igSBP9iQXZ06J1bOeKJ8E5FG8ukAfGyv+IJL+al0GzzJSRJE
         15NYCmT5pROffmnnoDskFZIk9l4m4nHQtFm70jAD9T7l/uuZMKrUjrXPYXWCUq6o369L
         1L6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPByM4E4nRVwqVwMn5+6EUhkW7lmoHRAODhko03iOFw=;
        b=lR+bWSosaclU8WQR/k9BxLFCCnDydNlkrasu82kQzAgm2F5uRGr0AO5/BHcpIK9iDZ
         nMg53nMLbHabyJn+/0MJVFMFEDzrCP9DPBoygNsfxh0x5go7F1TOb3NHkUX6/o4EXU7B
         XLnzBMX6ChtuQ6GZyC6hbw7vFsI68cKz/sBWufH79gDL2eJF7jHcyebriTNFU5rvoip8
         vJ4LRBrajATrhQhIx5/yDE8Lx4879+o+v4zss5Y9qGydJmSX8QGXzZETkxBjvUMLPMOx
         8no7axIf0m5e1Gp+H65RW82otzwOgDqPC7HGXTN3b4DhgfPoyKsVkB8cOeQy5njvqieZ
         2x4Q==
X-Gm-Message-State: APjAAAWbWxcS5AHhhhYkLrHCZ77Umr6F2eclA6Q4oExAskJcRp/C8a4W
        lYzbFql6oDcxWjf/DJaQcAV6uwwZwmL03fwoB9K0NWGm
X-Google-Smtp-Source: APXvYqx0G2ltcudbvhEQ7ROsD23rkgADedxvnYuCIBL2ReDxbHKGQz7mrL6vXN/IDFLvLAAm54HmzUx+qZSQQI2Jwy0=
X-Received: by 2002:ac2:5589:: with SMTP id v9mr2209082lfg.32.1573232491299;
 Fri, 08 Nov 2019 09:01:31 -0800 (PST)
MIME-Version: 1.0
References: <5eba2fb4af9ebc7396101bb9bd6c8aa9c8af0710.1571899508.git.viresh.kumar@linaro.org>
 <20191030164714.GH28938@suse.de> <20191108113156.y555y4se2mshv7in@vireshk-i7>
In-Reply-To: <20191108113156.y555y4se2mshv7in@vireshk-i7>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 8 Nov 2019 18:01:19 +0100
Message-ID: <CAKfTPtDraLuk7Cu0scLQBdcPh2CaK8CdSuGUzYFNACNEao-mvQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Make sched-idle cpu selection consistent throughout
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2019 at 12:32, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 30-10-19, 16:47, Mel Gorman wrote:
> > On Thu, Oct 24, 2019 at 12:15:27PM +0530, Viresh Kumar wrote:
> > > There are instances where we keep searching for an idle CPU despite
> > > having a sched-idle cpu already (in find_idlest_group_cpu(),
> > > select_idle_smt() and select_idle_cpu() and then there are places where
> > > we don't necessarily do that and return a sched-idle cpu as soon as we
> > > find one (in select_idle_sibling()). This looks a bit inconsistent and
> > > it may be worth having the same policy everywhere.
> > >
> >
> > This needs supporting data.
>
> I did some more interesting tests with rt-app. It was getting
> difficult to generate the correct numbers with normal use cases as
> most of the time prev/target/etc CPUs were found to be completely idle
> and the task was getting placed there in all the cases and so no diff
> with sched-idle changes.
>
> To prove the point I was making (that we can reduce task latency with
> SCHED_IDLE), I created 3 different tests on my hikey board (octa-core,
> 2 clusters, 0-3 and 4-7). The cpufreq governor was set to performance
> to avoid any side affects from CPU frequency.
>
> Test 1: 1-cfs-task:
>
> A single SCHED_NORMAL task is pinned to CPU5 which runs for 2333 us
> out of 7777 us (so gives time for the cluster to go in deep idle
> state).
>
> Test 2: 1-cfs-1-idle-task:
>
> A single SCHED_NORMAL task is pinned on CPU5 and single SCHED_IDLE
> task is pinned on CPU6 (to make sure cluster 1 doesn't go in deep idle
> state).
>
> Test 3: 1-cfs-8-idle-task:
>
> A single SCHED_NORMAL task is pinned on CPU5 and eight SCHED_IDLE
> tasks are created which run forever (not pinned anywhere, so they run
> on all CPUs). Checked with kernelshark that as soon as NORMAL task
> sleeps, the SCHED_IDLE task starts running on CPU5.
>
> And here are the results on mean latency (in us), using the "st" tool.
>
> $ st 1-cfs-task/rt-app-cfs_thread-0.log
> N       min     max     sum     mean    stddev
> 642     90      592     197180  307.134 109.906
>
> $ st 1-cfs-1-idle-task/rt-app-cfs_thread-0.log
> N       min     max     sum     mean    stddev
> 642     67      311     113850  177.336 41.4251
>
> $ st 1-cfs-8-idle-task/rt-app-cfs_thread-0.log
> N       min     max     sum     mean    stddev
> 643     29      173     41364   64.3297 13.2344
>
>
> The mean latency when:
> - we need to wakeup from deep idle state is 307 us
> - we need to wakeup from shallow idle state is 177 us
> - we need to preempt a SCHED_IDLE task is 64 us
>
> So the theory looks correct, we should probably prefer SCHED_IDLE CPUs
> both for power and performance :)
>
> > find_idlest_group_cpu is generally from
> > a fork() context where it's not particularly performance critical.
> > select_idle_sibling and the helpers it uses is wakeup context where is
> > is often much more critical to wake quickly than find the best CPU.
>
> I agree. We must find the best CPU here. But won't a SCHED_IDLE cpu be
> the best ? After all that is the one in shallowest idle state and so
> better for power :)

It makes sense to me to consider a CPU that runs only SCHED_IDLE task
as an idle CPU with shortest latency and most recently idled
timestamp. This seems to be confirmed be the data above.
The SCHED_IDLE tasks would be somewhat penalized because they can now
be preempted whereas there is a real idle CPU but such  SCHED_IDLE
task don't have any other requirements than not delaying NORMAL task
wakeup
Also this simplifies and shortens the search loop.


>
> --
> viresh
