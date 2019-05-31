Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AA9C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C1D26676
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tL1GT6mo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfEaJIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 05:08:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58958 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaJIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 05:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1bHe67ZMzZlGf0HYxrOOIqB9sFZ2/e7PsY66nGtu6ZE=; b=tL1GT6mo9h6RdsMJ0+qLgkhZ0
        4K8PqgIsUlKZ3DbHJGDLh9Qvaw56cQxJt1ZJruo2VjV6MYzXChvvsUoxPlyypBAy/fdKRrxsQi5wp
        LFYcB3JXFxnFvCziIdLUddzj5KVKCopIzDeW5TF1/76TBg11NiUtQElkrrSI9jE8BxuwrvEBoYpDz
        cTLKHbUKOP9x6aFJTf+vs8DnTFPB3JegbLMyFZXmjoUjukCwJSz6Ib129tcLEl+rccbsdxGoGeu8g
        qeb2dgsdZYXS8X51oicRhWubxj/OEddRi7+bz1zQ12xwg5d2noRj9/pKPsI/tFDwlY9b7X9nJHMvt
        hMgEBOqmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWdW7-0003Au-3T; Fri, 31 May 2019 09:08:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4630D201B8CFE; Fri, 31 May 2019 11:08:01 +0200 (CEST)
Date:   Fri, 31 May 2019 11:08:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH] ptrace: restore smp_rmb() in __ptrace_may_access()
Message-ID: <20190531090801.GM2677@hirez.programming.kicks-ass.net>
References: <20190529113157.227380-1-jannh@google.com>
 <20190529162120.GB27659@redhat.com>
 <CAG48ez3S1c_cd8RNSb9TrF66d+1AMAxD4zh-kixQ6uSEnmS-tg@mail.gmail.com>
 <20190530103405.GA6392@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530103405.GA6392@andrea>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 12:34:05PM +0200, Andrea Parri wrote:
> On Wed, May 29, 2019 at 07:38:46PM +0200, Jann Horn wrote:
> > On Wed, May 29, 2019 at 6:21 PM Oleg Nesterov <oleg@redhat.com> wrote:

> > > (I am wondering if smp_acquire__after_ctrl_dep() could be used instead, just to
> > >  make this code look more confusing)
> > 
> > Uuh, I had no idea that that barrier type exists. The helper isn't
> > even explicitly mentioned in Documentation/memory-barriers.rst. I
> > don't really want to use dark magic in the middle of ptrace access
> > logic...

Yeah, it's sorta not documented on purpose. It's too easy to get wrong
and we've only used it inside a number of more convenient primitives as
an optimzation.

I suppose we could add it to the section on control dependencies; just
to scare more people :-)

> > Anyway, looking at it, I think smp_acquire__after_ctrl_dep() doesn't
> > make sense here; quoting the documentation: "A load-load control
> > dependency requires a full read memory barrier, not simply a data
> > dependency barrier to make it work correctly". IIUC
> > smp_acquire__after_ctrl_dep() is for cases in which you would
> > otherwise need a full memory barrier - smp_mb() - and you want to be
> > able to reduce it to a read barrier.
> 
> It is supposed to be used when you want an ACQUIRE but you only have a
> control dependency (so you "augment the dependency" with this barrier).
> 
> FWIW, I do agree on the "dark magic"..., and I'd strongly recommend to
> not use this barrier (or, at least, to use it with high suspicion).

Right, so the purpose of the barrier is to upgrade a LOAD->STORE order
(as provided by the ctrl-dep) to a LOAD->{LOAD,STORE} order as would be
provided by load-acquire.

