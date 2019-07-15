Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E82C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7925D214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563167626;
	bh=aW2i/PMsu1zMZsd3sK5Tcsd3UlqlRHAKKbDGz7j/x1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ADwqI3p+ZGxV4HQ+GJrOoUBC2O5MiLAXC4zhVijz16LXB/wRb22Lo0WSY03rN4mQv
	 UKvH9P11clc3D5hPepfeyG2tIwlntICGDej344aw2Cq9ZF34/soBiSSPQJMnMA2+qU
	 c/DjEp09V01c1TTCBFN2DnH+gvjyC3+4DRIdU7xo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfGOFNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 01:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfGOFNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 01:13:44 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 266BB20868;
        Mon, 15 Jul 2019 05:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563167622;
        bh=aW2i/PMsu1zMZsd3sK5Tcsd3UlqlRHAKKbDGz7j/x1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0KA2pDsc9wLeijExz5pj9YhLJ81thpbG8VttUT9EBn6L4mZrrbxRrt0v7tF5Op5p6
         oX5+yNDT79lA8eB6EDg2ARNtulRqRGZKAp49Dm+QZkmkjia3mMZ5f2AC26TLfR+Fm3
         Zwettd3PoEhzKePdC0+PVgyCfLfEwMB1yKm2HBNA=
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
Subject: [RFC PATCH v2 14/15] tracing: of: Add function tracer filter properties
Date:   Mon, 15 Jul 2019 14:13:37 +0900
Message-Id: <156316761767.23477.13784128240295644594.stgit@devnote2>
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

Add function tracer filter properties which includes
 - ftrace-filters : string array of filter rules
 - ftrace-notraces : string array of notrace rules
These properties are available on ftrace root node and
instance node.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_of.c |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/kernel/trace/trace_of.c b/kernel/trace/trace_of.c
index 14d6c9a8fd81..1ee6fab918f5 100644
--- a/kernel/trace/trace_of.c
+++ b/kernel/trace/trace_of.c
@@ -322,11 +322,47 @@ trace_of_init_events(struct trace_array *tr, struct device_node *node)
 #define trace_of_init_events(tr, node) do {} while (0)
 #endif
 
+#ifdef CONFIG_FUNCTION_TRACER
+extern bool ftrace_filter_param __initdata;
+extern int ftrace_set_filter(struct ftrace_ops *ops, unsigned char *buf,
+			     int len, int reset);
+extern int ftrace_set_notrace(struct ftrace_ops *ops, unsigned char *buf,
+			     int len, int reset);
+
+static void __init
+trace_of_set_ftrace_filter(struct ftrace_ops *ops, const char *property,
+			   struct device_node *node)
+{
+	struct property *prop;
+	const char *p;
+	char buf[MAX_BUF_LEN];
+	int err;
+
+	of_property_for_each_string(node, property, prop, p) {
+		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf)) {
+			pr_err("filter string is too long: %s\n", p);
+			return;
+		}
+		err = ftrace_set_filter(ops, buf, strlen(buf), 0);
+		if (err) {
+			pr_err("Failed to add %s: %s\n", property, buf);
+			return;
+		}
+		ftrace_filter_param = true;
+	}
+}
+#else
+#define trace_of_set_ftrace_filter(ops, prop, node) do {} while (0)
+#endif
+
 static void __init
 trace_of_enable_tracer(struct trace_array *tr, struct device_node *node)
 {
 	const char *p;
 
+	trace_of_set_ftrace_filter(tr->ops, "ftrace-filters", node);
+	trace_of_set_ftrace_filter(tr->ops, "ftrace-notraces", node);
+
 	if (!of_property_read_string(node, "tracer", &p)) {
 		if (tracing_set_tracer(tr, p) < 0)
 			pr_err("Failed to set given tracer: %s\n", p);

