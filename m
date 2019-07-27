Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A322C76186
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 22:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9B1208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 22:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="J/SKn3Th"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387823AbfG0WZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 18:25:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45696 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbfG0WZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 18:25:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so57855941wre.12
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 15:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W5nql3mIFjeqSJfu3yyAmOy5FT+uPi/k/3ukaFea3TY=;
        b=J/SKn3ThJIBjNGsxUo/WVNfk6YEc0oigwI2KPwnAI0SJAtAYViG5ltIvsr3BXqn5ps
         F13dLjoe1iuXuedSCKeNhLaM08ZM10lH+/MC5AXsWJDVkdfX2pWPF7mg8Q1OCsh7XH5U
         g8BcQH743xLlEJJUiV5VWdICY6BLm9tfdaNC4XDgCZnboW3GrC6Og0U5MSpGdJcSduj3
         mUGGgznVVF/Wrs+j6+9pSirb7ezq4+FnnFadqRfFqU0IcbfO8PUM8YKnt7nGrhd1cBVe
         zLI5mha80DIcRAJw+mFkdhVrIbK366Eu9PJz4vgFbLavG9MO0UkJWBWeqIk8kHR+/R3L
         +bYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W5nql3mIFjeqSJfu3yyAmOy5FT+uPi/k/3ukaFea3TY=;
        b=B+NuseYmCSV5pzEXMLeJ7v1Kwi4PjK7Zb4hSpDgCezyPE+dk6KN/Nsf/zPS6WT1etJ
         EFYgY5mxr26OKvWpnSS1/ZHpcHuXUNgez67DG4gbTCQWBMsx/BiDc07HEZEcskPkESCe
         y8iVIx4P9nFsfhfWKqahqSiqkjfwSGw1HYHxjZBJsY4V6Nhzm3DaYJ+hRY+bLSUyRP3A
         6/MffHb17Jm54e4sYgwdq5Cc/p86M40Iyb7M5maWi50BRkI7qEdW2eIv8HeXQeEIHMAM
         qHYJixfnzr9fgv66m6EoTVwmRWC58RYacd9yisOW9n6ZnLr+wpCF128SViGYNnnfj+jD
         D4Zw==
X-Gm-Message-State: APjAAAWGaa8NO7JRvjF61xn9VeuuaeCozfW6qnuKnICbv2yfu5oooMpp
        XGjMv74SR+JswpqlrM8DQC35QXeEgAk=
X-Google-Smtp-Source: APXvYqw0fRdpFmIFjB/UZgEFvQbw51WZDdQxRaIALNY6WB5BAkFDvEhXSRfLYDhEwNIEPz77G3n2Nw==
X-Received: by 2002:a5d:4ecc:: with SMTP id s12mr8207265wrv.157.1564266321065;
        Sat, 27 Jul 2019 15:25:21 -0700 (PDT)
Received: from localhost.localdomain ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id g8sm54978721wmf.17.2019.07.27.15.25.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 15:25:20 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     linux-kernel@vger.kernel.org, oleg@redhat.com,
        torvalds@linux-foundation.org
Cc:     arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        joel@joelfernandes.org, tglx@linutronix.de, tj@kernel.org,
        dhowells@redhat.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, kernel-team@android.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v3 2/2] pidfd: add pidfd_wait tests
Date:   Sun, 28 Jul 2019 00:22:30 +0200
Message-Id: <20190727222229.6516-3-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190727222229.6516-1-christian@brauner.io>
References: <20190727222229.6516-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tests for pidfd_wait() and CLONE_WAIT_PID:
- test that waitid(P_PIDFD) can wait on a pidfd
- test that waitid(P_PIDFD) can wait on a pidfd and return siginfo_t
- test that waitid(P_PIDFD) works with WEXITED
- test that waitid(P_PIDFD) works with WSTOPPED
- test that waitid(P_PIDFD) works with WUNTRACED
- test that waitid(P_PIDFD) works with WCONTINUED
- test that waitid(P_PIDFD) works with WNOWAIT
- test that waitid(P_PIDFD)works with WNOHANG

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
v1:
- Christian Brauner <christian@brauner.io>:
  - adapt tests to new P_PIDFD concept

v2: unchanged

v3:
- Christian Brauner <christian@brauner.io>:
- add a test for passing an invalid pidfd
---
 tools/testing/selftests/pidfd/pidfd.h      |  25 ++
 tools/testing/selftests/pidfd/pidfd_test.c |  14 --
 tools/testing/selftests/pidfd/pidfd_wait.c | 258 +++++++++++++++++++++
 3 files changed, 283 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_wait.c

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 8452e910463f..7d7d0ca05e0b 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -16,6 +16,26 @@
 
 #include "../kselftest.h"
 
+#ifndef P_PIDFD
+#define P_PIDFD 3
+#endif
+
+#ifndef CLONE_PIDFD
+#define CLONE_PIDFD 0x00001000
+#endif
+
+#ifndef __NR_pidfd_open
+#define __NR_pidfd_open -1
+#endif
+
+#ifndef __NR_pidfd_send_signal
+#define __NR_pidfd_send_signal -1
+#endif
+
+#ifndef __NR_clone3
+#define __NR_clone3 -1
+#endif
+
 /*
  * The kernel reserves 300 pids via RESERVED_PIDS in kernel/pid.c
  * That means, when it wraps around any pid < 300 will be skipped.
@@ -53,5 +73,10 @@ int wait_for_pid(pid_t pid)
 	return WEXITSTATUS(status);
 }
 
+static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
+					unsigned int flags)
+{
+	return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
+}
 
 #endif /* __PIDFD_H */
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 7eaa8a3de262..42e3eb494d72 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -21,20 +21,12 @@
 #include "pidfd.h"
 #include "../kselftest.h"
 
-#ifndef __NR_pidfd_send_signal
-#define __NR_pidfd_send_signal -1
-#endif
-
 #define str(s) _str(s)
 #define _str(s) #s
 #define CHILD_THREAD_MIN_WAIT 3 /* seconds */
 
 #define MAX_EVENTS 5
 
-#ifndef CLONE_PIDFD
-#define CLONE_PIDFD 0x00001000
-#endif
-
 static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
 {
 	size_t stack_size = 1024;
@@ -47,12 +39,6 @@ static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
 #endif
 }
 
-static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
-					unsigned int flags)
-{
-	return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
-}
-
 static int signal_received;
 
 static void set_signal_received_on_sigusr1(int sig)
diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
new file mode 100644
index 000000000000..887c086d98ab
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_wait.c
@@ -0,0 +1,258 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+#include <signal.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sched.h>
+#include <string.h>
+#include <sys/resource.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "pidfd.h"
+#include "../kselftest.h"
+
+#define ptr_to_u64(ptr) ((__u64)((uintptr_t)(ptr)))
+
+static pid_t sys_clone3(struct clone_args *args)
+{
+	return syscall(__NR_clone3, args, sizeof(struct clone_args));
+}
+
+static int sys_waitid(int which, pid_t pid, siginfo_t *info, int options,
+		      struct rusage *ru)
+{
+	return syscall(__NR_waitid, which, pid, info, options, ru);
+}
+
+static int test_pidfd_wait_simple(void)
+{
+	const char *test_name = "pidfd wait simple";
+	int pidfd = -1, status = 0;
+	pid_t parent_tid = -1;
+	struct clone_args args = {
+		.parent_tid = ptr_to_u64(&parent_tid),
+		.pidfd = ptr_to_u64(&pidfd),
+		.flags = CLONE_PIDFD | CLONE_PARENT_SETTID,
+		.exit_signal = SIGCHLD,
+	};
+	int ret;
+	pid_t pid;
+	siginfo_t info = {
+		.si_signo = 0,
+	};
+
+	pidfd = open("/proc/self", O_DIRECTORY | O_RDONLY | O_CLOEXEC);
+	if (pidfd < 0)
+		ksft_exit_fail_msg("%s test: failed to open /proc/self %s\n",
+				   test_name, strerror(errno));
+
+	pid = sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL);
+	if (pid == 0)
+		ksft_exit_fail_msg(
+			"%s test: succeeded to wait on invalid pidfd %s\n",
+			test_name, strerror(errno));
+	close(pidfd);
+	pidfd = -1;
+
+	pid = sys_clone3(&args);
+	if (pid < 0)
+		ksft_exit_fail_msg("%s test: failed to create new process %s\n",
+				   test_name, strerror(errno));
+
+	if (pid == 0)
+		exit(EXIT_SUCCESS);
+
+	pid = sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL);
+	if (pid < 0)
+		ksft_exit_fail_msg(
+			"%s test: failed to wait on process with pid %d and pidfd %d: %s\n",
+			test_name, parent_tid, pidfd, strerror(errno));
+
+	if (!WIFEXITED(info.si_status) || WEXITSTATUS(info.si_status))
+		ksft_exit_fail_msg(
+			"%s test: unexpected status received after waiting on process with pid %d and pidfd %d: %s\n",
+			test_name, parent_tid, pidfd, strerror(errno));
+	close(pidfd);
+
+	if (info.si_signo != SIGCHLD)
+		ksft_exit_fail_msg(
+			"%s test: unexpected si_signo value %d received after waiting on process with pid %d and pidfd %d: %s\n",
+			test_name, info.si_signo, parent_tid, pidfd,
+			strerror(errno));
+
+	if (info.si_code != CLD_EXITED)
+		ksft_exit_fail_msg(
+			"%s test: unexpected si_code value %d received after waiting on process with pid %d and pidfd %d: %s\n",
+			test_name, info.si_code, parent_tid, pidfd,
+			strerror(errno));
+
+	if (info.si_pid != parent_tid)
+		ksft_exit_fail_msg(
+			"%s test: unexpected si_pid value %d received after waiting on process with pid %d and pidfd %d: %s\n",
+			test_name, info.si_pid, parent_tid, pidfd,
+			strerror(errno));
+
+	ksft_test_result_pass("%s test: Passed\n", test_name);
+	return 0;
+}
+
+static int test_pidfd_wait_states(void)
+{
+	const char *test_name = "pidfd wait states";
+	int pidfd = -1, status = 0;
+	pid_t parent_tid = -1;
+	struct clone_args args = {
+		.parent_tid = ptr_to_u64(&parent_tid),
+		.pidfd = ptr_to_u64(&pidfd),
+		.flags = CLONE_PIDFD | CLONE_PARENT_SETTID,
+		.exit_signal = SIGCHLD,
+	};
+	int ret;
+	pid_t pid;
+	siginfo_t info = {
+		.si_signo = 0,
+	};
+
+	pid = sys_clone3(&args);
+	if (pid < 0)
+		ksft_exit_fail_msg("%s test: failed to create new process %s\n",
+				   test_name, strerror(errno));
+
+	if (pid == 0) {
+		kill(getpid(), SIGSTOP);
+		kill(getpid(), SIGSTOP);
+		exit(EXIT_SUCCESS);
+	}
+
+	ret = sys_waitid(P_PIDFD, pidfd, &info, WSTOPPED, NULL);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s test: failed to wait on WSTOPPED process with pid %d and pidfd %d: %s\n",
+			test_name, parent_tid, pidfd, strerror(errno));
+
+	if (info.si_signo != SIGCHLD)
+		ksft_exit_fail_msg(
+			"%s test: unexpected si_signo value %d received after waiting on process with pid %d and pidfd %d: %s\n",
+			test_name, info.si_signo, parent_tid, pidfd,
+			strerror(errno));
+
+	if (info.si_code != CLD_STOPPED)
+		ksft_exit_fail_msg(
+			"%s test: unexpected si_code value %d received after waiting on process with pid %d and pidfd %d: %s\n",
+			test_name, info.si_code, parent_tid, pidfd,
+			strerror(errno));
+
+	if (info.si_pid != parent_tid)
+		ksft_exit_fail_msg(
+			"%s test: unexpected si_pid value %d received after waiting on process with pid %d and pidfd %d: %s\n",
+			test_name, info.si_pid, parent_tid, pidfd,
+			strerror(errno));
+
+	ret = sys_pidfd_send_signal(pidfd, SIGCONT, NULL, 0);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s test: failed to send signal to process with pid %d and pidfd %d: %s\n",
+			test_name, parent_tid, pidfd, strerror(errno));
+
+	ret = sys_waitid(P_PIDFD, pidfd, &info, WCONTINUED, NULL);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s test: failed to wait WCONTINUED on process with pid %d and pidfd %d: %s\n",
+			test_name, parent_tid, pidfd, strerror(errno));
+
+	if (info.si_signo != SIGCHLD)
+		ksft_exit_fail_msg(
+			"%s test: unexpected si_signo value %d received after waiting on process with pid %d and pidfd %d: %s\n",
+			test_name, info.si_signo, parent_tid, pidfd,
+			strerror(errno));
+
+	if (info.si_code != CLD_CONTINUED)
+		ksft_exit_fail_msg(
+			"%s test: unexpected si_code value %d received after waiting on process with pid %d and pidfd %d: %s\n",
+			test_name, info.si_code, parent_tid, pidfd,
+			strerror(errno));
+
+	if (info.si_pid != parent_tid)
+		ksft_exit_fail_msg(
+			"%s test: unexpected si_pid value %d received after waiting on process with pid %d and pidfd %d: %s\n",
+			test_name, info.si_pid, parent_tid, pidfd,
+			strerror(errno));
+
+	ret = sys_waitid(P_PIDFD, pidfd, &info, WUNTRACED, NULL);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s test: failed to wait on WUNTRACED process with pid %d and pidfd %d: %s\n",
+			test_name, parent_tid, pidfd, strerror(errno));
+
+	if (info.si_signo != SIGCHLD)
+		ksft_exit_fail_msg(
+			"%s test: unexpected si_signo value %d received after waiting on process with pid %d and pidfd %d: %s\n",
+			test_name, info.si_signo, parent_tid, pidfd,
+			strerror(errno));
+
+	if (info.si_code != CLD_STOPPED)
+		ksft_exit_fail_msg(
+			"%s test: unexpected si_code value %d received after waiting on process with pid %d and pidfd %d: %s\n",
+			test_name, info.si_code, parent_tid, pidfd,
+			strerror(errno));
+
+	if (info.si_pid != parent_tid)
+		ksft_exit_fail_msg(
+			"%s test: unexpected si_pid value %d received after waiting on process with pid %d and pidfd %d: %s\n",
+			test_name, info.si_pid, parent_tid, pidfd,
+			strerror(errno));
+
+	ret = sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s test: failed to send SIGKILL to process with pid %d and pidfd %d: %s\n",
+			test_name, parent_tid, pidfd, strerror(errno));
+
+	ret = sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s test: failed to wait on WEXITED process with pid %d and pidfd %d: %s\n",
+			test_name, parent_tid, pidfd, strerror(errno));
+
+	if (info.si_signo != SIGCHLD)
+		ksft_exit_fail_msg(
+			"%s test: unexpected si_signo value %d received after waiting on process with pid %d and pidfd %d: %s\n",
+			test_name, info.si_signo, parent_tid, pidfd,
+			strerror(errno));
+
+	if (info.si_code != CLD_KILLED)
+		ksft_exit_fail_msg(
+			"%s test: unexpected si_code value %d received after waiting on process with pid %d and pidfd %d: %s\n",
+			test_name, info.si_code, parent_tid, pidfd,
+			strerror(errno));
+
+	if (info.si_pid != parent_tid)
+		ksft_exit_fail_msg(
+			"%s test: unexpected si_pid value %d received after waiting on process with pid %d and pidfd %d: %s\n",
+			test_name, info.si_pid, parent_tid, pidfd,
+			strerror(errno));
+
+	close(pidfd);
+
+	ksft_test_result_pass("%s test: Passed\n", test_name);
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	ksft_print_header();
+	ksft_set_plan(2);
+
+	test_pidfd_wait_simple();
+	test_pidfd_wait_states();
+
+	return ksft_exit_pass();
+}
-- 
2.22.0

