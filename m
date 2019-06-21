Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58903C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318382089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561133990;
	bh=ORMFjD6wvQgU8GJG9KyEN/0vByMQj7Txl0lQOL6VHH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nvKFVna5X9RfQGF91wcH7n8hmQgnp25EFW2vLsBc7H2iVKSQM0nR/oW4wrPut+VJi
	 qmIoOwOYJLqneRna5+Ekg0MI3DCr5vDq/rP1S55Bq1HipOclQpOStdpr2UDSknnfC/
	 o62T1zl7jSUtDllNtGCuOcSe3MYR3CzoGD3jvP2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfFUQTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 12:19:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbfFUQTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:19:47 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5266F21537;
        Fri, 21 Jun 2019 16:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561133986;
        bh=ORMFjD6wvQgU8GJG9KyEN/0vByMQj7Txl0lQOL6VHH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1qUowMlNFdqlG9xi/RUi5XqeU1RcVS3QWD9HL2jMV/QymdUoIaHZnNjRcJ/fSZw1q
         OiTMj95vh99D6za79bG5n3YCgxTMOjvq7JfjLeUIZD/W1hcaxZ0qUhIVwu9PfDUmA8
         486+k41d5qvsCTnEMRlU7M04IQyEhZZop0RjVkUM=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC PATCH 10/11] tracing: of: Add kprobe event support
Date:   Sat, 22 Jun 2019 01:19:40 +0900
Message-Id: <156113398039.28344.4353616217444927643.stgit@devnote2>
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

Add kprobe event support in event node. User can add probe definitions
by "probes" property as a string array.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |    5 +++
 kernel/trace/trace_of.c     |   65 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 5166a12a9d49..cc5ba13028cd 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -765,6 +765,11 @@ static int create_or_delete_trace_kprobe(int argc, char **argv)
 	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
+int trace_kprobe_run_command(const char *command)
+{
+	return trace_run_command(command, create_or_delete_trace_kprobe);
+}
+
 static int trace_kprobe_release(struct dyn_event *ev)
 {
 	struct trace_kprobe *tk = to_trace_kprobe(ev);
diff --git a/kernel/trace/trace_of.c b/kernel/trace/trace_of.c
index 696f59234e62..43d87e5065a3 100644
--- a/kernel/trace/trace_of.c
+++ b/kernel/trace/trace_of.c
@@ -23,6 +23,7 @@ extern void __init trace_init_tracepoint_printk(void);
 extern ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 					  unsigned long size, int cpu_id);
 extern int trigger_process_regex(struct trace_event_file *file, char *buff);
+extern int trace_kprobe_run_command(const char *command);
 
 static void __init
 trace_of_set_ftrace_options(struct trace_array *tr, struct device_node *node)
@@ -99,14 +100,47 @@ trace_of_enable_events(struct trace_array *tr, struct device_node *node)
 	}
 }
 
+static int __init
+trace_of_add_kprobe_event(struct device_node *node,
+			  const char *group, const char *event)
+{
+	struct property *prop;
+	char buf[MAX_BUF_LEN];
+	const char *p;
+	char *q;
+	int len, ret;
+
+	len = snprintf(buf, ARRAY_SIZE(buf) - 1, "p:%s/%s ", group, event);
+	if (len >= ARRAY_SIZE(buf)) {
+		pr_err("Event name is too long: %s\n", event);
+		return -E2BIG;
+	}
+	q = buf + len;
+	len = ARRAY_SIZE(buf) - len;
+
+	of_property_for_each_string(node, "probes", prop, p) {
+		if (strlcpy(q, p, len) >= len) {
+			pr_err("Probe definition is too long: %s\n", p);
+			return -E2BIG;
+		}
+		ret = trace_kprobe_run_command(buf);
+		if (ret < 0) {
+			pr_err("Failed to add probe: %s\n", buf);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static void __init
 trace_of_init_one_event(struct trace_array *tr, struct device_node *node)
 {
 	struct trace_event_file *file;
 	struct property *prop;
 	char buf[MAX_BUF_LEN];
-	char *bufp;
-	const char *p;
+	const char *p, *group;
+	char *event;
 	int err;
 
 	if (!of_node_name_prefix(node, "event"))
@@ -123,18 +157,29 @@ trace_of_init_one_event(struct trace_array *tr, struct device_node *node)
 		pr_err("Event name is too long: %s\n", p);
 		return;
 	}
-	bufp = buf;
-
-	p = strsep(&bufp, ":");
-	if (!bufp) {
-		pr_err("%s has no group name\n", buf);
-		return;
+	event = buf;
+
+	group = strsep(&event, ":");
+	/* For a kprobe event, we have to generates an event at first */
+	if (of_find_property(node, "probes", NULL)) {
+		if (!event) {
+			event = buf;
+			group = "kprobes";
+		}
+		err = trace_of_add_kprobe_event(node, group, event);
+		if (err < 0)
+			return;
+	} else {
+		if (!event) {
+			pr_err("%s has no group name\n", buf);
+			return;
+		}
 	}
 
 	mutex_lock(&event_mutex);
-	file = find_event_file(tr, buf, bufp);
+	file = find_event_file(tr, group, event);
 	if (!file) {
-		pr_err("Failed to find event: %s\n", buf);
+		pr_err("Failed to find event: %s:%s\n", group, event);
 		return;
 	}
 

