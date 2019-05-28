Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DB2C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A01B208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bfv6NsKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfE1IXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:23:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfE1IXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LP7MPvy+aRLztWp8FooOU46PduDbMP/P2yCoPdAhii4=; b=Bfv6NsKQPlJ1Cucg5kXZFT2Bd
        +QtcLKV0C18BDGh+NRth9XpK5j066yfliQHMZL9GtkjrvLvxjl3c25VrpmacauYxXvKFaz77Idi5H
        fOXvqd3RU8C7PedJUgErkZlYSiTkV4Nl+RWzBEUbI1n3QVpWMNMoQLVZsiKyZAVetARjrkEudB4WJ
        X3CMrRJnMdYRjLYS0FjGw+up2y8Wrv3fQZPaAFAKudaJB8Fp3pDBneBcDRLFRj4Rstl0yp3meu+pZ
        kmUf84oxB8aXz4ip9Ae8OdxhbQAUQufQwo85e+OFfTjnCu/Z1Wsyjo4YiAhrVeL/0jo2Qp0ZXh+Kv
        ZQU9iEjkQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVXNn-0003Cf-AF; Tue, 28 May 2019 08:22:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 62CFF20297D49; Tue, 28 May 2019 10:22:53 +0200 (CEST)
Date:   Tue, 28 May 2019 10:22:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v4] locking/lock_events: Use this_cpu_add() when necessary
Message-ID: <20190528082253.GK2623@hirez.programming.kicks-ass.net>
References: <20190524194222.8398-1-longman@redhat.com>
 <20190527082326.GP2623@hirez.programming.kicks-ass.net>
 <CAHk-=wgr-2kxGU=AXFbW=00qOHCA0eb_Ky0Bq9aeBKOegaFxNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgr-2kxGU=AXFbW=00qOHCA0eb_Ky0Bq9aeBKOegaFxNg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 12:33:56PM -0700, Linus Torvalds wrote:
> On Mon, May 27, 2019 at 1:23 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > That's disguisting... I see Linus already applied it, but yuck. That's
> > what we have raw_cpu_*() for.
> 
> Ahh, I tried to look for that, but there was enough indirection and
> confusion that I wasn't sure they were generically available.
> 
> And the "raw_cpu_*()" functions are rare enough that I'd never
> encountered them enough to really be aware of them. In fact, we seem
> to have exactly _one_ user of "raw_cpu_add()" in the whole kernel, and
> a handful of "raw_cpu_inc()".

Yeah, not having many is good. From a correctness PoV they're basically
always the wrong thing to use, except for this one usecase where we
prefer speed over correctness.

> But ack on your patch, and a heartfelt "yeah, that's the right thing". Thanks,

Thanks, I'll go write me a Changelog then ;-)
