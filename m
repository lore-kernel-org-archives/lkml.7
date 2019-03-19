Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493CEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1506E2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t3QV6y6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfCSOxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:53:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41308 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbfCSOxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R1GM/NtRtTJCth8fInv/ew0gqocYHrkN9VvOAIwZ0YA=; b=t3QV6y6GRPkuHx4bALS2yLvX3
        m0hN/VyRrXwgXPaArozC7wQ/OJLc8B63m/sRwAoWarlw21RPsmwOpxa4Qv2l+94fHkquqhxossLZ5
        VZu06z44pFe3zySxp0WguVI8yL3pxGr9P1F7ixg080MS0z+Kn9Fyjd/X2l6tEHhO1GXlJBFuYMwHC
        TZm41b4kWCHBZS/zoIvkCQoLy5kxAEgXS5d8IiolSOwkSDbmrZdaVx0wqnuwo0Uxc46ksuJh0DsTl
        hSNSaDb9Rhf5nfDCUWHm35UbfhJx424EDtwcLYz2lhJsQ/0mK2C1SKpyBNFxi9ZTLtRZCZso957Ar
        AoM2eOpPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6G76-0001Jf-1U; Tue, 19 Mar 2019 14:53:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A46FA23E8CA32; Tue, 19 Mar 2019 15:53:09 +0100 (CET)
Date:   Tue, 19 Mar 2019 15:53:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 05/22] perf/x86: Support constraint ranges
Message-ID: <20190319145309.GI5996@hirez.programming.kicks-ass.net>
References: <20190318214144.4639-1-kan.liang@linux.intel.com>
 <20190318214144.4639-6-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318214144.4639-6-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 02:41:27PM -0700, kan.liang@linux.intel.com wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Icelake extended the general counters to 8, even when SMT is enabled.
> However only a (large) subset of the events can be used on all 8
> counters.
> 
> The events that can or cannot be used on all counters are organized
> in ranges.
> 
> We need a lot of scheduler constraints to handle all this.
> 
> To avoid blowing up the tables add event code ranges to the constraint
> tables, and a new inline function to match them.
> 
> The changes costs ~2k text size according to 0day report.

Where?! there isn't much code here.

> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c |  2 +-
>  arch/x86/events/intel/ds.c   |  2 +-
>  arch/x86/events/perf_event.h | 34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index a964b9832b0c..8486ab87f8f8 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2655,7 +2655,7 @@ x86_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>  
>  	if (x86_pmu.event_constraints) {
>  		for_each_event_constraint(c, x86_pmu.event_constraints) {
> -			if ((event->hw.config & c->cmask) == c->code) {
> +			if (constraint_match(c, event->hw.config)) {
>  				event->hw.flags |= c->flags;
>  				return c;
>  			}
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 974284c5ed6c..30370fb93e21 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -858,7 +858,7 @@ struct event_constraint *intel_pebs_constraints(struct perf_event *event)
>  
>  	if (x86_pmu.pebs_constraints) {
>  		for_each_event_constraint(c, x86_pmu.pebs_constraints) {
> -			if ((event->hw.config & c->cmask) == c->code) {
> +			if (constraint_match(c, event->hw.config)) {
>  				event->hw.flags |= c->flags;
>  				return c;
>  			}
> @@ -71,6 +72,12 @@ struct event_constraint {
>  #define PERF_X86_EVENT_AUTO_RELOAD	0x0400 /* use PEBS auto-reload */
>  #define PERF_X86_EVENT_LARGE_PEBS	0x0800 /* use large PEBS */
>  
> +static inline bool constraint_match(struct event_constraint *c, u64 ecode)
> +{
> +	ecode &= c->cmask;
> +	return ecode == c->code ||
> +		(c->range_end && ecode >= c->code && ecode <= c->range_end);
> +}
>  
>  struct amd_nb {
>  	int nb_id;  /* NorthBridge id */

That's all the code, how does that add up to 2k ?
