Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FB0C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717DE21A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570066122;
	bh=X8B73pQcjIp/AA1icOILDEEDeMeq0jr4E16DUv2eUgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aS0l0OtMGW5wuQspS/+6+Ugx9BP8VU2bANSU7qLpUPD2T1LHX/kkLEAJOxLj7kruH
	 Iemp/UZPyAXBGpSUuFVr0beJUc41aUxhsb0AcdRjvSnjzzDEU5aP+oqkc830hUUKAJ
	 Bqj24n7E/hGL/nnlSC7Kqb6wNJO16AGlSNKzvPww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfJCB2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:28:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727503AbfJCB2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:28:22 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 614E1222CB;
        Thu,  3 Oct 2019 01:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066101;
        bh=X8B73pQcjIp/AA1icOILDEEDeMeq0jr4E16DUv2eUgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xbbbWpI14/XUdne+aW7QslBAFZwwTx4nbXz+9yym0tASq1eQqeZCprHK9AooMr/dQ
         1r+glc5tzz6/QAOGE9c1KJdSz1ru0S8ev7Calpz8EeHVXU09nuDorw4FEWW7RYBD5g
         6BDkR6Tv5OGYqSAZxAZX6fpUZPwD0gNeShQ9OGMA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 7/9] Restore docs "rcu: Restore barrier() to rcu_read_lock() and rcu_read_unlock()"
Date:   Wed,  2 Oct 2019 18:28:13 -0700
Message-Id: <20191003012815.12639-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003012741.GA12456@paulmck-ThinkPad-P72>
References: <20191003012741.GA12456@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This restores docs back in ReST format.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 .../RCU/Design/Requirements/Requirements.rst       | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 0b22246..fd5e2cb 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1691,6 +1691,7 @@ follows:
 #. `Hotplug CPU`_
 #. `Scheduler and RCU`_
 #. `Tracing and RCU`_
+#. `Accesses to User Memory and RCU`_
 #. `Energy Efficiency`_
 #. `Scheduling-Clock Interrupts and RCU`_
 #. `Memory Efficiency`_
@@ -2004,6 +2005,59 @@ where RCU readers execute in environments in which tracing cannot be
 used. The tracing folks both located the requirement and provided the
 needed fix, so this surprise requirement was relatively painless.
 
+Accesses to User Memory and RCU
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The kernel needs to access user-space memory, for example, to access data
+referenced by system-call parameters.  The ``get_user()`` macro does this job.
+
+However, user-space memory might well be paged out, which means that
+``get_user()`` might well page-fault and thus block while waiting for the
+resulting I/O to complete.  It would be a very bad thing for the compiler to
+reorder a ``get_user()`` invocation into an RCU read-side critical section.
+
+For example, suppose that the source code looked like this:
+
+  ::
+
+       1 rcu_read_lock();
+       2 p = rcu_dereference(gp);
+       3 v = p->value;
+       4 rcu_read_unlock();
+       5 get_user(user_v, user_p);
+       6 do_something_with(v, user_v);
+
+The compiler must not be permitted to transform this source code into
+the following:
+
+  ::
+
+       1 rcu_read_lock();
+       2 p = rcu_dereference(gp);
+       3 get_user(user_v, user_p); // BUG: POSSIBLE PAGE FAULT!!!
+       4 v = p->value;
+       5 rcu_read_unlock();
+       6 do_something_with(v, user_v);
+
+If the compiler did make this transformation in a ``CONFIG_PREEMPT=n`` kernel
+build, and if ``get_user()`` did page fault, the result would be a quiescent
+state in the middle of an RCU read-side critical section.  This misplaced
+quiescent state could result in line 4 being a use-after-free access,
+which could be bad for your kernel's actuarial statistics.  Similar examples
+can be constructed with the call to ``get_user()`` preceding the
+``rcu_read_lock()``.
+
+Unfortunately, ``get_user()`` doesn't have any particular ordering properties,
+and in some architectures the underlying ``asm`` isn't even marked
+``volatile``.  And even if it was marked ``volatile``, the above access to
+``p->value`` is not volatile, so the compiler would not have any reason to keep
+those two accesses in order.
+
+Therefore, the Linux-kernel definitions of ``rcu_read_lock()`` and
+``rcu_read_unlock()`` must act as compiler barriers, at least for outermost
+instances of ``rcu_read_lock()`` and ``rcu_read_unlock()`` within a nested set
+of RCU read-side critical sections.
+
 Energy Efficiency
 ~~~~~~~~~~~~~~~~~
 
-- 
2.9.5

