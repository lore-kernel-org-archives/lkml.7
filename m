Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74347C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA11420651
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="VHRxYHuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfDYQP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:15:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41482 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbfDYQO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:14:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id m4so382414edd.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+4600aGXIC0qkIOtpB3WZuPhHkTSZFXZzi+VKOU2Bd0=;
        b=VHRxYHuf2C2zBh9h0R+NBcz8miij5PyDSTm5b8sHnQvWK7F94v2AOeAUbiuUzRFMCP
         iRFufreu/xB9hLkf/TBiX/yyRsE/N3JRwaWfC0xI9+X8PsoO0i1cmXIyFzS3TMh6v/xq
         zfEduJnF8tdLXfBqsjAP1KGIgzYdingBblbiudMvt0SMk+PSoPahxeWyYQ1mxCsUDn/a
         ykGXuJWasadSU3hUo6Qdt/SFw6poumD7A5JEkGMkDtIIGcIsYruyn7PGS1isssbypDe5
         AADnrG7w0YHJCf2gl2nsSktyx2ejRP5yggzOx1h/cm6MmhvaTwaxsbuEgXEYxmrlLq5X
         FANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+4600aGXIC0qkIOtpB3WZuPhHkTSZFXZzi+VKOU2Bd0=;
        b=Zb2gQLevxXKpqabesYX3B+rmAWtVq01Q/3yIqdgpmCdApLSSlBeuvz0o1JLtC2EhFs
         poWYqmdjlJB+BzKqTlPWJVelu9/QApCGFH8eOh+A65yIVbm6rqsu1d/7YwgWmq8wRLjf
         FGfLK0VW4el1N5083KMUY1v6GVbc40/TAAVLrNPpUzfl7/PPds8pDYMVZOuHxMoHHnTj
         ekEWPBMxHARCoaam37u+O8tVO2H4L9/a++cNnRN2TnSZBKxGxG9p/JUhpiQXOBARUmYM
         AX0/8oBSIFKQMnxrb7a69F5lFp0vGC/EMhJHG21lJBdButdX1awo02DyYPAmcr8yAezG
         2WuA==
X-Gm-Message-State: APjAAAXx7xXIwJSVQo2AEfL/Z4VrdKxO5jCzlpWTQP9A/deqMdQHTDB8
        w0cnu0G7KV2CeQdzfdpbfPV1GaBtwBA=
X-Google-Smtp-Source: APXvYqyLAKSlPZu6HREFbNbDEwszyA6Dt4G6rI4kep7+iEA2AEy9gf6p6LzxqROGnupXloVDkp5qFg==
X-Received: by 2002:a50:8e95:: with SMTP id w21mr25048272edw.154.1556208896587;
        Thu, 25 Apr 2019 09:14:56 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id br19sm4147042ejb.48.2019.04.25.09.14.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 09:14:56 -0700 (PDT)
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
Subject: [PATCHv3 23/27] selftest/timens: Add procfs selftest
Date:   Thu, 25 Apr 2019 17:14:12 +0100
Message-Id: <20190425161416.26600-24-dima@arista.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190425161416.26600-1-dima@arista.com>
References: <20190425161416.26600-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check that /proc/uptime is correct inside a new time namespace.

Co-developed-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore |   1 +
 tools/testing/selftests/timens/Makefile   |   2 +-
 tools/testing/selftests/timens/procfs.c   | 142 ++++++++++++++++++++++
 3 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/procfs.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index 9b6c8ddac2c8..94ffdd9cead7 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1,3 +1,4 @@
 clock_nanosleep
+procfs
 timens
 timerfd
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index 76a1dc891184..f96f50d1fef8 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,4 +1,4 @@
-TEST_GEN_PROGS := timens timerfd clock_nanosleep
+TEST_GEN_PROGS := timens timerfd clock_nanosleep procfs
 
 CFLAGS := -Wall -Werror
 
diff --git a/tools/testing/selftests/timens/procfs.c b/tools/testing/selftests/timens/procfs.c
new file mode 100644
index 000000000000..89a24c134510
--- /dev/null
+++ b/tools/testing/selftests/timens/procfs.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <math.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <time.h>
+#include <unistd.h>
+#include <time.h>
+
+#include "log.h"
+#include "timens.h"
+
+/*
+ * Test shouldn't be run for a day, so add 10 days to child
+ * time and check parent's time to be in the same day.
+ */
+#define MAX_TEST_TIME_SEC		(60*5)
+#define DAY_IN_SEC			(60*60*24)
+#define TEN_DAYS_IN_SEC			(10*DAY_IN_SEC)
+
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
+static int child_ns, parent_ns;
+
+static int switch_ns(int fd)
+{
+	if (setns(fd, CLONE_NEWTIME))
+		return pr_perror("setns()");
+
+	return 0;
+}
+
+static int init_namespaces(void)
+{
+	char path[] = "/proc/self/ns/time_for_children";
+	struct stat st1, st2;
+
+	parent_ns = open(path, O_RDONLY);
+	if (parent_ns <= 0)
+		return pr_perror("Unable to open %s", path);
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
+		return pr_err("The same child_ns after CLONE_NEWTIME");
+
+	if (_settime(CLOCK_BOOTTIME, TEN_DAYS_IN_SEC))
+		return -1;
+
+	return 0;
+}
+
+static int read_proc_uptime(struct timespec *uptime)
+{
+	unsigned long up_sec, up_nsec;
+	FILE *proc;
+
+	proc = fopen("/proc/uptime", "r");
+	if (proc == NULL) {
+		pr_perror("Unable to open /proc/uptime");
+		return -1;
+	}
+
+	if (fscanf(proc, "%lu.%02lu", &up_sec, &up_nsec) != 2) {
+		if (errno) {
+			pr_perror("fscanf");
+			return -errno;
+		}
+		pr_err("failed to parse /proc/uptime");
+		return -1;
+	}
+	fclose(proc);
+
+	uptime->tv_sec = up_sec;
+	uptime->tv_nsec = up_nsec;
+	return 0;
+}
+
+static int check_uptime(void)
+{
+	struct timespec uptime_new, uptime_old;
+	time_t uptime_expected;
+	double prec = MAX_TEST_TIME_SEC;
+
+	if (switch_ns(parent_ns))
+		return pr_err("switch_ns(%d)", parent_ns);
+
+	if (read_proc_uptime(&uptime_old))
+		return 1;
+
+	if (switch_ns(child_ns))
+		return pr_err("switch_ns(%d)", child_ns);
+
+	if (read_proc_uptime(&uptime_new))
+		return 1;
+
+	uptime_expected = uptime_old.tv_sec + TEN_DAYS_IN_SEC;
+	if (fabs(difftime(uptime_new.tv_sec, uptime_expected)) > prec) {
+		pr_fail("uptime in /proc/uptime: old %ld, new %ld [%ld]",
+			uptime_old.tv_sec, uptime_new.tv_sec,
+			uptime_old.tv_sec + TEN_DAYS_IN_SEC);
+		return 1;
+	}
+
+	ksft_test_result_pass("Passed for /proc/uptime\n");
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret = 0;
+
+	nscheck();
+
+	if (init_namespaces())
+		return 1;
+
+	ret |= check_uptime();
+
+	if (ret)
+		ksft_exit_fail();
+	ksft_exit_pass();
+	return ret;
+}
-- 
2.21.0

