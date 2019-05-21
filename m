Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F458C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B57E217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558425405;
	bh=bJvqGYw7DNXGDmes2Ibv22SSkaA4f4/0ULWJP8zE9PQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=on+oCmQz6mgmbm9CdhFEk8tD/kwlZlYthITKbmmYrvJVIScMk8xhhT7LyTeovarEP
	 0hqX4TyWFLlxZvY7JSZy4kfYkANwy9s6aS6R/jGrvFRL3XcG9r2b5D7KU4uNc4GIlQ
	 4vaHY0sqAcq44xt1B7j6e3xaaiNgNyYy/aaPYQLE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfEUH4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:56:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfEUH4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:56:43 -0400
Received: from localhost.localdomain (unknown [153.145.222.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DA3621783;
        Tue, 21 May 2019 07:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558425402;
        bh=bJvqGYw7DNXGDmes2Ibv22SSkaA4f4/0ULWJP8zE9PQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQvtcYoDDrjlqVPUv8EhnKsf6yitRF6LBq7FI3K16bmd1G5CVWpZt/PAPiFpjU62N
         oMS6KMa8mzqOsCctn7NaUUBEgwFKlawXzS10n/1F7JHe22pAQ0DEhBVUZgbqA8K5lu
         0bRx7LgW4AuVbf0+DzuBB9QnK4DigfdM7Ry5MaP8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 2/2] tracing/kprobe: Add kprobe_event= boot parameter
Date:   Tue, 21 May 2019 16:56:37 +0900
Message-Id: <155842539720.4253.9428800909463994709.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155842537599.4253.14690293652007233645.stgit@devnote2>
References: <155842537599.4253.14690293652007233645.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kprobe_event= boot parameter to define kprobe events
at boot time.
The definition syntax is similar to tracefs/kprobe_events
interface, but use ',' and ';' instead of ' ' and '\n'
respectively. e.g.

  kprobe_event=p,vfs_read,$arg1,$arg2

This puts a probe on vfs_read with argument1 and 2, and
enable the new event.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |   13 ++++++
 Documentation/trace/kprobetrace.rst             |   14 ++++++
 kernel/trace/trace_kprobe.c                     |   54 +++++++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2b8ee90bb644..96b22db7f763 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2002,6 +2002,19 @@
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
index 235ce2ab131a..5b129215ba33 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -124,6 +124,20 @@ You can check the total number of probe hits and probe miss-hits via
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
index 7d736248a070..6983435ff017 100644
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
@@ -1450,6 +1463,44 @@ void destroy_local_trace_kprobe(struct trace_event_call *event_call)
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
@@ -1481,6 +1532,9 @@ static __init int init_kprobe_trace(void)
 
 	if (!entry)
 		pr_warn("Could not create tracefs 'kprobe_profile' entry\n");
+
+	setup_boot_kprobe_events();
+
 	return 0;
 }
 fs_initcall(init_kprobe_trace);

