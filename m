Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55555C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 17:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3356120651
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 17:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfECRNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 13:13:46 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:58728 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727628AbfECRNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 13:13:45 -0400
Received: (qmail 6340 invoked by uid 2102); 3 May 2019 13:13:44 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 May 2019 13:13:44 -0400
Date:   Fri, 3 May 2019 13:13:44 -0400 (EDT)
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
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] Documentation: atomic_t.txt: Explain ordering provided
 by smp_mb__{before,after}_atomic()
In-Reply-To: <20190503163411.GH2606@hirez.programming.kicks-ass.net>
Message-ID: <Pine.LNX.4.44L0.1905031309300.1437-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description of smp_mb__before_atomic() and smp_mb__after_atomic()
in Documentation/atomic_t.txt is slightly terse and misleading.  It
does not clearly state which other instructions are ordered by these
barriers.

This improves the text to make the actual ordering implications clear,
and also to explain how these barriers differ from a RELEASE or
ACQUIRE ordering.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: Peter Zijlstra <peterz@infradead.org>

---

v2: Update the explanation: These barriers do provide order for 
accesses on the far side of the atomic RMW operation.


 Documentation/atomic_t.txt |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

Index: usb-devel/Documentation/atomic_t.txt
===================================================================
--- usb-devel.orig/Documentation/atomic_t.txt
+++ usb-devel/Documentation/atomic_t.txt
@@ -170,8 +170,14 @@ The barriers:
 
   smp_mb__{before,after}_atomic()
 
-only apply to the RMW ops and can be used to augment/upgrade the ordering
-inherent to the used atomic op. These barriers provide a full smp_mb().
+only apply to the RMW atomic ops and can be used to augment/upgrade the
+ordering inherent to the op. These barriers act almost like a full smp_mb():
+smp_mb__before_atomic() orders all earlier accesses against the RMW op
+itself and all accesses following it, and smp_mb__after_atomic() orders all
+later accesses against the RMW op and all accesses preceding it. However,
+accesses between the smp_mb__{before,after}_atomic() and the RMW op are not
+ordered, so it is advisable to place the barrier right next to the RMW atomic
+op whenever possible.
 
 These helper barriers exist because architectures have varying implicit
 ordering on their SMP atomic primitives. For example our TSO architectures
@@ -195,7 +201,9 @@ Further, while something like:
   atomic_dec(&X);
 
 is a 'typical' RELEASE pattern, the barrier is strictly stronger than
-a RELEASE. Similarly for something like:
+a RELEASE because it orders preceding instructions against both the read
+and write parts of the atomic_dec(), and against all following instructions
+as well. Similarly, something like:
 
   atomic_inc(&X);
   smp_mb__after_atomic();
@@ -227,7 +235,8 @@ strictly stronger than ACQUIRE. As illus
 
 This should not happen; but a hypothetical atomic_inc_acquire() --
 (void)atomic_fetch_inc_acquire() for instance -- would allow the outcome,
-since then:
+because it would not order the W part of the RMW against the following
+WRITE_ONCE.  Thus:
 
   P1			P2
 

