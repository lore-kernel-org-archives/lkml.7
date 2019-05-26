Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A44FC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288722171F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfEZTTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 15:19:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbfEZTSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 15:18:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E016216FD;
        Sun, 26 May 2019 19:18:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hUyfQ-0004dx-MK; Sun, 26 May 2019 15:18:48 -0400
Message-Id: <20190526191848.576284629@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 26 May 2019 15:18:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 14/16] tracing: Make a separate config for trace event self tests
References: <20190526191828.466305460@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The trace event self tests enable loop through *all* events, enables each
one, one at a time, runs some code to trigger various events (not
necessarily the same events), and checks if anything went wrong. The issue
is that trace events are usually the least likely start up test to cause a
problem, but they take the longest to run (because there are so many
events). When one of the other tests trigger a bug, the trace event start up
tests causes the bisect to take much longer, because it takes 10s of seconds
to get through the trace event tests.

By making them a separate config (even though they are enabled by default if
start up tests are set), it is possible to turn them off and still run the
other tracing start up tests much quicker.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig        | 12 +++++++++++-
 kernel/trace/trace_events.c |  2 +-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 5d965cef6c77..07d22c61b634 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -596,9 +596,19 @@ config FTRACE_STARTUP_TEST
 	  functioning properly. It will do tests on all the configured
 	  tracers of ftrace.
 
+config EVENT_TRACE_STARTUP_TEST
+	bool "Run selftest on trace events"
+	depends on FTRACE_STARTUP_TEST
+	default y
+	help
+	  This option performs a test on all trace events in the system.
+	  It basically just enables each event and runs some code that
+	  will trigger events (not necessarily the event it enables)
+	  This may take some time run as there are a lot of events.
+
 config EVENT_TRACE_TEST_SYSCALLS
 	bool "Run selftest on syscall events"
-	depends on FTRACE_STARTUP_TEST
+	depends on EVENT_TRACE_STARTUP_TEST
 	help
 	 This option will also enable testing every syscall event.
 	 It only enables the event and disables it and runs various loads
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 0ce3db67f556..edc72f3b080c 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3190,7 +3190,7 @@ void __init trace_event_init(void)
 	event_trace_enable();
 }
 
-#ifdef CONFIG_FTRACE_STARTUP_TEST
+#ifdef CONFIG_EVENT_TRACE_STARTUP_TEST
 
 static DEFINE_SPINLOCK(test_spinlock);
 static DEFINE_SPINLOCK(test_spinlock_irq);
-- 
2.20.1


