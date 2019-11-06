Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DD7C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5BC21848
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbfKFMuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 07:50:25 -0500
Received: from foss.arm.com ([217.140.110.172]:39308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbfKFMuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 07:50:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CCA47A7;
        Wed,  6 Nov 2019 04:50:24 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C6213F6C4;
        Wed,  6 Nov 2019 04:50:22 -0800 (PST)
Subject: Re: [Patch v5 1/6] sched/pelt.c: Add support to track thermal
 pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
 <1572979786-20361-2-git-send-email-thara.gopinath@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <6e2b2a11-834d-a0ee-a386-1edc624a8050@arm.com>
Date:   Wed, 6 Nov 2019 13:50:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1572979786-20361-2-git-send-email-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2019 19:49, Thara Gopinath wrote:
> Extrapolating on the exisiting framework to track rt/dl utilization using

s/exisiting/existing

> pelt signals, add a similar mechanism to track thermal pressure. The
> difference here from rt/dl utilization tracking is that, instead of
> tracking time spent by a cpu running a rt/dl task through util_avg,
> the average thermal pressure is tracked through load_avg. This is
> because thermal pressure signal is weighted "delta" capacity
> and is not binary(util_avg is binary). "delta capacity" here
> means delta between the actual capacity of a cpu and the decreased
> capacity a cpu due to a thermal event.
> In order to track average thermal pressure, a new sched_avg variable
> avg_thermal is introduced. Function update_thermal_load_avg can be called
> to do the periodic bookeeping (accumulate, decay and average)

s/bookeeping/bookkeeping

> of the thermal pressure.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  kernel/sched/pelt.c  | 13 +++++++++++++
>  kernel/sched/pelt.h  |  7 +++++++
>  kernel/sched/sched.h |  1 +
>  3 files changed, 21 insertions(+)
> 
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index a96db50..3821069 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -353,6 +353,19 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
>  	return 0;
>  }

Minor thing: There are function headers for rt_rq, dl_rq and irq. rt_rq
even explains that 'load_avg and runnable_load_avg are not supported and
meaningless.' Could you do something similar for thermal here? It's not
self-explanatory why we track load_avg, runnable_load_avg and util_avg
for thermal but only use load_avg.

> +int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
> +{
> +	if (___update_load_sum(now, &rq->avg_thermal,
> +			       capacity,
> +			       capacity,
> +			       capacity)) {
> +		___update_load_avg(&rq->avg_thermal, 1, 1);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +

[...]
