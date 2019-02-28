Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F291C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE7F2183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551357207;
	bh=79CVAXaCT5ykATNBoO+rgDRRbQTD1tXlrEyJUvvyVVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FtdpnT9ekFuCEbyrqnzYzlgLNw/loRnQF5eR8dAs82FT5Z9Bmui/epdixD/ETZeHi
	 wVKzh44TKLAwUapYUeDICE42mpCdUxp3zN0QItTochTCEiVlCaBUjqhj7uladfCBAC
	 7Hxaw3ApqwQqnMyBaBLo6EUkAwLAQgM6blkROJnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732589AbfB1Md0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:33:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:38808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfB1MdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:33:24 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F02F52083D;
        Thu, 28 Feb 2019 12:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551357204;
        bh=79CVAXaCT5ykATNBoO+rgDRRbQTD1tXlrEyJUvvyVVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y3T45lcIJOt+QOcMkXiI2eEcNvg/G8UMeH6SJtZFYphrzoVPk7VSmQ12XgxR0xS/f
         uM+dHFNjWp95gE5diqRz7vfwzBGaEXSPYOu0vjZVdo2HzG9+/EksFHJybAoqLI2b7p
         jHYofUXpVcub/4zJR+kMwoIZL94HmwKZkSP4loGw=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
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
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v4 6/6] selftests/ftrace: Add user-memory access syntax testcase
Date:   Thu, 28 Feb 2019 21:33:00 +0900
Message-Id: <155135718005.438.4959129860081979629.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <155135700242.438.12930250099644500209.stgit@devbox>
References: <155135700242.438.12930250099644500209.stgit@devbox>
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
 .../ftrace/test.d/kprobe/kprobe_args_user.tc       |   31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
new file mode 100644
index 000000000000..996da9d1eec5
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
@@ -0,0 +1,31 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe event user-memory access
+
+[ -f kprobe_events ] || exit_unsupported # this is configurable
+
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

