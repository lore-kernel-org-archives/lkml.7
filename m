Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABEEC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6F121655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfG2Qeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:34:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727450AbfG2Qeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:34:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 667C281DE1;
        Mon, 29 Jul 2019 16:34:35 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-116-74.ams2.redhat.com [10.36.116.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7AC215D6A0;
        Mon, 29 Jul 2019 16:34:33 +0000 (UTC)
From:   Adrian Reber <areber@redhat.com>
To:     Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>
Cc:     linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Adrian Reber <areber@redhat.com>
Subject: [PATCH 2/2] selftests: add test for clone3() with set_tid
Date:   Mon, 29 Jul 2019 18:33:55 +0200
Message-Id: <20190729163355.4530-2-areber@redhat.com>
In-Reply-To: <20190729163355.4530-1-areber@redhat.com>
References: <20190729163355.4530-1-areber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 29 Jul 2019 16:34:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This tests clone3() with set_tid to see if all desired PIDs are working
as expected. The test tries to clone3() with a set_tid of -1, 1,
pid_max, a PID which is already in use and an unused PID. The same
tests are also running in PID namespace.

Signed-off-by: Adrian Reber <areber@redhat.com>
---
 tools/testing/selftests/clone3/.gitignore     |   1 +
 tools/testing/selftests/clone3/Makefile       |  11 ++
 .../testing/selftests/clone3/clone3_set_tid.c | 148 ++++++++++++++++++
 3 files changed, 160 insertions(+)
 create mode 100644 tools/testing/selftests/clone3/.gitignore
 create mode 100644 tools/testing/selftests/clone3/Makefile
 create mode 100644 tools/testing/selftests/clone3/clone3_set_tid.c

diff --git a/tools/testing/selftests/clone3/.gitignore b/tools/testing/selftests/clone3/.gitignore
new file mode 100644
index 000000000000..09ccea33016c
--- /dev/null
+++ b/tools/testing/selftests/clone3/.gitignore
@@ -0,0 +1 @@
+clone3_set_tid
diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selftests/clone3/Makefile
new file mode 100644
index 000000000000..45c77b50f367
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
+	TEST_GEN_PROGS := clone3_set_tid
+endif
+
+include ../lib.mk
diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
new file mode 100644
index 000000000000..1ed0845aa4c5
--- /dev/null
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
+	args.flags = flags | CLONE_SET_TID;
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
+		ksft_print_msg("I am the child, my PID is %d\n", getpid());
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
+	ksft_print_msg("[%d] Trying clone3() with CLONE_SET_TID to %d "
+		        "and 0x%x\n", getpid(), set_tid, flags);
+	ret = call_clone3_set_tid(set_tid, flags);
+	ksft_print_msg("[%d] clone3() with CLONE_SET_TID %d says :%d "
+			"- expected %d\n", getpid(), set_tid, ret, expected);
+	if (ret != expected)
+		ksft_exit_fail_msg("[%d] Result (%d) is different than "
+				    "expected (%d)\n", getpid(), ret, expected);
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
+	ksft_set_plan(10);
+
+	f = fopen("/proc/sys/kernel/pid_max", "r");
+	if (f == NULL)
+		ksft_exit_fail_msg("%s - Could not open /proc/sys/kernel/pid_max\n",
+				strerror(errno));
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
+	if (test_clone3_set_tid(1, 0, -EAGAIN))
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
+	if (test_clone3_set_tid(pid, 0, -EAGAIN))
+		goto on_error;
+	(void)wait(NULL);
+	/* After the child has finished, try again with the same PID */
+	if (test_clone3_set_tid(pid, 0, 0))
+		goto on_error;
+	/* This should fail as there is no PID 1 in that namespace */
+	if (test_clone3_set_tid(pid, CLONE_NEWPID, -EINVAL))
+		goto on_error;
+	unshare(CLONE_NEWPID);
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
+	(void)wait(NULL);
+
+	ret = 0;
+on_error:
+
+	return !ret ? ksft_exit_pass() : ksft_exit_fail();
+}
-- 
2.21.0

