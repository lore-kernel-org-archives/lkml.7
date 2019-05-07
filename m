Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD5AC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C21D20578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WxvP46DA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfEGLkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 07:40:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38514 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfEGLkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 07:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FMOKuwYNHx8c/DxvlU6d8k+HpHk0o0d8G2tQYFCZEw4=; b=WxvP46DAE+yj4H7b9/KzeFr50
        3tt9tKYMQScKNXHp4CWXSyMdcYUWOW7XJR9dg+ELTDES/f9P7OZG4CSwn8VasaTAD1n/hiLChRA8m
        5wEYxnlLcCZCSn1EygA4AoAlRdZdhrV123inCFiEJxS6bL/Z1H+9Tux8tLcfincXSyslH3RevFWQX
        c8rOkQ4pNOt1ayHd3WWN6Z/xICRrGir9v/WKAf9BPAs9w5vrATpjcxXIZSuQB9Pfcw4B14s4Y0NCI
        1GA5kKstybuJo/o6qs2TrBEsjeKioo/GAl0A6nUlTzMzCYWpGz0/87PQbKjY5yQIPzlJSnSFqbH0J
        y8v84EFeA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hNySc-0006bM-A5; Tue, 07 May 2019 11:40:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DAD20202508A1; Tue,  7 May 2019 13:40:06 +0200 (CEST)
Date:   Tue, 7 May 2019 13:40:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf: allow non-privileged uprobe for user processes
Message-ID: <20190507114006.GS2606@hirez.programming.kicks-ass.net>
References: <20190507074315.3337668-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507074315.3337668-1-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 12:43:15AM -0700, Song Liu wrote:
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index abbd4b3b96c2..0508774d82e4 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8532,9 +8532,10 @@ static int perf_tp_event_match(struct perf_event *event,
>  	if (event->hw.state & PERF_HES_STOPPED)
>  		return 0;
>  	/*
> -	 * All tracepoints are from kernel-space.
> +	 * All tracepoints except uprobes are from kernel-space.
>  	 */
> -	if (event->attr.exclude_kernel)
> +	if (event->attr.exclude_kernel &&
> +	    ((event->tp_event->flags & TRACE_EVENT_FL_UPROBE) == 0))

That doesn't make sense; should you not be checking user_mode(regs)
instead?

