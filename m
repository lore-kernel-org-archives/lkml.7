Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6322BC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337922085A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q+LAgf1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfENP6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 11:58:49 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38414 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfENP6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 11:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uEG6RAbenetSOMt2p9wGwy8CK7MGZhuTPCJ+MQ39rqU=; b=q+LAgf1KxBqb6/SCaU1L7GtjIF
        kDReAoucGpNYabwwnltrdstTqskmLN4GIHlOa3uY8I35Rk8/VcqoQHpx5Vm/XZo0pW3GrcSqMAZpI
        nk9185FKy/dY5nH594dnb3Jetb8Q4vGQXnLNTPfrcl/9alvgWxYyHUjvW0IJscOGVsYL9oxN7QmCR
        5cQkgJmCnBswxrl2Amz9FDI4g9RJV0/QGdA5lzwIS/GGucJv4xcuPfI5StaCxCrf166f1pC+/FJ7k
        +6X7mLZmjTh/j43/jyvh7wieNqyCRXxsPLnzKFrO8885cv683+/ZVJd65Y412ChiSV5Oq5L1ADWCR
        QhXusegg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQZol-0000Wc-Bp; Tue, 14 May 2019 15:58:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9AF8F2029F877; Tue, 14 May 2019 17:58:13 +0200 (CEST)
Date:   Tue, 14 May 2019 17:58:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     huangpei@loongson.cn
Cc:     Paul Burton <paul.burton@mips.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Huacai Chen <chenhc@lemote.com>
Subject: Re: Re: [RFC][PATCH 2/5] mips/atomic: Fix loongson_llsc_mb() wreckage
Message-ID: <20190514155813.GG2677@hirez.programming.kicks-ass.net>
References: <20190424123656.484227701@infradead.org>
 <20190424124421.636767843@infradead.org>
 <20190424211759.52xraajqwudc2fza@pburton-laptop>
 <2b2b07cc.bf42.16a52dc4e4d.Coremail.huangpei@loongson.cn>
 <20190425073348.GV11158@hirez.programming.kicks-ass.net>
 <20190425091258.GC14281@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190425091258.GC14281@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I think this thread got 'lost'

On Thu, Apr 25, 2019 at 11:12:58AM +0200, Peter Zijlstra wrote:
> On Thu, Apr 25, 2019 at 09:33:48AM +0200, Peter Zijlstra wrote:
> > > Let me explain the bug more specific:
> > > 
> > > the bug ONLY matters in following situation:
> > > 
> > > #. more than one cpu (assume cpu A and B) doing ll/sc on same shared
> > > var V
> > > 
> > > #. speculative memory access from A cause A erroneously succeed sc
> > > operation, since the erroneously successful sc operation violate the
> > > coherence protocol. (here coherence protocol means the rules that CPU
> > > follow to implement ll/sc right)
> > > 
> > > #. B succeed sc operation too, but this sc operation is right both
> > > logically and follow the coherence protocol, and makes A's sc wrong
> > > logically since only ONE sc operation can succeed.
> 
> > > In one word， the bug only affect local cpu‘s ll/sc operation, and
> > > affect MP system.
> 
> > > PS:
> > > 
> > > If local_t is only ll/sc manipulated by current CPU， then no need fix it.
> > 
> > It _should_ be CPU local, but this was not at all clear from reading the
> > original changelog nor the comment with loongson_llsc_mb().
> 
> However, if it is a coherence issue, the thing is at the cacheline
> level, and there is nothing that says the line isn't shared, just the
> one variable isn't.
> 
> Ideally there should be minimal false sharing, but....

So if two variables share a line, and one is local while the other is
shared atomic, can contention on the line, but not the variable, cause
issues for the local variable?

If not; why not? Because so far the issue is line granular due to the
coherence aspect.
