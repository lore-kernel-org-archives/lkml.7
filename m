Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3402CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F0420811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfCSTiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 15:38:20 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:60022 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726627AbfCSTiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 15:38:20 -0400
Received: (qmail 6886 invoked by uid 2102); 19 Mar 2019 15:38:19 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Mar 2019 15:38:19 -0400
Date:   Tue, 19 Mar 2019 15:38:19 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
cc:     Daniel Kroening <kroening@cs.ox.ac.uk>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Adding plain accesses and detecting data races in the LKMM
Message-ID: <Pine.LNX.4.44L0.1903191459270.1593-200000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1559625215-990642464-1553024299=:1593"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1559625215-990642464-1553024299=:1593
Content-Type: TEXT/PLAIN; charset=US-ASCII

LKMM maintainers and other interested parties:

Here is my latest proposal for extending the Linux Kernel Memory Model 
to handle plain accesses and data races.  The document below explains 
the rationale behind the proposal, and a patch (based on the dev 
branch of Paul's linux-rcu tree) is attached.

This extension is not a complete treatment of plain accesses, because 
it pretty much ignores any ordering that plain accesses can provide.  
For example, given:

	r0 = rcu_dereference(ptr);
	r1 = r0->branch;
	r2 = READ_ONCE(&r1->data);

the memory model will not realize that the READ_ONCE must execute after
the rcu_dereference, because it doesn't take into account the address
dependency from the intermediate plain read.  Hopefully we will add 
such things to the memory model later on.  Concentrating on data races 
seems like enough for now.

Some of the ideas below were originally proposed for the LKMM by Andrea
Parri.

Alan

-----------------------------------------------------------------------

A Plan For Modeling Plain Accesses In The Linux Kernel Memory Model

Definition: A "plain" access is one which is not "marked".  Marked
accesses include all those annotated with READ_ONCE or WRITE_ONCE,
plus acquire and release accesses, Read-Modify-Write (RMW) atomic
and bitop accesses, and locking accesses.

Plain accesses are those the compiler is free to mess around with.
Marked accesses are implemented in the kernel by means of inline
assembly or as volatile accesses, which greatly restricts what the
compiler can do.

Definition: A "region" of code is a program-order source segment
contained in a single thread that is maximal with respect to not
containing any compiler barriers (i.e., it is bounded at each end by
either a compiler barrier or the start or end of its thread).

Assumption: All memory barriers are also compiler barriers.  This
includes acquire loads and release stores, which are not considered to
be compiler barriers in the C++11 Standard, as well as non-relaxed RMW
atomic operations.  (Question: should this include situation-specific
memory barriers such as smp_mb__after_unlock_lock?  Probably not.)

To avoid complications, the LKMM will consider only code in which
plain writes are separated by a compiler barrier from any marked
accesses of the same location.  (Question: Can this restriction be
removed?)  As a consequence, if a region contains any marked accesses
to a particular location then it cannot contain any plain writes to
that location.

This analysis is guided by the intuition that one can set up a limited
correspondence between an execution of the source code and an
execution of the generated object code.  Such a correspondence is
based on some limitations on what compilers can do when translating a
program:

	Each marked access in the source-level execution must
	correspond to a unique instruction in the object-level
	execution.  The corresponding events must access the same
	location, have the same values, and be of the same type (read
	or write).

	If a marked access is address-dependent on a marked read then
	the corresponding object-level instructions must have the same
	dependency (i.e., the compiler does not break address
	dependencies for marked accesses).

	If a source region contains no plain accesses to a location
	then the corresponding object-level region contains no
	accesses to that location other than those corresponding to
	marked accesses.

	If a source region contains no plain writes to a location then
	the corresponding object-level region contains no stores to
	that location other than those corresponding to marked writes.

	If a source region contains a plain write then the object code
	corresponding to that region must contain at least one access
	(it could be a load instead of a store) to the same location.

	If all the accesses to a particular location in some source
	region are address-dependent on one of the marked reads in
	some set S then every object-level access of that location
	must be dependent (not necessarily address-dependent, when the
	access is a store) on one of the instructions corresponding to
	the members of S.

	The object code for a region must ensure that the final value
	stored in a location is the same as the value of the po-final
	source write in the region.

The positions of the load and store instructions in the object code
for a region do not have to bear any particular relation to the plain
accesses in the source code.  Subject to the restrictions above, a
sequence of m plain writes in the source could be implemented by a
sequence of n store instructions at runtime where n is <, =, or > m,
and likewise for plain reads.

Similarly, the rf, co, and fr relations for plain accesses in
source-level executions have very limited meaning.

Given an object-level execution, let A1 and B1 be accesses in region
R1 and let A2 and B2 be accesses in region R2, all of the same
location, not all reads, and not all corresponding to marked accesses.
(We explicitly allow A1 and B1 to be the same access, and the same for
A2 and B2.)  The execution has a data race if the coherence ordering
from A1 to A2 is opposite to the ordering from B1 to B2.

Definition: Two accesses of the same location "conflict" if they are
in different threads, they are not both marked, and they are not both
reads.

The notions "executes before" and "is visible to" have already been
defined for marked accesses in the LKMM or in earlier proposals for
handling plain accesses (the xb -- or more properly, xb* -- and vis
relations).  I trust the ideas are familiar to everyone.  Note that
vis is contained in xb.  Also note that the vis relation is not
transitive, because smp_wmb is not A-cumulative.  That is, it's
possible for W1 to be visible to W2 and W2 to be visible to W3,
without W1 being visible to W3.  (However, on systems that are other
multicopy-atomic, vis is indeed transitive.)

We want to define data races for source programs in such a way that a
race-free source program has no data races in any of its object-level
executions.  To that end, we could begin with some requirements:

	For any two conflicting writes, one must be visible to the
	other.

	For a write conflicting with a read, either the write must be
	visible to the read or the read must execute before the write.

However, this isn't strong enough.  A source-level write can give rise
to object-level loads as well as stores.  Therefore whenever we
require that a plain write W be visible to some other access A, we
must also require that if W were a read then it would execute before
A.  And similarly, if A is required to be visible to W, we must also
require that if W were a read then A would still be visible to it.

At the same time, it is too strong.  If W1 is required to be visible
to W2 and W2 is required to be visible to A, then W1 doesn't
necessarily have to be visible to A.  Visibility is required only in
cases where W2 need not correspond to any object-level stores.

Since vis and xb aren't defined for plain accesses, we have to extend
the definitions.  We begin by saying that a plain access is pre- or
post-bounded by a marked access if the execution order can be
guaranteed, as follows.

Definition:

	A write W is "w-post-bounded" by a po-later marked access A if
	they are separated by an appropriate memory barrier (including
	the case where A is a release write).

	A read R is "r-post-bounded" by a po-later marked access A if
	they are separated by an appropriate memory barrier.

	Oddly, a plain write W is "r-post-bounded" by a po-later
	marked access A whenever W would be considered to be
	r-post-bounded by A if W were a read (for example, when A is a
	read and the two are separated by smp_rmb).

	In addition, a marked write is w-post-bounded by itself and a
	marked read is r-post-bounded by itself.

	An access being "w-pre-bounded" and "r-pre-bounded" by a
	po-earlier marked access are defined analogously, except that
	we also include cases where the later plain access is
	address-dependent on the marked access.

Note that as a result of these definitions, if one plain write is
w-post-bounded by a marked access than all the writes in the same
region are (this is because the memory barrier which enforces the
bounding is also a region delimiter).  And if one plain access is
r-post-bounded by a marked access then all the plain accesses in the
same region are.  The same cannot be said of w-pre-bounded and
r-pre-bounded, though, because of possible address dependencies.

Definition: ww-vis, ww-xb, wr-vis, wr-xb, and rw-xb are given by the
following scheme.  Let i and j each be either w or r, and let rel be
either vis or xb.  Then access A is related to access D by ij-rel if
there are marked accesses B and C such that:

	A ->i-post-bounded B ->rel C ->j-pre-bounded D.

For example, A is related by wr-vis to D if there are marked accesses
B and C such that A is w-post-bounded by B, B ->vis C, and C
r-pre-bounds D.  In cases where A or D is marked, B could be equal to
A or C could be equal to D.

As mentioned earlier, ww-vis is contained in ww-xb and wr-vis is
contained in wr-xb.  It turns out that the LKMM can almost prove that
the ij-xb relations are transitive, in the following sense.  If W is a
write and R is a read, then:

	(A ->iw-xb W ->wj-xb C) implies (A ->ij-xb C), and

	(A ->ir-xb R ->rj-xb C) implies (A ->ij-xb C).

To fully prove this requires adding one new term to the ppo relation:

	[Marked & R] ; addr ; [Plain & W] ; wmb ; [Marked & W]

For example, given the code:

	r = READ_ONCE(ptr);
	*r = 27;
	smp_wmb();
	WRITE_ONCE(x, 1);

the new term says that the READ_ONCE must execute before the
WRITE_ONCE.  To justify this, note that the object code is obliged to
ensure that *r contains 27 (or some co-later value) before the smp_wmb
executes.  It can do so in one of three ways:

(1)	Actually store a 27 through the *r pointer;

(2)	Load through the *r pointer and check that the location already
	holds 27; or

(3)	Check that r aliases a pointer to a location known to hold 27
	already.

In case (1), the ordering is enforced by the address dependency and
the smp_wmb.  In case (2) there is an address dependency to the *r
load and a conditional depending on that load.  Control dependencies
in object-code executions extend to all po-later stores; hence the
WRITE_ONCE must be ordered after the *r load.  In case (3) there is a
conditional depending on the READ_ONCE and po-before the WRITE_ONCE.

With this new term added, the LKMM can show that a cycle in the ij-xb
relations would give rise to a cycle in xb of marked accesses.  It
follows that in an allowed execution, the regions containing accesses
to a particular location x can be totally ordered in a way compatible
with the ij-xb relations, and this ordering must agree with the co and
rf orderings for x.

Therefore we can try defining a race-free execution to be one which
obeys the following requirements:

ww-race: If W1 ->co W2 and the two writes conflict then we must have
	W1 ->ww-vis W2.  If W1 is a plain write then we must also have
	W1 ->rw-xb W2, and if W2 is a plain write then we must also
	have W1 ->wr-vis W2.

wr-race: If W ->(co?;rf) R and the two accesses conflict then we must
	have W ->wr-vis R.

rw-race: If R ->fr W and the two accesses conflict then we must have
	R ->rw-xb W.

However, as described earlier, this is stronger than we really need.
In ww-race, we don't need to have W1 ->ww-vis W2 or W1 ->wr-vis W2 if
there is a third write W3 in between such that W3 must give rise to a
store in the object code.  In this case it doesn't matter whether W1
is visible to W2 or not; they can't race because W3 will be visible to
W2 and being co-later than W1, it will prevent W1 from interfering
with W2.  Much the same is true for wr-race.

If W3 is a marked write, it certainly corresponds to a write in the
object code.  But what if it is a plain write?

Definition: A write is "major" if it is not overwritten by any
po-later writes in its region.  A major write is "super" if it has a
different value from the co-preceding major write.  In addition, all
marked writes are considered to be super.

If a region contains a super write then the object code for the region
must contain a store to the write's location.  Otherwise, when
execution reached the end of the region at runtime, the value
contained in that location would still be the value from the end of
the preceding region -- that is, the value would be wrong.

Thus, ww-race need not apply if there is a super write co-between W1
and W2.  Likewise, wr-race need not apply if there is a super write
co-after W and co?-before the write which R reads from.  Note that
these weakenings do not apply in situations where W2 is the co-next
write after W1 or when R reads from W; in such cases ww-race and
wr-race retain their full force.

The LKMM also has to detect forbidden executions involving plain
accesses.  There are three obvious coherence-related checks:

	If W ->rf R then we must not have R ->rw-xb W.

	If R ->fr W then we must not have W ->wr-vis R.

	If W1 ->co W2 then we must not have W2 ->ww-vis W1.

(Question: Are these checks actually correct?  I'm not certain; they
are hard to reason about because co, rf, and fr don't have clear
meanings for plain accesses in racy executions.)

These proposed changes do not include any ordering due to dependencies
from plain reads to marked accesses, or from overwrites.  Perhaps we
will want to add them later on.

Some relevant and interesting litmus tests:

C non-transitive-wmb
(* allowed, no race *)

{}

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
		r4 = READ_ONCE(*x);
	}
}

exists (2:r3=1 /\ 2:r4=2)

If the plain write in P1 were changed to "*x = 1" then it would no
longer be super, and P0 would race with P2.

C LB1
(* forbidden, no race *)

{
        int *x = &a;
}

P0(int **x, int *y)
{
        int *r0;

        r0 = rcu_dereference(*x);
        *r0 = 0;
        smp_wmb();
        WRITE_ONCE(*y, 1);
}

P1(int **x, int *y, int *b)
{
        int r0;

        r0 = READ_ONCE(*y);
        rcu_assign_pointer(*x, b);
}

exists (0:r0=b /\ 1:r0=1)

The new term in ppo forces P0's rcu_dereference to execute before the
WRITE_ONCE.

C non-race4
(* allowed (should be forbidden), no race *)

{
int *x = a;
}

P0(int **x, int *b)
{
	*b = 1;
	smp_store_release(*x, b);
}

P1(int **x, int **tmp)
{
	int *r1;
	int *r2;
	int r3;

	r1 = READ_ONCE(*x);
	*tmp = r1;
	r2 = *tmp;
	r3 = *r2;
}

exists (1:r1=b /\ 1:r3=0)

It's pretty obvious that P1's read of *r2 must execute after the
READ_ONCE, but the model doesn't know this.

C overwrite-race

{}

P0(int *x)
{
	int r0;

	r0 = *x;
	WRITE_ONCE(*x, 1);
}

P1(int *x)
{
	int r1;

	r1 = READ_ONCE(*x);
	if (r1 == 1)
		WRITE_ONCE(*x, 2);
}

exists (1:r1=1)

This counts as a race, because the compiler is allowed to generate
loads from *x po-after P0's WRITE_ONCE.

C plain-ppo1
(* allowed (should be forbidden), no race *)

{
int *x = &u;
int u = 0;
int z = 5;
}

P0(int **x, int *y)
{
	int *r0;
	int r1;

	r0 = READ_ONCE(*x);
	r1 = *r0;
	WRITE_ONCE(*y, r1);
}

P1(int **x, int *y, int *z)
{
	int r2;

	r2 = READ_ONCE(*y);
	if (r2)
		WRITE_ONCE(*x, z);
}

exists (0:r0=z /\ 0:r1=5 /\ 1:r2=5)

The model does not recognize that P0's WRITE_ONCE must execute after
the READ_ONCE.

---1559625215-990642464-1553024299=:1593
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="plain-race.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44L0.1903191538190.1593@iolanthe.rowland.org>
Content-Description: 
Content-Disposition: attachment; filename="plain-race.patch"

IHRvb2xzL21lbW9yeS1tb2RlbC9saW51eC1rZXJuZWwuYmVsbCB8ICAgIDYg
KysNCiB0b29scy9tZW1vcnktbW9kZWwvbGludXgta2VybmVsLmNhdCAgfCAg
IDk0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQogdG9v
bHMvbWVtb3J5LW1vZGVsL2xpbnV4LWtlcm5lbC5kZWYgIHwgICAgMSANCiAz
IGZpbGVzIGNoYW5nZWQsIDg2IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9u
cygtKQ0KDQpJbmRleDogbGttbS90b29scy9tZW1vcnktbW9kZWwvbGludXgt
a2VybmVsLmJlbGwNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCi0tLSBsa21t
Lm9yaWcvdG9vbHMvbWVtb3J5LW1vZGVsL2xpbnV4LWtlcm5lbC5iZWxsDQor
KysgbGttbS90b29scy9tZW1vcnktbW9kZWwvbGludXgta2VybmVsLmJlbGwN
CkBAIC0yNCw2ICsyNCw3IEBAIGluc3RydWN0aW9ucyBSTVdbeydvbmNlLCdh
Y3F1aXJlLCdyZWxlYXMNCiBlbnVtIEJhcnJpZXJzID0gJ3dtYiAoKnNtcF93
bWIqKSB8fA0KIAkJJ3JtYiAoKnNtcF9ybWIqKSB8fA0KIAkJJ21iICgqc21w
X21iKikgfHwNCisJCSdiYXJyaWVyICgqYmFycmllciopIHx8DQogCQkncmN1
LWxvY2sgKCpyY3VfcmVhZF9sb2NrKikgIHx8DQogCQkncmN1LXVubG9jayAo
KnJjdV9yZWFkX3VubG9jayopIHx8DQogCQknc3luYy1yY3UgKCpzeW5jaHJv
bml6ZV9yY3UqKSB8fA0KQEAgLTc2LDMgKzc3LDggQEAgZmxhZyB+ZW1wdHkg
cmN1LXJzY3MgJiAocG8gOyBbU3luYy1zcmN1XQ0KIA0KICgqIFZhbGlkYXRl
IFNSQ1UgZHluYW1pYyBtYXRjaCAqKQ0KIGZsYWcgfmVtcHR5IGRpZmZlcmVu
dC12YWx1ZXMoc3JjdS1yc2NzKSBhcyBzcmN1LWJhZC1uZXN0aW5nDQorDQor
KCogQ29tcHV0ZSBtYXJrZWQgYW5kIHBsYWluIG1lbW9yeSBhY2Nlc3NlcyAq
KQ0KK2xldCBNYXJrZWQgPSAofk0pIHwgSVcgfCBPbmNlIHwgUmVsZWFzZSB8
IEFjcXVpcmUgfCBkb21haW4ocm13KSB8IHJhbmdlKHJtdykgfA0KKwkJTEtS
IHwgTEtXIHwgVUwgfCBMRiB8IFJMIHwgUlUNCitsZXQgUGxhaW4gPSBNIFwg
TWFya2VkDQpJbmRleDogbGttbS90b29scy9tZW1vcnktbW9kZWwvbGludXgt
a2VybmVsLmNhdA0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KLS0tIGxrbW0u
b3JpZy90b29scy9tZW1vcnktbW9kZWwvbGludXgta2VybmVsLmNhdA0KKysr
IGxrbW0vdG9vbHMvbWVtb3J5LW1vZGVsL2xpbnV4LWtlcm5lbC5jYXQNCkBA
IC0yNCw4ICsyNCwxNCBAQCBpbmNsdWRlICJsb2NrLmNhdCINCiAoKiBCYXNp
YyByZWxhdGlvbnMgKikNCiAoKioqKioqKioqKioqKioqKioqKikNCiANCiso
KiBSZWxlYXNlIEFjcXVpcmUgKikNCitsZXQgYWNxLXBvID0gW0FjcXVpcmVd
IDsgcG8gOyBbTV0NCitsZXQgcG8tcmVsID0gW01dIDsgcG8gOyBbUmVsZWFz
ZV0NCitsZXQgcG8tdW5sb2NrLXJmLWxvY2stcG8gPSBwbyA7IFtVTF0gOyBy
ZiA7IFtMS1JdIDsgcG8NCisNCiAoKiBGZW5jZXMgKikNCi1sZXQgcm1iID0g
W1IgXCBOb3JldHVybl0gOyBmZW5jZXJlbChSbWIpIDsgW1IgXCBOb3JldHVy
bl0NCitsZXQgUjRybWIgPSBSIFwgTm9yZXR1cm4JKCogUmVhZHMgZm9yIHdo
aWNoIHJtYiB3b3JrcyAqKQ0KK2xldCBybWIgPSBbUjRybWJdIDsgZmVuY2Vy
ZWwoUm1iKSA7IFtSNHJtYl0NCiBsZXQgd21iID0gW1ddIDsgZmVuY2VyZWwo
V21iKSA7IFtXXQ0KIGxldCBtYiA9IChbTV0gOyBmZW5jZXJlbChNYikgOyBb
TV0pIHwNCiAJKFtNXSA7IGZlbmNlcmVsKEJlZm9yZS1hdG9taWMpIDsgW1JN
V10gOyBwbz8gOyBbTV0pIHwNCkBAIC0zNCwxMyArNDAsMTQgQEAgbGV0IG1i
ID0gKFtNXSA7IGZlbmNlcmVsKE1iKSA7IFtNXSkgfA0KIAkoW01dIDsgcG8g
OyBbVUxdIDsgKGNvIHwgcG8pIDsgW0xLV10gOw0KIAkJZmVuY2VyZWwoQWZ0
ZXItdW5sb2NrLWxvY2spIDsgW01dKQ0KIGxldCBncCA9IHBvIDsgW1N5bmMt
cmN1IHwgU3luYy1zcmN1XSA7IHBvPw0KLQ0KIGxldCBzdHJvbmctZmVuY2Ug
PSBtYiB8IGdwDQogDQotKCogUmVsZWFzZSBBY3F1aXJlICopDQotbGV0IGFj
cS1wbyA9IFtBY3F1aXJlXSA7IHBvIDsgW01dDQotbGV0IHBvLXJlbCA9IFtN
XSA7IHBvIDsgW1JlbGVhc2VdDQotbGV0IHBvLXVubG9jay1yZi1sb2NrLXBv
ID0gcG8gOyBbVUxdIDsgcmYgOyBbTEtSXSA7IHBvDQorbGV0IG5vbnJ3LWZl
bmNlID0gc3Ryb25nLWZlbmNlIHwgcG8tcmVsIHwgYWNxLXBvDQorbGV0IGZl
bmNlID0gbm9ucnctZmVuY2UgfCB3bWIgfCBybWINCitsZXQgYmFycmllciA9
IGZlbmNlcmVsKEJhcnJpZXIgfCBSbWIgfCBXbWIgfCBNYiB8IFN5bmMtcmN1
IHwgU3luYy1zcmN1IHwNCisJCUFjcXVpcmUgfCBSZWxlYXNlKSB8DQorCShw
byA7IFtBY3F1aXJlIHwgUmVsZWFzZV0pIHwNCisJKFtBY3F1aXJlIHwgUmVs
ZWFzZV0gOyBwbykNCiANCiAoKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKikNCiAoKiBGdW5kYW1lbnRhbCBjb2hlcmVuY2Ugb3JkZXJpbmcg
KikNCkBAIC02MSwyMSArNjgsMjIgQEAgZW1wdHkgcm13ICYgKGZyZSA7IGNv
ZSkgYXMgYXRvbWljDQogbGV0IGRlcCA9IGFkZHIgfCBkYXRhDQogbGV0IHJ3
ZGVwID0gKGRlcCB8IGN0cmwpIDsgW1ddDQogbGV0IG92ZXJ3cml0ZSA9IGNv
IHwgZnINCi1sZXQgdG8tdyA9IHJ3ZGVwIHwgKG92ZXJ3cml0ZSAmIGludCkN
Ci1sZXQgdG8tciA9IGFkZHIgfCAoZGVwIDsgcmZpKQ0KLWxldCBmZW5jZSA9
IHN0cm9uZy1mZW5jZSB8IHdtYiB8IHBvLXJlbCB8IHJtYiB8IGFjcS1wbw0K
K2xldCB0by13ID0gcndkZXAgfCAob3ZlcndyaXRlICYgaW50KSB8IChhZGRy
IDsgW1BsYWluXSA7IHdtYikNCitsZXQgdG8tciA9IGFkZHIgfCAoZGVwIDsg
W01hcmtlZF0gOyByZmkpDQogbGV0IHBwbyA9IHRvLXIgfCB0by13IHwgZmVu
Y2UgfCAocG8tdW5sb2NrLXJmLWxvY2stcG8gJiBpbnQpDQogDQogKCogUHJv
cGFnYXRpb246IE9yZGVyaW5nIGZyb20gcmVsZWFzZSBvcGVyYXRpb25zIGFu
ZCBzdHJvbmcgZmVuY2VzLiAqKQ0KLWxldCBBLWN1bXVsKHIpID0gcmZlPyA7
IHINCi1sZXQgY3VtdWwtZmVuY2UgPSBBLWN1bXVsKHN0cm9uZy1mZW5jZSB8
IHBvLXJlbCkgfCB3bWIgfCBwby11bmxvY2stcmYtbG9jay1wbw0KLWxldCBw
cm9wID0gKG92ZXJ3cml0ZSAmIGV4dCk/IDsgY3VtdWwtZmVuY2UqIDsgcmZl
Pw0KK2xldCBBLWN1bXVsKHIpID0gKHJmZSA7IFtNYXJrZWRdKT8gOyByDQor
bGV0IGN1bXVsLWZlbmNlID0gW01hcmtlZF0gOyAoQS1jdW11bChzdHJvbmct
ZmVuY2UgfCBwby1yZWwpIHwgd21iIHwNCisJcG8tdW5sb2NrLXJmLWxvY2st
cG8pIDsgW01hcmtlZF0NCitsZXQgcHJvcCA9IFtNYXJrZWRdIDsgKG92ZXJ3
cml0ZSAmIGV4dCk/IDsgY3VtdWwtZmVuY2UqIDsNCisJW01hcmtlZF0gOyBy
ZmU/IDsgW01hcmtlZF0NCiANCiAoKg0KICAqIEhhcHBlbnMgQmVmb3JlOiBP
cmRlcmluZyBmcm9tIHRoZSBwYXNzYWdlIG9mIHRpbWUuDQogICogTm8gZmVu
Y2VzIG5lZWRlZCBoZXJlIGZvciBwcm9wIGJlY2F1c2UgcmVsYXRpb24gY29u
ZmluZWQgdG8gb25lIHByb2Nlc3MuDQogICopDQotbGV0IGhiID0gcHBvIHwg
cmZlIHwgKChwcm9wIFwgaWQpICYgaW50KQ0KK2xldCBoYiA9IFtNYXJrZWRd
IDsgKHBwbyB8IHJmZSB8ICgocHJvcCBcIGlkKSAmIGludCkpIDsgW01hcmtl
ZF0NCiBhY3ljbGljIGhiIGFzIGhhcHBlbnMtYmVmb3JlDQogDQogKCoqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiopDQpAQCAtODMs
NyArOTEsNyBAQCBhY3ljbGljIGhiIGFzIGhhcHBlbnMtYmVmb3JlDQogKCoq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiopDQogDQog
KCogUHJvcGFnYXRpb246IEVhY2ggbm9uLXJmIGxpbmsgbmVlZHMgYSBzdHJv
bmcgZmVuY2UuICopDQotbGV0IHBiID0gcHJvcCA7IHN0cm9uZy1mZW5jZSA7
IGhiKg0KK2xldCBwYiA9IHByb3AgOyBzdHJvbmctZmVuY2UgOyBoYiogOyBb
TWFya2VkXQ0KIGFjeWNsaWMgcGIgYXMgcHJvcGFnYXRpb24NCiANCiAoKioq
KioqKikNCkBAIC0xMzEsNyArMTM5LDcgQEAgbGV0IHJlYyByY3UtZmVuY2Ug
PSByY3UtZ3AgfCBzcmN1LWdwIHwNCiAJKHJjdS1mZW5jZSA7IHJjdS1saW5r
IDsgcmN1LWZlbmNlKQ0KIA0KICgqIHJiIG9yZGVycyBpbnN0cnVjdGlvbnMg
anVzdCBhcyBwYiBkb2VzICopDQotbGV0IHJiID0gcHJvcCA7IHBvIDsgcmN1
LWZlbmNlIDsgcG8/IDsgaGIqIDsgcGIqDQorbGV0IHJiID0gcHJvcCA7IHBv
IDsgcmN1LWZlbmNlIDsgcG8/IDsgaGIqIDsgcGIqIDsgW01hcmtlZF0NCiAN
CiBpcnJlZmxleGl2ZSByYiBhcyByY3UNCiANCkBAIC0xNDMsMyArMTUxLDU5
IEBAIGlycmVmbGV4aXZlIHJiIGFzIHJjdQ0KICAqIGxldCB4YiA9IGhiIHwg
cGIgfCByYg0KICAqIGFjeWNsaWMgeGIgYXMgZXhlY3V0ZXMtYmVmb3JlDQog
ICopDQorDQorDQorKCoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KikNCisoKiBQbGFpbiBhY2Nlc3NlcyBhbmQgZGF0YSByYWNlcyAqKQ0KKygq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiopDQorDQorKCogV2Fy
biBhYm91dCBwbGFpbiB3cml0ZXMgYW5kIG1hcmtlZCBhY2Nlc3NlcyBpbiB0
aGUgc2FtZSByZWdpb24gKikNCitsZXQgbWl4ZWQtYWNjZXNzZXMgPSAoW1Bs
YWluICYgV10gOyAocG8tbG9jIFwgYmFycmllcikgOyBbTWFya2VkXSkgfA0K
KwkoW01hcmtlZF0gOyAocG8tbG9jIFwgYmFycmllcikgOyBbUGxhaW4gJiBX
XSkNCitmbGFnIH5lbXB0eSBtaXhlZC1hY2Nlc3NlcyBhcyBtaXhlZC1hY2Nl
c3Nlcw0KKw0KKygqIEV4ZWN1dGVzLWJlZm9yZSBhbmQgdmlzaWJpbGl0eSAq
KQ0KK2xldCB4YnN0YXIgPSAoaGIgfCBwYiB8IHJiKSoNCitsZXQgZnVsbC1m
ZW5jZSA9IHN0cm9uZy1mZW5jZSB8IChwbyA7IHJjdS1mZW5jZSA7IHBvPykN
CitsZXQgdmlzID0gY3VtdWwtZmVuY2UqIDsgcmZlPyA7IFtNYXJrZWRdIDsN
CisJKChmdWxsLWZlbmNlIDsgW01hcmtlZF0gOyB4YnN0YXIpIHwgKHhic3Rh
ciAmIGludCkpDQorDQorKCogQm91bmRhcmllcyBmb3IgbGlmZXRpbWVzIG9m
IHBsYWluIGFjY2Vzc2VzICopDQorbGV0IHctcHJlLWJvdW5kZWQgPSBbTWFy
a2VkXSA7IChhZGRyIHwgZmVuY2UpPw0KK2xldCByLXByZS1ib3VuZGVkID0g
W01hcmtlZF0gOyAoYWRkciB8IG5vbnJ3LWZlbmNlIHwNCisJKFtSNHJtYl0g
OyBmZW5jZXJlbChSbWIpIDsgW35Ob3JldHVybl0pKT8NCitsZXQgdy1wb3N0
LWJvdW5kZWQgPSBmZW5jZT8gOyBbTWFya2VkXQ0KK2xldCByLXBvc3QtYm91
bmRlZCA9IChub25ydy1mZW5jZSB8IChbfk5vcmV0dXJuXSA7IGZlbmNlcmVs
KFJtYikgOyBbUjRybWJdKSk/IDsNCisJW01hcmtlZF0NCisNCisoKiBWaXNp
YmlsaXR5IGFuZCBleGVjdXRlcy1iZWZvcmUgZm9yIHBsYWluIGFjY2Vzc2Vz
ICopDQorbGV0IHd3LXZpcyA9IHctcG9zdC1ib3VuZGVkIDsgdmlzIDsgdy1w
cmUtYm91bmRlZA0KK2xldCB3ci12aXMgPSB3LXBvc3QtYm91bmRlZCA7IHZp
cyA7IHItcHJlLWJvdW5kZWQNCitsZXQgcncteGJzdGFyID0gci1wb3N0LWJv
dW5kZWQgOyB4YnN0YXIgOyB3LXByZS1ib3VuZGVkDQorDQorKCogUG90ZW50
aWFsIHJhY2VzICopDQorbGV0IHByZS1yYWNlID0gZXh0ICYgKChQbGFpbiAq
IE0pIHwgKChNIFwgSVcpICogUGxhaW4pKQ0KKw0KKygqIENvaGVyZW5jZSBy
ZXF1aXJlbWVudHMgZm9yIHBsYWluIGFjY2Vzc2VzICopDQorbGV0IHdyLWlu
Y29oID0gcHJlLXJhY2UgJiByZiAmIHJ3LXhic3Rhcl4tMQ0KK2xldCBydy1p
bmNvaCA9IHByZS1yYWNlICYgZnIgJiB3ci12aXNeLTENCitsZXQgd3ctaW5j
b2ggPSBwcmUtcmFjZSAmIGNvICYgd3ctdmlzXi0xDQorZW1wdHkgKHdyLWlu
Y29oIHwgcnctaW5jb2ggfCB3dy1pbmNvaCkgYXMgcGxhaW4tY29oZXJlbmNl
DQorDQorKCogQWN0dWFsIHJhY2VzICopDQorbGV0IHd3LW5vbnJhY2UgPSB3
dy12aXMgJiAoKE1hcmtlZCAqIFcpIHwgcncteGJzdGFyKSAmICgoVyAqIE1h
cmtlZCkgfCB3ci12aXMpDQorbGV0IHd3LXJhY2UgPSAocHJlLXJhY2UgJiBj
bykgXCB3dy1ub25yYWNlDQorbGV0IHdyLXJhY2UgPSAocHJlLXJhY2UgJiAo
Y28/IDsgcmYpKSBcIHdyLXZpcw0KK2xldCBydy1yYWNlID0gKHByZS1yYWNl
ICYgZnIpIFwgcncteGJzdGFyDQorDQorKCogTWFqb3Igd3JpdGVzLCBzdXBl
ciB3cml0ZXMsIGFuZCBzdXBlcnNlZGVkIHdyaXRlcyAqKQ0KK2xldCBNYWpv
ci13ID0gVyBcIGRvbWFpbihjb2kgXCBiYXJyaWVyKQ0KK2xldCBTdXBlci13
ID0gKFcgJiBNYXJrZWQpIHwNCisJcmFuZ2UoZGlmZmVyZW50LXZhbHVlcyhz
aW5nbGVzdGVwKFtNYWpvci13XSA7IGNvIDsgW01ham9yLXddKSkpDQorbGV0
IHN1cGVyc2VkZWQtdyA9IGNvIDsgW1N1cGVyLXddIDsgKGNvIHwgKGNvPyA7
IHJmKSkNCisNCisoKiBTdXBlcnNlZGVkIHdyaXRlcyBkb24ndCByYWNlICop
DQorbGV0IHd3LXJhY2UgPSB3dy1yYWNlIFwgc3VwZXJzZWRlZC13DQorbGV0
IHdyLXJhY2UgPSB3ci1yYWNlIFwgc3VwZXJzZWRlZC13DQorDQorZmxhZyB+
ZW1wdHkgKHd3LXJhY2UgfCB3ci1yYWNlIHwgcnctcmFjZSkgYXMgZGF0YS1y
YWNlDQpJbmRleDogbGttbS90b29scy9tZW1vcnktbW9kZWwvbGludXgta2Vy
bmVsLmRlZg0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KLS0tIGxrbW0ub3Jp
Zy90b29scy9tZW1vcnktbW9kZWwvbGludXgta2VybmVsLmRlZg0KKysrIGxr
bW0vdG9vbHMvbWVtb3J5LW1vZGVsL2xpbnV4LWtlcm5lbC5kZWYNCkBAIC0y
NCw2ICsyNCw3IEBAIHNtcF9tYl9fYmVmb3JlX2F0b21pYygpIHsgX19mZW5j
ZXtiZWZvcmUNCiBzbXBfbWJfX2FmdGVyX2F0b21pYygpIHsgX19mZW5jZXth
ZnRlci1hdG9taWN9OyB9DQogc21wX21iX19hZnRlcl9zcGlubG9jaygpIHsg
X19mZW5jZXthZnRlci1zcGlubG9ja307IH0NCiBzbXBfbWJfX2FmdGVyX3Vu
bG9ja19sb2NrKCkgeyBfX2ZlbmNle2FmdGVyLXVubG9jay1sb2NrfTsgfQ0K
K2JhcnJpZXIoKSB7IF9fZmVuY2V7YmFycmllcn07IH0NCiANCiAvLyBFeGNo
YW5nZQ0KIHhjaGcoWCxWKSAgX194Y2hne21ifShYLFYpDQo=
---1559625215-990642464-1553024299=:1593--
