Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93E5C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DEFD20693
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732373AbfIEKUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:20:02 -0400
Received: from foss.arm.com ([217.140.110.172]:41194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfIEKUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:20:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C02601576;
        Thu,  5 Sep 2019 03:20:01 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16F353F718;
        Thu,  5 Sep 2019 03:19:59 -0700 (PDT)
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com> <20190830174944.21741-5-subhra.mazumdar@oracle.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     subhra mazumdar <subhra.mazumdar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, tglx@linutronix.de, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        tim.c.chen@linux.intel.com, mgorman@techsingularity.net,
        parth@linux.ibm.com
Subject: Re: [RFC PATCH 4/9] sched: SIS_CORE to disable idle core search
In-reply-to: <20190830174944.21741-5-subhra.mazumdar@oracle.com>
Date:   Thu, 05 Sep 2019 11:19:57 +0100
Message-ID: <87lfv32gfm.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Aug 30, 2019 at 18:49:39 +0100, subhra mazumdar wrote...

> Use SIS_CORE to disable idle core search. For some workloads
> select_idle_core becomes a scalability bottleneck, removing it improves
> throughput. Also there are workloads where disabling it can hurt latency,
> so need to have an option.
>
> Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
> ---
>  kernel/sched/fair.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c31082d..23ec9c6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6268,9 +6268,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	if (!sd)
>  		return target;
>  
> -	i = select_idle_core(p, sd, target);
> -	if ((unsigned)i < nr_cpumask_bits)
> -		return i;
> +	if (sched_feat(SIS_CORE)) {
> +		i = select_idle_core(p, sd, target);
> +		if ((unsigned)i < nr_cpumask_bits)
> +			return i;
> +	}
>  
>  	i = select_idle_cpu(p, sd, target);
>  	if ((unsigned)i < nr_cpumask_bits)

This looks like should be squashed with the previous one, or whatever
code you'll add to define when this "biasing" is to be used or not.

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
