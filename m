Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FCBC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8772C20678
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="GUt90mBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbfDYTAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:00:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38337 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfDYTAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:00:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so301713pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZZmg+vFR4tPKaX56SK4SSqAQgo7Z9G28nKX2pBYiJnE=;
        b=GUt90mBMWKKnenpnESwhb1sow6eokCGLQUmq5YaMiFBCOyfSfEkpGQr6JaLe7VhwaC
         qOxLpLCJYk8pa8EKkrXva2PW2TZNwqlC+0cWYK3VtKYiIBhPKDHaYKxSRc0c8rAzhmiw
         oJBN7xhg//7ZDJUDHChdauR4JdBevzTep0pyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZZmg+vFR4tPKaX56SK4SSqAQgo7Z9G28nKX2pBYiJnE=;
        b=lQ7d9k129eWiobIVXMIomZuisGPa58MleoZjJZjF24RqqXohyGy+GoTbcG2KxkPyjR
         qf7xpbnjeMo29TIe5Icjq8iGJf523GVs2V+Z5UB4IzU2SQH+wOqNcqfRBPxm5jtEq4j3
         QvngjBjqUVN8PWElaciUS8m7qqDfe4Rz4f64MvvS1ks+wv7d7Urbxcco6SQntet5NgZo
         vht9aBWlU0oe3UurAzAgFAB/jvs8T4AfWbl/0pMlH5jEj66zLEsiWNGziVHGxctmfLTs
         Y4/Sp9oOm8g7sB8oUb3+qUPFt306h4dYSqx5diJVqEMQ7+rdXPQSxVe1o42lBa1vMlYa
         7UjA==
X-Gm-Message-State: APjAAAXHvlZPBPTI7e1kTVT4h4RxkGkJldR6ug0HNDY96/wzp3st35Qd
        1He5NRlSzoH2m17EuB9+uhCIhILw1fQ=
X-Google-Smtp-Source: APXvYqzLKDwlRdqQZxGeLDG7zMZoILZ6Gt6xUVYUA57HhNoAcQ9am6KOpcnbWPVIVZFwMAEzN7Py9w==
X-Received: by 2002:aa7:9627:: with SMTP id r7mr41453436pfg.245.1556218830955;
        Thu, 25 Apr 2019 12:00:30 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o14sm25480683pgn.4.2019.04.25.12.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:00:29 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>, dancol@google.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, jannh@google.com,
        Jann Horn <jann@thejh.net>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        kernel-team@android.com, linux-kselftest@vger.kernel.org,
        luto@amacapital.net, Michal Hocko <mhocko@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        rostedt@goodmis.org, Serge Hallyn <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>, sspatil@google.com,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, timmurray@google.com,
        torvalds@linux-foundation.org, Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH v1 2/2] Add selftests for pidfd polling
Date:   Thu, 25 Apr 2019 15:00:10 -0400
Message-Id: <20190425190010.46489-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190425190010.46489-1-joel@joelfernandes.org>
References: <20190425190010.46489-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Other than verifying pidfd based polling, the tests make sure that
wait semantics are preserved with the pidfd poll. Notably the 2 cases:
1. If a thread group leader exits while threads still there, then no
   pidfd poll notifcation should happen.
2. If a non-thread group leader does an execve, then the thread group
   leader is signaled to exit and is replaced with the execing thread
   as the new leader, however the parent is not notified in this case.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/pidfd/Makefile     |   2 +-
 tools/testing/selftests/pidfd/pidfd_test.c | 198 +++++++++++++++++++++
 2 files changed, 199 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index deaf8073bc06..4b31c14f273c 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -1,4 +1,4 @@
-CFLAGS += -g -I../../../../usr/include/
+CFLAGS += -g -I../../../../usr/include/ -lpthread
 
 TEST_GEN_PROGS := pidfd_test
 
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index d59378a93782..e887f807645e 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -4,18 +4,42 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/types.h>
+#include <pthread.h>
 #include <sched.h>
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <syscall.h>
+#include <sys/epoll.h>
+#include <sys/mman.h>
 #include <sys/mount.h>
 #include <sys/wait.h>
+#include <time.h>
 #include <unistd.h>
 
 #include "../kselftest.h"
 
+#define CHILD_THREAD_MIN_WAIT 3 /* seconds */
+#define MAX_EVENTS 5
+#define __NR_pidfd_send_signal 424
+
+#ifndef CLONE_PIDFD
+#define CLONE_PIDFD 0x00001000
+#endif
+
+static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
+{
+	size_t stack_size = 1024;
+	char *stack[1024] = { 0 };
+
+#ifdef __ia64__
+	return __clone2(fn, stack, stack_size, flags | SIGCHLD, NULL, pidfd);
+#else
+	return clone(fn, stack + stack_size, flags | SIGCHLD, NULL, pidfd);
+#endif
+}
+
 static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
 					unsigned int flags)
 {
@@ -368,10 +392,184 @@ static int test_pidfd_send_signal_syscall_support(void)
 	return 0;
 }
 
+void *test_pidfd_poll_exec_thread(void *priv)
+{
+	char waittime[256];
+
+	ksft_print_msg("Child Thread: starting. pid %d tid %d ; and sleeping\n",
+			getpid(), syscall(SYS_gettid));
+	ksft_print_msg("Child Thread: doing exec of sleep\n");
+
+	sprintf(waittime, "%d", CHILD_THREAD_MIN_WAIT);
+	execl("/bin/sleep", "sleep", waittime, (char *)NULL);
+
+	ksft_print_msg("Child Thread: DONE. pid %d tid %d\n",
+			getpid(), syscall(SYS_gettid));
+	return NULL;
+}
+
+static int poll_pidfd(const char *test_name, int pidfd)
+{
+	int c;
+	int epoll_fd = epoll_create1(0);
+	struct epoll_event event, events[MAX_EVENTS];
+
+	if (epoll_fd == -1)
+		ksft_exit_fail_msg("%s test: Failed to create epoll file descriptor\n",
+				   test_name);
+
+	event.events = EPOLLIN;
+	event.data.fd = pidfd;
+
+	if (epoll_ctl(epoll_fd, EPOLL_CTL_ADD, pidfd, &event)) {
+		ksft_print_msg("%s test: Failed to add epoll file descriptor: Skipping\n",
+			       test_name);
+		_exit(PIDFD_SKIP);
+	}
+
+	c = epoll_wait(epoll_fd, events, MAX_EVENTS, 5000);
+	if (c != 1 || !(events[0].events & EPOLLIN))
+		ksft_exit_fail_msg("%s test: Unexpected epoll_wait result (c=%d, events=%x)\n",
+				   test_name, c, events[0].events);
+
+	close(epoll_fd);
+	return events[0].events;
+
+}
+
+static int child_poll_exec_test(void *args)
+{
+	pthread_t t1;
+
+	ksft_print_msg("Child (pidfd): starting. pid %d tid %d\n", getpid(),
+			syscall(SYS_gettid));
+	pthread_create(&t1, NULL, test_pidfd_poll_exec_thread, NULL);
+	/*
+	 * Exec in the non-leader thread will destroy the leader immediately.
+	 * If the wait in the parent returns too soon, the test fails.
+	 */
+	while (1)
+		;
+}
+
+int test_pidfd_poll_exec(int use_waitpid)
+{
+	int pid, pidfd = 0;
+	int status, ret;
+	pthread_t t1;
+	time_t prog_start = time(NULL);
+	const char *test_name = "pidfd_poll check for premature notification on child thread exec";
+
+	ksft_print_msg("Parent: pid: %d\n", getpid());
+	pid = pidfd_clone(CLONE_PIDFD, &pidfd, child_poll_exec_test);
+
+	ksft_print_msg("Parent: Waiting for Child (%d) to complete.\n", pid);
+
+	if (use_waitpid) {
+		ret = waitpid(pid, &status, 0);
+		if (ret == -1)
+			ksft_print_msg("Parent: error\n");
+
+		if (ret == pid)
+			ksft_print_msg("Parent: Child process waited for.\n");
+	} else {
+		poll_pidfd(test_name, pidfd);
+	}
+
+	time_t prog_time = time(NULL) - prog_start;
+
+	ksft_print_msg("Time waited for child: %lu\n", prog_time);
+
+	close(pidfd);
+
+	if (prog_time < CHILD_THREAD_MIN_WAIT || prog_time > CHILD_THREAD_MIN_WAIT + 2)
+		ksft_exit_fail_msg("%s test: Failed\n", test_name);
+	else
+		ksft_test_result_pass("%s test: Passed\n", test_name);
+}
+
+void *test_pidfd_poll_leader_exit_thread(void *priv)
+{
+	char waittime[256];
+
+	ksft_print_msg("Child Thread: starting. pid %d tid %d ; and sleeping\n",
+			getpid(), syscall(SYS_gettid));
+	sleep(CHILD_THREAD_MIN_WAIT);
+	ksft_print_msg("Child Thread: DONE. pid %d tid %d\n", getpid(), syscall(SYS_gettid));
+	return NULL;
+}
+
+static time_t *child_exit_secs;
+static int child_poll_leader_exit_test(void *args)
+{
+	pthread_t t1, t2;
+
+	ksft_print_msg("Child: starting. pid %d tid %d\n", getpid(), syscall(SYS_gettid));
+	pthread_create(&t1, NULL, test_pidfd_poll_leader_exit_thread, NULL);
+	pthread_create(&t2, NULL, test_pidfd_poll_leader_exit_thread, NULL);
+
+	/*
+	 * glibc exit calls exit_group syscall, so explicity call exit only
+	 * so that only the group leader exits, leaving the threads alone.
+	 */
+	*child_exit_secs = time(NULL);
+	syscall(SYS_exit, 0);
+}
+
+int test_pidfd_poll_leader_exit(int use_waitpid)
+{
+	int pid, pidfd = 0;
+	int status, ret;
+	time_t prog_start = time(NULL);
+	const char *test_name = "pidfd_poll check for premature notification on non-empty"
+				"group leader exit";
+
+	child_exit_secs = mmap(NULL, sizeof *child_exit_secs, PROT_READ | PROT_WRITE,
+			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+
+	ksft_print_msg("Parent: pid: %d\n", getpid());
+	pid = pidfd_clone(CLONE_PIDFD, &pidfd, child_poll_leader_exit_test);
+
+	ksft_print_msg("Parent: Waiting for Child (%d) to complete.\n", pid);
+
+	if (use_waitpid) {
+		ret = waitpid(pid, &status, 0);
+		if (ret == -1)
+			ksft_print_msg("Parent: error\n");
+	} else {
+		/*
+		 * This sleep tests for the case where if the child exits, and is in
+		 * EXIT_ZOMBIE, but the thread group leader is non-empty, then the poll
+		 * doesn't prematurely return even though there are active threads
+		 */
+		sleep(1);
+		poll_pidfd(test_name, pidfd);
+	}
+
+	if (ret == pid)
+		ksft_print_msg("Parent: Child process waited for.\n");
+
+	time_t since_child_exit = time(NULL) - *child_exit_secs;
+
+	ksft_print_msg("Time since child exit: %lu\n", since_child_exit);
+
+	close(pidfd);
+
+	if (since_child_exit < CHILD_THREAD_MIN_WAIT ||
+			since_child_exit > CHILD_THREAD_MIN_WAIT + 2)
+		ksft_exit_fail_msg("%s test: Failed\n", test_name);
+	else
+		ksft_test_result_pass("%s test: Passed\n", test_name);
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
 
+	test_pidfd_poll_exec(0);
+	test_pidfd_poll_exec(1);
+	test_pidfd_poll_leader_exit(0);
+	test_pidfd_poll_leader_exit(1);
 	test_pidfd_send_signal_syscall_support();
 	test_pidfd_send_signal_simple_success();
 	test_pidfd_send_signal_exited_fail();
-- 
2.21.0.593.g511ec345e18-goog

