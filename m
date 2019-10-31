Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03861CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D548E20873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfJaQMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:12:07 -0400
Received: from foss.arm.com ([217.140.110.172]:51240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfJaQMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:12:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E9171F1;
        Thu, 31 Oct 2019 09:12:06 -0700 (PDT)
Received: from [192.168.1.20] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97ED43F71E;
        Thu, 31 Oct 2019 09:12:04 -0700 (PDT)
Subject: Re: [Patch v4 3/6] sched/fair: Enable CFS periodic tick to update
 thermal pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-4-git-send-email-thara.gopinath@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <a303b61e-42f6-dfd7-264b-ead91da5f5ca@arm.com>
Date:   Thu, 31 Oct 2019 17:11:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571776465-29763-4-git-send-email-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.19 22:34, Thara Gopinath wrote:
> Introduce support in CFS periodic tick to trigger the process of
> computing average thermal pressure for a cpu.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  kernel/sched/fair.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 682a754..4f9c2cb 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -21,6 +21,7 @@
>   *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
>   */
>  #include "sched.h"
> +#include "thermal.h"
>  
>  #include <trace/events/sched.h>
>  
> @@ -7574,6 +7575,8 @@ static void update_blocked_averages(int cpu)
>  		done = false;
>  
>  	update_blocked_load_status(rq, !done);
> +
> +	trigger_thermal_pressure_average(rq);
>  	rq_unlock_irqrestore(rq, &rf);
>  }

Since you update the thermal pressure signal in CFS's
update_blocked_averages() as well, I guess the patch title has to change.

>  
> @@ -9933,6 +9936,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>  
>  	update_misfit_status(curr, rq);
>  	update_overutilized_status(task_rq(curr));
> +
> +	trigger_thermal_pressure_average(rq);
>  }
>  
>  /*
> 
