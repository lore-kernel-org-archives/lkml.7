Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9689C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3B9208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qYliFr2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbfGaQuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 12:50:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43844 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfGaQuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M16IcJbVtcK6s+BiMRNJ1Hm7ZaYNlZKt9eZO5hx7aH0=; b=qYliFr2PO+2EqS/YmFoapRgRU
        bfiGCCwTZTob1I1SBoNS3RTHiJoPE8PgwOm6qcjOhy+hR5h+C56s8A9mC/0HfcaKdQ80jiDBW90uc
        HC+2IL7HPtCY2WQQT0uUvfVV2bVxKJ1lo+n/fBd8tIlAAMPseBDJXfuZEfGSF/Hq3ifjbbDOktTBL
        Qstol6QixMVw27cHOtJhIIHutuPEX8RjqnLkhgATeV0uOJ1S2TWJ7fwa0Dy1DMI8FNnBwOPdh9IwV
        al92sgMQdy6nP5TkaaN2MC+uhEFkLhzLoju9wYW9Q9mhFRCGInKSmjQNycuSqsGvCJl7MdbD8KpgE
        seJPwYesw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsrns-0005TD-C5; Wed, 31 Jul 2019 16:50:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CEB982029F4C9; Wed, 31 Jul 2019 18:50:14 +0200 (CEST)
Date:   Wed, 31 Jul 2019 18:50:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com
Subject: Re: [PATCH v3 2/7] perf/x86/intel: Support PEBS output to PT
Message-ID: <20190731165014.GY31381@hirez.programming.kicks-ass.net>
References: <20190731143041.64678-1-alexander.shishkin@linux.intel.com>
 <20190731143041.64678-3-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731143041.64678-3-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 05:30:36PM +0300, Alexander Shishkin wrote:
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index cfe256ca76df..6cf2a7ba822a 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1006,6 +1006,28 @@ static int collect_events(struct cpu_hw_events *cpuc, struct perf_event *leader,
>  	/* current number of events already accepted */
>  	n = cpuc->n_events;
>  
> +	if (!cpuc->is_fake && leader->attr.precise_ip) {
> +		if (!n)
> +			cpuc->pebs_output = 0;

I think this can go wobbly if we add a !pebs event first.

That is, in that case '!n && !precise_ip' and we'll not reset the output
state.

> +
> +		/*
> +		 * For PEBS->PT, if !aux_event, the group leader (PT) went
> +		 * away, the group was broken down and this singleton event
> +		 * can't schedule any more.
> +		 */
> +		if (WARN_ON_ONCE(is_pebs_pt(leader) && !leader->aux_event))
> +			return -EINVAL;
> +
> +		/*
> +		 * pebs_output: 0: no PEBS so far, 1: PT, 2: DS
> +		 */
> +		if (cpuc->pebs_output &&
> +		    cpuc->pebs_output != is_pebs_pt(leader) + 1)
> +			return -EINVAL;
> +
> +		cpuc->pebs_output = is_pebs_pt(leader) + 1;
> +	}
> +
>  	if (is_x86_event(leader)) {
>  		if (n >= max_count)
>  			return -EINVAL;
