Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60394C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FF121655
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563167563;
	bh=/wxCnYPLVwdT4cpAyKbsmDxPrplVMFkeyF1ByHZlUCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e+FyFzKIgAdWn1mC4guCaXOoPOpYWmIvbCa1tHKhaQ18ZWYMBxerCZvePtu09DVEu
	 jajcM/096N1tyrsT01fbTUstrasBqjpV/Ezxo5Er336Y4xOo1xU6tVCeaf6D/4D+ZH
	 YFKbGtiHZGW7yDCBto5EheEyk1DI18dHmOav34tc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfGOFMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 01:12:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfGOFMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 01:12:41 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A043E20C01;
        Mon, 15 Jul 2019 05:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563167559;
        bh=/wxCnYPLVwdT4cpAyKbsmDxPrplVMFkeyF1ByHZlUCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zO2mEFoBMsiFr5PhG4UOtZi4bmlDi1WnMMr9KYbIUrB/y+TAIwnncRMUD9EKN+TWC
         Q3oHnw69a33dntdnG/LM15QN9KgF5Ki3TuxgJuoiaYwTucwTqqNgF8CdmVLlYK9txF
         tjuCJqo8fHE2tHJkiisdCCUGgb/FlDAVyBuz8QKY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Tim Bird <Tim.Bird@sony.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC PATCH v2 08/15] tracing: of: Add setup tracing by devicetree support
Date:   Mon, 15 Jul 2019 14:12:34 +0900
Message-Id: <156316755387.23477.7274354465259652846.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156316746861.23477.5815110570539190650.stgit@devnote2>
References: <156316746861.23477.5815110570539190650.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setup tracing options by devicetree instead of kernel parameters.

Since the kernel parameter is limited length, sometimes there is
no space to setup the tracing options. This will read the tracing
options from devicetree "ftrace" node and setup tracers at boot.

Note that this is not replacing the kernel parameters, because
this devicetree based setting is later than that. If you want to
trace earlier boot events, you still need kernel parameters.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
  Changes in v2:
    - Move ftrace node under chosen node.
    - Make events property available only when CONFIG_EVENT_TRACING=y
---
 kernel/trace/Kconfig    |   10 +++
 kernel/trace/Makefile   |    1 
 kernel/trace/trace.c    |   38 ++++++++----
 kernel/trace/trace_of.c |  150 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 186 insertions(+), 13 deletions(-)
 create mode 100644 kernel/trace/trace_of.c

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 07d22c61b634..025198bb2764 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -796,6 +796,16 @@ config GCOV_PROFILE_FTRACE
 	  Note that on a kernel compiled with this config, ftrace will
 	  run significantly slower.
 
+config OF_TRACING
+	bool "Boot Trace Programming by Devicetree"
+	depends on OF && TRACING
+	select OF_EARLY_FLATTREE
+	default y
+	help
+	  Enable developer to setup ftrace subsystem via devicetree
+	  at boot time for debugging (tracing) driver initialization
+	  and boot process.
+
 endif # FTRACE
 
 endif # TRACING_SUPPORT
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index c2b2148bb1d2..6f68271f5c56 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -82,6 +82,7 @@ endif
 obj-$(CONFIG_DYNAMIC_EVENTS) += trace_dynevent.o
 obj-$(CONFIG_PROBE_EVENTS) += trace_probe.o
 obj-$(CONFIG_UPROBE_EVENTS) += trace_uprobe.o
+obj-$(CONFIG_OF_TRACING) += trace_of.o
 
 obj-$(CONFIG_TRACEPOINT_BENCHMARK) += trace_benchmark.o
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 30f09c058f79..6f50c58a3ad4 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -158,7 +158,7 @@ union trace_eval_map_item {
 static union trace_eval_map_item *trace_eval_maps;
 #endif /* CONFIG_TRACE_EVAL_MAP_FILE */
 
-static int tracing_set_tracer(struct trace_array *tr, const char *buf);
+int tracing_set_tracer(struct trace_array *tr, const char *buf);
 static void ftrace_trace_userstack(struct ring_buffer *buffer,
 				   unsigned long flags, int pc);
 
@@ -178,6 +178,11 @@ static int __init set_cmdline_ftrace(char *str)
 }
 __setup("ftrace=", set_cmdline_ftrace);
 
+void __init trace_init_dump_on_oops(int mode)
+{
+	ftrace_dump_on_oops = mode;
+}
+
 static int __init set_ftrace_dump_on_oops(char *str)
 {
 	if (*str++ != '=' || !*str) {
@@ -4614,7 +4619,7 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 	return 0;
 }
 
-static int trace_set_options(struct trace_array *tr, char *option)
+int trace_set_options(struct trace_array *tr, char *option)
 {
 	char *cmp;
 	int neg = 0;
@@ -5505,8 +5510,8 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 	return ret;
 }
 
-static ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
-					  unsigned long size, int cpu_id)
+ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
+				  unsigned long size, int cpu_id)
 {
 	int ret = size;
 
@@ -5585,7 +5590,7 @@ static void add_tracer_options(struct trace_array *tr, struct tracer *t)
 	create_trace_option_files(tr, t);
 }
 
-static int tracing_set_tracer(struct trace_array *tr, const char *buf)
+int tracing_set_tracer(struct trace_array *tr, const char *buf)
 {
 	struct tracer *t;
 #ifdef CONFIG_TRACER_MAX_TRACE
@@ -9160,16 +9165,23 @@ __init static int tracer_alloc_buffers(void)
 	return ret;
 }
 
+void __init trace_init_tracepoint_printk(void)
+{
+	tracepoint_printk = 1;
+
+	tracepoint_print_iter =
+		kmalloc(sizeof(*tracepoint_print_iter), GFP_KERNEL);
+	if (WARN_ON(!tracepoint_print_iter))
+		tracepoint_printk = 0;
+	else
+		static_key_enable(&tracepoint_printk_key.key);
+}
+
 void __init early_trace_init(void)
 {
-	if (tracepoint_printk) {
-		tracepoint_print_iter =
-			kmalloc(sizeof(*tracepoint_print_iter), GFP_KERNEL);
-		if (WARN_ON(!tracepoint_print_iter))
-			tracepoint_printk = 0;
-		else
-			static_key_enable(&tracepoint_printk_key.key);
-	}
+	if (tracepoint_printk)
+		trace_init_tracepoint_printk();
+
 	tracer_alloc_buffers();
 }
 
diff --git a/kernel/trace/trace_of.c b/kernel/trace/trace_of.c
new file mode 100644
index 000000000000..5e108a1d5bb3
--- /dev/null
+++ b/kernel/trace/trace_of.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * trace_of.c
+ * devicetree tracing programming APIs
+ */
+
+#define pr_fmt(fmt)	"trace_of: " fmt
+
+#include <linux/ftrace.h>
+#include <linux/init.h>
+#include <linux/of.h>
+
+#include "trace.h"
+
+#define MAX_BUF_LEN 256
+
+extern int trace_set_options(struct trace_array *tr, char *option);
+extern enum ftrace_dump_mode ftrace_dump_on_oops;
+extern int __disable_trace_on_warning;
+extern int tracing_set_tracer(struct trace_array *tr, const char *buf);
+extern void __init trace_init_tracepoint_printk(void);
+extern ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
+					  unsigned long size, int cpu_id);
+
+static void __init
+trace_of_set_ftrace_options(struct trace_array *tr, struct device_node *node)
+{
+	struct property *prop;
+	const char *p;
+	char buf[MAX_BUF_LEN];
+	u32 v = 0;
+	int err;
+
+	/* Common ftrace options */
+	of_property_for_each_string(node, "options", prop, p) {
+		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf)) {
+			pr_err("String is too long: %s\n", p);
+			continue;
+		}
+
+		if (trace_set_options(tr, buf) < 0)
+			pr_err("Failed to set option: %s\n", buf);
+	}
+
+	err = of_property_read_string(node, "trace-clock", &p);
+	if (!err) {
+		if (tracing_set_clock(tr, p) < 0)
+			pr_err("Failed to set trace clock: %s\n", p);
+	}
+
+	/* Command line boot options */
+	if (of_find_property(node, "dump-on-oops", NULL)) {
+		err = of_property_read_u32_index(node, "dump-on-oops", 0, &v);
+		if (err || v == 1)
+			ftrace_dump_on_oops = DUMP_ALL;
+		else if (!err && v == 2)
+			ftrace_dump_on_oops = DUMP_ORIG;
+	}
+
+	if (of_find_property(node, "traceoff-on-warning", NULL))
+		__disable_trace_on_warning = 1;
+
+	if (of_find_property(node, "tp-printk", NULL))
+		trace_init_tracepoint_printk();
+
+	/* This accepts per-cpu buffer size in KB */
+	err = of_property_read_u32_index(node, "buffer-size-kb", 0, &v);
+	if (!err) {
+		v <<= 10;	/* KB to Byte */
+		if (v < PAGE_SIZE)
+			pr_err("Buffer size is too small: %d KB\n", v >> 10);
+		if (tracing_resize_ring_buffer(tr, v, RING_BUFFER_ALL_CPUS) < 0)
+			pr_err("Failed to resize trace buffer to %d KB\n",
+				v >> 10);
+	}
+
+	if (of_find_property(node, "alloc-snapshot", NULL))
+		if (tracing_alloc_snapshot() < 0)
+			pr_err("Failed to allocate snapshot buffer\n");
+}
+
+#ifdef CONFIG_EVENT_TRACING
+extern int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
+
+static void __init
+trace_of_enable_events(struct trace_array *tr, struct device_node *node)
+{
+	struct property *prop;
+	char buf[MAX_BUF_LEN];
+	const char *p;
+
+	of_property_for_each_string(node, "events", prop, p) {
+		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf)) {
+			pr_err("String is too long: %s\n", p);
+			continue;
+		}
+
+		if (ftrace_set_clr_event(tr, buf, 1) < 0)
+			pr_err("Failed to enable event: %s\n", p);
+	}
+}
+#else
+#define trace_of_enable_events(tr, node) do {} while (0)
+#endif
+
+static void __init
+trace_of_enable_tracer(struct trace_array *tr, struct device_node *node)
+{
+	const char *p;
+
+	if (!of_property_read_string(node, "tracer", &p)) {
+		if (tracing_set_tracer(tr, p) < 0)
+			pr_err("Failed to set given tracer: %s\n", p);
+
+	}
+}
+
+static struct device_node * __init trace_of_find_ftrace_node(void)
+{
+	if (!of_chosen)
+		return NULL;
+
+	return of_find_node_by_name(of_chosen, "linux,ftrace");
+}
+
+static int __init trace_of_init(void)
+{
+	struct device_node *trace_node;
+	struct trace_array *tr;
+
+	trace_node = trace_of_find_ftrace_node();
+	if (!trace_node)
+		return 0;
+
+	trace_node = of_node_get(trace_node);
+
+	tr = top_trace_array();
+	if (!tr)
+		goto end;
+
+	trace_of_set_ftrace_options(tr, trace_node);
+	trace_of_enable_events(tr, trace_node);
+	trace_of_enable_tracer(tr, trace_node);
+
+end:
+	of_node_put(trace_node);
+	return 0;
+}
+
+fs_initcall(trace_of_init);

