Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114ABC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB1920651
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A8zG5Dg0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfCOMDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 08:03:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39440 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbfCOMDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 08:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WzxXKYm1YsUi7LIyFK/BfGSJlhvaM3nxioJ6/CDHwJQ=; b=A8zG5Dg0VB97zAuEcjk59IXrx
        Mfi5X0nIRh7xtwVZQxJUcLYwEaxzkRm7aF8pJhZsdsDfEqeGSle2h9PbL3gFXs314R6EhgQ8fz+W8
        jjy1SF7CqEeeDHwR6IdXaufG6d2EyEPDSw/i6bhKU71lchUuqWIUbUKtq3/j+Ekp4LXS1zqyFX64j
        2s4+YmOrpqw9PhOISwYJldQLLoP87J3EaRvW9apy8WXapV9NSUL5PxeDKcNC+SOXldoGfK8JUHCOL
        Sdl+trwerU5Tsp+S9Mq5OaihLa9rCPdxtaagSQMaZCNfMZjvM9CJWFnlx6/hG1XWiufD2JrtLoQWT
        hjr0DK26w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4lYQ-0005XT-Mw; Fri, 15 Mar 2019 12:03:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7685C2142294F; Fri, 15 Mar 2019 13:03:11 +0100 (CET)
Date:   Fri, 15 Mar 2019 13:03:11 +0100
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
Subject: Re: [RFC PATCH 2/2] x86/perf/amd: Resolve NMI latency issues when
 multiple PMCs are active
Message-ID: <20190315120311.GX5996@hirez.programming.kicks-ass.net>
References: <155232291547.21417.2499429555505085131.stgit@tlendack-t1.amdoffice.net>
 <155232292961.21417.3665243457569518550.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155232292961.21417.3665243457569518550.stgit@tlendack-t1.amdoffice.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 04:48:51PM +0000, Lendacky, Thomas wrote:
> @@ -467,6 +470,45 @@ static void amd_pmu_wait_on_overflow(int idx, u64 config)
>  	}
>  }
>  
> +/*
> + * Because of NMI latency, if multiple PMC counters are active we need to take
> + * into account that multiple PMC overflows can generate multiple NMIs but be
> + * handled by a single invocation of the NMI handler (think PMC overflow while
> + * in the NMI handler). This could result in subsequent unknown NMI messages
> + * being issued.
> + *
> + * Attempt to mitigate this by using the number of active PMCs to determine
> + * whether to return NMI_HANDLED if the perf NMI handler did not handle/reset
> + * any PMCs. The per-CPU perf_nmi_counter variable is set to a minimum of one
> + * less than the number of active PMCs or 2. The value of 2 is used in case the
> + * NMI does not arrive at the APIC in time to be collapsed into an already
> + * pending NMI.

LAPIC I really do hope?!

> + */
> +static int amd_pmu_mitigate_nmi_latency(unsigned int active, int handled)
> +{
> +	/* If multiple counters are not active return original handled count */
> +	if (active <= 1)
> +		return handled;

Should we not reset perf_nmi_counter in this case?

> +
> +	/*
> +	 * If a counter was handled, record the number of possible remaining
> +	 * NMIs that can occur.
> +	 */
> +	if (handled) {
> +		this_cpu_write(perf_nmi_counter,
> +			       min_t(unsigned int, 2, active - 1));
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
> +
>  static struct event_constraint *
>  amd_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>  			  struct perf_event *event)
> @@ -689,6 +731,7 @@ static __initconst const struct x86_pmu amd_pmu = {
>  
>  	.amd_nb_constraints	= 1,
>  	.wait_on_overflow	= amd_pmu_wait_on_overflow,
> +	.mitigate_nmi_latency	= amd_pmu_mitigate_nmi_latency,
>  };

Again, you could just do amd_pmu_handle_irq() and avoid an extra
callback.

Anyway, we already had code to deal with spurious NMIs from AMD; see
commit:

  63e6be6d98e1 ("perf, x86: Catch spurious interrupts after disabling counters")

And that looks to be doing something very much the same. Why then do you
still need this on top?


