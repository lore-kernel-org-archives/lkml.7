Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E903C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F15F20640
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfLCIjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 03:39:21 -0500
Received: from foss.arm.com ([217.140.110.172]:39002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfLCIjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 03:39:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A954C30E;
        Tue,  3 Dec 2019 00:39:20 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EFAD3F68E;
        Tue,  3 Dec 2019 00:42:27 -0800 (PST)
Date:   Tue, 3 Dec 2019 08:39:16 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        pavel@ucw.cz, dhaval.giani@oracle.com, qperret@qperret.net,
        David.Laight@ACULAB.COM, morten.rasmussen@arm.com, pjt@google.com,
        tj@kernel.org, dietmar.eggemann@arm.com, viresh.kumar@linaro.org,
        rafael.j.wysocki@intel.com, daniel.lezcano@linaro.org
Subject: Re: [RFC 3/3] Allow sched_{get,set}attr to change latency_tolerance
 of the task
Message-ID: <20191203083915.yahl2qd3wnnkqxxs@e107158-lin.cambridge.arm.com>
References: <20191125094618.30298-1-parth@linux.ibm.com>
 <20191125094618.30298-4-parth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191125094618.30298-4-parth@linux.ibm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/19 15:16, Parth Shah wrote:
> Introduce the latency_tolerance attribute to sched_attr and provide a
> mechanism to change the value with the use of sched_setattr/sched_getattr
> syscall.
> 
> Also add new flag "SCHED_FLAG_LATENCY_TOLERANCE" to hint the change in
> latency_tolerance of the task on every sched_setattr syscall.
> 
> Signed-off-by: Parth Shah <parth@linux.ibm.com>
> ---
>  include/uapi/linux/sched.h       |  4 +++-
>  include/uapi/linux/sched/types.h |  2 ++
>  kernel/sched/core.c              | 15 +++++++++++++++
>  kernel/sched/sched.h             |  1 +
>  4 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> index b3105ac1381a..73db430d11b6 100644
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -71,6 +71,7 @@ struct clone_args {
>  #define SCHED_FLAG_KEEP_PARAMS		0x10
>  #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
>  #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
> +#define SCHED_FLAG_LATENCY_TOLERANCE	0x80
>  
>  #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
>  				 SCHED_FLAG_KEEP_PARAMS)
> @@ -82,6 +83,7 @@ struct clone_args {
>  			 SCHED_FLAG_RECLAIM		| \
>  			 SCHED_FLAG_DL_OVERRUN		| \
>  			 SCHED_FLAG_KEEP_ALL		| \
> -			 SCHED_FLAG_UTIL_CLAMP)
> +			 SCHED_FLAG_UTIL_CLAMP		| \
> +			 SCHED_FLAG_LATENCY_TOLERANCE)
>  
>  #endif /* _UAPI_LINUX_SCHED_H */
> diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
> index c852153ddb0d..960774ac0c70 100644
> --- a/include/uapi/linux/sched/types.h
> +++ b/include/uapi/linux/sched/types.h
> @@ -118,6 +118,8 @@ struct sched_attr {
>  	__u32 sched_util_min;
>  	__u32 sched_util_max;
>  
> +	/* latency requirement hints */
> +	__s32 sched_latency_tolerance;
>  };
>  
>  #endif /* _UAPI_LINUX_SCHED_TYPES_H */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ea7abbf5c1bb..dfd36ec14404 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4695,6 +4695,9 @@ static void __setscheduler_params(struct task_struct *p,
>  	p->rt_priority = attr->sched_priority;
>  	p->normal_prio = normal_prio(p);
>  	set_load_weight(p, true);
> +
> +	/* Change latency tolerance of the task if !SCHED_FLAG_KEEP_PARAMS */
> +	p->latency_tolerance = attr->sched_latency_tolerance;
>  }
>  
>  /* Actually do priority change: must hold pi & rq lock. */
> @@ -4852,6 +4855,13 @@ static int __sched_setscheduler(struct task_struct *p,
>  			return retval;
>  	}
>  
> +	if (attr->sched_flags & SCHED_FLAG_LATENCY_TOLERANCE) {
> +		if (attr->sched_latency_tolerance > MAX_LATENCY_TOLERANCE)
> +			return -EINVAL;
> +		if (attr->sched_latency_tolerance < MIN_LATENCY_TOLERANCE)
> +			return -EINVAL;
> +	}
> +
>  	if (pi)
>  		cpuset_read_lock();
>  
> @@ -4886,6 +4896,9 @@ static int __sched_setscheduler(struct task_struct *p,
>  			goto change;
>  		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
>  			goto change;
> +		if (attr->sched_flags & SCHED_FLAG_LATENCY_TOLERANCE &&
> +		    attr->sched_latency_tolerance != p->latency_tolerance)
> +			goto change;
>  
>  		p->sched_reset_on_fork = reset_on_fork;
>  		retval = 0;
> @@ -5392,6 +5405,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
>  	else
>  		kattr.sched_nice = task_nice(p);
>  
> +	kattr.sched_latency_tolerance = p->latency_tolerance;
> +
>  #ifdef CONFIG_UCLAMP_TASK
>  	kattr.sched_util_min = p->uclamp_req[UCLAMP_MIN].value;
>  	kattr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 0db2c1b3361e..bb181175954b 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -21,6 +21,7 @@
>  #include <linux/sched/nohz.h>
>  #include <linux/sched/numa_balancing.h>
>  #include <linux/sched/prio.h>
> +#include <linux/sched/latency_tolerance.h>

nit: keep in alphabatical order.

The series looks good to me except for the 2 minor nits. Thanks for taking care
of this!

Reviewed-by: Qais Yousef <qais.yousef@arm.com>

Cheers

--
Qais Yousef

>  #include <linux/sched/rt.h>
>  #include <linux/sched/signal.h>
>  #include <linux/sched/smt.h>
> -- 
> 2.17.2
> 
