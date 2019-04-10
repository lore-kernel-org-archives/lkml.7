Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880BBC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61388218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbfDJLG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:06:27 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59031 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731204AbfDJLGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:06:24 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hEB3d-0005Gj-Bz; Wed, 10 Apr 2019 13:06:22 +0200
Message-Id: <20190410103647.205989744@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 10 Apr 2019 12:28:34 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>
Subject: [RFC patch 40/41] stacktrace: Remove obsolete functions
References: <20190410102754.387743324@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No more users of the struct stack_trace based interfaces. Remove them.

Remove the macro stubs for !CONFIG_STACKTRACE as well as they are pointless
because the storage on the call sites is conditional on CONFIG_STACKTRACE
already. No point to be 'smart'.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/stacktrace.h |   46 +++++++++++++++------------------------------
 kernel/stacktrace.c        |   14 -------------
 2 files changed, 16 insertions(+), 44 deletions(-)

--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -8,23 +8,6 @@ struct task_struct;
 struct pt_regs;
 
 #ifdef CONFIG_STACKTRACE
-struct stack_trace {
-	unsigned int nr_entries, max_entries;
-	unsigned long *entries;
-	int skip;	/* input argument: How many entries to skip */
-};
-
-extern void save_stack_trace(struct stack_trace *trace);
-extern void save_stack_trace_regs(struct pt_regs *regs,
-				  struct stack_trace *trace);
-extern void save_stack_trace_tsk(struct task_struct *tsk,
-				struct stack_trace *trace);
-extern int save_stack_trace_tsk_reliable(struct task_struct *tsk,
-					 struct stack_trace *trace);
-
-extern void print_stack_trace(struct stack_trace *trace, int spaces);
-extern int snprint_stack_trace(char *buf, size_t size,
-			struct stack_trace *trace, int spaces);
 
 extern void stack_trace_print(unsigned long *trace, unsigned int nr_entries,
 			      int spaces);
@@ -43,20 +26,23 @@ extern unsigned int stack_trace_save_reg
 extern unsigned int stack_trace_save_user(unsigned long *store,
 					  unsigned int size,
 					  unsigned int skipnr);
+/*
+ * The below is for stack trace internals and architecture
+ * implementations. Do not use in generic code.
+ */
+struct stack_trace {
+	unsigned int nr_entries, max_entries;
+	unsigned long *entries;
+	int skip;	/* input argument: How many entries to skip */
+};
 
-#ifdef CONFIG_USER_STACKTRACE_SUPPORT
+extern void save_stack_trace(struct stack_trace *trace);
+extern void save_stack_trace_regs(struct pt_regs *regs,
+				  struct stack_trace *trace);
+extern void save_stack_trace_tsk(struct task_struct *tsk,
+				struct stack_trace *trace);
+extern int save_stack_trace_tsk_reliable(struct task_struct *tsk,
+					 struct stack_trace *trace);
 extern void save_stack_trace_user(struct stack_trace *trace);
-#else
-# define save_stack_trace_user(trace)              do { } while (0)
-#endif
-
-#else /* !CONFIG_STACKTRACE */
-# define save_stack_trace(trace)			do { } while (0)
-# define save_stack_trace_tsk(tsk, trace)		do { } while (0)
-# define save_stack_trace_user(trace)			do { } while (0)
-# define print_stack_trace(trace, spaces)		do { } while (0)
-# define snprint_stack_trace(buf, size, trace, spaces)	do { } while (0)
-# define save_stack_trace_tsk_reliable(tsk, trace)	({ -ENOSYS; })
-#endif /* CONFIG_STACKTRACE */
 
 #endif /* __LINUX_STACKTRACE_H */
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -30,12 +30,6 @@ void stack_trace_print(unsigned long *en
 }
 EXPORT_SYMBOL_GPL(stack_trace_print);
 
-void print_stack_trace(struct stack_trace *trace, int spaces)
-{
-	stack_trace_print(trace->entries, trace->nr_entries, spaces);
-}
-EXPORT_SYMBOL_GPL(print_stack_trace);
-
 /**
  * stack_trace_snprint - Print the entries in the stack trace into a buffer
  * @buf:	Pointer to the print buffer
@@ -70,14 +64,6 @@ int stack_trace_snprint(char *buf, size_
 }
 EXPORT_SYMBOL_GPL(stack_trace_snprint);
 
-int snprint_stack_trace(char *buf, size_t size,
-			struct stack_trace *trace, int spaces)
-{
-	return stack_trace_snprint(buf, size, trace->entries,
-				   trace->nr_entries, spaces);
-}
-EXPORT_SYMBOL_GPL(snprint_stack_trace);
-
 /*
  * Architectures that do not implement save_stack_trace_*()
  * get these weak aliases and once-per-bootup warnings


