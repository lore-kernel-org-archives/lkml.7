Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC15CC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71CF2190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfJKMXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:23:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728070AbfJKMXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:23:50 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7BD5580F83
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 12:23:49 +0000 (UTC)
Received: by mail-ed1-f70.google.com with SMTP id c23so5636669edb.14
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 05:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3cPBHk1mEoebcHg5P34RWIFsyAjZtXn8ix58sCjirqg=;
        b=fR7ZWgP2NIdvjBvjuekbIZ3CUFLXIdhG5ORE8xVhpdYKHRgOzaOfAjpXD53jICzgOY
         3yFE17uYukntNgruNtFeHv730R/FKArQdgsA3OUP5nR2AlqRd/G+s52p4mIFD7Hn0rPg
         MP2o6ZAjEsLoOtWeHgSeScj8zvwYeEAD2JsAY2pEAKwR5V5LCu4jqSGSNAmKKMqGIcT6
         WzzcaRByQwqdA4uFOkr+KaJn4HPXin6QNzQgLZ9HCvB9fJKuuGkLfuunV61bF9goUv1S
         H/ubgF8LLvrxy0HFN7U5dfjXKZjqYxRD8Gm5dtd7d+C5+S+vzGc6TGPJBjcAH8jKjxbm
         5Qdg==
X-Gm-Message-State: APjAAAV5dEymAIR7IdOn6r4KDcTYHly3NOuMONP3R+X8r6TKVgJDJydQ
        IVfkaFpIIdbgDyQWbwzBJvSglT7s723v21krSAQqN0ZD/H0x3upyutBGaLoD1e1dOMX2NCYvIv8
        1BGCRd+C8KkGMAzjw6Ab4wTsI
X-Received: by 2002:aa7:d6cd:: with SMTP id x13mr13234265edr.272.1570796627954;
        Fri, 11 Oct 2019 05:23:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx3FaL2QqsIQ6t673/hPHNxo+RsW5gKJLm6+xJjO1xTQgAVjVXfuzs53s1wKTr2WV9wc/xbwQ==
X-Received: by 2002:aa7:d6cd:: with SMTP id x13mr13234239edr.272.1570796627703;
        Fri, 11 Oct 2019 05:23:47 -0700 (PDT)
Received: from localhost ([2a02:2450:102e:d85:877d:43b4:dd8f:144d])
        by smtp.gmail.com with ESMTPSA id w21sm1533538eda.90.2019.10.11.05.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 05:23:47 -0700 (PDT)
From:   Christian Kellner <ckellner@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org,
        Christian Kellner <christian@kellner.me>,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 2/2] pidfd: add tests for NSpid info in fdinfo
Date:   Fri, 11 Oct 2019 14:23:21 +0200
Message-Id: <20191011122323.7770-2-ckellner@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011122323.7770-1-ckellner@redhat.com>
References: <20191009160532.20674-1-ckellner@redhat.com>
 <20191011122323.7770-1-ckellner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Kellner <christian@kellner.me>

Add tests that check that if pid namespaces are configured the fdinfo
file of a pidfd contains an NSpid: entry containing the process id
in the current and additionally all nested namespaces.

Signed-off-by: Christian Kellner <christian@kellner.me>
---
 tools/testing/selftests/pidfd/Makefile        |  2 +-
 tools/testing/selftests/pidfd/pidfd.h         | 12 +++
 .../selftests/pidfd/pidfd_fdinfo_test.c       | 98 +++++++++++++++++++
 tools/testing/selftests/pidfd/pidfd_test.c    | 12 ---
 4 files changed, 111 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c

diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index 7550f08822a3..43db1b98e845 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -g -I../../../../usr/include/ -pthread
 
-TEST_GEN_PROGS := pidfd_test pidfd_open_test pidfd_poll_test pidfd_wait
+TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test pidfd_poll_test pidfd_wait
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index c6bc68329f4b..2946d788645b 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -84,4 +84,16 @@ static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
 	return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
 }
 
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
 #endif /* __PIDFD_H */
diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
new file mode 100644
index 000000000000..fbae502ad8ad
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/types.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <sys/wait.h>
+
+#include "pidfd.h"
+#include "../kselftest.h"
+
+static int child_fdinfo_nspid_test(void *args)
+{
+	ksft_print_msg("Child: pid %d\n", getpid());
+	return 0;
+}
+
+static int compare_fdinfo_nspid(int pidfd, char *expect, size_t len)
+{
+	char path[512];
+	FILE *f;
+	size_t n = 0;
+	ssize_t k;
+	char *line = NULL;
+	int r = -1;
+
+	snprintf(path, sizeof(path), "/proc/self/fdinfo/%d", pidfd);
+
+	f = fopen(path, "re");
+	if (!f)
+		return -1;
+
+	while ((k = getline(&line, &n, f)) != -1) {
+		if (strncmp(line, "NSpid:", 6))
+			continue;
+
+		line[k - 1] = '\0';
+		ksft_print_msg("Child: fdinfo NSpid line: '%s'.\n", line);
+		r = strncmp(line + 6, expect, len);
+		break;
+	}
+
+	free(line);
+	fclose(f);
+
+	return r;
+}
+
+static void test_pidfd_fdinfo_nspid(void)
+{
+	char expect[512];
+	int pid, pidfd = 0;
+	int n, r;
+	const char *test_name = "pidfd check for NSpid information in fdinfo";
+
+	pid = pidfd_clone(CLONE_PIDFD | CLONE_NEWPID | CLONE_NEWUSER, &pidfd,
+			  child_fdinfo_nspid_test);
+	if (pid < 0)
+		ksft_exit_fail_msg(
+			"%s test: pidfd_clone failed (ret %d, errno %d)\n",
+			test_name, pid, errno);
+
+	ksft_print_msg("Parent: child-pid: %d\n", pid);
+
+	/* The child will have pid 1 in the new pid namespace,
+	 * so the line must be 'NSPid:\t<pid>\t1'
+	 */
+	n = snprintf(expect, sizeof(expect), "\t%d\t%d", pid, 1);
+	r = compare_fdinfo_nspid(pidfd, expect, n);
+
+	(void)close(pidfd);
+
+	if (wait_for_pid(pid))
+		ksft_exit_fail_msg(
+			"%s test: waitpid failed (ret %d, errno %d)\n",
+			test_name, r, errno);
+
+	if (r != 0)
+		ksft_exit_fail_msg("%s test: Failed\n", test_name);
+	else
+		ksft_test_result_pass("%s test: Passed\n", test_name);
+}
+
+int main(int argc, char **argv)
+{
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	test_pidfd_fdinfo_nspid();
+
+	return ksft_exit_pass();
+}
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 7aff2d3b42c0..9cf0b6b3e389 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -27,18 +27,6 @@
 
 #define MAX_EVENTS 5
 
-static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
-{
-	size_t stack_size = 1024;
-	char *stack[1024] = { 0 };
-
-#ifdef __ia64__
-	return __clone2(fn, stack, stack_size, flags | SIGCHLD, NULL, pidfd);
-#else
-	return clone(fn, stack + stack_size, flags | SIGCHLD, NULL, pidfd);
-#endif
-}
-
 static int signal_received;
 
 static void set_signal_received_on_sigusr1(int sig)
-- 
2.21.0

