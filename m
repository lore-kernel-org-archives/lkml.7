Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15816C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 06:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55B321734
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 06:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552891451;
	bh=Q2wrxlPrXLcFkDHNhcUzdjdBeRuKkQt34AEOPrdQUDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EEyQ6kF65jt1uDM25v5+zcbqZWxn2NoY9pvckjgdLsstUTLqPOl7qu8QjjuvK7zYd
	 0z0dpzDpyiyaLTTxcT4tcAzEeqebl4huMjjHM4zz+BTg6ojMOM0/Jx/SFhirU1b2G5
	 P9ZmeeUKG1tLIb5E1UOuabFVCaz+zp3ApjtEQ2kA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfCRGoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 02:44:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbfCRGoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 02:44:09 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E38F32085A;
        Mon, 18 Mar 2019 06:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552891449;
        bh=Q2wrxlPrXLcFkDHNhcUzdjdBeRuKkQt34AEOPrdQUDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQ1HGBtnjui/NNyBRaiii9i3poudSXNslvI1H3zAUEdaWcGl3HlZXGA0xgcYbL4Sx
         yuJpbTzn+Hl7hqgLPRL9TPrTXFpB26kl5mBjEAOQueJC/gnVw0XjiIiw6iGIB8AJm5
         Zw6nLXQwmaTXQwT5yHZ5B7THkIDagNwMd44PWbrc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com
Subject: [RFC PATCH v6 5/6] selftests/ftrace: Add user-memory access syntax testcase
Date:   Mon, 18 Mar 2019 15:44:03 +0900
Message-Id: <155289144369.7218.15236944970162206835.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155289137555.7218.9282784065958321058.stgit@devnote2>
References: <155289137555.7218.9282784065958321058.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a user-memory access syntax testcase which checks
new user-memory access syntax and ustring type.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v6:
  - Add $argN availability check
---
 .../ftrace/test.d/kprobe/kprobe_args_user.tc       |   32 ++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
new file mode 100644
index 000000000000..0f60087583d8
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
@@ -0,0 +1,32 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe event user-memory access
+
+[ -f kprobe_events ] || exit_unsupported # this is configurable
+
+grep -q '\$arg<N>' README || exit_unresolved # depends on arch
+grep -A10 "fetcharg:" README | grep -q 'ustring' || exit_unsupported
+grep -A10 "fetcharg:" README | grep -q '\[u\]<offset>' || exit_unsupported
+
+:;: "user-memory access syntax and ustring working on user memory";:
+echo 'p:myevent do_sys_open path=+0($arg2):ustring path2=+u0($arg2):string' \
+	> kprobe_events
+
+grep myevent kprobe_events | \
+	grep -q 'path=+0($arg2):ustring path2=+u0($arg2):string'
+echo 1 > events/kprobes/myevent/enable
+echo > /dev/null
+echo 0 > events/kprobes/myevent/enable
+
+grep myevent trace | grep -q 'path="/dev/null" path2="/dev/null"'
+
+:;: "user-memory access syntax and ustring not working with kernel memory";:
+echo 'p:myevent vfs_symlink path=+0($arg3):ustring path2=+u0($arg3):string' \
+	> kprobe_events
+echo 1 > events/kprobes/myevent/enable
+ln -s foo $TMPDIR/bar
+echo 0 > events/kprobes/myevent/enable
+
+grep myevent trace | grep -q 'path=(fault) path2=(fault)'
+
+exit 0

