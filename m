Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5507C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5ED214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfHLUKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 16:10:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727418AbfHLUKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:10:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2098B308A968;
        Mon, 12 Aug 2019 20:10:21 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCCFF71C82;
        Mon, 12 Aug 2019 20:10:03 +0000 (UTC)
From:   Adrian Reber <areber@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Adrian Reber <areber@redhat.com>
Subject: [PATCH v6 2/2] selftests: add tests for clone3()
Date:   Mon, 12 Aug 2019 22:09:39 +0200
Message-Id: <20190812200939.23784-2-areber@redhat.com>
In-Reply-To: <20190812200939.23784-1-areber@redhat.com>
References: <20190812200939.23784-1-areber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 12 Aug 2019 20:10:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This tests clone3() with and without set_tid to see if all desired PIDs
are working as expected. The test tries to clone3() with a set_tid of
-1, 1, pid_max, a PID which is already in use and an unused PID. The
same tests are also running in PID namespace.

In addition the clone3 test (without set_tid) tries to call clone3()
with different sizes of clone_args.

Signed-off-by: Adrian Reber <areber@redhat.com>
---
 tools/testing/selftests/clone3/.gitignore     |   2 +
 tools/testing/selftests/clone3/Makefile       |  11 +
 tools/testing/selftests/clone3/clone3.c       | 231 ++++++++++++++++++
 .../testing/selftests/clone3/clone3_set_tid.c | 161 ++++++++++++
 4 files changed, 405 insertions(+)
 create mode 100644 tools/testing/selftests/clone3/.gitignore
 create mode 100644 tools/testing/selftests/clone3/Makefile
 create mode 100644 tools/testing/selftests/clone3/clone3.c
 create mode 100644 tools/testing/selftests/clone3/clone3_set_tid.c

diff --git a/tools/testing/selftests/clone3/.gitignore b/tools/testing/selftests/clone3/.gitignore
new file mode 100644
index 000000000000..c63c64a78ddf
--- /dev/null
+++ b/tools/testing/selftests/clone3/.gitignore
@@ -0,0 +1,2 @@
+clone3_set_tid
+clone3
diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selftests/clone3/Makefile
new file mode 100644
index 000000000000..4efcf45b995b
--- /dev/null
+++ b/tools/testing/selftests/clone3/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+uname_M := $(shell uname -m 2>/dev/null || echo not)
+ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/i386/)
+
+CFLAGS += -I../../../../usr/include/
+
+ifeq ($(ARCH),x86_64)
+	TEST_GEN_PROGS := clone3 clone3_set_tid
+endif
+
+include ../lib.mk
diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
new file mode 100644
index 000000000000..a0f1989f8b1b
--- /dev/null
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Based on Christian Brauner's clone3() example */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/un.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <sched.h>
+
+#include "../kselftest.h"
+
+/*
+ * Different sizes of struct clone_args
+ */
+#define CLONE3_ARGS_SIZE_V0 64
+/* V1 includes set_tid */
+#define CLONE3_ARGS_SIZE_V1 72
+
+#define CLONE3_ARGS_NO_TEST 0
+#define CLONE3_ARGS_ALL_0 1
+#define CLONE3_ARGS_ALL_1 2
+
+static pid_t raw_clone(struct clone_args *args, size_t size)
+{
+	return syscall(__NR_clone3, args, size);
+}
+
+static int call_clone3(int flags, size_t size, int test_mode)
+{
+	struct clone_args args = {0};
+	pid_t ppid = -1;
+	pid_t pid = -1;
+	int status;
+
+	args.flags = flags;
+	args.exit_signal = SIGCHLD;
+
+	if (size == 0)
+		size = sizeof(struct clone_args);
+
+	if (test_mode == CLONE3_ARGS_ALL_0) {
+		args.flags = 0;
+		args.pidfd = 0;
+		args.child_tid = 0;
+		args.parent_tid = 0;
+		args.exit_signal = 0;
+		args.stack = 0;
+		args. stack_size = 0;
+		args.tls = 0;
+		args.set_tid = 0;
+	} else if (test_mode == CLONE3_ARGS_ALL_1) {
+		args.flags = 1;
+		args.pidfd = 1;
+		args.child_tid = 1;
+		args.parent_tid = 1;
+		args.exit_signal = 1;
+		args.stack = 1;
+		args. stack_size = 1;
+		args.tls = 1;
+		args.set_tid = 1;
+	}
+
+	pid = raw_clone(&args, size);
+	if (pid < 0) {
+		ksft_print_msg("%s - Failed to create new process\n",
+				strerror(errno));
+		return -errno;
+	}
+
+	if (pid == 0) {
+		ksft_print_msg("I am the child, my PID is %d\n", getpid());
+		_exit(EXIT_SUCCESS);
+	}
+
+	ppid = getpid();
+	ksft_print_msg("I am the parent (%d). My child's pid is %d\n",
+			ppid, pid);
+
+	(void)wait(&status);
+	if (WEXITSTATUS(status))
+		return WEXITSTATUS(status);
+
+	return 0;
+}
+
+static int test_clone3(int flags, size_t size, int expected, int test_mode)
+{
+	int ret;
+
+	ksft_print_msg("[%d] Trying clone3() with flags 0x%x (size %d)\n",
+			getpid(), flags, size);
+	ret = call_clone3(flags, size, test_mode);
+	ksft_print_msg("[%d] clone3() with flags says :%d expected %d\n",
+			getpid(), ret, expected);
+	if (ret != expected)
+		ksft_exit_fail_msg(
+			"[%d] Result (%d) is different than expected (%d)\n",
+			getpid(), ret, expected);
+	ksft_test_result_pass("[%d] Result (%d) matches expectation (%d)\n",
+			getpid(), ret, expected);
+	return 0;
+}
+int main(int argc, char *argv[])
+{
+	int ret = -1;
+	pid_t pid;
+
+	ksft_print_header();
+	ksft_set_plan(16);
+
+	/* Just a simple clone3() should return 0.*/
+	if (test_clone3(0, 0, 0, CLONE3_ARGS_NO_TEST))
+		goto on_error;
+	/* Do a clone3() in a new PID NS.*/
+	if (test_clone3(CLONE_NEWPID, 0, 0, CLONE3_ARGS_NO_TEST))
+		goto on_error;
+	/* Do a clone3() with CLONE3_ARGS_SIZE_V0. */
+	if (test_clone3(0, CLONE3_ARGS_SIZE_V0, 0, CLONE3_ARGS_NO_TEST))
+		goto on_error;
+	/* Do a clone3() with CLONE3_ARGS_SIZE_V1. */
+	if (test_clone3(0, CLONE3_ARGS_SIZE_V0, 0, CLONE3_ARGS_NO_TEST))
+		goto on_error;
+	/* Do a clone3() with CLONE3_ARGS_SIZE_V0 - 8 */
+	if (test_clone3(0, CLONE3_ARGS_SIZE_V0 - 8, -EINVAL,
+				CLONE3_ARGS_NO_TEST))
+		goto on_error;
+	/* Do a clone3() with sizeof(struct clone_args) + 8 */
+	if (test_clone3(0, sizeof(struct clone_args) + 8, -E2BIG,
+				CLONE3_ARGS_NO_TEST))
+		goto on_error;
+	/* Do a clone3() with all members set to 1 */
+	if (test_clone3(0, CLONE3_ARGS_SIZE_V0, -EINVAL, CLONE3_ARGS_ALL_1))
+		goto on_error;
+	/*
+	 * Do a clone3() with sizeof(struct clone_args) + 8
+	 * and all members set to 0.
+	 */
+	if (test_clone3(0, sizeof(struct clone_args) + 8, -E2BIG,
+				CLONE3_ARGS_ALL_0))
+		goto on_error;
+	/*
+	 * Do a clone3() with sizeof(struct clone_args) + 8
+	 * and all members set to 0.
+	 */
+	if (test_clone3(0, sizeof(struct clone_args) + 8, -E2BIG,
+				CLONE3_ARGS_ALL_1))
+		goto on_error;
+	/* Do a clone3() with > page size */
+	if (test_clone3(0, getpagesize() + 8, -E2BIG, CLONE3_ARGS_NO_TEST))
+		goto on_error;
+	/* Do a clone3() with CLONE3_ARGS_SIZE_V0 in a new PID NS. */
+	if (test_clone3(CLONE_NEWPID, CLONE3_ARGS_SIZE_V0, 0,
+				CLONE3_ARGS_NO_TEST))
+		goto on_error;
+	/* Do a clone3() with CLONE3_ARGS_SIZE_V1 in a new PID NS. */
+	if (test_clone3(CLONE_NEWPID, CLONE3_ARGS_SIZE_V0, 0,
+				CLONE3_ARGS_NO_TEST))
+		goto on_error;
+	/* Do a clone3() with CLONE3_ARGS_SIZE_V0 - 8 in a new PID NS */
+	if (test_clone3(CLONE_NEWPID, CLONE3_ARGS_SIZE_V0 - 8, -EINVAL,
+				CLONE3_ARGS_NO_TEST))
+		goto on_error;
+	/* Do a clone3() with sizeof(struct clone_args) + 8 in a new PID NS */
+	if (test_clone3(CLONE_NEWPID, sizeof(struct clone_args) + 8, -E2BIG,
+				CLONE3_ARGS_NO_TEST))
+		goto on_error;
+	/* Do a clone3() with > page size in a new PID NS */
+	if (test_clone3(CLONE_NEWPID, getpagesize() + 8, -E2BIG,
+				CLONE3_ARGS_NO_TEST))
+		goto on_error;
+	ksft_print_msg("First unshare\n");
+	if (unshare(CLONE_NEWPID))
+		goto on_error;
+	/*
+	 * Before clone3()ing in a new PID NS with
+	 * CLONE_NEWPID a fork() is necessary.
+	 */
+	if (test_clone3(CLONE_NEWPID, 0, -EINVAL, CLONE3_ARGS_NO_TEST))
+		goto on_error;
+	pid = fork();
+	if (pid < 0) {
+		ksft_print_msg("First fork() failed\n");
+		goto on_error;
+	}
+	if (pid > 0) {
+		(void)wait(NULL);
+		goto parent_out;
+	}
+	ksft_set_plan(19);
+	if (test_clone3(CLONE_NEWPID, 0, 0, CLONE3_ARGS_NO_TEST))
+		goto on_error;
+	if (test_clone3(0, 0, 0, CLONE3_ARGS_NO_TEST))
+		goto on_error;
+	ksft_print_msg("Second unshare\n");
+	if (unshare(CLONE_NEWPID))
+		goto on_error;
+	/*
+	 * Before clone3()ing in a new PID NS with
+	 * CLONE_NEWPID a fork() is necessary.
+	 */
+	if (test_clone3(CLONE_NEWPID, 0, -EINVAL, CLONE3_ARGS_NO_TEST))
+		goto on_error;
+	pid = fork();
+	if (pid < 0) {
+		ksft_print_msg("Second fork() failed\n");
+		goto on_error;
+	}
+	if (pid > 0) {
+		(void)wait(NULL);
+		goto parent_out;
+	}
+	ksft_set_plan(21);
+	if (test_clone3(CLONE_NEWPID, 0, 0, CLONE3_ARGS_NO_TEST))
+		goto on_error;
+	if (test_clone3(0, 0, 0, CLONE3_ARGS_NO_TEST))
+		goto on_error;
+
+parent_out:
+	ret = 0;
+on_error:
+
+	return !ret ? ksft_exit_pass() : ksft_exit_fail();
+}
diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
new file mode 100644
index 000000000000..f5012e84dcb3
--- /dev/null
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Based on Christian Brauner's clone3() example */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/un.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <sched.h>
+
+#include "../kselftest.h"
+
+static pid_t raw_clone(struct clone_args *args)
+{
+	return syscall(__NR_clone3, args, sizeof(struct clone_args));
+}
+
+static int call_clone3_set_tid(int set_tid, int flags)
+{
+	struct clone_args args = {0};
+	pid_t ppid = -1;
+	pid_t pid = -1;
+	int status;
+
+	args.flags = flags;
+	args.exit_signal = SIGCHLD;
+	args.set_tid = set_tid;
+
+	pid = raw_clone(&args);
+	if (pid < 0) {
+		ksft_print_msg("%s - Failed to create new process\n",
+				strerror(errno));
+		return -errno;
+	}
+
+	if (pid == 0) {
+		ksft_print_msg("I am the child, my PID is %d (expected %d)\n",
+				getpid(), set_tid);
+		if (set_tid != getpid())
+			_exit(EXIT_FAILURE);
+		_exit(EXIT_SUCCESS);
+	}
+
+	ppid = getpid();
+	ksft_print_msg("I am the parent (%d). My child's pid is %d\n",
+			ppid, pid);
+
+	(void)wait(&status);
+	if (WEXITSTATUS(status))
+		return WEXITSTATUS(status);
+
+	return 0;
+}
+
+static int test_clone3_set_tid(int set_tid, int flags, int expected)
+{
+	int ret;
+
+	ksft_print_msg(
+		"[%d] Trying clone3() with CLONE_SET_TID to %d and 0x%x\n",
+		getpid(), set_tid, flags);
+	ret = call_clone3_set_tid(set_tid, flags);
+	ksft_print_msg(
+		"[%d] clone3() with CLONE_SET_TID %d says :%d - expected %d\n",
+		getpid(), set_tid, ret, expected);
+	if (ret != expected)
+		ksft_exit_fail_msg(
+			"[%d] Result (%d) is different than expected (%d)\n",
+			getpid(), ret, expected);
+	ksft_test_result_pass("[%d] Result (%d) matches expectation (%d)\n",
+			getpid(), ret, expected);
+	return 0;
+}
+int main(int argc, char *argv[])
+{
+	FILE *f;
+	int pid_max = 0;
+	pid_t pid;
+	pid_t ns_pid;
+	int ret = -1;
+
+	ksft_print_header();
+	ksft_set_plan(13);
+
+	f = fopen("/proc/sys/kernel/pid_max", "r");
+	if (f == NULL)
+		ksft_exit_fail_msg(
+			"%s - Could not open /proc/sys/kernel/pid_max\n",
+			strerror(errno));
+	fscanf(f, "%d", &pid_max);
+	fclose(f);
+	ksft_print_msg("/proc/sys/kernel/pid_max %d\n", pid_max);
+
+	/* First try with an invalid PID */
+	if (test_clone3_set_tid(-1, 0, -EINVAL))
+		goto on_error;
+	if (test_clone3_set_tid(-1, CLONE_NEWPID, -EINVAL))
+		goto on_error;
+	/* Then with PID 1 */
+	if (test_clone3_set_tid(1, 0, -EEXIST))
+		goto on_error;
+	/* PID 1 should not fail in a PID namespace */
+	if (test_clone3_set_tid(1, CLONE_NEWPID, 0))
+		goto on_error;
+	/* pid_max should fail everywhere */
+	if (test_clone3_set_tid(pid_max, 0, -EINVAL))
+		goto on_error;
+	if (test_clone3_set_tid(pid_max, CLONE_NEWPID, -EINVAL))
+		goto on_error;
+	/* Find the current active PID */
+	pid = fork();
+	if (pid == 0) {
+		ksft_print_msg("Child has PID %d\n", getpid());
+		sleep(1);
+		_exit(EXIT_SUCCESS);
+	}
+	/* Try to create a process with that PID should fail */
+	if (test_clone3_set_tid(pid, 0, -EEXIST))
+		goto on_error;
+	(void)wait(NULL);
+	/* After the child has finished, try again with the same PID */
+	if (test_clone3_set_tid(pid, 0, 0))
+		goto on_error;
+	/* This should fail as there is no PID 1 in that namespace */
+	if (test_clone3_set_tid(pid, CLONE_NEWPID, -EINVAL))
+		goto on_error;
+	unshare(CLONE_NEWPID);
+	if (test_clone3_set_tid(10, 0, -EINVAL))
+		goto on_error;
+	/* Let's create a PID 1 */
+	ns_pid = fork();
+	if (ns_pid == 0) {
+		ksft_print_msg("Child in PID namespace has PID %d\n", getpid());
+		sleep(1);
+		_exit(EXIT_SUCCESS);
+	}
+	/*
+	 * Now, after the unshare() it should be possible to create a process
+	 * with another ID than 1 in the PID namespace.
+	 */
+	if (test_clone3_set_tid(2, 0, 0))
+		goto on_error;
+	/* Use a different PID in this namespace. */
+	if (test_clone3_set_tid(2222, 0, 0))
+		goto on_error;
+	if (test_clone3_set_tid(1, 0, -EEXIST))
+		goto on_error;
+	(void)wait(NULL);
+
+	ret = 0;
+on_error:
+
+	return !ret ? ksft_exit_pass() : ksft_exit_fail();
+}
-- 
2.21.0

