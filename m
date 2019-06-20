Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8DBC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1502084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbfFTPzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 11:55:48 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:44934 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726551AbfFTPzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:55:47 -0400
Received: (qmail 4706 invoked by uid 2102); 20 Jun 2019 11:55:46 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Jun 2019 11:55:46 -0400
Date:   Thu, 20 Jun 2019 11:55:46 -0400 (EDT)
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
cc:     Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] tools: memory-model: Change definition of rcu-fence
Message-ID: <Pine.LNX.4.44L0.1906201152370.1512-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcu-fence relation in the Linux Kernel Memory Model is not well
named.  It doesn't act like any other fence relation, in that it does
not relate events before a fence to events after that fence.  All it
does is relate certain RCU events to one another (those that are
ordered by the RCU Guarantee); this induces an actual
strong-fence-like relation linking events preceding the first RCU
event to those following the second.

This patch renames rcu-fence, now called rcu-order.  It adds a new
definition of rcu-fence, something which should have been present all
along because it is used in the rb relation.  And it modifies the
fence and strong-fence relations by making them incorporate the new
rcu-fence.

As a result of this change, there is no longer any need to define
full-fence in the section for detecting data races.  It can simply be
replaced by the updated strong-fence relation.

This change should have no effect on the operation of the memory model.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---


 tools/memory-model/linux-kernel.cat |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

Index: usb-devel/tools/memory-model/linux-kernel.cat
===================================================================
--- usb-devel.orig/tools/memory-model/linux-kernel.cat
+++ usb-devel/tools/memory-model/linux-kernel.cat
@@ -124,24 +124,28 @@ let rcu-link = po? ; hb* ; pb* ; prop ;
 
 (*
  * Any sequence containing at least as many grace periods as RCU read-side
- * critical sections (joined by rcu-link) acts as a generalized strong fence.
+ * critical sections (joined by rcu-link) induces order like a generalized
+ * inter-CPU strong fence.
  * Likewise for SRCU grace periods and read-side critical sections, provided
  * the synchronize_srcu() and srcu_read_[un]lock() calls refer to the same
  * struct srcu_struct location.
  *)
-let rec rcu-fence = rcu-gp | srcu-gp |
+let rec rcu-order = rcu-gp | srcu-gp |
 	(rcu-gp ; rcu-link ; rcu-rscsi) |
 	((srcu-gp ; rcu-link ; srcu-rscsi) & loc) |
 	(rcu-rscsi ; rcu-link ; rcu-gp) |
 	((srcu-rscsi ; rcu-link ; srcu-gp) & loc) |
-	(rcu-gp ; rcu-link ; rcu-fence ; rcu-link ; rcu-rscsi) |
-	((srcu-gp ; rcu-link ; rcu-fence ; rcu-link ; srcu-rscsi) & loc) |
-	(rcu-rscsi ; rcu-link ; rcu-fence ; rcu-link ; rcu-gp) |
-	((srcu-rscsi ; rcu-link ; rcu-fence ; rcu-link ; srcu-gp) & loc) |
-	(rcu-fence ; rcu-link ; rcu-fence)
+	(rcu-gp ; rcu-link ; rcu-order ; rcu-link ; rcu-rscsi) |
+	((srcu-gp ; rcu-link ; rcu-order ; rcu-link ; srcu-rscsi) & loc) |
+	(rcu-rscsi ; rcu-link ; rcu-order ; rcu-link ; rcu-gp) |
+	((srcu-rscsi ; rcu-link ; rcu-order ; rcu-link ; srcu-gp) & loc) |
+	(rcu-order ; rcu-link ; rcu-order)
+let rcu-fence = po ; rcu-order ; po?
+let fence = fence | rcu-fence
+let strong-fence = strong-fence | rcu-fence
 
 (* rb orders instructions just as pb does *)
-let rb = prop ; po ; rcu-fence ; po? ; hb* ; pb* ; [Marked]
+let rb = prop ; rcu-fence ; hb* ; pb* ; [Marked]
 
 irreflexive rb as rcu
 
@@ -165,9 +169,8 @@ flag ~empty mixed-accesses as mixed-acce
 
 (* Executes-before and visibility *)
 let xbstar = (hb | pb | rb)*
-let full-fence = strong-fence | (po ; rcu-fence ; po?)
 let vis = cumul-fence* ; rfe? ; [Marked] ;
-	((full-fence ; [Marked] ; xbstar) | (xbstar & int))
+	((strong-fence ; [Marked] ; xbstar) | (xbstar & int))
 
 (* Boundaries for lifetimes of plain accesses *)
 let w-pre-bounded = [Marked] ; (addr | fence)?

