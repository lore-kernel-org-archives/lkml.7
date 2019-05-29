Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDF8C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D222070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfE2JkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:40:07 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:52620 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbfE2JkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:40:07 -0400
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 May 2019 05:40:04 EDT
Received: from faui03f.informatik.uni-erlangen.de (faui03f.informatik.uni-erlangen.de [IPv6:2001:638:a000:4130:131:188:30:118])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 4C7FF241306;
        Wed, 29 May 2019 11:33:25 +0200 (CEST)
Received: by faui03f.informatik.uni-erlangen.de (Postfix, from userid 30501)
        id 38749341CD4; Wed, 29 May 2019 11:33:25 +0200 (CEST)
From:   Thomas Preisner <linux@tpreisner.de>
Cc:     linux@tpreisner.de, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ftrace: add simple oneshot function tracer
Date:   Wed, 29 May 2019 11:31:23 +0200
Message-Id: <20190529093124.2872-1-linux@tpreisner.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "oneshot" tracer records every address (ip, parent_ip) exactly once.
As a result, "oneshot" can be used to efficiently create kernel function
coverage/usage reports such as in undertaker-tailor[0].

In order to provide this functionality, "oneshot" uses a
configurable hashset for blacklisting already recorded addresses. This
way, no user space application is required to parse the function
tracer's output and to deactivate functions after they have been
recorded once. Additionally, the tracer's output is reduced to a bare
mininum so that it can be passed directly to undertaker-tailor.

Further information regarding this oneshot function tracer can also be
found at [1].

[0]: https://undertaker.cs.fau.de
[1]: https://tpreisner.de/pub/ba-thesis.pdf

Signed-off-by: Thomas Preisner <linux@tpreisner.de>
---
 Documentation/trace/ftrace.rst |   7 ++
 kernel/trace/Kconfig           |  68 ++++++++++
 kernel/trace/Makefile          |   1 +
 kernel/trace/trace.h           |   4 +
 kernel/trace/trace_entries.h   |  13 ++
 kernel/trace/trace_oneshot.c   | 220 +++++++++++++++++++++++++++++++++
 kernel/trace/trace_selftest.c  |  38 ++++++
 7 files changed, 351 insertions(+)
 create mode 100644 kernel/trace/trace_oneshot.c

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index f60079259669..ee56d9f9b246 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -759,6 +759,13 @@ Here is the list of current tracers that may be configured.
 	unlikely branch is hit and if it was correct in its prediction
 	of being correct.
 
+  "oneshot"
+
+	Traces every kernel function and originating address exactly
+	once. For kernel modules the offset together with the module
+	name is printed. As a result, this tracer can be used to
+	efficiently create kernel function coverage/usage reports.
+
   "nop"
 
 	This is the "trace nothing" tracer. To remove all
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 5d965cef6c77..3b5c2650763a 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -279,6 +279,74 @@ config HWLAT_TRACER
 	 file. Every time a latency is greater than tracing_thresh, it will
 	 be recorded into the ring buffer.
 
+menuconfig ONESHOT_TRACER
+	bool "Oneshot Function Tracer"
+	default n
+	depends on HAVE_FUNCTION_TRACER
+	select GENERIC_TRACER
+	help
+	  This tracer records every function call (and callee) exactly once per
+	  cpu. It uses a separate hashtable for each cpu core to keep track of
+	  already recorded functions.
+
+	  Very useful for efficiently creating kernel function coverage/usage
+	  reports. Can also be used for mostly automated kernel-tailoring in
+	  conjunction with the undertaker toolchain as this tracer produces
+	  significantly less output in comparison to the normal function
+	  tracer.
+
+	  If unsure, say N.
+
+if ONESHOT_TRACER
+
+config ONESHOT_HASHTABLE_DYNAMIC_ALLOC
+	bool "Dynamic Hashtable Allocation"
+	default y
+	help
+	  When this is enabled (default) the oneshot tracer will try to allocate
+	  memory for one hashtable per cpu. This method should always work but
+	  might not be the most efficient way as vmalloc only allocates a
+	  contiguous memory region in the virtual address space instead of the
+	  physical one.
+
+	  When this is disabled the oneshot tracer will use static allocation to
+	  allocate memory for NR_CPUS hashtables. Keep in mind that this will
+	  drastically increase the size of the compiled kernel and may even succeed
+	  the kernel size restrictions thus failing the build. If that happens you
+	  may decrease NR_CPUS to a more fitting value as it is not possible to
+	  detect the exact amount of cpu cores beforehand.
+
+	  If unsure, say Y.
+
+config ONESHOT_HASHTABLE_BUCKET_COUNT
+	int "Hashtable bucket count"
+	default 24
+	help
+	  Sets the hashtable bucket count to be reserved for every cpu core.
+
+	  Be aware that this value represents magnitudes of 2 so increasing this
+	  number results in a much higher memory usage.
+
+	  If unsure, keep the default.
+
+config ONESHOT_HASHTABLE_ELEMENT_COUNT
+	int "Hashtable element count"
+	default 500000
+	help
+	  Sets the hashtable element count to be reserved for every cpu core.
+
+	  Depending on how many kernel features you have selected it might be
+	  useful to increase this number to be able to memorize more already
+	  visited function to decrease the generated output.
+
+	  Be aware that this number determines a huge amount of memory to be
+	  reserved for the hashtables so increasing this will result in a higher
+	  memory usage.
+
+	  If unsure, keep the default.
+
+endif # ONESHOT_TRACER
+
 config ENABLE_DEFAULT_TRACERS
 	bool "Trace process context switches and events"
 	depends on !GENERIC_TRACER
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index c2b2148bb1d2..25b66b759bd8 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_IRQSOFF_TRACER) += trace_irqsoff.o
 obj-$(CONFIG_PREEMPT_TRACER) += trace_irqsoff.o
 obj-$(CONFIG_SCHED_TRACER) += trace_sched_wakeup.o
 obj-$(CONFIG_HWLAT_TRACER) += trace_hwlat.o
+obj-$(CONFIG_ONESHOT_TRACER) += trace_oneshot.o
 obj-$(CONFIG_NOP_TRACER) += trace_nop.o
 obj-$(CONFIG_STACK_TRACER) += trace_stack.o
 obj-$(CONFIG_MMIOTRACE) += trace_mmiotrace.o
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 005f08629b8b..e1e1d28a2914 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -40,6 +40,7 @@ enum trace_type {
 	TRACE_BLK,
 	TRACE_BPUTS,
 	TRACE_HWLAT,
+	TRACE_ONESHOT,
 	TRACE_RAW_DATA,
 
 	__TRACE_LAST_TYPE,
@@ -398,6 +399,7 @@ extern void __ftrace_bad_type(void);
 		IF_ASSIGN(var, ent, struct bprint_entry, TRACE_BPRINT);	\
 		IF_ASSIGN(var, ent, struct bputs_entry, TRACE_BPUTS);	\
 		IF_ASSIGN(var, ent, struct hwlat_entry, TRACE_HWLAT);	\
+		IF_ASSIGN(var, ent, struct oneshot_entry, TRACE_ONESHOT);\
 		IF_ASSIGN(var, ent, struct raw_data_entry, TRACE_RAW_DATA);\
 		IF_ASSIGN(var, ent, struct trace_mmiotrace_rw,		\
 			  TRACE_MMIO_RW);				\
@@ -828,6 +830,8 @@ extern int trace_selftest_startup_preemptirqsoff(struct tracer *trace,
 						 struct trace_array *tr);
 extern int trace_selftest_startup_wakeup(struct tracer *trace,
 					 struct trace_array *tr);
+extern int trace_selftest_startup_oneshot(struct tracer *trace,
+					  struct trace_array *tr);
 extern int trace_selftest_startup_nop(struct tracer *trace,
 					 struct trace_array *tr);
 extern int trace_selftest_startup_branch(struct tracer *trace,
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index fc8e97328e54..fbf3c813721f 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -366,3 +366,16 @@ FTRACE_ENTRY(hwlat, hwlat_entry,
 
 	FILTER_OTHER
 );
+
+FTRACE_ENTRY(oneshot, oneshot_entry,
+
+	TRACE_ONESHOT,
+
+	F_STRUCT(
+		__field(	unsigned long,	ip	)
+	),
+
+	F_printk("%lx\n", __entry->ip),
+
+	FILTER_OTHER
+);
diff --git a/kernel/trace/trace_oneshot.c b/kernel/trace/trace_oneshot.c
new file mode 100644
index 000000000000..931925aff20b
--- /dev/null
+++ b/kernel/trace/trace_oneshot.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * oneshot tracer
+ *
+ * Copyright (C) 2019 Thomas Preisner <linux@tpreisner.de>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/ftrace.h>
+#include <linux/hashtable.h>
+#include <linux/percpu.h>
+
+#include "trace.h"
+#include "trace_output.h"
+
+#ifdef CONFIG_ONESHOT_TRACER
+
+static struct trace_array	*oneshot_trace;
+
+struct ip_entry {
+	unsigned long address;
+	struct hlist_node next;
+};
+
+struct oneshot_hashtable {
+	DECLARE_HASHTABLE(functions, CONFIG_ONESHOT_HASHTABLE_BUCKET_COUNT);
+	int size;
+	struct ip_entry elements[CONFIG_ONESHOT_HASHTABLE_ELEMENT_COUNT];
+};
+
+static DEFINE_PER_CPU(struct oneshot_hashtable *, visited);
+#ifndef CONFIG_ONESHOT_HASHTABLE_DYNAMIC_ALLOC
+static oneshot_hashtable visited_functions[NR_CPUS];
+#endif /* CONFIG_ONESHOT_HASHTABLE_DYNAMIC_ALLOC */
+
+
+/*
+ * returns true if value has been inserted or if hashtable is full
+ */
+static inline bool
+oneshot_lookup_and_insert(struct oneshot_hashtable *curr_visited,
+			  unsigned long address)
+{
+	struct ip_entry *entry;
+
+	hash_for_each_possible(curr_visited->functions, entry, next, address) {
+		if (entry->address == address)
+			return false;
+	}
+
+	if (curr_visited->size >= CONFIG_ONESHOT_HASHTABLE_ELEMENT_COUNT)
+		return true;
+
+	entry = &curr_visited->elements[curr_visited->size++];
+	entry->address = address;
+
+	hash_add(curr_visited->functions, &entry->next, address);
+
+	return true;
+}
+
+static void trace_oneshot(struct trace_array *tr, unsigned long ip)
+{
+	struct trace_event_call *call = &event_oneshot;
+	struct ring_buffer *buffer = tr->trace_buffer.buffer;
+	struct ring_buffer_event *event;
+	struct oneshot_entry *entry;
+
+	event = trace_buffer_lock_reserve(buffer, TRACE_ONESHOT, sizeof(*entry),
+					  0, 0);
+	if (!event)
+		return;
+
+	entry = ring_buffer_event_data(event);
+	entry->ip = ip;
+
+	if (!call_filter_check_discard(call, entry, buffer, event))
+		trace_buffer_unlock_commit_nostack(buffer, event);
+}
+
+static void
+oneshot_tracer_call(unsigned long ip, unsigned long parent_ip,
+		    struct ftrace_ops *op, struct pt_regs *pt_regs)
+{
+	struct trace_array *tr = op->private;
+	struct oneshot_hashtable *curr_visited;
+
+	if (unlikely(!tr->function_enabled))
+		return;
+
+	preempt_disable_notrace();
+	curr_visited = this_cpu_read(visited);
+
+	if (oneshot_lookup_and_insert(curr_visited, ip))
+		trace_oneshot(oneshot_trace, ip);
+
+	if (oneshot_lookup_and_insert(curr_visited, parent_ip))
+		trace_oneshot(oneshot_trace, parent_ip);
+
+	preempt_enable_notrace();
+}
+
+static int start_oneshot_tracer(struct trace_array *tr)
+{
+	int ret;
+
+	if (unlikely(tr->function_enabled))
+		return 0;
+
+	ret = register_ftrace_function(tr->ops);
+	if (!ret)
+		tr->function_enabled = 1;
+
+	return ret;
+}
+
+static void stop_oneshot_tracer(struct trace_array *tr)
+{
+	if (unlikely(!tr->function_enabled))
+		return;
+
+	unregister_ftrace_function(tr->ops);
+	tr->function_enabled = 0;
+}
+
+static int oneshot_trace_init(struct trace_array *tr)
+{
+	int cpu;
+
+	oneshot_trace = tr;
+
+	for_each_possible_cpu(cpu) {
+#ifdef CONFIG_ONESHOT_HASHTABLE_DYNAMIC_ALLOC
+		struct oneshot_hashtable *tmp;
+
+		tmp = vmalloc(sizeof(struct oneshot_hashtable));
+		if (!tmp)
+			return 1;
+
+		per_cpu(visited, cpu) = tmp;
+#else
+		per_cpu(visited, cpu) = &visited_functions[cpu];
+#endif /* CONFIG_ONESHOT_HASHTABLE_DYNAMIC_ALLOC */
+
+		per_cpu(visited, cpu)->size = 0;
+		hash_init(per_cpu(visited, cpu)->functions);
+	}
+
+	ftrace_init_array_ops(tr, oneshot_tracer_call);
+
+	start_oneshot_tracer(tr);
+	return 0;
+}
+
+static void oneshot_trace_reset(struct trace_array *tr)
+{
+	int cpu;
+
+	stop_oneshot_tracer(tr);
+	ftrace_reset_array_ops(tr);
+
+	for_each_possible_cpu(cpu) {
+		vfree(per_cpu(visited, cpu));
+	}
+}
+
+static void oneshot_print_header(struct seq_file *s)
+{
+	// do not print anything!
+}
+
+static enum print_line_t oneshot_print_line(struct trace_iterator *iter)
+{
+	struct trace_seq *s = &iter->seq;
+	struct trace_entry *entry = iter->ent;
+	struct oneshot_entry *field;
+	struct module *mod;
+
+	trace_assign_type(field, entry);
+
+	mod = __module_address(field->ip);
+	if (mod) {
+		unsigned long addr;
+
+		addr = field->ip - (unsigned long) mod->core_layout.base;
+		trace_seq_printf(s, "%lx %s\n", addr, mod->name);
+	} else {
+		trace_seq_printf(s, "%lx\n", field->ip);
+	}
+
+	return trace_handle_return(s);
+}
+
+struct tracer oneshot_tracer __read_mostly = {
+	.name		= "oneshot",
+	.init		= oneshot_trace_init,
+	.reset		= oneshot_trace_reset,
+	.print_header	= oneshot_print_header,
+	.print_line	= oneshot_print_line,
+#ifdef CONFIG_FTRACE_SELFTEST
+	.selftest	= trace_selftest_startup_oneshot,
+#endif
+	.allow_instances = true,
+};
+
+
+__init static int init_oneshot_tracer(void)
+{
+	int ret;
+
+	ret = register_tracer(&oneshot_tracer);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+core_initcall(init_oneshot_tracer);
+#endif /* CONFIG_ONESHOT_TRACER */
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 69ee8ef12cee..95449ecfaca7 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -1028,6 +1028,44 @@ trace_selftest_startup_preemptirqsoff(struct tracer *trace, struct trace_array *
 }
 #endif /* CONFIG_IRQSOFF_TRACER && CONFIG_PREEMPT_TRACER */
 
+#ifdef CONFIG_ONESHOT_TRACER
+__init int
+trace_selftest_startup_oneshot(struct tracer *trace, struct trace_array *tr)
+{
+	unsigned long count;
+	int ret;
+
+	/* make sure msleep has been recorded */
+	msleep(1);
+
+	/* start the tracing */
+	ret = tracer_init(trace, tr);
+	if (ret) {
+		warn_failed_init_tracer(trace, ret);
+		return ret;
+	}
+
+	/* Sleep for a 1/10 of a second */
+	msleep(100);
+
+	/* stop the tracing. */
+	tracing_stop();
+
+	/* check the trace buffer */
+	ret = trace_test_buffer(&tr->trace_buffer, &count);
+
+	trace->reset(tr);
+	tracing_start();
+
+	if (!ret && !count) {
+		printk(KERN_CONT ".. no entries found ..");
+		ret = -1;
+	}
+
+	return ret;
+}
+#endif /* CONFIG_ONESHOT_TRACER */
+
 #ifdef CONFIG_NOP_TRACER
 int
 trace_selftest_startup_nop(struct tracer *trace, struct trace_array *tr)
-- 
2.19.1

