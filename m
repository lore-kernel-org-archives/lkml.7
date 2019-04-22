Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011E4C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6C820874
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfDVQR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:17:59 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:37782 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726098AbfDVQR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 12:17:59 -0400
Received: (qmail 5422 invoked by uid 2102); 22 Apr 2019 12:17:58 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Apr 2019 12:17:58 -0400
Date:   Mon, 22 Apr 2019 12:17:58 -0400 (EDT)
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
Subject: [PATCH 2/3] tools: memory-model: Add definitions of plain and marked
 accesses
Message-ID: <Pine.LNX.4.44L0.1904221213350.1384-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds definitions for marked and plain accesses to the
Linux-Kernel Memory Model.  It also modifies the definitions of the
existing parts of the model (including the cumul-fence, prop, hb, pb,
and rb relations) so as to make them apply only to marked accesses.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---


 tools/memory-model/linux-kernel.bell |    5 +++++
 tools/memory-model/linux-kernel.cat  |   16 +++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

Index: usb-devel/tools/memory-model/linux-kernel.bell
===================================================================
--- usb-devel.orig/tools/memory-model/linux-kernel.bell
+++ usb-devel/tools/memory-model/linux-kernel.bell
@@ -76,3 +76,8 @@ flag ~empty rcu-rscs & (po ; [Sync-srcu]
 
 (* Validate SRCU dynamic match *)
 flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
+
+(* Compute marked and plain memory accesses *)
+let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
+		LKR | LKW | UL | LF | RL | RU
+let Plain = M \ Marked
Index: usb-devel/tools/memory-model/linux-kernel.cat
===================================================================
--- usb-devel.orig/tools/memory-model/linux-kernel.cat
+++ usb-devel/tools/memory-model/linux-kernel.cat
@@ -67,19 +67,21 @@ let dep = addr | data
 let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
 let to-w = rwdep | (overwrite & int)
-let to-r = addr | (dep ; rfi)
+let to-r = addr | (dep ; [Marked] ; rfi)
 let ppo = to-r | to-w | fence | (po-unlock-rf-lock-po & int)
 
 (* Propagation: Ordering from release operations and strong fences. *)
-let A-cumul(r) = rfe? ; r
-let cumul-fence = A-cumul(strong-fence | po-rel) | wmb | po-unlock-rf-lock-po
-let prop = (overwrite & ext)? ; cumul-fence* ; rfe?
+let A-cumul(r) = (rfe ; [Marked])? ; r
+let cumul-fence = [Marked] ; (A-cumul(strong-fence | po-rel) | wmb |
+	po-unlock-rf-lock-po) ; [Marked]
+let prop = [Marked] ; (overwrite & ext)? ; cumul-fence* ;
+	[Marked] ; rfe? ; [Marked]
 
 (*
  * Happens Before: Ordering from the passage of time.
  * No fences needed here for prop because relation confined to one process.
  *)
-let hb = ppo | rfe | ((prop \ id) & int)
+let hb = [Marked] ; (ppo | rfe | ((prop \ id) & int)) ; [Marked]
 acyclic hb as happens-before
 
 (****************************************)
@@ -87,7 +89,7 @@ acyclic hb as happens-before
 (****************************************)
 
 (* Propagation: Each non-rf link needs a strong fence. *)
-let pb = prop ; strong-fence ; hb*
+let pb = prop ; strong-fence ; hb* ; [Marked]
 acyclic pb as propagation
 
 (*******)
@@ -135,7 +137,7 @@ let rec rcu-fence = rcu-gp | srcu-gp |
 	(rcu-fence ; rcu-link ; rcu-fence)
 
 (* rb orders instructions just as pb does *)
-let rb = prop ; po ; rcu-fence ; po? ; hb* ; pb*
+let rb = prop ; po ; rcu-fence ; po? ; hb* ; pb* ; [Marked]
 
 irreflexive rb as rcu
 


