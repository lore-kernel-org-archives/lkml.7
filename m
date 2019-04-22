Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8BDC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AC320874
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfDVQRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:17:47 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:37716 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726098AbfDVQRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 12:17:46 -0400
Received: (qmail 5407 invoked by uid 2102); 22 Apr 2019 12:17:45 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Apr 2019 12:17:45 -0400
Date:   Mon, 22 Apr 2019 12:17:45 -0400 (EDT)
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
Subject: [PATCH 1/3] tools: memory-model: Prepare for data-race detection
Message-ID: <Pine.LNX.4.44L0.1904221211440.1384-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some slight alterations to linux-kernel.cat in
preparation for adding support for data-race detection to the
Linux-Kernel Memory Model.

	The definitions of relations involved in Acquire, Release, and
	unlock-lock ordering are moved up earlier in the source file.

	The rmb relation is factored through the new R4rmb class: the
	class of reads to which rmb will apply.

	The definition of the fence relation is moved earlier, and it
	is split up into read- and write-fences (rmb and wmb) and all
	the others.

This should not make any functional changes.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---


 tools/memory-model/linux-kernel.cat |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

Index: usb-devel/tools/memory-model/linux-kernel.cat
===================================================================
--- usb-devel.orig/tools/memory-model/linux-kernel.cat
+++ usb-devel/tools/memory-model/linux-kernel.cat
@@ -26,8 +26,14 @@ include "lock.cat"
 (* Basic relations *)
 (*******************)
 
+(* Release Acquire *)
+let acq-po = [Acquire] ; po ; [M]
+let po-rel = [M] ; po ; [Release]
+let po-unlock-rf-lock-po = po ; [UL] ; rf ; [LKR] ; po
+
 (* Fences *)
-let rmb = [R \ Noreturn] ; fencerel(Rmb) ; [R \ Noreturn]
+let R4rmb = R \ Noreturn	(* Reads for which rmb works *)
+let rmb = [R4rmb] ; fencerel(Rmb) ; [R4rmb]
 let wmb = [W] ; fencerel(Wmb) ; [W]
 let mb = ([M] ; fencerel(Mb) ; [M]) |
 	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
@@ -36,13 +42,10 @@ let mb = ([M] ; fencerel(Mb) ; [M]) |
 	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
 		fencerel(After-unlock-lock) ; [M])
 let gp = po ; [Sync-rcu | Sync-srcu] ; po?
-
 let strong-fence = mb | gp
 
-(* Release Acquire *)
-let acq-po = [Acquire] ; po ; [M]
-let po-rel = [M] ; po ; [Release]
-let po-unlock-rf-lock-po = po ; [UL] ; rf ; [LKR] ; po
+let nonrw-fence = strong-fence | po-rel | acq-po
+let fence = nonrw-fence | wmb | rmb
 
 (**********************************)
 (* Fundamental coherence ordering *)
@@ -65,7 +68,6 @@ let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
 let to-w = rwdep | (overwrite & int)
 let to-r = addr | (dep ; rfi)
-let fence = strong-fence | wmb | po-rel | rmb | acq-po
 let ppo = to-r | to-w | fence | (po-unlock-rf-lock-po & int)
 
 (* Propagation: Ordering from release operations and strong fences. *)


