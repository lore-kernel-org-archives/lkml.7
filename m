Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA97AC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CB021783
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391284AbfETOWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:22:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388913AbfETOWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:22:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C77BD21734;
        Mon, 20 May 2019 14:21:59 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hSjAs-0003Ug-Oq; Mon, 20 May 2019 10:21:58 -0400
Message-Id: <20190520142158.655759375@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 20 May 2019 10:20:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: [RFC][PATCH 14/14 v2] function_graph: Add selftest for passing local variables
References: <20190520142001.270067280@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add boot up selftest that passes variables from a function entry to a
function exit, and make sure that they do get passed around.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_selftest.c | 161 ++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index facd5d1c05e7..9318677b5bf2 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -718,6 +718,165 @@ trace_selftest_startup_function(struct tracer *trace, struct trace_array *tr)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+
+#define BYTE_NUMBER 123
+#define SHORT_NUMBER 12345
+#define WORD_NUMBER 1234567890
+#define LONG_NUMBER 1234567890123456789LL
+
+static int fgraph_store_size __initdata;
+static const char *fgraph_store_type_name __initdata;
+static char *fgraph_error_str __initdata;
+static char fgraph_error_str_buf[128] __initdata;
+
+static __init int store_entry(struct ftrace_graph_ent *trace,
+			      struct fgraph_ops *gops)
+{
+	const char *type = fgraph_store_type_name;
+	int size = fgraph_store_size;
+	void *p;
+
+	p = fgraph_reserve_data(size);
+	if (!p) {
+		snprintf(fgraph_error_str_buf, sizeof(fgraph_error_str_buf),
+			 "Failed to reserve %s\n", type);
+		fgraph_error_str = fgraph_error_str_buf;
+		return 0;
+	}
+
+	switch (fgraph_store_size) {
+	case 1:
+		*(char *)p = BYTE_NUMBER;
+		break;
+	case 2:
+		*(short *)p = SHORT_NUMBER;
+		break;
+	case 4:
+		*(int *)p = WORD_NUMBER;
+		break;
+	case 8:
+		*(long long *)p = LONG_NUMBER;
+		break;
+	}
+
+	return 1;
+}
+
+static __init void store_return(struct ftrace_graph_ret *trace,
+				struct fgraph_ops *gops)
+{
+	const char *type = fgraph_store_type_name;
+	long long expect = 0;
+	long long found = -1;
+	char *p;
+
+	p = fgraph_retrieve_data();
+	if (!p) {
+		snprintf(fgraph_error_str_buf, sizeof(fgraph_error_str_buf),
+			 "Failed to retrieve %s\n", type);
+		fgraph_error_str = fgraph_error_str_buf;
+		return;
+	}
+
+	switch (fgraph_store_size) {
+	case 1:
+		expect = BYTE_NUMBER;
+		found = *(char *)p;
+		break;
+	case 2:
+		expect = SHORT_NUMBER;
+		found = *(short *)p;
+		break;
+	case 4:
+		expect = WORD_NUMBER;
+		found = *(int *)p;
+		break;
+	case 8:
+		expect = LONG_NUMBER;
+		found = *(long long *)p;
+		break;
+	}
+
+	if (found != expect) {
+		snprintf(fgraph_error_str_buf, sizeof(fgraph_error_str_buf),
+			 "%s returned not %lld but %lld\n", type, expect, found);
+		fgraph_error_str = fgraph_error_str_buf;
+		return;
+	}
+	fgraph_error_str = NULL;
+}
+
+static struct fgraph_ops store_bytes __initdata = {
+	.entryfunc		= store_entry,
+	.retfunc		= store_return,
+};
+
+static int __init test_graph_storage_type(const char *name, int size)
+{
+	char *func_name;
+	int len;
+	int ret;
+
+	fgraph_store_type_name = name;
+	fgraph_store_size = size;
+
+	snprintf(fgraph_error_str_buf, sizeof(fgraph_error_str_buf),
+		 "Failed to execute storage %s\n", name);
+	fgraph_error_str = fgraph_error_str_buf;
+
+	printk(KERN_CONT "PASSED\n");
+	pr_info("Testing fgraph storage of %d byte%s: ", size, size > 1 ? "s" : "");
+
+	func_name = "*" __stringify(DYN_FTRACE_TEST_NAME);
+	len = strlen(func_name);
+
+	ret = ftrace_set_filter(&store_bytes.ops, func_name, len, 1);
+	if (ret && ret != -ENODEV) {
+		pr_cont("*Could not set filter* ");
+		return -1;
+	}
+
+	ret = register_ftrace_graph(&store_bytes);
+	if (ret) {
+		printk(KERN_WARNING "Failed to init store_bytes fgraph tracing\n");
+		return -1;
+	}
+
+	DYN_FTRACE_TEST_NAME();
+
+	unregister_ftrace_graph(&store_bytes);
+
+	if (fgraph_error_str) {
+		printk(KERN_CONT "*** %s ***", fgraph_error_str);
+		return -1;
+	}
+
+	return 0;
+}
+/* Test the storage passed across function_graph entry and return */
+static __init int test_graph_storage(void)
+{
+	int ret;
+
+	ret = test_graph_storage_type("byte", 1);
+	if (ret)
+		return ret;
+	ret = test_graph_storage_type("short", 2);
+	if (ret)
+		return ret;
+	ret = test_graph_storage_type("word", 4);
+	if (ret)
+		return ret;
+	ret = test_graph_storage_type("long long", 8);
+	if (ret)
+		return ret;
+	return 0;
+}
+#else
+static inline int test_graph_storage(void) { return 0; }
+#endif /* CONFIG_DYNAMIC_FTRACE */
+
 /* Maximum number of functions to trace before diagnosing a hang */
 #define GRAPH_MAX_FUNC_TEST	100000000
 
@@ -805,6 +964,8 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 		goto out;
 	}
 
+	ret = test_graph_storage();
+
 	/* Don't test dynamic tracing, the function tracer already did */
 
 out:
-- 
2.20.1


