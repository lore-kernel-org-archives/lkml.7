Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B939C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F90207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfLDKlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 05:41:16 -0500
Received: from foss.arm.com ([217.140.110.172]:54162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727446AbfLDKlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:41:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C8601FB;
        Wed,  4 Dec 2019 02:41:15 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 045723F52E;
        Wed,  4 Dec 2019 02:41:13 -0800 (PST)
Subject: Re: Null pointer crash at find_idlest_group on db845c w/ linus/master
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Qais Yousef <qais.yousef@arm.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <CALAqxLXrWWnWi32BR1F8JOtrGt1y2Kzj__zWopLx1ZfRy3EZKA@mail.gmail.com>
 <CAKfTPtAvnLY3brp9iy_aHNu0rMM8nLfgeLc3CXEkMk3bwU1weA@mail.gmail.com>
 <20191204094216.u7yld5r3zelp22lf@e107158-lin.cambridge.arm.com>
 <20191204100925.GA15727@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <629cca09-dde7-5d77-42e1-c68f2c1820d2@arm.com>
Date:   Wed, 4 Dec 2019 10:41:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191204100925.GA15727@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2019 10:09, Vincent Guittot wrote:
> Now, we test that a group has at least one allowed CPU for the task so we
> could skip the local group with the correct/wrong p->cpus_ptr
> 
> The path is used for fork/exec ibut also for wakeup path for b.L when the task doesn't fit in the CPUs
> 
> So we can probably imagine a scenario where we change task affinity while
> sleeping. If the wakeup happens on a CPU that belongs to the group that is not
> allowed, we can imagine that we skip the local_group
> 

Shoot, I think you're right. If it is the local group that is NULL, then
we most likely splat on:

		if (local->sgc->max_capacity >= idlest->sgc->max_capacity)
			return NULL;

We don't splat before because we just use local_sgs, which is uninitialized
but on the stack.

Also; does it really have to involve an affinity "race"? AFAIU affinity
could have been changed a while back, but the waking CPU isn't allowed
so we skip the local_group (in simpler cases where each CPU is a group).


