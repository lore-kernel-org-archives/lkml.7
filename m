Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A03CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099D02067B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S5YUav6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfJUKhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:37:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54916 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfJUKhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SssMt3eW+z2CI/cFwTW6F4urVB4aoQtUGwnCYEoR8S8=; b=S5YUav6lX2y7FicsXrF472bcD
        7uN1twe01t6mQLAE4MQeWkDKroNbo6lU9ZfaVYxdnvPaepkYXyJZyrz1tvP4/TY7JVUVlVpB5L4hz
        nDR3rFT3w6T6N986DiM6TfRKFUEUbDB7z8F/OotjqsozHXwX6m2PrX7L1jTUbHjEv/HpiagBRBZ/f
        w3tEnXdNNOHhcpbXG74zBjgzIb5wBO/YcFgCizHQyvofDlQPSc03nygNQCGnvcgm/vmjdRJVbtdCT
        Q3p96IA1hI4f73xMh6v4VPdoCLTnfpUUnF6iEmtNSA4qXPQKKhfQ8YOZyju+uOz1IQxTL1dGJI3EJ
        tAYDkFjzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMV4O-0002pL-2t; Mon, 21 Oct 2019 10:37:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 19247300EBF;
        Mon, 21 Oct 2019 12:36:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 27D942022BA17; Mon, 21 Oct 2019 12:37:45 +0200 (CEST)
Date:   Mon, 21 Oct 2019 12:37:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] perf/core,x86: synchronize PMU task contexts on
 optimized context switches
Message-ID: <20191021103745.GF1800@hirez.programming.kicks-ass.net>
References: <0b20a07f-d074-d3da-7551-c9a4a94fe8e3@linux.intel.com>
 <f3253a36-c174-8051-a462-9728ef721766@linux.intel.com>
 <20191021075942.GA8809@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021075942.GA8809@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 09:59:42AM +0200, Ingo Molnar wrote:
> 
> * Alexey Budankov <alexey.budankov@linux.intel.com> wrote:
> 
> > +			/*
> > +			 * PMU specific parts of task perf context may require
> > +			 * additional synchronization, at least for proper Intel
> > +			 * LBR callstack data profiling;
> > +			 */
> > +			pmu->sync_task_ctx(ctx->task_ctx_data,
> > +					   next_ctx->task_ctx_data);
> 
> Firstly, I'm pretty sure you never run this on a CPU where 
> pmu->sync_task_ctx is NULL, right? ;-)
> 
> Secondly, even on Intel CPUs in many cases we'll just call into a ~2 deep 
> function pointer based call hierarchy, just to find that nothing needs to 

See prototype here for getting rid of at least one layer of indirect
calls:

  https://lkml.kernel.org/r/20191007083831.26880701.6@infradead.org

> be done, because there's no LBR call stack maintained:
> 
> +       if (!one || !another)
> +               return;
> 
> So while it's technically a layering violation, it might make sense to 
> elevate this check to the generic layer and say that synchronization 
> calls by the core layer will always provide two valid pointers?

Alternatively we can write the thing like:

	if (pmu->swap_task_ctx)
		pmu->swap_task_ctx(ctx, next_ctx)
	else
		swap(ctx->task_ctx_data, next_ctx->task_ctx_data);


