Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F64CC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 08:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A109208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 08:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfEJIvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 04:51:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40064 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfEJIvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 04:51:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1BDCA78;
        Fri, 10 May 2019 01:51:22 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0D053F575;
        Fri, 10 May 2019 01:51:18 -0700 (PDT)
Subject: Re: [PATCH 4/7] sched: Add sched_load_rq tracepoint
To:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
References: <20190505115732.9844-1-qais.yousef@arm.com>
 <20190505115732.9844-5-qais.yousef@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <4971629f-70d2-9ee1-7509-5d0cfe9004ff@arm.com>
Date:   Fri, 10 May 2019 10:51:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190505115732.9844-5-qais.yousef@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On 5/5/19 1:57 PM, Qais Yousef wrote:

[...]

> diff --git a/kernel/sched/sched_tracepoints.h b/kernel/sched/sched_tracepoints.h
> new file mode 100644
> index 000000000000..f4ded705118e
> --- /dev/null
> +++ b/kernel/sched/sched_tracepoints.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Scheduler tracepoints that are probe-able only and aren't exported ABI in
> + * tracefs.
> + */
> +
> +#include <trace/events/sched.h>
> +
> +#define SCHED_TP_PATH_LEN		64
> +
> +
> +static __always_inline void sched_tp_load_cfs_rq(struct cfs_rq *cfs_rq)
> +{
> +	if (trace_sched_load_rq_enabled()) {
> +		int cpu = cpu_of(rq_of(cfs_rq));
> +		char path[SCHED_TP_PATH_LEN];
> +
> +		cfs_rq_tg_path(cfs_rq, path, SCHED_TP_PATH_LEN);
> +		trace_sched_load_rq(cpu, path, &cfs_rq->avg);

This will let a !CONFIG_SMP build fail.

> +	}
> +}
> +
> +static __always_inline void sched_tp_load_rt_rq(struct rq *rq)
> +{
> +	if (trace_sched_load_rq_enabled()) {
> +		int cpu = cpu_of(rq);
> +
> +		trace_sched_load_rq(cpu, NULL, &rq->avg_rt);

Same here.

> +	}
> +}
> +
> +static __always_inline void sched_tp_load_dl_rq(struct rq *rq)
> +{
> +	if (trace_sched_load_rq_enabled()) {
> +		int cpu = cpu_of(rq);
> +
> +		trace_sched_load_rq(cpu, NULL, &rq->avg_dl);

and here.
