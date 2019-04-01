Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98018C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE8A20883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbfDASTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:19:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728663AbfDAST3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:19:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F75C5944D;
        Mon,  1 Apr 2019 18:19:29 +0000 (UTC)
Received: from localhost.default (ovpn-116-31.phx2.redhat.com [10.3.116.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B68E5D6A6;
        Mon,  1 Apr 2019 18:19:27 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: [PATCH V2 1/2] trace,x86: Add external_interrupts to the irq_vectors class
Date:   Mon,  1 Apr 2019 20:19:24 +0200
Message-Id: <833f2a192b491649e4d46cec51028d07c96bbf5e.1554142415.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 01 Apr 2019 18:19:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the irq_vectors is showing the entry and exit events for
the interrupts of the architecture, but not for external interrupts.

Adds the tracepoints for external interrupts.

Example of output:
 <idle>-0     [000] d.h.   102.890935: external_interrupt_entry: vector=35
 <idle>-0     [000] d.h.   102.890960: external_interrupt_exit: vector=35

Changes from V1:
  - Fix a compilation problem when CONFIG_X86_LOCAL_APIC is not set (kbuild test)

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Clark Williams <williams@redhat.com>
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org
---
 arch/x86/include/asm/trace/irq_vectors.h | 10 +++++++++-
 arch/x86/kernel/irq.c                    |  2 ++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/trace/irq_vectors.h b/arch/x86/include/asm/trace/irq_vectors.h
index 33b9d0f0aafe..38e73d56db70 100644
--- a/arch/x86/include/asm/trace/irq_vectors.h
+++ b/arch/x86/include/asm/trace/irq_vectors.h
@@ -138,6 +138,12 @@ DEFINE_IRQ_VECTOR_EVENT(deferred_error_apic);
 DEFINE_IRQ_VECTOR_EVENT(thermal_apic);
 #endif
 
+/*
+ * external_interrupt - called when entering/exiting from regular device
+ * interrupt vector handler.
+ */
+DEFINE_IRQ_VECTOR_EVENT(external_interrupt);
+
 TRACE_EVENT(vector_config,
 
 	TP_PROTO(unsigned int irq, unsigned int vector,
@@ -385,7 +391,9 @@ TRACE_EVENT(vector_free_moved,
 		  __entry->is_managed)
 );
 
-
+#else /* CONFIG_X86_LOCAL_APIC */
+#define trace_external_interrupt_entry(vector) do {} while(0)
+#define trace_external_interrupt_exit(vector) do {} while(0)
 #endif /* CONFIG_X86_LOCAL_APIC */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 59b5f2ea7c2f..715afe3a4f24 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -237,6 +237,7 @@ __visible unsigned int __irq_entry do_IRQ(struct pt_regs *regs)
 	unsigned vector = ~regs->orig_ax;
 
 	entering_irq();
+	trace_external_interrupt_entry(vector);
 
 	/* entering_irq() tells RCU that we're not quiescent.  Check it. */
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
@@ -255,6 +256,7 @@ __visible unsigned int __irq_entry do_IRQ(struct pt_regs *regs)
 		}
 	}
 
+	trace_external_interrupt_exit(vector);
 	exiting_irq();
 
 	set_irq_regs(old_regs);
-- 
2.19.0

