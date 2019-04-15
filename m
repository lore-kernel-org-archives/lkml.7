Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C81C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9C820880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dm/ieGao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfDOPxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:53:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34518 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfDOPxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LO1RllZ/71tnHIfUtwFXLB6BFIjHkbH0y5hcmUBDVA8=; b=dm/ieGaoYMyCpo9uwiKcCSrKz
        Kl7yOtT5AwGoz0eus3tki78ToFCaIFC5a914DlkrKYRao+XxO5iOrLi0CQIXhNSPsVPTXLACwUut4
        JI9V3jJ9eWKjy7dEqO/IS+w/UkKfFFDlIzySRTa6ec2gTxbMIg/YTCGj3fgFt/uEMxTmMFDY6a25J
        4QAs6ydsGRssBHHFChnZgwl+M6WZuAx7Bp24JhD3bjPpJuoTFbE/U/Mgbwy6Vfl0y0n5KpbAB/f1s
        axqSiz3anP9JaoBocQs77I7R+MN97vazixpW3GBgQQ2v8fgIRifK7EVTEhM2tcu764n2QsplDw/AC
        vbg2l2ugg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hG3uv-0002d5-Tz; Mon, 15 Apr 2019 15:53:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 88F812038C257; Mon, 15 Apr 2019 17:53:08 +0200 (CEST)
Date:   Mon, 15 Apr 2019 17:53:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        ak@linux.intel.com, kan.liang@intel.com, mingo@elte.hu,
        nelson.dsouza@intel.com, jolsa@redhat.com, tonyj@suse.com
Subject: Re: [PATCH v2 1/2] perf/core: add perf_ctx_resched() as global
 function
Message-ID: <20190415155308.GP14281@hirez.programming.kicks-ass.net>
References: <20190408173252.37932-1-eranian@google.com>
 <20190408173252.37932-2-eranian@google.com>
 <20190415154537.GH12232@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415154537.GH12232@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:45:37PM +0200, Peter Zijlstra wrote:
> On Mon, Apr 08, 2019 at 10:32:51AM -0700, Stephane Eranian wrote:
> > This patch add perf_ctx_resched() a global function that can be called
> > to force rescheduling of events based on event types. The function locks
> > both cpuctx and task_ctx internally. This will be used by a subsequent patch.
> 
> I took out the task_ctx and event_type arguments.

> +void perf_ctx_resched(struct perf_cpu_context *cpuctx)
> +{
> +	struct perf_event_context *task_ctx = cpuctx->task_ctx;
> +
> +	perf_ctx_lock(cpuctx, task_ctx);
> +	ctx_resched(cpuctx, task_ctx, EVENT_ALL|EVENT_CPU);
> +	perf_ctx_unlock(cpuctx, task_ctx);
> +}

Hmm... I might just rework the thing to:

  perf_pmu_resched(struct pmu *pmu);

As that is what we want; esp. in the light of that whole core context
rewrite that i'm still sitting on :/
