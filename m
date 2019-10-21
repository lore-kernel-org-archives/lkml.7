Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E30CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3F821BE5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665266;
	bh=/yMYdILkEZpciGS3rhWRI3Vk6HWst0iqEjJYsYFZioc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mftCeGlLUndNXFikb7HWrGRC/yvYUZ4PJSa8hNkbCc2mKjs/8HbqCLCFJSg85za0a
	 v7DBv99OYa4ZEEioCrM5AzJqS70pF/4vwZPXu078je/fyKVK3e4LQsWGCLvMxBeN/a
	 zb2XkOFUaXFi9+DnCgMyq2imNjpFMO8awP01wHZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbfJUNlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:41:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729001AbfJUNlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:41:00 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2240D21783;
        Mon, 21 Oct 2019 13:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665259;
        bh=/yMYdILkEZpciGS3rhWRI3Vk6HWst0iqEjJYsYFZioc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=clFRhUYjybmHd9H6I+nvh3jXC0nFctKgSBRvLrTS7vt5LVbrQ923tHok2KYQxluaQ
         OCMBvnSiwCNR35NbIDM64C53k6Chi/f319q0fVGDcts2rc7z3z+4IzyGROPGtnyNif
         SFfISwlJLvtTPNYbvUpxTvf567w37q7+0he7N3bA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 42/57] perf tests: Disable bp_signal testing for arm64
Date:   Mon, 21 Oct 2019 10:38:19 -0300
Message-Id: <20191021133834.25998-43-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

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
index c1c2c13de254..166f411568a5 100644
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
-- 
2.21.0

