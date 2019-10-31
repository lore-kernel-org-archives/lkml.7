Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADFDCA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B659208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfJaLzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:55:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55352 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbfJaLzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:14 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92i-00030z-Vk; Thu, 31 Oct 2019 12:55:09 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7E6591C04DF;
        Thu, 31 Oct 2019 12:55:03 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:03 -0000
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] Revert docs from "rcu: Restore barrier() to
 rcu_read_lock() and rcu_read_unlock()"
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252290322.29376.3242675913911109273.tip-bot2@tip-bot2>
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

Commit-ID:     97df75cde57f0a24075200e22d9e2cfb1f2e195b
Gitweb:        https://git.kernel.org/tip/97df75cde57f0a24075200e22d9e2cfb1f2e195b
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Thu, 01 Aug 2019 17:39:16 -04:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 29 Oct 2019 02:43:50 -07:00

Revert docs from "rcu: Restore barrier() to rcu_read_lock() and rcu_read_unlock()"

This reverts docs from commit d6b9cd7dc8e041ee83cb1362fce59a3cdb1f2709.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
[ paulmck: Added Joel's SoB per Stephen Rothwell feedback. ]
[ paulmck: Joel approved via private email. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Requirements/Requirements.html | 71 +--------
 1 file changed, 71 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Documentation/RCU/Design/Requirements/Requirements.html
index 467251f..bdbc84f 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.html
+++ b/Documentation/RCU/Design/Requirements/Requirements.html
@@ -2129,8 +2129,6 @@ Some of the relevant points of interest are as follows:
 <li>	<a href="#Hotplug CPU">Hotplug CPU</a>.
 <li>	<a href="#Scheduler and RCU">Scheduler and RCU</a>.
 <li>	<a href="#Tracing and RCU">Tracing and RCU</a>.
-<li>	<a href="#Accesses to User Memory and RCU">
-Accesses to User Memory and RCU</a>.
 <li>	<a href="#Energy Efficiency">Energy Efficiency</a>.
 <li>	<a href="#Scheduling-Clock Interrupts and RCU">
 	Scheduling-Clock Interrupts and RCU</a>.
@@ -2523,75 +2521,6 @@ cannot be used.
 The tracing folks both located the requirement and provided the
 needed fix, so this surprise requirement was relatively painless.
 
-<h3><a name="Accesses to User Memory and RCU">
-Accesses to User Memory and RCU</a></h3>
-
-<p>
-The kernel needs to access user-space memory, for example, to access
-data referenced by system-call parameters.
-The <tt>get_user()</tt> macro does this job.
-
-<p>
-However, user-space memory might well be paged out, which means
-that <tt>get_user()</tt> might well page-fault and thus block while
-waiting for the resulting I/O to complete.
-It would be a very bad thing for the compiler to reorder
-a <tt>get_user()</tt> invocation into an RCU read-side critical
-section.
-For example, suppose that the source code looked like this:
-
-<blockquote>
-<pre>
- 1 rcu_read_lock();
- 2 p = rcu_dereference(gp);
- 3 v = p-&gt;value;
- 4 rcu_read_unlock();
- 5 get_user(user_v, user_p);
- 6 do_something_with(v, user_v);
-</pre>
-</blockquote>
-
-<p>
-The compiler must not be permitted to transform this source code into
-the following:
-
-<blockquote>
-<pre>
- 1 rcu_read_lock();
- 2 p = rcu_dereference(gp);
- 3 get_user(user_v, user_p); // BUG: POSSIBLE PAGE FAULT!!!
- 4 v = p-&gt;value;
- 5 rcu_read_unlock();
- 6 do_something_with(v, user_v);
-</pre>
-</blockquote>
-
-<p>
-If the compiler did make this transformation in a
-<tt>CONFIG_PREEMPT=n</tt> kernel build, and if <tt>get_user()</tt> did
-page fault, the result would be a quiescent state in the middle
-of an RCU read-side critical section.
-This misplaced quiescent state could result in line&nbsp;4 being
-a use-after-free access, which could be bad for your kernel's
-actuarial statistics.
-Similar examples can be constructed with the call to <tt>get_user()</tt>
-preceding the <tt>rcu_read_lock()</tt>.
-
-<p>
-Unfortunately, <tt>get_user()</tt> doesn't have any particular
-ordering properties, and in some architectures the underlying <tt>asm</tt>
-isn't even marked <tt>volatile</tt>.
-And even if it was marked <tt>volatile</tt>, the above access to
-<tt>p-&gt;value</tt> is not volatile, so the compiler would not have any
-reason to keep those two accesses in order.
-
-<p>
-Therefore, the Linux-kernel definitions of <tt>rcu_read_lock()</tt>
-and <tt>rcu_read_unlock()</tt> must act as compiler barriers,
-at least for outermost instances of <tt>rcu_read_lock()</tt> and
-<tt>rcu_read_unlock()</tt> within a nested set of RCU read-side critical
-sections.
-
 <h3><a name="Energy Efficiency">Energy Efficiency</a></h3>
 
 <p>
