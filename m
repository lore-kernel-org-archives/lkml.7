Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7195C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8463A20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AcYbXBeK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfCRKkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:40:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55026 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbfCRKkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r5Bk6YCZR9p14DU7vum0FGMqw1wDEe2/Bu7Z8JYNbCs=; b=AcYbXBeKj2590UUCP5KCNLECb
        tkCuJNI61u+/SSiHwMyPynMtLSqYJbK7/0dPd/4WmZjFMEG0ZCGYS3At9Jdr+URw5t6HHFcSdMpZv
        EppOQyC3ocLMq2Nme1lIZwxu6Q6kgL8HUonYp2jSBJirpe7JbrUWWBpeH77jphm7iJr7JHUSBsIW2
        mhxGGe8Qlp+YYJC+l/FidiSygrp/nsA5AjZl+kvxLmFw1VWwTlfWDkTEAO2WEoMAR0cLchw5usTOc
        GNk7i0Ce4wad4SBfYKzQwCXejBhXmShvaJDj8t8SEDxaH1yeUW8DT/+jiKJ1cMgC+0GNnnQ+lphnD
        MufggtUwQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5pgk-0007DJ-Eo; Mon, 18 Mar 2019 10:40:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 95486202194F5; Mon, 18 Mar 2019 11:40:09 +0100 (CET)
Date:   Mon, 18 Mar 2019 11:40:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RFC PATCH v2 2/2] x86/perf/amd: Resolve NMI latency issues when
 multiple PMCs are active
Message-ID: <20190318104009.GK6058@hirez.programming.kicks-ass.net>
References: <155268244291.14761.3432013617741218607.stgit@tlendack-t1.amdoffice.net>
 <155268245818.14761.10443012194152751116.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155268245818.14761.10443012194152751116.stgit@tlendack-t1.amdoffice.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 08:41:00PM +0000, Lendacky, Thomas wrote:
> This issue is different from a previous issue related to perf NMIs that
> was fixed in commit:
>   63e6be6d98e1 ("perf, x86: Catch spurious interrupts after disabling counters")
> 
> The difference here is that the NMI latency can contribute to what appear
> to be spurious NMIs during the handling of PMC counter overflow while the
> counter is active as opposed to when the counter is being disabled.

But could we not somehow merge these two cases? The cause is similar
IIUC. The PMI gets triggered, but then:

  - a previous PMI handler handled our overflow, or
  - our event gets disabled.

and when our PMI triggers it finds nothing to do.

> +/*
> + * Because of NMI latency, if multiple PMC counters are active or other sources
> + * of NMIs are received, the perf NMI handler can handle one or more overflowed
> + * PMC counters outside of the NMI associated with the PMC overflow. If the NMI
> + * doesn't arrive at the LAPIC in time to become a pending NMI, then the kernel
> + * back-to-back NMI support won't be active. This PMC handler needs to take into
> + * account that this can occur, otherwise this could result in unknown NMI
> + * messages being issued. Examples of this is PMC overflow while in the NMI
> + * handler when multiple PMCs are active or PMC overflow while handling some
> + * other source of an NMI.
> + *
> + * Attempt to mitigate this by using the number of active PMCs to determine
> + * whether to return NMI_HANDLED if the perf NMI handler did not handle/reset
> + * any PMCs. The per-CPU perf_nmi_counter variable is set to a minimum of the
> + * number of active PMCs or 2. The value of 2 is used in case an NMI does not
> + * arrive at the LAPIC in time to be collapsed into an already pending NMI.
> + */
> +static int amd_pmu_handle_irq(struct pt_regs *regs)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	int active, handled;
> +
> +	active = __bitmap_weight(cpuc->active_mask, X86_PMC_IDX_MAX);
> +	handled = x86_pmu_handle_irq(regs);
> +
> +	/*
> +	 * If no counters are active, reset perf_nmi_counter and return
> +	 * NMI_DONE
> +	 */
> +	if (!active) {
> +		this_cpu_write(perf_nmi_counter, 0);
> +		return NMI_DONE;
> +	}

This will actively render 63e6be6d98e1 void I think. Because that can
return !0 while !active -- that's rather the whole point of it.

> +	/*
> +	 * If a counter was handled, record the number of possible remaining
> +	 * NMIs that can occur.
> +	 */
> +	if (handled) {
> +		this_cpu_write(perf_nmi_counter,
> +			       min_t(unsigned int, 2, active));
> +
> +		return handled;
> +	}
> +
> +	if (!this_cpu_read(perf_nmi_counter))
> +		return NMI_DONE;
> +
> +	this_cpu_dec(perf_nmi_counter);
> +
> +	return NMI_HANDLED;
> +}


