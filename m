Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C10C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D4820883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbfDASTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:19:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728663AbfDASTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:19:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4FD7A59443;
        Mon,  1 Apr 2019 18:19:31 +0000 (UTC)
Received: from localhost.default (ovpn-116-31.phx2.redhat.com [10.3.116.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9AB1B5D71A;
        Mon,  1 Apr 2019 18:19:29 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: [PATCH V2 2/2] trace,x86: Add nmi to the irq_vectors class
Date:   Mon,  1 Apr 2019 20:19:25 +0200
Message-Id: <d9e0e9d14d2ef394cea974e2f47c0099b7d18839.1554142415.git.bristot@redhat.com>
In-Reply-To: <833f2a192b491649e4d46cec51028d07c96bbf5e.1554142415.git.bristot@redhat.com>
References: <833f2a192b491649e4d46cec51028d07c96bbf5e.1554142415.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 01 Apr 2019 18:19:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the irq_vector class of tracepoints does not include the NMI
entry. The NMI was in the first set of tracepoints for IRQs, but it was
dropped off because of the logic of switching IDT when enabling trace[1].
However, as the switching IDT logic was removed [2], it is possible to add
the NMI tracepoints back.

The tracepoints looks like:
          <idle>-0     [000] d.Z.   179.594315: nmi_entry: vector=2
          <idle>-0     [000] d.Z.   179.594396: nmi_exit: vector=2

[1] trace,x86: irq vector tracepoint support
    https://lwn.net/Articles/555465/
[2] commit 4b9a8dca0e58 ("x86/idt: Remove the tracing IDT completely")

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
 arch/x86/include/asm/trace/irq_vectors.h | 7 +++++++
 arch/x86/kernel/nmi.c                    | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/trace/irq_vectors.h b/arch/x86/include/asm/trace/irq_vectors.h
index 38e73d56db70..a68885e90e16 100644
--- a/arch/x86/include/asm/trace/irq_vectors.h
+++ b/arch/x86/include/asm/trace/irq_vectors.h
@@ -144,6 +144,11 @@ DEFINE_IRQ_VECTOR_EVENT(thermal_apic);
  */
 DEFINE_IRQ_VECTOR_EVENT(external_interrupt);
 
+/*
+ * nmi - called when entering/exiting from nmi vector handler.
+ */
+DEFINE_IRQ_VECTOR_EVENT(nmi);
+
 TRACE_EVENT(vector_config,
 
 	TP_PROTO(unsigned int irq, unsigned int vector,
@@ -394,6 +399,8 @@ TRACE_EVENT(vector_free_moved,
 #else /* CONFIG_X86_LOCAL_APIC */
 #define trace_external_interrupt_entry(vector) do {} while(0)
 #define trace_external_interrupt_exit(vector) do {} while(0)
+#define trace_nmi_entry(vector) do {} while(0)
+#define trace_nmi_exit(vector) do {} while(0)
 #endif /* CONFIG_X86_LOCAL_APIC */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 18bc9b51ac9b..fa2d16b3af60 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -37,6 +37,8 @@
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/nmi.h>
+#undef CREATE_TRACE_POINTS
+#include <asm/trace/irq_vectors.h>
 
 struct nmi_desc {
 	raw_spinlock_t lock;
@@ -514,12 +516,14 @@ do_nmi(struct pt_regs *regs, long error_code)
 #endif
 
 	nmi_enter();
+	trace_nmi_entry(2);
 
 	inc_irq_stat(__nmi_count);
 
 	if (!ignore_nmis)
 		default_do_nmi(regs);
 
+	trace_nmi_exit(2);
 	nmi_exit();
 
 #ifdef CONFIG_X86_64
-- 
2.19.0

