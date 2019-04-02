Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C684C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F110B2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 18:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfDBSGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 14:06:38 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:43948 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726582AbfDBSGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 14:06:38 -0400
Received: (qmail 6115 invoked by uid 2102); 2 Apr 2019 14:06:37 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Apr 2019 14:06:37 -0400
Date:   Tue, 2 Apr 2019 14:06:37 -0400 (EDT)
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
In-Reply-To: <20190402144242.GA5401@andrea>
Message-ID: <Pine.LNX.4.44L0.1904021147460.1562-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2019, Andrea Parri wrote:

> On Tue, Mar 19, 2019 at 03:38:19PM -0400, Alan Stern wrote:
> > LKMM maintainers and other interested parties:
> > 
> > Here is my latest proposal for extending the Linux Kernel Memory Model 
> > to handle plain accesses and data races.  The document below explains 
> > the rationale behind the proposal, and a patch (based on the dev 
> > branch of Paul's linux-rcu tree) is attached.
> 
> Thank you for this!  Unfortunately, I didn't have enough time to give it
> justice yet...  Below are some first thoughts/questions.

Thanks for the feedback.

> > This extension is not a complete treatment of plain accesses, because 
> > it pretty much ignores any ordering that plain accesses can provide.  
> > For example, given:
> > 
> > 	r0 = rcu_dereference(ptr);
> > 	r1 = r0->branch;
> > 	r2 = READ_ONCE(&r1->data);
> > 
> > the memory model will not realize that the READ_ONCE must execute after
> > the rcu_dereference, because it doesn't take into account the address
> > dependency from the intermediate plain read.  Hopefully we will add 
> > such things to the memory model later on.  Concentrating on data races 
> > seems like enough for now.
> > 
> > Some of the ideas below were originally proposed for the LKMM by Andrea
> > Parri.
> > 
> > Alan
> > 
> > -----------------------------------------------------------------------
> > 
> > A Plan For Modeling Plain Accesses In The Linux Kernel Memory Model
> > 
> > Definition: A "plain" access is one which is not "marked".  Marked
> > accesses include all those annotated with READ_ONCE or WRITE_ONCE,
> > plus acquire and release accesses, Read-Modify-Write (RMW) atomic
> > and bitop accesses, and locking accesses.
> > 
> > Plain accesses are those the compiler is free to mess around with.
> > Marked accesses are implemented in the kernel by means of inline
> > assembly or as volatile accesses, which greatly restricts what the
> > compiler can do.
> > 
> > Definition: A "region" of code is a program-order source segment
> > contained in a single thread that is maximal with respect to not
> > containing any compiler barriers (i.e., it is bounded at each end by
> > either a compiler barrier or the start or end of its thread).
> > 
> > Assumption: All memory barriers are also compiler barriers.  This
> > includes acquire loads and release stores, which are not considered to
> > be compiler barriers in the C++11 Standard, as well as non-relaxed RMW
> > atomic operations.  (Question: should this include situation-specific
> > memory barriers such as smp_mb__after_unlock_lock?  Probably not.)
> 
> I'd have:
> 
> 	*x = 1; /* A */
> 	smp_mb__before_atomic();
> 	r0 = xchg_relaxed(x, 2); /* B (read or write part) */
> 
> 	=> (A ->barrier B)

Perhaps so.  It wasn't clear initially how these should be treated, so
I just ignored them.  For example, what should happen here if there
were other statements between the smp_mb__before_atomic and the
xchg_relaxed?

> smp_mb__after_unlock_lock() seems more tricky, given that it generates
> inter-threads links.

The inter-thread part is completely irrelevant as far as compiler 
barriers are concerned.

> Intuitively, we would have a "barrier" that is a superset of "mb" (I'm
> not saying that this is feasible, but this seems worth considering...)

I don't understand that comment.

> ---
> I don't get the motivations for the component:
> 
> 	(po ; [Acquire | Release]) |
> 	([Acquire | Release] ; po)
> 
> in "barrier".  Why did you write it?

I was thinking that in situations like:

	A: z = 1;
	B: smp_store_release(z, 2);
	C: r = z;

in addition to there being a compiler barrier between A and C, there
effectively has to be a barrier between A and B (that is, the object
code has to store first 1 and then 2 to z) and between B and C (that
is, the object code can't skip doing the load from z and just set r to
2).

The basic principle was the idea that load-acquire and store-release 
are special because each of them is both a memory access and a memory 
barrier at the same time.  Now, I didn't give this a tremendous amount 
of thought and it's quite possible that the Cat code should be changed.
For example, maybe there should be a compiler barrier immediately 
before a store-release but not immediately after, and vice versa for 
load-acquire.

> Also, consider the snippets:
> 
> 	WRITE_ONCE(*x, 1);
> 	*x = 2;
> 
> and
> 
> 	smp_store_release(x, 1);
> 	*x = 2;
> 
> The first snippet would be flagged "mixed-accesses" by the patch while
> the second snippet would not (thanks to the above component); was this
> intentional?  (Notice that some implementations map the latter to:
> 
> 	barrier();
> 	WRITE_ONCE(*x, 1);
> 	*x = 2;
> 
> )

That last observation is a good reason for changing the Cat code.

> > To avoid complications, the LKMM will consider only code in which
> > plain writes are separated by a compiler barrier from any marked
> > accesses of the same location.  (Question: Can this restriction be
> > removed?)  As a consequence, if a region contains any marked accesses
> > to a particular location then it cannot contain any plain writes to
> > that location.
> 
> I don't know if it can be removed...  Said this, maybe we should go back
> to the (simpler?) question: "What can go wrong without the restriction?",
> ;-)  IOW, what are those "complications", can you provide some examples?

Here's an example I sent to Will a little while ago.  Suppose we 
have:
 
      r = rcu_dereference(ptr);
      *r = 1;
      WRITE_ONCE(x, 2);

Imagine if the compiler transformed this to:

      r = rcu_dereference(ptr);
      WRITE_ONCE(x, 2);
      if (r != &x)
              *r = 1;

This is bad because it destroys the address dependency when ptr
contains &x.

> > This analysis is guided by the intuition that one can set up a limited
> > correspondence between an execution of the source code and an
> > execution of the generated object code.  Such a correspondence is
> > based on some limitations on what compilers can do when translating a
> > program:
> > 
> > 	Each marked access in the source-level execution must
> > 	correspond to a unique instruction in the object-level
> > 	execution.  The corresponding events must access the same
> > 	location, have the same values, and be of the same type (read
> > 	or write).
> > 
> > 	If a marked access is address-dependent on a marked read then
> > 	the corresponding object-level instructions must have the same
> > 	dependency (i.e., the compiler does not break address
> > 	dependencies for marked accesses).
> 
> We known that this "limitation" does not hold, in this generality.  Your
> proposal goes even further than that (by adding address dep. from marked
> reads to marked accesses):  A warning, maybe also a pointer to doc. such
> as Documentation/RCU/rcu_dereference.txt wouldn't have hurt! ;-)

Agreed.

> > 	If a source region contains no plain accesses to a location
> > 	then the corresponding object-level region contains no
> > 	accesses to that location other than those corresponding to
> > 	marked accesses.
> > 
> > 	If a source region contains no plain writes to a location then
> > 	the corresponding object-level region contains no stores to
> > 	that location other than those corresponding to marked writes.
> > 
> > 	If a source region contains a plain write then the object code
> > 	corresponding to that region must contain at least one access
> > 	(it could be a load instead of a store) to the same location.
> > 
> > 	If all the accesses to a particular location in some source
> > 	region are address-dependent on one of the marked reads in
> > 	some set S then every object-level access of that location
> > 	must be dependent (not necessarily address-dependent, when the
> > 	access is a store) on one of the instructions corresponding to
> > 	the members of S.
> > 
> > 	The object code for a region must ensure that the final value
> > 	stored in a location is the same as the value of the po-final
> > 	source write in the region.
> > 
> > The positions of the load and store instructions in the object code
> > for a region do not have to bear any particular relation to the plain
> > accesses in the source code.  Subject to the restrictions above, a
> > sequence of m plain writes in the source could be implemented by a
> > sequence of n store instructions at runtime where n is <, =, or > m,
> > and likewise for plain reads.
> > 
> > Similarly, the rf, co, and fr relations for plain accesses in
> > source-level executions have very limited meaning.
> > 
> > Given an object-level execution, let A1 and B1 be accesses in region
> > R1 and let A2 and B2 be accesses in region R2, all of the same
> > location, not all reads, and not all corresponding to marked accesses.
> > (We explicitly allow A1 and B1 to be the same access, and the same for
> > A2 and B2.)  The execution has a data race if the coherence ordering
> > from A1 to A2 is opposite to the ordering from B1 to B2.
> > 
> > Definition: Two accesses of the same location "conflict" if they are
> > in different threads, they are not both marked, and they are not both
> > reads.
> > 
> > The notions "executes before" and "is visible to" have already been
> > defined for marked accesses in the LKMM or in earlier proposals for
> > handling plain accesses (the xb -- or more properly, xb* -- and vis
> > relations).  I trust the ideas are familiar to everyone.  Note that
> > vis is contained in xb.  Also note that the vis relation is not
> > transitive, because smp_wmb is not A-cumulative.  That is, it's
> > possible for W1 to be visible to W2 and W2 to be visible to W3,
> > without W1 being visible to W3.  (However, on systems that are other
> > multicopy-atomic, vis is indeed transitive.)
> > 
> > We want to define data races for source programs in such a way that a
> > race-free source program has no data races in any of its object-level
> > executions.  To that end, we could begin with some requirements:
> > 
> > 	For any two conflicting writes, one must be visible to the
> > 	other.
> > 
> > 	For a write conflicting with a read, either the write must be
> > 	visible to the read or the read must execute before the write.
> 
> I'm missing the link with the notion of "data race of an object-level
> execution" given above (it is possible that I did not understand that
> description): could you elaborate? (maybe by providing some examples)

The argument here is based on an unstated principle (I didn't state it
explicitly because I don't know if it is really true): Given a
candidate execution in which write W is not visible to write X even
though W is co-before X, there is another, very similar (whatever
that means!) execution in which X is co-before W.

So consider as an example the case where W is a marked write which 
conflicts with a plain write X.  Since X is plain, the compiler is 
allowed to generate object code which carries out the X write twice; 
let's call these object-level writes X1 and X2.  If W is not visible to 
X1 and X2 and yet W ->co X2, the principle states that there is 
an execution in which X1 ->co W ->co X2.  This fits the object-level 
definition of a data race above.

> > However, this isn't strong enough.  A source-level write can give rise
> > to object-level loads as well as stores.  Therefore whenever we
> > require that a plain write W be visible to some other access A, we
> > must also require that if W were a read then it would execute before
> > A.  And similarly, if A is required to be visible to W, we must also
> > require that if W were a read then A would still be visible to it.
> > 
> > At the same time, it is too strong.  If W1 is required to be visible
> > to W2 and W2 is required to be visible to A, then W1 doesn't
> > necessarily have to be visible to A.  Visibility is required only in
> > cases where W2 need not correspond to any object-level stores.
> > 
> > Since vis and xb aren't defined for plain accesses, we have to extend
> > the definitions.  We begin by saying that a plain access is pre- or
> > post-bounded by a marked access if the execution order can be
> > guaranteed, as follows.
> > 
> > Definition:
> > 
> > 	A write W is "w-post-bounded" by a po-later marked access A if
> > 	they are separated by an appropriate memory barrier (including
> > 	the case where A is a release write).
> > 
> > 	A read R is "r-post-bounded" by a po-later marked access A if
> > 	they are separated by an appropriate memory barrier.
> > 
> > 	Oddly, a plain write W is "r-post-bounded" by a po-later
> > 	marked access A whenever W would be considered to be
> > 	r-post-bounded by A if W were a read (for example, when A is a
> > 	read and the two are separated by smp_rmb).
> 
> Looking at the patch, I see that a plain read can be "w-post-bounded":
> should/can we prevent this from happening?

It doesn't matter.  w-post-bounded gets used only in situations where 
the left-hand access is a write.  (Unless I made a mistake somewhere.)

> > 	In addition, a marked write is w-post-bounded by itself and a
> > 	marked read is r-post-bounded by itself.
> > 
> > 	An access being "w-pre-bounded" and "r-pre-bounded" by a
> > 	po-earlier marked access are defined analogously, except that
> > 	we also include cases where the later plain access is
> > 	address-dependent on the marked access.
> > 
> > Note that as a result of these definitions, if one plain write is
> > w-post-bounded by a marked access than all the writes in the same
> > region are (this is because the memory barrier which enforces the
> > bounding is also a region delimiter).  And if one plain access is
> > r-post-bounded by a marked access then all the plain accesses in the
> > same region are.  The same cannot be said of w-pre-bounded and
> > r-pre-bounded, though, because of possible address dependencies.
> > 
> > Definition: ww-vis, ww-xb, wr-vis, wr-xb, and rw-xb are given by the
> > following scheme.  Let i and j each be either w or r, and let rel be
> > either vis or xb.  Then access A is related to access D by ij-rel if
> > there are marked accesses B and C such that:
> > 
> > 	A ->i-post-bounded B ->rel C ->j-pre-bounded D.
> > 
> > For example, A is related by wr-vis to D if there are marked accesses
> > B and C such that A is w-post-bounded by B, B ->vis C, and C
> > r-pre-bounds D.  In cases where A or D is marked, B could be equal to
> > A or C could be equal to D.
> > 
> > As mentioned earlier, ww-vis is contained in ww-xb and wr-vis is
> > contained in wr-xb.  It turns out that the LKMM can almost prove that
> > the ij-xb relations are transitive, in the following sense.  If W is a
> > write and R is a read, then:
> > 
> > 	(A ->iw-xb W ->wj-xb C) implies (A ->ij-xb C), and
> > 
> > 	(A ->ir-xb R ->rj-xb C) implies (A ->ij-xb C).
> > 
> > To fully prove this requires adding one new term to the ppo relation:
> > 
> > 	[Marked & R] ; addr ; [Plain & W] ; wmb ; [Marked & W]
> 
> ... or removing any of these links, right?

I don't understand.  Remove any of which links?  Remove it from the
candidate execution or from the memory model?

> > For example, given the code:
> > 
> > 	r = READ_ONCE(ptr);
> > 	*r = 27;
> > 	smp_wmb();
> > 	WRITE_ONCE(x, 1);
> > 
> > the new term says that the READ_ONCE must execute before the
> > WRITE_ONCE.  To justify this, note that the object code is obliged to
> > ensure that *r contains 27 (or some co-later value) before the smp_wmb
> > executes.  It can do so in one of three ways:
> > 
> > (1)	Actually store a 27 through the *r pointer;
> > 
> > (2)	Load through the *r pointer and check that the location already
> > 	holds 27; or
> > 
> > (3)	Check that r aliases a pointer to a location known to hold 27
> > 	already.
> > 
> > In case (1), the ordering is enforced by the address dependency and
> > the smp_wmb.  In case (2) there is an address dependency to the *r
> > load and a conditional depending on that load.  Control dependencies
> > in object-code executions extend to all po-later stores; hence the
> > WRITE_ONCE must be ordered after the *r load.  In case (3) there is a
> > conditional depending on the READ_ONCE and po-before the WRITE_ONCE.
> 
> The proposed model is unsound w.r.t. (2); c.f., LB1 vs. LB2 from:
> 
>   http://lkml.kernel.org/r/20190116213658.GA3984@andrea

Again, I don't understand.  What's unsound about the proposed model?  

For LB1 it says that the WRITE_ONCE must execute after the
rcu_dereference, which is correct.  For LB2 it doesn't say anything,
because in LB2 there is no plain write event between the
rcu_dereference and the smp_wmb events.

> Mmh..., no particular suggestions at the moment (just blaming "addr"
> and "wmb", I guess ;-) ); the fact is that "soundness" looks like a
> very desirable property...
> 
> 
> > 
> > With this new term added, the LKMM can show that a cycle in the ij-xb
> > relations would give rise to a cycle in xb of marked accesses.  It
> > follows that in an allowed execution, the regions containing accesses
> > to a particular location x can be totally ordered in a way compatible
> > with the ij-xb relations, and this ordering must agree with the co and
> > rf orderings for x.
> > 
> > Therefore we can try defining a race-free execution to be one which
> > obeys the following requirements:
> > 
> > ww-race: If W1 ->co W2 and the two writes conflict then we must have
> > 	W1 ->ww-vis W2.  If W1 is a plain write then we must also have
> > 	W1 ->rw-xb W2, and if W2 is a plain write then we must also
> > 	have W1 ->wr-vis W2.
> > 
> > wr-race: If W ->(co?;rf) R and the two accesses conflict then we must
> > 	have W ->wr-vis R.
> > 
> > rw-race: If R ->fr W and the two accesses conflict then we must have
> > 	R ->rw-xb W.
> > 
> > However, as described earlier, this is stronger than we really need.
> > In ww-race, we don't need to have W1 ->ww-vis W2 or W1 ->wr-vis W2 if
> > there is a third write W3 in between such that W3 must give rise to a
> > store in the object code.  In this case it doesn't matter whether W1
> > is visible to W2 or not; they can't race because W3 will be visible to
> > W2 and being co-later than W1, it will prevent W1 from interfering
> > with W2.  Much the same is true for wr-race.
> > 
> > If W3 is a marked write, it certainly corresponds to a write in the
> > object code.  But what if it is a plain write?
> > 
> > Definition: A write is "major" if it is not overwritten by any
> > po-later writes in its region.  A major write is "super" if it has a
> > different value from the co-preceding major write.  In addition, all
> > marked writes are considered to be super.
> > 
> > If a region contains a super write then the object code for the region
> > must contain a store to the write's location.  Otherwise, when
> > execution reached the end of the region at runtime, the value
> > contained in that location would still be the value from the end of
> > the preceding region -- that is, the value would be wrong.
> > 
> > Thus, ww-race need not apply if there is a super write co-between W1
> > and W2.  Likewise, wr-race need not apply if there is a super write
> > co-after W and co?-before the write which R reads from.  Note that
> > these weakenings do not apply in situations where W2 is the co-next
> > write after W1 or when R reads from W; in such cases ww-race and
> > wr-race retain their full force.
> 
> I don't know yet...  Frankly, this idea of "semantics depending on the
> _values_ of plain accesses" simply scares me. ;-)

Unfortunately, that's how computer programs work in the real world:
Their behavior depends on the values that reads obtain.

> Let's look at your "non-transitive-wmb" test: I tend to read the write
> "*x = 2" as nothing more than "write 2 to the 1st byte, write 0 to the
> 2nd byte, write 0 to the next byte, ...";  and similarly for "*x = 1";

That's already a mistake.  The compiler can do extraordinary things to 
the code.  It doesn't have to end up being anything as simple as "write 
2 to the 1st byte, ...".

> maybe some of these writes aren't performed at all (the compiler knows
> that the most significant byte, say, is never touched/modified); maybe
> they intersect (overwrite) one another...  what else? 

That's the thing.  According to one of the assumptions listed earlier
in this document, it's not possible that the "write 2 to the 1st byte"  
access isn't performed at all.  The higher-order bytes, yes, they might
not be touched.  But if no writes are performed at all then at the end
of the region *x will contain 1, not 2 -- and that would be a bug in
the compiler.

>  So, for example,
> if we "slice" the most significant parts of the plain writes in P0 and
> P1 then they have the "same value" in a certain sense.
> 
> Mmh, I still don't feel comfortable with these concepts sorry, maybe I
> just need more time to process them...
> 
> 
> > 
> > The LKMM also has to detect forbidden executions involving plain
> > accesses.  There are three obvious coherence-related checks:
> > 
> > 	If W ->rf R then we must not have R ->rw-xb W.
> > 
> > 	If R ->fr W then we must not have W ->wr-vis R.
> > 
> > 	If W1 ->co W2 then we must not have W2 ->ww-vis W1.
> > 
> > (Question: Are these checks actually correct?  I'm not certain; they
> > are hard to reason about because co, rf, and fr don't have clear
> > meanings for plain accesses in racy executions.)
> 
> So maybe they were not that "obvious". ;-)

Well, they were pretty obvious to me -- they are just restatements of
the coherence-related rules in the operational model.  Of course,
"obvious" doesn't always mean "correct".

> This all deserves a careful review and testing; unfortunately, I doubt
> that I'll be able to do much more in the next couple of weeks.  bbl,

Good luck on all the more pressing engagements!

Alan

