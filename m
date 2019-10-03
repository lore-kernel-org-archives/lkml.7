Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57EAC4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B801721A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570066125;
	bh=r918KxJxCTjLYvo1S0is29B2TP2tE0+EBrtulOmH7NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LBLay0FG2supncBG0YBvn20JloSNzClO3LBmvywRltxuSyYK6gh6do5g+ALlA316f
	 0GDmX6P3oaKVCecm1hKJYsDHsREldQ/znBgrk1m3y+EG1zGNXV/YjXSdjAPKXbNeQm
	 U0N1WvJxpdLcbY456BZIXDe+lEmc0FKNlKrjPfmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfJCB2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:28:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727587AbfJCB2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:28:22 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B09B8222CD;
        Thu,  3 Oct 2019 01:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066101;
        bh=r918KxJxCTjLYvo1S0is29B2TP2tE0+EBrtulOmH7NY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jY32C+ICdxo04jN1txh1S5ED+EgHQDxvoAt2DXC/uIOAfxnj2M4wZKbqmT9Bt1Wcm
         ovuP7Gz182OdH+YNnFhPD80368OSNX4t7uVB80ej1K/5sPI2z13TLIr4EPC52Pw8FM
         4Q9BNhh9VqOm7xEwp96giaZwxMZ3aa0BPPwNhum8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 8/9] doc: Update list_for_each_entry_rcu() documentation
Date:   Wed,  2 Oct 2019 18:28:14 -0700
Message-Id: <20191003012815.12639-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003012741.GA12456@paulmck-ThinkPad-P72>
References: <20191003012741.GA12456@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This commit updates the documentation with information about
usage of lockdep with list_for_each_entry_rcu().

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
[ paulmck: Wordsmithing. ]
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 Documentation/RCU/lockdep.txt   | 18 ++++++++++++++----
 Documentation/RCU/whatisRCU.txt | 10 +++++++++-
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/RCU/lockdep.txt b/Documentation/RCU/lockdep.txt
index da51d30..89db949e 100644
--- a/Documentation/RCU/lockdep.txt
+++ b/Documentation/RCU/lockdep.txt
@@ -96,7 +96,17 @@ other flavors of rcu_dereference().  On the other hand, it is illegal
 to use rcu_dereference_protected() if either the RCU-protected pointer
 or the RCU-protected data that it points to can change concurrently.
 
-There are currently only "universal" versions of the rcu_assign_pointer()
-and RCU list-/tree-traversal primitives, which do not (yet) check for
-being in an RCU read-side critical section.  In the future, separate
-versions of these primitives might be created.
+Like rcu_dereference(), when lockdep is enabled, RCU list and hlist
+traversal primitives check for being called from within an RCU read-side
+critical section.  However, a lockdep expression can be passed to them
+as a additional optional argument.  With this lockdep expression, these
+traversal primitives will complain only if the lockdep expression is
+false and they are called from outside any RCU read-side critical section.
+
+For example, the workqueue for_each_pwq() macro is intended to be used
+either within an RCU read-side critical section or with wq->mutex held.
+It is thus implemented as follows:
+
+	#define for_each_pwq(pwq, wq)
+		list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node,
+					lock_is_held(&(wq->mutex).dep_map))
diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
index 17f4831..58ba05c 100644
--- a/Documentation/RCU/whatisRCU.txt
+++ b/Documentation/RCU/whatisRCU.txt
@@ -290,7 +290,7 @@ rcu_dereference()
 	at any time, including immediately after the rcu_dereference().
 	And, again like rcu_assign_pointer(), rcu_dereference() is
 	typically used indirectly, via the _rcu list-manipulation
-	primitives, such as list_for_each_entry_rcu().
+	primitives, such as list_for_each_entry_rcu() [2].
 
 	[1] The variant rcu_dereference_protected() can be used outside
 	of an RCU read-side critical section as long as the usage is
@@ -305,6 +305,14 @@ rcu_dereference()
 	a lockdep splat is emitted.  See Documentation/RCU/Design/Requirements/Requirements.rst
 	and the API's code comments for more details and example usage.
 
+	[2] If the list_for_each_entry_rcu() instance might be used by
+	update-side code as well as by RCU readers, then an additional
+	lockdep expression can be added to its list of arguments.
+	For example, given an additional "lock_is_held(&mylock)" argument,
+	the RCU lockdep code would complain only if this instance was
+	invoked outside of an RCU read-side critical section and without
+	the protection of mylock.
+
 The following diagram shows how each API communicates among the
 reader, updater, and reclaimer.
 
-- 
2.9.5

