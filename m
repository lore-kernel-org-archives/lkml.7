Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D254C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FE12073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qn/LUqf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfLDPob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:44:31 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34042 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbfLDPob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jaqgzM0fZ1bmgfEy1YIkwABQnEP68MUdp+w37tK5PBs=; b=Qn/LUqf4p/zFTHNJp0eyHLvWT
        YxGBlpRhNZ1hphz6KDFTQcycn/j0x8mcesVr9s1iD/yJ6aRm7y7WSSDlufnln2VO5zRxcsLagNXYw
        bVDEegqCK7HrL8lrG5XyQRIFMPyV2VqkBjtCeFmTKAXRov2Phwr5YSvobfYkgvBzb0GH+nTE76MAP
        FPtdwY4ZKG6OrICTCnhdoglW8+371/FX0w8WOGPqCZGjCOzYj9Y2rHDwkHiSk3732+pkxtV7WJGh0
        g/3jEYN0PLvSJd7s56PxDnqHiRb+U52715ig11TZNQmmUCHUp4jpV8m2Gh66+X9P8yFpg2uOTuMq1
        lPP9ds/fw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icWpG-0001wV-Na; Wed, 04 Dec 2019 15:44:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD7833060AF;
        Wed,  4 Dec 2019 16:43:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89EEB2871C357; Wed,  4 Dec 2019 16:44:24 +0100 (CET)
Date:   Wed, 4 Dec 2019 16:44:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Meelis Roos <mroos@linux.ee>, LKML <linux-kernel@vger.kernel.org>,
        x86@kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: UBSAN: Undefined behaviour in arch/x86/events/intel/p6.c:116:29
Message-ID: <20191204154424.GA2810@hirez.programming.kicks-ass.net>
References: <02f44ed5-13ac-f9c6-1f35-129c41006900@linux.ee>
 <20191202170633.GN2844@hirez.programming.kicks-ass.net>
 <0676c6ec-4475-62dc-b202-a62deaedd2dd@linux.ee>
 <20191204121540.GE20746@krava>
 <20191204150656.GX2844@hirez.programming.kicks-ass.net>
 <20191204152444.GA15573@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204152444.GA15573@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 04:24:44PM +0100, Jiri Olsa wrote:

> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index 9a89d98c55bd..f17417644665 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -1642,9 +1643,12 @@ static struct attribute_group x86_pmu_format_group __ro_after_init = {
> >  
> >  ssize_t events_sysfs_show(struct device *dev, struct device_attribute *attr, char *page)
> >  {
> > -	struct perf_pmu_events_attr *pmu_attr = \
> > +	struct perf_pmu_events_attr *pmu_attr =
> 
> ugh, did this do something weird? ;-)

No, but it's weird to explicitly concat the line outside of a macro, so
if 'fixed' it.

> >  		container_of(attr, struct perf_pmu_events_attr, attr);
> > -	u64 config = x86_pmu.event_map(pmu_attr->id);
> > +	u64 config = 0;
> > +
> > +	if (pmu_attr->id < x86_pmu.max_events)
> > +		x86_pmu.event_map(pmu_attr->id);
> 
> hum, should this be assigned to config?
> 
> 		config = x86_pmu.event_map(pmu_attr->id);

D'oh... Yes.

> >  
> >  	/* string trumps id */
> >  	if (pmu_attr->event_str)
