Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C80FC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 01:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116F22070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 01:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="gBQww/xk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfG2BId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 21:08:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41908 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfG2BId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 21:08:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so27106891pff.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 18:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qbL3ZNd6Yfl9XGwRwZu8P8EkNcIfnBlQKqpKi3KACD8=;
        b=gBQww/xkoLK4gbu3lkp1VXuPMw9oRLmCcF52ne8vCYRNMs9IR0XPXDySOT3gRssI5M
         h+TAgGnrgApeXOLmz6sREDeBI9SSysdMrMADGyI1mgLNJtv8r2o1PaxdMZq+YJBSrljk
         FX34Heav4w+saNV2KxFdmeUAh+SorNTvY5JbJUi/zGSl+pzjr064dpi6mQ3+ZJvdyldC
         OfPlglYP1wXrJyKK0UAJ9sIltUvc3IWLm6SZU0wv+Dzpz1IlVM2oYXKLBRB8vdqO9Jct
         rg+91u3HHoWcEHKYWXnBUkzq9clWyVZ1gvnnD12h8Sm5nmexvFPxNwmUFs2Bl42jy5dw
         oY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qbL3ZNd6Yfl9XGwRwZu8P8EkNcIfnBlQKqpKi3KACD8=;
        b=sO8Nj1QXwsuqHOVJ54MjvCPmRgvbqRMAWeCh7M7IqWl0/6coIq5o9qx+Fv1fKGXeLA
         XJ/QW+u7wdNFtx/5orXFbDcJyyTpBsACsEcVOhwk1C0bwigf5ZxsUBJKPq6rmDxZllx1
         FiwQ8ycZKq0vyv8mD0Wp+HGPlNfjs7drS6lHxJnN4odN3ZIT6UcOn8uoKMjjV57UeS5l
         b9FA1r4EGKNjh8R4Ab6epEFN+zYCQjDXhqWvZ8AB8Tc9RMvfz79/0seLkHVMpqYhmnBI
         yOGO1AjkjqniSuhqWuEkqY+gX+kaW+gxZ02z3l6DgFjQmKd1Yc3d9wsp30EJhGqUYu7E
         5T4A==
X-Gm-Message-State: APjAAAUOnLiA5bYrtxohupmYctVsuxvZ4zQM5UZrn8BOHCHKYn/UQAoE
        gRZpYc03LAGK+z7fiuvsFFk=
X-Google-Smtp-Source: APXvYqzvwMexYFJFD8qJvuvgSGbcmtY9AgfvLNXs/7DCCXuFfYlAMPT5t0xpmOLpraGIVU0fDcgKmQ==
X-Received: by 2002:aa7:9514:: with SMTP id b20mr34727150pfp.223.1564362512313;
        Sun, 28 Jul 2019 18:08:32 -0700 (PDT)
Received: from localhost.localdomain (p2517222-ipngn21701marunouchi.tokyo.ocn.ne.jp. [118.7.246.222])
        by smtp.gmail.com with ESMTPSA id a3sm68620300pje.3.2019.07.28.18.08.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 18:08:31 -0700 (PDT)
From:   Eiichi Tsukata <devel@etsukata.com>
To:     joel@joelfernandes.org, paulmck@linux.vnet.ibm.com,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        mingo@redhat.com, fweisbec@gmail.com, luto@amacapital.net,
        linux-kernel@vger.kernel.org
Cc:     Eiichi Tsukata <devel@etsukata.com>
Subject: [PATCH] tracing: Prevent RCU EQS breakage in preemptirq events
Date:   Mon, 29 Jul 2019 10:07:34 +0900
Message-Id: <20190729010734.3352-1-devel@etsukata.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If context tracking is enabled, causing page fault in preemptirq
irq_enable or irq_disable events triggers the following RCU EQS warning.

Reproducer:

  // CONFIG_PREEMPTIRQ_EVENTS=y
  // CONFIG_CONTEXT_TRACKING=y
  // CONFIG_RCU_EQS_DEBUG=y
  # echo 1 > events/preemptirq/irq_disable/enable
  # echo 1 > options/userstacktrace

  WARNING: CPU: 0 PID: 2574 at kernel/rcu/tree.c:262 rcu_dynticks_eqs_exit+0x48/0x50
  CPU: 0 PID: 2574 Comm: sh Not tainted 5.3.0-rc1+ #105
  RIP: 0010:rcu_dynticks_eqs_exit+0x48/0x50
  Call Trace:
   rcu_eqs_exit+0x4e/0xd0
   rcu_user_exit+0x13/0x20
   __context_tracking_exit.part.0+0x74/0x120
   context_tracking_exit.part.0+0x28/0x50
   context_tracking_exit+0x1d/0x20
   do_page_fault+0xab/0x1b0
   do_async_page_fault+0x35/0xb0
   async_page_fault+0x3e/0x50
  RIP: 0010:arch_stack_walk_user+0x8e/0x100
   stack_trace_save_user+0x7d/0xa9
   trace_buffer_unlock_commit_regs+0x178/0x220
   trace_event_buffer_commit+0x6b/0x200
   trace_event_raw_event_preemptirq_template+0x7b/0xc0
   trace_hardirqs_off_caller+0xb3/0xf0
   trace_hardirqs_off_thunk+0x1a/0x20
   entry_SYSCALL_64_after_hwframe+0x3e/0xbe

Details of call trace and RCU EQS/Context:

  entry_SYSCALL_64_after_hwframe() EQS: IN, CTX: USER
    trace_irq_disable_rcuidle()
      rcu_irq_enter_irqson()
        rcu_dynticks_eqs_exit() EQS: IN => OUT
      stack_trace_save_user() EQS: OUT, CTX: USER
        page_fault()
          do_page_fault()
            exception_enter() EQS: OUT, CTX: USER
              context_tracking_exit()
                rcu_eqs_exit()
		  rcu_dynticks_eqs_exit() EQS: OUT => OUT? (warning)

trace_irq_disable/enable_rcuidle() are called from user mode in entry
code, and calls rcu_irq_enter_irqson() in __DO_TRACE(). This can cause
the state "RCU ESQ: OUT but CTX: USER", then stack_trace_save_user() can
cause page fault which calls rcu_dynticks_eqs_exit() again leads to hit
the EQS validation warning if CONFIG_RCU_EQS_DEBUG is enabled.

Fix it by calling exception_enter/exit() around
trace_irq_disable/enable_rcuidle() to enter CONTEXT_KERNEL before
tracing code causes page fault. Also makes the timing of state change to
CONTEXT_KERNL earlier to prevent tracing codes from calling
context_tracking_exit() recursively.

Ideally, the problem can be fixed by calling enter_from_user_mode() before
TRACE_IRQS_OFF in entry codes (then we need to tell lockdep that IRQs are
off eariler) and calling prepare_exit_to_usermode() after TRACE_IRQS_ON.
But this patch will be much simpler and limit the most change to tracing
codes.

Fixes: 865e63b04e9b ("tracing: Add back in rcu_irq_enter/exit_irqson() for rcuidle tracepoints")
Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
---
 kernel/context_tracking.c       |  6 +++++-
 kernel/trace/trace_preemptirq.c | 15 +++++++++++++--
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index be01a4d627c9..860eaf9780e5 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -148,6 +148,11 @@ void __context_tracking_exit(enum ctx_state state)
 		return;
 
 	if (__this_cpu_read(context_tracking.state) == state) {
+		/*
+		 * Change state before executing codes which can trigger
+		 * page fault leading unnecessary re-entrance.
+		 */
+		__this_cpu_write(context_tracking.state, CONTEXT_KERNEL);
 		if (__this_cpu_read(context_tracking.active)) {
 			/*
 			 * We are going to run code that may use RCU. Inform
@@ -159,7 +164,6 @@ void __context_tracking_exit(enum ctx_state state)
 				trace_user_exit(0);
 			}
 		}
-		__this_cpu_write(context_tracking.state, CONTEXT_KERNEL);
 	}
 	context_tracking_recursion_exit();
 }
diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index 4d8e99fdbbbe..031b51cb94d0 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/ftrace.h>
 #include <linux/kprobes.h>
+#include <linux/context_tracking.h>
 #include "trace.h"
 
 #define CREATE_TRACE_POINTS
@@ -49,9 +50,14 @@ NOKPROBE_SYMBOL(trace_hardirqs_off);
 
 __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
 {
+	enum ctx_state prev_state;
+
 	if (this_cpu_read(tracing_irq_cpu)) {
-		if (!in_nmi())
+		if (!in_nmi()) {
+			prev_state = exception_enter();
 			trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
+			exception_exit(prev_state);
+		}
 		tracer_hardirqs_on(CALLER_ADDR0, caller_addr);
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
@@ -63,11 +69,16 @@ NOKPROBE_SYMBOL(trace_hardirqs_on_caller);
 
 __visible void trace_hardirqs_off_caller(unsigned long caller_addr)
 {
+	enum ctx_state prev_state;
+
 	if (!this_cpu_read(tracing_irq_cpu)) {
 		this_cpu_write(tracing_irq_cpu, 1);
 		tracer_hardirqs_off(CALLER_ADDR0, caller_addr);
-		if (!in_nmi())
+		if (!in_nmi()) {
+			prev_state = exception_enter();
 			trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
+			exception_exit(prev_state);
+		}
 	}
 
 	lockdep_hardirqs_off(CALLER_ADDR0);
-- 
2.21.0

