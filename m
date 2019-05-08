Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563E9C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D4220989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfEHMl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 08:41:57 -0400
Received: from foss.arm.com ([217.140.101.70]:33116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbfEHMl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 08:41:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 127FB80D;
        Wed,  8 May 2019 05:41:56 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA5703F575;
        Wed,  8 May 2019 05:41:53 -0700 (PDT)
Date:   Wed, 8 May 2019 13:41:52 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH V2 1/3] Calculate Thermal Pressure
Message-ID: <20190508090547.4glnypolmiw3cun4@queper01-lin>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <1555443521-579-2-git-send-email-thara.gopinath@linaro.org>
 <20190425105658.q45cmfogrt6wwtih@queper01-ThinkPad-T460s>
 <CAKfTPtBvY3xiDt6tcqF7GoZki3VihD4Tz7E5ctE8hNaNzL6NPA@mail.gmail.com>
 <5CC31314.3070700@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5CC31314.3070700@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thara,

Sorry for the delayed response.

On Friday 26 Apr 2019 at 10:17:56 (-0400), Thara Gopinath wrote:
> On 04/25/2019 08:45 AM, Vincent Guittot wrote:
> > Do you mean calling a variant of sched_update_thermal_pressure() in
> > update_cpu_capacity() instead of periodic update ?
> > Yes , that should be enough
> 
> Hi,
> 
> I do have some concerns in doing this.
> 1. Updating thermal pressure does involve some calculations for
> accumulating, averaging, decaying etc which in turn could have some
> finite and measurable time spent in the function. I am not sure if this
> delay will be acceptable for all systems during load balancing (I have
> not measured the time involved). We need to decide if this is something
> we can live with.
> 
> 2. More importantly, since update can happen from at least two paths (
> thermal fw and periodic timer in case of this patch series)to ensure
> mutual exclusion,  the update is done under a spin lock. Again calling
> from update_cpu_capacity will involve holding the lock in the load
> balance path which is possible not for the best.
> For me, updating out of load balance minimizes the disruption to
> scheduler on the whole.
> 
> But if there is an over whelming support for updating the statistics
> from the LB , I can move the code.

If I try to clarify my point a little bit, my observation is really that
it's a shame to update the thermal stats often, but to not reflect that
in capacity_of().

So in fact there are two alternatives: 1) do the update only during LB
(which is what I suggested first) to avoid 'useless' work; or 2) reflect
the thermal pressure in the CPU capacity every time the thermal stats
are updated.

And thinking more about it, perhaps 2) is actually a better option? With
this we could try smaller decay periods than the LB interval (which is
most likely useless otherwise) and make sure the capacity considered
during wake-up is up-to-date. This should be a good thing for latency
sensitive tasks I think. (If you consider a task in the Android display
pipeline for example, it needs to run within 16ms or the frame is
missed. So, on wake-up, we'd like to know where the task can run fast
_now_, not according to the capacities the CPUs had 200ms ago or so).

Thoughts ?
Quentin
