Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAD1C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE19621473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfDHOSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:18:21 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51572 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726349AbfDHOSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:18:21 -0400
Received: (qmail 2760 invoked by uid 2102); 8 Apr 2019 10:18:20 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Apr 2019 10:18:20 -0400
Date:   Mon, 8 Apr 2019 10:18:20 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
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
In-Reply-To: <20190408055117.GA25135@andrea>
Message-ID: <Pine.LNX.4.44L0.1904081010090.1440-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2019, Andrea Parri wrote:

> > > > > I'd have:
> > > > > 
> > > > > 	*x = 1; /* A */
> > > > > 	smp_mb__before_atomic();
> > > > > 	r0 = xchg_relaxed(x, 2); /* B (read or write part) */
> > > > > 
> > > > > 	=> (A ->barrier B)
> > > > 
> > > > Perhaps so.  It wasn't clear initially how these should be treated, so
> > > > I just ignored them.  For example, what should happen here if there
> > > > were other statements between the smp_mb__before_atomic and the
> > > > xchg_relaxed?
> > > 
> > > I'd say that the link "A ->barrier B" should still be present and that
> > > no other barrier-links should appear.  More formally, I am suggesting
> > > that Before-atomic induced the following barrier-links:
> > > 
> > > 	[M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]
> > 
> > Hmmm, maybe.  But exactly where is the barrier introduced?  Are you 
> > saying that on some architectures the barrier is contained in the 
> > smp_mb__before_atomic and on others it is contained in the 
> > xchg_relaxed?
> 
> The formula was more along the line of "do not assume either of these
> cases to hold; use barrier() is you need an unconditional barrier..."
> AFAICT, all current implementations of smp_mb__{before,after}_atomic()
> provides a compiler barrier with either barrier() or "memory" clobber.

Well, we have two reasonable choices: Say that 
smp_mb__{before,after}_atomic will always provide a compiler barrier, 
or don't say this.  I see no point in saying that the combination of 
Before-atomic followed by RMW provides a barrier.


> > > > > Also, consider the snippets:
> > > > > 
> > > > > 	WRITE_ONCE(*x, 1);
> > > > > 	*x = 2;
> > > > > 
> > > > > and
> > > > > 
> > > > > 	smp_store_release(x, 1);
> > > > > 	*x = 2;
> > > > > 
> > > > > The first snippet would be flagged "mixed-accesses" by the patch while
> > > > > the second snippet would not (thanks to the above component); was this
> > > > > intentional?  (Notice that some implementations map the latter to:
> > > > > 
> > > > > 	barrier();
> > > > > 	WRITE_ONCE(*x, 1);
> > > > > 	*x = 2;
> > > > > 
> > > > > )
> > > > 
> > > > That last observation is a good reason for changing the Cat code.
> > > 
> > > You mean in:
> > > 
> > > 	po-rel | acq-po
> > > 
> > > ? (together with the fencerel()-ifications of Release and Acquire already
> > > present in the patch).
> > 
> > No, I meant changing the definition of "barrier" to say:
> > 
> > 	(po ; [Release]) | ([Acquire] ; po)
> > 
> > (for example) instead of the code you quoted above.
> 
> This makes sense to me.

I'll put it into the next version.


> > > > > > To avoid complications, the LKMM will consider only code in which
> > > > > > plain writes are separated by a compiler barrier from any marked
> > > > > > accesses of the same location.  (Question: Can this restriction be
> > > > > > removed?)  As a consequence, if a region contains any marked accesses
> > > > > > to a particular location then it cannot contain any plain writes to
> > > > > > that location.
> > > > > 
> > > > > I don't know if it can be removed...  Said this, maybe we should go back
> > > > > to the (simpler?) question: "What can go wrong without the restriction?",
> > > > > ;-)  IOW, what are those "complications", can you provide some examples?
> > > > 
> > > > Here's an example I sent to Will a little while ago.  Suppose we 
> > > > have:
> > > >  
> > > >       r = rcu_dereference(ptr);
> > > >       *r = 1;
> > > >       WRITE_ONCE(x, 2);
> > > > 
> > > > Imagine if the compiler transformed this to:
> > > > 
> > > >       r = rcu_dereference(ptr);
> > > >       WRITE_ONCE(x, 2);
> > > >       if (r != &x)
> > > >               *r = 1;
> > > > 
> > > > This is bad because it destroys the address dependency when ptr
> > > > contains &x.
> > > 
> > > Oh, indeed!  (In fact, we discussed this example before... ;-/)  BTW,
> > > can you also point out an example which does not involve dependencies
> > > (or destruction thereof)?
> > 
> > I believe all the examples did involve dependencies.  However, Paul has
> > provided several use cases showing that one might have good reasons for
> > mixing plain reads with marked acccesses -- but he didn't have any use
> > cases for mixing plain writes.
> 
> I see.  BTW, if we'll converge to add this new flag (or some variant),
> it might be a good idea to log some of these examples, maybe just the
> snippet above, in a commit message (these could come in handy when we
> will be addressed with the question "Why am I seeing this flag?" ...)

Okay.

> > There are some open questions remaining.  For instance, given:
> > 
> > 	r1 = READ_ONCE(*x);
> > 	r2 = *x;
> > 
> > is the compiler allowed to replace the plain read with the value from 
> > the READ_ONCE?  What if the statements were in the opposite order?  
> > What if the READ_ONCE was changed to WRITE_ONCE?
> > 
> > At the moment, I think it's best if we can ignore these issues.
> 
> (To all three questions:) let me put it in these terms: I'm currently
> unable to argue: "The compiler isn't allowed, because...".  But wait,
> which "issues"? am I forgetting some other "bad" examples? (the above
> mentioned flag doesn't seem to "cure" plain reads...)

Well, these aren't really issues, because they don't affect the memory 
model directly.  At least, not in its current form.  But they are open 
questions, and at the moment I think it's best to assume the most 
conservative answers -- that is, the compiler may do all sorts of crazy 
things to these code examples.


> > > Let me try again...  Consider the following two steps:
> > > 
> > >  - Start with a _race-free_ test program T1 (= LB1),
> > > 
> > >  - Apply a "reasonable" source-to-source transformation (2) to obtain a
> > >    new test T2 (LB2) (in particular, T2 must be race-free);
> > > 
> > > Then the property that I had in mind is described as follows:
> > > 
> > >    If S is a valid state of T2 then S is also a valid state of T1; IOW,
> > >    the tranformation does not introduce new behaviors.
> > > 
> > > (An infamously well-known paper about the study of this property, in the
> > > context of the C11 memory model, is available at:
> > > 
> > >   http://plv.mpi-sws.org/c11comp/  )
> > > 
> > > This property does not hold in the proposed model (c.f., e.g., the state
> > > specified in the "exists" clauses).
> > 
> > I don't regard this as a serious drawback.  We know that the memory 
> > model doesn't behave all that well when it comes to control 
> > dependencies to marked writes beyond the end of an "if" statement, for 
> > example.  This is related to that.
> > 
> > We also know that not all hardware exhibits all the behaviors allowed
> > by the architecture.  So it's reasonable that on some computer, T1
> > might never exhibit state S (even though it is architecturally allowed
> > to) whereas T2 could exhibit S.
> 
> Sure.  I was just pointing out the fact that the proposed approach does
> introduce scenarios (the example above) where this property is violated.
> It wasn't intended as "No, no"  ;-) but, again, (like for the "if (-) E
> else E" scenario, also related...) it seemed worth noticing.

All right.  Consider it noticed.  :-)


> > > > > Let's look at your "non-transitive-wmb" test: I tend to read the write
> > > > > "*x = 2" as nothing more than "write 2 to the 1st byte, write 0 to the
> > > > > 2nd byte, write 0 to the next byte, ...";  and similarly for "*x = 1";
> > > > > maybe some of these writes aren't performed at all (the compiler knows
> > > > > that the most significant byte, say, is never touched/modified); maybe
> > > > > they intersect (overwrite) one another...  what else? 
> > > > 
> > > > That's the thing.  According to one of the assumptions listed earlier
> > > > in this document, it's not possible that the "write 2 to the 1st byte"  
> > > > access isn't performed at all.  The higher-order bytes, yes, they might
> > > > not be touched.  But if no writes are performed at all then at the end
> > > > of the region *x will contain 1, not 2 -- and that would be a bug in
> > > > the compiler.
> > > 
> > > AFAICT, we agreed here.  So consider the following test:
> > > 
> > > C non-transitive-wmb-2
> > > 
> > > {
> > > x=0x00010000;
> > > }
> > > 
> > > P0(int *x, int *y)
> > > {
> > > 	*x = 1;
> > > 	smp_store_release(y, 1);
> > > }
> > > 
> > > P1(int *x, int *y, int *z)
> > > {
> > > 	int r1;
> > > 
> > > 	r1 = smp_load_acquire(y);
> > > 	if (r1) {
> > > 		*x = 2;
> > > 		smp_wmb();
> > > 		WRITE_ONCE(*z, 1);
> > > 	}
> > > }
> > > 
> > > P2(int *x, int *z)
> > > {
> > > 	int r3;
> > > 	int r4 = 0;
> > > 
> > > 	r3 = READ_ONCE(*z);
> > > 	if (r3) {
> > > 		smp_rmb();
> > > 		r4 = READ_ONCE(*x);	/* E */
> > > 	}
> > > }
> > > 
> > > exists (2:r3=1 /\ 2:r4=2)
> > > 
> > > The proposed model says that this is race-free.  Now suppose that the
> > > compiler mapped the two plain writes above as follows:
> > > 
> > > 	*x = 1;	-->  A:write 0x0001 at x
> > > 		     B:write 0x0000 at (x + 2)
> > > 	
> > > 	*x = 2;	-->  C:write 0x0002 at x
> > > 		     if ((D:read of 2 bytes at (x + 2)) != 0x0000)
> > > 		         write 0x0000 at (x + 2)
> > > 
> > > and consider the execution where 1:r1=1 and 2:r3=1.  We know that A and
> > > B propagate to P1 before C and D execute (release/acquire) and that C
> > > propagates to P2 before E executes (wmb/rmb).  But what guarantees that
> > > B, say, propagates to P2 before E executes?  AFAICT, nothing prevent P2
> > > from reading the value 0x00010002 for x, that is, from reading the least
> > > significant bits from P1's "write 0x0002 at x" and the most significant
> > > bits from the initial write.  However, the proposed model doesn't report
> > > the corresponding execution/state.
> > 
> > Ah, that is indeed an excellent example!  I had not considered
> > mixed-size accesses generated by the compiler.
> > 
> > So perhaps it would be better to get rid of the whole notion of super 
> > and major writes, and declare that non-transitive-wmb is racy in all 
> > its variants.
> 
> This makes sense to me.

In the next version...

Alan

