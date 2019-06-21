Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7815C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0A321655
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561133977;
	bh=/kwntWQW3LP0jIYi0ujmhqQBYlYdyIflNjwJ6hVtcyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bo9wEM8H07DRsdQx/1yHPlLvNLZyvgdF436Vjz28TsxbovN9PelgTCUC5jWAqBWqF
	 aVENSu3gkPhjzUz0c1m2vQ6M05UTk9VKtSOfxs1cq+D2RlgiKEB+jDF57bsCA98JyH
	 zRL5pxFORHFXBB0Tx/EobfFJ8sTGq20kvc/XiiHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfFUQTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 12:19:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfFUQTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:19:35 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75F63208CA;
        Fri, 21 Jun 2019 16:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561133974;
        bh=/kwntWQW3LP0jIYi0ujmhqQBYlYdyIflNjwJ6hVtcyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DeVZG3oHwcAJHg/sjbWMBLJuxrr2U8BBKSwHdXkkxtf531RZUR33wKuWqtOg0AmDZ
         EgkIklMGEDcSGoS4PmsCKhkilU6HppGV9EpIurkBdhEv2JLsm9rFdd+NPJg/HdZWk8
         srhKN2eMvErjIa3kjyKkG7oDbkrEHCC9YFY9Movo=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC PATCH 09/11] tracing: of: Add trace event settings
Date:   Sat, 22 Jun 2019 01:19:30 +0900
Message-Id: <156113396992.28344.5633907708861645713.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156113387975.28344.16009584175308192243.stgit@devnote2>
References: <156113387975.28344.16009584175308192243.stgit@devnote2>
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
 kernel/trace/trace_events_trigger.c |    2 -
 kernel/trace/trace_of.c             |   81 +++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 1 deletion(-)

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
index 5e34e2475d42..696f59234e62 100644
--- a/kernel/trace/trace_of.c
+++ b/kernel/trace/trace_of.c
@@ -22,6 +22,7 @@ extern int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
 extern void __init trace_init_tracepoint_printk(void);
 extern ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 					  unsigned long size, int cpu_id);
+extern int trigger_process_regex(struct trace_event_file *file, char *buff);
 
 static void __init
 trace_of_set_ftrace_options(struct trace_array *tr, struct device_node *node)
@@ -98,6 +99,85 @@ trace_of_enable_events(struct trace_array *tr, struct device_node *node)
 	}
 }
 
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
+
 static void __init
 trace_of_enable_tracer(struct trace_array *tr, struct device_node *trace_node)
 {
@@ -126,6 +206,7 @@ static int __init trace_of_init(void)
 		goto end;
 
 	trace_of_set_ftrace_options(tr, trace_node);
+	trace_of_init_events(tr, trace_node);
 	trace_of_enable_events(tr, trace_node);
 	trace_of_enable_tracer(tr, trace_node);
 

