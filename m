Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE82C0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707DC20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfHKVho convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 17:37:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46681 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfHKVho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 17:37:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id w3so11278026pgt.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 14:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:reply-to:to:cc:from
         :message-id;
        bh=v8eLbZA+7mOOzjJCgBgH9xXfCDsgTzcNvSzcCxdO9Uo=;
        b=DmFDMJC3QYVsXFmv/iILzi9UUNCQPpWnb/YsKkNSKgGxm4Xad5gWmwM931820NdSE5
         B4/h6BiQ24nRTGBd6NorEL02Ux9FzatouUtvPMc3sjA06JTiVnkoWmZhsFWKXhpOhowr
         O8vFgkkA5MrM74qEB3LP/d/b70u3FXFv6Wvsc5zvfejM5q1A+IPjAJKhJoZ9MKsHRVNt
         dEH1Sk7wUJcCOQ4Jmtig+Y2kTx8otd81DPYo6hFi79kPBChD8bu9AlCGf4VotA9P84L8
         mOUjQXymnmsLFEANKJ30B7vzS6Hn+z6SXqbcy8zwyymmwffE1Lff+neXWj8wdB8VcASJ
         l6mw==
X-Gm-Message-State: APjAAAXj3E4B//xmgn107AEti5fvZ6eux+m+OP4Td9NBDpLekTpgXz6v
        pIvKRtXKBOF9oXoHZ2+YQYvebQ==
X-Google-Smtp-Source: APXvYqyLJ3cueTK5+iMHK57u1YCJ5HguMaHaS8eSULyrNbqY7GXdYAQGqdbf5u2sui1hvmhmzWX6Iw==
X-Received: by 2002:a62:5250:: with SMTP id g77mr4530802pfb.158.1565559462989;
        Sun, 11 Aug 2019 14:37:42 -0700 (PDT)
Received: from ?IPv6:2607:fb90:21df:e27c:bdf0:b946:3fed:b747? ([2607:fb90:21df:e27c:bdf0:b946:3fed:b747])
        by smtp.gmail.com with ESMTPSA id j20sm99818949pfr.113.2019.08.11.14.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:37:42 -0700 (PDT)
Date:   Sun, 11 Aug 2019 14:37:03 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20190811203327.5385-2-areber@redhat.com>
References: <20190811203327.5385-1-areber@redhat.com> <20190811203327.5385-2-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v5 2/2] selftests: add tests for clone3()
Reply-to: christian.brauner@ubuntu.com
To:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
CC:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
From:   Christian Brauner <christian.brauner@ubuntu.com>
Message-ID: <779F5F12-A430-4B33-86A8-15FB52654683@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On August 11, 2019 1:33:27 PM PDT, Adrian Reber <areber@redhat.com> wrote:
>This tests clone3() with and without set_tid to see if all desired PIDs
>are working as expected. The test tries to clone3() with a set_tid of
>-1, 1, pid_max, a PID which is already in use and an unused PID. The
>same tests are also running in PID namespace.
>
>Signed-off-by: Adrian Reber <areber@redhat.com>
>---
> tools/testing/selftests/clone3/.gitignore     |   2 +
> tools/testing/selftests/clone3/Makefile       |  11 ++
> tools/testing/selftests/clone3/clone3.c       | 141 +++++++++++++++
> .../testing/selftests/clone3/clone3_set_tid.c | 161 ++++++++++++++++++
> 4 files changed, 315 insertions(+)
> create mode 100644 tools/testing/selftests/clone3/.gitignore
> create mode 100644 tools/testing/selftests/clone3/Makefile
> create mode 100644 tools/testing/selftests/clone3/clone3.c
> create mode 100644 tools/testing/selftests/clone3/clone3_set_tid.c
>
>diff --git a/tools/testing/selftests/clone3/.gitignore
>b/tools/testing/selftests/clone3/.gitignore
>new file mode 100644
>index 000000000000..c63c64a78ddf
>--- /dev/null
>+++ b/tools/testing/selftests/clone3/.gitignore
>@@ -0,0 +1,2 @@
>+clone3_set_tid
>+clone3
>diff --git a/tools/testing/selftests/clone3/Makefile
>b/tools/testing/selftests/clone3/Makefile
>new file mode 100644
>index 000000000000..4efcf45b995b
>--- /dev/null
>+++ b/tools/testing/selftests/clone3/Makefile
>@@ -0,0 +1,11 @@
>+# SPDX-License-Identifier: GPL-2.0
>+uname_M := $(shell uname -m 2>/dev/null || echo not)
>+ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/i386/)
>+
>+CFLAGS += -I../../../../usr/include/
>+
>+ifeq ($(ARCH),x86_64)
>+	TEST_GEN_PROGS := clone3 clone3_set_tid
>+endif
>+
>+include ../lib.mk
>diff --git a/tools/testing/selftests/clone3/clone3.c
>b/tools/testing/selftests/clone3/clone3.c
>new file mode 100644
>index 000000000000..55a6915566b8
>--- /dev/null
>+++ b/tools/testing/selftests/clone3/clone3.c
>@@ -0,0 +1,141 @@
>+// SPDX-License-Identifier: GPL-2.0
>+
>+/* Based on Christian Brauner's clone3() example */
>+
>+#define _GNU_SOURCE
>+#include <errno.h>
>+#include <linux/types.h>
>+#include <linux/sched.h>
>+#include <stdio.h>
>+#include <stdlib.h>
>+#include <sys/syscall.h>
>+#include <sys/types.h>
>+#include <sys/un.h>
>+#include <sys/wait.h>
>+#include <unistd.h>
>+#include <sched.h>
>+
>+#include "../kselftest.h"
>+
>+static pid_t raw_clone(struct clone_args *args)
>+{
>+	return syscall(__NR_clone3, args, sizeof(struct clone_args));
>+}
>+
>+static int call_clone3(int flags)
>+{
>+	struct clone_args args = {0};
>+	pid_t ppid = -1;
>+	pid_t pid = -1;
>+	int status;
>+
>+	args.flags = flags;
>+	args.exit_signal = SIGCHLD;
>+
>+	pid = raw_clone(&args);
>+	if (pid < 0) {
>+		ksft_print_msg("%s - Failed to create new process\n",
>+				strerror(errno));
>+		return -errno;
>+	}
>+
>+	if (pid == 0) {
>+		ksft_print_msg("I am the child, my PID is %d\n", getpid());
>+		_exit(EXIT_SUCCESS);
>+	}
>+
>+	ppid = getpid();
>+	ksft_print_msg("I am the parent (%d). My child's pid is %d\n",
>+			ppid, pid);
>+
>+	(void)wait(&status);
>+	if (WEXITSTATUS(status))
>+		return WEXITSTATUS(status);
>+
>+	return 0;
>+}
>+
>+static int test_clone3(int flags, int expected)
>+{
>+	int ret;
>+
>+	ksft_print_msg("[%d] Trying clone3() with flags 0x%x\n",
>+			getpid(), flags);
>+	ret = call_clone3(flags);
>+	ksft_print_msg("[%d] clone3() with flags says :%d expected %d\n",
>+			getpid(), ret, expected);
>+	if (ret != expected)
>+		ksft_exit_fail_msg(
>+			"[%d] Result (%d) is different than expected (%d)\n",
>+			getpid(), ret, expected);
>+	ksft_test_result_pass("[%d] Result (%d) matches expectation (%d)\n",
>+			getpid(), ret, expected);
>+	return 0;
>+}
>+int main(int argc, char *argv[])
>+{
>+	int ret = -1;
>+	pid_t pid;
>+
>+	ksft_print_header();
>+	ksft_set_plan(3);
>+
>+	/* Just a simple clone3() should return 0.*/
>+	if (test_clone3(0, 0))
>+		goto on_error;
>+	/* Do a clone3() in a new PID NS.*/
>+	if (test_clone3(CLONE_NEWPID, 0))
>+		goto on_error;
>+	ksft_print_msg("First unshare\n");
>+	if (unshare(CLONE_NEWPID))
>+		goto on_error;
>+	/*
>+	 * Before clone3()ing in a new PID NS with
>+	 * CLONE_NEWPID a fork() is necessary.
>+	 */
>+	if (test_clone3(CLONE_NEWPID, -EINVAL))
>+		goto on_error;
>+	pid = fork();
>+	if (pid < 0) {
>+		ksft_print_msg("First fork() failed\n");
>+		goto on_error;
>+	}
>+	if (pid > 0) {
>+		(void)wait(NULL);
>+		goto parent_out;
>+	}
>+	ksft_set_plan(6);
>+	if (test_clone3(CLONE_NEWPID, 0))
>+		goto on_error;
>+	if (test_clone3(0, 0))
>+		goto on_error;
>+	ksft_print_msg("Second unshare\n");
>+	if (unshare(CLONE_NEWPID))
>+		goto on_error;
>+	/*
>+	 * Before clone3()ing in a new PID NS with
>+	 * CLONE_NEWPID a fork() is necessary.
>+	 */
>+	if (test_clone3(CLONE_NEWPID, -EINVAL))
>+		goto on_error;
>+	pid = fork();
>+	if (pid < 0) {
>+		ksft_print_msg("Second fork() failed\n");
>+		goto on_error;
>+	}
>+	if (pid > 0) {
>+		(void)wait(NULL);
>+		goto parent_out;
>+	}
>+	ksft_set_plan(8);
>+	if (test_clone3(CLONE_NEWPID, 0))
>+		goto on_error;
>+	if (test_clone3(0, 0))
>+		goto on_error;
>+
>+parent_out:
>+	ret = 0;
>+on_error:
>+
>+	return !ret ? ksft_exit_pass() : ksft_exit_fail();
>+}
>diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c
>b/tools/testing/selftests/clone3/clone3_set_tid.c
>new file mode 100644
>index 000000000000..f5012e84dcb3
>--- /dev/null
>+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
>@@ -0,0 +1,161 @@
>+// SPDX-License-Identifier: GPL-2.0
>+
>+/* Based on Christian Brauner's clone3() example */
>+
>+#define _GNU_SOURCE
>+#include <errno.h>
>+#include <linux/types.h>
>+#include <linux/sched.h>
>+#include <stdio.h>
>+#include <stdlib.h>
>+#include <sys/syscall.h>
>+#include <sys/types.h>
>+#include <sys/un.h>
>+#include <sys/wait.h>
>+#include <unistd.h>
>+#include <sched.h>
>+
>+#include "../kselftest.h"
>+
>+static pid_t raw_clone(struct clone_args *args)
>+{
>+	return syscall(__NR_clone3, args, sizeof(struct clone_args));
>+}
>+
>+static int call_clone3_set_tid(int set_tid, int flags)
>+{
>+	struct clone_args args = {0};
>+	pid_t ppid = -1;
>+	pid_t pid = -1;
>+	int status;
>+
>+	args.flags = flags;
>+	args.exit_signal = SIGCHLD;
>+	args.set_tid = set_tid;
>+
>+	pid = raw_clone(&args);
>+	if (pid < 0) {
>+		ksft_print_msg("%s - Failed to create new process\n",
>+				strerror(errno));
>+		return -errno;
>+	}
>+
>+	if (pid == 0) {
>+		ksft_print_msg("I am the child, my PID is %d (expected %d)\n",
>+				getpid(), set_tid);
>+		if (set_tid != getpid())
>+			_exit(EXIT_FAILURE);
>+		_exit(EXIT_SUCCESS);
>+	}
>+
>+	ppid = getpid();
>+	ksft_print_msg("I am the parent (%d). My child's pid is %d\n",
>+			ppid, pid);
>+
>+	(void)wait(&status);
>+	if (WEXITSTATUS(status))
>+		return WEXITSTATUS(status);
>+
>+	return 0;
>+}
>+
>+static int test_clone3_set_tid(int set_tid, int flags, int expected)
>+{
>+	int ret;
>+
>+	ksft_print_msg(
>+		"[%d] Trying clone3() with CLONE_SET_TID to %d and 0x%x\n",
>+		getpid(), set_tid, flags);
>+	ret = call_clone3_set_tid(set_tid, flags);
>+	ksft_print_msg(
>+		"[%d] clone3() with CLONE_SET_TID %d says :%d - expected %d\n",
>+		getpid(), set_tid, ret, expected);
>+	if (ret != expected)
>+		ksft_exit_fail_msg(
>+			"[%d] Result (%d) is different than expected (%d)\n",
>+			getpid(), ret, expected);
>+	ksft_test_result_pass("[%d] Result (%d) matches expectation (%d)\n",
>+			getpid(), ret, expected);
>+	return 0;
>+}
>+int main(int argc, char *argv[])
>+{
>+	FILE *f;
>+	int pid_max = 0;
>+	pid_t pid;
>+	pid_t ns_pid;
>+	int ret = -1;
>+
>+	ksft_print_header();
>+	ksft_set_plan(13);
>+
>+	f = fopen("/proc/sys/kernel/pid_max", "r");
>+	if (f == NULL)
>+		ksft_exit_fail_msg(
>+			"%s - Could not open /proc/sys/kernel/pid_max\n",
>+			strerror(errno));
>+	fscanf(f, "%d", &pid_max);
>+	fclose(f);
>+	ksft_print_msg("/proc/sys/kernel/pid_max %d\n", pid_max);
>+
>+	/* First try with an invalid PID */
>+	if (test_clone3_set_tid(-1, 0, -EINVAL))
>+		goto on_error;
>+	if (test_clone3_set_tid(-1, CLONE_NEWPID, -EINVAL))
>+		goto on_error;
>+	/* Then with PID 1 */
>+	if (test_clone3_set_tid(1, 0, -EEXIST))
>+		goto on_error;
>+	/* PID 1 should not fail in a PID namespace */
>+	if (test_clone3_set_tid(1, CLONE_NEWPID, 0))
>+		goto on_error;
>+	/* pid_max should fail everywhere */
>+	if (test_clone3_set_tid(pid_max, 0, -EINVAL))
>+		goto on_error;
>+	if (test_clone3_set_tid(pid_max, CLONE_NEWPID, -EINVAL))
>+		goto on_error;
>+	/* Find the current active PID */
>+	pid = fork();
>+	if (pid == 0) {
>+		ksft_print_msg("Child has PID %d\n", getpid());
>+		sleep(1);
>+		_exit(EXIT_SUCCESS);
>+	}
>+	/* Try to create a process with that PID should fail */
>+	if (test_clone3_set_tid(pid, 0, -EEXIST))
>+		goto on_error;
>+	(void)wait(NULL);
>+	/* After the child has finished, try again with the same PID */
>+	if (test_clone3_set_tid(pid, 0, 0))
>+		goto on_error;
>+	/* This should fail as there is no PID 1 in that namespace */
>+	if (test_clone3_set_tid(pid, CLONE_NEWPID, -EINVAL))
>+		goto on_error;
>+	unshare(CLONE_NEWPID);
>+	if (test_clone3_set_tid(10, 0, -EINVAL))
>+		goto on_error;
>+	/* Let's create a PID 1 */
>+	ns_pid = fork();
>+	if (ns_pid == 0) {
>+		ksft_print_msg("Child in PID namespace has PID %d\n", getpid());
>+		sleep(1);
>+		_exit(EXIT_SUCCESS);
>+	}
>+	/*
>+	 * Now, after the unshare() it should be possible to create a process
>+	 * with another ID than 1 in the PID namespace.
>+	 */
>+	if (test_clone3_set_tid(2, 0, 0))
>+		goto on_error;
>+	/* Use a different PID in this namespace. */
>+	if (test_clone3_set_tid(2222, 0, 0))
>+		goto on_error;
>+	if (test_clone3_set_tid(1, 0, -EEXIST))
>+		goto on_error;
>+	(void)wait(NULL);
>+
>+	ret = 0;
>+on_error:
>+
>+	return !ret ? ksft_exit_pass() : ksft_exit_fail();
>+}

Thanks for the tests!
Could you also add tests where we pass invalid or unknown struct sizes?:
- pass struct size that is too small aka < CLONE3_ARGS_SIZE_V0
- pass a struct size that is too large aka > PAGE_SIZE
- pass struct size that is smaller than the one the kernel supports
- pass struct size that is larger than the one the kernel supports; once with all unknown fields set to 0 and once with a field set to non-0

I think this might fit well with this patch since it changes the struct size. :)

Sorry, I didn't know you'd be sending out a new version today. :)

Christian
