Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2C4C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5374020644
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fO4UiudJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388159AbfHASOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:14:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43984 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388140AbfHASOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:14:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id r22so7043744pgk.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 11:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bi7DhQ5yFa9gdtz6q03hD/81+WCPHg2ZwPjp55qICY0=;
        b=fO4UiudJ9OPBgpVdBS/EVuSW3M31sA5bIBv0f7GHYLZ6KkmIIADDCqXDEx3XnUFCLs
         A3gewf6NuVtUkKSTx+re3DkJTvrn6JSlXBhDjVLXvFCTzKOgDCZI/6Hg/xw46wW5lXry
         dq5lHUiLros4HmkHn68n0nJHv1qIsk3wowRHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bi7DhQ5yFa9gdtz6q03hD/81+WCPHg2ZwPjp55qICY0=;
        b=f3qbTTNC2mr5okupBf8is9WcaUs8i1t7PluIHndfJ99DnW0iP189ID5vBMN2FiIDwd
         ASmvIZAsRCg0XO/aiC9aHhBeAlXHrAr+eX5cN/nPzwye8fFH89QqcXFKgn7qwMU/O6I0
         KrNmozFOcYwRgVpDBoezfPAzz+BACG8AxThTMXaQF3SWRSrfIf9AnU0jU+AvTbn+rEth
         UKDqo08bbGWe12vU/KK+Eb5pirBKQ1bUGRfKzMDAYE5/AwwsVASsQjZXC665yKm24+Ia
         HG7ACoN48KO2Krdw67yDEkXYUdHmoY+LCp7upBNSg8EBl2It2wyi6V65l+KLH/XMDfzL
         YnWg==
X-Gm-Message-State: APjAAAUOtUVZSNF+2vMBoavHvdO0BQR0x9VrrSfjA+WZ23ZjEjI3u+B5
        UockxuMQpFT6vjoOgodNFWcVHU0c
X-Google-Smtp-Source: APXvYqx8IMpZeuWjlPp//DQHV1o08Drpy+nyYs9KCBr1edQSTruxWAMtgwZ97clPwroBcOKdeS3d/Q==
X-Received: by 2002:a63:58c:: with SMTP id 134mr125709836pgf.106.1564683259886;
        Thu, 01 Aug 2019 11:14:19 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g8sm82089165pgk.1.2019.08.01.11.14.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 11:14:19 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org
Subject: [PATCH 1/9] Revert "rcu: Restore barrier() to rcu_read_lock() and rcu_read_unlock()"
Date:   Thu,  1 Aug 2019 14:14:03 -0400
Message-Id: <20190801181411.96429-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801181411.96429-1-joel@joelfernandes.org>
References: <20190801181411.96429-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d6b9cd7dc8e041ee83cb1362fce59a3cdb1f2709.
---
 .../RCU/Design/Requirements/Requirements.html | 71 -------------------
 kernel/rcu/tree_plugin.h                      | 11 +++
 2 files changed, 11 insertions(+), 71 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.html b/Documentation/RCU/Design/Requirements/Requirements.html
index 467251f7fef6..bdbc84f1b949 100644
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
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 379cb7e50a62..e1491d262892 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -288,6 +288,7 @@ void rcu_note_context_switch(bool preempt)
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp;
 
+	barrier(); /* Avoid RCU read-side critical sections leaking down. */
 	trace_rcu_utilization(TPS("Start context switch"));
 	lockdep_assert_irqs_disabled();
 	WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0);
@@ -330,6 +331,7 @@ void rcu_note_context_switch(bool preempt)
 	if (rdp->exp_deferred_qs)
 		rcu_report_exp_rdp(rdp);
 	trace_rcu_utilization(TPS("End context switch"));
+	barrier(); /* Avoid RCU read-side critical sections leaking up. */
 }
 EXPORT_SYMBOL_GPL(rcu_note_context_switch);
 
@@ -813,6 +815,11 @@ static void rcu_qs(void)
  * dyntick-idle quiescent state visible to other CPUs, which will in
  * some cases serve for expedited as well as normal grace periods.
  * Either way, register a lightweight quiescent state.
+ *
+ * The barrier() calls are redundant in the common case when this is
+ * called externally, but just in case this is called from within this
+ * file.
+ *
  */
 void rcu_all_qs(void)
 {
@@ -827,12 +834,14 @@ void rcu_all_qs(void)
 		return;
 	}
 	this_cpu_write(rcu_data.rcu_urgent_qs, false);
+	barrier(); /* Avoid RCU read-side critical sections leaking down. */
 	if (unlikely(raw_cpu_read(rcu_data.rcu_need_heavy_qs))) {
 		local_irq_save(flags);
 		rcu_momentary_dyntick_idle();
 		local_irq_restore(flags);
 	}
 	rcu_qs();
+	barrier(); /* Avoid RCU read-side critical sections leaking up. */
 	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(rcu_all_qs);
@@ -842,6 +851,7 @@ EXPORT_SYMBOL_GPL(rcu_all_qs);
  */
 void rcu_note_context_switch(bool preempt)
 {
+	barrier(); /* Avoid RCU read-side critical sections leaking down. */
 	trace_rcu_utilization(TPS("Start context switch"));
 	rcu_qs();
 	/* Load rcu_urgent_qs before other flags. */
@@ -854,6 +864,7 @@ void rcu_note_context_switch(bool preempt)
 		rcu_tasks_qs(current);
 out:
 	trace_rcu_utilization(TPS("End context switch"));
+	barrier(); /* Avoid RCU read-side critical sections leaking up. */
 }
 EXPORT_SYMBOL_GPL(rcu_note_context_switch);
 
-- 
2.22.0.770.g0f2c4a37fd-goog

