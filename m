Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E7CC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EFD208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfD0KH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 06:07:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:51468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726503AbfD0KHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 06:07:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3645ADF2;
        Sat, 27 Apr 2019 10:07:51 +0000 (UTC)
From:   Nicolai Stange <nstange@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>
Subject: [PATCH 4/4] selftests/livepatch: add "ftrace a live patched function" test
Date:   Sat, 27 Apr 2019 12:06:39 +0200
Message-Id: <20190427100639.15074-5-nstange@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190427100639.15074-1-nstange@suse.de>
References: <20190427100639.15074-1-nstange@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There had been an issue with interactions between tracing and live patching
due to how x86' CONFIG_DYNAMIC_FTRACE used to handle the breakpoints at the
updated instructions from its ftrace_int3_handler().

More specifically, starting to trace a live patched function caused a short
period in time where the live patching redirection became ineffective. In
particular, the guarantees from the consistency model couldn't be held up
in this situation.

Implement a testcase for verifying that a function's live patch replacement
is kept effective when enabling tracing on it.

Reuse the existing 'test_klp_livepatch' live patch module which patches
cmdline_proc_show(), the handler for /proc/cmdline.

Let the testcase in a loop
- apply this live patch,
- launch a background shell job enabling tracing on that function
- while continuously verifying that the contents of /proc/cmdline still
  match what would be expected when the live patch is applied.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 tools/testing/selftests/livepatch/Makefile         |  3 +-
 .../livepatch/test-livepatch-vs-ftrace.sh          | 44 ++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/livepatch/test-livepatch-vs-ftrace.sh

diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
index af4aee79bebb..bfa5353f6d17 100644
--- a/tools/testing/selftests/livepatch/Makefile
+++ b/tools/testing/selftests/livepatch/Makefile
@@ -3,6 +3,7 @@
 TEST_GEN_PROGS := \
 	test-livepatch.sh \
 	test-callbacks.sh \
-	test-shadow-vars.sh
+	test-shadow-vars.sh \
+	test-livepatch-vs-ftrace.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/livepatch/test-livepatch-vs-ftrace.sh b/tools/testing/selftests/livepatch/test-livepatch-vs-ftrace.sh
new file mode 100755
index 000000000000..5c982ec56373
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test-livepatch-vs-ftrace.sh
@@ -0,0 +1,44 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 SUSE Linux GmbH
+
+. $(dirname $0)/functions.sh
+
+set -e
+
+MOD_LIVEPATCH=test_klp_livepatch
+
+# TEST: ftrace a live patched function
+# - load a livepatch that modifies the output from /proc/cmdline
+# - install a function tracer at the live patched function
+# - verify that the function is still patched by reading /proc/cmdline
+# - unload the livepatch and make sure the patch was removed
+
+echo -n "TEST: ftrace a live patched function ... "
+dmesg -C
+
+for i in $(seq 1 3); do
+	load_lp $MOD_LIVEPATCH
+
+	( echo cmdline_proc_show > /sys/kernel/debug/tracing/set_ftrace_filter;
+	  echo function > /sys/kernel/debug/tracing/current_tracer ) &
+
+	for j in $(seq 1 200); do
+		if [[ "$(cat /proc/cmdline)" !=				\
+			"$MOD_LIVEPATCH: this has been live patched" ]] ; then
+			echo -e "FAIL\n\n"
+			die "livepatch kselftest(s) failed"
+		fi
+	done
+
+	wait %1
+
+	echo nop > /sys/kernel/debug/tracing/current_tracer
+	echo > /sys/kernel/debug/tracing/set_ftrace_filter
+
+	disable_lp $MOD_LIVEPATCH
+	unload_lp $MOD_LIVEPATCH
+done
+
+echo "ok"
+exit 0
-- 
2.13.7

