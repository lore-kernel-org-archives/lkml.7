Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B945CC282E5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC7C2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfEZTTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 15:19:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbfEZTSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 15:18:50 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60271217F4;
        Sun, 26 May 2019 19:18:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hUyfQ-0004dT-HJ; Sun, 26 May 2019 15:18:48 -0400
Message-Id: <20190526191848.425725176@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 26 May 2019 15:18:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 13/16] tracing/kprobe: Add kprobe_event= boot parameter
References: <20190526191828.466305460@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add kprobe_event= boot parameter to define kprobe events
at boot time.
The definition syntax is similar to tracefs/kprobe_events
interface, but use ',' and ';' instead of ' ' and '\n'
respectively. e.g.

  kprobe_event=p,vfs_read,$arg1,$arg2

This puts a probe on vfs_read with argument1 and 2, and
enable the new event.

Link: http://lkml.kernel.org/r/155851395498.15728.830529496248543583.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../admin-guide/kernel-parameters.txt         | 13 +++++
 Documentation/trace/kprobetrace.rst           | 14 +++++
 kernel/trace/trace_kprobe.c                   | 54 +++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 138f6664b2e2..11b9ffb265eb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2007,6 +2007,19 @@
 			Built with CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y,
 			the default is off.
 
+	kprobe_event=[probe-list]
+			[FTRACE] Add kprobe events and enable at boot time.
+			The probe-list is a semicolon delimited list of probe
+			definitions. Each definition is same as kprobe_events
+			interface, but the parameters are comma delimited.
+			For example, to add a kprobe event on vfs_read with
+			arg1 and arg2, add to the command line;
+
+			      kprobe_event=p,vfs_read,$arg1,$arg2
+
+			See also Documentation/trace/kprobetrace.rst "Kernel
+			Boot Parameter" section.
+
 	kpti=		[ARM64] Control page table isolation of user
 			and kernel address spaces.
 			Default: enabled on cores which need mitigation.
diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 09ff474493e1..af776989caca 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -146,6 +146,20 @@ You can check the total number of probe hits and probe miss-hits via
 The first column is event name, the second is the number of probe hits,
 the third is the number of probe miss-hits.
 
+Kernel Boot Parameter
+---------------------
+You can add and enable new kprobe events when booting up the kernel by
+"kprobe_event=" parameter. The parameter accepts a semicolon-delimited
+kprobe events, which format is similar to the kprobe_events.
+The difference is that the probe definition parameters are comma-delimited
+instead of space. For example, adding myprobe event on do_sys_open like below
+
+  p:myprobe do_sys_open dfd=%ax filename=%dx flags=%cx mode=+4($stack)
+
+should be below for kernel boot parameter (just replace spaces with comma)
+
+  p:myprobe,do_sys_open,dfd=%ax,filename=%dx,flags=%cx,mode=+4($stack)
+
 
 Usage examples
 --------------
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 2c5357dddb92..004fffd24ec1 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -12,6 +12,8 @@
 #include <linux/rculist.h>
 #include <linux/error-injection.h>
 
+#include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
+
 #include "trace_dynevent.h"
 #include "trace_kprobe_selftest.h"
 #include "trace_probe.h"
@@ -19,6 +21,17 @@
 
 #define KPROBE_EVENT_SYSTEM "kprobes"
 #define KRETPROBE_MAXACTIVE_MAX 4096
+#define MAX_KPROBE_CMDLINE_SIZE 1024
+
+/* Kprobe early definition from command line */
+static char kprobe_boot_events_buf[COMMAND_LINE_SIZE] __initdata;
+
+static int __init set_kprobe_boot_events(char *str)
+{
+	strlcpy(kprobe_boot_events_buf, str, COMMAND_LINE_SIZE);
+	return 0;
+}
+__setup("kprobe_event=", set_kprobe_boot_events);
 
 static int trace_kprobe_create(int argc, const char **argv);
 static int trace_kprobe_show(struct seq_file *m, struct dyn_event *ev);
@@ -1494,6 +1507,44 @@ void destroy_local_trace_kprobe(struct trace_event_call *event_call)
 }
 #endif /* CONFIG_PERF_EVENTS */
 
+static __init void enable_boot_kprobe_events(void)
+{
+	struct trace_array *tr = top_trace_array();
+	struct trace_event_file *file;
+	struct trace_kprobe *tk;
+	struct dyn_event *pos;
+
+	mutex_lock(&event_mutex);
+	for_each_trace_kprobe(tk, pos) {
+		list_for_each_entry(file, &tr->events, list)
+			if (file->event_call == &tk->tp.call)
+				trace_event_enable_disable(file, 1, 0);
+	}
+	mutex_unlock(&event_mutex);
+}
+
+static __init void setup_boot_kprobe_events(void)
+{
+	char *p, *cmd = kprobe_boot_events_buf;
+	int ret;
+
+	strreplace(kprobe_boot_events_buf, ',', ' ');
+
+	while (cmd && *cmd != '\0') {
+		p = strchr(cmd, ';');
+		if (p)
+			*p++ = '\0';
+
+		ret = trace_run_command(cmd, create_or_delete_trace_kprobe);
+		if (ret)
+			pr_warn("Failed to add event(%d): %s\n", ret, cmd);
+
+		cmd = p;
+	}
+
+	enable_boot_kprobe_events();
+}
+
 /* Make a tracefs interface for controlling probe points */
 static __init int init_kprobe_trace(void)
 {
@@ -1525,6 +1576,9 @@ static __init int init_kprobe_trace(void)
 
 	if (!entry)
 		pr_warn("Could not create tracefs 'kprobe_profile' entry\n");
+
+	setup_boot_kprobe_events();
+
 	return 0;
 }
 fs_initcall(init_kprobe_trace);
-- 
2.20.1


