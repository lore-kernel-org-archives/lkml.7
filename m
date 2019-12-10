Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D9DC2D0BE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13E120726
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575951618;
	bh=ng+ze/OYqZqO9jZh11sxURI+8AmnO36XW3oAqQ85jmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yaAFDkoQPCCZnmHY3lDI58nHfy09Kv4jFnfYgPbEjpY/31PksBWp7cC8CGgtyt5vw
	 /dxElMcRZyQ5MKchTan7/iRTjukohetwL454ABgsy75SQk/IC/fuphVxLuUbK9OuoQ
	 MWgaLlSucspd16dsVZgVlW79+7+IShq11msW2O7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfLJEUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:20:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:47044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbfLJEUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:20:08 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68135214AF;
        Tue, 10 Dec 2019 04:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951606;
        bh=ng+ze/OYqZqO9jZh11sxURI+8AmnO36XW3oAqQ85jmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CmZVrDFnerOfQbtJrM9tZ4WJFYuWvx90L/jjQfYmtahxz9mEazpa78ggISNTxRRrt
         hKpxxe5vLjnDQcHKASYrPt22LMO5V3LYqgCMOaPFpa3wrug8kEyQCymEKMU7rT2fL8
         8J6BPHlaF+2QVKsf/0QHGmSYfyYVuFh1MxFQpYmc=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 4/9] rcu: Use WRITE_ONCE() for assignments to ->pprev for hlist_nulls
Date:   Mon,  9 Dec 2019 20:19:57 -0800
Message-Id: <20191210042002.3490-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210041938.GA3367@paulmck-ThinkPad-P72>
References: <20191210041938.GA3367@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Eric Dumazet supplied a KCSAN report of a bug that forces use
of hlist_unhashed_lockless() from sk_unhashed():

------------------------------------------------------------------------

BUG: KCSAN: data-race in inet_unhash / inet_unhash

write to 0xffff8880a69a0170 of 8 bytes by interrupt on cpu 1:
 __hlist_nulls_del include/linux/list_nulls.h:88 [inline]
 hlist_nulls_del_init_rcu include/linux/rculist_nulls.h:36 [inline]
 __sk_nulls_del_node_init_rcu include/net/sock.h:676 [inline]
 inet_unhash+0x38f/0x4a0 net/ipv4/inet_hashtables.c:612
 tcp_set_state+0xfa/0x3e0 net/ipv4/tcp.c:2249
 tcp_done+0x93/0x1e0 net/ipv4/tcp.c:3854
 tcp_write_err+0x7e/0xc0 net/ipv4/tcp_timer.c:56
 tcp_retransmit_timer+0x9b8/0x16d0 net/ipv4/tcp_timer.c:479
 tcp_write_timer_handler+0x42d/0x510 net/ipv4/tcp_timer.c:599
 tcp_write_timer+0xd1/0xf0 net/ipv4/tcp_timer.c:619
 call_timer_fn+0x5f/0x2f0 kernel/time/timer.c:1404
 expire_timers kernel/time/timer.c:1449 [inline]
 __run_timers kernel/time/timer.c:1773 [inline]
 __run_timers kernel/time/timer.c:1740 [inline]
 run_timer_softirq+0xc0c/0xcd0 kernel/time/timer.c:1786
 __do_softirq+0x115/0x33f kernel/softirq.c:292
 invoke_softirq kernel/softirq.c:373 [inline]
 irq_exit+0xbb/0xe0 kernel/softirq.c:413
 exiting_irq arch/x86/include/asm/apic.h:536 [inline]
 smp_apic_timer_interrupt+0xe6/0x280 arch/x86/kernel/apic/apic.c:1137
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
 native_safe_halt+0xe/0x10 arch/x86/kernel/paravirt.c:71
 arch_cpu_idle+0x1f/0x30 arch/x86/kernel/process.c:571
 default_idle_call+0x1e/0x40 kernel/sched/idle.c:94
 cpuidle_idle_call kernel/sched/idle.c:154 [inline]
 do_idle+0x1af/0x280 kernel/sched/idle.c:263
 cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:355
 start_secondary+0x208/0x260 arch/x86/kernel/smpboot.c:264
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241

read to 0xffff8880a69a0170 of 8 bytes by interrupt on cpu 0:
 sk_unhashed include/net/sock.h:607 [inline]
 inet_unhash+0x3d/0x4a0 net/ipv4/inet_hashtables.c:592
 tcp_set_state+0xfa/0x3e0 net/ipv4/tcp.c:2249
 tcp_done+0x93/0x1e0 net/ipv4/tcp.c:3854
 tcp_write_err+0x7e/0xc0 net/ipv4/tcp_timer.c:56
 tcp_retransmit_timer+0x9b8/0x16d0 net/ipv4/tcp_timer.c:479
 tcp_write_timer_handler+0x42d/0x510 net/ipv4/tcp_timer.c:599
 tcp_write_timer+0xd1/0xf0 net/ipv4/tcp_timer.c:619
 call_timer_fn+0x5f/0x2f0 kernel/time/timer.c:1404
 expire_timers kernel/time/timer.c:1449 [inline]
 __run_timers kernel/time/timer.c:1773 [inline]
 __run_timers kernel/time/timer.c:1740 [inline]
 run_timer_softirq+0xc0c/0xcd0 kernel/time/timer.c:1786
 __do_softirq+0x115/0x33f kernel/softirq.c:292
 invoke_softirq kernel/softirq.c:373 [inline]
 irq_exit+0xbb/0xe0 kernel/softirq.c:413
 exiting_irq arch/x86/include/asm/apic.h:536 [inline]
 smp_apic_timer_interrupt+0xe6/0x280 arch/x86/kernel/apic/apic.c:1137
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
 native_safe_halt+0xe/0x10 arch/x86/kernel/paravirt.c:71
 arch_cpu_idle+0x1f/0x30 arch/x86/kernel/process.c:571
 default_idle_call+0x1e/0x40 kernel/sched/idle.c:94
 cpuidle_idle_call kernel/sched/idle.c:154 [inline]
 do_idle+0x1af/0x280 kernel/sched/idle.c:263
 cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:355
 rest_init+0xec/0xf6 init/main.c:452
 arch_call_rest_init+0x17/0x37
 start_kernel+0x838/0x85e init/main.c:786
 x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:490
 x86_64_start_kernel+0x72/0x76 arch/x86/kernel/head64.c:471
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-rc6+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 01/01/2011

------------------------------------------------------------------------

This commit therefore replaces C-language assignments with WRITE_ONCE()
in include/linux/list_nulls.h and include/linux/rculist_nulls.h.

Reported-by: Eric Dumazet <edumazet@google.com> # For KCSAN
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/list_nulls.h    | 8 ++++----
 include/linux/rculist_nulls.h | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/list_nulls.h b/include/linux/list_nulls.h
index 3ef9674..1ecd356 100644
--- a/include/linux/list_nulls.h
+++ b/include/linux/list_nulls.h
@@ -72,10 +72,10 @@ static inline void hlist_nulls_add_head(struct hlist_nulls_node *n,
 	struct hlist_nulls_node *first = h->first;
 
 	n->next = first;
-	n->pprev = &h->first;
+	WRITE_ONCE(n->pprev, &h->first);
 	h->first = n;
 	if (!is_a_nulls(first))
-		first->pprev = &n->next;
+		WRITE_ONCE(first->pprev, &n->next);
 }
 
 static inline void __hlist_nulls_del(struct hlist_nulls_node *n)
@@ -85,13 +85,13 @@ static inline void __hlist_nulls_del(struct hlist_nulls_node *n)
 
 	WRITE_ONCE(*pprev, next);
 	if (!is_a_nulls(next))
-		next->pprev = pprev;
+		WRITE_ONCE(next->pprev, pprev);
 }
 
 static inline void hlist_nulls_del(struct hlist_nulls_node *n)
 {
 	__hlist_nulls_del(n);
-	n->pprev = LIST_POISON2;
+	WRITE_ONCE(n->pprev, LIST_POISON2);
 }
 
 /**
diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index bc8206a..517a06f 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -34,7 +34,7 @@ static inline void hlist_nulls_del_init_rcu(struct hlist_nulls_node *n)
 {
 	if (!hlist_nulls_unhashed(n)) {
 		__hlist_nulls_del(n);
-		n->pprev = NULL;
+		WRITE_ONCE(n->pprev, NULL);
 	}
 }
 
@@ -66,7 +66,7 @@ static inline void hlist_nulls_del_init_rcu(struct hlist_nulls_node *n)
 static inline void hlist_nulls_del_rcu(struct hlist_nulls_node *n)
 {
 	__hlist_nulls_del(n);
-	n->pprev = LIST_POISON2;
+	WRITE_ONCE(n->pprev, LIST_POISON2);
 }
 
 /**
@@ -94,10 +94,10 @@ static inline void hlist_nulls_add_head_rcu(struct hlist_nulls_node *n,
 	struct hlist_nulls_node *first = h->first;
 
 	n->next = first;
-	n->pprev = &h->first;
+	WRITE_ONCE(n->pprev, &h->first);
 	rcu_assign_pointer(hlist_nulls_first_rcu(h), n);
 	if (!is_a_nulls(first))
-		first->pprev = &n->next;
+		WRITE_ONCE(first->pprev, &n->next);
 }
 
 /**
-- 
2.9.5

