Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438D5C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D6E26B9B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559315954;
	bh=8u1ZhqDssJ200IfzBzUDbLSa8bZ0d6DjqSWbVyLbL8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xd0SHBJ3c4mhYNqAt3JF50gsz9FWADR+pEHgG7pYG5bXGonadHJkvGMJFK+7GB1Vj
	 oxryRrLb6+EUQdyOfDeyda5+G8KUZibnL40SIBf+6UjDpo8453Yu2HB2lQbtSGLD9H
	 mJDsGLw21fC8jqWtp9s4V2YXc2wYZThwy6wqbJ9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfEaPTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:19:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfEaPTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:19:13 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 973FB26B91;
        Fri, 31 May 2019 15:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559315951;
        bh=8u1ZhqDssJ200IfzBzUDbLSa8bZ0d6DjqSWbVyLbL8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0KHm0ypOWtbBedrXpNI7ARAYQY/CJZh8WNrGGGIiVyRPCrgoOpkTK1VHKlmqPh222
         joi35eDCQSPOBcXfaMQU54tpABhFAk8iIFCVRcIngoau0EXaaigehnpGKJVvW6tc54
         tmEIsdV1D9OzfLoFVR8p95E3P/7CEAdUbbGbXDSs=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/21] tracing/kprobe: Add per-probe delete from event
Date:   Sat,  1 Jun 2019 00:19:06 +0900
Message-Id: <155931594657.28323.6372186017174748156.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155931578555.28323.16360245959211149678.stgit@devnote2>
References: <155931578555.28323.16360245959211149678.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
index 84a164559a47..b950a92976b0 100644
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

