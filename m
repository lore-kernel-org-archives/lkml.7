Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87809C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4952171F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="sECQjFMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388283AbfHASOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:14:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44005 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388229AbfHASOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:14:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id r22so7044127pgk.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 11:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cEH3ua6NqMKEtm+KNl7f9AkmibNB7Fry2m+0HSWgt9Y=;
        b=sECQjFMeP09OLvaWvyhHRrkJ/dwut97N5l52doLfqSYuG7DAnh11GOeTmjfJbFxFXK
         lt7S+Al4/ewODGC1Tjd9BXphrL55LaP9Qa5FPWNC4NFvYgFpEk2yk+YO5DrieVBN6JYO
         7s+HNjKbwbUVy6VGugob5oo8tec24HtqQDYx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cEH3ua6NqMKEtm+KNl7f9AkmibNB7Fry2m+0HSWgt9Y=;
        b=ReaHIBSrDGRsBIGLrmRu7x90FlvjeONt9GfzvzK8Tznp2AMFLoppCf087FeLKzDfh/
         N+n59C96tN35oDWinIFLVjlFQoOxJxBRJSt6r3El6QLzxrNrHcJihWzamaBeipvI5UhA
         rudRHYgwaD/f32BxwQ/sHp6/bRO7cMtuWzYJmwvq/63ZXJOAS4+5zPN/Vpr3yEYBJUwO
         vrNjRZoP7g7cRPZgIgYBb+KGU/x4L/xUx350nZeLhEnzPXTOaT9GgUO/SJGMLHPcvjJe
         U/+VqMkE25RJ1LKj/dx/JBMDMIR71tmIzL8gKqEiF6SikP4MfQM9VWo8LOKUlz4b5AUJ
         H0mg==
X-Gm-Message-State: APjAAAUUFeUYudMmNFYCgPXxFVmgU4hkVbJRZovAvVAXff4qzcb9lGPk
        ZKsjMYrmQUWiPNUQ4OMre4qO0Uuuns0=
X-Google-Smtp-Source: APXvYqzSQ1PJ1cHqmh/PjYRZ8130uTvMoUVxmoj7Km2jckPHANgKN0EHx3f/y+EXdTelcw4hgt0zmg==
X-Received: by 2002:a17:90a:290b:: with SMTP id g11mr101679pjd.122.1564683275400;
        Thu, 01 Aug 2019 11:14:35 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g8sm82089165pgk.1.2019.08.01.11.14.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 11:14:34 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org
Subject: [PATCH 9/9] Revert "Revert "rcu: Restore barrier() to rcu_read_lock() and rcu_read_unlock()""
Date:   Thu,  1 Aug 2019 14:14:11 -0400
Message-Id: <20190801181411.96429-10-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801181411.96429-1-joel@joelfernandes.org>
References: <20190801181411.96429-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 43ddb98ebe7171ff1c6e11c1616fd03726d8e9bf while
adding the documentation that the original commit added but in ReST
format.
---
 .../RCU/Design/Requirements/Requirements.rst  | 54 +++++++++++++++++++
 kernel/rcu/tree_plugin.h                      | 11 ----
 2 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 0b222469d7ce..fd5e2cbc4935 100644
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
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index e1491d262892..379cb7e50a62 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -288,7 +288,6 @@ void rcu_note_context_switch(bool preempt)
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp;
 
-	barrier(); /* Avoid RCU read-side critical sections leaking down. */
 	trace_rcu_utilization(TPS("Start context switch"));
 	lockdep_assert_irqs_disabled();
 	WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0);
@@ -331,7 +330,6 @@ void rcu_note_context_switch(bool preempt)
 	if (rdp->exp_deferred_qs)
 		rcu_report_exp_rdp(rdp);
 	trace_rcu_utilization(TPS("End context switch"));
-	barrier(); /* Avoid RCU read-side critical sections leaking up. */
 }
 EXPORT_SYMBOL_GPL(rcu_note_context_switch);
 
@@ -815,11 +813,6 @@ static void rcu_qs(void)
  * dyntick-idle quiescent state visible to other CPUs, which will in
  * some cases serve for expedited as well as normal grace periods.
  * Either way, register a lightweight quiescent state.
- *
- * The barrier() calls are redundant in the common case when this is
- * called externally, but just in case this is called from within this
- * file.
- *
  */
 void rcu_all_qs(void)
 {
@@ -834,14 +827,12 @@ void rcu_all_qs(void)
 		return;
 	}
 	this_cpu_write(rcu_data.rcu_urgent_qs, false);
-	barrier(); /* Avoid RCU read-side critical sections leaking down. */
 	if (unlikely(raw_cpu_read(rcu_data.rcu_need_heavy_qs))) {
 		local_irq_save(flags);
 		rcu_momentary_dyntick_idle();
 		local_irq_restore(flags);
 	}
 	rcu_qs();
-	barrier(); /* Avoid RCU read-side critical sections leaking up. */
 	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(rcu_all_qs);
@@ -851,7 +842,6 @@ EXPORT_SYMBOL_GPL(rcu_all_qs);
  */
 void rcu_note_context_switch(bool preempt)
 {
-	barrier(); /* Avoid RCU read-side critical sections leaking down. */
 	trace_rcu_utilization(TPS("Start context switch"));
 	rcu_qs();
 	/* Load rcu_urgent_qs before other flags. */
@@ -864,7 +854,6 @@ void rcu_note_context_switch(bool preempt)
 		rcu_tasks_qs(current);
 out:
 	trace_rcu_utilization(TPS("End context switch"));
-	barrier(); /* Avoid RCU read-side critical sections leaking up. */
 }
 EXPORT_SYMBOL_GPL(rcu_note_context_switch);
 
-- 
2.22.0.770.g0f2c4a37fd-goog

