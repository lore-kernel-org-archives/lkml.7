Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D4FC282CE
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 00:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE412175B
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 00:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AyyqVYtm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfDFAtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 20:49:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32880 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfDFAtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 20:49:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id i19so4175556pfd.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 17:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5v9GeByz0e8ztI/4z6IGD9wrnAkRBjQD34Nw0B/fu9Q=;
        b=AyyqVYtmkM9B1wPc0bOFsOVQeOebCkSfuAtS6fzyJr0LVxy/oUVxzZnawn36XNJSzN
         LmbFExTIe51i5BgtycZzHxA7nq4bXHFqiZMb3a/cvDG5wwhC7e+hpywyGBHipXr0izbn
         Y21L7vkNwktH92t5gOLQEPMz4jWMIJRD2U6Dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5v9GeByz0e8ztI/4z6IGD9wrnAkRBjQD34Nw0B/fu9Q=;
        b=Q2hl/P41GkU1f0iEM5YURESFmdtYrjjYY5xmLPrJi2p79XigWOFSfb9GdNSFqrBil/
         u718t+DCxn5Zpum1cAQ/hHIjv5rREnYaLiCIh4AqT2O7eVp9Duv5ZdVLgB1iMCGPGbu4
         UcaYXFIB4sQfxfTVHw/BCUevDHRweOdGqvcZUNTkNdSgViNQgwo/him3VcIH7NagCXxG
         W/nXS6JHCtK5AHFdPPHfMEe05aHYsauaD0v3kKptRqjAouZP+OM/tbUP4CpA3crYfLuA
         ZPlCN6kBhC5oGfyxnAPvBFu9p9KRyAr9/B+xWk0q/VmK0BBSr2T6CqCIU9QMevjZHqGm
         LmRw==
X-Gm-Message-State: APjAAAV8qMY8sKw87mjaI8FxZaCW64jhu2/vLLz5KP5FqFDFPryZYilX
        YlbeDQdUempw9VoE2b1FpzUPWQ==
X-Google-Smtp-Source: APXvYqxRoCo0o+nufBrxJBz+aTcITBIKMKfSAYlZ79ub640NIh9E2Fj5LV4Prmp2kOXhKpZ8vOPVJA==
X-Received: by 2002:a63:e44f:: with SMTP id i15mr11491913pgk.362.1554511761685;
        Fri, 05 Apr 2019 17:49:21 -0700 (PDT)
Received: from andrea ([63.64.74.251])
        by smtp.gmail.com with ESMTPSA id d3sm34458656pfn.113.2019.04.05.17.49.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 17:49:20 -0700 (PDT)
Date:   Sat, 6 Apr 2019 02:49:13 +0200
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
Message-ID: <20190406004913.GA3828@andrea>
References: <20190402144242.GA5401@andrea>
 <Pine.LNX.4.44L0.1904021147460.1562-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1904021147460.1562-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'd have:
> > 
> > 	*x = 1; /* A */
> > 	smp_mb__before_atomic();
> > 	r0 = xchg_relaxed(x, 2); /* B (read or write part) */
> > 
> > 	=> (A ->barrier B)
> 
> Perhaps so.  It wasn't clear initially how these should be treated, so
> I just ignored them.  For example, what should happen here if there
> were other statements between the smp_mb__before_atomic and the
> xchg_relaxed?

I'd say that the link "A ->barrier B" should still be present and that
no other barrier-links should appear.  More formally, I am suggesting
that Before-atomic induced the following barrier-links:

	[M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]


> > smp_mb__after_unlock_lock() seems more tricky, given that it generates
> > inter-threads links.
> 
> The inter-thread part is completely irrelevant as far as compiler 
> barriers are concerned.
> 
> > Intuitively, we would have a "barrier" that is a superset of "mb" (I'm
> > not saying that this is feasible, but this seems worth considering...)
> 
> I don't understand that comment.

I was suggesting to consider something like:

	let barrier = [...] | mb

but I'm still not sure about those After-unlock-lock and After-spinlock.


> > I don't get the motivations for the component:
> > 
> > 	(po ; [Acquire | Release]) |
> > 	([Acquire | Release] ; po)
> > 
> > in "barrier".  Why did you write it?
> 
> I was thinking that in situations like:
> 
> 	A: z = 1;
> 	B: smp_store_release(z, 2);
> 	C: r = z;
> 
> in addition to there being a compiler barrier between A and C, there
> effectively has to be a barrier between A and B (that is, the object
> code has to store first 1 and then 2 to z) and between B and C (that
> is, the object code can't skip doing the load from z and just set r to
> 2).
> 
> The basic principle was the idea that load-acquire and store-release 
> are special because each of them is both a memory access and a memory 
> barrier at the same time.  Now, I didn't give this a tremendous amount 
> of thought and it's quite possible that the Cat code should be changed.
> For example, maybe there should be a compiler barrier immediately 
> before a store-release but not immediately after, and vice versa for 
> load-acquire.
> 
> > Also, consider the snippets:
> > 
> > 	WRITE_ONCE(*x, 1);
> > 	*x = 2;
> > 
> > and
> > 
> > 	smp_store_release(x, 1);
> > 	*x = 2;
> > 
> > The first snippet would be flagged "mixed-accesses" by the patch while
> > the second snippet would not (thanks to the above component); was this
> > intentional?  (Notice that some implementations map the latter to:
> > 
> > 	barrier();
> > 	WRITE_ONCE(*x, 1);
> > 	*x = 2;
> > 
> > )
> 
> That last observation is a good reason for changing the Cat code.

You mean in:

	po-rel | acq-po

? (together with the fencerel()-ifications of Release and Acquire already
present in the patch).


> > > To avoid complications, the LKMM will consider only code in which
> > > plain writes are separated by a compiler barrier from any marked
> > > accesses of the same location.  (Question: Can this restriction be
> > > removed?)  As a consequence, if a region contains any marked accesses
> > > to a particular location then it cannot contain any plain writes to
> > > that location.
> > 
> > I don't know if it can be removed...  Said this, maybe we should go back
> > to the (simpler?) question: "What can go wrong without the restriction?",
> > ;-)  IOW, what are those "complications", can you provide some examples?
> 
> Here's an example I sent to Will a little while ago.  Suppose we 
> have:
>  
>       r = rcu_dereference(ptr);
>       *r = 1;
>       WRITE_ONCE(x, 2);
> 
> Imagine if the compiler transformed this to:
> 
>       r = rcu_dereference(ptr);
>       WRITE_ONCE(x, 2);
>       if (r != &x)
>               *r = 1;
> 
> This is bad because it destroys the address dependency when ptr
> contains &x.

Oh, indeed!  (In fact, we discussed this example before... ;-/)  BTW,
can you also point out an example which does not involve dependencies
(or destruction thereof)?


> > > Given an object-level execution, let A1 and B1 be accesses in region
> > > R1 and let A2 and B2 be accesses in region R2, all of the same
> > > location, not all reads, and not all corresponding to marked accesses.
> > > (We explicitly allow A1 and B1 to be the same access, and the same for
> > > A2 and B2.)  The execution has a data race if the coherence ordering
> > > from A1 to A2 is opposite to the ordering from B1 to B2.
> > > 
> > > Definition: Two accesses of the same location "conflict" if they are
> > > in different threads, they are not both marked, and they are not both
> > > reads.
> > > 
> > > The notions "executes before" and "is visible to" have already been
> > > defined for marked accesses in the LKMM or in earlier proposals for
> > > handling plain accesses (the xb -- or more properly, xb* -- and vis
> > > relations).  I trust the ideas are familiar to everyone.  Note that
> > > vis is contained in xb.  Also note that the vis relation is not
> > > transitive, because smp_wmb is not A-cumulative.  That is, it's
> > > possible for W1 to be visible to W2 and W2 to be visible to W3,
> > > without W1 being visible to W3.  (However, on systems that are other
> > > multicopy-atomic, vis is indeed transitive.)
> > > 
> > > We want to define data races for source programs in such a way that a
> > > race-free source program has no data races in any of its object-level
> > > executions.  To that end, we could begin with some requirements:
> > > 
> > > 	For any two conflicting writes, one must be visible to the
> > > 	other.
> > > 
> > > 	For a write conflicting with a read, either the write must be
> > > 	visible to the read or the read must execute before the write.
> > 
> > I'm missing the link with the notion of "data race of an object-level
> > execution" given above (it is possible that I did not understand that
> > description): could you elaborate? (maybe by providing some examples)
> 
> The argument here is based on an unstated principle (I didn't state it
> explicitly because I don't know if it is really true): Given a
> candidate execution in which write W is not visible to write X even
> though W is co-before X, there is another, very similar (whatever
> that means!) execution in which X is co-before W.
> 
> So consider as an example the case where W is a marked write which 
> conflicts with a plain write X.  Since X is plain, the compiler is 
> allowed to generate object code which carries out the X write twice; 
> let's call these object-level writes X1 and X2.  If W is not visible to 
> X1 and X2 and yet W ->co X2, the principle states that there is 
> an execution in which X1 ->co W ->co X2.  This fits the object-level 
> definition of a data race above.

Thanks for the intuition.  (I'll think about it...)


> > Looking at the patch, I see that a plain read can be "w-post-bounded":
> > should/can we prevent this from happening?
> 
> It doesn't matter.  w-post-bounded gets used only in situations where 
> the left-hand access is a write.  (Unless I made a mistake somewhere.)

Well, we can enforce that "gets used only in..." by heading the relation
with [W] ; _  (this will also help us to prevent "mistakes" in the future)


> > > As mentioned earlier, ww-vis is contained in ww-xb and wr-vis is
> > > contained in wr-xb.  It turns out that the LKMM can almost prove that
> > > the ij-xb relations are transitive, in the following sense.  If W is a
> > > write and R is a read, then:
> > > 
> > > 	(A ->iw-xb W ->wj-xb C) implies (A ->ij-xb C), and
> > > 
> > > 	(A ->ir-xb R ->rj-xb C) implies (A ->ij-xb C).
> > > 
> > > To fully prove this requires adding one new term to the ppo relation:
> > > 
> > > 	[Marked & R] ; addr ; [Plain & W] ; wmb ; [Marked & W]
> > 
> > ... or removing any of these links, right?
> 
> I don't understand.  Remove any of which links?  Remove it from the
> candidate execution or from the memory model?

I meant removing the term [Marked & R] ; addr ; [Plain & W] or the term
[Plain & W] ; wmb ; [Marked & W] from the (interested) definitions of
{w,r}-{pre,post}-bounded.  (And yes: IIUC, this also means to continue
to say "sorry, you're on your own" for some common patterns...)


> > The proposed model is unsound w.r.t. (2); c.f., LB1 vs. LB2 from:
> > 
> >   http://lkml.kernel.org/r/20190116213658.GA3984@andrea
> 
> Again, I don't understand.  What's unsound about the proposed model?  

Let me try again...  Consider the following two steps:

 - Start with a _race-free_ test program T1 (= LB1),

 - Apply a "reasonable" source-to-source transformation (2) to obtain a
   new test T2 (LB2) (in particular, T2 must be race-free);

Then the property that I had in mind is described as follows:

   If S is a valid state of T2 then S is also a valid state of T1; IOW,
   the tranformation does not introduce new behaviors.

(An infamously well-known paper about the study of this property, in the
context of the C11 memory model, is available at:

  http://plv.mpi-sws.org/c11comp/  )

This property does not hold in the proposed model (c.f., e.g., the state
specified in the "exists" clauses).


> > Let's look at your "non-transitive-wmb" test: I tend to read the write
> > "*x = 2" as nothing more than "write 2 to the 1st byte, write 0 to the
> > 2nd byte, write 0 to the next byte, ...";  and similarly for "*x = 1";
> > maybe some of these writes aren't performed at all (the compiler knows
> > that the most significant byte, say, is never touched/modified); maybe
> > they intersect (overwrite) one another...  what else? 
> 
> That's the thing.  According to one of the assumptions listed earlier
> in this document, it's not possible that the "write 2 to the 1st byte"  
> access isn't performed at all.  The higher-order bytes, yes, they might
> not be touched.  But if no writes are performed at all then at the end
> of the region *x will contain 1, not 2 -- and that would be a bug in
> the compiler.

AFAICT, we agreed here.  So consider the following test:

C non-transitive-wmb-2

{
x=0x00010000;
}

P0(int *x, int *y)
{
	*x = 1;
	smp_store_release(y, 1);
}

P1(int *x, int *y, int *z)
{
	int r1;

	r1 = smp_load_acquire(y);
	if (r1) {
		*x = 2;
		smp_wmb();
		WRITE_ONCE(*z, 1);
	}
}

P2(int *x, int *z)
{
	int r3;
	int r4 = 0;

	r3 = READ_ONCE(*z);
	if (r3) {
		smp_rmb();
		r4 = READ_ONCE(*x);	/* E */
	}
}

exists (2:r3=1 /\ 2:r4=2)

The proposed model says that this is race-free.  Now suppose that the
compiler mapped the two plain writes above as follows:

	*x = 1;	-->  A:write 0x0001 at x
		     B:write 0x0000 at (x + 2)
	
	*x = 2;	-->  C:write 0x0002 at x
		     if ((D:read of 2 bytes at (x + 2)) != 0x0000)
		         write 0x0000 at (x + 2)

and consider the execution where 1:r1=1 and 2:r3=1.  We know that A and
B propagate to P1 before C and D execute (release/acquire) and that C
propagates to P2 before E executes (wmb/rmb).  But what guarantees that
B, say, propagates to P2 before E executes?  AFAICT, nothing prevent P2
from reading the value 0x00010002 for x, that is, from reading the least
significant bits from P1's "write 0x0002 at x" and the most significant
bits from the initial write.  However, the proposed model doesn't report
the corresponding execution/state.

  Andrea
