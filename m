Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1307DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13392075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BV6Ziibd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfDJHvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:51:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50902 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbfDJHvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nRRpFlA2MAi/jgOy8X4Iz8ZSpdnVh1I2OhaEYXqmfx4=; b=BV6Ziibd8tvPPVOm344x7S4np
        mAxMz9nhxL1+7gZLRDoNU8Wuh2axws7Hcc2+UEzu1LxxnIaxh6wQ5eg8dZz1L6cVp1moe2sfq/X+w
        91i96AXKETrbfvHy2dEME1JsvHY01YCKwXL66gjodyrbxsrzV5YuGZF7eBqhPZqRhovlFNydhp6Cc
        X6rNuENgvPepAKP0IfSmZcQ2sX4i+2yd03AYQxkbYWKcHCHMnT5QjCuoqPT5aaiCX0GiHFrk6HXdu
        46k0Jjo7PfvM7ar9wUR9t/MYVU0ARw2Woxz3z1TZfh5nk0p+m+nty95v2QUZPEpuTmRAmkDzPnz5F
        wkJDg9u9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hE81D-0006SV-Vw; Wed, 10 Apr 2019 07:51:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B618429B453E4; Wed, 10 Apr 2019 09:51:38 +0200 (CEST)
Date:   Wed, 10 Apr 2019 09:51:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        acme@kernel.org, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 2/2] perf/x86/intel: Add Tremont core PMU support
Message-ID: <20190410075138.GX11158@hirez.programming.kicks-ass.net>
References: <1554858600-148296-1-git-send-email-kan.liang@linux.intel.com>
 <1554858600-148296-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554858600-148296-3-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 06:10:00PM -0700, kan.liang@linux.intel.com wrote:

> The generic purpose counter 0 and fixed counter 0 have less skid.
> Force :ppp events on generic purpose counter 0.
> Force instruction:ppp always on fixed counter 0.

> +static struct event_constraint *
> +tnt_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
> +			  struct perf_event *event)
> +{
> +	struct event_constraint *c;
> +
> +	/*
> +	 * :ppp means to do reduced skid PEBS,
> +	 * which is available at PMC0 and fixed counter 0.
> +	 */
> +	if (event->attr.precise_ip == 3) {
> +		/* Force instruction:ppp in Fixed counter 0 */
> +		if (event->hw.config == X86_CONFIG(.event=0xc0))
> +			return &fixed_counter0_constraint;
> +
> +		return &counter0_constraint;

I'm confused, 0xc0 is the architectural 'instructions' event, surely we
can program that on pmc0 too?

Did we want a fixed0_counter0_constraint for that?

> +	}
> +
> +	c = intel_get_event_constraints(cpuc, idx, event);
> +
> +	return c;
> +}
