Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2979C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B512206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bMw7ocyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbfDBOmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:42:52 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:33034 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730362AbfDBOmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:42:52 -0400
Received: by mail-wr1-f45.google.com with SMTP id q1so17025275wrp.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zhcjDBrSHzl0f92wKaf2sVHRih3fgJw7zcHsk78XY9w=;
        b=bMw7ocyP8f3VamNEMpmAbx4XDRjyLjtr/XlJGy3dIgLpO8RKb6FV7Vzg5+vDkCIFil
         eP846eoNdCyAmRgGriaPe0r6PxPcPDfpUAexQXE2gU5eS4FCO9/4ZEvvlyMXepbfrwBk
         uD8swSrKUdFef+a/yR6V1yhZYwdNijTdX9Xs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zhcjDBrSHzl0f92wKaf2sVHRih3fgJw7zcHsk78XY9w=;
        b=XciFPuOgUSF32KOkmxX8JxyENY7Wpoax7e3pcOWRjLswdkEz7gBdHLYMocmU9NUJfg
         01o9iNJYKR0K8p1l2P/wInhSq03VQCMzg7tz5fe19sYUHqpQKeu2VklFGOdo/WF/8ui/
         bRPew72kXUwexZFwJRzZCpEQxi6GTaVTXmCxH/Sa7As8MoVieQbJWUemEo0OOB0R63S5
         FgLWLlJwNphvXmVYzvP0RJrMI4QRdSKbw4Gh2nU5x7mcvlYZb5UCFFSh4tAEumm0bd6i
         GoAxLIfpXDNRcy/7ROsKJdMnwjo8O+VjTrcWB5BkCA+xBbAiYgLKPTm3UlTRNAp22L7p
         UMxA==
X-Gm-Message-State: APjAAAWjHFaoJ6ItOe/D7OBb1cSHLURvkIYHJ97waxvDamLjK7A3VtF+
        TwgEYX5QGb+N5YY2v8XvdU8Ilg==
X-Google-Smtp-Source: APXvYqz/2w3PbbzTQObqBLFD/dTonZcRiodkEZbcE+mB8HeKVIHc1mfTdmi8zJ2qCiVwRQIUsKb+9Q==
X-Received: by 2002:adf:ef0b:: with SMTP id e11mr33868491wro.244.1554216169238;
        Tue, 02 Apr 2019 07:42:49 -0700 (PDT)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id x14sm15901015wmj.3.2019.04.02.07.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 07:42:48 -0700 (PDT)
Date:   Tue, 2 Apr 2019 16:42:42 +0200
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
Message-ID: <20190402144242.GA5401@andrea>
References: <Pine.LNX.4.44L0.1903191459270.1593-200000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1903191459270.1593-200000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 03:38:19PM -0400, Alan Stern wrote:
> LKMM maintainers and other interested parties:
> 
> Here is my latest proposal for extending the Linux Kernel Memory Model 
> to handle plain accesses and data races.  The document below explains 
> the rationale behind the proposal, and a patch (based on the dev 
> branch of Paul's linux-rcu tree) is attached.

Thank you for this!  Unfortunately, I didn't have enough time to give it
justice yet...  Below are some first thoughts/questions.


> 
> This extension is not a complete treatment of plain accesses, because 
> it pretty much ignores any ordering that plain accesses can provide.  
> For example, given:
> 
> 	r0 = rcu_dereference(ptr);
> 	r1 = r0->branch;
> 	r2 = READ_ONCE(&r1->data);
> 
> the memory model will not realize that the READ_ONCE must execute after
> the rcu_dereference, because it doesn't take into account the address
> dependency from the intermediate plain read.  Hopefully we will add 
> such things to the memory model later on.  Concentrating on data races 
> seems like enough for now.
> 
> Some of the ideas below were originally proposed for the LKMM by Andrea
> Parri.
> 
> Alan
> 
> -----------------------------------------------------------------------
> 
> A Plan For Modeling Plain Accesses In The Linux Kernel Memory Model
> 
> Definition: A "plain" access is one which is not "marked".  Marked
> accesses include all those annotated with READ_ONCE or WRITE_ONCE,
> plus acquire and release accesses, Read-Modify-Write (RMW) atomic
> and bitop accesses, and locking accesses.
> 
> Plain accesses are those the compiler is free to mess around with.
> Marked accesses are implemented in the kernel by means of inline
> assembly or as volatile accesses, which greatly restricts what the
> compiler can do.
> 
> Definition: A "region" of code is a program-order source segment
> contained in a single thread that is maximal with respect to not
> containing any compiler barriers (i.e., it is bounded at each end by
> either a compiler barrier or the start or end of its thread).
> 
> Assumption: All memory barriers are also compiler barriers.  This
> includes acquire loads and release stores, which are not considered to
> be compiler barriers in the C++11 Standard, as well as non-relaxed RMW
> atomic operations.  (Question: should this include situation-specific
> memory barriers such as smp_mb__after_unlock_lock?  Probably not.)

I'd have:

	*x = 1; /* A */
	smp_mb__before_atomic();
	r0 = xchg_relaxed(x, 2); /* B (read or write part) */

	=> (A ->barrier B)

smp_mb__after_unlock_lock() seems more tricky, given that it generates
inter-threads links.

Intuitively, we would have a "barrier" that is a superset of "mb" (I'm
not saying that this is feasible, but this seems worth considering...)

---
I don't get the motivations for the component:

	(po ; [Acquire | Release]) |
	([Acquire | Release] ; po)

in "barrier".  Why did you write it?

Also, consider the snippets:

	WRITE_ONCE(*x, 1);
	*x = 2;

and

	smp_store_release(x, 1);
	*x = 2;

The first snippet would be flagged "mixed-accesses" by the patch while
the second snippet would not (thanks to the above component); was this
intentional?  (Notice that some implementations map the latter to:

	barrier();
	WRITE_ONCE(*x, 1);
	*x = 2;

)


> 
> To avoid complications, the LKMM will consider only code in which
> plain writes are separated by a compiler barrier from any marked
> accesses of the same location.  (Question: Can this restriction be
> removed?)  As a consequence, if a region contains any marked accesses
> to a particular location then it cannot contain any plain writes to
> that location.

I don't know if it can be removed...  Said this, maybe we should go back
to the (simpler?) question: "What can go wrong without the restriction?",
;-)  IOW, what are those "complications", can you provide some examples?


> 
> This analysis is guided by the intuition that one can set up a limited
> correspondence between an execution of the source code and an
> execution of the generated object code.  Such a correspondence is
> based on some limitations on what compilers can do when translating a
> program:
> 
> 	Each marked access in the source-level execution must
> 	correspond to a unique instruction in the object-level
> 	execution.  The corresponding events must access the same
> 	location, have the same values, and be of the same type (read
> 	or write).
> 
> 	If a marked access is address-dependent on a marked read then
> 	the corresponding object-level instructions must have the same
> 	dependency (i.e., the compiler does not break address
> 	dependencies for marked accesses).

We known that this "limitation" does not hold, in this generality.  Your
proposal goes even further than that (by adding address dep. from marked
reads to marked accesses):  A warning, maybe also a pointer to doc. such
as Documentation/RCU/rcu_dereference.txt wouldn't have hurt! ;-)


> 
> 	If a source region contains no plain accesses to a location
> 	then the corresponding object-level region contains no
> 	accesses to that location other than those corresponding to
> 	marked accesses.
> 
> 	If a source region contains no plain writes to a location then
> 	the corresponding object-level region contains no stores to
> 	that location other than those corresponding to marked writes.
> 
> 	If a source region contains a plain write then the object code
> 	corresponding to that region must contain at least one access
> 	(it could be a load instead of a store) to the same location.
> 
> 	If all the accesses to a particular location in some source
> 	region are address-dependent on one of the marked reads in
> 	some set S then every object-level access of that location
> 	must be dependent (not necessarily address-dependent, when the
> 	access is a store) on one of the instructions corresponding to
> 	the members of S.
> 
> 	The object code for a region must ensure that the final value
> 	stored in a location is the same as the value of the po-final
> 	source write in the region.
> 
> The positions of the load and store instructions in the object code
> for a region do not have to bear any particular relation to the plain
> accesses in the source code.  Subject to the restrictions above, a
> sequence of m plain writes in the source could be implemented by a
> sequence of n store instructions at runtime where n is <, =, or > m,
> and likewise for plain reads.
> 
> Similarly, the rf, co, and fr relations for plain accesses in
> source-level executions have very limited meaning.
> 
> Given an object-level execution, let A1 and B1 be accesses in region
> R1 and let A2 and B2 be accesses in region R2, all of the same
> location, not all reads, and not all corresponding to marked accesses.
> (We explicitly allow A1 and B1 to be the same access, and the same for
> A2 and B2.)  The execution has a data race if the coherence ordering
> from A1 to A2 is opposite to the ordering from B1 to B2.
> 
> Definition: Two accesses of the same location "conflict" if they are
> in different threads, they are not both marked, and they are not both
> reads.
> 
> The notions "executes before" and "is visible to" have already been
> defined for marked accesses in the LKMM or in earlier proposals for
> handling plain accesses (the xb -- or more properly, xb* -- and vis
> relations).  I trust the ideas are familiar to everyone.  Note that
> vis is contained in xb.  Also note that the vis relation is not
> transitive, because smp_wmb is not A-cumulative.  That is, it's
> possible for W1 to be visible to W2 and W2 to be visible to W3,
> without W1 being visible to W3.  (However, on systems that are other
> multicopy-atomic, vis is indeed transitive.)
> 
> We want to define data races for source programs in such a way that a
> race-free source program has no data races in any of its object-level
> executions.  To that end, we could begin with some requirements:
> 
> 	For any two conflicting writes, one must be visible to the
> 	other.
> 
> 	For a write conflicting with a read, either the write must be
> 	visible to the read or the read must execute before the write.

I'm missing the link with the notion of "data race of an object-level
execution" given above (it is possible that I did not understand that
description): could you elaborate? (maybe by providing some examples)


> 
> However, this isn't strong enough.  A source-level write can give rise
> to object-level loads as well as stores.  Therefore whenever we
> require that a plain write W be visible to some other access A, we
> must also require that if W were a read then it would execute before
> A.  And similarly, if A is required to be visible to W, we must also
> require that if W were a read then A would still be visible to it.
> 
> At the same time, it is too strong.  If W1 is required to be visible
> to W2 and W2 is required to be visible to A, then W1 doesn't
> necessarily have to be visible to A.  Visibility is required only in
> cases where W2 need not correspond to any object-level stores.
> 
> Since vis and xb aren't defined for plain accesses, we have to extend
> the definitions.  We begin by saying that a plain access is pre- or
> post-bounded by a marked access if the execution order can be
> guaranteed, as follows.
> 
> Definition:
> 
> 	A write W is "w-post-bounded" by a po-later marked access A if
> 	they are separated by an appropriate memory barrier (including
> 	the case where A is a release write).
> 
> 	A read R is "r-post-bounded" by a po-later marked access A if
> 	they are separated by an appropriate memory barrier.
> 
> 	Oddly, a plain write W is "r-post-bounded" by a po-later
> 	marked access A whenever W would be considered to be
> 	r-post-bounded by A if W were a read (for example, when A is a
> 	read and the two are separated by smp_rmb).

Looking at the patch, I see that a plain read can be "w-post-bounded":
should/can we prevent this from happening?


> 
> 	In addition, a marked write is w-post-bounded by itself and a
> 	marked read is r-post-bounded by itself.
> 
> 	An access being "w-pre-bounded" and "r-pre-bounded" by a
> 	po-earlier marked access are defined analogously, except that
> 	we also include cases where the later plain access is
> 	address-dependent on the marked access.
> 
> Note that as a result of these definitions, if one plain write is
> w-post-bounded by a marked access than all the writes in the same
> region are (this is because the memory barrier which enforces the
> bounding is also a region delimiter).  And if one plain access is
> r-post-bounded by a marked access then all the plain accesses in the
> same region are.  The same cannot be said of w-pre-bounded and
> r-pre-bounded, though, because of possible address dependencies.
> 
> Definition: ww-vis, ww-xb, wr-vis, wr-xb, and rw-xb are given by the
> following scheme.  Let i and j each be either w or r, and let rel be
> either vis or xb.  Then access A is related to access D by ij-rel if
> there are marked accesses B and C such that:
> 
> 	A ->i-post-bounded B ->rel C ->j-pre-bounded D.
> 
> For example, A is related by wr-vis to D if there are marked accesses
> B and C such that A is w-post-bounded by B, B ->vis C, and C
> r-pre-bounds D.  In cases where A or D is marked, B could be equal to
> A or C could be equal to D.
> 
> As mentioned earlier, ww-vis is contained in ww-xb and wr-vis is
> contained in wr-xb.  It turns out that the LKMM can almost prove that
> the ij-xb relations are transitive, in the following sense.  If W is a
> write and R is a read, then:
> 
> 	(A ->iw-xb W ->wj-xb C) implies (A ->ij-xb C), and
> 
> 	(A ->ir-xb R ->rj-xb C) implies (A ->ij-xb C).
> 
> To fully prove this requires adding one new term to the ppo relation:
> 
> 	[Marked & R] ; addr ; [Plain & W] ; wmb ; [Marked & W]

... or removing any of these links, right?


> 
> For example, given the code:
> 
> 	r = READ_ONCE(ptr);
> 	*r = 27;
> 	smp_wmb();
> 	WRITE_ONCE(x, 1);
> 
> the new term says that the READ_ONCE must execute before the
> WRITE_ONCE.  To justify this, note that the object code is obliged to
> ensure that *r contains 27 (or some co-later value) before the smp_wmb
> executes.  It can do so in one of three ways:
> 
> (1)	Actually store a 27 through the *r pointer;
> 
> (2)	Load through the *r pointer and check that the location already
> 	holds 27; or
> 
> (3)	Check that r aliases a pointer to a location known to hold 27
> 	already.
> 
> In case (1), the ordering is enforced by the address dependency and
> the smp_wmb.  In case (2) there is an address dependency to the *r
> load and a conditional depending on that load.  Control dependencies
> in object-code executions extend to all po-later stores; hence the
> WRITE_ONCE must be ordered after the *r load.  In case (3) there is a
> conditional depending on the READ_ONCE and po-before the WRITE_ONCE.

The proposed model is unsound w.r.t. (2); c.f., LB1 vs. LB2 from:

  http://lkml.kernel.org/r/20190116213658.GA3984@andrea

Mmh..., no particular suggestions at the moment (just blaming "addr"
and "wmb", I guess ;-) ); the fact is that "soundness" looks like a
very desirable property...


> 
> With this new term added, the LKMM can show that a cycle in the ij-xb
> relations would give rise to a cycle in xb of marked accesses.  It
> follows that in an allowed execution, the regions containing accesses
> to a particular location x can be totally ordered in a way compatible
> with the ij-xb relations, and this ordering must agree with the co and
> rf orderings for x.
> 
> Therefore we can try defining a race-free execution to be one which
> obeys the following requirements:
> 
> ww-race: If W1 ->co W2 and the two writes conflict then we must have
> 	W1 ->ww-vis W2.  If W1 is a plain write then we must also have
> 	W1 ->rw-xb W2, and if W2 is a plain write then we must also
> 	have W1 ->wr-vis W2.
> 
> wr-race: If W ->(co?;rf) R and the two accesses conflict then we must
> 	have W ->wr-vis R.
> 
> rw-race: If R ->fr W and the two accesses conflict then we must have
> 	R ->rw-xb W.
> 
> However, as described earlier, this is stronger than we really need.
> In ww-race, we don't need to have W1 ->ww-vis W2 or W1 ->wr-vis W2 if
> there is a third write W3 in between such that W3 must give rise to a
> store in the object code.  In this case it doesn't matter whether W1
> is visible to W2 or not; they can't race because W3 will be visible to
> W2 and being co-later than W1, it will prevent W1 from interfering
> with W2.  Much the same is true for wr-race.
> 
> If W3 is a marked write, it certainly corresponds to a write in the
> object code.  But what if it is a plain write?
> 
> Definition: A write is "major" if it is not overwritten by any
> po-later writes in its region.  A major write is "super" if it has a
> different value from the co-preceding major write.  In addition, all
> marked writes are considered to be super.
> 
> If a region contains a super write then the object code for the region
> must contain a store to the write's location.  Otherwise, when
> execution reached the end of the region at runtime, the value
> contained in that location would still be the value from the end of
> the preceding region -- that is, the value would be wrong.
> 
> Thus, ww-race need not apply if there is a super write co-between W1
> and W2.  Likewise, wr-race need not apply if there is a super write
> co-after W and co?-before the write which R reads from.  Note that
> these weakenings do not apply in situations where W2 is the co-next
> write after W1 or when R reads from W; in such cases ww-race and
> wr-race retain their full force.

I don't know yet...  Frankly, this idea of "semantics depending on the
_values_ of plain accesses" simply scares me. ;-)

Let's look at your "non-transitive-wmb" test: I tend to read the write
"*x = 2" as nothing more than "write 2 to the 1st byte, write 0 to the
2nd byte, write 0 to the next byte, ...";  and similarly for "*x = 1";
maybe some of these writes aren't performed at all (the compiler knows
that the most significant byte, say, is never touched/modified); maybe
they intersect (overwrite) one another...  what else?  So, for example,
if we "slice" the most significant parts of the plain writes in P0 and
P1 then they have the "same value" in a certain sense.

Mmh, I still don't feel comfortable with these concepts sorry, maybe I
just need more time to process them...


> 
> The LKMM also has to detect forbidden executions involving plain
> accesses.  There are three obvious coherence-related checks:
> 
> 	If W ->rf R then we must not have R ->rw-xb W.
> 
> 	If R ->fr W then we must not have W ->wr-vis R.
> 
> 	If W1 ->co W2 then we must not have W2 ->ww-vis W1.
> 
> (Question: Are these checks actually correct?  I'm not certain; they
> are hard to reason about because co, rf, and fr don't have clear
> meanings for plain accesses in racy executions.)

So maybe they were not that "obvious". ;-)

This all deserves a careful review and testing; unfortunately, I doubt
that I'll be able to do much more in the next couple of weeks.  bbl,

  Andrea


> 
> These proposed changes do not include any ordering due to dependencies
> from plain reads to marked accesses, or from overwrites.  Perhaps we
> will want to add them later on.
> 
> Some relevant and interesting litmus tests:
> 
> C non-transitive-wmb
> (* allowed, no race *)
> 
> {}
> 
> P0(int *x, int *y)
> {
> 	*x = 1;
> 	smp_store_release(y, 1);
> }
> 
> P1(int *x, int *y, int *z)
> {
> 	int r1;
> 
> 	r1 = smp_load_acquire(y);
> 	if (r1) {
> 		*x = 2;
> 		smp_wmb();
> 		WRITE_ONCE(*z, 1);
> 	}
> }
> 
> P2(int *x, int *z)
> {
> 	int r3;
> 	int r4 = 0;
> 
> 	r3 = READ_ONCE(*z);
> 	if (r3) {
> 		smp_rmb();
> 		r4 = READ_ONCE(*x);
> 	}
> }
> 
> exists (2:r3=1 /\ 2:r4=2)
> 
> If the plain write in P1 were changed to "*x = 1" then it would no
> longer be super, and P0 would race with P2.
> 
> C LB1
> (* forbidden, no race *)
> 
> {
>         int *x = &a;
> }
> 
> P0(int **x, int *y)
> {
>         int *r0;
> 
>         r0 = rcu_dereference(*x);
>         *r0 = 0;
>         smp_wmb();
>         WRITE_ONCE(*y, 1);
> }
> 
> P1(int **x, int *y, int *b)
> {
>         int r0;
> 
>         r0 = READ_ONCE(*y);
>         rcu_assign_pointer(*x, b);
> }
> 
> exists (0:r0=b /\ 1:r0=1)
> 
> The new term in ppo forces P0's rcu_dereference to execute before the
> WRITE_ONCE.
> 
> C non-race4
> (* allowed (should be forbidden), no race *)
> 
> {
> int *x = a;
> }
> 
> P0(int **x, int *b)
> {
> 	*b = 1;
> 	smp_store_release(*x, b);
> }
> 
> P1(int **x, int **tmp)
> {
> 	int *r1;
> 	int *r2;
> 	int r3;
> 
> 	r1 = READ_ONCE(*x);
> 	*tmp = r1;
> 	r2 = *tmp;
> 	r3 = *r2;
> }
> 
> exists (1:r1=b /\ 1:r3=0)
> 
> It's pretty obvious that P1's read of *r2 must execute after the
> READ_ONCE, but the model doesn't know this.
> 
> C overwrite-race
> 
> {}
> 
> P0(int *x)
> {
> 	int r0;
> 
> 	r0 = *x;
> 	WRITE_ONCE(*x, 1);
> }
> 
> P1(int *x)
> {
> 	int r1;
> 
> 	r1 = READ_ONCE(*x);
> 	if (r1 == 1)
> 		WRITE_ONCE(*x, 2);
> }
> 
> exists (1:r1=1)
> 
> This counts as a race, because the compiler is allowed to generate
> loads from *x po-after P0's WRITE_ONCE.
> 
> C plain-ppo1
> (* allowed (should be forbidden), no race *)
> 
> {
> int *x = &u;
> int u = 0;
> int z = 5;
> }
> 
> P0(int **x, int *y)
> {
> 	int *r0;
> 	int r1;
> 
> 	r0 = READ_ONCE(*x);
> 	r1 = *r0;
> 	WRITE_ONCE(*y, r1);
> }
> 
> P1(int **x, int *y, int *z)
> {
> 	int r2;
> 
> 	r2 = READ_ONCE(*y);
> 	if (r2)
> 		WRITE_ONCE(*x, z);
> }
> 
> exists (0:r0=z /\ 0:r1=5 /\ 1:r2=5)
> 
> The model does not recognize that P0's WRITE_ONCE must execute after
> the READ_ONCE.

>  tools/memory-model/linux-kernel.bell |    6 ++
>  tools/memory-model/linux-kernel.cat  |   94 +++++++++++++++++++++++++++++------
>  tools/memory-model/linux-kernel.def  |    1 
>  3 files changed, 86 insertions(+), 15 deletions(-)
> 
> Index: lkmm/tools/memory-model/linux-kernel.bell
> ===================================================================
> --- lkmm.orig/tools/memory-model/linux-kernel.bell
> +++ lkmm/tools/memory-model/linux-kernel.bell
> @@ -24,6 +24,7 @@ instructions RMW[{'once,'acquire,'releas
>  enum Barriers = 'wmb (*smp_wmb*) ||
>  		'rmb (*smp_rmb*) ||
>  		'mb (*smp_mb*) ||
> +		'barrier (*barrier*) ||
>  		'rcu-lock (*rcu_read_lock*)  ||
>  		'rcu-unlock (*rcu_read_unlock*) ||
>  		'sync-rcu (*synchronize_rcu*) ||
> @@ -76,3 +77,8 @@ flag ~empty rcu-rscs & (po ; [Sync-srcu]
>  
>  (* Validate SRCU dynamic match *)
>  flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
> +
> +(* Compute marked and plain memory accesses *)
> +let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
> +		LKR | LKW | UL | LF | RL | RU
> +let Plain = M \ Marked
> Index: lkmm/tools/memory-model/linux-kernel.cat
> ===================================================================
> --- lkmm.orig/tools/memory-model/linux-kernel.cat
> +++ lkmm/tools/memory-model/linux-kernel.cat
> @@ -24,8 +24,14 @@ include "lock.cat"
>  (* Basic relations *)
>  (*******************)
>  
> +(* Release Acquire *)
> +let acq-po = [Acquire] ; po ; [M]
> +let po-rel = [M] ; po ; [Release]
> +let po-unlock-rf-lock-po = po ; [UL] ; rf ; [LKR] ; po
> +
>  (* Fences *)
> -let rmb = [R \ Noreturn] ; fencerel(Rmb) ; [R \ Noreturn]
> +let R4rmb = R \ Noreturn	(* Reads for which rmb works *)
> +let rmb = [R4rmb] ; fencerel(Rmb) ; [R4rmb]
>  let wmb = [W] ; fencerel(Wmb) ; [W]
>  let mb = ([M] ; fencerel(Mb) ; [M]) |
>  	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
> @@ -34,13 +40,14 @@ let mb = ([M] ; fencerel(Mb) ; [M]) |
>  	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
>  		fencerel(After-unlock-lock) ; [M])
>  let gp = po ; [Sync-rcu | Sync-srcu] ; po?
> -
>  let strong-fence = mb | gp
>  
> -(* Release Acquire *)
> -let acq-po = [Acquire] ; po ; [M]
> -let po-rel = [M] ; po ; [Release]
> -let po-unlock-rf-lock-po = po ; [UL] ; rf ; [LKR] ; po
> +let nonrw-fence = strong-fence | po-rel | acq-po
> +let fence = nonrw-fence | wmb | rmb
> +let barrier = fencerel(Barrier | Rmb | Wmb | Mb | Sync-rcu | Sync-srcu |
> +		Acquire | Release) |
> +	(po ; [Acquire | Release]) |
> +	([Acquire | Release] ; po)
>  
>  (**********************************)
>  (* Fundamental coherence ordering *)
> @@ -61,21 +68,22 @@ empty rmw & (fre ; coe) as atomic
>  let dep = addr | data
>  let rwdep = (dep | ctrl) ; [W]
>  let overwrite = co | fr
> -let to-w = rwdep | (overwrite & int)
> -let to-r = addr | (dep ; rfi)
> -let fence = strong-fence | wmb | po-rel | rmb | acq-po
> +let to-w = rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
> +let to-r = addr | (dep ; [Marked] ; rfi)
>  let ppo = to-r | to-w | fence | (po-unlock-rf-lock-po & int)
>  
>  (* Propagation: Ordering from release operations and strong fences. *)
> -let A-cumul(r) = rfe? ; r
> -let cumul-fence = A-cumul(strong-fence | po-rel) | wmb | po-unlock-rf-lock-po
> -let prop = (overwrite & ext)? ; cumul-fence* ; rfe?
> +let A-cumul(r) = (rfe ; [Marked])? ; r
> +let cumul-fence = [Marked] ; (A-cumul(strong-fence | po-rel) | wmb |
> +	po-unlock-rf-lock-po) ; [Marked]
> +let prop = [Marked] ; (overwrite & ext)? ; cumul-fence* ;
> +	[Marked] ; rfe? ; [Marked]
>  
>  (*
>   * Happens Before: Ordering from the passage of time.
>   * No fences needed here for prop because relation confined to one process.
>   *)
> -let hb = ppo | rfe | ((prop \ id) & int)
> +let hb = [Marked] ; (ppo | rfe | ((prop \ id) & int)) ; [Marked]
>  acyclic hb as happens-before
>  
>  (****************************************)
> @@ -83,7 +91,7 @@ acyclic hb as happens-before
>  (****************************************)
>  
>  (* Propagation: Each non-rf link needs a strong fence. *)
> -let pb = prop ; strong-fence ; hb*
> +let pb = prop ; strong-fence ; hb* ; [Marked]
>  acyclic pb as propagation
>  
>  (*******)
> @@ -131,7 +139,7 @@ let rec rcu-fence = rcu-gp | srcu-gp |
>  	(rcu-fence ; rcu-link ; rcu-fence)
>  
>  (* rb orders instructions just as pb does *)
> -let rb = prop ; po ; rcu-fence ; po? ; hb* ; pb*
> +let rb = prop ; po ; rcu-fence ; po? ; hb* ; pb* ; [Marked]
>  
>  irreflexive rb as rcu
>  
> @@ -143,3 +151,59 @@ irreflexive rb as rcu
>   * let xb = hb | pb | rb
>   * acyclic xb as executes-before
>   *)
> +
> +
> +(*********************************)
> +(* Plain accesses and data races *)
> +(*********************************)
> +
> +(* Warn about plain writes and marked accesses in the same region *)
> +let mixed-accesses = ([Plain & W] ; (po-loc \ barrier) ; [Marked]) |
> +	([Marked] ; (po-loc \ barrier) ; [Plain & W])
> +flag ~empty mixed-accesses as mixed-accesses
> +
> +(* Executes-before and visibility *)
> +let xbstar = (hb | pb | rb)*
> +let full-fence = strong-fence | (po ; rcu-fence ; po?)
> +let vis = cumul-fence* ; rfe? ; [Marked] ;
> +	((full-fence ; [Marked] ; xbstar) | (xbstar & int))
> +
> +(* Boundaries for lifetimes of plain accesses *)
> +let w-pre-bounded = [Marked] ; (addr | fence)?
> +let r-pre-bounded = [Marked] ; (addr | nonrw-fence |
> +	([R4rmb] ; fencerel(Rmb) ; [~Noreturn]))?
> +let w-post-bounded = fence? ; [Marked]
> +let r-post-bounded = (nonrw-fence | ([~Noreturn] ; fencerel(Rmb) ; [R4rmb]))? ;
> +	[Marked]
> +
> +(* Visibility and executes-before for plain accesses *)
> +let ww-vis = w-post-bounded ; vis ; w-pre-bounded
> +let wr-vis = w-post-bounded ; vis ; r-pre-bounded
> +let rw-xbstar = r-post-bounded ; xbstar ; w-pre-bounded
> +
> +(* Potential races *)
> +let pre-race = ext & ((Plain * M) | ((M \ IW) * Plain))
> +
> +(* Coherence requirements for plain accesses *)
> +let wr-incoh = pre-race & rf & rw-xbstar^-1
> +let rw-incoh = pre-race & fr & wr-vis^-1
> +let ww-incoh = pre-race & co & ww-vis^-1
> +empty (wr-incoh | rw-incoh | ww-incoh) as plain-coherence
> +
> +(* Actual races *)
> +let ww-nonrace = ww-vis & ((Marked * W) | rw-xbstar) & ((W * Marked) | wr-vis)
> +let ww-race = (pre-race & co) \ ww-nonrace
> +let wr-race = (pre-race & (co? ; rf)) \ wr-vis
> +let rw-race = (pre-race & fr) \ rw-xbstar
> +
> +(* Major writes, super writes, and superseded writes *)
> +let Major-w = W \ domain(coi \ barrier)
> +let Super-w = (W & Marked) |
> +	range(different-values(singlestep([Major-w] ; co ; [Major-w])))
> +let superseded-w = co ; [Super-w] ; (co | (co? ; rf))
> +
> +(* Superseded writes don't race *)
> +let ww-race = ww-race \ superseded-w
> +let wr-race = wr-race \ superseded-w
> +
> +flag ~empty (ww-race | wr-race | rw-race) as data-race
> Index: lkmm/tools/memory-model/linux-kernel.def
> ===================================================================
> --- lkmm.orig/tools/memory-model/linux-kernel.def
> +++ lkmm/tools/memory-model/linux-kernel.def
> @@ -24,6 +24,7 @@ smp_mb__before_atomic() { __fence{before
>  smp_mb__after_atomic() { __fence{after-atomic}; }
>  smp_mb__after_spinlock() { __fence{after-spinlock}; }
>  smp_mb__after_unlock_lock() { __fence{after-unlock-lock}; }
> +barrier() { __fence{barrier}; }
>  
>  // Exchange
>  xchg(X,V)  __xchg{mb}(X,V)

