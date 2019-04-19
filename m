Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E579DC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3E9222AF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfDSSVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:21:49 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:60878 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727399AbfDSSVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:21:47 -0400
Received: (qmail 5596 invoked by uid 2102); 19 Apr 2019 13:21:45 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Apr 2019 13:21:45 -0400
Date:   Fri, 19 Apr 2019 13:21:45 -0400 (EDT)
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
Subject: [PATCH] Documentation: atomic_t.txt: Explain ordering provided by
 smp_mb__{before,after}_atomic()
Message-ID: <Pine.LNX.4.44L0.1904191312200.1406-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description of smp_mb__before_atomic() and smp_mb__after_atomic()
in Documentation/atomic_t.txt is slightly terse and misleading.  It
does not clearly state that these barriers only affect the ordering of
other instructions with respect to the atomic operation.

This improves the text to make the actual ordering implications clear,
and also to explain how these barriers differ from a RELEASE or
ACQUIRE ordering.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---


 Documentation/atomic_t.txt |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

Index: usb-devel/Documentation/atomic_t.txt
===================================================================
--- usb-devel.orig/Documentation/atomic_t.txt
+++ usb-devel/Documentation/atomic_t.txt
@@ -171,7 +171,10 @@ The barriers:
   smp_mb__{before,after}_atomic()
 
 only apply to the RMW ops and can be used to augment/upgrade the ordering
-inherent to the used atomic op. These barriers provide a full smp_mb().
+inherent to the used atomic op. Unlike normal smp_mb() barriers, they order
+only the RMW op itself against the instructions preceding the
+smp_mb__before_atomic() or following the smp_mb__after_atomic(); they do
+not order instructions on the other side of the RMW op at all.
 
 These helper barriers exist because architectures have varying implicit
 ordering on their SMP atomic primitives. For example our TSO architectures
@@ -195,7 +198,8 @@ Further, while something like:
   atomic_dec(&X);
 
 is a 'typical' RELEASE pattern, the barrier is strictly stronger than
-a RELEASE. Similarly for something like:
+a RELEASE because it orders preceding instructions against both the read
+and write parts of the atomic_dec(). Similarly, something like:
 
   atomic_inc(&X);
   smp_mb__after_atomic();
@@ -227,7 +231,8 @@ strictly stronger than ACQUIRE. As illus
 
 This should not happen; but a hypothetical atomic_inc_acquire() --
 (void)atomic_fetch_inc_acquire() for instance -- would allow the outcome,
-since then:
+because it would not order the W part of the RMW against the following
+WRITE_ONCE.  Thus:
 
   P1			P2
 

