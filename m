Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E9EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF4A2053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YElJ2j2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfICHrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 03:47:49 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50000 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfICHrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 03:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gGHouZH/ciuLGyIRExd41CGKa87B1imPF/6rkdY3lbg=; b=YElJ2j2cjWJ1exLoHh9Lpbmqv
        hw/wtXMaB3TTMwc3g/SkOPult+gnfJTXSOgShNqQGiQPi4FGnWKO/L8hYZ8LjTKSbBeyedGsCJeC1
        i/54yD30lPgCOwNoFj0uo+VQx/rSy3VIq1OVP/s8ECk13akb2FnpThTCis945OyiaA8GDkFYAXTq4
        cGlDPArMTzyEOD6UFjDOjUIrKJw87nWQHX/LzmWMwX/wWrjd2kNCBPkDIU8KLZhfOxrBGd3vbTVAs
        o9NBmUVOaBzJoFfjS6pDqkx5YuqAB9x9gPhIHNYCR90rjzFGNkwGS3/Z/3F1VPFP4mvNwnxfjWLkR
        +sgHpbtfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i53X6-0003Gi-RF; Tue, 03 Sep 2019 07:47:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AF5DF306010;
        Tue,  3 Sep 2019 09:46:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 75C3A29BA4608; Tue,  3 Sep 2019 09:47:18 +0200 (CEST)
Date:   Tue, 3 Sep 2019 09:47:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 2/3] task: RCU protect tasks on the runqueue
Message-ID: <20190903074718.GT2386@hirez.programming.kicks-ass.net>
References: <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
 <20190830160957.GC2634@redhat.com>
 <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
 <87o906wimo.fsf@x220.int.ebiederm.org>
 <20190902134003.GA14770@redhat.com>
 <87tv9uiq9r.fsf@x220.int.ebiederm.org>
 <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
 <87k1aqt23r.fsf_-_@x220.int.ebiederm.org>
 <878sr6t21a.fsf_-_@x220.int.ebiederm.org>
 <20190903074117.GX2369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903074117.GX2369@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 09:41:17AM +0200, Peter Zijlstra wrote:
> On Mon, Sep 02, 2019 at 11:52:01PM -0500, Eric W. Biederman wrote:
> 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 2b037f195473..802958407369 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> 
> > @@ -3857,7 +3857,7 @@ static void __sched notrace __schedule(bool preempt)
> >  
> >  	if (likely(prev != next)) {
> >  		rq->nr_switches++;
> > -		rq->curr = next;
> > +		rcu_assign_pointer(rq->curr, next);
> >  		/*
> >  		 * The membarrier system call requires each architecture
> >  		 * to have a full memory barrier after updating
> 
> This one is sad; it puts a (potentially) expensive barrier in here. And
> I'm not sure I can explain the need for it. That is, we've not changed
> @next before this and don't need to 'publish' it as such.
> 
> Can we use RCU_INIT_POINTER() or simply WRITE_ONCE(), here?

That is, I'm thinking we qualify for point 3 (both a and b) of
RCU_INIT_POINTER().
