Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB13AC04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8502075C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n0a/et07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfE2Hyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 03:54:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35936 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfE2Hyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ma8dfRIf50m6FQgzwGAwfa76I2p3gK7P2g7IlG5PKDA=; b=n0a/et07D8PFMte5C043I4pZJ
        OfSUVkUln1OPXFPL3MSht9gah3dgTstHFpjf3P5WgZfNrO7aOWu8eNiYHmx51xBLO8z5fYFKrRc09
        RXp3+cdvZsCZzAlhsBEitHHbufMbBhJtKUvtO8jpP7ug1sisOvuPD8utshApfeveLpOwogkP4jxRb
        7831V9Bqx3OUc53ccRrkgHKT3UAKLGjSmugN6pat0SK6jPU1i2zIf6s2adHeyqAXAM+qQbpl6eyR+
        j5x0D8x+BQOQaoakpTrp1CLBQNHRgVkyPG1CjYFtCQ/l4RdqZ6ymEiFCfJB03CZqqeox+Fhb6baF7
        4IIeZOJug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVtPo-0004Qr-HU; Wed, 29 May 2019 07:54:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E97D6201A7E41; Wed, 29 May 2019 09:54:26 +0200 (CEST)
Date:   Wed, 29 May 2019 09:54:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 4/9] perf/x86/intel: Support hardware TopDown metrics
Message-ID: <20190529075426.GA2623@hirez.programming.kicks-ass.net>
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-5-kan.liang@linux.intel.com>
 <20190528134354.GP2623@hirez.programming.kicks-ass.net>
 <561ec469-2e0b-4749-c184-d07e4f4eaf40@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <561ec469-2e0b-4749-c184-d07e4f4eaf40@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 02:24:38PM -0400, Liang, Kan wrote:
> 
> 
> On 5/28/2019 9:43 AM, Peter Zijlstra wrote:
> > On Tue, May 21, 2019 at 02:40:50PM -0700, kan.liang@linux.intel.com wrote:
> > > @@ -3287,6 +3304,13 @@ static int core_pmu_hw_config(struct perf_event *event)
> > >   	return intel_pmu_bts_config(event);
> > >   }
> > > +#define EVENT_CODE(e)	(e->attr.config & INTEL_ARCH_EVENT_MASK)
> > > +#define is_slots_event(e)	(EVENT_CODE(e) == 0x0400)
> > > +#define is_perf_metrics_event(e)				\
> > > +		(((EVENT_CODE(e) & 0xff) == 0xff) &&		\
> > > +		 (EVENT_CODE(e) >= 0x01ff) &&			\
> > > +		 (EVENT_CODE(e) <= 0x04ff))
> > > +
> > 
> > That is horrific.. (e & INTEL_ARCH_EVENT_MASK) & 0xff is just daft,
> > that should be: (e & ARCH_PERFMON_EVENTSEL_EVENT).
> > 
> > Also, we already have fake events for event=0, see FIXED2, why are we
> > now using event=0xff ?
> 
> I think event=0 is for genuine fixed events. Metrics events are fake events.
> I didn't find FIXED2 in the code. Could you please share more hints?

cd09c0c40a97 ("perf events: Enable raw event support for Intel unhalted_reference_cycles event")

We used the fake event=0x00, umask=0x03 for CPU_CLK_UNHALTED.REF_TSC,
because that was not available as a generic event, *until now* it seems.
I see ICL actually has it as a generic event, which means we need to fix
up the constraint mask for that differently.

But note that for all previous uarchs this event did not in fact exist.

It appears the TOPDOWN.SLOTS thing, which is available in in FIXED3 is
event=0x00, umask=0x04, is indeed a generic event too.
