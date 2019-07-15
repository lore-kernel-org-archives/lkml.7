Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB67C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03C2214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563167604;
	bh=he0cLIlCSxJggZvEU16Jx+uhRxzb4zHCpiAsU+uAfko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gM/MX/DJ/vKA3g8va7uEeVkGjx8fp7BsP4A3PnR3U3tu1b8E43MEcA62gUOMzRdMz
	 y6eOknv9fxXuaJAM+bAhQCzG8DhUaKwYhEuSZCkedgRJArWYBDf8Ctouwlb+oM1HqF
	 sqsw83gDrpxWLKWYLduNKyxeQ0sHAiOeM2MzpkzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbfGOFNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 01:13:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfGOFNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 01:13:23 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EAA020868;
        Mon, 15 Jul 2019 05:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563167601;
        bh=he0cLIlCSxJggZvEU16Jx+uhRxzb4zHCpiAsU+uAfko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ROnWu6dVHYL99vo47cq6HaPR7bjMoubVzc2r8/8N+hRysthg6OXRlNwGwQQMOagzb
         AaX4C5VJ6Yw2wAUVcTvzo2ibce2KV0brwO2tk2z0qHw1pHLM6B5gHAkydLwJppbnw5
         5xA9osmy2mQjBAIDXd5wsjkxBjK81lFuPRbYk7Eo=
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
Subject: [RFC PATCH v2 12/15] tracing: of: Add instance node support
Date:   Mon, 15 Jul 2019 14:13:16 +0900
Message-Id: <156316759652.23477.15841482804179404771.stgit@devnote2>
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

Add instance node support to devicetree ftrace binding.
User can set some options and event nodes in instance node.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_of.c |   67 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace_of.c b/kernel/trace/trace_of.c
index e9142c63ece1..7fe81c25dc59 100644
--- a/kernel/trace/trace_of.c
+++ b/kernel/trace/trace_of.c
@@ -21,9 +21,10 @@ extern int tracing_set_tracer(struct trace_array *tr, const char *buf);
 extern void __init trace_init_tracepoint_printk(void);
 extern ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 					  unsigned long size, int cpu_id);
+extern struct trace_array *trace_array_create(const char *name);
 
 static void __init
-trace_of_set_ftrace_options(struct trace_array *tr, struct device_node *node)
+trace_of_set_instance_options(struct trace_array *tr, struct device_node *node)
 {
 	struct property *prop;
 	const char *p;
@@ -48,6 +49,24 @@ trace_of_set_ftrace_options(struct trace_array *tr, struct device_node *node)
 			pr_err("Failed to set trace clock: %s\n", p);
 	}
 
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
+}
+
+static void __init
+trace_of_set_ftrace_options(struct trace_array *tr, struct device_node *node)
+{
+	u32 v = 0;
+	int err;
+
 	/* Command line boot options */
 	if (of_find_property(node, "dump-on-oops", NULL)) {
 		err = of_property_read_u32_index(node, "dump-on-oops", 0, &v);
@@ -63,20 +82,11 @@ trace_of_set_ftrace_options(struct trace_array *tr, struct device_node *node)
 	if (of_find_property(node, "tp-printk", NULL))
 		trace_init_tracepoint_printk();
 
-	/* This accepts per-cpu buffer size in KB */
-	err = of_property_read_u32_index(node, "buffer-size-kb", 0, &v);
-	if (!err) {
-		v <<= 10;	/* KB to Byte */
-		if (v < PAGE_SIZE)
-			pr_err("Buffer size is too small: %d KB\n", v >> 10);
-		if (tracing_resize_ring_buffer(tr, v, RING_BUFFER_ALL_CPUS) < 0)
-			pr_err("Failed to resize trace buffer to %d KB\n",
-				v >> 10);
-	}
-
 	if (of_find_property(node, "alloc-snapshot", NULL))
 		if (tracing_alloc_snapshot() < 0)
 			pr_err("Failed to allocate snapshot buffer\n");
+
+	trace_of_set_instance_options(tr, node);
 }
 
 #ifdef CONFIG_EVENT_TRACING
@@ -310,6 +320,38 @@ trace_of_enable_tracer(struct trace_array *tr, struct device_node *node)
 	}
 }
 
+static void __init
+trace_of_init_instances(struct device_node *__node)
+{
+	struct device_node *node;
+	struct trace_array *tr;
+	const char *p;
+	int err;
+
+	for_each_child_of_node(__node, node) {
+		if (!of_node_name_prefix(node, "instance"))
+			continue;
+
+		err = of_property_read_string(node, "instance", &p);
+		if (err) {
+			pr_err("Failed to get instance name on %s\n",
+				of_node_full_name(node));
+			continue;
+		}
+
+		tr = trace_array_create(p);
+		if (IS_ERR(tr)) {
+			pr_err("Failed to create instance %s\n", p);
+			continue;
+		}
+
+		trace_of_set_instance_options(tr, node);
+		trace_of_init_events(tr, node);
+		trace_of_enable_events(tr, node);
+		trace_of_enable_tracer(tr, node);
+	}
+}
+
 static struct device_node * __init trace_of_find_ftrace_node(void)
 {
 	if (!of_chosen)
@@ -337,6 +379,7 @@ static int __init trace_of_init(void)
 	trace_of_init_events(tr, trace_node);
 	trace_of_enable_events(tr, trace_node);
 	trace_of_enable_tracer(tr, trace_node);
+	trace_of_init_instances(trace_node);
 
 end:
 	of_node_put(trace_node);

