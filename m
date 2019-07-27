Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83D6C76194
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 08:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22322085A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 08:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="aUQW8c7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfG0Ix0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 04:53:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40841 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbfG0IxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 04:53:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so56692761wrl.7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 01:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XORA2wT3NIX9LqSjkoxeMI/DGRc61YiWDYsfjEiSeFA=;
        b=aUQW8c7ilVjVIjX8rIPwq0L41KV7/5RpSPTkRRQU3zmu1PktlPYNTj9SqPhg6d+Bwg
         T3Bo80iYFJy9HhUKXe8LfhhpGaZzVXeNgHJW/rWXbnEx2s/32TE1spUdAOD7dWcPz8sl
         f84d79FHxuzg5PpTNs2s6ZkybP7BaamaZfVjuTVrv23SZUW2AbITJYkn9TPREEs75Kr2
         QM0cavXjvv/C7zYIYyQN9s2Sdv2zvL7N+UQSUHIg9hmsE1FDAYqRuMcwLiyjQ30qPG0W
         4QA/7GRgDX0r5WL9Bd7WWwTcdTW421BasGD2Lv8YtpalDgcBM+/TTyp6Ryug2ZEKBH25
         AU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XORA2wT3NIX9LqSjkoxeMI/DGRc61YiWDYsfjEiSeFA=;
        b=E0sOoP2Rollmzn2BdFhCFKhwBsDTKvcdZEienQYyPDFypRjSRZSl3CwV+WwG7T99Pn
         2kW+zoT4X5PIxv+UXjQOTXhUgu5N6ux2GiiH9j2kRv4hXKyI4OKbmM4Ze/AjRZsLNcQV
         oVdAWUGJcReH3mv0qwYYLGP8oKf+QGOG/NjszeU6AEPmt7xjOOuzRM2ipNVg48jbZ1k9
         /goHBkWZm1Q1j9uAfaBTWxuScBktg5kfFvNYTrp5Bfbzkn/qwePCOjmuEnuZGjvaaNWS
         NwcpCI9N9fDQCmk2DOWs8iqd0/Jx5zQEMbi4yp5PrlyIDptIQla3RnXlTeFuqArD/pSe
         7Kqw==
X-Gm-Message-State: APjAAAXH6v46Ue6cfYkS9h6Avm8SbRE8NoFwn3D1DRAhSqmYZ6Zobf8E
        g0lxBNbyxzYDAYssE5ceKOSW3dAqhLY=
X-Google-Smtp-Source: APXvYqwGJ5ay/noHEG7X2Un8gbDPgRm2GxlBPbKCGrrOYGw7aHG91DYuXTfSokGsqboe1PsTaVOmJw==
X-Received: by 2002:a5d:62c9:: with SMTP id o9mr67168720wrv.186.1564217600290;
        Sat, 27 Jul 2019 01:53:20 -0700 (PDT)
Received: from localhost.localdomain ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id y24sm40114584wmi.10.2019.07.27.01.53.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 01:53:19 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     linux-kernel@vger.kernel.org, oleg@redhat.com
Cc:     arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        joel@joelfernandes.org, tglx@linutronix.de, tj@kernel.org,
        dhowells@redhat.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 2/2] pidfd: add pidfd_wait tests
Date:   Sat, 27 Jul 2019 10:52:01 +0200
Message-Id: <20190727085201.11743-3-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190727085201.11743-1-christian@brauner.io>
References: <20190727085201.11743-1-christian@brauner.io>
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

