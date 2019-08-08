Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4646BC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2190921874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbfHHGrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 02:47:41 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:53541 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbfHHGrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:47:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=aaron.lu@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0TYwvRMH_1565246851;
Received: from aaronlu(mailfrom:aaron.lu@linux.alibaba.com fp:SMTPD_---0TYwvRMH_1565246851)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 08 Aug 2019 14:47:37 +0800
Date:   Thu, 8 Aug 2019 14:47:31 +0800
From:   Aaron Lu <aaron.lu@linux.alibaba.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <20190808064731.GA5121@aaronlu>
References: <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu>
 <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
 <20190802153715.GA18075@sinkpad>
 <f4778816-69e5-146c-2a30-ec42e7f1677f@linux.intel.com>
 <20190806032418.GA54717@aaronlu>
 <e1c4a7ed-822e-93cb-ff1d-6a0842db115f@linux.intel.com>
 <20190806171241.GQ2349@hirez.programming.kicks-ass.net>
 <21933a50-f796-3d28-664c-030cb7c98431@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21933a50-f796-3d28-664c-030cb7c98431@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 02:19:57PM -0700, Tim Chen wrote:
> +void account_core_idletime(struct task_struct *p, u64 exec)
> +{
> +	const struct cpumask *smt_mask;
> +	struct rq *rq;
> +	bool force_idle, refill;
> +	int i, cpu;
> +
> +	rq = task_rq(p);
> +	if (!sched_core_enabled(rq) || !p->core_cookie)
> +		return;

I don't see why return here for untagged task. Untagged task can also
preempt tagged task and force a CPU thread enter idle state.
Untagged is just another tag to me, unless we want to allow untagged
task to coschedule with a tagged task.

> +	cpu = task_cpu(p);
> +	force_idle = false;
> +	refill = true;
> +	smt_mask = cpu_smt_mask(cpu);
> +
> +	for_each_cpu(i, smt_mask) {
> +		if (cpu == i)
> +			continue;
> +
> +		if (cpu_rq(i)->core_forceidle)
> +			force_idle = true;
> +
> +		/* Only refill if everyone has run out of allowance */
> +		if (cpu_rq(i)->core_idle_allowance > 0)
> +			refill = false;
> +	}
> +
> +	if (force_idle)
> +		rq->core_idle_allowance -= (s64) exec;
> +
> +	if (rq->core_idle_allowance < 0 && refill) {
> +		for_each_cpu(i, smt_mask) {
> +			cpu_rq(i)->core_idle_allowance += (s64) SCHED_IDLE_ALLOWANCE;
> +		}
> +	}
> +}
