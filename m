Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBBDC76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B7E22CB9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="gDX4zze0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfGZJlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:41:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43615 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfGZJlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:41:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so53683892wru.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 02:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jGJO60BGRfv0UwsNco+vPhFtEwujYOvVXKIXwQ+ynCQ=;
        b=gDX4zze0R2o2iXPvZ+fJveRTo2g33vYDGTpCuRCQY9DurpB1TaCaMP/5KHfsjvJ2yS
         pXtOttKQdk1I7m4I9LDKwH5WQZvhWoVVVxFoM59I21wrTIQC3ulwbcD4X8E0XpcI/Ex9
         ZVth4yvA6GhXtjikt3xwvR5wPvtnNhbuVtwWuh2sHDecpWdqFVRegjzrMst3c6xv5H6n
         rYcon3yTs/GFUTh/++MXsxRTyCS47KhpQkUenUJCDj3PhkAggGbR8g4UxiSAvk4vqILA
         hZqQgwAGBQ0yNnbEeaKWAvC/lW5+A2cYhopc9WZQO//0Mq4crKOtTvEDoSK61FgpJDKf
         ZSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jGJO60BGRfv0UwsNco+vPhFtEwujYOvVXKIXwQ+ynCQ=;
        b=VUvK/MlD8EHmpP8+iqnga3o1FWe1Xq1c3e9ZMFIrorIxaXH8JUVX+soWZCzwSrhtZ0
         3ngx1NP330aMsq4UdOuwdbIbxCv7Mz859C4SE5lUBeBdyhX0hGi2scMF5qdfNDcieOaD
         DSMXW2UWaKsluISontd2hvW0kqEaqlim6uWf9/sB9YG6VIL2J+Bvpsaj1qKRIM0S1AFH
         ubB1mlUmMzsQBgYlfG6Utr0kU666H0IdTS/f9tcsnUalJb76St/WpLA4b2yQGcRg6rcN
         PQkIkVPtqxQDI4w7u91X/UokbH6icUjk7ZwU6dEM5aFTgyqAK1opIuiqDCLDVpBXir17
         cneA==
X-Gm-Message-State: APjAAAWnaE8Q6DGbzNv5sdk5C4oRUje7pACbOOPJ8SlPBn1AcEiLmd6j
        RBbVdxscYGn2odbRw3VlhSZNCYMkP34=
X-Google-Smtp-Source: APXvYqwOERcca6Jycz2UpfNdg60A9BigLTUkM1foiwh6hBqDy2xfdBe8JHBQmqh3qrOe54+Rn6BRKQ==
X-Received: by 2002:adf:f851:: with SMTP id d17mr101113985wrq.77.1564134066312;
        Fri, 26 Jul 2019 02:41:06 -0700 (PDT)
Received: from localhost.localdomain ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id r12sm61664892wrt.95.2019.07.26.02.41.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 02:41:05 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     linux-kernel@vger.kernel.org, oleg@redhat.com
Cc:     arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        joel@joelfernandes.org, tglx@linutronix.de, tj@kernel.org,
        dhowells@redhat.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 2/2] pidfd: add pidfd_wait tests
Date:   Fri, 26 Jul 2019 11:39:34 +0200
Message-Id: <20190726093934.13557-3-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726093934.13557-1-christian@brauner.io>
References: <20190726093934.13557-1-christian@brauner.io>
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
---
 tools/testing/selftests/pidfd/pidfd.h      |  25 +++
 tools/testing/selftests/pidfd/pidfd_test.c |  14 --
 tools/testing/selftests/pidfd/pidfd_wait.c | 245 +++++++++++++++++++++
 3 files changed, 270 insertions(+), 14 deletions(-)
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
index 000000000000..018d806032c0
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_wait.c
@@ -0,0 +1,245 @@
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
+	const char *test_name = "pidfd wait siginfo";
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
+			"%s test: failed to wait on process with pid %d and pidfd %d: %s\n",
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
+			"%s test: failed to wait on process with pid %d and pidfd %d: %s\n",
+			test_name, parent_tid, pidfd, strerror(errno));
+
+	ret = sys_waitid(P_PIDFD, pidfd, &info, WCONTINUED, NULL);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s test: failed to wait on process with pid %d and pidfd %d: %s\n",
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
+			"%s test: failed to wait on process with pid %d and pidfd %d: %s\n",
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
+			"%s test: failed to wait on process with pid %d and pidfd %d: %s\n",
+			test_name, parent_tid, pidfd, strerror(errno));
+
+	ret = sys_waitid(P_PIDFD, pidfd, &info, WEXITED, NULL);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s test: failed to wait on process with pid %d and pidfd %d: %s\n",
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

