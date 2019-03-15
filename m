Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22D3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6E921871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Co32Sdu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbfCOKuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:50:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38770 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfCOKuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 06:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Qy1jr0AkgXYq/ljGe2OnfsKJt7HMkUdQp8p34xIwKAc=; b=Co32Sdu++BIbk2/vZ7GHprVPr
        gEVyEnlyKscI1qEkhxz8iESEv4WLAk7JbZ7zUla3FCr204PJTc9zuPEuI1Hpk9vEuJNKcnsYdMLn1
        9XK1Okd2bEnD4reffCmcNUIwnMLpGPRz+vPk25TdLxds7yg0q8kFqr4eOsgpU3rNjrTrXuAcR7IZ8
        GRBaNfWJ3rY1br/7Lg+MvxwUV4gief3ZI3iAyUR9KfI7lDdgiEH02n2dbU/CjYMSJA/3hF9S3wiXV
        7za/3QDK7Tnsl0mGnzlwIQmgIxsCmYfJK6lfXZJh1yKZjnozIDxN9jugdkgWFOi+5mkC6TfZo6PEp
        HUqzgZ7yQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4kPe-0003tR-OZ; Fri, 15 Mar 2019 10:50:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 419802142294E; Fri, 15 Mar 2019 11:50:04 +0100 (CET)
Date:   Fri, 15 Mar 2019 11:50:04 +0100
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
Subject: Re: [RFC PATCH 1/2] x86/perf/amd: Resolve race condition when
 disabling PMC
Message-ID: <20190315105004.GW5996@hirez.programming.kicks-ass.net>
References: <155232291547.21417.2499429555505085131.stgit@tlendack-t1.amdoffice.net>
 <155232292270.21417.18139649076000959940.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155232292270.21417.18139649076000959940.stgit@tlendack-t1.amdoffice.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 04:48:44PM +0000, Lendacky, Thomas wrote:
> On AMD processors, the detection of an overflowed counter in the NMI
> handler relies on the current value of the counter. So, for example, to
> check for overflow on a 48 bit counter, bit 47 is checked to see if it
> is 1 (not overflowed) or 0 (overflowed).
> 
> There is currently a race condition present when disabling and then
> updating the PMC. Increased NMI latency in newer AMD processors makes this
> race condition more pronounced.

Increased NMI latency also makes the results less useful :/ What amount
of skid are we talking about, and is there anything AMD is going to do
about this?

> If the counter value has overflowed, it is
> possible to update the PMC value before the NMI handler can run.

Arguably the WRMSR should sync against the PMI. That is the beahviour
one would expect.

Isn't that something you can fix in ucode? And could you very please
tell the hardware people this is disguisting?

> The updated PMC value is not an overflowed value, so when the perf NMI
> handler does run, it will not find an overflowed counter. This may
> appear as an unknown NMI resulting in either a panic or a series of
> messages, depending on how the kernel is configured.
> 
> To eliminate this race condition, the PMC value must be checked after
> disabling the counter in x86_pmu_disable_all(), and, if overflowed, must
> wait for the NMI handler to reset the value before continuing. Add a new,
> optional, callable function that can be used to test for and resolve this
> condition.
> 
> Cc: <stable@vger.kernel.org> # 4.14.x-
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

> +static void amd_pmu_wait_on_overflow(int idx, u64 config)
> +{
> +	unsigned int i;
> +	u64 counter;
> +
> +	/*
> +	 * We shouldn't be calling this from NMI context, but add a safeguard
> +	 * here to return, since if we're in NMI context we can't wait for an
> +	 * NMI to reset an overflowed counter value.
> +	 */
> +	if (in_nmi())
> +		return;
> +
> +	/*
> +	 * If the interrupt isn't enabled then we won't get the NMI that will
> +	 * reset the overflow condition, so return.
> +	 */
> +	if (!(config & ARCH_PERFMON_EVENTSEL_INT))
> +		return;
> +
> +	/*
> +	 * Wait for the counter to be reset if it has overflowed. This loop
> +	 * should exit very, very quickly, but just in case, don't wait
> +	 * forever...
> +	 */
> +	for (i = 0; i < OVERFLOW_WAIT_COUNT; i++) {
> +		rdmsrl(x86_pmu_event_addr(idx), counter);
> +		if (counter & (1ULL << (x86_pmu.cntval_bits - 1)))
> +			break;
> +
> +		/* Might be in IRQ context, so can't sleep */
> +		udelay(1);
> +	}
> +}

Argh.. that's horrible, as I'm sure you fully appreciate :/

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index b684f0294f35..f1d2f70000cd 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -606,6 +606,9 @@ void x86_pmu_disable_all(void)
>  			continue;
>  		val &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
>  		wrmsrl(x86_pmu_config_addr(idx), val);
> +
> +		if (x86_pmu.wait_on_overflow)
> +			x86_pmu.wait_on_overflow(idx, val);
>  	}
>  }

One alternative is adding amd_pmu_disable_all() to amd/core.c and using
that. Then you can also change the loop to do the wait after all the
WRMSRs, if that helps with latency.

