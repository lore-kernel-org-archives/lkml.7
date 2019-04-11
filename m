Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F614C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1C02082E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="uccv7bV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfDKRvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:51:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44151 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfDKRvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:51:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id y13so3798264pfm.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 10:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1WrIR0QOrJAwS3O8qZx8u0RVTe8tfr2CaORBL+Co0xk=;
        b=uccv7bV+PZGraUVfb64/3l/Z98RLjyH4tb9mc9oMi5T53UkrcJMaLyW+6zVzEOSpOR
         KGtzqyO6v5QmmKrnOk8zD5bU2ucC0sYc+v6+MuLSjRox6qjDXb3hOdaGWF8BohTKgV88
         q9UroqE3nKPUwL5MeJbnSBIDuw73IwaNN6CYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1WrIR0QOrJAwS3O8qZx8u0RVTe8tfr2CaORBL+Co0xk=;
        b=TYzXOwID5jAHRZHiyDSIKdnog+pNAXVkAegYnrdQudBKGFj0+MYIqMT4gjuWk/AtrP
         5Y0vXnT7Wmups4t05kLdKOB7BN3mkdvw6F4ZZexYUDw9vODEiakAvp7X6UEsolqvgLJn
         WKX180gBOMOKghILr5ZSEHBqpsq7DhT7z/r3czBR9GQYYXUlqFvqDBPpy3QhWPNHHEFX
         Q/Gl7SL8z3X4ThZfbkMEIi5K141NbkyDZXQpYtdqAl9O62AkcN3XGrDRI2WMG67JWE7E
         vtti/Z8oiG4/HnGNKUHxtVTKt64ZQZtlL5C4CtRIdfnGN21AC6ns03BV/SOXKQxsZjdN
         hiOg==
X-Gm-Message-State: APjAAAUwIVowR7DvlsWw6FuI5cY/OS2fZJnt9i6GYHQxlCgjclc7S+dS
        nspVYioCRsy6rOtr4rpwwCAKqmXCGV0=
X-Google-Smtp-Source: APXvYqyEBspSgCilT9XDbXPdxcIHARn2vp2dVZyccuVlh8ElwuJF902L52cribKxzCo9TRfaeh34Ig==
X-Received: by 2002:a62:6490:: with SMTP id y138mr51320380pfb.230.1555005065044;
        Thu, 11 Apr 2019 10:51:05 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d68sm58776474pfg.16.2019.04.11.10.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 10:51:04 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>, dancol@google.com,
        "Eric W. Biederman" <ebiederm@xmission.com>, jannh@google.com,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        luto@amacapital.net, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>, Oleg Nesterov <oleg@redhat.com>,
        rostedt@goodmis.org, Serge Hallyn <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        torvalds@linux-foundation.org, Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH RFC 2/2] Add selftests for pidfd polling
Date:   Thu, 11 Apr 2019 13:50:43 -0400
Message-Id: <20190411175043.31207-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190411175043.31207-1-joel@joelfernandes.org>
References: <20190411175043.31207-1-joel@joelfernandes.org>
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
 tools/testing/selftests/pidfd/pidfd_test.c | 216 ++++++++++++++++++++-
 2 files changed, 208 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index deaf8073bc06..4b31c14f273c 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -1,4 +1,4 @@
-CFLAGS += -g -I../../../../usr/include/
+CFLAGS += -g -I../../../../usr/include/ -lpthread
 
 TEST_GEN_PROGS := pidfd_test
 
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index d59378a93782..4d5206280091 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -4,18 +4,26 @@
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
 static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
 					unsigned int flags)
 {
@@ -30,6 +38,22 @@ static void set_signal_received_on_sigusr1(int sig)
 		signal_received = 1;
 }
 
+static int open_pidfd(const char *test_name, pid_t pid)
+{
+	char buf[256];
+	int pidfd;
+
+	snprintf(buf, sizeof(buf), "/proc/%d", pid);
+	pidfd = open(buf, O_DIRECTORY | O_CLOEXEC);
+
+	if (pidfd < 0)
+		ksft_exit_fail_msg(
+			"%s test: Failed to open process file descriptor\n",
+			test_name);
+
+	return pidfd;
+}
+
 /*
  * Straightforward test to see whether pidfd_send_signal() works is to send
  * a signal to ourself.
@@ -87,7 +111,6 @@ static int wait_for_pid(pid_t pid)
 static int test_pidfd_send_signal_exited_fail(void)
 {
 	int pidfd, ret, saved_errno;
-	char buf[256];
 	pid_t pid;
 	const char *test_name = "pidfd_send_signal signal exited process";
 
@@ -99,17 +122,10 @@ static int test_pidfd_send_signal_exited_fail(void)
 	if (pid == 0)
 		_exit(EXIT_SUCCESS);
 
-	snprintf(buf, sizeof(buf), "/proc/%d", pid);
-
-	pidfd = open(buf, O_DIRECTORY | O_CLOEXEC);
+	pidfd = open_pidfd(test_name, pid);
 
 	(void)wait_for_pid(pid);
 
-	if (pidfd < 0)
-		ksft_exit_fail_msg(
-			"%s test: Failed to open process file descriptor\n",
-			test_name);
-
 	ret = sys_pidfd_send_signal(pidfd, 0, NULL, 0);
 	saved_errno = errno;
 	close(pidfd);
@@ -368,10 +384,192 @@ static int test_pidfd_send_signal_syscall_support(void)
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
+int test_pidfd_poll_exec(int use_waitpid)
+{
+	int pid, pidfd;
+	int status, ret;
+	pthread_t t1;
+	time_t prog_start = time(NULL);
+	const char *test_name = "pidfd_poll check for premature notification on child thread exec";
+
+	ksft_print_msg("Parent: pid: %d\n", getpid());
+	pid = fork();
+	if (pid == 0) {
+		ksft_print_msg("Child: starting. pid %d tid %d\n", getpid(),
+				syscall(SYS_gettid));
+		pthread_create(&t1, NULL, test_pidfd_poll_exec_thread, NULL);
+		/*
+		 * Exec in the non-leader thread will destroy the leader immediately.
+		 * If the wait in the parent returns too soon, the test fails.
+		 */
+		while (1)
+			;
+	}
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
+		pidfd = open_pidfd(test_name, pid);
+		if (poll_pidfd(test_name, pidfd) & EPOLLERR)
+			ksft_exit_fail_msg("%s test: Unexpected epoll error\n", test_name);
+	}
+
+	time_t prog_time = time(NULL) - prog_start;
+
+	ksft_print_msg("Time waited for child: %lu\n", prog_time);
+
+	/* Check to make sure poll_pidfd returns error after reaping */
+	if (!use_waitpid &&
+	    (waitpid(pid, &status, 0) != pid || !(poll_pidfd(test_name, pidfd) & EPOLLERR))) {
+		ksft_exit_fail_msg("%s test: poll_pidfd EPOLLERR check failed\n", test_name);
+	}
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
+int test_pidfd_poll_leader_exit(int use_waitpid)
+{
+	int pid, pidfd;
+	int status, ret;
+	pthread_t t1, t2;
+	time_t prog_start = time(NULL);
+	const char *test_name = "pidfd_poll check for premature notification on non-empty"
+				"group leader exit";
+
+	child_exit_secs = mmap(NULL, sizeof *child_exit_secs, PROT_READ | PROT_WRITE,
+			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+
+	ksft_print_msg("Parent: pid: %d\n", getpid());
+	pid = fork();
+	if (pid == 0) {
+		ksft_print_msg("Child: starting. pid %d tid %d\n", getpid(), syscall(SYS_gettid));
+		pthread_create(&t1, NULL, test_pidfd_poll_leader_exit_thread, NULL);
+		pthread_create(&t2, NULL, test_pidfd_poll_leader_exit_thread, NULL);
+
+		/*
+		 * glibc exit calls exit_group syscall, so explicity call exit only
+		 * so that only the group leader exits, leaving the threads alone.
+		 */
+		*child_exit_secs = time(NULL);
+		syscall(SYS_exit, 0);
+	}
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
+		pidfd = open_pidfd(test_name, pid);
+		if (poll_pidfd(test_name, pidfd) & EPOLLERR)
+			ksft_exit_fail_msg("%s test: Unexpected epoll error\n", test_name);
+	}
+
+	if (ret == pid)
+		ksft_print_msg("Parent: Child process waited for.\n");
+
+	time_t since_child_exit = time(NULL) - *child_exit_secs;
+
+	ksft_print_msg("Time since child exit: %lu\n", since_child_exit);
+
+	/* Check to make sure poll_pidfd returns error after reaping */
+	if (!use_waitpid &&
+	    (waitpid(pid, &status, 0) != pid ||
+	    !(poll_pidfd(test_name, pidfd) & EPOLLERR))) {
+		ksft_exit_fail_msg("%s test: poll_pidfd EPOLLERR check failed\n", test_name);
+	}
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
2.21.0.392.gf8f6787159e-goog

