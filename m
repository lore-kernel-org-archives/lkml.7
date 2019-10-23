Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E59CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF5520650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3Ma/9YRa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392473AbfJWP3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 11:29:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49462 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732725AbfJWP3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YiS0cerYCIiVMA5WVjTZh2HXHttAk39sYz0Qhued9es=; b=3Ma/9YRaysm2dYKupiYEzEzgZ
        /O+BE/YlpCB4tt4q9LIIVQo16Px0sRy7IXgVNV4KOPqzrlHLPLGgcHNm9zjmnoE2XahHKk/NspESH
        RRP0gZjYKVHcgNQcnlb96YKCPC8yyr5vciPrbSJgBlLhCWFFywmcFf0zBJ2x2uQZSfv8ZgGsd/8no
        PZni7BOrKWNN1Y18/ShVoWZcejy3igAl29216Jmg+T3fgJWR/mdjU22T/7KHUIv4fWxeBJqjfnHCI
        1G7UPmDuibql+pLbrGPj8v7jkSOc0BuzKPjkHp0O1t8CvgbSAWesyGzRfBK+ikM3+K97R3wynyRxp
        gkr36L+Vw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNIZd-0007qY-Qg; Wed, 23 Oct 2019 15:29:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 48431300C3C;
        Wed, 23 Oct 2019 17:28:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 445DC2B1ADEC7; Wed, 23 Oct 2019 17:29:20 +0200 (CEST)
Date:   Wed, 23 Oct 2019 17:29:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, mingo@elte.hu,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Liang, Kan" <kan.liang@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf/core: fix multiplexing event scheduling issue
Message-ID: <20191023152920.GG19358@hirez.programming.kicks-ass.net>
References: <20191018002746.149200-1-eranian@google.com>
 <20191021100558.GC1800@hirez.programming.kicks-ass.net>
 <CABPqkBRgBegcdNHtXUqkdfJUASjuUYnSkh_cNeqfoO4wF7tnFQ@mail.gmail.com>
 <20191023093757.GR1817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023093757.GR1817@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 11:37:57AM +0200, Peter Zijlstra wrote:
> Further, since we set it on reschedule, I propose you change the above
> like:
> 
> 	if (ctx->rotate_necessary) {
> 		int type = get_event_type(event);
> 		/*
> 		 * comment..
> 		 */
> 		if (type & EVENT_PINNED)
> 			type |= EVENT_FLEXIBLE;
> +		/*
> +		 * Will be reset by ctx_resched()'s flexible_sched_in().
> +		 */
> +		ctx->rotate_necessary = 0;
> 		ctx_resched(cpuctx, cpuctx->task_ctx, type);
> 	}

n/m, that is already done through ctx_sched_out().
