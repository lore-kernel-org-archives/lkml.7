Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C988C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC152083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YoCWDAW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfCRJiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:38:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55800 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387910AbfCRJhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y3NiwwRe/QDvRzEhR0UQDgHYLh/EGideUmQY76n5dxg=; b=YoCWDAW0kjG6izfCRgmyjPHTy
        1KK6LSYcm3Gf4l+2PBbvCnoyAHHrlb/GWRRJXfQK/3CZOTzFakw4q/A3+xp9hcUl2vSsTLBeI0/Ia
        XqTByWB6ZDqZr+eMGJeLW2UBgg+cTw06CaQjQLgYzkFBqgynVwFJk5NFlbfrK/Mzq+SL5BUBm6Zai
        pKgGqROmSHcHn8vOdikeF6KRvFPwNz7gIxhB2Q/yGl6Ykm82zWhTaewHyv/XjN52yuVzV8K4QJyWl
        s4oRun254CK/1/1fVAeoaRz/9uCqlbi/abyZl77eYqJ03Ioo+Qbqt/BATbcVHygfqUdR8fZcXRdBv
        4oktorCiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5oi1-0003L2-AC; Mon, 18 Mar 2019 09:37:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 298A1202194ED; Mon, 18 Mar 2019 10:37:25 +0100 (CET)
Date:   Mon, 18 Mar 2019 10:37:25 +0100
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
Subject: Re: [RFC PATCH v2 1/2] x86/perf/amd: Resolve race condition when
 disabling PMC
Message-ID: <20190318093725.GJ6058@hirez.programming.kicks-ass.net>
References: <155268244291.14761.3432013617741218607.stgit@tlendack-t1.amdoffice.net>
 <155268245032.14761.7748666703519081877.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155268245032.14761.7748666703519081877.stgit@tlendack-t1.amdoffice.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 08:40:53PM +0000, Lendacky, Thomas wrote:
> +void amd_pmu_disable_all(void)
> +{
> +	unsigned long overflow_check[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	int idx;
> +
> +	bitmap_zero(overflow_check, X86_PMC_IDX_MAX);
> +
> +	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
> +		u64 val;
> +
> +		if (!test_bit(idx, cpuc->active_mask))
> +			continue;
> +
> +		rdmsrl(x86_pmu_config_addr(idx), val);
> +		if (!(val & ARCH_PERFMON_EVENTSEL_ENABLE))
> +			continue;
> +
> +		val &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
> +		wrmsrl(x86_pmu_config_addr(idx), val);
> +
> +		/*
> +		 * If the interrupt is enabled, this counter must be checked
> +		 * for an overflow condition to avoid possibly changing the
> +		 * counter value before the NMI handler runs.
> +		 */
> +		if (val & ARCH_PERFMON_EVENTSEL_INT)
> +			__set_bit(idx, overflow_check);
> +	}

I think you can ditch overflow_check and directly call
x86_pmu_disable_all() here.

> +
> +	/*
> +	 * This shouldn't be called from NMI context, but add a safeguard here
> +	 * to return, since if we're in NMI context we can't wait for an NMI
> +	 * to reset an overflowed counter value.
> +	 */
> +	if (in_nmi())
> +		return;
> +
> +	/*
> +	 * Check each counter for overflow and wait for it to be reset by the
> +	 * NMI if it has overflowed.
> +	 */
> +	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
> +		if (!test_bit(idx, overflow_check))

And simply iterate cpuc->active_mask again here.

> +			continue;
> +
> +		amd_pmu_wait_on_overflow(idx);
> +	}
> +}

Because, per x86_pmu_hw_config() we _always_ have EVENTSEL_INT set, even
for !sampling events -- such that we can deal with overflow, and we
should 'always' have EVENTSEL_ENABLE set when 'active', see
x86_pmu_enable_all().


