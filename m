Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A70BC04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB8F208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="czrbPr28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfE2Hau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 03:30:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35164 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfE2Hau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QWfZaBHW4KrPHBXEhRILiR8hZRsdefnT2/M4lXG3ymE=; b=czrbPr28PvQ+6Qt31K7mct8r7
        MvhKT6DCNWUKDIv5aI235FQJWI2inlwQkOuOsZvCAsKveDakEUaz9fYundTLnAJ1RKskkFBLGG47a
        0fr4VGQet5mVwxyK7YYJVbiN78clXIvcdcjYS5px0GmuCL8uUvo1uao1yL1LKzN1a2Z2knX0BwExz
        1kYr4N7NUKdJtZ9ZsoFS7Uz23PqZulnfrvTWrqcK8UmIiPQPZDM08lKKMoJLbbIh1NPTOjVXlJHm2
        t7DSvt/m18A0lhghOpxXOGnockAkkLhiTF7SGSY7bxw1BlJI5tsDeNJWLf3Qej+ftX2GfJ+PL8+0H
        a1xyy7HwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVt2s-0001Fa-Fl; Wed, 29 May 2019 07:30:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EFC0F201A7E41; Wed, 29 May 2019 09:30:44 +0200 (CEST)
Date:   Wed, 29 May 2019 09:30:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 4/9] perf/x86/intel: Support hardware TopDown metrics
Message-ID: <20190529073044.GY2623@hirez.programming.kicks-ass.net>
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-5-kan.liang@linux.intel.com>
 <20190528124349.GU2606@hirez.programming.kicks-ass.net>
 <287c2c84-25cf-fdce-a3c3-49a6ee93ae4c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <287c2c84-25cf-fdce-a3c3-49a6ee93ae4c@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 02:23:09PM -0400, Liang, Kan wrote:
> > > RDPMC
> > > =========
> > > The TopDown can be collected per thread/process. To use TopDown
> > > through RDPMC in applications on Icelake, the metrics and slots values
> > > have to be saved/restored during context switching.
> > > 
> > > Add specific set_period() to specially handle the slots and metrics
> > > event. Because,
> > >   - The initial value must be 0.
> > >   - Only need to restore the value in context switch. For other cases,
> > >     the counters have been cleared after read.
> > 
> > So the above claims to explain RDPMC, but doesn't mention that magic
> > value below at all. In fact, I don't see how the above relates to RDPMC
> > at all.
> 
> Current perf only support per-core Topdown RDPMC. On Icelake, it can be
> extended to per-thread Topdown RDPMC.
> It tries to explain the extra work for per-thread topdown RDPMC, e.g.
> save/restore slots and metrics value in context switch.

Right, this has what relation to RDPMC ?

> > > @@ -2141,7 +2157,9 @@ static int x86_pmu_event_idx(struct perf_event *event)
> > >   	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
> > >   		return 0;
> > > -	if (x86_pmu.num_counters_fixed && idx >= INTEL_PMC_IDX_FIXED) {
> > > +	if (is_metric_idx(idx))
> > > +		idx = 1 << 29;
> > 
> > I can't find this in the SDM RDPMC description. What does it return?
> 
> It will return the value of PERF_METRICS. I will add it in the changelog.

A comment would be even better.
