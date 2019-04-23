Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C35AC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2645B218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fL9Xx94R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfDWTet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:34:49 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53994 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWTet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 15:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sU0OH+OkE04CbdTPlNqdVi5ayyffGhhufijK4RmPgH4=; b=fL9Xx94RnBlU1urhwz8ErZ98q
        oMyGhyio9tneubY3y71Xz7qiZITIx17HlwFChQES6UleQWvY+tlh8/AiGqRLA9p094KaUD0g4ZBRy
        8P6Pv6Y4qzRcSQsZpfda5nn1LoNn34RMyMYaEgaqufxqZLPfazz5y1Ihk5g8FoKVrLgmmd6+MF1d0
        fS9a/7fbai0Xj6wXNMbFPCGyAS6+BCgmEoh9HzZuXFAR9LQlb+D07tnilNbf9F+2Pd33HpAHw0JXz
        B0kP8kTPbgFgvEHmuxRz3ZJGqbaiULZ6A5YLNks0ks8DFes952z0YK3YG6yOlSzZuligXf2BKvdfz
        8yEA+vW0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJ1Be-0000gU-6i; Tue, 23 Apr 2019 19:34:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D86129C30E09; Tue, 23 Apr 2019 21:34:35 +0200 (CEST)
Date:   Tue, 23 Apr 2019 21:34:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4 14/16] locking/rwsem: Guard against making count
 negative
Message-ID: <20190423193435.GX4038@hirez.programming.kicks-ass.net>
References: <4cbd3c18-c9c0-56eb-4e01-ee355a69057a@redhat.com>
 <20190419102647.GP7905@worktop.programming.kicks-ass.net>
 <20190419120207.GO4038@hirez.programming.kicks-ass.net>
 <20190419130304.GV14281@hirez.programming.kicks-ass.net>
 <20190419131522.GW14281@hirez.programming.kicks-ass.net>
 <57620139-92a3-4a21-56bd-5d6fff23214f@redhat.com>
 <7b1bfc26-6e90-bd65-ab46-08413acd80e9@redhat.com>
 <20190423141714.GO11158@hirez.programming.kicks-ass.net>
 <CAHk-=whnQJ9YDrkcKteNSACMJxzw1bL0RPfGQsey_9Nm7b8mnw@mail.gmail.com>
 <4f62d7f2-e5f6-500e-3e70-b1d1978f7140@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f62d7f2-e5f6-500e-3e70-b1d1978f7140@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 03:12:16PM -0400, Waiman Long wrote:
> On 4/23/19 12:27 PM, Linus Torvalds wrote:
> > On Tue, Apr 23, 2019 at 7:17 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >> I'm not aware of an architecture where disabling interrupts is faster
> >> than disabling preemption.
> > I don't thin kit ever is, but I'd worry a bit about the
> > preempt_enable() just because it also checks if need_resched() is true
> > when re-enabling preemption.
> >
> > So doing preempt_enable() as part of rwsem_read_trylock() might cause
> > us to schedule in *exactly* the wrong place,
> 
> You are right on that. However, there is a variant called
> preempt_enable_no_resched() that doesn't have this side effect. So I am
> going to use that one instead.

Only if the very next line is schedule(). Otherwise you're very much not
going to use that function.
