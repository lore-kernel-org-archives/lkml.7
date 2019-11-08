Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2CDFC6197
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA16214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733232AbfKHVfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:35:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:34820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732922AbfKHVew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:34:52 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D5F922473;
        Fri,  8 Nov 2019 21:34:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iTBu6-0007y3-Ix; Fri, 08 Nov 2019 16:34:50 -0500
Message-Id: <20191108213450.461898076@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 08 Nov 2019 16:28:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 06/10] ftrace/selftest: Add tests to test register_ftrace_direct()
References: <20191108212834.594904349@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add two test cases that test the new ftrace direct functionality if the
ftrace-direct sample module is available. One test case tests against each
available tracer (function, function_graph, mmiotrace, etc), and the other
test tests against a kprobe at the same location as the direct caller. Both
tests follow the same pattern of testing combinations:

  enable test (either the tracer or the kprobe)
  load direct function module
  unload direct function module
  disable test

  enable test
  load direct function module
  disable test
  unload direct function module

  load direct function module
  enable test
  disable test
  unload direct function module

  load direct function module
  enable test
  unload direct function module
  disable test

As most the bugs in development happened with various ways of enabling or
disabling the direct calls with function tracer in one of these
combinations.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../ftrace/test.d/direct/ftrace-direct.tc     | 53 ++++++++++++++
 .../ftrace/test.d/direct/kprobe-direct.tc     | 71 +++++++++++++++++++
 2 files changed, 124 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc

diff --git a/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
new file mode 100644
index 000000000000..8b8ed3cad51b
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
@@ -0,0 +1,53 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test ftrace direct functions against tracers
+
+rmmod ftrace-direct ||:
+if ! modprobe ftrace-direct ; then
+  echo "No ftrace-direct sample module - please make CONFIG_SAMPLE_FTRACE_DIRECT=m"
+  exit_unresolved;
+fi
+
+echo "Let the module run a little"
+sleep 1
+
+grep -q "my_direct_func: wakeing up" trace
+
+rmmod ftrace-direct
+
+test_tracer() {
+	tracer=$1
+
+	# tracer -> direct -> no direct > no tracer
+	echo $tracer > current_tracer
+	modprobe ftrace-direct
+	rmmod ftrace-direct
+	echo nop > current_tracer
+
+	# tracer -> direct -> no tracer > no direct
+	echo $tracer > current_tracer
+	modprobe ftrace-direct
+	echo nop > current_tracer
+	rmmod ftrace-direct
+
+	# direct -> tracer -> no tracer > no direct
+	modprobe ftrace-direct
+	echo $tracer > current_tracer
+	echo nop > current_tracer
+	rmmod ftrace-direct
+
+	# direct -> tracer -> no direct > no notracer
+	modprobe ftrace-direct
+	echo $tracer > current_tracer
+	rmmod ftrace-direct
+	echo nop > current_tracer
+}
+
+for t in `cat available_tracers`; do
+	if [ "$t" != "nop" ]; then
+		test_tracer $t
+	fi
+done
+
+echo nop > current_tracer
+rmmod ftrace-direct ||:
diff --git a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
new file mode 100644
index 000000000000..1561106765e4
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
@@ -0,0 +1,71 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test ftrace direct functions against kprobes
+
+rmmod ftrace-direct ||:
+if ! modprobe ftrace-direct ; then
+  echo "No ftrace-direct sample module - please build with CONFIG_SAMPLE_FTRACE_DIRECT=m"
+  exit_unresolved;
+fi
+
+if [ ! -f kprobe_events ]; then
+	echo "No kprobe_events file -please build CONFIG_KPROBE_EVENTS"
+	exit_unresolved;
+fi
+
+echo "Let the module run a little"
+sleep 1
+
+grep -q "my_direct_func: wakeing up" trace
+
+rmmod ftrace-direct
+
+echo 'p:kwake wake_up_process task=$arg1' > kprobe_events
+
+start_direct() {
+	echo > trace
+	modprobe ftrace-direct
+	sleep 0.1
+	grep -q "my_direct_func: wakeing up" trace
+}
+
+stop_direct() {
+	rmmod ftrace-direct
+}
+
+enable_probe() {
+	echo > trace
+	echo 1 > events/kprobes/kwake/enable
+	sleep 0.1
+	grep -q "kwake:" trace
+}
+
+disable_probe() {
+	echo 0 > events/kprobes/kwake/enable
+}
+
+# probe -> direct -> no direct > no probe
+enable_probe
+start_direct
+stop_direct
+disable_probe
+
+# probe -> direct -> no probe > no direct
+enable_probe
+start_direct
+disable_probe
+stop_direct
+
+# direct -> probe -> no probe > no direct
+start_direct
+enable_probe
+disable_probe
+stop_direct
+
+# direct -> probe -> no direct > no noprobe
+start_direct
+enable_probe
+stop_direct
+disable_probe
+
+echo > kprobe_events
-- 
2.23.0


