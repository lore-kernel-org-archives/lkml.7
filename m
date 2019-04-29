Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF90DC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEAE216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="D7lXn/wM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbfD2SdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:33:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53789 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbfD2SdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:33:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIVuQk1027020
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:31:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIVuQk1027020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556562718;
        bh=rrAoA0GKqwZzUoJAdxzshTaqR21TMHKaY7GTqRQHKHs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=D7lXn/wMHAhhL29KWQmP58/VFIfSCuF4mRYEw2gLKI/KnbtaWlVoPjAPMNfahH8eA
         xQO2/h7ijkbDTusnqqIVoRI1falbqTUHxZ7L1Ntjm9RSLxK3yuDQuMk+TumOCufrgq
         KgPoUE/Z9DkhVcHHBQ8cUW+jOw06FxhthWgTZ2BE/yD85m2SwwWJ6vkci39WzOruTM
         Bjl9/kc2+7Ilbr92SMAJZknG/mUN1EBq4cu1wKlsxxMtt0+9vxyi8VmxhNCVDZSA4R
         UK9pjlxdveZax1kXxLIi8rEV0QDZf5IJjCfSbA1kDbl0ElHD9XPEYdUUzF3ll7d+CQ
         l1FrRITEi+42w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIVums1027016;
        Mon, 29 Apr 2019 11:31:56 -0700
Date:   Mon, 29 Apr 2019 11:31:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-e9b98e162aa53cbea7c8b0d6c9d5dc6e0f822b9c@git.kernel.org>
Cc:     luto@kernel.org, mbenes@suse.cz, rostedt@goodmis.org,
        josef@toxicpanda.com, penberg@kernel.org, tglx@linutronix.de,
        rientjes@google.com, airlied@linux.ie, dsterba@suse.com,
        joonas.lahtinen@linux.intel.com, aryabinin@virtuozzo.com,
        akpm@linux-foundation.org, tom.zanussi@linux.intel.com,
        linux-kernel@vger.kernel.org, agk@redhat.com, adobriyan@gmail.com,
        catalin.marinas@arm.com, jani.nikula@linux.intel.com,
        maarten.lankhorst@linux.intel.com, robin.murphy@arm.com,
        m.szyprowski@samsung.com, snitzer@redhat.com, daniel@ffwll.ch,
        hch@lst.de, hpa@zytor.com, jthumshirn@suse.de, mingo@kernel.org,
        rodrigo.vivi@intel.com, cl@linux.com, glider@google.com,
        rppt@linux.vnet.ibm.com, akinobu.mita@gmail.com,
        dvyukov@google.com, jpoimboe@redhat.com, clm@fb.com
Reply-To: aryabinin@virtuozzo.com, dsterba@suse.com,
          joonas.lahtinen@linux.intel.com, adobriyan@gmail.com,
          agk@redhat.com, catalin.marinas@arm.com,
          linux-kernel@vger.kernel.org, tom.zanussi@linux.intel.com,
          akpm@linux-foundation.org, rostedt@goodmis.org, mbenes@suse.cz,
          luto@kernel.org, tglx@linutronix.de, rientjes@google.com,
          airlied@linux.ie, penberg@kernel.org, josef@toxicpanda.com,
          cl@linux.com, glider@google.com, rodrigo.vivi@intel.com,
          rppt@linux.vnet.ibm.com, mingo@kernel.org, hch@lst.de,
          hpa@zytor.com, jthumshirn@suse.de, daniel@ffwll.ch, clm@fb.com,
          dvyukov@google.com, jpoimboe@redhat.com, akinobu.mita@gmail.com,
          m.szyprowski@samsung.com, maarten.lankhorst@linux.intel.com,
          robin.murphy@arm.com, jani.nikula@linux.intel.com,
          snitzer@redhat.com
In-Reply-To: <20190425094801.324810708@linutronix.de>
References: <20190425094801.324810708@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] stacktrace: Provide helpers for common stack
 trace operations
Git-Commit-ID: e9b98e162aa53cbea7c8b0d6c9d5dc6e0f822b9c
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

Commit-ID:  e9b98e162aa53cbea7c8b0d6c9d5dc6e0f822b9c
Gitweb:     https://git.kernel.org/tip/e9b98e162aa53cbea7c8b0d6c9d5dc6e0f822b9c
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:44:55 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:46 +0200

stacktrace: Provide helpers for common stack trace operations

All operations with stack traces are based on struct stack_trace. That's a
horrible construct as the struct is a kitchen sink for input and
output. Quite some usage sites embed it into their own data structures
which creates weird indirections.

There is absolutely no point in doing so. For all use cases a storage array
and the number of valid stack trace entries in the array is sufficient.

Provide helper functions which avoid the struct stack_trace indirection so
the usage sites can be cleaned up.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
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
Cc: linux-arch@vger.kernel.org
Link: https://lkml.kernel.org/r/20190425094801.324810708@linutronix.de

---
 include/linux/stacktrace.h |  27 +++++++
 kernel/stacktrace.c        | 170 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 182 insertions(+), 15 deletions(-)

diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
index ba29a0613e66..a24340b3e9e1 100644
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -3,11 +3,26 @@
 #define __LINUX_STACKTRACE_H
 
 #include <linux/types.h>
+#include <asm/errno.h>
 
 struct task_struct;
 struct pt_regs;
 
 #ifdef CONFIG_STACKTRACE
+void stack_trace_print(unsigned long *trace, unsigned int nr_entries,
+		       int spaces);
+int stack_trace_snprint(char *buf, size_t size, unsigned long *entries,
+			unsigned int nr_entries, int spaces);
+unsigned int stack_trace_save(unsigned long *store, unsigned int size,
+			      unsigned int skipnr);
+unsigned int stack_trace_save_tsk(struct task_struct *task,
+				  unsigned long *store, unsigned int size,
+				  unsigned int skipnr);
+unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *store,
+				   unsigned int size, unsigned int skipnr);
+unsigned int stack_trace_save_user(unsigned long *store, unsigned int size);
+
+/* Internal interfaces. Do not use in generic code */
 struct stack_trace {
 	unsigned int nr_entries, max_entries;
 	unsigned long *entries;
@@ -41,4 +56,16 @@ extern void save_stack_trace_user(struct stack_trace *trace);
 # define save_stack_trace_tsk_reliable(tsk, trace)	({ -ENOSYS; })
 #endif /* CONFIG_STACKTRACE */
 
+#if defined(CONFIG_STACKTRACE) && defined(CONFIG_HAVE_RELIABLE_STACKTRACE)
+int stack_trace_save_tsk_reliable(struct task_struct *tsk, unsigned long *store,
+				  unsigned int size);
+#else
+static inline int stack_trace_save_tsk_reliable(struct task_struct *tsk,
+						unsigned long *store,
+						unsigned int size)
+{
+	return -ENOSYS;
+}
+#endif
+
 #endif /* __LINUX_STACKTRACE_H */
diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index f8edee9c792d..b38333b3bc18 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -11,35 +11,54 @@
 #include <linux/kallsyms.h>
 #include <linux/stacktrace.h>
 
-void print_stack_trace(struct stack_trace *trace, int spaces)
+/**
+ * stack_trace_print - Print the entries in the stack trace
+ * @entries:	Pointer to storage array
+ * @nr_entries:	Number of entries in the storage array
+ * @spaces:	Number of leading spaces to print
+ */
+void stack_trace_print(unsigned long *entries, unsigned int nr_entries,
+		       int spaces)
 {
-	int i;
+	unsigned int i;
 
-	if (WARN_ON(!trace->entries))
+	if (WARN_ON(!entries))
 		return;
 
-	for (i = 0; i < trace->nr_entries; i++)
-		printk("%*c%pS\n", 1 + spaces, ' ', (void *)trace->entries[i]);
+	for (i = 0; i < nr_entries; i++)
+		printk("%*c%pS\n", 1 + spaces, ' ', (void *)entries[i]);
+}
+EXPORT_SYMBOL_GPL(stack_trace_print);
+
+void print_stack_trace(struct stack_trace *trace, int spaces)
+{
+	stack_trace_print(trace->entries, trace->nr_entries, spaces);
 }
 EXPORT_SYMBOL_GPL(print_stack_trace);
 
-int snprint_stack_trace(char *buf, size_t size,
-			struct stack_trace *trace, int spaces)
+/**
+ * stack_trace_snprint - Print the entries in the stack trace into a buffer
+ * @buf:	Pointer to the print buffer
+ * @size:	Size of the print buffer
+ * @entries:	Pointer to storage array
+ * @nr_entries:	Number of entries in the storage array
+ * @spaces:	Number of leading spaces to print
+ *
+ * Return: Number of bytes printed.
+ */
+int stack_trace_snprint(char *buf, size_t size, unsigned long *entries,
+			unsigned int nr_entries, int spaces)
 {
-	int i;
-	int generated;
-	int total = 0;
+	unsigned int generated, i, total = 0;
 
-	if (WARN_ON(!trace->entries))
+	if (WARN_ON(!entries))
 		return 0;
 
-	for (i = 0; i < trace->nr_entries; i++) {
+	for (i = 0; i < nr_entries && size; i++) {
 		generated = snprintf(buf, size, "%*c%pS\n", 1 + spaces, ' ',
-				     (void *)trace->entries[i]);
+				     (void *)entries[i]);
 
 		total += generated;
-
-		/* Assume that generated isn't a negative number */
 		if (generated >= size) {
 			buf += size;
 			size = 0;
@@ -51,6 +70,14 @@ int snprint_stack_trace(char *buf, size_t size,
 
 	return total;
 }
+EXPORT_SYMBOL_GPL(stack_trace_snprint);
+
+int snprint_stack_trace(char *buf, size_t size,
+			struct stack_trace *trace, int spaces)
+{
+	return stack_trace_snprint(buf, size, trace->entries,
+				   trace->nr_entries, spaces);
+}
 EXPORT_SYMBOL_GPL(snprint_stack_trace);
 
 /*
@@ -77,3 +104,116 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
 	WARN_ONCE(1, KERN_INFO "save_stack_tsk_reliable() not implemented yet.\n");
 	return -ENOSYS;
 }
+
+/**
+ * stack_trace_save - Save a stack trace into a storage array
+ * @store:	Pointer to storage array
+ * @size:	Size of the storage array
+ * @skipnr:	Number of entries to skip at the start of the stack trace
+ *
+ * Return: Number of trace entries stored
+ */
+unsigned int stack_trace_save(unsigned long *store, unsigned int size,
+			      unsigned int skipnr)
+{
+	struct stack_trace trace = {
+		.entries	= store,
+		.max_entries	= size,
+		.skip		= skipnr + 1,
+	};
+
+	save_stack_trace(&trace);
+	return trace.nr_entries;
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
+ * Return: Number of trace entries stored
+ */
+unsigned int stack_trace_save_tsk(struct task_struct *task,
+				  unsigned long *store, unsigned int size,
+				  unsigned int skipnr)
+{
+	struct stack_trace trace = {
+		.entries	= store,
+		.max_entries	= size,
+		.skip		= skipnr + 1,
+	};
+
+	save_stack_trace_tsk(task, &trace);
+	return trace.nr_entries;
+}
+
+/**
+ * stack_trace_save_regs - Save a stack trace based on pt_regs into a storage array
+ * @regs:	Pointer to pt_regs to examine
+ * @store:	Pointer to storage array
+ * @size:	Size of the storage array
+ * @skipnr:	Number of entries to skip at the start of the stack trace
+ *
+ * Return: Number of trace entries stored
+ */
+unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *store,
+				   unsigned int size, unsigned int skipnr)
+{
+	struct stack_trace trace = {
+		.entries	= store,
+		.max_entries	= size,
+		.skip		= skipnr,
+	};
+
+	save_stack_trace_regs(regs, &trace);
+	return trace.nr_entries;
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
+	struct stack_trace trace = {
+		.entries	= store,
+		.max_entries	= size,
+	};
+	int ret = save_stack_trace_tsk_reliable(tsk, &trace);
+
+	return ret ? ret : trace.nr_entries;
+}
+#endif
+
+#ifdef CONFIG_USER_STACKTRACE_SUPPORT
+/**
+ * stack_trace_save_user - Save a user space stack trace into a storage array
+ * @store:	Pointer to storage array
+ * @size:	Size of the storage array
+ *
+ * Return: Number of trace entries stored
+ */
+unsigned int stack_trace_save_user(unsigned long *store, unsigned int size)
+{
+	struct stack_trace trace = {
+		.entries	= store,
+		.max_entries	= size,
+	};
+
+	save_stack_trace_user(&trace);
+	return trace.nr_entries;
+}
+#endif /* CONFIG_USER_STACKTRACE_SUPPORT */
