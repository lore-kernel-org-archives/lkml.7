Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371C0C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077DE214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HJ8RIXtg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbfHTOKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:10:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54868 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729961AbfHTOKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WxJHVEIViyfLMpz7Bciv2LYQmHsR4TQVABk3sc5cjOo=; b=HJ8RIXtgA/NW9zIEuLeqQQ4he
        PS3CT9l7gQnY9EfnSxKf6utYeSIO11MucaJBBElhzPTsFy3HzMSF3225Dtp7pgI/1pXdrH/RcqNXg
        ToxnU6REp0h+jvHGUPU1Ti/JbrxN2cVo0xRijx6d9Bcmh3u7DKKJfbkux6MRAk5zobvLDBq0bGE8X
        JyV8dDASuD7bnMC+dTvWywnM1uafn77LHgm59OenA++cYZzNrZc1brkb6WWkPjoqNqzmmyKix6VV6
        qAVGE8Pl2Ev95VWu/933ECrklE+nF1MSplOWOhE2zMxWGGMmK0dUcGNA5moRnm1sfih4FHOzvMdSO
        1dSQDcXjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i04q0-0001vM-Ch; Tue, 20 Aug 2019 14:10:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1EAA0307456;
        Tue, 20 Aug 2019 16:09:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 58F3E20A99A14; Tue, 20 Aug 2019 16:10:14 +0200 (CEST)
Date:   Tue, 20 Aug 2019 16:10:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH] perf/x86: Consider pinned events for group validation
Message-ID: <20190820141014.GU2332@hirez.programming.kicks-ass.net>
References: <1565977750-76693-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565977750-76693-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 10:49:10AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> perf stat -M metrics relies on weak groups to reject unschedulable
> groups and run them as non-groups.
> This uses the group validation code in the kernel. Unfortunately
> that code doesn't take pinned events, such as the NMI watchdog, into
> account. So some groups can pass validation, but then later still
> never schedule.

But if you first create the group and then a pinned event it 'works',
which is inconsistent and makes all this timing dependent.

> @@ -2011,9 +2011,11 @@ static int validate_event(struct perf_event *event)
>   */
>  static int validate_group(struct perf_event *event)
>  {
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  	struct perf_event *leader = event->group_leader;
>  	struct cpu_hw_events *fake_cpuc;
> -	int ret = -EINVAL, n;
> +	struct perf_event *pinned_event;
> +	int ret = -EINVAL, n, i;
>  
>  	fake_cpuc = allocate_fake_cpuc();
>  	if (IS_ERR(fake_cpuc))
> @@ -2033,6 +2035,24 @@ static int validate_group(struct perf_event *event)
>  	if (n < 0)
>  		goto out;
>  
> +	/*
> +	 * The new group must can be scheduled
> +	 * together with current pinned events.
> +	 * Otherwise, it will never get a chance
> +	 * to be scheduled later.

That's wrapped short; also I don't think it is sufficient; what if you
happen to have a pinned event on CPU1 (and not others) and happen to run
validation for a new CPU1 event on CPUn ?

Also; per that same; it is broken, you're accessing the cpu-local cpuc
without serialization.

> +	 */
> +	for (i = 0; i < cpuc->n_events; i++) {
> +		pinned_event = cpuc->event_list[i];
> +		if (WARN_ON_ONCE(!pinned_event))
> +			continue;
> +		if (!pinned_event->attr.pinned)
> +			continue;
> +		fake_cpuc->n_events = n;
> +		n = collect_events(fake_cpuc, pinned_event, false);
> +		if (n < 0)
> +			goto out;
> +	}
> +
>  	fake_cpuc->n_events = 0;
>  	ret = x86_pmu.schedule_events(fake_cpuc, n, NULL);
>  
> -- 
> 2.7.4
> 
