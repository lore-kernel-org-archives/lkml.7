Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA18C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4769E2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfDDBiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 21:38:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfDDBhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 21:37:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FACF21871;
        Thu,  4 Apr 2019 01:37:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hBrK5-00052G-89; Wed, 03 Apr 2019 21:37:45 -0400
Message-Id: <20190404013745.139071782@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 03 Apr 2019 21:37:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 12/19] selftests/ftrace: Move kprobe/uprobe check_error() to
 test.d/functions
References: <20190404013721.023858792@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

The k/uprobe_sytax_errors test case defines a check_error() function
used to run a command and check the position of the caret in the
output.

This would be useful for other ftrace facilities too, so move it to
test.d/functions for use by anyone.  In the process, rename it to
ftrace_errlog_check() and parametrize it for general use.

Link: http://lkml.kernel.org/r/9f88080a06f1755811f69081926afe7e5cb53178.1554072478.git.tom.zanussi@linux.intel.com

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/selftests/ftrace/test.d/functions      | 12 ++++++++++++
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc     | 10 +---------
 .../ftrace/test.d/kprobe/uprobe_syntax_errors.tc     | 10 +---------
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 7b96e80e6b8a..779ec11f61bd 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -109,3 +109,15 @@ LOCALHOST=127.0.0.1
 yield() {
     ping $LOCALHOST -c 1 || sleep .001 || usleep 1 || sleep 1
 }
+
+ftrace_errlog_check() { # err-prefix command-with-error-pos-by-^ command-file
+    pos=$(echo -n "${2%^*}" | wc -c) # error position
+    command=$(echo "$2" | tr -d ^)
+    echo "Test command: $command"
+    echo > error_log
+    (! echo "$command" > "$3" ) 2> /dev/null
+    grep "$1: error:" -A 3 error_log
+    N=$(tail -n 1 error_log | wc -c)
+    # "  Command: " and "^\n" => 13
+    test $(expr 13 + $pos) -eq $N
+}
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index 7eb577b1d222..29faaec942c6 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -7,15 +7,7 @@
 [ -f error_log ] || exit_unsupported
 
 check_error() { # command-with-error-pos-by-^
-pos=$(echo -n "${1%^*}" | wc -c) # error position
-command=$(echo "$1" | tr -d ^)
-echo "Test command: $command"
-echo > error_log
-(! echo "$command" > kprobe_events ) 2> /dev/null
-grep "trace_kprobe: error:" -A 3 error_log
-N=$(tail -n 1 error_log | wc -c)
-# "  Command: " and "^\n" => 13
-test $(expr 13 + $pos) -eq $N
+    ftrace_errlog_check 'trace_kprobe' "$1" 'kprobe_events'
 }
 
 if grep -q 'r\[maxactive\]' README; then
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
index ec7389b7934b..14229d5778a0 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/uprobe_syntax_errors.tc
@@ -7,15 +7,7 @@
 [ -f error_log ] || exit_unsupported
 
 check_error() { # command-with-error-pos-by-^
-pos=$(echo -n "${1%^*}" | wc -c) # error position
-command=$(echo "$1" | tr -d ^)
-echo "Test command: $command"
-echo > error_log
-(! echo "$command" > uprobe_events ) 2> /dev/null
-grep "trace_uprobe: error:" -A 3 error_log
-N=$(tail -n 1 error_log | wc -c)
-# "  Command: " and "^\n" => 13
-test $(expr 13 + $pos) -eq $N
+    ftrace_errlog_check 'trace_uprobe' "$1" 'uprobe_events'
 }
 
 check_error 'p ^/non_exist_file:100'	# FILE_NOT_FOUND
-- 
2.20.1


