Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1731CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF0C208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfJaLzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:55:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55304 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfJaLzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:09 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92f-0002yU-5V; Thu, 31 Oct 2019 12:55:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 23C411C03AD;
        Thu, 31 Oct 2019 12:55:01 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:00 -0000
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] Restore docs "rcu: Restore barrier() to
 rcu_read_lock() and rcu_read_unlock()"
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252290078.29376.6359963595193512368.tip-bot2@tip-bot2>
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

Commit-ID:     71cb46ae46bda16e766a8957bc68396002767352
Gitweb:        https://git.kernel.org/tip/71cb46ae46bda16e766a8957bc68396002767352
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Thu, 01 Aug 2019 17:39:22 -04:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 29 Oct 2019 02:48:23 -07:00

Restore docs "rcu: Restore barrier() to rcu_read_lock() and rcu_read_unlock()"

This restores docs back in ReST format.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
[ paulmck: Added Joel's SoB per Stephen Rothwell feedback. ]
[ paulmck: Joel approved via private email. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 54 +++++++++-
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
 
