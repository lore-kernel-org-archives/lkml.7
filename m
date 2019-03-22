Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B383DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86315218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfCVTJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:09:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbfCVTJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 15:09:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C304218FE;
        Fri, 22 Mar 2019 19:09:25 +0000 (UTC)
Date:   Fri, 22 Mar 2019 15:09:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuahkhan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] selftests/ftrace: Select an existing function in
 kprobe_eventname test
Message-ID: <20190322150923.1b58eca5@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

Running the ftrace selftests on the latest kernel caused the
kprobe_eventname test to fail. It was due to the test that searches for
a function with at "dot" in the name and adding a probe to that.
Unfortunately, for this test, it picked:

 optimize_nops.isra.2.cold.4

Which happens to be marked as "__init", which means it no longer exists
in the kernel! (kallsyms keeps those function names around for tracing
purposes)

As only functions that still exist are in the
available_filter_functions file, as they are removed when the functions
are freed at boot or module exit, have the test search for a function
with ".isra." in the name as well as being in the
available_filter_functions (if the file exists).

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
index 3fb70e01b1fe..3ff236719b6e 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
@@ -24,7 +24,21 @@ test -d events/kprobes2/event2 || exit_failure
 
 :;: "Add an event on dot function without name" ;:
 
-FUNC=`grep -m 10 " [tT] .*\.isra\..*$" /proc/kallsyms | tail -n 1 | cut -f 3 -d " "`
+find_dot_func() {
+	if [ ! -f available_filter_functions ]; then
+		grep -m 10 " [tT] .*\.isra\..*$" /proc/kallsyms | tail -n 1 | cut -f 3 -d " "
+		return;
+	fi
+
+	grep " [tT] .*\.isra\..*" /proc/kallsyms | cut -f 3 -d " " | while read f; do
+		if grep -s $f available_filter_functions; then
+			echo $f
+			break
+		fi
+	done
+}
+
+FUNC=`find_dot_func | tail -n 1`
 [ "x" != "x$FUNC" ] || exit_unresolved
 echo "p $FUNC" > kprobe_events
 EVENT=`grep $FUNC kprobe_events | cut -f 1 -d " " | cut -f 2 -d:`
