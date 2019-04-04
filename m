Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5E7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BF921872
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfDDBhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 21:37:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbfDDBhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 21:37:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A72C9217D4;
        Thu,  4 Apr 2019 01:37:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hBrK3-0004yL-PC; Wed, 03 Apr 2019 21:37:43 -0400
Message-Id: <20190404013743.674315225@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 03 Apr 2019 21:37:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 04/19] tracing: Save the last hist commands associated event name
References: <20190404013721.023858792@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

In preparation for making use of the new trace error log, save the
subsystem and event name associated with the last hist command - it
will be passed as the location param in the event_log_err() calls.

Link: http://lkml.kernel.org/r/eb0fd1362be8f39facb86c83eecf441b7a5876f8.1554072478.git.tom.zanussi@linux.intel.com

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 33 ++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 795aa2038377..0de702bf148f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -535,15 +535,34 @@ static struct track_data *track_data_alloc(unsigned int key_len,
 	return data;
 }
 
-static char last_hist_cmd[MAX_FILTER_STR_VAL];
+static char last_cmd[MAX_FILTER_STR_VAL];
+static char last_cmd_loc[MAX_FILTER_STR_VAL];
+
 static char hist_err_str[MAX_FILTER_STR_VAL];
 
-static void last_cmd_set(char *str)
+static void last_cmd_set(struct trace_event_file *file, char *str)
 {
+	const char *system = NULL, *name = NULL;
+	struct trace_event_call *call;
+
 	if (!str)
 		return;
 
-	strncpy(last_hist_cmd, str, MAX_FILTER_STR_VAL - 1);
+	strncpy(last_cmd, str, MAX_FILTER_STR_VAL - 1);
+
+	if (file) {
+		call = file->event_call;
+
+		system = call->class->system;
+		if (system) {
+			name = trace_event_name(call);
+			if (!name)
+				system = NULL;
+		}
+	}
+
+	if (system)
+		snprintf(last_cmd_loc, MAX_FILTER_STR_VAL, "hist:%s:%s", system, name);
 }
 
 static void hist_err(char *str, char *var)
@@ -583,6 +602,8 @@ static void hist_err_event(char *str, char *system, char *event, char *var)
 static void hist_err_clear(void)
 {
 	hist_err_str[0] = '\0';
+	last_cmd[0] = '\0';
+	last_cmd_loc[0] = '\0';
 }
 
 static bool have_hist_err(void)
@@ -5438,8 +5459,8 @@ static int hist_show(struct seq_file *m, void *v)
 	}
 
 	if (have_hist_err()) {
-		seq_printf(m, "\nERROR: %s\n", hist_err_str);
-		seq_printf(m, "  Last command: %s\n", last_hist_cmd);
+		seq_printf(m, "\n%s: error: \n", hist_err_str);
+		seq_printf(m, "  Last command: %s\n", last_cmd);
 	}
 
  out_unlock:
@@ -6043,8 +6064,8 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	lockdep_assert_held(&event_mutex);
 
 	if (glob && strlen(glob)) {
-		last_cmd_set(param);
 		hist_err_clear();
+		last_cmd_set(file, param);
 	}
 
 	if (!param)
-- 
2.20.1


