Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A659DC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698E0214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cdOWuRlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388838AbfDRL01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 07:26:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53209 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfDRL0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 07:26:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3IBPOh9166585
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Apr 2019 04:25:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3IBPOh9166585
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555586725;
        bh=UvvezZ0fTZ9f9BlVrDebjkzNzwSZFgLjd0ElzXuSiSY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=cdOWuRlLsArDBuzwJ2ZItfxAlX9zCBycyBns1lsnsZBmv4LWA23QBpzy9f9t5oSHZ
         k0UsxcCRhTND0Ug73mksSQJ/KEKYjWfKaANW8WJVm3F+hzXL8E/1zQA89aLgtNunWV
         0petLXkIPae/pviftwlkP86gvxV4rLqxDY4PuHUMrkZ4QnbBlW7lsEOzy39mNynAUj
         /D3QwfPUBfI7jMQ6dS78lbxauIV6ZmnMM9DLQOQiIAQpBE0mqL3fAYX2rU8y9ESyT3
         jA9ekvKCeOlj7mA5Q+gV8IQtJOUMPpRtWdm8CFRX+CwGOVIGPrFpa3HUEzxq00GNEm
         SJXWqS1Z6Kq0w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3IBPNF0166581;
        Thu, 18 Apr 2019 04:25:23 -0700
Date:   Thu, 18 Apr 2019 04:25:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nicholas Piggin <tipbot@zytor.com>
Message-ID: <tip-3ab68397950772b0dccf565b1294d929f573a8a2@git.kernel.org>
Cc:     hpa@zytor.com, sjitindarsingh@gmail.com,
        torvalds@linux-foundation.org, frederic@kernel.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, paulus@samba.org, peterz@infradead.org,
        tglx@linutronix.de, bigeasy@linutronix.de, mingo@kernel.org,
        clg@kaod.org
Reply-To: clg@kaod.org, mingo@kernel.org, tglx@linutronix.de,
          peterz@infradead.org, bigeasy@linutronix.de, npiggin@gmail.com,
          paulus@samba.org, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, hpa@zytor.com,
          sjitindarsingh@gmail.com, rostedt@goodmis.org,
          frederic@kernel.org
In-Reply-To: <20190409093403.20994-1-npiggin@gmail.com>
References: <20190409093403.20994-1-npiggin@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] irq_work: Do not raise an IPI when queueing work on
 the local CPU
Git-Commit-ID: 3ab68397950772b0dccf565b1294d929f573a8a2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3ab68397950772b0dccf565b1294d929f573a8a2
Gitweb:     https://git.kernel.org/tip/3ab68397950772b0dccf565b1294d929f573a8a2
Author:     Nicholas Piggin <npiggin@gmail.com>
AuthorDate: Tue, 9 Apr 2019 19:34:03 +1000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 18 Apr 2019 12:48:49 +0200

irq_work: Do not raise an IPI when queueing work on the local CPU

The QEMU PowerPC/PSeries machine model was not expecting a self-IPI,
and it may be a bit surprising thing to do, so have irq_work_queue_on
do local queueing when target is the current CPU.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190409093403.20994-1-npiggin@gmail.com
[ Simplified the preprocessor comments. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/irq_work.c | 78 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 35 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 6b7cdf17ccf8..e5f9fe961078 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -56,61 +56,69 @@ void __weak arch_irq_work_raise(void)
 	 */
 }
 
-/*
- * Enqueue the irq_work @work on @cpu unless it's already pending
- * somewhere.
- *
- * Can be re-enqueued while the callback is still in progress.
- */
-bool irq_work_queue_on(struct irq_work *work, int cpu)
+/* Enqueue on current CPU, work must already be claimed and preempt disabled */
+static void __irq_work_queue_local(struct irq_work *work)
 {
-	/* All work should have been flushed before going offline */
-	WARN_ON_ONCE(cpu_is_offline(cpu));
-
-#ifdef CONFIG_SMP
-
-	/* Arch remote IPI send/receive backend aren't NMI safe */
-	WARN_ON_ONCE(in_nmi());
+	/* If the work is "lazy", handle it from next tick if any */
+	if (work->flags & IRQ_WORK_LAZY) {
+		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
+		    tick_nohz_tick_stopped())
+			arch_irq_work_raise();
+	} else {
+		if (llist_add(&work->llnode, this_cpu_ptr(&raised_list)))
+			arch_irq_work_raise();
+	}
+}
 
+/* Enqueue the irq work @work on the current CPU */
+bool irq_work_queue(struct irq_work *work)
+{
 	/* Only queue if not already pending */
 	if (!irq_work_claim(work))
 		return false;
 
-	if (llist_add(&work->llnode, &per_cpu(raised_list, cpu)))
-		arch_send_call_function_single_ipi(cpu);
-
-#else /* #ifdef CONFIG_SMP */
-	irq_work_queue(work);
-#endif /* #else #ifdef CONFIG_SMP */
+	/* Queue the entry and raise the IPI if needed. */
+	preempt_disable();
+	__irq_work_queue_local(work);
+	preempt_enable();
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(irq_work_queue);
 
-/* Enqueue the irq work @work on the current CPU */
-bool irq_work_queue(struct irq_work *work)
+/*
+ * Enqueue the irq_work @work on @cpu unless it's already pending
+ * somewhere.
+ *
+ * Can be re-enqueued while the callback is still in progress.
+ */
+bool irq_work_queue_on(struct irq_work *work, int cpu)
 {
+#ifndef CONFIG_SMP
+	return irq_work_queue(work);
+
+#else /* CONFIG_SMP: */
+	/* All work should have been flushed before going offline */
+	WARN_ON_ONCE(cpu_is_offline(cpu));
+
 	/* Only queue if not already pending */
 	if (!irq_work_claim(work))
 		return false;
 
-	/* Queue the entry and raise the IPI if needed. */
 	preempt_disable();
-
-	/* If the work is "lazy", handle it from next tick if any */
-	if (work->flags & IRQ_WORK_LAZY) {
-		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
-		    tick_nohz_tick_stopped())
-			arch_irq_work_raise();
-	} else {
-		if (llist_add(&work->llnode, this_cpu_ptr(&raised_list)))
-			arch_irq_work_raise();
-	}
-
+	if (cpu != smp_processor_id()) {
+		/* Arch remote IPI send/receive backend aren't NMI safe */
+		WARN_ON_ONCE(in_nmi());
+		if (llist_add(&work->llnode, &per_cpu(raised_list, cpu)))
+			arch_send_call_function_single_ipi(cpu);
+	} else
+		__irq_work_queue_local(work);
 	preempt_enable();
 
 	return true;
+#endif /* CONFIG_SMP */
 }
-EXPORT_SYMBOL_GPL(irq_work_queue);
+
 
 bool irq_work_needs_cpu(void)
 {
