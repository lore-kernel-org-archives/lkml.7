Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D3DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 03:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9D32173E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 03:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566789572;
	bh=uHqfn9peEd3ORIM3wsSJk2LrEw61/eQUGWlnaFOeCsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w6c4Ir2kHt2baxy+IICEDF3+V/AcfjQAd/Ud2GfADidj35aaEvBRVaCrDzoGIEvt1
	 7wiMUk+jHrM2tK+2AYxXe9UxkP5UVdrZfOuc1uxTO3wNQg2ovXwvUdjE67zR3KUOHk
	 D3wWuSpaTaFJWbd6BdKvCEx75oS6fncy9cc6/wxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbfHZDTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 23:19:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729378AbfHZDTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 23:19:30 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED8022168B;
        Mon, 26 Aug 2019 03:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566789569;
        bh=uHqfn9peEd3ORIM3wsSJk2LrEw61/eQUGWlnaFOeCsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OwKoveKLdrVY+N9Mn6VFT/RfjDs8u4C7XtkqDlc9V8drC8GIXQz9Dd3PJjCJKkSFV
         QDHc4BUijUjNWntQI5+6xAqZqxe3utIc0hcV5vz4ogz8CsD9weJqDPTL2g9+KMh8l+
         j6sqbdG6g1+i06wePcS2bqqwWZh0xRfuWtJargtg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Tim Bird <Tim.Bird@sony.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 19/19] Documentation: tracing: Add boot-time tracing document
Date:   Mon, 26 Aug 2019 12:19:23 +0900
Message-Id: <156678956359.21459.7183859111623533121.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156678933823.21459.4100380582025186209.stgit@devnote2>
References: <156678933823.21459.4100380582025186209.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a documentation about boot-time tracing options for
SKC file.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/trace/boottime-trace.rst |  185 ++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)
 create mode 100644 Documentation/trace/boottime-trace.rst

diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
new file mode 100644
index 000000000000..fc074afd014e
--- /dev/null
+++ b/Documentation/trace/boottime-trace.rst
@@ -0,0 +1,185 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+Boot-time tracing
+=================
+
+:Author: Masami Hiramatsu <mhiramat@kernel.org>
+
+Overview
+========
+
+Boot-time tracing allows users to trace boot-time process including
+device initialization with full features of ftrace including per-event
+filter and actions, histograms, kprobe-events and synthetic-events,
+and trace instances.
+Since kernel cmdline is not enough to control these complex features,
+this uses supplemental kernel cmdline (SKC) to describe tracing
+feature programming.
+
+Options in Supplemental Kernel Cmdline
+======================================
+
+Here is the list of available options list for boot time tracing in
+supplemental kenrel cmdline file [1]_. All options are under "ftrace."
+prefix to isolate from other subsystems.
+
+.. [1] See Documentation/admin-guide/skc.rst for details.
+
+Ftrace Global Options
+---------------------
+
+These options are only for global ftrace node since these are globally
+applied.
+
+ftrace.tp_printk;
+   Output trace-event data on printk buffer too.
+
+ftrace.dump_on_oops [= MODE];
+   Dump ftrace on Oops. If MODE = 1 or omitted, dump trace buffer
+   on all CPUs. If MODE = 2, dump a buffer on a CPU which kicks Oops.
+
+ftrace.traceoff_on_warning;
+   Stop tracing if WARN_ON() occurs.
+
+ftrace.fgraph.filters = FILTER[, FILTER2...];
+   Add fgraph tracing function filters.
+
+ftrace.fgraph.notraces = FILTER[, FILTER2...];
+   Add fgraph non tracing function filters.
+
+ftrace.fgraph.max_depth = MAX_DEPTH;
+   Set MAX_DEPTH to maximum depth of fgraph tracer.
+
+
+Ftrace Per-instance Options
+---------------------------
+
+These options can be used for each instance including global ftrace node.
+
+ftrace.[instance.INSTANCE.]options = OPT1[, OPT2[...]];
+   Enable given ftrace options.
+
+ftrace.[instance.INSTANCE.]trace_clock = CLOCK;
+   Set given CLOCK to ftrace's trace_clock.
+
+ftrace.[instance.INSTANCE.]buffer_size = SIZE;
+   Configure ftrace buffer size to SIZE. You can use "KB" or "MB"
+   for that SIZE.
+
+ftrace.[instance.INSTANCE.]alloc_snapshot;
+   Allocate snapshot buffer.
+
+ftrace.[instance.INSTANCE.]events = EVENT[, EVENT2[...]];
+   Enable given events on boot. You can use a wild card in EVENT.
+
+ftrace.[instance.INSTANCE.]tracer = TRACER;
+   Set TRACER to current tracer on boot. (e.g. function)
+
+ftrace.[instance.INSTANCE.]ftrace.filters
+   This will take an array of tracing function filter rules
+
+ftrace.[instance.INSTANCE.]ftrace.notraces
+   This will take an array of NON-tracing function filter rules
+
+
+Ftrace Per-Event Options
+------------------------
+
+These options are setting per-event options.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.enable;
+   Enables GROUP:EVENT tracing.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.filter = FILTER;
+   Set FILTER rule to the GROUP:EVENT.
+
+ftrace.[instance.INSTANCE.]event.GROUP.EVENT.actions = ACTION[, ACTION2[...]];
+   Set ACTIONs to the GROUP:EVENT.
+
+ftrace.[instance.INSTANCE.]event.kprobes.EVENT.probes = PROBE[, PROBE2[...]];
+   Defines new kprobe event based on PROBEs. It is able to define
+   multiple probes on one event, but those must have same type of
+   arguments. This option is available only for the event which
+   group name is "kprobes".
+
+ftrace.[instance.INSTANCE.]event.synthetic.EVENT.fields = FIELD[, FIELD2[...]];
+   Defines new synthetic event with FIELDs. Each field should be
+   "type varname".
+
+Note that kprobe and synthetic event definitions can be written under
+instance node, but those are also visible from other instances. So please
+take care for event name conflict.
+
+Examples
+========
+
+For example, to add filter and actions for each event, define kprobe
+events, and synthetic events with histogram, write SKC like below.
+
+::
+
+  ftrace.event {
+        task.task_newtask {
+                filter = "pid < 128";
+                enable;
+        }
+        kprobes.vfs_read {
+                probes = "vfs_read $arg1 $arg2";
+                filter = "common_pid < 200";
+                enable;
+        }
+        synthetic.initcall_latency {
+                fields = "unsigned long func", "u64 lat";
+                actions = "hist:keys=func.sym,lat:vals=lat:sort=lat";
+        }
+        initcall.initcall_start {
+                actions = "hist:keys=func:ts0=common_timestamp.usecs";
+        }
+        initcall.initcall_finish {
+                actions = "hist:keys=func:lat=common_timestamp.usecs-$ts0:onmatch(initcall.initcall_start).initcall_latency(func,$lat)";
+        }
+  }
+
+Also, boottime tracing supports "instance" node, which allows us to run
+several tracers for different purpose at once. For example, one tracer
+is for tracing functions in module alpha, and others tracing module beta,
+you can write as below.
+
+::
+
+  ftrace.instance {
+        foo {
+                tracer = "function";
+                ftrace-filters = "*:mod:alpha";
+        }
+        bar {
+                tracer = "function";
+                ftrace-filters = "*:mod:beta";
+        }
+  }
+
+The instance node also accepts event nodes so that each instance
+can customize its event tracing.
+
+This boot-time trace also supports ftrace kernel parameters.
+For example, following kernel parameters
+
+::
+
+ trace_options=sym-addr trace_event=initcall:* tp_printk trace_buf_size=1M ftrace=function ftrace_filter="vfs*"
+
+This can be written in SKC like below.
+
+::
+
+  ftrace {
+        options = sym-addr;
+        events = "initcall:*";
+        tp-printk;
+        buffer-size = 1MB;
+        ftrace-filters = "vfs*";
+  }
+
+However, since the initialization timing is different, if you need
+to trace very early boot, please use normal kernel parameters.

