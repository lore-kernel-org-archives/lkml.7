Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AF3C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0060621473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfEVOhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 10:37:14 -0400
Received: from foss.arm.com ([217.140.101.70]:52716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728111AbfEVOhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 10:37:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 398B280D;
        Wed, 22 May 2019 07:37:14 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C1D43F718;
        Wed, 22 May 2019 07:37:13 -0700 (PDT)
Date:   Wed, 22 May 2019 15:37:11 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smp,cpumask: Don't call functions on offline CPUs
Message-ID: <20190522143711.GC8268@e119886-lin.cambridge.arm.com>
References: <20190522111537.27815-1-andrew.murray@arm.com>
 <20190522140921.GD16275@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522140921.GD16275@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 04:09:21PM +0200, Peter Zijlstra wrote:
> On Wed, May 22, 2019 at 12:15:37PM +0100, Andrew Murray wrote:
> > When we are able to allocate a cpumask in on_each_cpu_cond_mask
> > we call functions with on_each_cpu_mask - this masks out offline
> > cpus via smp_call_function_many.
> > 
> > However when we fail to allocate a cpumask in on_each_cpu_cond_mask
> > we call functions with smp_call_function_single - this will return
> > -ENXIO from generic_exec_single if a CPU is offline which will
> > result in a WARN_ON_ONCE.
> > 
> > Let's avoid the WARN by only calling smp_call_function_single when
> > the CPU is online and thus making both paths consistent with each
> > other.
> 
> I'm confused, why are you feeding it offline CPUs to begin with? @mask
> shouldn't include them.

There are only two users of this function: on_each_cpu_cond which passes
cpu_online_mask, and native_flush_tlb_others from arch/x86/mm/tlb.c. But
I haven't followed all callers to native_flush_tlb_others to determine if
they are only passing in online CPUs.

Whilst trying to understand the code I couldn't help but notice that the
behaviour changes depending on the ability of memory allocation at the
time. This seemed odd. And of course there may be future callers of this
function that for some strange reason do pass in offline CPUs. (Maybe this
is OK and it's something they shouldn't be doing).

I felt that this function should be consistent and document the behaviour
via the @mask doc like some of the other functions in the file.

> 
> Is perhaps the problem that on_each_cpu_cond() uses cpu_onlne_mask
> without protection?

Does this prevent racing with a CPU going offline? I guess this prevents
the warning at the expense of a lock - but is only beneficial in the
unlikely path. (In the likely path this prevents new CPUs going offline
but we don't care because we don't WARN if they aren't they when we
attempt to call functions).

At least this is my limited understanding.

Thanks,

Andrew Murray

> 
> Something like so?
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index f4cf1b0bb3b8..a493b3dfa67f 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -705,8 +707,10 @@ void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
>  			smp_call_func_t func, void *info, bool wait,
>  			gfp_t gfp_flags)
>  {
> +	cpus_read_lock();
>  	on_each_cpu_cond_mask(cond_func, func, info, wait, gfp_flags,
>  				cpu_online_mask);
> +	cpus_read_unlock();
>  }
>  EXPORT_SYMBOL(on_each_cpu_cond);
>  
> 
