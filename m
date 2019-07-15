Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39E9C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E09214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563167573;
	bh=rnYqu90gFhMlvGUQmo3HOEqC0mOA+PgGI1p0yQM7YLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QBS3ZS+3NF84lrg04u7SAFsw1yJgK/FRDJt+kqfUXdBrH2dwjPCx5W2ZvFu49ZW69
	 3OvYmTm61UPsQy92PcrHM0f+I5OHky3R9nRJCQ/hMqv+YrxXKSUiDa7nPHlKAxMmpi
	 ANSUmjceTWf4JRYWBUjtCU+eaeiWMucJchPO/DqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfGOFMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 01:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfGOFMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 01:12:51 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D19C214DA;
        Mon, 15 Jul 2019 05:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563167570;
        bh=rnYqu90gFhMlvGUQmo3HOEqC0mOA+PgGI1p0yQM7YLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uBqgp5I6ckXFwtcgDRD3c262GB04+/tgu78VUL9JMzeFHLAsZz+T0TJnzeUGKXEUr
         Wkowwdlz+Xm2pfMetbGLf4JpdjCL4ZfYdT0Li/hC8Czw6sWfTRw41B3rm+/VPSTtmU
         GAUlZG20lb7GLxMWckH9ZqFM29LaHzkDNtBAH9zw=
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
Subject: [RFC PATCH v2 09/15] tracing: of: Add trace event settings
Date:   Mon, 15 Jul 2019 14:12:45 +0900
Message-Id: <156316756493.23477.857559505771671133.stgit@devnote2>
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

Add per-event settings, which includes filter and actions.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
  Changes in v2:
   - Make event node available only if CONFIG_EVENT_TRACING=y
---
 kernel/trace/trace_events_trigger.c |    2 -
 kernel/trace/trace_of.c             |   82 +++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 2a2912cb4533..74a19c18219f 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -208,7 +208,7 @@ static int event_trigger_regex_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
-static int trigger_process_regex(struct trace_event_file *file, char *buff)
+int trigger_process_regex(struct trace_event_file *file, char *buff)
 {
 	char *command, *next = buff;
 	struct event_command *p;
diff --git a/kernel/trace/trace_of.c b/kernel/trace/trace_of.c
index 5e108a1d5bb3..3719f711144a 100644
--- a/kernel/trace/trace_of.c
+++ b/kernel/trace/trace_of.c
@@ -81,6 +81,7 @@ trace_of_set_ftrace_options(struct trace_array *tr, struct device_node *node)
 
 #ifdef CONFIG_EVENT_TRACING
 extern int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
+extern int trigger_process_regex(struct trace_event_file *file, char *buff);
 
 static void __init
 trace_of_enable_events(struct trace_array *tr, struct device_node *node)
@@ -99,8 +100,88 @@ trace_of_enable_events(struct trace_array *tr, struct device_node *node)
 			pr_err("Failed to enable event: %s\n", p);
 	}
 }
+
+static void __init
+trace_of_init_one_event(struct trace_array *tr, struct device_node *node)
+{
+	struct trace_event_file *file;
+	struct property *prop;
+	char buf[MAX_BUF_LEN];
+	char *bufp;
+	const char *p;
+	int err;
+
+	if (!of_node_name_prefix(node, "event"))
+		return;
+
+	err = of_property_read_string(node, "event", &p);
+	if (err) {
+		pr_err("Failed to find event on %s\n", of_node_full_name(node));
+		return;
+	}
+
+	err = strlcpy(buf, p, ARRAY_SIZE(buf));
+	if (err >= ARRAY_SIZE(buf)) {
+		pr_err("Event name is too long: %s\n", p);
+		return;
+	}
+	bufp = buf;
+
+	p = strsep(&bufp, ":");
+	if (!bufp) {
+		pr_err("%s has no group name\n", buf);
+		return;
+	}
+
+	mutex_lock(&event_mutex);
+	file = find_event_file(tr, buf, bufp);
+	if (!file) {
+		pr_err("Failed to find event: %s\n", buf);
+		return;
+	}
+
+	err = of_property_read_string(node, "filter", &p);
+	if (!err) {
+		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf)) {
+			pr_err("filter string is too long: %s\n", p);
+			return;
+		}
+
+		if (apply_event_filter(file, buf) < 0) {
+			pr_err("Failed to apply filter: %s\n", buf);
+			return;
+		}
+	}
+
+	of_property_for_each_string(node, "actions", prop, p) {
+		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf)) {
+			pr_err("action string is too long: %s\n", p);
+			continue;
+		}
+
+		if (trigger_process_regex(file, buf) < 0)
+			pr_err("Failed to apply an action: %s\n", buf);
+	}
+
+	if (of_property_read_bool(node, "enable")) {
+		if (trace_event_enable_disable(file, 1, 0) < 0)
+			pr_err("Failed to enable event node: %s\n",
+				of_node_full_name(node));
+	}
+	mutex_unlock(&event_mutex);
+}
+
+static void __init
+trace_of_init_events(struct trace_array *tr, struct device_node *node)
+{
+	struct device_node *enode;
+
+	for_each_child_of_node(node, enode)
+		trace_of_init_one_event(tr, enode);
+}
 #else
 #define trace_of_enable_events(tr, node) do {} while (0)
+#define trace_of_init_events(tr, node) do {} while (0)
 #endif
 
 static void __init
@@ -139,6 +220,7 @@ static int __init trace_of_init(void)
 		goto end;
 
 	trace_of_set_ftrace_options(tr, trace_node);
+	trace_of_init_events(tr, trace_node);
 	trace_of_enable_events(tr, trace_node);
 	trace_of_enable_tracer(tr, trace_node);
 

