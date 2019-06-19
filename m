Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D04C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566F421897
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560956895;
	bh=71TJ/i+a+ltiiVmXz7FgsEoC2HngwssIwub8kPjFd4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LOGZ8mZb2hM5SjEpnMI+k5rFkTWataHmzwg0Ff9KmksGRHW+Qdg3Kipgcy5U5wpFC
	 NBm9R7xlNWLeqq6NxG+/1BfuqzI0pqBKBUiFtc0771hT1yeNijvV4Wt+P5jzVOwx+Z
	 pcFn02O+lZ6OLxNg6GSJVk4fntG3z0U1cgpX9iqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbfFSPIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:08:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbfFSPIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:08:13 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B92C821883;
        Wed, 19 Jun 2019 15:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560956892;
        bh=71TJ/i+a+ltiiVmXz7FgsEoC2HngwssIwub8kPjFd4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gYpqSZPnofQ+wk6OFl9BgJ3ftkFB9SG4GJvRGQp/IdjQxF/2g1bD3TaA7J3c8XbOo
         YYroZO6Xw7q/OhUgqLGfdgECtuWwGlFcLnk32tjg6rmR7r9NGBcYKaDPZwIEUpXeHY
         ZkCuuN/Fh3MfCQhN0xpwUmZo7j7SW35VPxsSsZPA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v2 06/12] tracing/kprobe: Add per-probe delete from event
Date:   Thu, 20 Jun 2019 00:08:08 +0900
Message-Id: <156095688848.28024.15798690082378432435.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156095682948.28024.14190188071338900568.stgit@devnote2>
References: <156095682948.28024.14190188071338900568.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow user to delete a probe from event. This is done by head
match. For example, if we have 2 probes on an event

$ cat kprobe_events
p:kprobes/testprobe _do_fork r1=%ax r2=%dx
p:kprobes/testprobe idle_fork r1=%ax r2=%cx

Then you can remove one of them by passing the head of definition
which identify the probe.

$ echo "-:kprobes/testprobe idle_fork" >> kprobe_events

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   25 ++++++++++++++++++++++++-
 kernel/trace/trace_probe.c  |   18 ++++++++++++++++++
 kernel/trace/trace_probe.h  |    2 ++
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index f43098bf62dd..18c4175b6585 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -137,13 +137,36 @@ static bool trace_kprobe_is_busy(struct dyn_event *ev)
 	return trace_probe_is_enabled(&tk->tp);
 }
 
+static bool trace_kprobe_match_command_head(struct trace_kprobe *tk,
+					    int argc, const char **argv)
+{
+	char buf[MAX_ARGSTR_LEN + 1];
+
+	if (!argc)
+		return true;
+
+	if (!tk->symbol)
+		snprintf(buf, sizeof(buf), "0x%p", tk->rp.kp.addr);
+	else if (tk->rp.kp.offset)
+		snprintf(buf, sizeof(buf), "%s+%u",
+			 trace_kprobe_symbol(tk), tk->rp.kp.offset);
+	else
+		snprintf(buf, sizeof(buf), "%s", trace_kprobe_symbol(tk));
+	if (strcmp(buf, argv[0]))
+		return false;
+	argc--; argv++;
+
+	return trace_probe_match_command_args(&tk->tp, argc, argv);
+}
+
 static bool trace_kprobe_match(const char *system, const char *event,
 			int argc, const char **argv, struct dyn_event *ev)
 {
 	struct trace_kprobe *tk = to_trace_kprobe(ev);
 
 	return strcmp(trace_probe_name(&tk->tp), event) == 0 &&
-	    (!system || strcmp(trace_probe_group_name(&tk->tp), system) == 0);
+	    (!system || strcmp(trace_probe_group_name(&tk->tp), system) == 0) &&
+	    trace_kprobe_match_command_head(tk, argc, argv);
 }
 
 static nokprobe_inline unsigned long trace_kprobe_nhit(struct trace_kprobe *tk)
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 651a1449acde..f8c3c65c035d 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1047,3 +1047,21 @@ int trace_probe_compare_arg_type(struct trace_probe *a, struct trace_probe *b)
 
 	return 0;
 }
+
+bool trace_probe_match_command_args(struct trace_probe *tp,
+				    int argc, const char **argv)
+{
+	char buf[MAX_ARGSTR_LEN + 1];
+	int i;
+
+	if (tp->nr_args < argc)
+		return false;
+
+	for (i = 0; i < argc; i++) {
+		snprintf(buf, sizeof(buf), "%s=%s",
+			 tp->args[i].name, tp->args[i].comm);
+		if (strcmp(buf, argv[i]))
+			return false;
+	}
+	return true;
+}
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 39926e8a344b..2dcc4e317787 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -332,6 +332,8 @@ int trace_probe_remove_file(struct trace_probe *tp,
 struct event_file_link *trace_probe_get_file_link(struct trace_probe *tp,
 						struct trace_event_file *file);
 int trace_probe_compare_arg_type(struct trace_probe *a, struct trace_probe *b);
+bool trace_probe_match_command_args(struct trace_probe *tp,
+				    int argc, const char **argv);
 
 #define trace_probe_for_each_link(pos, tp)	\
 	list_for_each_entry(pos, &(tp)->event->files, list)

