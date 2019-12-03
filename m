Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B08C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E42720640
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfLCIhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 03:37:00 -0500
Received: from foss.arm.com ([217.140.110.172]:38948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfLCIhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 03:37:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 457F730E;
        Tue,  3 Dec 2019 00:36:59 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAAAE3F68E;
        Tue,  3 Dec 2019 00:40:05 -0800 (PST)
Date:   Tue, 3 Dec 2019 08:36:54 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        pavel@ucw.cz, dhaval.giani@oracle.com, qperret@qperret.net,
        David.Laight@ACULAB.COM, morten.rasmussen@arm.com, pjt@google.com,
        tj@kernel.org, dietmar.eggemann@arm.com, viresh.kumar@linaro.org,
        rafael.j.wysocki@intel.com, daniel.lezcano@linaro.org
Subject: Re: [RFC 1/3] Introduce latency-tolerance as an per-task attribute
Message-ID: <20191203083654.3ctttimdiujdt7tl@e107158-lin.cambridge.arm.com>
References: <20191125094618.30298-1-parth@linux.ibm.com>
 <20191125094618.30298-2-parth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191125094618.30298-2-parth@linux.ibm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/19 15:16, Parth Shah wrote:
> Latency-tolerance indicates the latency requirements of a task with respect
> to the other tasks in the system. The value of the attribute can be within
> the range of [-20, 19] both inclusive to be in-line with the values just
> like task nice values.
> 
> latency_tolerance = -20 indicates the task to have the least latency as
> compared to the tasks having latency_tolerance = +19.
> 
> The latency_tolerance may affect only the CFS SCHED_CLASS by getting
> latency requirements from the userspace.
> 
> Signed-off-by: Parth Shah <parth@linux.ibm.com>
> ---
>  include/linux/sched.h                   |  3 +++
>  include/linux/sched/latency_tolerance.h | 13 +++++++++++++
>  2 files changed, 16 insertions(+)
>  create mode 100644 include/linux/sched/latency_tolerance.h
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 2c2e56bd8913..bcc1c1d0856d 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -25,6 +25,7 @@
>  #include <linux/resource.h>
>  #include <linux/latencytop.h>
>  #include <linux/sched/prio.h>
> +#include <linux/sched/latency_tolerance.h>
>  #include <linux/sched/types.h>
>  #include <linux/signal_types.h>
>  #include <linux/mm_types_task.h>
> @@ -666,6 +667,8 @@ struct task_struct {
>  #endif
>  	int				on_rq;
>  
> +	int				latency_tolerance;
> +
>  	int				prio;
>  	int				static_prio;
>  	int				normal_prio;
> diff --git a/include/linux/sched/latency_tolerance.h b/include/linux/sched/latency_tolerance.h
> new file mode 100644
> index 000000000000..7a00abe05bc4
> --- /dev/null
> +++ b/include/linux/sched/latency_tolerance.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_SCHED_LATENCY_TOLERANCE_H
> +#define _LINUX_SCHED_LATENCY_TOLERANCE_H

nit: Add some description here explaining what latency tolerance is please. You
copy paste some text from your cover letter :)

--
Qais Youesf

> +
> +#define MAX_LATENCY_TOLERANCE	19
> +#define MIN_LATENCY_TOLERANCE	-20
> +
> +#define LATENCY_TOLERANCE_WIDTH	\
> +	(MAX_LATENCY_TOLERANCE - MIN_LATENCY_TOLERANCE + 1)
> +
> +#define DEFAULT_LATENCY_TOLERANCE	0
> +
> +#endif /* _LINUX_SCHED_LATENCY_TOLERANCE_H */
> -- 
> 2.17.2
> 
