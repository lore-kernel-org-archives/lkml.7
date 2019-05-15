Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4D4C04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 05:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5FA2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 05:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557898742;
	bh=VDiUnyqc05NytAODfxSffpH8wvdiZMIe54NLJsYe784=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ln3vH56ImxxYIyGuB68Rf1HG7YZspy8k17Gl3R0L1wUGr187uk6NToIPWbIPmTVxy
	 d2GonmrVAjuQMSRizBkP3ezBWeQPL/PALMpTJwodl924PcA6y0YeQr9GxMgCYwzgvo
	 p/47ZlrA8EAq3dvhVb2DRz+n3uDDUwSmmh/XX15g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfEOFjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 01:39:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfEOFjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 01:39:00 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5650620862;
        Wed, 15 May 2019 05:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557898740;
        bh=VDiUnyqc05NytAODfxSffpH8wvdiZMIe54NLJsYe784=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gMvpRZQSKc9dSDzSRojIEOTabK4pN1/xpYTHs82xRaGHSFWMAZg8W/i0b2ONhWWuS
         tjDSHCAgIrL/FtoTNY1/RWl42gyWj0YdjopymJNMRfYagHQxhNWuGKFjnHz70jLJte
         UghPAfvnHXyVSjKAZNZJGlSsnhPLwf0IXJqGSELk=
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
Subject: [PATCH -tip v9 5/6] selftests/ftrace: Add user-memory access syntax testcase
Date:   Wed, 15 May 2019 14:38:54 +0900
Message-Id: <155789873385.26965.9557271156179140676.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155789866428.26965.8344923934342528416.stgit@devnote2>
References: <155789866428.26965.8344923934342528416.stgit@devnote2>
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
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
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

