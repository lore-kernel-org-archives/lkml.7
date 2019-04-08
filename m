Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66219C282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D8B20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JGrbyuYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfDHIWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:22:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54272 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDHIWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QYFM2r8ApWnkhG6CF3UeQCeWjU2P81rZ50Qu9OE9ZdU=; b=JGrbyuYLQAOxaWLmBuKm8uAur
        Hxo1/clWd3mc/eAAVxx9AUpWOeK4SPZGvww4TgNt5Tr0EUc+6jQAQ35Bdd5YZPNOrfWJzssGObx5i
        aQX1g0eCiwpfEFztIIefiweAR2AyHBMBiOjMh7lTM2rxGjzU9oZY0hUJewpsrxSn2U+oClfkWHv/f
        apBaNRo/GaxxocYjgJUtfyU+/WR2/4huwQV1D/9mlEU5PsrvscVItz6SRwjJlTYGfqg39FWkW4jOC
        1xoBBZ0TLLQNXBEW8Be4k0R/F6cF58z7M3sKwyXthwFjsyVpZHrkVuuHh51KhqaKYl9vlZdlsCcl7
        1CqXx4Prg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDPXz-0005MX-R8; Mon, 08 Apr 2019 08:22:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1CD302038C24B; Mon,  8 Apr 2019 10:22:29 +0200 (CEST)
Date:   Mon, 8 Apr 2019 10:22:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>, acme@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: WARN_ON_ONCE() hit at kernel/events/core.c:330
Message-ID: <20190408082229.GI4038@hirez.programming.kicks-ass.net>
References: <ccef663c-8df9-4088-cc9b-804d6c751f18@linux.ibm.com>
 <20190403104103.GE4038@hirez.programming.kicks-ass.net>
 <eb3cbf9b-6851-72c6-2648-3e6eaa78fb7d@linux.ibm.com>
 <20190404110909.GY4038@hirez.programming.kicks-ass.net>
 <20190404130300.GF14281@hirez.programming.kicks-ass.net>
 <adcbac67-82b5-98a4-efb4-61c9ed870c15@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adcbac67-82b5-98a4-efb4-61c9ed870c15@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 09:12:28AM +0200, Thomas-Mich Richter wrote:
> > Does the below cure things? It's not exactly pretty, but it could just
> > do the trick.
> > 
> > ---
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index dfc4bab0b02b..d496e6911442 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -2009,8 +2009,8 @@ event_sched_out(struct perf_event *event,
> >  	event->pmu->del(event, 0);
> >  	event->oncpu = -1;
> >  
> > -	if (event->pending_disable) {
> > -		event->pending_disable = 0;
> > +	if (event->pending_disable == smp_processor_id()) {
> > +		event->pending_disable = -1;
> >  		state = PERF_EVENT_STATE_OFF;
> >  	}
> >  	perf_event_set_state(event, state);
> > @@ -2198,7 +2198,7 @@ EXPORT_SYMBOL_GPL(perf_event_disable);
> >  
> >  void perf_event_disable_inatomic(struct perf_event *event)
> >  {
> > -	event->pending_disable = 1;
> > +	event->pending_disable = smp_processor_id();
> >  	irq_work_queue(&event->pending);
> >  }
> >  
> > @@ -5822,8 +5822,8 @@ static void perf_pending_event(struct irq_work *entry)
> >  	 * and we won't recurse 'further'.
> >  	 */
> >  
> > -	if (event->pending_disable) {
> > -		event->pending_disable = 0;
> > +	if (event->pending_disable == smp_processor_id()) {
> > +		event->pending_disable = -1;
> >  		perf_event_disable_local(event);
> >  	}
> >  
> > @@ -10236,6 +10236,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
> >  
> >  
> >  	init_waitqueue_head(&event->waitq);
> > +	event->pending_disable = -1;
> >  	init_irq_work(&event->pending, perf_pending_event);
> >  
> >  	mutex_init(&event->mmap_mutex);
> > 
> 
> Peter,
> 
> very good news, your fix ran over the weekend without any hit!!!
> 
> Thanks very much for your help. Do you submit this patch to the kernel mailing list?

Most excellent, let me go write a Changelog.

Could I convince you to implement arch_irq_work_raise() for s390?
