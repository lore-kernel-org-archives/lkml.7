Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACE2CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B81208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfJ3QrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 12:47:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:36424 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726626AbfJ3QrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:47:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6FEAEB3E2;
        Wed, 30 Oct 2019 16:47:16 +0000 (UTC)
Date:   Wed, 30 Oct 2019 16:47:14 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Make sched-idle cpu selection consistent
 throughout
Message-ID: <20191030164714.GH28938@suse.de>
References: <5eba2fb4af9ebc7396101bb9bd6c8aa9c8af0710.1571899508.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <5eba2fb4af9ebc7396101bb9bd6c8aa9c8af0710.1571899508.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 12:15:27PM +0530, Viresh Kumar wrote:
> There are instances where we keep searching for an idle CPU despite
> having a sched-idle cpu already (in find_idlest_group_cpu(),
> select_idle_smt() and select_idle_cpu() and then there are places where
> we don't necessarily do that and return a sched-idle cpu as soon as we
> find one (in select_idle_sibling()). This looks a bit inconsistent and
> it may be worth having the same policy everywhere.
> 

This needs supporting data. find_idlest_group_cpu is generally from
a fork() context where it's not particularly performance critical.
select_idle_sibling and the helpers it uses is wakeup context where is
is often much more critical to wake quickly than find the best CPU. The
biggest challenge of select_idle_sibling is making a "good enough decision"
quickly without disrupting cache but a fork-intensive workload making quick
decision can overload local domains requiring fixing by the load balancer.

> On the other hand, choosing a sched-idle cpu over a idle one shall be
> beneficial from performance point of view as well, as we don't need to
> get the cpu online from a deep idle state which is quite a time
> consuming process and delays the scheduling of the newly wakeup task.
> 
> This patch tries to simplify code around sched-idle cpu selection and
> make it consistent throughout.
> 
> FWIW, tests were done with the help of rt-app (8 SCHED_OTHER and 5
> SCHED_IDLE tasks, not bound to any cpu) on ARM platform (octa-core), and
> no significant difference in scheduling latency of SCHED_OTHER tasks was
> found.
> 

As the patch stands, I think a fork-intensive workload where each
process is doing small amounts of work will suffer from overloading
domains and have variable performance depending on how quickly the load
balancer reacts.

-- 
Mel Gorman
SUSE Labs
