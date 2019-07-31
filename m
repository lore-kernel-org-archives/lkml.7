Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F372C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9B1206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D3wcXKvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbfGaQQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 12:16:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43680 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfGaQQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=grmjM1oT7pcR8/D46XNCHxIck7pv+ePjJa/sfCwumfM=; b=D3wcXKvZbhgSymvlC87F1fDcd
        LuuwAC1EirzjPO7ivw7k52vXtyiTVW5li19v8Jchdh+GRVBevKhAUjIL5SFr4Ks+OPmBhHM/rD8/k
        mLkv+ZQmVvR6IMURgOQwPTCMDmpwx+D95vVhOT2h2pfTWs4gms7HVAqWvILyDAVaZGXQ+2JO/dhbv
        WrksHSJ3j3tFBZ59klfAFK/N5cmAaKGWb3HOf1rRdnHSFsUeUtuOjHMhGALGJoVcLTb9LodEvH0yX
        2VBhLdQeLXteEp3Ptw81WAJ0JDtmjt3xNCpi0RWV6UuFHH+Ox1sVoaMagwwwIo2I73ewWhyyo8lDb
        szHTY5Hpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsrHS-0004HD-JR; Wed, 31 Jul 2019 16:16:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3D1752029F869; Wed, 31 Jul 2019 18:16:44 +0200 (CEST)
Date:   Wed, 31 Jul 2019 18:16:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com
Subject: Re: [PATCH v3 1/7] perf: Allow normal events to be sources of AUX
 data
Message-ID: <20190731161644.GW31381@hirez.programming.kicks-ass.net>
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

We should probably do something like:

		perf_event_set_state(event, PERF_EVENT_STATE_ERROR);

to avoid these events messing up scheduling for the rest.

> +	}
> +}
