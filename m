Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951E3C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CF120645
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbfEMNhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 09:37:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56132 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729292AbfEMNha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 09:37:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F29ED80D;
        Mon, 13 May 2019 06:37:29 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CA693F71E;
        Mon, 13 May 2019 06:37:27 -0700 (PDT)
Subject: Re: [PATCH v2 4/7] sched: Add pelt_rq tracepoint
To:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Quentin Perret <quentin.perret@arm.com>
References: <20190510113013.1193-1-qais.yousef@arm.com>
 <20190510113013.1193-5-qais.yousef@arm.com>
 <20190513121445.GT2623@hirez.programming.kicks-ass.net>
 <20190513124829.aybnwdh74bsm7ugv@e107158-lin.cambridge.arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <da915e4d-07ce-2914-e090-0f8e3e9e9650@arm.com>
Date:   Mon, 13 May 2019 15:37:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513124829.aybnwdh74bsm7ugv@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/19 2:48 PM, Qais Yousef wrote:
> On 05/13/19 14:14, Peter Zijlstra wrote:
>> On Fri, May 10, 2019 at 12:30:10PM +0100, Qais Yousef wrote:
>>
>>> +DECLARE_TRACE(pelt_rq,
>>> +	TP_PROTO(int cpu, const char *path, struct sched_avg *avg),
>>> +	TP_ARGS(cpu, path, avg));
>>> +
>>
>>> +static __always_inline void sched_trace_pelt_cfs_rq(struct cfs_rq *cfs_rq)
>>> +{
>>> +	if (trace_pelt_rq_enabled()) {
>>> +		int cpu = cpu_of(rq_of(cfs_rq));
>>> +		char path[SCHED_TP_PATH_LEN];
>>> +
>>> +		cfs_rq_tg_path(cfs_rq, path, SCHED_TP_PATH_LEN);
>>> +		trace_pelt_rq(cpu, path, &cfs_rq->avg);
>>> +	}
>>> +}
>>> +
>>> +static __always_inline void sched_trace_pelt_rt_rq(struct rq *rq)
>>> +{
>>> +	if (trace_pelt_rq_enabled()) {
>>> +		int cpu = cpu_of(rq);
>>> +
>>> +		trace_pelt_rq(cpu, NULL, &rq->avg_rt);
>>> +	}
>>> +}
>>> +
>>> +static __always_inline void sched_trace_pelt_dl_rq(struct rq *rq)
>>> +{
>>> +	if (trace_pelt_rq_enabled()) {
>>> +		int cpu = cpu_of(rq);
>>> +
>>> +		trace_pelt_rq(cpu, NULL, &rq->avg_dl);
>>> +	}
>>> +}
>>
>> Since it is only the one real tracepoint, how do we know which avg is
>> which?
> 
> Good question. I missed that to be honest since we are mainly interested in cfs
> and I was focused into not adding too many tracepoints..
> 
> I'm happy to create a tracepoint per class assuming that's what you're
> suggesting.

IMHO, you should also consider irq (rq->avg_irq), so when people are 
tracing asystem with 'IRQ' or 'paravirtual steal' time accounting, they 
will get the full picture.
