Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA96C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB6421971
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553268905;
	bh=qKOBR8Fq3o4q24GhiprEsTC4RogHh718Qlgu8qkrbWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=VzjZ94uyCyU+saz650sEmtzLt92jraaYtY9bJwDeuiHTI/MqaHgGOHj48E1HJz0L2
	 WXuxsLzfH9lqnV8byNwf2mvdjsOa+ya2QbB5firVsWIqeWqHyhLNX3s6/YIihHpbrS
	 18frw4hH8wKd5IfvpwcgF5VMYxY+YtnZpYre24F4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfCVPfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:35:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbfCVPfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:35:00 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 575DE21A4A;
        Fri, 22 Mar 2019 15:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553268899;
        bh=qKOBR8Fq3o4q24GhiprEsTC4RogHh718Qlgu8qkrbWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=WS0JWi006Ekl/KeT4jUcWPQpUWnzlojFpT0ySnzih8psoNV2OQTLQqKxPKWMkt4tu
         PhJ7t5Z7LTYFFbQ/HiLIQ2PjYgME5YqZTBH7geE1Jdqw8hVxuEYruSsaRBnIDOhddE
         G2yv/wMPOwXLwc8oGiTyL7S7q+wyEPWMj9l54S78=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v4 09/11] tracing: Add tracing/error_log Documentation
Date:   Fri, 22 Mar 2019 10:34:35 -0500
Message-Id: <7ee9b7802cefcd6b33d5cb7e82a1c1b741c5d028.1553268041.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1553268040.git.tom.zanussi@linux.intel.com>
References: <cover.1553268040.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1553268040.git.tom.zanussi@linux.intel.com>
References: <cover.1553268040.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Move most of the hist trigger extended error documentation to
ftrace.rst and expand on it to fully document tracing/error_log.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
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
2.14.1

