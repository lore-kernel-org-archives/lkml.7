Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E24C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133BA214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfDVQSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:18:10 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:37822 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726098AbfDVQSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 12:18:10 -0400
Received: (qmail 5437 invoked by uid 2102); 22 Apr 2019 12:18:09 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Apr 2019 12:18:09 -0400
Date:   Mon, 22 Apr 2019 12:18:09 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 3/3] tools: memory-model: Add data-race detection
Message-ID: <Pine.LNX.4.44L0.1904221214370.1384-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds data-race detection to the Linux-Kernel Memory Model.
As part of this effort, support is added for:

	compiler barriers (the barrier() function), and

	a new Preserved Program Order term: (addr ; [Plain] ; wmb)

Data races are marked with a special Flag warning in herd.  It is
not guaranteed that the model will provide accurate predictions when a
data race is present.

The patch does not include documentation for the data-race detection
facility.  The basic design has been explained in various emails, and
a separate documentation patch will be submitted later.

This work is based on an earlier formulation of data races for the
LKMM by Andrea Parri.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---


 tools/memory-model/linux-kernel.bell |    1 
 tools/memory-model/linux-kernel.cat  |   50 ++++++++++++++++++++++++++++++++++-
 tools/memory-model/linux-kernel.def  |    1 
 3 files changed, 51 insertions(+), 1 deletion(-)

Index: usb-devel/tools/memory-model/linux-kernel.bell
===================================================================
--- usb-devel.orig/tools/memory-model/linux-kernel.bell
+++ usb-devel/tools/memory-model/linux-kernel.bell
@@ -24,6 +24,7 @@ instructions RMW[{'once,'acquire,'releas
 enum Barriers = 'wmb (*smp_wmb*) ||
 		'rmb (*smp_rmb*) ||
 		'mb (*smp_mb*) ||
+		'barrier (*barrier*) ||
 		'rcu-lock (*rcu_read_lock*)  ||
 		'rcu-unlock (*rcu_read_unlock*) ||
 		'sync-rcu (*synchronize_rcu*) ||
Index: usb-devel/tools/memory-model/linux-kernel.cat
===================================================================
--- usb-devel.orig/tools/memory-model/linux-kernel.cat
+++ usb-devel/tools/memory-model/linux-kernel.cat
@@ -46,6 +46,9 @@ let strong-fence = mb | gp
 
 let nonrw-fence = strong-fence | po-rel | acq-po
 let fence = nonrw-fence | wmb | rmb
+let barrier = fencerel(Barrier | Rmb | Wmb | Mb | Sync-rcu | Sync-srcu |
+		Before-atomic | After-atomic | Acquire | Release) |
+	(po ; [Release]) | ([Acquire] ; po)
 
 (**********************************)
 (* Fundamental coherence ordering *)
@@ -66,7 +69,7 @@ empty rmw & (fre ; coe) as atomic
 let dep = addr | data
 let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
-let to-w = rwdep | (overwrite & int)
+let to-w = rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
 let to-r = addr | (dep ; [Marked] ; rfi)
 let ppo = to-r | to-w | fence | (po-unlock-rf-lock-po & int)
 
@@ -149,3 +152,48 @@ irreflexive rb as rcu
  * let xb = hb | pb | rb
  * acyclic xb as executes-before
  *)
+
+(*********************************)
+(* Plain accesses and data races *)
+(*********************************)
+
+(* Warn about plain writes and marked accesses in the same region *)
+let mixed-accesses = ([Plain & W] ; (po-loc \ barrier) ; [Marked]) |
+	([Marked] ; (po-loc \ barrier) ; [Plain & W])
+flag ~empty mixed-accesses as mixed-accesses
+
+(* Executes-before and visibility *)
+let xbstar = (hb | pb | rb)*
+let full-fence = strong-fence | (po ; rcu-fence ; po?)
+let vis = cumul-fence* ; rfe? ; [Marked] ;
+	((full-fence ; [Marked] ; xbstar) | (xbstar & int))
+
+(* Boundaries for lifetimes of plain accesses *)
+let w-pre-bounded = [Marked] ; (addr | fence)?
+let r-pre-bounded = [Marked] ; (addr | nonrw-fence |
+	([R4rmb] ; fencerel(Rmb) ; [~Noreturn]))?
+let w-post-bounded = fence? ; [Marked]
+let r-post-bounded = (nonrw-fence | ([~Noreturn] ; fencerel(Rmb) ; [R4rmb]))? ;
+	[Marked]
+
+(* Visibility and executes-before for plain accesses *)
+let ww-vis = w-post-bounded ; vis ; w-pre-bounded
+let wr-vis = w-post-bounded ; vis ; r-pre-bounded
+let rw-xbstar = r-post-bounded ; xbstar ; w-pre-bounded
+
+(* Potential races *)
+let pre-race = ext & ((Plain * M) | ((M \ IW) * Plain))
+
+(* Coherence requirements for plain accesses *)
+let wr-incoh = pre-race & rf & rw-xbstar^-1
+let rw-incoh = pre-race & fr & wr-vis^-1
+let ww-incoh = pre-race & co & ww-vis^-1
+empty (wr-incoh | rw-incoh | ww-incoh) as plain-coherence
+
+(* Actual races *)
+let ww-nonrace = ww-vis & ((Marked * W) | rw-xbstar) & ((W * Marked) | wr-vis)
+let ww-race = (pre-race & co) \ ww-nonrace
+let wr-race = (pre-race & (co? ; rf)) \ wr-vis
+let rw-race = (pre-race & fr) \ rw-xbstar
+
+flag ~empty (ww-race | wr-race | rw-race) as data-race
Index: usb-devel/tools/memory-model/linux-kernel.def
===================================================================
--- usb-devel.orig/tools/memory-model/linux-kernel.def
+++ usb-devel/tools/memory-model/linux-kernel.def
@@ -24,6 +24,7 @@ smp_mb__before_atomic() { __fence{before
 smp_mb__after_atomic() { __fence{after-atomic}; }
 smp_mb__after_spinlock() { __fence{after-spinlock}; }
 smp_mb__after_unlock_lock() { __fence{after-unlock-lock}; }
+barrier() { __fence{barrier}; }
 
 // Exchange
 xchg(X,V)  __xchg{mb}(X,V)


