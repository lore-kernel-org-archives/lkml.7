Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C724BC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1670B20891
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="AbEC8OmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfDYQPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:15:05 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33661 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728938AbfDYQPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:15:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id d55so431348ede.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ppbYUdfI3sJgTp+sWoMuPAWR6kGpJpj8xIPAGOifh4g=;
        b=AbEC8OmJUOaFRfrFSPjQGv2nFz5KEETmUN5jaDPEMZ50opdGnnBzodiRJ3s1At6K73
         FcwrYc6uvEvIRCIgkbdf3G52O7irWu/2McFOSzS+HytGcrXj9eHy54S+feuxYbI89Gyl
         Q3Ku7p3Ma+2mIaOQIQJNoKkQrEq5UfjbApz28V9XRDlk1UAnfx5EHh94y8bYduKtKgfu
         gME3EOsLI1b80z+hDF+3/3TNwr8O5yl0UyZip605zvBiNCZIZKkT4qKHbg799s5nYIFx
         oKWAziqvnRVGlFaWpFBVpZnVCFTqZw535Sj1i53Msc8LDvRufO8gPVpVt3Lv7OXCIQzP
         qytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ppbYUdfI3sJgTp+sWoMuPAWR6kGpJpj8xIPAGOifh4g=;
        b=rRnZsZDsYSb5dumA3Wx32gGt7wNOBSy+LFb0EgydPTkPr5if/8CZwqMmM7uHjlhZ4Z
         I6hrHXxgV5qvwKIIndcO0ZKtBIVu9WI9cD3LCI+BzONgeTMrHZiF7Idojy+iX5jVsq7+
         eaB4Clwia+GVK09xuzF35Ee3RfQmEroeNxtp1fHZuIb0wn62jZEgNF9UqGBr4Mf4c1Ai
         yQWNvDznvKF3NmvJrtUWmS/dJr9En4QlxXtnKPovMfFiPI89Ia/+6gtlVX6ueaD100HW
         ut4nom6Ttk6ZsjtT9/3MB/WSvhfxG/Zj5HAczDMU1tqiKKQuWxFN7zEQrzV6ecnIU9C1
         DCLQ==
X-Gm-Message-State: APjAAAW2nuZR3ZlMwy3Pf+heqYF9aglF0i/GnkbRZNccAaiYX7+7Snw7
        J5DKY+PZNf0DscrniiTfagPltylsA3M=
X-Google-Smtp-Source: APXvYqxmFnbf6elnG86GTSwN9wHMcoylG4GQX483RkE/yKkU6xb+t+fDq0bbAU/UnD9ecqLVYFCnpA==
X-Received: by 2002:a17:906:4e88:: with SMTP id v8mr19461438eju.160.1556208901322;
        Thu, 25 Apr 2019 09:15:01 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id br19sm4147042ejb.48.2019.04.25.09.14.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 09:15:00 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
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
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv3 26/27] selftests: Add a simple perf test for clock_gettime()
Date:   Thu, 25 Apr 2019 17:14:15 +0100
Message-Id: <20190425161416.26600-27-dima@arista.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190425161416.26600-1-dima@arista.com>
References: <20190425161416.26600-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore     |  2 +
 tools/testing/selftests/timens/Makefile       |  8 +-
 tools/testing/selftests/timens/gettime_perf.c | 74 +++++++++++++++++++
 .../selftests/timens/gettime_perf_cold.c      | 63 ++++++++++++++++
 4 files changed, 146 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/gettime_perf.c
 create mode 100644 tools/testing/selftests/timens/gettime_perf_cold.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index 3b7eda8f35ce..16292e4d08a5 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1,4 +1,6 @@
 clock_nanosleep
+gettime_perf
+gettime_perf_cold
 procfs
 timens
 timer
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index ae1ffd24cc43..ef65bf96b55c 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,4 +1,10 @@
-TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs
+TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs gettime_perf
+
+uname_M := $(shell uname -m 2>/dev/null || echo not)
+ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/i386/)
+ifeq ($(ARCH),x86_64)
+TEST_GEN_PROGS += gettime_perf_cold
+endif
 
 CFLAGS := -Wall -Werror
 LDFLAGS := -lrt
diff --git a/tools/testing/selftests/timens/gettime_perf.c b/tools/testing/selftests/timens/gettime_perf.c
new file mode 100644
index 000000000000..510d77a941d9
--- /dev/null
+++ b/tools/testing/selftests/timens/gettime_perf.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <time.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+
+#include "log.h"
+#include "timens.h"
+
+//#define TEST_SYSCALL
+
+static void test(clock_t clockid, char *clockstr, bool in_ns)
+{
+	struct timespec tp, start;
+	long i = 0;
+	const int timeout = 3;
+
+#ifndef TEST_SYSCALL
+	clock_gettime(clockid, &start);
+#else
+	syscall(__NR_clock_gettime, clockid, &start);
+#endif
+	tp = start;
+	for (tp = start; start.tv_sec + timeout > tp.tv_sec ||
+			 (start.tv_sec + timeout == tp.tv_sec &&
+			  start.tv_nsec > tp.tv_nsec); i++) {
+#ifndef TEST_SYSCALL
+		clock_gettime(clockid, &tp);
+#else
+		syscall(__NR_clock_gettime, clockid, &tp);
+#endif
+	}
+
+	ksft_test_result_pass("%s:\tclock: %10s\tcycles:\t%10ld\n",
+			      in_ns ? "ns" : "host", clockstr, i);
+}
+
+int main(int argc, char *argv[])
+{
+	time_t offset = 10;
+	int nsfd;
+
+	test(CLOCK_MONOTONIC, "monotonic", false);
+	test(CLOCK_BOOTTIME, "boottime", false);
+
+	nscheck();
+
+	if (unshare(CLONE_NEWTIME))
+		return pr_perror("Can't unshare() timens");
+
+	nsfd = open("/proc/self/ns/time_for_children", O_RDONLY);
+	if (nsfd < 0)
+		return pr_perror("Can't open a time namespace");
+
+	if (_settime(CLOCK_MONOTONIC, offset))
+		return 1;
+	if (_settime(CLOCK_BOOTTIME, offset))
+		return 1;
+
+	if (setns(nsfd, CLONE_NEWTIME))
+		return pr_perror("setns");
+
+	test(CLOCK_MONOTONIC, "monotonic", true);
+	test(CLOCK_BOOTTIME, "boottime", true);
+
+	ksft_exit_pass();
+	return 0;
+}
diff --git a/tools/testing/selftests/timens/gettime_perf_cold.c b/tools/testing/selftests/timens/gettime_perf_cold.c
new file mode 100644
index 000000000000..f72db8a4c903
--- /dev/null
+++ b/tools/testing/selftests/timens/gettime_perf_cold.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <time.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <string.h>
+
+#include "log.h"
+#include "timens.h"
+
+static __inline__ unsigned long long rdtsc(void)
+{
+	unsigned hi, lo;
+
+	__asm__ __volatile__ ("rdtsc" : "=a"(lo), "=d"(hi));
+	return ((unsigned long long) lo) | (((unsigned long long)hi) << 32);
+}
+
+static void test(clock_t clockid, char *clockstr)
+{
+	struct timespec tp;
+	long long s, e;
+
+	s = rdtsc();
+	clock_gettime(clockid, &tp);
+	e = rdtsc();
+	printf("%lld\n", e - s);
+	return;
+}
+
+int main(int argc, char **argv)
+{
+	time_t offset = 10;
+	int nsfd;
+
+	if (argc == 1) {
+		test(CLOCK_MONOTONIC, "monotonic");
+		return 0;
+	}
+	nscheck();
+
+	if (unshare(CLONE_NEWTIME))
+		return pr_perror("Can't unshare() timens");
+
+	nsfd = open("/proc/self/ns/time_for_children", O_RDONLY);
+	if (nsfd < 0)
+		return pr_perror("Can't open a time namespace");
+
+	if (_settime(CLOCK_MONOTONIC, offset))
+		return 1;
+
+	if (setns(nsfd, CLONE_NEWTIME))
+		return pr_perror("setns");
+
+	test(CLOCK_MONOTONIC, "monotonic");
+	return 0;
+}
-- 
2.21.0

