Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B408DC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123B12083E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MCHUAZkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfDHFv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 01:51:26 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:38350 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfDHFv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 01:51:26 -0400
Received: by mail-pg1-f172.google.com with SMTP id j26so6644944pgl.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 22:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xKhzdA+EBwJkioaMRxYXXBo0eHNqGbLlYOcIi6GU7UQ=;
        b=MCHUAZkIQrqEoZL3QiMfCJDVSmAyTKJB9T/s9AoZ1/7B4P84IqCOcftQ2aH143rEwU
         WPSrEHzaXrwhqTmpLbn/lh8iSOEOC0ZqxvQIuDACIj2pJQKWlZLBqQ15f808ZLDjS/Zm
         q9e8rK55t4iyGqkHmWRe5Y/Z6c2Qyj7G3AgqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xKhzdA+EBwJkioaMRxYXXBo0eHNqGbLlYOcIi6GU7UQ=;
        b=hPsxjyo4FB+V7WIXYShRT3Tp4eaOjNaay6TcVlTsHWLUtMx476Rg0GmZ5/XLjKqQ/T
         6qQpIsPg4iu0Rl7rqmCVgO9ychaq3TmkXTQpxo7s/3V2iJPHHqNFBTNCZbTbhX7G5ZIy
         0B8LpMv5vnOb5blJoViwqbIe98hjqkHyaMznT9fwUX8ibRTzKMS4ONmzT99z2io0OxJT
         K1xr5NJrpgG/orl9KvWd/viD2B6LWxPH+Uf/G0Cv8fwhMMsfdfqtScxVD4r06nmcv9wn
         ogJbrwbGsrL+CjnsyTOGq5pvobrsFRqJGsoIy/Ef9ksxsHW7ztgqvwJmAj8Y84cGOV/d
         +uKg==
X-Gm-Message-State: APjAAAWGdD+yUPRANNSxsW/Uf3/FJHVbqHCycR5qfl0Csx3BdxaDEH5k
        nVOyjwNJCG6YLyRg4u91fcIDuw==
X-Google-Smtp-Source: APXvYqyY5vElQ4IEJl1QC7EmShsHq/GvcsE24zuoe/Ts9CFnsRun70FJqSR1MVE0RTRLzU1+swfSBg==
X-Received: by 2002:a62:4558:: with SMTP id s85mr27906331pfa.171.1554702685169;
        Sun, 07 Apr 2019 22:51:25 -0700 (PDT)
Received: from andrea ([63.64.74.251])
        by smtp.gmail.com with ESMTPSA id e126sm62526345pfh.35.2019.04.07.22.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 22:51:24 -0700 (PDT)
Date:   Mon, 8 Apr 2019 07:51:17 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Kroening <kroening@cs.ox.ac.uk>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Adding plain accesses and detecting data races in the LKMM
Message-ID: <20190408055117.GA25135@andrea>
References: <20190406004913.GA3828@andrea>
 <Pine.LNX.4.44L0.1904061135170.19196-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1904061135170.19196-100000@netrider.rowland.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > I'd have:
> > > > 
> > > > 	*x = 1; /* A */
> > > > 	smp_mb__before_atomic();
> > > > 	r0 = xchg_relaxed(x, 2); /* B (read or write part) */
> > > > 
> > > > 	=> (A ->barrier B)
> > > 
> > > Perhaps so.  It wasn't clear initially how these should be treated, so
> > > I just ignored them.  For example, what should happen here if there
> > > were other statements between the smp_mb__before_atomic and the
> > > xchg_relaxed?
> > 
> > I'd say that the link "A ->barrier B" should still be present and that
> > no other barrier-links should appear.  More formally, I am suggesting
> > that Before-atomic induced the following barrier-links:
> > 
> > 	[M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]
> 
> Hmmm, maybe.  But exactly where is the barrier introduced?  Are you 
> saying that on some architectures the barrier is contained in the 
> smp_mb__before_atomic and on others it is contained in the 
> xchg_relaxed?

The formula was more along the line of "do not assume either of these
cases to hold; use barrier() is you need an unconditional barrier..."
AFAICT, all current implementations of smp_mb__{before,after}_atomic()
provides a compiler barrier with either barrier() or "memory" clobber.


> > I was suggesting to consider something like:
> > 
> > 	let barrier = [...] | mb
> > 
> > but I'm still not sure about those After-unlock-lock and After-spinlock.
> 
> I don't see any point in saying that After-unlock-lock or 
> After-spinlock contains a barrier, because spin_lock and spin_unlock 
> already do.

(They would not "contain a barrier", they would induce some when paired
with the specified locking primitive/sequence: this distinction matters
for some implementation here doesn't provide the compiler barrier.  But) 
I agree with you: these barriers seem either redundant or unnecessary.


> > > > Also, consider the snippets:
> > > > 
> > > > 	WRITE_ONCE(*x, 1);
> > > > 	*x = 2;
> > > > 
> > > > and
> > > > 
> > > > 	smp_store_release(x, 1);
> > > > 	*x = 2;
> > > > 
> > > > The first snippet would be flagged "mixed-accesses" by the patch while
> > > > the second snippet would not (thanks to the above component); was this
> > > > intentional?  (Notice that some implementations map the latter to:
> > > > 
> > > > 	barrier();
> > > > 	WRITE_ONCE(*x, 1);
> > > > 	*x = 2;
> > > > 
> > > > )
> > > 
> > > That last observation is a good reason for changing the Cat code.
> > 
> > You mean in:
> > 
> > 	po-rel | acq-po
> > 
> > ? (together with the fencerel()-ifications of Release and Acquire already
> > present in the patch).
> 
> No, I meant changing the definition of "barrier" to say:
> 
> 	(po ; [Release]) | ([Acquire] ; po)
> 
> (for example) instead of the code you quoted above.

This makes sense to me.


> > > > > To avoid complications, the LKMM will consider only code in which
> > > > > plain writes are separated by a compiler barrier from any marked
> > > > > accesses of the same location.  (Question: Can this restriction be
> > > > > removed?)  As a consequence, if a region contains any marked accesses
> > > > > to a particular location then it cannot contain any plain writes to
> > > > > that location.
> > > > 
> > > > I don't know if it can be removed...  Said this, maybe we should go back
> > > > to the (simpler?) question: "What can go wrong without the restriction?",
> > > > ;-)  IOW, what are those "complications", can you provide some examples?
> > > 
> > > Here's an example I sent to Will a little while ago.  Suppose we 
> > > have:
> > >  
> > >       r = rcu_dereference(ptr);
> > >       *r = 1;
> > >       WRITE_ONCE(x, 2);
> > > 
> > > Imagine if the compiler transformed this to:
> > > 
> > >       r = rcu_dereference(ptr);
> > >       WRITE_ONCE(x, 2);
> > >       if (r != &x)
> > >               *r = 1;
> > > 
> > > This is bad because it destroys the address dependency when ptr
> > > contains &x.
> > 
> > Oh, indeed!  (In fact, we discussed this example before... ;-/)  BTW,
> > can you also point out an example which does not involve dependencies
> > (or destruction thereof)?
> 
> I believe all the examples did involve dependencies.  However, Paul has
> provided several use cases showing that one might have good reasons for
> mixing plain reads with marked acccesses -- but he didn't have any use
> cases for mixing plain writes.

I see.  BTW, if we'll converge to add this new flag (or some variant),
it might be a good idea to log some of these examples, maybe just the
snippet above, in a commit message (these could come in handy when we
will be addressed with the question "Why am I seeing this flag?" ...)


> There are some open questions remaining.  For instance, given:
> 
> 	r1 = READ_ONCE(*x);
> 	r2 = *x;
> 
> is the compiler allowed to replace the plain read with the value from 
> the READ_ONCE?  What if the statements were in the opposite order?  
> What if the READ_ONCE was changed to WRITE_ONCE?
> 
> At the moment, I think it's best if we can ignore these issues.

(To all three questions:) let me put it in these terms: I'm currently
unable to argue: "The compiler isn't allowed, because...".  But wait,
which "issues"? am I forgetting some other "bad" examples? (the above
mentioned flag doesn't seem to "cure" plain reads...)


> > I meant removing the term [Marked & R] ; addr ; [Plain & W] or the term
> > [Plain & W] ; wmb ; [Marked & W] from the (interested) definitions of
> > {w,r}-{pre,post}-bounded.  (And yes: IIUC, this also means to continue
> > to say "sorry, you're on your own" for some common patterns...)
> 
> Yes, indeed it will.  Many of the common patterns involved in RCU would 
> then be considered to contain races.  I don't think people would like 
> that.

We will try to give people what they like, no doubts about this.  ;-)
Of course, people also do not typically like compilers breaking their
dependencies: ideally, we will flag "all exceptions" (including those
documented in rcu_dereference.txt), but we're not quite there...  ;-/


> > Let me try again...  Consider the following two steps:
> > 
> >  - Start with a _race-free_ test program T1 (= LB1),
> > 
> >  - Apply a "reasonable" source-to-source transformation (2) to obtain a
> >    new test T2 (LB2) (in particular, T2 must be race-free);
> > 
> > Then the property that I had in mind is described as follows:
> > 
> >    If S is a valid state of T2 then S is also a valid state of T1; IOW,
> >    the tranformation does not introduce new behaviors.
> > 
> > (An infamously well-known paper about the study of this property, in the
> > context of the C11 memory model, is available at:
> > 
> >   http://plv.mpi-sws.org/c11comp/  )
> > 
> > This property does not hold in the proposed model (c.f., e.g., the state
> > specified in the "exists" clauses).
> 
> I don't regard this as a serious drawback.  We know that the memory 
> model doesn't behave all that well when it comes to control 
> dependencies to marked writes beyond the end of an "if" statement, for 
> example.  This is related to that.
> 
> We also know that not all hardware exhibits all the behaviors allowed
> by the architecture.  So it's reasonable that on some computer, T1
> might never exhibit state S (even though it is architecturally allowed
> to) whereas T2 could exhibit S.

Sure.  I was just pointing out the fact that the proposed approach does
introduce scenarios (the example above) where this property is violated.
It wasn't intended as "No, no"  ;-) but, again, (like for the "if (-) E
else E" scenario, also related...) it seemed worth noticing.


> > > > Let's look at your "non-transitive-wmb" test: I tend to read the write
> > > > "*x = 2" as nothing more than "write 2 to the 1st byte, write 0 to the
> > > > 2nd byte, write 0 to the next byte, ...";  and similarly for "*x = 1";
> > > > maybe some of these writes aren't performed at all (the compiler knows
> > > > that the most significant byte, say, is never touched/modified); maybe
> > > > they intersect (overwrite) one another...  what else? 
> > > 
> > > That's the thing.  According to one of the assumptions listed earlier
> > > in this document, it's not possible that the "write 2 to the 1st byte"  
> > > access isn't performed at all.  The higher-order bytes, yes, they might
> > > not be touched.  But if no writes are performed at all then at the end
> > > of the region *x will contain 1, not 2 -- and that would be a bug in
> > > the compiler.
> > 
> > AFAICT, we agreed here.  So consider the following test:
> > 
> > C non-transitive-wmb-2
> > 
> > {
> > x=0x00010000;
> > }
> > 
> > P0(int *x, int *y)
> > {
> > 	*x = 1;
> > 	smp_store_release(y, 1);
> > }
> > 
> > P1(int *x, int *y, int *z)
> > {
> > 	int r1;
> > 
> > 	r1 = smp_load_acquire(y);
> > 	if (r1) {
> > 		*x = 2;
> > 		smp_wmb();
> > 		WRITE_ONCE(*z, 1);
> > 	}
> > }
> > 
> > P2(int *x, int *z)
> > {
> > 	int r3;
> > 	int r4 = 0;
> > 
> > 	r3 = READ_ONCE(*z);
> > 	if (r3) {
> > 		smp_rmb();
> > 		r4 = READ_ONCE(*x);	/* E */
> > 	}
> > }
> > 
> > exists (2:r3=1 /\ 2:r4=2)
> > 
> > The proposed model says that this is race-free.  Now suppose that the
> > compiler mapped the two plain writes above as follows:
> > 
> > 	*x = 1;	-->  A:write 0x0001 at x
> > 		     B:write 0x0000 at (x + 2)
> > 	
> > 	*x = 2;	-->  C:write 0x0002 at x
> > 		     if ((D:read of 2 bytes at (x + 2)) != 0x0000)
> > 		         write 0x0000 at (x + 2)
> > 
> > and consider the execution where 1:r1=1 and 2:r3=1.  We know that A and
> > B propagate to P1 before C and D execute (release/acquire) and that C
> > propagates to P2 before E executes (wmb/rmb).  But what guarantees that
> > B, say, propagates to P2 before E executes?  AFAICT, nothing prevent P2
> > from reading the value 0x00010002 for x, that is, from reading the least
> > significant bits from P1's "write 0x0002 at x" and the most significant
> > bits from the initial write.  However, the proposed model doesn't report
> > the corresponding execution/state.
> 
> Ah, that is indeed an excellent example!  I had not considered
> mixed-size accesses generated by the compiler.
> 
> So perhaps it would be better to get rid of the whole notion of super 
> and major writes, and declare that non-transitive-wmb is racy in all 
> its variants.

This makes sense to me.

  Andrea
