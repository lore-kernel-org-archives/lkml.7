Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8573C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA7A2145D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390732AbfIEPof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:44:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390533AbfIEPnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:43:43 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFE97218AF;
        Thu,  5 Sep 2019 15:43:43 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1i5tvC-0007Zv-AN; Thu, 05 Sep 2019 11:43:42 -0400
Message-Id: <20190905154342.209092701@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 11:43:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 16/25] selftests/ftrace: Add syntax error test for multiprobe
References: <20190905154258.573706229@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add syntax error test cases for multiprobe appending
errors.

Link: http://lkml.kernel.org/r/156095694541.28024.11918630805148623119.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/selftests/ftrace/test.d/functions        |  2 +-
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc       | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 1d96c5f7e402..86986c4bba54 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -115,7 +115,7 @@ ftrace_errlog_check() { # err-prefix command-with-error-pos-by-^ command-file
     command=$(echo "$2" | tr -d ^)
     echo "Test command: $command"
     echo > error_log
-    (! echo "$command" > "$3" ) 2> /dev/null
+    (! echo "$command" >> "$3" ) 2> /dev/null
     grep "$1: error:" -A 3 error_log
     N=$(tail -n 1 error_log | wc -c)
     # "  Command: " and "^\n" => 13
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index aa59944bcace..39ef7ac1f51c 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -87,4 +87,14 @@ case $(uname -m) in
     ;;
 esac
 
+# multiprobe errors
+if grep -q "Create/append/" README && grep -q "imm-value" README; then
+echo 'p:kprobes/testevent _do_fork' > kprobe_events
+check_error '^r:kprobes/testevent do_exit'	# DIFF_PROBE_TYPE
+echo 'p:kprobes/testevent _do_fork abcd=\1' > kprobe_events
+check_error 'p:kprobes/testevent _do_fork ^bcd=\1'	# DIFF_ARG_TYPE
+check_error 'p:kprobes/testevent _do_fork ^abcd=\1:u8'	# DIFF_ARG_TYPE
+check_error 'p:kprobes/testevent _do_fork ^abcd=\"foo"'	# DIFF_ARG_TYPE
+fi
+
 exit 0
-- 
2.20.1


