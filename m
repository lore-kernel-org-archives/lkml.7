Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D04BC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7A621655
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561133999;
	bh=vZTIPel1k0Goob2NV5rhCNi/4PicEMn+Wbjb1yT/6XM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UZB6t3zEVf2oaQoap/iAHQMz8YMQGKc7NxZlzrFOPbsYTFkjuaRCwyK0q8EYnyFPJ
	 UW4GOIh+OgQzKwcO9mozJKMSqq7My0JFF4zN/+z7K9/g74rF8YVnu6029AGASNH04O
	 qPOWJR2J/8ygLtSrCWkbntLwlOVp4edTVtsSp4Q8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfFUQT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 12:19:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbfFUQT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:19:58 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 483972089E;
        Fri, 21 Jun 2019 16:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561133996;
        bh=vZTIPel1k0Goob2NV5rhCNi/4PicEMn+Wbjb1yT/6XM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YUd1vKgbdSdGZc7N9T/+k9JhJB1idwqKfzo1/pjXfG3eYUDMIqiPnmQNisboqicJt
         liqC5Y/9BlpTOPtrFYfPup8MjPvNqzAtZpDJ3Akx1CVW6kMICiWWEG1u7ZK1GBnOWy
         Aq895LBsf0idoDc6SEPnCnEwUZVqmb5lVXhQyDVY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC PATCH 11/11] tracing: of: Add synthetic event support
Date:   Sat, 22 Jun 2019 01:19:51 +0900
Message-Id: <156113399174.28344.17111722475993258131.stgit@devnote2>
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

Add synthetic event node support. The synthetic event node must be
a child node of ftrace node, and the node must start with "synth@"
prefix. The synth node requires fields string (not string array),
which defines the fields as same as tracing/synth_events interface.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_events_hist.c |    5 ++++
 kernel/trace/trace_of.c          |   54 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index db973928e580..e7f5d0a353e2 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1343,6 +1343,11 @@ static int create_or_delete_synth_event(int argc, char **argv)
 	return ret == -ECANCELED ? -EINVAL : ret;
 }
 
+int synth_event_run_command(const char *command)
+{
+	return trace_run_command(command, create_or_delete_synth_event);
+}
+
 static int synth_event_create(int argc, const char **argv)
 {
 	const char *name = argv[0];
diff --git a/kernel/trace/trace_of.c b/kernel/trace/trace_of.c
index 43d87e5065a3..1b2a1306fc60 100644
--- a/kernel/trace/trace_of.c
+++ b/kernel/trace/trace_of.c
@@ -24,6 +24,7 @@ extern ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 					  unsigned long size, int cpu_id);
 extern int trigger_process_regex(struct trace_event_file *file, char *buff);
 extern int trace_kprobe_run_command(const char *command);
+extern int synth_event_run_command(const char *command);
 
 static void __init
 trace_of_set_ftrace_options(struct trace_array *tr, struct device_node *node)
@@ -133,6 +134,38 @@ trace_of_add_kprobe_event(struct device_node *node,
 	return 0;
 }
 
+static int __init
+trace_of_add_synth_event(struct device_node *node, const char *event)
+{
+	struct property *prop;
+	char buf[MAX_BUF_LEN], *q;
+	const char *p;
+	int len, delta, ret;
+
+	len = ARRAY_SIZE(buf);
+	delta = snprintf(buf, len, "%s", event);
+	if (delta >= len) {
+		pr_err("Event name is too long: %s\n", event);
+		return -E2BIG;
+	}
+	len -= delta; q = buf + delta;
+
+	of_property_for_each_string(node, "fields", prop, p) {
+		delta = snprintf(q, len, " %s;", p);
+		if (delta >= len) {
+			pr_err("fields string is too long: %s\n", p);
+			return -E2BIG;
+		}
+		len -= delta; q += delta;
+	}
+
+	ret = synth_event_run_command(buf);
+	if (ret < 0)
+		pr_err("Failed to add synthetic event: %s\n", buf);
+
+	return ret;
+}
+
 static void __init
 trace_of_init_one_event(struct trace_array *tr, struct device_node *node)
 {
@@ -160,15 +193,30 @@ trace_of_init_one_event(struct trace_array *tr, struct device_node *node)
 	event = buf;
 
 	group = strsep(&event, ":");
-	/* For a kprobe event, we have to generates an event at first */
+
+	/* Generates kprobe/synth event at first */
 	if (of_find_property(node, "probes", NULL)) {
+		if (of_find_property(node, "fields", NULL)) {
+			pr_err("Error: %s node has both probes and fields\n",
+				of_node_full_name(node));
+			return;
+		}
 		if (!event) {
 			event = buf;
 			group = "kprobes";
 		}
-		err = trace_of_add_kprobe_event(node, group, event);
-		if (err < 0)
+		if (trace_of_add_kprobe_event(node, group, event) < 0)
+			return;
+	} else if (of_find_property(node, "fields", NULL)) {
+		if (!event)
+			event = buf;
+		else if (strcmp(group, "synthetic") != 0) {
+			pr_err("Synthetic event must be in synthetic group\n");
+			return;
+		}
+		if (trace_of_add_synth_event(node, event) < 0)
 			return;
+		group = "synthetic";
 	} else {
 		if (!event) {
 			pr_err("%s has no group name\n", buf);

