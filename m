Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A720ACA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B20321734
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfJaL5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:57:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55379 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfJaLzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:18 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92n-00034V-TZ; Thu, 31 Oct 2019 12:55:14 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4444D1C0673;
        Thu, 31 Oct 2019 12:55:06 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:05 -0000
From:   "tip-bot2 for Alan Stern" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tools/memory-model/Documentation: Put redefinition of
 rcu-fence into explanation.txt
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252290599.29376.15152132361280992721.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     ddc82999f02580f93f9be2b8fb3b10f6139fb281
Gitweb:        https://git.kernel.org/tip/ddc82999f02580f93f9be2b8fb3b10f6139fb281
Author:        Alan Stern <stern@rowland.harvard.edu>
AuthorDate:    Tue, 01 Oct 2019 13:40:11 -04:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Sat, 05 Oct 2019 11:59:23 -07:00

tools/memory-model/Documentation: Put redefinition of rcu-fence into explanation.txt

This patch updates the Linux Kernel Memory Model's explanation.txt
file to incorporate the introduction of the rcu-order relation and
the redefinition of rcu-fence made by commit 15aa25cbf0cc
("tools/memory-model: Change definition of rcu-fence").

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/explanation.txt | 53 ++++++++++-----
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 1b52645..ecf6ccc 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -27,7 +27,7 @@ Explanation of the Linux-Kernel Memory Consistency Model
   19. AND THEN THERE WAS ALPHA
   20. THE HAPPENS-BEFORE RELATION: hb
   21. THE PROPAGATES-BEFORE RELATION: pb
-  22. RCU RELATIONS: rcu-link, rcu-gp, rcu-rscsi, rcu-fence, and rb
+  22. RCU RELATIONS: rcu-link, rcu-gp, rcu-rscsi, rcu-order, rcu-fence, and rb
   23. LOCKING
   24. ODDS AND ENDS
 
@@ -1425,8 +1425,8 @@ they execute means that it cannot have cycles.  This requirement is
 the content of the LKMM's "propagation" axiom.
 
 
-RCU RELATIONS: rcu-link, rcu-gp, rcu-rscsi, rcu-fence, and rb
--------------------------------------------------------------
+RCU RELATIONS: rcu-link, rcu-gp, rcu-rscsi, rcu-order, rcu-fence, and rb
+------------------------------------------------------------------------
 
 RCU (Read-Copy-Update) is a powerful synchronization mechanism.  It
 rests on two concepts: grace periods and read-side critical sections.
@@ -1536,29 +1536,29 @@ Z's CPU before Z begins but doesn't propagate to some other CPU until
 after X ends.)  Similarly, X ->rcu-rscsi Y ->rcu-link Z says that X is
 the end of a critical section which starts before Z begins.
 
-The LKMM goes on to define the rcu-fence relation as a sequence of
+The LKMM goes on to define the rcu-order relation as a sequence of
 rcu-gp and rcu-rscsi links separated by rcu-link links, in which the
 number of rcu-gp links is >= the number of rcu-rscsi links.  For
 example:
 
 	X ->rcu-gp Y ->rcu-link Z ->rcu-rscsi T ->rcu-link U ->rcu-gp V
 
-would imply that X ->rcu-fence V, because this sequence contains two
+would imply that X ->rcu-order V, because this sequence contains two
 rcu-gp links and one rcu-rscsi link.  (It also implies that
-X ->rcu-fence T and Z ->rcu-fence V.)  On the other hand:
+X ->rcu-order T and Z ->rcu-order V.)  On the other hand:
 
 	X ->rcu-rscsi Y ->rcu-link Z ->rcu-rscsi T ->rcu-link U ->rcu-gp V
 
-does not imply X ->rcu-fence V, because the sequence contains only
+does not imply X ->rcu-order V, because the sequence contains only
 one rcu-gp link but two rcu-rscsi links.
 
-The rcu-fence relation is important because the Grace Period Guarantee
-means that rcu-fence acts kind of like a strong fence.  In particular,
-E ->rcu-fence F implies not only that E begins before F ends, but also
-that any write po-before E will propagate to every CPU before any
-instruction po-after F can execute.  (However, it does not imply that
-E must execute before F; in fact, each synchronize_rcu() fence event
-is linked to itself by rcu-fence as a degenerate case.)
+The rcu-order relation is important because the Grace Period Guarantee
+means that rcu-order links act kind of like strong fences.  In
+particular, E ->rcu-order F implies not only that E begins before F
+ends, but also that any write po-before E will propagate to every CPU
+before any instruction po-after F can execute.  (However, it does not
+imply that E must execute before F; in fact, each synchronize_rcu()
+fence event is linked to itself by rcu-order as a degenerate case.)
 
 To prove this in full generality requires some intellectual effort.
 We'll consider just a very simple case:
@@ -1585,7 +1585,26 @@ G's CPU before G starts must propagate to every CPU before C starts.
 In particular, the write propagates to every CPU before F finishes
 executing and hence before any instruction po-after F can execute.
 This sort of reasoning can be extended to handle all the situations
-covered by rcu-fence.
+covered by rcu-order.
+
+The rcu-fence relation is a simple extension of rcu-order.  While
+rcu-order only links certain fence events (calls to synchronize_rcu(),
+rcu_read_lock(), or rcu_read_unlock()), rcu-fence links any events
+that are separated by an rcu-order link.  This is analogous to the way
+the strong-fence relation links events that are separated by an
+smp_mb() fence event (as mentioned above, rcu-order links act kind of
+like strong fences).  Written symbolically, X ->rcu-fence Y means
+there are fence events E and F such that:
+
+	X ->po E ->rcu-order F ->po Y.
+
+From the discussion above, we see this implies not only that X
+executes before Y, but also (if X is a store) that X propagates to
+every CPU before Y executes.  Thus rcu-fence is sort of a
+"super-strong" fence: Unlike the original strong fences (smp_mb() and
+synchronize_rcu()), rcu-fence is able to link events on different
+CPUs.  (Perhaps this fact should lead us to say that rcu-fence isn't
+really a fence at all!)
 
 Finally, the LKMM defines the RCU-before (rb) relation in terms of
 rcu-fence.  This is done in essentially the same way as the pb
@@ -1596,7 +1615,7 @@ before F, just as E ->pb F does (and for much the same reasons).
 Putting this all together, the LKMM expresses the Grace Period
 Guarantee by requiring that the rb relation does not contain a cycle.
 Equivalently, this "rcu" axiom requires that there are no events E
-and F with E ->rcu-link F ->rcu-fence E.  Or to put it a third way,
+and F with E ->rcu-link F ->rcu-order E.  Or to put it a third way,
 the axiom requires that there are no cycles consisting of rcu-gp and
 rcu-rscsi alternating with rcu-link, where the number of rcu-gp links
 is >= the number of rcu-rscsi links.
@@ -1750,7 +1769,7 @@ addition to normal RCU.  The ideas involved are much the same as
 above, with new relations srcu-gp and srcu-rscsi added to represent
 SRCU grace periods and read-side critical sections.  There is a
 restriction on the srcu-gp and srcu-rscsi links that can appear in an
-rcu-fence sequence (the srcu-rscsi links must be paired with srcu-gp
+rcu-order sequence (the srcu-rscsi links must be paired with srcu-gp
 links having the same SRCU domain with proper nesting); the details
 are relatively unimportant.
 
