Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB1CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA892084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387619AbfJVAFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:05:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387553AbfJVAFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:05:08 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgwx-0003v4-D0; Tue, 22 Oct 2019 01:18:55 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 928781C03AB;
        Tue, 22 Oct 2019 01:18:54 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:18:54 -0000
From:   "tip-bot2 for Leo Yan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tests: Disable bp_signal testing for arm64
Cc:     Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191018085531.6348-3-leo.yan@linaro.org>
References: <20191018085531.6348-3-leo.yan@linaro.org>
MIME-Version: 1.0
Message-ID: <157169993406.29376.12473771029179755767.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     6a5f3d94cb69a185b921cb92c39888dc31009acb
Gitweb:        https://git.kernel.org/tip/6a5f3d94cb69a185b921cb92c39888dc31009acb
Author:        Leo Yan <leo.yan@linaro.org>
AuthorDate:    Fri, 18 Oct 2019 16:55:31 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 19 Oct 2019 15:35:01 -03:00

perf tests: Disable bp_signal testing for arm64

As there are several discussions for enabling perf breakpoint signal
testing on arm64 platform: arm64 needs to rely on single-step to execute
the breakpointed instruction and then reinstall the breakpoint exception
handler.  But if we hook the breakpoint with a signal, the signal
handler will do the stepping rather than the breakpointed instruction,
this causes infinite loops as below:

         Kernel space              |            Userspace
  ---------------------------------|--------------------------------
                                   |  __test_function() -> hit
				   |                       breakpoint
  breakpoint_handler()             |
    `-> user_enable_single_step()  |
  do_signal()                      |
                                   |  sig_handler() -> Step one
				   |                instruction and
				   |                trap to kernel
  single_step_handler()            |
    `-> reinstall_suspended_bps()  |
                                   |  __test_function() -> hit
				   |     breakpoint again and
				   |     repeat up flow infinitely

As Will Deacon mentioned [1]: "that we require the overflow handler to
do the stepping on arm/arm64, which is relied upon by GDB/ptrace. The
hw_breakpoint code is a complete disaster so my preference would be to
rip out the perf part and just implement something directly in ptrace,
but it's a pretty horrible job".  Though Will commented this on arm
architecture, but the comment also can apply on arm64 architecture.

For complete information, I searched online and found a few years back,
Wang Nan sent one patch 'arm64: Store breakpoint single step state into
pstate' [2]; the patch tried to resolve this issue by avoiding single
stepping in signal handler and defer to enable the signal stepping when
return to __test_function().  The fixing was not merged due to the
concern for missing to handle different usage cases.

Based on the info, the most feasible way is to skip Perf breakpoint
signal testing for arm64 and this could avoid the duplicate
investigation efforts when people see the failure.  This patch skips
this case on arm64 platform, which is same with arm architecture.

[1] https://lkml.org/lkml/2018/11/15/205
[2] https://lkml.org/lkml/2015/12/23/477

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Will Deacon <will@kernel.org>
Link: http://lore.kernel.org/lkml/20191018085531.6348-3-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bp_signal.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index c1c2c13..166f411 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -49,14 +49,6 @@ asm (
 	"__test_function:\n"
 	"incq (%rdi)\n"
 	"ret\n");
-#elif defined (__aarch64__)
-extern void __test_function(volatile long *ptr);
-asm (
-	".globl __test_function\n"
-	"__test_function:\n"
-	"str x30, [x0]\n"
-	"ret\n");
-
 #else
 static void __test_function(volatile long *ptr)
 {
@@ -302,10 +294,15 @@ bool test__bp_signal_is_supported(void)
 	 * stepping into the SIGIO handler and getting stuck on the
 	 * breakpointed instruction.
 	 *
+	 * Since arm64 has the same issue with arm for the single-step
+	 * handling, this case also gets suck on the breakpointed
+	 * instruction.
+	 *
 	 * Just disable the test for these architectures until these
 	 * issues are resolved.
 	 */
-#if defined(__powerpc__) || defined(__s390x__) || defined(__arm__)
+#if defined(__powerpc__) || defined(__s390x__) || defined(__arm__) || \
+    defined(__aarch64__)
 	return false;
 #else
 	return true;
