Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE7CC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFDE20880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbfHELBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:01:20 -0400
Received: from foss.arm.com ([217.140.110.172]:46100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbfHELBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:01:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FA52344;
        Mon,  5 Aug 2019 04:01:19 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D206E3F694;
        Mon,  5 Aug 2019 04:01:17 -0700 (PDT)
Subject: Re: [PATCH v3] sched/fair: use utilization to select misfit task
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com
References: <1564670424-26023-9-git-send-email-vincent.guittot@linaro.org>
 <1564750572-20251-1-git-send-email-vincent.guittot@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <bd755dd1-0326-e0e0-6730-a41ba46bbd6e@arm.com>
Date:   Mon, 5 Aug 2019 12:01:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1564750572-20251-1-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2019 13:56, Vincent Guittot wrote:
> utilization is used to detect a misfit task but the load is then used to
> select the task on the CPU which can lead to select a small task with
> high weight instead of the task that triggered the misfit migration.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> Keep tracking load instead of utilization but check that 
> task doesn't fit CPU's capacity when selecting the task to detach as
> suggested by Valentin 
> 
>  kernel/sched/fair.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 53e64a7..8496118 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7487,15 +7487,9 @@ static int detach_tasks(struct lb_env *env)
>  			break;
>  
>  		case migrate_misfit:
> -			load = task_h_load(p);
> -
> -			/*
> -			 * utilization of misfit task might decrease a bit
> -			 * since it has been recorded. Be conservative in the
> -			 * condition.
> -			 */
> -			if (load < env->imbalance)
> -				goto next;
> +			/* This is not a misfit task */
> +                       if (task_fits_capacity(p, capacity_of(env->src_cpu)))
   ^^^^^^^^^^^^^^^^^^^^^^^
Just noticed those are spaces for some reason (I think my original diff is
to blame)

> +			       goto next;
>  
>  			env->imbalance = 0;
>  			break;
> 
