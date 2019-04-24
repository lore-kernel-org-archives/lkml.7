Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9739C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BDB2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fuH9kVme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfDXXMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:12:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38125 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfDXXMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:12:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id 10so10103967pfo.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0xopY1lmZ8N5OeEKtF78e6u48ARcCoPF6av4+vwYGRo=;
        b=fuH9kVme655YR5+nnR2nihLgcQ86AQlQoJdRaP1bm40T75402xyGkug5CGctC0ndSq
         h/ZAvfTG9ylfp3Oun4SpdYTeppMljuo9s9wlJucapoqouh9hmeZhZSBt7dNIFWqYscTP
         L+EYYBsQWUzVrkFdFMfe9YGvfPmsm+eH8sYwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0xopY1lmZ8N5OeEKtF78e6u48ARcCoPF6av4+vwYGRo=;
        b=QCQrLCsEZpchSqlqAWQFZ8QUdMetZCaIOaMPX1Bxnr9bMFWS/2kdg9oZ/M8nVf6VBn
         +FOAR+0NDNADkxl+6kukSQOr//uiAkNnoYWBEY/eOmPm3B+TqRB67JEqgUo6YEGmWbag
         7FZcc45DC447YPeSLVy7BWEXtELWePd/aMZ86NkFrO/GAApjxAD+MiiX98BBdUcq313o
         RrVmbOQC3CXDbGw8lT+luIg6DiuQzvR7wQseNtds0TJXa0GVXyb0NLmd9+EH++32hCGA
         jrZwn0mAOvEsAC6rakoY75E2ybWYtx8tMgDmPJPTamVUfbNBWR3RD2rvaCRQSsYcX5M9
         IxjA==
X-Gm-Message-State: APjAAAV0zUBRkzeZq+medWgsupWk6u5cs/Zrou5gZCPWb5lPWzAcTtYE
        Q9VRdWSDoMIB4WV886dc/FHSHA==
X-Google-Smtp-Source: APXvYqzcqsWTHWTUtQU4LHsPUM4bh0obWKd8JT1CxFHpaiQ+cRNdj4bl4HkHA6mXfHdwDDcFt/NJZA==
X-Received: by 2002:a65:518d:: with SMTP id h13mr33759514pgq.259.1556147566777;
        Wed, 24 Apr 2019 16:12:46 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id j22sm27387266pfn.129.2019.04.24.16.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 16:12:44 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        Serge Hallyn <serge@hallyn.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] selftests: Add test plan API to kselftest.h and adjust callers
Date:   Wed, 24 Apr 2019 16:12:37 -0700
Message-Id: <20190424231237.14776-9-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424231237.14776-1-keescook@chromium.org>
References: <20190424231237.14776-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test plan for TAP needs to be declared immediately after the header.
This adds the test plan API to kselftest.h and updates all callers to
declare their expected test counts.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../selftests/breakpoints/breakpoint_test.c       | 15 ++++++++++++---
 .../selftests/breakpoints/breakpoint_test_arm64.c |  3 ++-
 .../breakpoints/step_after_suspend_test.c         |  8 ++++++++
 .../testing/selftests/capabilities/test_execve.c  |  6 ++++--
 .../selftests/futex/functional/futex_requeue_pi.c |  1 +
 .../functional/futex_requeue_pi_mismatched_ops.c  |  1 +
 .../functional/futex_requeue_pi_signal_restart.c  |  1 +
 .../functional/futex_wait_private_mapped_file.c   |  1 +
 .../futex/functional/futex_wait_timeout.c         |  1 +
 .../functional/futex_wait_uninitialized_heap.c    |  1 +
 .../futex/functional/futex_wait_wouldblock.c      |  1 +
 tools/testing/selftests/kselftest.h               | 13 +++++++++++--
 .../selftests/membarrier/membarrier_test.c        |  1 +
 tools/testing/selftests/pidfd/pidfd_test.c        |  1 +
 tools/testing/selftests/sigaltstack/sas.c         |  1 +
 tools/testing/selftests/sync/sync_test.c          |  1 +
 16 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/breakpoints/breakpoint_test.c b/tools/testing/selftests/breakpoints/breakpoint_test.c
index 901b85ea6a59..8f3655e59020 100644
--- a/tools/testing/selftests/breakpoints/breakpoint_test.c
+++ b/tools/testing/selftests/breakpoints/breakpoint_test.c
@@ -21,6 +21,8 @@
 
 #include "../kselftest.h"
 
+#define COUNT_ISN_BPS	4
+#define COUNT_WPS	4
 
 /* Breakpoint access modes */
 enum {
@@ -220,7 +222,7 @@ static void trigger_tests(void)
 			if (!local && !global)
 				continue;
 
-			for (i = 0; i < 4; i++) {
+			for (i = 0; i < COUNT_ISN_BPS; i++) {
 				dummy_funcs[i]();
 				check_trapped();
 			}
@@ -292,7 +294,7 @@ static void launch_instruction_breakpoints(char *buf, int local, int global)
 {
 	int i;
 
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < COUNT_ISN_BPS; i++) {
 		set_breakpoint_addr(dummy_funcs[i], i);
 		toggle_breakpoint(i, BP_X, 1, local, global, 1);
 		ptrace(PTRACE_CONT, child_pid, NULL, 0);
@@ -314,7 +316,7 @@ static void launch_watchpoints(char *buf, int mode, int len,
 	else
 		mode_str = "read";
 
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < COUNT_WPS; i++) {
 		set_breakpoint_addr(&dummy_var[i], i);
 		toggle_breakpoint(i, mode, len, local, global, 1);
 		ptrace(PTRACE_CONT, child_pid, NULL, 0);
@@ -330,8 +332,15 @@ static void launch_watchpoints(char *buf, int mode, int len,
 static void launch_tests(void)
 {
 	char buf[1024];
+	unsigned int tests = 0;
 	int len, local, global, i;
 
+	tests += 3 * COUNT_ISN_BPS;
+	tests += sizeof(long) / 2 * 3 * COUNT_WPS;
+	tests += sizeof(long) / 2 * 3 * COUNT_WPS;
+	tests += 2;
+	ksft_set_plan(tests);
+
 	/* Instruction breakpoints */
 	for (local = 0; local < 2; local++) {
 		for (global = 0; global < 2; global++) {
diff --git a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
index 2d95e5adde72..ab59d814341a 100644
--- a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
+++ b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
@@ -118,7 +118,7 @@ static bool set_watchpoint(pid_t pid, int size, int wp)
 	return false;
 }
 
-static bool run_test(int wr_size, int wp_size, int wr, int wp)
+static bool arun_test(int wr_size, int wp_size, int wr, int wp)
 {
 	int status;
 	siginfo_t siginfo;
@@ -214,6 +214,7 @@ int main(int argc, char **argv)
 	bool result;
 
 	ksft_print_header();
+	ksft_set_plan(213);
 
 	act.sa_handler = sigalrm;
 	sigemptyset(&act.sa_mask);
diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index f82dcc1f8841..cf868b5e00f7 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -173,6 +173,7 @@ int main(int argc, char **argv)
 	int opt;
 	bool do_suspend = true;
 	bool succeeded = true;
+	unsigned int tests = 0;
 	cpu_set_t available_cpus;
 	int err;
 	int cpu;
@@ -191,6 +192,13 @@ int main(int argc, char **argv)
 		}
 	}
 
+	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
+		if (!CPU_ISSET(cpu, &available_cpus))
+			continue;
+		tests++;
+	}
+	ksft_set_plan(tests);
+
 	if (do_suspend)
 		suspend();
 
diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
index 3ab39a61b95b..df0ef02b4036 100644
--- a/tools/testing/selftests/capabilities/test_execve.c
+++ b/tools/testing/selftests/capabilities/test_execve.c
@@ -430,8 +430,6 @@ int main(int argc, char **argv)
 {
 	char *tmp1, *tmp2, *our_path;
 
-	ksft_print_header();
-
 	/* Find our path */
 	tmp1 = strdup(argv[0]);
 	if (!tmp1)
@@ -445,6 +443,8 @@ int main(int argc, char **argv)
 	mpid = getpid();
 
 	if (fork_wait()) {
+		ksft_print_header();
+		ksft_set_plan(12);
 		ksft_print_msg("[RUN]\t+++ Tests with uid == 0 +++\n");
 		return do_tests(0, our_path);
 	}
@@ -452,6 +452,8 @@ int main(int argc, char **argv)
 	ksft_print_msg("==================================================\n");
 
 	if (fork_wait()) {
+		ksft_print_header();
+		ksft_set_plan(9);
 		ksft_print_msg("[RUN]\t+++ Tests with uid != 0 +++\n");
 		return do_tests(1, our_path);
 	}
diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
index 54cd5c414e82..8d20957f7586 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -395,6 +395,7 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
+	ksft_set_plan(1);
 	ksft_print_msg("%s: Test requeue functionality\n", basename(argv[0]));
 	ksft_print_msg(
 		"\tArguments: broadcast=%d locked=%d owner=%d timeout=%ldns\n",
diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_ops.c b/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_ops.c
index 08187a16507f..742624c59ba7 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_ops.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_ops.c
@@ -79,6 +79,7 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
+	ksft_set_plan(1);
 	ksft_print_msg("%s: Detect mismatched requeue_pi operations\n",
 	       basename(argv[0]));
 
diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c b/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c
index f0542a344d95..a0f5934707ff 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c
@@ -144,6 +144,7 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
+	ksft_set_plan(1);
 	ksft_print_msg("%s: Test signal handling during requeue_pi\n",
 	       basename(argv[0]));
 	ksft_print_msg("\tArguments: <none>\n");
diff --git a/tools/testing/selftests/futex/functional/futex_wait_private_mapped_file.c b/tools/testing/selftests/futex/functional/futex_wait_private_mapped_file.c
index 6216de828093..a458d42ff86e 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_private_mapped_file.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_private_mapped_file.c
@@ -98,6 +98,7 @@ int main(int argc, char **argv)
 	}
 
 	ksft_print_header();
+	ksft_set_plan(1);
 	ksft_print_msg(
 		"%s: Test the futex value of private file mappings in FUTEX_WAIT\n",
 		basename(argv[0]));
diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
index bab3dfe1787f..04b95478059c 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -69,6 +69,7 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
+	ksft_set_plan(1);
 	ksft_print_msg("%s: Block on a futex and wait for timeout\n",
 	       basename(argv[0]));
 	ksft_print_msg("\tArguments: timeout=%ldns\n", timeout_ns);
diff --git a/tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c b/tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c
index 26975322545b..3a1d12a14921 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c
@@ -100,6 +100,7 @@ int main(int argc, char **argv)
 	}
 
 	ksft_print_header();
+	ksft_set_plan(1);
 	ksft_print_msg("%s: Test the uninitialized futex value in FUTEX_WAIT\n",
 	       basename(argv[0]));
 
diff --git a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
index da15a63269b4..a34a6bbc30ce 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
@@ -65,6 +65,7 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
+	ksft_set_plan(1);
 	ksft_print_msg("%s: Test the unexpected futex value in FUTEX_WAIT\n",
 	       basename(argv[0]));
 
diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 7f078e79a9fa..ec15c4f6af55 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -33,6 +33,7 @@ struct ksft_count {
 };
 
 static struct ksft_count ksft_cnt;
+static unsigned int ksft_plan;
 
 static inline int ksft_test_num(void)
 {
@@ -61,13 +62,21 @@ static inline void ksft_print_header(void)
 		printf("TAP version 13\n");
 }
 
+static inline void ksft_set_plan(unsigned int plan)
+{
+	ksft_plan = plan;
+	printf("1..%d\n", ksft_plan);
+}
+
 static inline void ksft_print_cnts(void)
 {
+	if (ksft_plan != ksft_test_num())
+		printf("# Planned tests != run tests (%u != %u)\n",
+			ksft_plan, ksft_test_num());
 	printf("# Pass %d Fail %d Xfail %d Xpass %d Skip %d Error %d\n",
 		ksft_cnt.ksft_pass, ksft_cnt.ksft_fail,
 		ksft_cnt.ksft_xfail, ksft_cnt.ksft_xpass,
 		ksft_cnt.ksft_xskip, ksft_cnt.ksft_error);
-	printf("1..%d\n", ksft_test_num());
 }
 
 static inline void ksft_print_msg(const char *msg, ...)
@@ -172,7 +181,7 @@ static inline int ksft_exit_skip(const char *msg, ...)
 		va_list args;
 
 		va_start(args, msg);
-		printf("not ok %d # SKIP ", ksft_test_num());
+		printf("not ok %d # SKIP ", 1 + ksft_test_num());
 		vprintf(msg, args);
 		va_end(args);
 	} else {
diff --git a/tools/testing/selftests/membarrier/membarrier_test.c b/tools/testing/selftests/membarrier/membarrier_test.c
index 6793f8ecc8e7..70b4ddbf126b 100644
--- a/tools/testing/selftests/membarrier/membarrier_test.c
+++ b/tools/testing/selftests/membarrier/membarrier_test.c
@@ -304,6 +304,7 @@ static int test_membarrier_query(void)
 int main(int argc, char **argv)
 {
 	ksft_print_header();
+	ksft_set_plan(13);
 
 	test_membarrier_query();
 	test_membarrier();
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index d59378a93782..5bae1792e3d6 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -371,6 +371,7 @@ static int test_pidfd_send_signal_syscall_support(void)
 int main(int argc, char **argv)
 {
 	ksft_print_header();
+	ksft_set_plan(4);
 
 	test_pidfd_send_signal_syscall_support();
 	test_pidfd_send_signal_simple_success();
diff --git a/tools/testing/selftests/sigaltstack/sas.c b/tools/testing/selftests/sigaltstack/sas.c
index 228c2ae47687..ad0f8df2ca0a 100644
--- a/tools/testing/selftests/sigaltstack/sas.c
+++ b/tools/testing/selftests/sigaltstack/sas.c
@@ -109,6 +109,7 @@ int main(void)
 	int err;
 
 	ksft_print_header();
+	ksft_set_plan(3);
 
 	sigemptyset(&act.sa_mask);
 	act.sa_flags = SA_ONSTACK | SA_SIGINFO;
diff --git a/tools/testing/selftests/sync/sync_test.c b/tools/testing/selftests/sync/sync_test.c
index 7f7938263c5c..3824b66f41a0 100644
--- a/tools/testing/selftests/sync/sync_test.c
+++ b/tools/testing/selftests/sync/sync_test.c
@@ -86,6 +86,7 @@ int main(void)
 	int err;
 
 	ksft_print_header();
+	ksft_set_plan(3 + 7);
 
 	sync_api_supported();
 
-- 
2.17.1

