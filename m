Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB587C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8398B2184D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfEJJOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 05:14:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40576 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbfEJJOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 05:14:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8840A78;
        Fri, 10 May 2019 02:14:44 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C76B3F738;
        Fri, 10 May 2019 02:14:43 -0700 (PDT)
Date:   Fri, 10 May 2019 10:14:40 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/7] sched: Add sched_load_rq tracepoint
Message-ID: <20190510091440.2vbebpndrcxm7gin@e107158-lin.cambridge.arm.com>
References: <20190505115732.9844-1-qais.yousef@arm.com>
 <20190505115732.9844-5-qais.yousef@arm.com>
 <4971629f-70d2-9ee1-7509-5d0cfe9004ff@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4971629f-70d2-9ee1-7509-5d0cfe9004ff@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/19 10:51, Dietmar Eggemann wrote:
> Hi Qais,
> 
> On 5/5/19 1:57 PM, Qais Yousef wrote:
> 
> [...]
> 
> > diff --git a/kernel/sched/sched_tracepoints.h b/kernel/sched/sched_tracepoints.h
> > new file mode 100644
> > index 000000000000..f4ded705118e
> > --- /dev/null
> > +++ b/kernel/sched/sched_tracepoints.h
> > @@ -0,0 +1,39 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Scheduler tracepoints that are probe-able only and aren't exported ABI in
> > + * tracefs.
> > + */
> > +
> > +#include <trace/events/sched.h>
> > +
> > +#define SCHED_TP_PATH_LEN		64
> > +
> > +
> > +static __always_inline void sched_tp_load_cfs_rq(struct cfs_rq *cfs_rq)
> > +{
> > +	if (trace_sched_load_rq_enabled()) {
> > +		int cpu = cpu_of(rq_of(cfs_rq));
> > +		char path[SCHED_TP_PATH_LEN];
> > +
> > +		cfs_rq_tg_path(cfs_rq, path, SCHED_TP_PATH_LEN);
> > +		trace_sched_load_rq(cpu, path, &cfs_rq->avg);
> 
> This will let a !CONFIG_SMP build fail.

You're right. sched_avg is only defined if CONFIG_SMP. Fixed all three
functions.

Thanks!

--
Qais Yousef
