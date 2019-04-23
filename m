Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA9DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3F121738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uCOSHCt3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfDWMcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:32:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59158 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfDWMcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qwUUbxM5GxoPZKNRXRfVIZulH7d9e6S8phCX3hQBc5s=; b=uCOSHCt34uLTwdA4nVwoax+27
        2QXc4DyJjlqVE1du+beBBLRh7Xz42GgN8+Avpgxde9qPcbkPJVDSeOrkrvqduG63PV4dpqTIWTcqN
        Dy7XS+M+3fnG97llLYw+kNV+LutgSqBaR2p/O3h/jBNJ7jZFpzIXgBDWr/ub7upDiMG01tgstlB2w
        6aVj+VySnBhlgBKQ0WwbL9JWKgiMiVZhyI2SjBOb+MNRNreZfwwfVv7ZP03CruoBUrNzsSiY0wrjm
        rDBoqof+1tWN9/WHfHL3inxl5/XSH/XWMGeS/nUGqff4kqwbKnCEWELfIDPyiw009DVzbx3sTjMct
        rQ0Q8xJaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIuap-0007oB-9c; Tue, 23 Apr 2019 12:32:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FA0229B8FE25; Tue, 23 Apr 2019 14:32:09 +0200 (CEST)
Date:   Tue, 23 Apr 2019 14:32:09 +0200
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
Message-ID: <20190423123209.GR4038@hirez.programming.kicks-ass.net>
References: <Pine.LNX.4.44L0.1904191312200.1406-100000@iolanthe.rowland.org>
 <20190419180017.GP4038@hirez.programming.kicks-ass.net>
 <20190419182620.GF14111@linux.ibm.com>
 <1555719429.t9n8gkf70y.astroid@bobo.none>
 <20190420085440.GK14111@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420085440.GK14111@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 01:54:40AM -0700, Paul E. McKenney wrote:
> 	And atomic_set(): set_preempt_state().	This fails
> 	on x86, s390, and TSO friends, does it not?  Or is
> 	this ARM-only?	Still, why not just smp_mb() before and
> 	after?	Same issue in __kernfs_new_node(), bio_cnt_set(),
> 	sbitmap_queue_update_wake_batch(), 
> 
> 	Ditto for atomic64_set() in __ceph_dir_set_complete().
> 
> 	Ditto for atomic_read() in rvt_qp_is_avail().  This function
> 	has a couple of other oddly placed smp_mb__before_atomic().

That are just straight up bugs. The atomic_t.txt file clearly specifies
the barriers only apply to RmW ops and both _set() and _read() are
specified to not be a RmW.

> 	And atomic_cmpxchg(): msc_buffer_alloc().  This instance
> 	of smp_mb__before_atomic() can be removed unless I am missing
> 	something subtle.  Ditto for kvm_vcpu_exiting_guest_mode(),
> 	pv_kick_node(), __sbq_wake_up(), 

Note that pv_kick_node() uses cmpxchg_relaxed(), which does not
otherwise imply barriers.

> 	And lock acquisition??? acm_read_bulk_callback().

I think it goes with the set_bit() earlier, but what do I know.

> 	In nfnl_acct_fill_info(), a smp_mb__before_atomic() after
> 	a atomic64_xchg()???  Also before a clear_bit(), but the
> 	clear_bit() is inside an "if".

Since it is _before, I'm thinking the pairing was intended with the
clear_bit(), and yes, then I would expect the smp_mb__before_atomic() to
be part of that same branch.

> 	There are a few cases that would see added overhead.  For example,
> 	svc_get_next_xprt() has the following:
> 
> 		smp_mb__before_atomic();
> 		clear_bit(SP_CONGESTED, &pool->sp_flags);
> 		clear_bit(RQ_BUSY, &rqstp->rq_flags);
> 		smp_mb__after_atomic();
> 
> 	And xs_sock_reset_connection_flags() has this:
> 
> 		smp_mb__before_atomic();
> 		clear_bit(XPRT_CLOSE_WAIT, &xprt->state);
> 		clear_bit(XPRT_CLOSING, &xprt->state);
> 		xs_sock_reset_state_flags(xprt);  /* Also a clear_bit(). */
> 		smp_mb__after_atomic();
> 
> 	Yeah, there are more than a few misuses, aren't there?  :-/
> 	A coccinelle script seems in order.  In 0day test robot.

If we can get it to flag the right patterns, then yes that might be
useful regardless of the issue at hand, people seem to get this one
wrong a lot.

> 	But there are a number of helper functions whose purpose
> 	seems to be to wrap an atomic in smp_mb__before_atomic() and
> 	smp_mb__after_atomic(), so some of the atomic_xxx_mb() functions
> 	might be a good idea just for improved readability.

Are there really sites where _mb() makes sense? The above is just a lot
of buggy code.
