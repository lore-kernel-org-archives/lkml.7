Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970A6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C16B2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfDDBiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 21:38:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfDDBhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 21:37:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9512821855;
        Thu,  4 Apr 2019 01:37:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hBrK5-00053k-NQ; Wed, 03 Apr 2019 21:37:45 -0400
Message-Id: <20190404013745.616653252@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 03 Apr 2019 21:37:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 15/19] tracing: Add tracing/error_log Documentation
References: <20190404013721.023858792@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Move most of the hist trigger extended error documentation to
ftrace.rst and expand on it to fully document tracing/error_log.

Link: http://lkml.kernel.org/r/c5d53c8f643ef6844d6ad8d0200c116936730b01.1554072478.git.tom.zanussi@linux.intel.com

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.rst    | 31 +++++++++++++++++++++++++++++++
 Documentation/trace/histogram.rst | 16 ++--------------
 2 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 7c5e6d6ab5d1..809b39d066ee 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -765,6 +765,37 @@ Here is the list of current tracers that may be configured.
 	tracers from tracing simply echo "nop" into
 	current_tracer.
 
+Error conditions
+----------------
+
+  For most ftrace commands, failure modes are obvious and communicated
+  using standard return codes.
+
+  For other more involved commands, extended error information may be
+  available via the tracing/error_log file.  For the commands that
+  support it, reading the tracing/error_log file after an error will
+  display more detailed information about what went wrong, if
+  information is available.  The tracing/error_log file is a circular
+  error log displaying a small number (currently, 8) of ftrace errors
+  for the last (8) failed commands.
+
+  The extended error information and usage takes the form shown in
+  this example::
+
+    # echo xxx > /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
+    echo: write error: Invalid argument
+
+    # cat /sys/kernel/debug/tracing/error_log
+    [ 5348.887237] location: error: Couldn't yyy: zzz
+      Command: xxx
+               ^
+    [ 7517.023364] location: error: Bad rrr: sss
+      Command: ppp qqq
+                   ^
+
+  To clear the error log, echo the empty string into it::
+
+    # echo > /sys/kernel/debug/tracing/error_log
 
 Examples of using the tracer
 ----------------------------
diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 0ea59d45aef1..7612c7ad5715 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -199,20 +199,8 @@ Extended error information
 
   For some error conditions encountered when invoking a hist trigger
   command, extended error information is available via the
-  corresponding event's 'hist' file.  Reading the hist file after an
-  error will display more detailed information about what went wrong,
-  if information is available.  This extended error information will
-  be available until the next hist trigger command for that event.
-
-  If available for a given error condition, the extended error
-  information and usage takes the following form::
-
-    # echo xxx > /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
-    echo: write error: Invalid argument
-
-    # cat /sys/kernel/debug/tracing/events/sched/sched_wakeup/hist
-    ERROR: Couldn't yyy: zzz
-      Last command: xxx
+  tracing/error_log file.  See Error Conditions in
+  :file:`Documentation/trace/ftrace.rst` for details.
 
 6.2 'hist' trigger examples
 ---------------------------
-- 
2.20.1


