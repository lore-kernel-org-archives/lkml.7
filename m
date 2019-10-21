Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B495CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A67F2089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="opkIn8p/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbfJUKGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:06:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52406 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfJUKGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2kwxvwEmTAe/D98HW8RU5ge31HdCDSxAfN1n0LHssq0=; b=opkIn8p/+wSw7gu3RUkgH4JYi
        RLYYj/P9Ep3LxdeiOJS9bevy0wZrBSSbDPPJEOJ1ZSzQA7DMqdhb/E1Nzx8s1daJoJPQ0vAlbSKq6
        Nq7jvI0OcW8ZfkN5FBPqE7yFqpKNwyE6jhbuyVrMJ9AJj+CEp0FsV+qHYN+rpNpf2QM+OozYTkCq8
        vL/Kpax1Yy/ERAreX8OeadIKozCCkZaZoRnreH6WFpS8iERTlRfxM7u1iu2htwBUdUyALOrpXkQMw
        yna8LpYAXAhm51mOBtWfkw/Cs5U5yicu9saAR4SRz18adaZpW5xenMEU/R1XZsMFe/zqnOUYj/Y6H
        N0lU4AXTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMUZc-00030f-I5; Mon, 21 Oct 2019 10:06:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3BA9E303DA1;
        Mon, 21 Oct 2019 12:05:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 315CE202411A1; Mon, 21 Oct 2019 12:05:58 +0200 (CEST)
Date:   Mon, 21 Oct 2019 12:05:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, mingo@elte.hu, acme@redhat.com,
        jolsa@redhat.com, kan.liang@intel.com, songliubraving@fb.com,
        irogers@google.com
Subject: Re: [PATCH] perf/core: fix multiplexing event scheduling issue
Message-ID: <20191021100558.GC1800@hirez.programming.kicks-ass.net>
References: <20191018002746.149200-1-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018002746.149200-1-eranian@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 05:27:46PM -0700, Stephane Eranian wrote:
> @@ -2153,6 +2157,7 @@ __perf_remove_from_context(struct perf_event *event,
>  			   void *info)
>  {
>  	unsigned long flags = (unsigned long)info;
> +	int was_necessary = ctx->rotate_necessary;
>  
>  	if (ctx->is_active & EVENT_TIME) {
>  		update_context_time(ctx);
> @@ -2171,6 +2176,37 @@ __perf_remove_from_context(struct perf_event *event,
>  			cpuctx->task_ctx = NULL;
>  		}
>  	}
> +
> +	/*
> +	 * sanity check that event_sched_out() does not and will not
> +	 * change the state of ctx->rotate_necessary
> +	 */
> +	WARN_ON(was_necessary != event->ctx->rotate_necessary);

It doesn't... why is this important to check?

> +	/*
> +	 * if we remove an event AND we were multiplexing then, that means
> +	 * we had more events than we have counters for, and thus, at least,
> +	 * one event was in INACTIVE state. Now, that we removed an event,
> +	 * we need to resched to give a chance to all events to get scheduled,
> +	 * otherwise some may get stuck.
> +	 *
> +	 * By the time this function is called the event is usually in the OFF
> +	 * state.
> +	 * Note that this is not a duplicate of the same code in _perf_event_disable()
> +	 * because the call path are different. Some events may be simply disabled

It is the exact same code twice though; IIRC this C language has a
feature to help with that.

> +	 * others removed. There is a way to get removed and not be disabled first.
> +	 */
> +	if (ctx->rotate_necessary && ctx->nr_events) {
> +		int type = get_event_type(event);
> +		/*
> +		 * In case we removed a pinned event, then we need to
> +		 * resched for both pinned and flexible events. The
> +		 * opposite is not true. A pinned event can never be
> +		 * inactive due to multiplexing.
> +		 */
> +		if (type & EVENT_PINNED)
> +			type |= EVENT_FLEXIBLE;
> +		ctx_resched(cpuctx, cpuctx->task_ctx, type);
> +	}

What you're relying on is that ->rotate_necessary implies ->is_active
and there's pending events. And if we tighten ->rotate_necessary you can
remove the && ->nr_events.

> @@ -2232,6 +2270,35 @@ static void __perf_event_disable(struct perf_event *event,
>  		event_sched_out(event, cpuctx, ctx);
>  
>  	perf_event_set_state(event, PERF_EVENT_STATE_OFF);
> +	/*
> +	 * sanity check that event_sched_out() does not and will not
> +	 * change the state of ctx->rotate_necessary
> +	 */
> +	WARN_ON_ONCE(was_necessary != event->ctx->rotate_necessary);
> +
> +	/*
> +	 * if we disable an event AND we were multiplexing then, that means
> +	 * we had more events than we have counters for, and thus, at least,
> +	 * one event was in INACTIVE state. Now, that we disabled an event,
> +	 * we need to resched to give a chance to all events to be scheduled,
> +	 * otherwise some may get stuck.
> +	 *
> +	 * Note that this is not a duplicate of the same code in
> +	 * __perf_remove_from_context()
> +	 * because events can be disabled without being removed.

It _IS_ a duplicate, it is the _exact_ same code twice. What you're
trying to say is that we need it in both places, but that's something
else entirely.

> +	 */
> +	if (ctx->rotate_necessary && ctx->nr_events) {
> +		int type = get_event_type(event);
> +		/*
> +		 * In case we removed a pinned event, then we need to
> +		 * resched for both pinned and flexible events. The
> +		 * opposite is not true. A pinned event can never be
> +		 * inactive due to multiplexing.
> +		 */
> +		if (type & EVENT_PINNED)
> +			type |= EVENT_FLEXIBLE;
> +		ctx_resched(cpuctx, cpuctx->task_ctx, type);
> +	}
>  }


