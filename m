Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99550C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75654217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388000AbfJNQQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:16:06 -0400
Received: from foss.arm.com ([217.140.110.172]:48102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729977AbfJNQQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:16:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35BAD28;
        Mon, 14 Oct 2019 09:16:05 -0700 (PDT)
Received: from [10.1.195.43] (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1FF73F718;
        Mon, 14 Oct 2019 09:16:03 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: util_est: fast ramp-up EWMA on utilization
 increases
To:     Peter Zijlstra <peterz@infradead.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
References: <20190620150555.15717-1-patrick.bellasi@arm.com>
 <CAKfTPtDTfyBvfwE6_gtjxJoPNS6YGQ7rrLcjg_M-jr=YSc+FNA@mail.gmail.com>
 <20190628100751.lpcwsouacsi2swkm@e110439-lin>
 <20190628123800.GS3419@hirez.programming.kicks-ass.net>
 <20190628140057.7aujh2wsk7wtqib3@e110439-lin>
 <20190802094725.ploqfarz7fj7vrtp@e110439-lin>
 <20191014145218.GI2328@hirez.programming.kicks-ass.net>
From:   Douglas Raillard <douglas.raillard@arm.com>
Organization: ARM
Message-ID: <48adc956-77a4-e293-29d9-cd8b82a40ae8@arm.com>
Date:   Mon, 14 Oct 2019 17:16:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191014145218.GI2328@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 10/14/19 3:52 PM, Peter Zijlstra wrote:
> 
> The energy aware schedutil patches remimded me this was still pending.
> 
> On Fri, Aug 02, 2019 at 10:47:25AM +0100, Patrick Bellasi wrote:
>> Hi Peter, Vincent,
>> is there anything different I can do on this?
> 
> I think both Vincent and me are basically fine with the patch, it was
> the Changelog/explanation for it that sat uneasy.
> 
> Specifically I think the 'confusion' around the PELT invariance stuff
> doesn't help.
> 
> I think that if you present it simply as making util_est directly follow
> upward motion and only decay on downward -- and the rationale for it --
> then it should be fine.

random idea: Since these things are much easier to understand by looking at a graph
of util over time, we may agree on some mailing-list-friendly way to convey graphs.
For example, a simple CSV with:
* before/after delimiters (line of # or =)
* graph title
* one point per signal transition, so that it can be plotted with gnuplot style "steps" or matplotlib drawstyle='steps-post'
* consistent column names:
    - time: in seconds (scientific notation for nanoseconds)
    - activation: 1 when the task is actually running, 0 otherwise
     (so it can be turned into transparent coloured bands like using gnuplot filledcurves, like in [1])
    - util: util_avg of the task being talked about

The delimiters allow writing a scripts to render graphs directly out of an mbox file or ML archive URL.
This won't solve the issue for the commit message itself, but that may ease the ML discussions.

[1] https://lisa-linux-integrated-system-analysis.readthedocs.io/en/master/trace_analysis.html#lisa.analysis.tasks.TasksAnalysis.plot_task_activation

Cheers,
Douglas
