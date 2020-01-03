Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE72C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A5A206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgACQjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 11:39:12 -0500
Received: from foss.arm.com ([217.140.110.172]:56784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgACQjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 11:39:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4E77328;
        Fri,  3 Jan 2020 08:39:10 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 421583F703;
        Fri,  3 Jan 2020 08:39:09 -0800 (PST)
Subject: Re: [PATCH v4 00/10] sched/fair: rework the CFS load balance
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, hdanton@sina.com, parth@linux.ibm.com,
        riel@surriel.com
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <e33e1896-01e1-665d-862a-e73384b0fbe6@arm.com>
Message-ID: <48636730-f8fb-6c65-fc30-068345923bc1@arm.com>
Date:   Fri, 3 Jan 2020 16:39:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e33e1896-01e1-665d-862a-e73384b0fbe6@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2019 12:48, Valentin Schneider wrote:
> I've been busy trying to get some perf numbers on arm64 server~ish systems,
> I finally managed to get some specjbb numbers on TX2 (the 2 nodes, 224
> CPUs version which I suspect is the same as you used in the above). I only
> have a limited number of iterations (5, although each runs for about 2h)
> because I wanted to get some (usable) results by today, I'll spin some more
> during the week.
> 
> 
> This is based on the "critical-jOPs" metric which AFAIU higher is better:
> 
> Baseline, SMTOFF:
>   mean     12156.400000
>   std        660.640068
>   min      11016.000000
>   25%      12158.000000
>   50%      12464.000000
>   75%      12521.000000
>   max      12623.000000
> 
> Patches (+ find_idlest_group() fixup), SMTOFF:
>   mean     12487.250000
>   std        184.404221
>   min      12326.000000
>   25%      12349.250000
>   50%      12449.500000
>   75%      12587.500000
>   max      12724.000000	
> 
> 
> It looks slightly better overall (mean, stddev), but I'm annoyed by that
> low iteration count. I also had some issues with my SMTON run and I only
> got numbers for 2 iterations, so I'll respin that before complaining.
> 
> FWIW the branch I've been using is:
> 
>   http://www.linux-arm.org/git?p=linux-vs.git;a=shortlog;h=refs/heads/mainline/load-balance/vincent_rework/tip
> 

Forgot about that; I got some more results in the meantime, still specjbb
and still ThunderX2):

| kernel          | count |         mean |        std |     min |     50% |      75% |      99% |     max |
|-----------------+-------+--------------+------------+---------+---------+----------+----------+---------|
| -REWORK SMT-ON  |    15 | 19961.133333 | 613.406515 | 19058.0 | 20006.0 | 20427.50 | 20903.42 | 20924.0 |
| +REWORK SMT-ON  |    12 | 19265.666667 | 563.959917 | 18380.0 | 19133.5 | 19699.25 | 20024.90 | 20026.0 |
| -REWORK SMT-OFF |    25 | 12397.000000 | 425.763628 | 11016.0 | 12377.0 | 12623.00 | 13137.20 | 13154.0 |
| +REWORK SMT-OFF |    20 | 12436.700000 | 414.130554 | 11313.0 | 12505.0 | 12687.00 | 12981.44 | 12986.0 |

SMT-ON  delta: -3.48%
SMT-OFF delta: +0.32%


This is consistent with some earlier runs (where I had a few issues
getting enough iterations): SMT-OFF performs a tad better, and SMT-ON
performs slightly worse.

Looking at the 99th percentile, it seems we're a bit worse compared to
the previous best cases, but looking at the slightly reduced stddev it also
seems that we are somewhat more consistent.
