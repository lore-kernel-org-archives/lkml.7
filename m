Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD444C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A93B23DD8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559316020;
	bh=k1BQ1yPh+N7XX9pqjnPlfC0pXckaeVezrpKaJrNHvGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jKO1zALUP0fb8Fjy8fWTEBDyBt/SdKG8o4Zz4nRHokIE5VaBezLWSMPu6NawycSiW
	 jChCDdA4djS37Isxlg6X/NO3yq2Z7yUyOcSho01C2wEmUEbG/LR9u6RtLRICxtx+C6
	 0Wo8pXYXyrWpuqQHz5hBvA4EWIkw4vyttpfTL1aY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfEaPUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfEaPUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:20:19 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EC4926B9B;
        Fri, 31 May 2019 15:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559316018;
        bh=k1BQ1yPh+N7XX9pqjnPlfC0pXckaeVezrpKaJrNHvGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UEn3AjoVBZEImDMx9gdCZyAAfnhg/YyyeWdRWu0UkWsmzFRtQxOFf/8cqEsU1u0S0
         q+IaW7XEWir7Z+f0RBgeswvbDqN2s/+wFz/cvsbZ7Mq/8vXIDMG2A4WSwHhvtiO/EK
         ObyRmpC/omwj51s2EFshHWSjAQHhv6tR8Gi2frjo=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/21] selftests/ftrace: Add syntax error test for multiprobe
Date:   Sat,  1 Jun 2019 00:20:10 +0900
Message-Id: <155931600998.28323.4989458148164676449.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155931578555.28323.16360245959211149678.stgit@devnote2>
References: <155931578555.28323.16360245959211149678.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add syntax error test cases for multiprobe appending
errors.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/testing/selftests/ftrace/test.d/functions    |    2 +-
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |   10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 779ec11f61bd..1cac8cc2cb35 100644
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

