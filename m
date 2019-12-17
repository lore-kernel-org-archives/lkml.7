Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C38C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976F620663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfLQM5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:57:40 -0500
Received: from foss.arm.com ([217.140.110.172]:36312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfLQM5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:57:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 661C131B;
        Tue, 17 Dec 2019 04:57:39 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 759FF3F719;
        Tue, 17 Dec 2019 04:57:37 -0800 (PST)
Subject: Re: [Patch v6 4/7] sched/fair: Enable periodic update of average
 thermal pressure
To:     Quentin Perret <qperret@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        ionela.voinescu@arm.com, vincent.guittot@linaro.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        amit.kucheria@verdurent.com
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
 <1576123908-12105-5-git-send-email-thara.gopinath@linaro.org>
 <20191216143932.GT2844@hirez.programming.kicks-ass.net>
 <20191216175901.GA157313@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <78b0f8a6-462b-acca-7682-f5269fea17c5@arm.com>
Date:   Tue, 17 Dec 2019 13:57:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216175901.GA157313@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2019 18:59, Quentin Perret wrote:
> On Monday 16 Dec 2019 at 15:39:32 (+0100), Peter Zijlstra wrote:
>>> @@ -10274,6 +10281,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>>>  
>>>  	update_misfit_status(curr, rq);
>>>  	update_overutilized_status(task_rq(curr));
>>> +	update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure);
>>>  }
>>
>> My objection here is that when the arch does not have support for it,
>> there is still code generated and runtime overhead associated with it.
> 
> I guess this function could be stubbed for CONFIG_CPU_THERMAL=n ?
> That is, reflecting the thermal pressure in the scheduler only makes
> sense when the thermal infrastructure is enabled to begin with (which is
> indeed not the case for most archs).

Makes sense to me. If we can agree that 'CPU cooling' is the only actor
for thermal (CPU capacity) capping.

thermal_sys-$(CONFIG_CPU_THERMAL)       += cpu_cooling.o
