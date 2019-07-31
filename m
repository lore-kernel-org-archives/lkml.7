Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE40C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A04208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qN3EkyES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfGaQVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 12:21:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43702 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfGaQVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DLywjtf9AHnfBiRIBY4kbj0CidghKY4rkO0+gFvevPc=; b=qN3EkyES0mtU/oRjNGDFtlNOV
        PPM8kGpiLJivmqs5TVUCSyDa/a6I7LInZ2CIDHdqEDaWZmnCqaB/n6GUOH7902b8P/C/RIPs2AD0a
        A17l4XreXtdgW6kNjhYcIETjNUfwmzoq7u5WmvIG3RIFnzmAXI6MK2dwR0XR8k/bFlX+UHTIjUKDU
        JUliRvAdM5Ufgc+jdZVZ9pVWvWpfKfHGcq2XjjhmuERmfCwnwYSEEGZlD3kc+KC4JyWRaydYgsxQy
        qOC4F6W9Y/7uep20plhAIiTu7iKUfKI0DYh7bYe63619WRYrv8Kd/0yEW74dZuCSRGGnynEwhG//1
        Ke0mxGBag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsrLf-0004Ip-W1; Wed, 31 Jul 2019 16:21:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ABFC92029F869; Wed, 31 Jul 2019 18:21:06 +0200 (CEST)
Date:   Wed, 31 Jul 2019 18:21:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com
Subject: Re: [PATCH v3 1/7] perf: Allow normal events to be sources of AUX
 data
Message-ID: <20190731162106.GX31381@hirez.programming.kicks-ass.net>
References: <20190731143041.64678-1-alexander.shishkin@linux.intel.com>
 <20190731143041.64678-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731143041.64678-2-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 05:30:35PM +0300, Alexander Shishkin wrote:
> +static void perf_put_aux_event(struct perf_event *event)
> +{
> +	struct perf_event_context *ctx = event->ctx;
> +	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
> +	struct perf_event *iter = NULL;
> +
> +	/*
> +	 * If event uses aux_event tear down the link
> +	 */
> +	if (event->aux_event) {
> +		put_event(event->aux_event);
> +		event->aux_event = NULL;

Those lines should probably be reversed; put_event() should be done
after clearing the link.

It probably doesn't matter, but it is confusing.

> +		return;
> +	}
> +
> +	/*
> +	 * If the event is an aux_event, tear down all links to
> +	 * it from other events.
> +	 */
> +	for_each_sibling_event(iter, event->group_leader) {
> +		if (iter->aux_event != event)
> +			continue;
> +
> +		iter->aux_event = NULL;
> +		put_event(event);
> +
> +		/*
> +		 * If it's ACTIVE, schedule it out. It won't schedule
> +		 * again because !aux_event.
> +		 */
> +		event_sched_out(iter, cpuctx, ctx);
> +	}
> +}
