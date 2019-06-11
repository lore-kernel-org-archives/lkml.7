Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F9DC468B3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 20:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF102175B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 20:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391973AbfFKUeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 16:34:13 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:41628 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391943AbfFKUeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 16:34:13 -0400
Received: from faui03f.informatik.uni-erlangen.de (faui03f.informatik.uni-erlangen.de [IPv6:2001:638:a000:4130:131:188:30:118])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 2364F241863;
        Tue, 11 Jun 2019 22:34:09 +0200 (CEST)
Received: by faui03f.informatik.uni-erlangen.de (Postfix, from userid 30501)
        id 19E82341CD4; Tue, 11 Jun 2019 22:34:09 +0200 (CEST)
From:   Thomas Preisner <linux@tpreisner.de>
Cc:     linux@tpreisner.de, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ftrace: add simple oneshot function profiler
Date:   Tue, 11 Jun 2019 22:33:12 +0200
Message-Id: <20190611203312.13653-2-linux@tpreisner.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190529104552.146fa97c@oasis.local.home>
References: <20190529104552.146fa97c@oasis.local.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "oneshot" profiler records every address (ip, parent_ip) exactly once.
As a result, "oneshot" can be used to efficiently create kernel function
coverage/usage reports such as in undertaker-tailor[0].

In order to provide this functionality, "oneshot" uses a configurable
hashset for blacklisting already recorded addresses. This way, no user
space application is required to parse the function profilers's output
and to deactivate functions after they have been recorded once.
Additionally, the profilers's output is reduced to a bare mininum so
that it can be passed directly to undertaker-tailor.

Further information regarding this one oneshot function tracer can also
be found at [1].

[0]: https://i4gerrit.informatik.uni-erlangen.de/undertaker.git
[1]: https://tpreisner.de/pub/ba-thesis.pdf

Signed-off-by: Thomas Preisner <linux@tpreisner.de>
---
 kernel/trace/Kconfig         |  66 ++++++++++++++
 kernel/trace/Makefile        |   1 +
 kernel/trace/trace_oneshot.c | 165 +++++++++++++++++++++++++++++++++++
 3 files changed, 232 insertions(+)
 create mode 100644 kernel/trace/trace_oneshot.c

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 5d965cef6c77..91c03881c4c7 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -279,6 +279,72 @@ config HWLAT_TRACER
 	 file. Every time a latency is greater than tracing_thresh, it will
 	 be recorded into the ring buffer.
 
+menuconfig ONESHOT_PROFILER
+	bool "Oneshot Function Profiler"
+	default n
+	depends on HAVE_FUNCTION_TRACER
+	select GENERIC_TRACER
+	help
+	  This profiler records every function call (and callee) exactly once per cpu
+	  core by using a separate hashtable for each cpu core to keep track of
+	  already recorded functions.
+
+	  Very useful for mostly automated kernel-tailoring in combination with the
+	  undertaker toolchain as this tracer produces significantly less output in
+	  comparison to the normal function tracer.
+
+	  If unsure, say N.
+
+if ONESHOT_PROFILER
+
+config ONESHOT_HASHTABLE_DYNAMIC_ALLOC
+	bool "Dynamic Hashtable Allocation"
+	default y
+	help
+	  When this is enabled (default) the oneshot profiler will try to allocate
+	  memory for one hashtable per cpu. This method should always work but
+	  might not be the most efficient way as vmalloc only allocates a
+	  contiguous memory region in the virtual address space instead of the
+	  physical one.
+
+	  When this is disabled the oneshot profiler will use static allocation to
+	  allocate memory for NR_CPUS hashtables. Keep in mind that this will
+	  drastically increase the size of the compiled kernel and may even succeed
+	  the kernel size restrictions, thus failing the build. If that happens you
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
+endif # ONESHOT_PROFILER
+
 config ENABLE_DEFAULT_TRACERS
 	bool "Trace process context switches and events"
 	depends on !GENERIC_TRACER
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index c2b2148bb1d2..c3ef309bcbe1 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_STACK_TRACER) += trace_stack.o
 obj-$(CONFIG_MMIOTRACE) += trace_mmiotrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += trace_functions_graph.o
 obj-$(CONFIG_TRACE_BRANCH_PROFILING) += trace_branch.o
+obj-$(CONFIG_ONESHOT_PROFILER) += trace_oneshot.o
 obj-$(CONFIG_BLK_DEV_IO_TRACE) += blktrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += fgraph.o
 ifeq ($(CONFIG_BLOCK),y)
diff --git a/kernel/trace/trace_oneshot.c b/kernel/trace/trace_oneshot.c
new file mode 100644
index 000000000000..b533c1b05632
--- /dev/null
+++ b/kernel/trace/trace_oneshot.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * oneshot profiler
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
+#include "trace_stat.h"
+
+#ifdef CONFIG_ONESHOT_PROFILER
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
+
+#ifndef CONFIG_ONESHOT_HASHTABLE_DYNAMIC_ALLOC
+static struct oneshot_hashtable visited_functions[NR_CPUS];
+#endif /* CONFIG_ONESHOT_HASHTABLE_DYNAMIC_ALLOC */
+
+static struct oneshot_hashtable output_hashset;
+
+
+static inline void
+oneshot_insert(struct oneshot_hashtable *curr_visited,
+			  unsigned long address)
+{
+	struct ip_entry *entry;
+
+	if (curr_visited->size >= CONFIG_ONESHOT_HASHTABLE_ELEMENT_COUNT)
+		return;
+
+	hash_for_each_possible(curr_visited->functions, entry, next, address) {
+		if (entry->address == address)
+			return;
+	}
+
+	entry = &curr_visited->elements[curr_visited->size++];
+	entry->address = address;
+
+	hash_add(curr_visited->functions, &entry->next, address);
+}
+
+static void
+oneshot_profile_call(unsigned long ip, unsigned long parent_ip,
+		    struct ftrace_ops *op, struct pt_regs *pt_regs)
+{
+	struct oneshot_hashtable *curr_visited;
+
+	preempt_disable_notrace();
+	curr_visited = this_cpu_read(visited);
+
+	oneshot_insert(curr_visited, ip);
+	oneshot_insert(curr_visited, parent_ip);
+
+	preempt_enable_notrace();
+}
+
+static void *oneshot_stat_start(struct tracer_stat *trace)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct oneshot_hashtable *tmp;
+		int size;
+		int i;
+
+		tmp = per_cpu(visited, cpu);
+		size = tmp->size;
+
+		for (i = 0; i < size; i++) {
+			oneshot_insert(&output_hashset,
+				       tmp->elements[i].address);
+		}
+	}
+
+	if (output_hashset.size <= 0)
+		return NULL;
+
+	return &output_hashset.elements[0].address;
+}
+
+static void *oneshot_stat_next(void *prev, int idx)
+{
+	if (output_hashset.size <= idx)
+		return NULL;
+
+	return &output_hashset.elements[idx].address;
+}
+
+static int oneshot_stat_show(struct seq_file *s, void *entry)
+{
+	unsigned long ip = *(unsigned long *)entry;
+	struct module *mod;
+
+	mod = __module_address(ip);
+	if (mod) {
+		unsigned long addr;
+
+		addr = ip - (unsigned long) mod->core_layout.base;
+		seq_printf(s, "%lx %s\n", addr, mod->name);
+	} else {
+		seq_printf(s, "%lx\n", ip);
+	}
+	return 0;
+}
+
+static struct tracer_stat oneshot_stats = {
+	.name = "oneshot",
+	.stat_start = oneshot_stat_start,
+	.stat_next = oneshot_stat_next,
+	.stat_show = oneshot_stat_show
+};
+
+static struct ftrace_ops oneshot_profile_ops __read_mostly = {
+	.func		= oneshot_profile_call,
+	.flags		= FTRACE_OPS_FL_RECURSION_SAFE,
+};
+
+static int init_oneshot_profile(void)
+{
+	int cpu;
+	int ret;
+
+	for_each_possible_cpu(cpu) {
+#ifdef CONFIG_ONESHOT_HASHTABLE_DYNAMIC_ALLOC
+		struct oneshot_hashtable *tmp;
+
+		tmp = vmalloc(sizeof(struct oneshot_hashtable));
+		if (!tmp)
+			return -ENOMEM;
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
+	ret = register_ftrace_function(&oneshot_profile_ops);
+	if (ret)
+		return ret;
+
+	return register_stat_tracer(&oneshot_stats);
+}
+
+core_initcall(init_oneshot_profile);
+#endif /* CONFIG_ONESHOT_PROFILER */
-- 
2.19.1

