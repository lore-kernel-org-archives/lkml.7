Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C70EC10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A57721850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kH2vutXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbfDEHz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:55:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38970 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730390AbfDEHz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 03:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Hgyhvmuunrz+BBA46ihl8bnEzXA2fhD6JcDOqMwUvsg=; b=kH2vutXapcfgDYgnN4SQwCL9A
        Gc8nwxko+cOQQ1EVop+Jc3DTQLSFgsU30EY8Pwa7Bj8RHzA5Jv/TQKQ7UEudDvYbIoyFDN7Ko+sl8
        GwR6La5BOnWiNzuzW2+ikEk9eSp1WTdcE6mFpG4ap1f3ycV/76viOSWGRr4MBEoAYz3C71saGHVki
        RhTEFhdQ8kaUw3nMv1ydPPIc2O3HVfRp6XHaYHFjeDUZ7kz2yBHyfdbB5T6Z6QBjS79amUFNabybf
        6BY77IQ7xn89wDAjlgn3WNlUisKHhit53OZiG4UZ5hhB2Hl4Q9bXdBeQMLgEqixB70wvsC++UzXF5
        a7zPERMsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hCJ2d-0003ML-25; Fri, 05 Apr 2019 07:13:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A05423954621; Fri,  5 Apr 2019 09:13:33 +0200 (CEST)
Date:   Fri, 5 Apr 2019 09:13:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        ak@linux.intel.com, kan.liang@intel.com, mingo@elte.hu,
        nelson.dsouza@intel.com, jolsa@redhat.com, tonyj@suse.com
Subject: Re: [PATCH 3/3] perf/x86/intel: force resched when TFA sysctl is
 modified
Message-ID: <20190405071333.GB4038@hirez.programming.kicks-ass.net>
References: <20190404183219.125083-1-eranian@google.com>
 <20190404183219.125083-4-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404183219.125083-4-eranian@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 11:32:19AM -0700, Stephane Eranian wrote:
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index a4b7711ef0ee..8d356c2096bc 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4483,6 +4483,60 @@ static ssize_t freeze_on_smi_store(struct device *cdev,
>  	return count;
>  }
>  
> +static void update_tfa_sched(void *ignored)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	struct pmu *pmu = x86_get_pmu();
> +	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
> +	struct perf_event_context *task_ctx = cpuctx->task_ctx;
> +
> +	/* prevent any changes to the two contexts */
> +	perf_ctx_lock(cpuctx, task_ctx);
> +
> +	/*
> +	 * check if PMC3 is used
> +	 * and if so force schedule out for all event types all contexts
> +	 */
> +	if (test_bit(3, cpuc->active_mask))
> +		perf_ctx_resched(cpuctx, task_ctx, EVENT_ALL|EVENT_CPU);
> +
> +	perf_ctx_unlock(cpuctx, task_ctx);

I'm not particularly happy with exporting all that. Can't we create this
new perf_ctx_resched() to include the locking and everything. Then the
above reduces to:

	if (test_bit(3, cpuc->active_mask))
		perf_ctx_resched(cpuctx);

And we don't get to export the tricky bits.

> +}
> +
> +static ssize_t show_sysctl_tfa(struct device *cdev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	return snprintf(buf, 40, "%d\n", allow_tsx_force_abort);
> +}
> +
> +static ssize_t set_sysctl_tfa(struct device *cdev,
> +			      struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	unsigned long val;
> +	ssize_t ret;
> +
> +	ret = kstrtoul(buf, 0, &val);

You want kstrtobool()

> +	if (ret)
> +		return ret;
> +
> +	/* looking for boolean value */
> +	if (val > 2)
> +		return -EINVAL;
> +
> +	/* no change */
> +	if (val == allow_tsx_force_abort)
> +		return count;
> +
> +	allow_tsx_force_abort ^= 1;

	allow_tsx_force_abort = val;

is simpler

> +
> +	on_each_cpu(update_tfa_sched, NULL, 1);
> +
> +	return count;
> +}
