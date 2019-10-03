Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CFAC4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79349222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570066103;
	bh=wJKxvWvd7SK3qGvEJLz8xIFla/eoVSIcHC0HLuWfA0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zDSC6KIDWBL1IlihFoqOSvdByQ38zqGDUzytWYHLQWw+mHvlf9YjyXmS62gpzlk5G
	 t31qFLr6XhwA3h/vusrgokShgWjzKMGcT9xioEgw4o1b8u+88G2B1i9lBaQtfBU7VI
	 CHNuS/pouGdJwob8GHoB9I7H37akWo5mLaehx04Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfJCB2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:28:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfJCB2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:28:19 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15F3D21A4C;
        Thu,  3 Oct 2019 01:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066098;
        bh=wJKxvWvd7SK3qGvEJLz8xIFla/eoVSIcHC0HLuWfA0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1f4DAL63vZdn9mStFKlNJ+6Skm/xAzeDm/1UusSUgbc3m0fJaE6ObOk+b8Q1iy9Ug
         Ntg/kRfqwG3T1vvfTu9u22VkwKEyiMJ/pvdViVCcpT5XcYUWvaUPqKKLk4clxMQqRm
         ljx1QMQyWs/6bfhSo+DBXAbfVH0hkN1nP31shS/E=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 1/9] Revert docs from "rcu: Restore barrier() to rcu_read_lock() and rcu_read_unlock()"
Date:   Wed,  2 Oct 2019 18:28:07 -0700
Message-Id: <20191003012815.12639-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003012741.GA12456@paulmck-ThinkPad-P72>
References: <20191003012741.GA12456@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This reverts docs from commit d6b9cd7dc8e041ee83cb1362fce59a3cdb1f2709.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 .../RCU/Design/Requirements/Requirements.html      | 71 ----------------------
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
-- 
2.9.5

