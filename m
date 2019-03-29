Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDFFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F46206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="GZ4UvnU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbfC2Pyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:54:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38245 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729734AbfC2Pyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:54:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so3201125wro.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 08:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NA73ahu1OFNnHhVar2xqm/1xkCJSGToafjHb1r4GAE8=;
        b=GZ4UvnU6T3s2aFpfgiK/MkLZmPgGYfGWCaJ61WiQ6u4kPFjKR0hPnccbE6DJTS1dn+
         idBy+yEiEHJ/JXDHxWG0TvL41tDhGx0VgnuDdsFllq7pDY4r5lbyeqv7c9uXPPw6iI8c
         clLyZ2DRqXgsZk04pLF72L8q85ebro99XlPETn9gw0lwnnkpPALIHircWRJftZsfdb93
         dy0N8YFEs/9fJo/WI4V2+1ADbtBzM+AWCd6eAtr7MONSlWGX4vGTfgmPyf3QsOLf1Kb5
         0hDzTu4/k4bPHbagbTr3dGiZOl9DmtCMGR/YtHy3/zVt93d2Jc5dmWJSoP6kbXUPEqDc
         I5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NA73ahu1OFNnHhVar2xqm/1xkCJSGToafjHb1r4GAE8=;
        b=r962AA0Nr9DcoN/JOzuAf5/RGpi1d63VWK8oCacDFJty8+XgRXALQxnf6Am6ZKVhrU
         1iPjtEctkKmhx6mXYTRRi/1JAQHsLUQVLoWRL5PI7PLrCinfmBqZ13FzuvkAFiC3l0IU
         XEQTKjPttEQNCiiRB0UfAYPMLBpX1qvQW36zXzgXZMcNXUlszaEJVD7x+mELEwLraEVt
         tATeq3+Uv/DwlRrWGB9uWXcH6Bxw68+G0TGlgnTdtoYNOi19pJZXb+PuP+HGtZEN03Zv
         8FLSm3CCSBSHfCGc3P67g4dES5zQTikm9XnZk0cCZGyMyWh6Yocif/4quGjesVAwWocu
         f3Ag==
X-Gm-Message-State: APjAAAXOBr19ceYH9EPRJofccDpzE7aeOmq0twXdS+rNyDy649gzGtPp
        syDuWHugBorCni5BsVbe/+O/Rw==
X-Google-Smtp-Source: APXvYqzjEU2cdxKBB2ddXU8iSxG46qflMqcjq9qgIT+aLQkYjBTstStE4tuULpuunXBSna7tyV0ZIw==
X-Received: by 2002:a5d:6050:: with SMTP id j16mr32429659wrt.253.1553874890730;
        Fri, 29 Mar 2019 08:54:50 -0700 (PDT)
Received: from localhost.localdomain (p2E5A5955.dip0.t-ipconnect.de. [46.90.89.85])
        by smtp.gmail.com with ESMTPSA id e1sm4177959wrw.66.2019.03.29.08.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 08:54:50 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     jannh@google.com, luto@kernel.org, dhowells@redhat.com,
        serge@hallyn.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, ebiederm@xmission.com, khlebnikov@yandex-team.ru,
        keescook@chromium.org, adobriyan@gmail.com, tglx@linutronix.de,
        mtk.manpages@gmail.com, bl0pbl33p@gmail.com, ldv@altlinux.org,
        akpm@linux-foundation.org, oleg@redhat.com,
        nagarathnam.muthusamy@oracle.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, joel@joelfernandes.org, dancol@google.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v2 5/5] tests: add pidfd_open() tests
Date:   Fri, 29 Mar 2019 16:54:25 +0100
Message-Id: <20190329155425.26059-6-christian@brauner.io>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190329155425.26059-1-christian@brauner.io>
References: <20190329155425.26059-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds testing for pidfd_open():
- test that no invalid flags can be passed to pidfd_open()
- test that no invalid pid can be passed to pidfd_open()
- test that a pidfd can be retrieved with pidfd_open()
- test whether a pidfd can be converted into an fd to /proc/<pid> to get
  metadata access
- test that a pidfd retrieved based on a pid that has been recycled cannot
  be converted into /proc/<pid> for that recycled pid

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jann Horn <jannh@google.com
Cc: David Howells <dhowells@redhat.com>
Cc: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Jonathan Kowalski <bl0pbl33p@gmail.com>
Cc: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
---
 tools/testing/selftests/pidfd/Makefile        |   2 +-
 tools/testing/selftests/pidfd/pidfd.h         |  57 +++
 .../testing/selftests/pidfd/pidfd_open_test.c | 361 ++++++++++++++++++
 tools/testing/selftests/pidfd/pidfd_test.c    |  41 +-
 4 files changed, 420 insertions(+), 41 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd.h
 create mode 100644 tools/testing/selftests/pidfd/pidfd_open_test.c

diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index deaf8073bc06..b36c0be70848 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -1,6 +1,6 @@
 CFLAGS += -g -I../../../../usr/include/
 
-TEST_GEN_PROGS := pidfd_test
+TEST_GEN_PROGS := pidfd_test pidfd_open_test
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
new file mode 100644
index 000000000000..8452e910463f
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __PIDFD_H
+#define __PIDFD_H
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <sys/mount.h>
+
+#include "../kselftest.h"
+
+/*
+ * The kernel reserves 300 pids via RESERVED_PIDS in kernel/pid.c
+ * That means, when it wraps around any pid < 300 will be skipped.
+ * So we need to use a pid > 300 in order to test recycling.
+ */
+#define PID_RECYCLE 1000
+
+/*
+ * Define a few custom error codes for the child process to clearly indicate
+ * what is happening. This way we can tell the difference between a system
+ * error, a test error, etc.
+ */
+#define PIDFD_PASS 0
+#define PIDFD_FAIL 1
+#define PIDFD_ERROR 2
+#define PIDFD_SKIP 3
+#define PIDFD_XFAIL 4
+
+int wait_for_pid(pid_t pid)
+{
+	int status, ret;
+
+again:
+	ret = waitpid(pid, &status, 0);
+	if (ret == -1) {
+		if (errno == EINTR)
+			goto again;
+
+		return -1;
+	}
+
+	if (!WIFEXITED(status))
+		return -1;
+
+	return WEXITSTATUS(status);
+}
+
+
+#endif /* __PIDFD_H */
diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testing/selftests/pidfd/pidfd_open_test.c
new file mode 100644
index 000000000000..ebe7a96cc8d6
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
@@ -0,0 +1,361 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <limits.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <sys/mount.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "pidfd.h"
+#include "../kselftest.h"
+
+static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
+{
+	return syscall(__NR_pidfd_open, pid, flags);
+}
+
+static int safe_int(const char *numstr, int *converted)
+{
+	char *err = NULL;
+	signed long int sli;
+
+	errno = 0;
+	sli = strtol(numstr, &err, 0);
+	if (errno == ERANGE && (sli == LONG_MAX || sli == LONG_MIN))
+		return -ERANGE;
+
+	if (errno != 0 && sli == 0)
+		return -EINVAL;
+
+	if (err == numstr || *err != '\0')
+		return -EINVAL;
+
+	if (sli > INT_MAX || sli < INT_MIN)
+		return -ERANGE;
+
+	*converted = (int)sli;
+	return 0;
+}
+
+static int char_left_gc(const char *buffer, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		if (buffer[i] == ' ' ||
+		    buffer[i] == '\t')
+			continue;
+
+		return i;
+	}
+
+	return 0;
+}
+
+static int char_right_gc(const char *buffer, size_t len)
+{
+	int i;
+
+	for (i = len - 1; i >= 0; i--) {
+		if (buffer[i] == ' '  ||
+		    buffer[i] == '\t' ||
+		    buffer[i] == '\n' ||
+		    buffer[i] == '\0')
+			continue;
+
+		return i + 1;
+	}
+
+	return 0;
+}
+
+static char *trim_whitespace_in_place(char *buffer)
+{
+	buffer += char_left_gc(buffer, strlen(buffer));
+	buffer[char_right_gc(buffer, strlen(buffer))] = '\0';
+	return buffer;
+}
+
+static pid_t get_pid_from_status_file(int *fd, const char *key, size_t keylen)
+{
+	int ret;
+	FILE *f;
+	size_t n = 0;
+	pid_t result = -1;
+	char *line = NULL;
+
+	/* fd now belongs to FILE and will be closed by fclose() */
+	f = fdopen(*fd, "r");
+	if (!f)
+		return -1;
+
+	while (getline(&line, &n, f) != -1) {
+		char *numstr;
+
+		if (strncmp(line, key, keylen))
+			continue;
+
+		numstr = trim_whitespace_in_place(line + 4);
+		ret = safe_int(numstr, &result);
+		if (ret < 0)
+			goto out;
+
+		break;
+	}
+
+out:
+	free(line);
+	fclose(f);
+	*fd = -1;
+	return result;
+}
+
+static int set_ns_last_pid(void)
+{
+	int fd;
+	ssize_t bytes;
+
+	fd = open("/proc/sys/kernel/ns_last_pid", O_WRONLY | O_CLOEXEC);
+	if (fd < 0) {
+		ksft_print_msg("failed to open \"/proc/sys/kernel/ns_last_pid\"n");
+		return -1;
+	}
+
+	bytes = write(fd, "999", sizeof("999") - 1);
+	close(fd);
+	if (bytes < 0 || (size_t)bytes != (sizeof("999") - 1))
+		return -1;
+
+	return 0;
+}
+
+static int test_pidfd_to_procfd_recycled_pid_fail(void)
+{
+	const char *test_name = "pidfd_open pidfd to procfd conversion on pid recycling";
+	int ret;
+	pid_t pid1;
+
+	ret = unshare(CLONE_NEWPID);
+	if (ret < 0)
+		ksft_exit_fail_msg("%s test: Failed to unshare pid namespace\n",
+				   test_name);
+
+	ret = unshare(CLONE_NEWNS);
+	if (ret < 0)
+		ksft_exit_fail_msg(
+			"%s test: Failed to unshare mount namespace\n",
+			test_name);
+
+	ret = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
+	if (ret < 0)
+		ksft_exit_fail_msg("%s test: Failed to remount / private\n",
+				   test_name);
+
+	/* pid 1 in new pid namespace */
+	pid1 = fork();
+	if (pid1 < 0)
+		ksft_exit_fail_msg("%s test: Failed to create new process\n",
+				   test_name);
+
+	/*
+	 * This is lazy with file descriptor closing in the child process but
+	 * it doesn't matter since we are very short-lived anyway and the
+	 * cleanup would just be more complexity in this test.
+	 */
+	if (pid1 == 0) {
+		int pidfd, procpidfd, procfd, ret;
+		pid_t pid2;
+
+
+		(void)umount2("/proc", MNT_DETACH);
+		ret = mount("proc", "/proc", "proc", 0, NULL);
+		if (ret < 0) {
+			ksft_print_msg("failed to mount a fresh /proc instance\n");
+			_exit(PIDFD_ERROR);
+		}
+
+		/* get pidfd for pid 1000 */
+		if (set_ns_last_pid() < 0) {
+			ksft_print_msg("failed to set ns_last_pid\n");
+			_exit(PIDFD_ERROR);
+		}
+
+		pid2 = fork();
+		if (pid2 < 0) {
+			ksft_print_msg("failed to create new process\n");
+			_exit(PIDFD_ERROR);
+		}
+
+		if (pid2 == 0)
+			_exit(PIDFD_PASS);
+
+		if (pid2 == PID_RECYCLE) {
+			pidfd = sys_pidfd_open(pid2, 0);
+		} else {
+			ksft_print_msg("failed to create process with pid %d\n",
+				       PID_RECYCLE);
+			_exit(PIDFD_ERROR);
+		}
+
+		if (wait_for_pid(pid2))
+			_exit(PIDFD_ERROR);
+
+		if (pidfd < 0)
+			_exit(PIDFD_ERROR);
+
+		/* recycle pid 1000 */
+		if (set_ns_last_pid() < 0) {
+			ksft_print_msg("failed to set ns_last_pid\n");
+			_exit(PIDFD_ERROR);
+		}
+
+		pid2 = fork();
+		if (pid2 < 0) {
+			ksft_print_msg("failed to create new process\n");
+			_exit(PIDFD_ERROR);
+		}
+
+		if (pid2 == 0)
+			_exit(PIDFD_PASS);
+
+		if (pid2 != PID_RECYCLE) {
+			ksft_print_msg("failed to recycle pid %d\n",
+				       PID_RECYCLE);
+			_exit(PIDFD_ERROR);
+		}
+
+		/*
+		 * Now PID_RECYCLE is in zombie state since we have not waited
+		 * on it yet, but it might have already exited. This ensures
+		 * that the /proc/<pid> directory stays around.
+		 */
+		procfd = open("/proc", O_DIRECTORY | O_RDONLY | O_CLOEXEC);
+		if (procfd < 0) {
+			ksft_print_msg("%s - failed to open /proc\n",
+				       strerror(errno));
+			_exit(PIDFD_ERROR);
+		}
+
+		procpidfd = ioctl(pidfd, PIDFD_GET_PROCFD, procfd);
+		if (procpidfd >= 0) {
+			ksft_print_msg(
+				"managed to get access to /proc/<pid> of recycled pid\n");
+			_exit(PIDFD_ERROR);
+		}
+
+		if (wait_for_pid(pid2))
+			_exit(PIDFD_ERROR);
+
+		_exit(PIDFD_PASS);
+	}
+
+	if (wait_for_pid(pid1) != 0)
+		return -1;
+
+	ksft_test_result_pass("%s test: passed\n", test_name);
+	ksft_inc_pass_cnt();
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int ret = 1;
+	int pidfd = -1, procfd = -1, procpidfd = -1, statusfd = -1;
+	pid_t pid;
+
+	pidfd = sys_pidfd_open(-1, 0);
+	if (pidfd >= 0) {
+		ksft_print_msg(
+			"%s - succeeded to open pidfd for invalid pid -1\n",
+			strerror(errno));
+		goto on_error;
+	}
+	ksft_test_result_pass("do not allow invalid pid test: passed\n");
+	ksft_inc_pass_cnt();
+
+	pidfd = sys_pidfd_open(getpid(), 1);
+	if (pidfd >= 0) {
+		ksft_print_msg(
+			"%s - succeeded to open pidfd with invalid flag value specified\n",
+			strerror(errno));
+		goto on_error;
+	}
+	ksft_test_result_pass("do not allow invalid flag test: passed\n");
+	ksft_inc_pass_cnt();
+
+	pidfd = sys_pidfd_open(getpid(), 0);
+	if (pidfd < 0) {
+		ksft_print_msg("%s - failed to open pidfd\n", strerror(errno));
+		goto on_error;
+	}
+	ksft_test_result_pass("open a new pidfd test: passed\n");
+	ksft_inc_pass_cnt();
+
+	procfd = open("/proc", O_DIRECTORY | O_RDONLY | O_CLOEXEC);
+	if (procfd < 0) {
+		ksft_print_msg("%s - failed to open /proc\n", strerror(errno));
+		goto on_error;
+	}
+
+	procpidfd = ioctl(pidfd, PIDFD_GET_PROCFD, procfd);
+	if (procpidfd < 0) {
+		ksft_print_msg(
+			"%s - failed to retrieve /proc/<pid> from pidfd\n",
+			strerror(errno));
+		goto on_error;
+	}
+
+	statusfd = openat(procpidfd, "status", O_CLOEXEC | O_RDONLY);
+	if (statusfd < 0) {
+		ksft_print_msg("%s - failed to open /proc/<pid>/status\n",
+			       strerror(errno));
+		goto on_error;
+	}
+
+	pid = get_pid_from_status_file(&statusfd, "Pid:", sizeof("Pid:") - 1);
+	if (pid < 0) {
+		ksft_print_msg(
+			"%s - failed to retrieve pid from /proc/<pid>/status\n",
+			strerror(errno));
+		goto on_error;
+	}
+
+	if (pid != getpid()) {
+		ksft_print_msg(
+			"%s - actual pid %d does not equal retrieved pid from /proc/<pid>/status\n",
+			strerror(errno), pid, getpid());
+		goto on_error;
+	}
+	ksft_test_result_pass("convert pidfd to /proc/<pid> fd test: passed\n");
+	ksft_inc_pass_cnt();
+
+	ret = test_pidfd_to_procfd_recycled_pid_fail();
+
+on_error:
+	if (pidfd >= 0)
+		close(pidfd);
+
+	if (procfd >= 0)
+		close(procfd);
+
+	if (procpidfd >= 0)
+		close(procpidfd);
+
+	if (statusfd >= 0)
+		close(statusfd);
+
+	return !ret ? ksft_exit_pass() : ksft_exit_fail();
+}
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index d59378a93782..f01de87249c9 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -14,6 +14,7 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
+#include "pidfd.h"
 #include "../kselftest.h"
 
 static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
@@ -62,28 +63,6 @@ static int test_pidfd_send_signal_simple_success(void)
 	return 0;
 }
 
-static int wait_for_pid(pid_t pid)
-{
-	int status, ret;
-
-again:
-	ret = waitpid(pid, &status, 0);
-	if (ret == -1) {
-		if (errno == EINTR)
-			goto again;
-
-		return -1;
-	}
-
-	if (ret != pid)
-		goto again;
-
-	if (!WIFEXITED(status))
-		return -1;
-
-	return WEXITSTATUS(status);
-}
-
 static int test_pidfd_send_signal_exited_fail(void)
 {
 	int pidfd, ret, saved_errno;
@@ -128,13 +107,6 @@ static int test_pidfd_send_signal_exited_fail(void)
 	return 0;
 }
 
-/*
- * The kernel reserves 300 pids via RESERVED_PIDS in kernel/pid.c
- * That means, when it wraps around any pid < 300 will be skipped.
- * So we need to use a pid > 300 in order to test recycling.
- */
-#define PID_RECYCLE 1000
-
 /*
  * Maximum number of cycles we allow. This is equivalent to PID_MAX_DEFAULT.
  * If users set a higher limit or we have cycled PIDFD_MAX_DEFAULT number of
@@ -143,17 +115,6 @@ static int test_pidfd_send_signal_exited_fail(void)
  */
 #define PIDFD_MAX_DEFAULT 0x8000
 
-/*
- * Define a few custom error codes for the child process to clearly indicate
- * what is happening. This way we can tell the difference between a system
- * error, a test error, etc.
- */
-#define PIDFD_PASS 0
-#define PIDFD_FAIL 1
-#define PIDFD_ERROR 2
-#define PIDFD_SKIP 3
-#define PIDFD_XFAIL 4
-
 static int test_pidfd_send_signal_recycled_pid_fail(void)
 {
 	int i, ret;
-- 
2.21.0

