Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF33C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16DAA2067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgAHPuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:50:04 -0500
Received: from foss.arm.com ([217.140.110.172]:46370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgAHPuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:50:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5806031B;
        Wed,  8 Jan 2020 07:50:03 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78B9D3F534;
        Wed,  8 Jan 2020 07:50:01 -0800 (PST)
Subject: Re: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v3
To:     Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Hillf Danton <hdanton@sina.com>, Rik van Riel <riel@surriel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Parth Shah <parth@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200106144250.GA3466@techsingularity.net>
 <04033a63f11a9c59ebd2b099355915e4e889b772.camel@surriel.com>
 <20200106163303.GC3466@techsingularity.net>
 <20200107015111.4836-1-hdanton@sina.com>
 <20200107091256.GE3466@techsingularity.net>
 <CAKfTPtAMeta=jtTkTewdFN1UyqT+iyRhm9pfNDjkydfJQjaorQ@mail.gmail.com>
 <20200107101646.GG3466@techsingularity.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <d0c556ee-0758-ee57-7264-f1e4c158ae54@arm.com>
Date:   Wed, 8 Jan 2020 15:49:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107101646.GG3466@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2020 10:16, Mel Gorman wrote:
> I think running tasks at least is the least bad metric. idle CPUs gets
> caught up in corner cases with bindings and util_avg can be skewed by
> outliers. Running tasks is a sensible starting point until there is a
> concrete use case that shows it is unworkable.

I'd tend to agree with you here. Also; this being in the group_has_spare
imbalance type we have some guarantees that the group is not overutilized.

If we keep some threshold of 'sum_nr_running < group_weight / 2', then this
"naturally" puts a hard limit of 50% total group utilization (corner case
where all tasks are 100% util).

> Lets see what you think of
> the other untested patch I posted that takes the group weight and child
> domain weight into account.
> 
