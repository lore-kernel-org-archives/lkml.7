Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89972C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E722075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="NRn/9yYg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfD2SvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:51:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47379 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbfD2SvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:51:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TInl9o1031807
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:49:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TInl9o1031807
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556563788;
        bh=m4f88uF4xvwWONg2c+JLdm1USzGrlVT2FHlWybCWYRc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=NRn/9yYg5b7zAR+yD48E1empSDbO55W500SLBoidsUYPhGG4SEkIJO/FR7gWXNfAe
         9vZP4HtBCibKgpZD8iPAxH630l3yjAwsbxRsIXQukcrql+4E1gR8MjJ3Mvv9iH809S
         pP5jGxPtvUMfMpB9GdgFHVbnwZdJKkhVy/it9VIfKL1Af9gZE3hFtuJt/01+wipSop
         uZQbYqWoXFEaJ/ZCD5NFM6eoai6mEphnZh/nW48RitCUxKccqiS5KiQZ6u1bJjk8CY
         oNx3yLqQdPxzjNLC8LGmD2JntKVw/vQW9Ob76bAUtAXAxHf0FzZMoB65TQmP66pXcP
         XKECszpgC6xRw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TInkh41031803;
        Mon, 29 Apr 2019 11:49:46 -0700
Date:   Mon, 29 Apr 2019 11:49:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-214d8ca6ee854f696f75e75511fe66b409e656db@git.kernel.org>
Cc:     rppt@linux.vnet.ibm.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, josef@toxicpanda.com,
        dsterba@suse.com, agk@redhat.com, hch@lst.de,
        akpm@linux-foundation.org, mingo@kernel.org,
        joonas.lahtinen@linux.intel.com, jani.nikula@linux.intel.com,
        rientjes@google.com, cl@linux.com, rostedt@goodmis.org,
        maarten.lankhorst@linux.intel.com, penberg@kernel.org,
        tom.zanussi@linux.intel.com, aryabinin@virtuozzo.com,
        catalin.marinas@arm.com, jthumshirn@suse.de, luto@kernel.org,
        robin.murphy@arm.com, m.szyprowski@samsung.com, mbenes@suse.cz,
        clm@fb.com, hpa@zytor.com, snitzer@redhat.com, adobriyan@gmail.com,
        airlied@linux.ie, tglx@linutronix.de, rodrigo.vivi@intel.com,
        akinobu.mita@gmail.com, dvyukov@google.com, daniel@ffwll.ch,
        glider@google.com
Reply-To: snitzer@redhat.com, adobriyan@gmail.com, hpa@zytor.com,
          clm@fb.com, airlied@linux.ie, akinobu.mita@gmail.com,
          dvyukov@google.com, rodrigo.vivi@intel.com, tglx@linutronix.de,
          daniel@ffwll.ch, glider@google.com, luto@kernel.org,
          catalin.marinas@arm.com, jthumshirn@suse.de,
          robin.murphy@arm.com, m.szyprowski@samsung.com, mbenes@suse.cz,
          mingo@kernel.org, jani.nikula@linux.intel.com,
          joonas.lahtinen@linux.intel.com, rientjes@google.com,
          cl@linux.com, rostedt@goodmis.org, penberg@kernel.org,
          maarten.lankhorst@linux.intel.com, tom.zanussi@linux.intel.com,
          aryabinin@virtuozzo.com, rppt@linux.vnet.ibm.com,
          jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
          dsterba@suse.com, josef@toxicpanda.com, hch@lst.de,
          agk@redhat.com, akpm@linux-foundation.org
In-Reply-To: <20190425094803.713568606@linutronix.de>
References: <20190425094803.713568606@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] stacktrace: Provide common infrastructure
Git-Commit-ID: 214d8ca6ee854f696f75e75511fe66b409e656db
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

Commit-ID:  214d8ca6ee854f696f75e75511fe66b409e656db
Gitweb:     https://git.kernel.org/tip/214d8ca6ee854f696f75e75511fe66b409e656db
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:45:21 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:57 +0200

stacktrace: Provide common infrastructure

All architectures which support stacktrace carry duplicated code and
do the stack storage and filtering at the architecture side.

Provide a consolidated interface with a callback function for consuming the
stack entries provided by the architecture specific stack walker. This
removes lots of duplicated code and allows to implement better filtering
than 'skip number of entries' in the future without touching any
architecture specific code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: linux-arch@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: linux-mm@kvack.org
Cc: David Rientjes <rientjes@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: kasan-dev@googlegroups.com
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: David Sterba <dsterba@suse.com>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
Cc: dm-devel@redhat.com
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/20190425094803.713568606@linutronix.de

---
 include/linux/stacktrace.h |  39 ++++++++++
 kernel/stacktrace.c        | 173 +++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig                |   4 ++
 3 files changed, 216 insertions(+)

diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
index 40decfbb9a24..f0cfd12cb45e 100644
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -23,6 +23,44 @@ unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *store,
 unsigned int stack_trace_save_user(unsigned long *store, unsigned int size);
 
 /* Internal interfaces. Do not use in generic code */
+#ifdef CONFIG_ARCH_STACKWALK
+
+/**
+ * stack_trace_consume_fn - Callback for arch_stack_walk()
+ * @cookie:	Caller supplied pointer handed back by arch_stack_walk()
+ * @addr:	The stack entry address to consume
+ * @reliable:	True when the stack entry is reliable. Required by
+ *		some printk based consumers.
+ *
+ * Return:	True, if the entry was consumed or skipped
+ *		False, if there is no space left to store
+ */
+typedef bool (*stack_trace_consume_fn)(void *cookie, unsigned long addr,
+				       bool reliable);
+/**
+ * arch_stack_walk - Architecture specific function to walk the stack
+ * @consume_entry:	Callback which is invoked by the architecture code for
+ *			each entry.
+ * @cookie:		Caller supplied pointer which is handed back to
+ *			@consume_entry
+ * @task:		Pointer to a task struct, can be NULL
+ * @regs:		Pointer to registers, can be NULL
+ *
+ * ============ ======= ============================================
+ * task	        regs
+ * ============ ======= ============================================
+ * task		NULL	Stack trace from task (can be current)
+ * current	regs	Stack trace starting on regs->stackpointer
+ * ============ ======= ============================================
+ */
+void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
+		     struct task_struct *task, struct pt_regs *regs);
+int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry, void *cookie,
+			     struct task_struct *task);
+void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
+			  const struct pt_regs *regs);
+
+#else /* CONFIG_ARCH_STACKWALK */
 struct stack_trace {
 	unsigned int nr_entries, max_entries;
 	unsigned long *entries;
@@ -37,6 +75,7 @@ extern void save_stack_trace_tsk(struct task_struct *tsk,
 extern int save_stack_trace_tsk_reliable(struct task_struct *tsk,
 					 struct stack_trace *trace);
 extern void save_stack_trace_user(struct stack_trace *trace);
+#endif /* !CONFIG_ARCH_STACKWALK */
 #endif /* CONFIG_STACKTRACE */
 
 #if defined(CONFIG_STACKTRACE) && defined(CONFIG_HAVE_RELIABLE_STACKTRACE)
diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index dd55312f3fe9..27bafc1e271e 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -5,6 +5,8 @@
  *
  *  Copyright (C) 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
  */
+#include <linux/sched/task_stack.h>
+#include <linux/sched/debug.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
@@ -66,6 +68,175 @@ int stack_trace_snprint(char *buf, size_t size, unsigned long *entries,
 }
 EXPORT_SYMBOL_GPL(stack_trace_snprint);
 
+#ifdef CONFIG_ARCH_STACKWALK
+
+struct stacktrace_cookie {
+	unsigned long	*store;
+	unsigned int	size;
+	unsigned int	skip;
+	unsigned int	len;
+};
+
+static bool stack_trace_consume_entry(void *cookie, unsigned long addr,
+				      bool reliable)
+{
+	struct stacktrace_cookie *c = cookie;
+
+	if (c->len >= c->size)
+		return false;
+
+	if (c->skip > 0) {
+		c->skip--;
+		return true;
+	}
+	c->store[c->len++] = addr;
+	return c->len < c->size;
+}
+
+static bool stack_trace_consume_entry_nosched(void *cookie, unsigned long addr,
+					      bool reliable)
+{
+	if (in_sched_functions(addr))
+		return true;
+	return stack_trace_consume_entry(cookie, addr, reliable);
+}
+
+/**
+ * stack_trace_save - Save a stack trace into a storage array
+ * @store:	Pointer to storage array
+ * @size:	Size of the storage array
+ * @skipnr:	Number of entries to skip at the start of the stack trace
+ *
+ * Return: Number of trace entries stored.
+ */
+unsigned int stack_trace_save(unsigned long *store, unsigned int size,
+			      unsigned int skipnr)
+{
+	stack_trace_consume_fn consume_entry = stack_trace_consume_entry;
+	struct stacktrace_cookie c = {
+		.store	= store,
+		.size	= size,
+		.skip	= skipnr + 1,
+	};
+
+	arch_stack_walk(consume_entry, &c, current, NULL);
+	return c.len;
+}
+EXPORT_SYMBOL_GPL(stack_trace_save);
+
+/**
+ * stack_trace_save_tsk - Save a task stack trace into a storage array
+ * @task:	The task to examine
+ * @store:	Pointer to storage array
+ * @size:	Size of the storage array
+ * @skipnr:	Number of entries to skip at the start of the stack trace
+ *
+ * Return: Number of trace entries stored.
+ */
+unsigned int stack_trace_save_tsk(struct task_struct *tsk, unsigned long *store,
+				  unsigned int size, unsigned int skipnr)
+{
+	stack_trace_consume_fn consume_entry = stack_trace_consume_entry_nosched;
+	struct stacktrace_cookie c = {
+		.store	= store,
+		.size	= size,
+		.skip	= skipnr + 1,
+	};
+
+	if (!try_get_task_stack(tsk))
+		return 0;
+
+	arch_stack_walk(consume_entry, &c, tsk, NULL);
+	put_task_stack(tsk);
+	return c.len;
+}
+
+/**
+ * stack_trace_save_regs - Save a stack trace based on pt_regs into a storage array
+ * @regs:	Pointer to pt_regs to examine
+ * @store:	Pointer to storage array
+ * @size:	Size of the storage array
+ * @skipnr:	Number of entries to skip at the start of the stack trace
+ *
+ * Return: Number of trace entries stored.
+ */
+unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *store,
+				   unsigned int size, unsigned int skipnr)
+{
+	stack_trace_consume_fn consume_entry = stack_trace_consume_entry;
+	struct stacktrace_cookie c = {
+		.store	= store,
+		.size	= size,
+		.skip	= skipnr,
+	};
+
+	arch_stack_walk(consume_entry, &c, current, regs);
+	return c.len;
+}
+
+#ifdef CONFIG_HAVE_RELIABLE_STACKTRACE
+/**
+ * stack_trace_save_tsk_reliable - Save task stack with verification
+ * @tsk:	Pointer to the task to examine
+ * @store:	Pointer to storage array
+ * @size:	Size of the storage array
+ *
+ * Return:	An error if it detects any unreliable features of the
+ *		stack. Otherwise it guarantees that the stack trace is
+ *		reliable and returns the number of entries stored.
+ *
+ * If the task is not 'current', the caller *must* ensure the task is inactive.
+ */
+int stack_trace_save_tsk_reliable(struct task_struct *tsk, unsigned long *store,
+				  unsigned int size)
+{
+	stack_trace_consume_fn consume_entry = stack_trace_consume_entry;
+	struct stacktrace_cookie c = {
+		.store	= store,
+		.size	= size,
+	};
+	int ret;
+
+	/*
+	 * If the task doesn't have a stack (e.g., a zombie), the stack is
+	 * "reliably" empty.
+	 */
+	if (!try_get_task_stack(tsk))
+		return 0;
+
+	ret = arch_stack_walk_reliable(consume_entry, &c, tsk);
+	put_task_stack(tsk);
+	return ret;
+}
+#endif
+
+#ifdef CONFIG_USER_STACKTRACE_SUPPORT
+/**
+ * stack_trace_save_user - Save a user space stack trace into a storage array
+ * @store:	Pointer to storage array
+ * @size:	Size of the storage array
+ *
+ * Return: Number of trace entries stored.
+ */
+unsigned int stack_trace_save_user(unsigned long *store, unsigned int size)
+{
+	stack_trace_consume_fn consume_entry = stack_trace_consume_entry;
+	struct stacktrace_cookie c = {
+		.store	= store,
+		.size	= size,
+	};
+
+	/* Trace user stack if not a kernel thread */
+	if (!current->mm)
+		return 0;
+
+	arch_stack_walk_user(consume_entry, &c, task_pt_regs(current));
+	return c.len;
+}
+#endif
+
+#else /* CONFIG_ARCH_STACKWALK */
+
 /*
  * Architectures that do not implement save_stack_trace_*()
  * get these weak aliases and once-per-bootup warnings
@@ -203,3 +374,5 @@ unsigned int stack_trace_save_user(unsigned long *store, unsigned int size)
 	return trace.nr_entries;
 }
 #endif /* CONFIG_USER_STACKTRACE_SUPPORT */
+
+#endif /* !CONFIG_ARCH_STACKWALK */
diff --git a/lib/Kconfig b/lib/Kconfig
index a9e56539bd11..e86975bfca6a 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -597,6 +597,10 @@ config ARCH_HAS_UACCESS_FLUSHCACHE
 config ARCH_HAS_UACCESS_MCSAFE
 	bool
 
+# Temporary. Goes away when all archs are cleaned up
+config ARCH_STACKWALK
+       bool
+
 config STACKDEPOT
 	bool
 	select STACKTRACE
