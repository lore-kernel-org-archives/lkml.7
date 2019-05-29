Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CC4C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFA02070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M3EnNLp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfE2H51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 03:57:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59908 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfE2H51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wFXL69+e9FA8T4bdG84SBXZny14soC0SfpQJDLWkYx4=; b=M3EnNLp1Cc9fiAjrltyjRQQfH
        YyyDpA9ZxG8zhyWf+mBrd+4sQAkmFloMRli3OaTx64lNU8GvoK6ZlYVGfoKzjDAfxHFTpCCI6oGoL
        FQEbcCJZ2MkxSrGAdOn/v3z6m5IXvXUXw5EUT9l/QxdNjul4FctOiJpE1sLApwKv2deMk6Zc0SBpq
        yCCKndWjw1+qmuB/9ZtXju8YJlLmf5bYSQdy+N2kf3P+KDIoSwoatgtXSdIahv5yam5lSt1j2SSvL
        Z4FVqGdTcTNRLZGNdwI00M4IM4BWkA+JKi+DOsYnBjXtQ8IzqBnZF84wG2lmQMzsE8YgnFl8RzZR+
        EPPIX7X7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVtSc-0002IT-1T; Wed, 29 May 2019 07:57:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BCAA6201A7E41; Wed, 29 May 2019 09:57:20 +0200 (CEST)
Date:   Wed, 29 May 2019 09:57:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 4/9] perf/x86/intel: Support hardware TopDown metrics
Message-ID: <20190529075720.GB2623@hirez.programming.kicks-ass.net>
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-5-kan.liang@linux.intel.com>
 <20190528134845.GQ2623@hirez.programming.kicks-ass.net>
 <2d693635-9697-2cf5-54dc-b91da4dfd14f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d693635-9697-2cf5-54dc-b91da4dfd14f@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 02:24:56PM -0400, Liang, Kan wrote:
> 
> 
> On 5/28/2019 9:48 AM, Peter Zijlstra wrote:
> > On Tue, May 21, 2019 at 02:40:50PM -0700, kan.liang@linux.intel.com wrote:
> > > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > > index b980b9e95d2a..0d7081434d1d 100644
> > > --- a/include/linux/perf_event.h
> > > +++ b/include/linux/perf_event.h
> > > @@ -133,6 +133,11 @@ struct hw_perf_event {
> > >   			struct hw_perf_event_extra extra_reg;
> > >   			struct hw_perf_event_extra branch_reg;
> > > +
> > > +			u64		saved_metric;
> > > +			u64		saved_slots;
> > > +			u64		last_slots;
> > > +			u64		last_metric;
> > 
> > This is really sad, and I'm thinking much of that really isn't needed
> > anyway, due to how you're not using some of the other fields.
> 
> If we don't cache the value, we have to update all metrics events when
> reading any metrics event. I think that could bring high overhead.

Since you don't support sampling, or even 'normal' functionality on this
FIXED3/SLOTS thing, you'll not use prev_count, sample_period,
last_period, period_left, interrupts_seq, interrupts, freq_time_stamp
and freq_count_stamp.

So why do you then need to grow the data structure with 4 more nonsense
fields?

Also, I'm not sure what you need those last things for, you reset the
value to 0 every time you read them, there is no delta to track.
