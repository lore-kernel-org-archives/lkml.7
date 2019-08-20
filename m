Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111F1C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FA9206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UmsEXLmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbfHTPJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:09:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbfHTPJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JHlgi15dC5UewYnRImY+zgT5KbVe0tiRyqttLs7kJdA=; b=UmsEXLmktfEyEdQsQVh8SKTvu
        nSXQUXujeVsslm7r68lf8gK37QnZlcYaBN0mwKYYztO8X2eYUY0F+jgdeYHGUEd9l3Bkhdo5vZV/G
        0oLkrjWnwZTCZeaVcNavTsGMNdelfLzXS7tRFaSrfFT0vnSg2MqPWjA+sYyoeaDGnbeoADAUrx2pt
        V4GD+SaCTcTcugTCS6scBfBdZoAFqbkHqZFiS+Xa7khi6WmaRvKB9S4VBLbW9nMnsClulETekUMw/
        nVEw3ReE4iikfiZOp1FZblWDHNJXAQeHZSR3aQOBZrsTNYA3crJbY3ygSxji91ClbsJRQgq+eEwxf
        xfnZQZZNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i05lg-0003vm-7b; Tue, 20 Aug 2019 15:09:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E3E3B30768C;
        Tue, 20 Aug 2019 17:09:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2ED9520CF5BAA; Tue, 20 Aug 2019 17:09:50 +0200 (CEST)
Date:   Tue, 20 Aug 2019 17:09:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH] perf/x86: Consider pinned events for group validation
Message-ID: <20190820150950.GT2349@hirez.programming.kicks-ass.net>
References: <1565977750-76693-1-git-send-email-kan.liang@linux.intel.com>
 <20190820141014.GU2332@hirez.programming.kicks-ass.net>
 <776c7bf0-d779-7d27-9e05-b46cd299813b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <776c7bf0-d779-7d27-9e05-b46cd299813b@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 10:52:57AM -0400, Liang, Kan wrote:
> On 8/20/2019 10:10 AM, Peter Zijlstra wrote:
> > On Fri, Aug 16, 2019 at 10:49:10AM -0700, kan.liang@linux.intel.com wrote:
> > > From: Kan Liang <kan.liang@linux.intel.com>
> > > 
> > > perf stat -M metrics relies on weak groups to reject unschedulable
> > > groups and run them as non-groups.
> > > This uses the group validation code in the kernel. Unfortunately
> > > that code doesn't take pinned events, such as the NMI watchdog, into
> > > account. So some groups can pass validation, but then later still
> > > never schedule.
> > 
> > But if you first create the group and then a pinned event it 'works',
> > which is inconsistent and makes all this timing dependent.
> 
> I don't think so. The pinned event will be validated by validate_event(),
> which doesn't simulate the schedule.
> So the validation still pass, but the group still never schedule.

Exactly my point; so sometimes it fails creation and sometimes if fails
running. So now we have two failiure cases instead of one and the
reason might not always be evident.

> > > +	/*
> > > +	 * The new group must can be scheduled
> > > +	 * together with current pinned events.
> > > +	 * Otherwise, it will never get a chance
> > > +	 * to be scheduled later.
> > 
> > That's wrapped short; also I don't think it is sufficient; what if you
> > happen to have a pinned event on CPU1 (and not others) and happen to run
> > validation for a new CPU1 event on CPUn ?
> > 
> 
> The patch doesn't support this case.

Which makes the whole thing even more random.

> It is mentioned in the description.
> The patch doesn't intend to catch all possible cases that cannot be
> scheduled. I think it's impossible to catch all cases.
> We only want to improve the validate_group() a little bit to catch some
> common cases, e.g. NMI watchdog interacting with group.
> 
> > Also; per that same; it is broken, you're accessing the cpu-local cpuc
> > without serialization.
> 
> Do you mean accessing all cpuc serially?
> We only check the cpuc on current CPU here. It doesn't intend to access
> other cpuc.

There's nothing preventing the cpuc you're looking at changing while
you're looking at it. Heck, afaict it is possible to UaF here. Nothing
prevents the events you're looking at from going away and getting freed.
