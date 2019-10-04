Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FB8C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F7A20862
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbfJDQ6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:58:25 -0400
Received: from ms.lwn.net ([45.79.88.28]:40310 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfJDQ6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:58:25 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D70A12C1;
        Fri,  4 Oct 2019 16:58:23 +0000 (UTC)
Date:   Fri, 4 Oct 2019 10:58:22 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Andrea Parri" <parri.andrea@gmail.com>,
        "Will Deacon" <will@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Boqun Feng" <boqun.feng@gmail.com>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "David Howells" <dhowells@redhat.com>,
        "Jade Alglave" <j.alglave@ucl.ac.uk>,
        "Luc Maranget" <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Akira Yokosawa" <akiyks@gmail.com>,
        "Daniel Lustig" <dlustig@nvidia.com>
Subject: [PATCH] docs: remove :c:func: from refcount-vs-atomic.rst
Message-ID: <20191004105449.3671ff78@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of 5.3, the automarkup extension will do the right thing with function()
notation, so we don't need to clutter the text with :c:func: invocations.
So remove them.

Looking at the generated output reveals that we lack kerneldoc coverage for
much of this API, but that's a separate problem.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
I'll feed this through docs-next unless somebody tells me otherwise...

 Documentation/core-api/refcount-vs-atomic.rst | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/core-api/refcount-vs-atomic.rst b/Documentation/core-api/refcount-vs-atomic.rst
index 976e85adffe8..79a009ce11df 100644
--- a/Documentation/core-api/refcount-vs-atomic.rst
+++ b/Documentation/core-api/refcount-vs-atomic.rst
@@ -35,7 +35,7 @@ atomics & refcounters only provide atomicity and
 program order (po) relation (on the same CPU). It guarantees that
 each ``atomic_*()`` and ``refcount_*()`` operation is atomic and instructions
 are executed in program order on a single CPU.
-This is implemented using :c:func:`READ_ONCE`/:c:func:`WRITE_ONCE` and
+This is implemented using READ_ONCE()/WRITE_ONCE() and
 compare-and-swap primitives.
 
 A strong (full) memory ordering guarantees that all prior loads and
@@ -44,7 +44,7 @@ before any po-later instruction is executed on the same CPU.
 It also guarantees that all po-earlier stores on the same CPU
 and all propagated stores from other CPUs must propagate to all
 other CPUs before any po-later instruction is executed on the original
-CPU (A-cumulative property). This is implemented using :c:func:`smp_mb`.
+CPU (A-cumulative property). This is implemented using smp_mb().
 
 A RELEASE memory ordering guarantees that all prior loads and
 stores (all po-earlier instructions) on the same CPU are completed
@@ -52,14 +52,14 @@ before the operation. It also guarantees that all po-earlier
 stores on the same CPU and all propagated stores from other CPUs
 must propagate to all other CPUs before the release operation
 (A-cumulative property). This is implemented using
-:c:func:`smp_store_release`.
+smp_store_release().
 
 An ACQUIRE memory ordering guarantees that all post loads and
 stores (all po-later instructions) on the same CPU are
 completed after the acquire operation. It also guarantees that all
 po-later stores on the same CPU must propagate to all other CPUs
 after the acquire operation executes. This is implemented using
-:c:func:`smp_acquire__after_ctrl_dep`.
+smp_acquire__after_ctrl_dep().
 
 A control dependency (on success) for refcounters guarantees that
 if a reference for an object was successfully obtained (reference
@@ -78,8 +78,8 @@ case 1) - non-"Read/Modify/Write" (RMW) ops
 
 Function changes:
 
- * :c:func:`atomic_set` --> :c:func:`refcount_set`
- * :c:func:`atomic_read` --> :c:func:`refcount_read`
+ * atomic_set() --> refcount_set()
+ * atomic_read() --> refcount_read()
 
 Memory ordering guarantee changes:
 
@@ -91,8 +91,8 @@ case 2) - increment-based ops that return no value
 
 Function changes:
 
- * :c:func:`atomic_inc` --> :c:func:`refcount_inc`
- * :c:func:`atomic_add` --> :c:func:`refcount_add`
+ * atomic_inc() --> refcount_inc()
+ * atomic_add() --> refcount_add()
 
 Memory ordering guarantee changes:
 
@@ -103,7 +103,7 @@ case 3) - decrement-based RMW ops that return no value
 
 Function changes:
 
- * :c:func:`atomic_dec` --> :c:func:`refcount_dec`
+ * atomic_dec() --> refcount_dec()
 
 Memory ordering guarantee changes:
 
@@ -115,8 +115,8 @@ case 4) - increment-based RMW ops that return a value
 
 Function changes:
 
- * :c:func:`atomic_inc_not_zero` --> :c:func:`refcount_inc_not_zero`
- * no atomic counterpart --> :c:func:`refcount_add_not_zero`
+ * atomic_inc_not_zero() --> refcount_inc_not_zero()
+ * no atomic counterpart --> refcount_add_not_zero()
 
 Memory ordering guarantees changes:
 
@@ -131,8 +131,8 @@ case 5) - generic dec/sub decrement-based RMW ops that return a value
 
 Function changes:
 
- * :c:func:`atomic_dec_and_test` --> :c:func:`refcount_dec_and_test`
- * :c:func:`atomic_sub_and_test` --> :c:func:`refcount_sub_and_test`
+ * atomic_dec_and_test() --> refcount_dec_and_test()
+ * atomic_sub_and_test() --> refcount_sub_and_test()
 
 Memory ordering guarantees changes:
 
@@ -144,14 +144,14 @@ case 6) other decrement-based RMW ops that return a value
 
 Function changes:
 
- * no atomic counterpart --> :c:func:`refcount_dec_if_one`
+ * no atomic counterpart --> refcount_dec_if_one()
  * ``atomic_add_unless(&var, -1, 1)`` --> ``refcount_dec_not_one(&var)``
 
 Memory ordering guarantees changes:
 
  * fully ordered --> RELEASE ordering + control dependency
 
-.. note:: :c:func:`atomic_add_unless` only provides full order on success.
+.. note:: atomic_add_unless() only provides full order on success.
 
 
 case 7) - lock-based RMW
@@ -159,10 +159,10 @@ case 7) - lock-based RMW
 
 Function changes:
 
- * :c:func:`atomic_dec_and_lock` --> :c:func:`refcount_dec_and_lock`
- * :c:func:`atomic_dec_and_mutex_lock` --> :c:func:`refcount_dec_and_mutex_lock`
+ * atomic_dec_and_lock() --> refcount_dec_and_lock()
+ * atomic_dec_and_mutex_lock() --> refcount_dec_and_mutex_lock()
 
 Memory ordering guarantees changes:
 
  * fully ordered --> RELEASE ordering + control dependency + hold
-   :c:func:`spin_lock` on success
+   spin_lock() on success
-- 
2.21.0

