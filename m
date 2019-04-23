Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8107C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F0C20645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RJ4R54eN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfDWN0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:26:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49290 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfDWN0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BdM6CArgxEm22HVbHd3GaZ5CV6hbS9CSRE8mWJGcDtc=; b=RJ4R54eN+qh1iuz/f39xpMin1
        BFHUaJ/xdY+5M84Z9GZ8bVrNb+OeGnqiX8Z/G/HZBBgFDmtgC09JwD+6S6HhM0YRZUIIV8rhej1bD
        VD862VKwmY66Bxvt3yArtQYKrnFODhEmAqvovixM96iKBn/FaJfKqgV/bgf57FUpW+G7j7n0zO+LK
        RYUL+XmZtiRhSwUMtmfDU6y3WwNWqu1Aig6opZYRLbm8I25R2/0V8F18dlmjQ4QzqWEOuEMimXiF6
        ZyqeQM+jdYl73H5dToPNZeSJZRPBnTMKs835ucgxNGlf8xAULWUthmTuGlBnp1C+6pMgWXdsnakMp
        dlamRMA7w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIvRG-0004mU-D1; Tue, 23 Apr 2019 13:26:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9468229C2338C; Tue, 23 Apr 2019 15:26:20 +0200 (CEST)
Date:   Tue, 23 Apr 2019 15:26:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Luc Maranget <luc.maranget@inria.fr>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] Documentation: atomic_t.txt: Explain ordering provided
 by smp_mb__{before,after}_atomic()
Message-ID: <20190423132620.GU4038@hirez.programming.kicks-ass.net>
References: <Pine.LNX.4.44L0.1904191312200.1406-100000@iolanthe.rowland.org>
 <20190419180017.GP4038@hirez.programming.kicks-ass.net>
 <20190419182620.GF14111@linux.ibm.com>
 <1555719429.t9n8gkf70y.astroid@bobo.none>
 <20190420085440.GK14111@linux.ibm.com>
 <20190423121715.GQ4038@hirez.programming.kicks-ass.net>
 <20190423132116.GJ3923@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423132116.GJ3923@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 06:21:16AM -0700, Paul E. McKenney wrote:
> On Tue, Apr 23, 2019 at 02:17:15PM +0200, Peter Zijlstra wrote:
> > On Sat, Apr 20, 2019 at 01:54:40AM -0700, Paul E. McKenney wrote:
> > > 3.	Make non-value-returning atomics provide full ordering.
> > > 	This would of course need some benchmarking, but would be a
> > > 	simple change to make and would eliminate a large class of
> > > 	potential bugs.  My guess is that the loss in performance
> > > 	would be non-negligible, but who knows?
> > 
> > Well, only for the architectures that have
> > smp_mb__{before,after}_atomic() as barrier(), which are: ia64, mips,
> > s390, sparc, x86 and xtense.
> 
> The weakly ordered architectures would need to add the equivalent of
> smp_mb() before and after, right?  This might result in a more noticeable
> loss of performance.

The weak archs already have: smp_mb__{before,after}_atomic() :=
smp_mb().


