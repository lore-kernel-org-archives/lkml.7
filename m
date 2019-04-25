Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89BDC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BAE214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Nsn6kd0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfDYQO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:14:59 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35885 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbfDYQOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:14:53 -0400
Received: by mail-ed1-f65.google.com with SMTP id u57so413212edm.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0sP3xwkGhzT+CuPyZFvnURVXk85+qPoqAIfzfDwVyFQ=;
        b=Nsn6kd0UOo1EArsy8hQALSWYKYj+0RV/0eAdB/QQ0TUCNjQCgxLBAuhV8vlixSwanv
         PxJYLutNofaTguFrrryn1UUy+M3qnh4KDS8BTlO+jZoCCJ0gZO8h+aiYJ6rvtDw57zsH
         DpLLvHu/nIioQg/Rhw4kinfe6S4zN36yJ72CNiL0PRwkaBYsU3ybIRqgEWo0Ve5BZSvo
         9OBNgwdhYXYYyt+wvTc9DNDFAfsU40UK0ddtfuJl8YkJ8IICZkoNQv3sVgklvPJKflmB
         AotqvLZH11wimv6F/YIqmaA1bU+rfWLVXpAeC6qT+tgxTs42Tnth/XkTfnHRTLJgnouB
         3S+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0sP3xwkGhzT+CuPyZFvnURVXk85+qPoqAIfzfDwVyFQ=;
        b=TiWvUzpxDeTO8mdmJSJt9Vigwlo++Ibc2ww00N+j9RVfGhYA7TDwM2YsGSajJygNiH
         fJjsXorXPu8a0jPxNtu0xvow1lRiAZPGXs0NRZv/Aj3z9vBU1S3DufpphVQh4oRo1xT2
         qRYmaSkMeJdK0NOmuAq0uEkYZ/6qJQJpwpbIcq1xYdOQnvYd6tPJlYyClUJ5gcpbKZZD
         yGPON89wPiS98O/r0Eip7dRTMwY0bRmXLGXUNfCcWitvLKvTaA8WQ8xrtbdqOoSLB+5u
         krXQaOSMyfBkdGWFdWKev8Wo76qtdhFvGN8j4EMdAi3xNs50hK9L1jB79gXVJcTZ7raf
         mlRw==
X-Gm-Message-State: APjAAAUi4vK1rVzfGTWqi9hvCtHdS3yCSj5hmsToUwcuxgRVr+Blz9PW
        NLHWaGk2DQHRam2vOQHGmI6jAZSufYA=
X-Google-Smtp-Source: APXvYqx9G+LK1xgCOdh0oEXU5P3VNIhifAoMULMbkSIxehqmmZr8DGEVK7WmCv3q8NUdme/ERxpRSw==
X-Received: by 2002:a50:89f6:: with SMTP id h51mr25047167edh.131.1556208891707;
        Thu, 25 Apr 2019 09:14:51 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id br19sm4147042ejb.48.2019.04.25.09.14.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 09:14:51 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCHv3 20/27] selftest/timens: Add Time Namespace test for supported clocks
Date:   Thu, 25 Apr 2019 17:14:09 +0100
Message-Id: <20190425161416.26600-21-dima@arista.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190425161416.26600-1-dima@arista.com>
References: <20190425161416.26600-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test to check that all supported clocks work on host and inside
a new time namespace. Use both ways to get time: through VDSO and
by entering the kernel with implicit syscall.

Introduce a new timens directory in selftests framework for
the next timens tests.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/Makefile          |   1 +
 tools/testing/selftests/timens/.gitignore |   1 +
 tools/testing/selftests/timens/Makefile   |   5 +
 tools/testing/selftests/timens/config     |   1 +
 tools/testing/selftests/timens/log.h      |  26 +++
 tools/testing/selftests/timens/timens.c   | 188 ++++++++++++++++++++++
 tools/testing/selftests/timens/timens.h   |  63 ++++++++
 7 files changed, 285 insertions(+)
 create mode 100644 tools/testing/selftests/timens/.gitignore
 create mode 100644 tools/testing/selftests/timens/Makefile
 create mode 100644 tools/testing/selftests/timens/config
 create mode 100644 tools/testing/selftests/timens/log.h
 create mode 100644 tools/testing/selftests/timens/timens.c
 create mode 100644 tools/testing/selftests/timens/timens.h

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 971fc8428117..7cfb6e96f391 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -47,6 +47,7 @@ TARGETS += splice
 TARGETS += static_keys
 TARGETS += sync
 TARGETS += sysctl
+TARGETS += timens
 ifneq (1, $(quicktest))
 TARGETS += timers
 endif
diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
new file mode 100644
index 000000000000..27a693229ce1
--- /dev/null
+++ b/tools/testing/selftests/timens/.gitignore
@@ -0,0 +1 @@
+timens
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
new file mode 100644
index 000000000000..b877efb78974
--- /dev/null
+++ b/tools/testing/selftests/timens/Makefile
@@ -0,0 +1,5 @@
+TEST_GEN_PROGS := timens
+
+CFLAGS := -Wall -Werror
+
+include ../lib.mk
diff --git a/tools/testing/selftests/timens/config b/tools/testing/selftests/timens/config
new file mode 100644
index 000000000000..4480620f6f49
--- /dev/null
+++ b/tools/testing/selftests/timens/config
@@ -0,0 +1 @@
+CONFIG_TIME_NS=y
diff --git a/tools/testing/selftests/timens/log.h b/tools/testing/selftests/timens/log.h
new file mode 100644
index 000000000000..db64df2a8483
--- /dev/null
+++ b/tools/testing/selftests/timens/log.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __SELFTEST_TIMENS_LOG_H__
+#define __SELFTEST_TIMENS_LOG_H__
+
+#define pr_msg(fmt, lvl, ...)						\
+	ksft_print_msg("[%s] (%s:%d)\t" fmt "\n",			\
+			lvl, __FILE__, __LINE__, ##__VA_ARGS__)
+
+#define pr_p(func, fmt, ...)	func(fmt ": %m", ##__VA_ARGS__)
+
+#define pr_err(fmt, ...)						\
+	({								\
+		ksft_test_result_error(fmt "\n", ##__VA_ARGS__);		\
+		-1;							\
+	})
+
+#define pr_fail(fmt, ...)					\
+	({							\
+		ksft_test_result_fail(fmt, ##__VA_ARGS__);	\
+		-1;						\
+	})
+
+#define pr_perror(fmt, ...)	pr_p(pr_err, fmt, ##__VA_ARGS__)
+
+#endif
diff --git a/tools/testing/selftests/timens/timens.c b/tools/testing/selftests/timens/timens.c
new file mode 100644
index 000000000000..407e7a97882f
--- /dev/null
+++ b/tools/testing/selftests/timens/timens.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <time.h>
+#include <unistd.h>
+#include <time.h>
+#include <string.h>
+
+#include "log.h"
+#include "timens.h"
+
+/*
+ * Test shouldn't be run for a day, so add 10 days to child
+ * time and check parent's time to be in the same day.
+ */
+#define DAY_IN_SEC			(60*60*24)
+#define TEN_DAYS_IN_SEC			(10*DAY_IN_SEC)
+
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+#define CLOCK_TYPES							\
+	ct(CLOCK_BOOTTIME, -1),						\
+	ct(CLOCK_BOOTTIME_ALARM, 1),					\
+	ct(CLOCK_MONOTONIC, -1),					\
+	ct(CLOCK_MONOTONIC_COARSE, 1),					\
+	ct(CLOCK_MONOTONIC_RAW, 1),					\
+
+
+struct test_clock {
+	clockid_t id;
+	char *name;
+	/*
+	 * off_id is -1 if a clock has own offset, or it contains an index
+	 * which contains a right offset of this clock.
+	 */
+	int off_id;
+	time_t offset;
+};
+
+#define ct(clock, off_id)	{ clock, #clock, off_id }
+static struct test_clock clocks[] = {
+	CLOCK_TYPES
+};
+#undef ct
+
+static int child_ns, parent_ns = -1;
+
+static int switch_ns(int fd)
+{
+	if (setns(fd, CLONE_NEWTIME)) {
+		pr_perror("setns()");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int init_namespaces(void)
+{
+	char path[] = "/proc/self/ns/time_for_children";
+	struct stat st1, st2;
+
+	if (parent_ns == -1) {
+		parent_ns = open(path, O_RDONLY);
+		if (parent_ns <= 0)
+			return pr_perror("Unable to open %s", path);
+	}
+
+	if (fstat(parent_ns, &st1))
+		return pr_perror("Unable to stat the parent timens");
+
+	if (unshare(CLONE_NEWTIME))
+		return pr_perror("Can't unshare() timens");
+
+	child_ns = open(path, O_RDONLY);
+	if (child_ns <= 0)
+		return pr_perror("Unable to open %s", path);
+
+	if (fstat(child_ns, &st2))
+		return pr_perror("Unable to stat the timens");
+
+	if (st1.st_ino == st2.st_ino)
+		return pr_perror("The same child_ns after CLONE_NEWTIME");
+
+	return 0;
+}
+
+static int test_gettime(clockid_t clock_index, bool raw_syscall, time_t offset)
+{
+	struct timespec child_ts_new, parent_ts_old, cur_ts;
+	char *entry = raw_syscall ? "syscall" : "vdso";
+	double precision = 0.0;
+
+	switch (clocks[clock_index].id) {
+	case CLOCK_MONOTONIC_COARSE:
+	case CLOCK_MONOTONIC_RAW:
+		precision = -2.0;
+		break;
+	}
+
+	if (switch_ns(parent_ns))
+		return pr_err("switch_ns(%d)", child_ns);
+
+	if (_gettime(clocks[clock_index].id, &parent_ts_old, raw_syscall))
+		return -1;
+
+	child_ts_new.tv_nsec = parent_ts_old.tv_nsec;
+	child_ts_new.tv_sec = parent_ts_old.tv_sec + offset;
+
+	if (switch_ns(child_ns))
+		return pr_err("switch_ns(%d)", child_ns);
+
+	if (_gettime(clocks[clock_index].id, &cur_ts, raw_syscall))
+		return -1;
+
+	if (difftime(cur_ts.tv_sec, child_ts_new.tv_sec) < precision) {
+		ksft_test_result_fail(
+			"Child's %s (%s) time has not changed: %lu -> %lu [%lu]\n",
+			clocks[clock_index].name, entry, parent_ts_old.tv_sec,
+			child_ts_new.tv_sec, cur_ts.tv_sec);
+		return -1;
+	}
+
+	if (switch_ns(parent_ns))
+		return pr_err("switch_ns(%d)", parent_ns);
+
+	if (_gettime(clocks[clock_index].id, &cur_ts, raw_syscall))
+		return -1;
+
+	if (difftime(cur_ts.tv_sec, parent_ts_old.tv_sec) > DAY_IN_SEC) {
+		ksft_test_result_fail(
+			"Parent's %s (%s) time has changed: %lu -> %lu [%lu]\n",
+			clocks[clock_index].name, entry, parent_ts_old.tv_sec,
+			child_ts_new.tv_sec, cur_ts.tv_sec);
+		/* Let's play nice and put it closer to original */
+		clock_settime(clocks[clock_index].id, &cur_ts);
+		return -1;
+	}
+
+	ksft_test_result_pass("Passed for %s (%s)\n",
+				clocks[clock_index].name, entry);
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned int i;
+	time_t offset;
+	int ret = 0;
+
+	nscheck();
+
+
+	if (init_namespaces())
+		return 1;
+
+	/* Offsets have to be set before tasks enter the namespace. */
+	for (i = 0; i < ARRAY_SIZE(clocks); i++) {
+		if (clocks[i].off_id != -1)
+			continue;
+		offset = TEN_DAYS_IN_SEC + i * 1000;
+		clocks[i].offset = offset;
+		if (_settime(clocks[i].id, offset))
+			return 1;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(clocks); i++) {
+		if (clocks[i].off_id != -1)
+			offset = clocks[clocks[i].off_id].offset;
+		else
+			offset = clocks[i].offset;
+		ret |= test_gettime(i, true, offset);
+		ret |= test_gettime(i, false, offset);
+	}
+
+	if (ret)
+		ksft_exit_fail();
+
+	ksft_exit_pass();
+	return !!ret;
+}
diff --git a/tools/testing/selftests/timens/timens.h b/tools/testing/selftests/timens/timens.h
new file mode 100644
index 000000000000..71a0ad78c634
--- /dev/null
+++ b/tools/testing/selftests/timens/timens.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TIMENS_H__
+#define __TIMENS_H__
+
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdbool.h>
+
+#include "../kselftest.h"
+
+#ifndef CLONE_NEWTIME
+# define CLONE_NEWTIME	0x00001000
+#endif
+
+static inline int _settime(clockid_t clk_id, time_t offset)
+{
+	int fd, len;
+	char buf[4096];
+
+	if (clk_id == CLOCK_MONOTONIC_COARSE || clk_id == CLOCK_MONOTONIC_RAW)
+		clk_id = CLOCK_MONOTONIC;
+
+	len = snprintf(buf, sizeof(buf), "%d %ld 0", clk_id, offset);
+
+	fd = open("/proc/self/timens_offsets", O_WRONLY);
+	if (fd < 0)
+		return pr_perror("/proc/self/timens_offsets");
+
+	if (write(fd, buf, len) != len)
+		return pr_perror("/proc/self/timens_offsets");
+
+	close(fd);
+
+	return 0;
+}
+
+static inline int _gettime(clockid_t clk_id, struct timespec *res, bool raw_syscall)
+{
+	int err;
+
+	if (!raw_syscall) {
+		if (clock_gettime(clk_id, res)) {
+			pr_perror("clock_gettime(%d)", (int)clk_id);
+			return -1;
+		}
+		return 0;
+	}
+
+	err = syscall(SYS_clock_gettime, clk_id, res);
+	if (err)
+		pr_perror("syscall(SYS_clock_gettime(%d))", (int)clk_id);
+
+	return err;
+}
+
+static inline void nscheck(void)
+{
+	if (access("/proc/self/ns/time", F_OK) < 0)
+		ksft_exit_skip("Time namespaces are not supported\n");
+}
+
+#endif
-- 
2.21.0

