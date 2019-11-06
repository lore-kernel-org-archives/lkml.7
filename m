Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB21C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237CB2173E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbfKFQ4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:56:53 -0500
Received: from foss.arm.com ([217.140.110.172]:43158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732201AbfKFQ4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:56:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 375C746A;
        Wed,  6 Nov 2019 08:56:52 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CC9B3F719;
        Wed,  6 Nov 2019 08:56:50 -0800 (PST)
Date:   Wed, 6 Nov 2019 16:56:48 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [Patch v5 4/6] sched/fair: update cpu_capcity to reflect thermal
 pressure
Message-ID: <20191106165646.vc7j4hbhj2hcrku4@e107158-lin.cambridge.arm.com>
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
 <1572979786-20361-5-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1572979786-20361-5-git-send-email-thara.gopinath@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/19 13:49, Thara Gopinath wrote:
> cpu_capacity relflects the maximum available capacity of a cpu. Thermal
> pressure on a cpu means this maximum available capacity is reduced. This
> patch reduces the average thermal pressure for a cpu from its maximum
> available capacity so that cpu_capacity reflects the actual
> available capacity.
> 
> Other signals that are deducted from cpu_capacity to reflect the actual
> capacity available are rt and dl util_avg. util_avg tracks a binary signal
> and uses the weights 1024 and 0. Whereas thermal pressure is tracked
> using load_avg. load_avg uses the actual "delta" capacity as the weight.

I think you intended to put this as comment...

> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  kernel/sched/fair.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9fb0494..5f6c371 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7738,6 +7738,7 @@ static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
>  
>  	used = READ_ONCE(rq->avg_rt.util_avg);
>  	used += READ_ONCE(rq->avg_dl.util_avg);
> +	used += READ_ONCE(rq->avg_thermal.load_avg);

... here?

I find the explanation hard to parse too. Do you think you can rephrase it?
Something based on what you wrote here would be more understandable IMHO:
https://lore.kernel.org/lkml/5DBB05BC.40502@linaro.org/


Thanks!

--
Qais Yousef

>  
>  	if (unlikely(used >= max))
>  		return 1;
> -- 
> 2.1.4
> 
