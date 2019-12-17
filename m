Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A21C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968BA21775
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfLQMyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:54:21 -0500
Received: from foss.arm.com ([217.140.110.172]:36156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfLQMyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:54:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89F7C31B;
        Tue, 17 Dec 2019 04:54:20 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 920BF3F719;
        Tue, 17 Dec 2019 04:54:18 -0800 (PST)
Subject: Re: [Patch v6 1/7] sched/pelt.c: Add support to track thermal
 pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
 <1576123908-12105-2-git-send-email-thara.gopinath@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <cdaf2c1f-63bb-2430-c53a-f19a45035fc5@arm.com>
Date:   Tue, 17 Dec 2019 13:54:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576123908-12105-2-git-send-email-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2019 05:11, Thara Gopinath wrote:

minor: in subject: s/sched/pelt.c/sched/pelt

[...]

> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index a96db50..9aac3b7 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -353,6 +353,28 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
>  	return 0;
>  }
>  
> +/*
> + * thermal:
> + *
> + *   load_sum = \Sum se->avg.load_sum

Why not '\Sum rq->avg.load_sum' ?

> + *
> + *   util_avg and runnable_load_avg are not supported and meaningless.
> + *
> + */
> +int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
> +{
> +	if (___update_load_sum(now, &rq->avg_thermal,
> +			       capacity,
> +			       capacity,
> +			       capacity)) {
> +		___update_load_avg(&rq->avg_thermal, 1, 1);
> +		trace_pelt_thermal_tp(rq);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +

[...]
