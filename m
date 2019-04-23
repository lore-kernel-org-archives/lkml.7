Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE26C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C659214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AR67rJjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfDWNkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:40:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49504 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfDWNkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y5x4SrRuOG6KqEv5SjoNKrRwTXVCdGEbhb9XQVsw16c=; b=AR67rJjv+UP1eHVJ2VGR1yZ1v
        TatE9hy4a62FXAqrTQjkOZ19cdYnX+aNt29yIWRQ9LmlV+1YnFkji6rG2QQs4yNhcUij7gdW10W0u
        fwodHhgs7DO628bPda+qCDSgB9y9bTv5mSM6KpXM5egVrlL3o8osyZ3fK/oxTD99EVlt7idE32obZ
        d/X7UFwLcQdAYpOPWZBHWoIweAj7Ly6piCBiB2K6RhfTwLjvruInpjd/aWu+IFkO05Op2cl6ZDzZ9
        6QQ0yDJ30d0zpkhcwCks/uMgWCJfQxULQkZngC6eozsUQOehT95VwHMf7qxLCZNTLnmOApCR6h0RI
        WbHURFUcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIveW-0004xz-EL; Tue, 23 Apr 2019 13:40:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35D6529C2338C; Tue, 23 Apr 2019 15:40:03 +0200 (CEST)
Date:   Tue, 23 Apr 2019 15:40:03 +0200
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
Message-ID: <20190423134003.GV4038@hirez.programming.kicks-ass.net>
References: <Pine.LNX.4.44L0.1904191312200.1406-100000@iolanthe.rowland.org>
 <20190419180017.GP4038@hirez.programming.kicks-ass.net>
 <20190419182620.GF14111@linux.ibm.com>
 <1555719429.t9n8gkf70y.astroid@bobo.none>
 <20190420085440.GK14111@linux.ibm.com>
 <20190423123209.GR4038@hirez.programming.kicks-ass.net>
 <20190423133010.GK3923@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423133010.GK3923@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 06:30:10AM -0700, Paul E. McKenney wrote:
> There are a great many that look like this:
> 
> 	smp_mb__before_atomic();
> 	clear_bit(NFSD4_CLIENT_UPCALL_LOCK, &clp->cl_flags);
> 	smp_mb__after_atomic();

Ooh, marvel at the comment describing the ordering there. Oh wait :-(
So much for checkpatch.pl I suppose.

I think the first is a release order for the 'LOCK' bit and the second
is because of wake_up_bit() being a shitty interface.

So maybe that should've been:

	clear_bit_unlock(NFSD4_CLIENT_UPCALL_LOCK, &clp->cl_flags);
	smp_mb__after_atomic();
	wake_up_bit(&clp->cl_flags, NFSD4_CLIENT_UPCALL_LOCK);

instead?
