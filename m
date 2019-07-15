Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0360CC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA69F20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 05:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563167584;
	bh=J3toTsmMYkCedNY+dZ7+xVxoag06YSywWTZtk6/pnL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OlZalcbuwzpVwx2RmSL2jRa2L+mMPIOXQyRm+5nsqq0aXTnyiR+us41l2g7muDdO7
	 oJGxm+UxVswdp6EVrznXzJk7PEKGIFogd5mudwjldiwjExTbyxU1a8QmU3zb4pi9Iq
	 wI9VTY2emjWfpWIYGJ3C+bHAFxztEBLlAWfcDO5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbfGOFND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 01:13:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfGOFNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 01:13:01 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10B7120868;
        Mon, 15 Jul 2019 05:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563167580;
        bh=J3toTsmMYkCedNY+dZ7+xVxoag06YSywWTZtk6/pnL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rAgVEHI7AYbLeNGXoDfjshvi8YDTZh04Pmw4j+1ZGVi3N/4rvC/609odvOnYus7kj
         o8NzrwTAxekyVCvOKRhvQqtZ2NhX8fJviVF44PiTLI8rvMESRxu9XptXGQCMbIaxaX
         M9C0su5WmSa0T3bKdZJ/RsIoq1pZll9rxWwtDRZU=
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
Subject: [RFC PATCH v2 10/15] tracing: of: Add kprobe event support
Date:   Mon, 15 Jul 2019 14:12:55 +0900
Message-Id: <156316757537.23477.11850485954586213304.stgit@devnote2>
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

Add kprobe event support in event node. User can add probe definitions
by "probes" property as a string array.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
  Changes in v2:
   - Make probes property avaiable if CONFIG_KPROBE_EVENTS=y.
---
 kernel/trace/trace_kprobe.c |    5 +++
 kernel/trace/trace_of.c     |   76 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 71 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 5135c07b6557..03ce60928c18 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -728,6 +728,11 @@ static int create_or_delete_trace_kprobe(int argc, char **argv)
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
index 3719f711144a..56c5deb45f54 100644
--- a/kernel/trace/trace_of.c
+++ b/kernel/trace/trace_of.c
@@ -101,14 +101,59 @@ trace_of_enable_events(struct trace_array *tr, struct device_node *node)
 	}
 }
 
+#ifdef CONFIG_KPROBE_EVENTS
+extern int trace_kprobe_run_command(const char *command);
+
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
+#else
+static inline int __init
+trace_of_add_kprobe_event(struct device_node *node,
+			  const char *group, const char *event)
+{
+	pr_err("Kprobe event is not supported.\n");
+	return -ENOTSUPP;
+}
+#endif
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
@@ -125,18 +170,29 @@ trace_of_init_one_event(struct trace_array *tr, struct device_node *node)
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
 

