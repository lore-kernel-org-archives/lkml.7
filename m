Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68685C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306D922469
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LBOFbhge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfKLB2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:28:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53685 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbfKLB2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:28:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id u18so1293943wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 17:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RNfsmIT0+BhiYq9BO8+tYgWoshhceY0zmERPb4Uhclk=;
        b=LBOFbhgewoIh0TdoVsojgaeHhXzTKf1SPZL+qopibTdSI6HKVcAdiFWlvX/kmLv1JB
         cjf8uma3f29O5wGLmB4abBYZ5igw14EASvdtxxp+6pSPrPf7woVje/MIe17/tGR70Dp7
         lgEgQe0klsQhraw570FHm24PAXfAXjKhexx60qC3tH60Sa1/pxsuDhJc4063YX9RSAyn
         fIk3RZ/mRHKYV6tI/Au0rk/xVNJXf+drZzaqxe7v9kp7i7ZClDP8W56WPaFg8WZ5nR3r
         w40AxnDh4iyHxsv1kpNfYLUA1EmWPMDiomHXcc+PxAotBXbU3ju3i3HXsBJ3ProVSZXf
         e1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RNfsmIT0+BhiYq9BO8+tYgWoshhceY0zmERPb4Uhclk=;
        b=JEuxPfbHqYnXQwkMnzSWrs2dEFZ2miFzAKcuRtB/KzhWaTDbDwaI54ioJqJ7N2WKeq
         sQabvuaFo/Jses6V5bpFKBbn11JyzBflU5jTiJ+bPNfJB5buNe07X6sJA0No0mI62ozB
         mCrjlhtc/JOzZ4vgyCPcHhrP8wGNNMo9uGeo8cN+5it9PAQ310O89tTgqpIn8sVtObJ9
         nB5ygwKBWHYFJNa8Jlh4F5VLCvUIwSQayvVRCknTPtECrXAYqctZ/qnx2uwqkd53RLun
         RWB1+YidKilJnv06Vex32wXZhIrNvJaHVo4lItjtTqn7BkeMK/PEnPzGxk4iXm7tuNM8
         ma9w==
X-Gm-Message-State: APjAAAUFOJQ7RXQiG56R/PB0cuCQpx9FbxtVO6e2ZTQrX2UnKJiH6fM0
        ELqdSgAuWZ/NpcKYXeqnZOyGmtkaGQ4=
X-Google-Smtp-Source: APXvYqxqGzt4Pd0eW5OeuHgOiBRdyAyLa35OK6CFzshJ4eVcR5OO+nlEqGz0SRz2kt/0PHvm5O/djw==
X-Received: by 2002:a1c:1b06:: with SMTP id b6mr1472813wmb.3.1573522097632;
        Mon, 11 Nov 2019 17:28:17 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:28:17 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv8 34/34] selftests/timens: Check for right timens offsets after fork and exec
Date:   Tue, 12 Nov 2019 01:27:23 +0000
Message-Id: <20191112012724.250792-35-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112012724.250792-1-dima@arista.com>
References: <20191112012724.250792-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Output on success:
 1..1
 ok 1 exec
 # Pass 1 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0

Output on failure:
 1..1
 not ok 1 36016 16
 Bail out!

Output with lack of permissions:
 1..1
 not ok 1 # SKIP need to run as root

Output without support of time namespaces:
 1..1
 not ok 1 # SKIP Time namespaces are not supported

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore |  1 +
 tools/testing/selftests/timens/Makefile   |  2 +-
 tools/testing/selftests/timens/exec.c     | 94 +++++++++++++++++++++++
 3 files changed, 96 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/exec.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index 16292e4d08a5..789f21e81028 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1,4 +1,5 @@
 clock_nanosleep
+exec
 gettime_perf
 gettime_perf_cold
 procfs
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index 6aefcaccb8f4..e9fb30bd8aeb 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,4 +1,4 @@
-TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs
+TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs exec
 TEST_GEN_PROGS_EXTENDED := gettime_perf
 
 CFLAGS := -Wall -Werror -pthread
diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
new file mode 100644
index 000000000000..87b47b557a7a
--- /dev/null
+++ b/tools/testing/selftests/timens/exec.c
@@ -0,0 +1,94 @@
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
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+#include <time.h>
+#include <string.h>
+
+#include "log.h"
+#include "timens.h"
+
+#define OFFSET (36000)
+
+int main(int argc, char *argv[])
+{
+	struct timespec now, tst;
+	int status, i;
+	pid_t pid;
+
+	if (argc > 1) {
+		if (sscanf(argv[1], "%ld", &now.tv_sec) != 1)
+			return pr_perror("sscanf");
+
+		for (i = 0; i < 2; i++) {
+			_gettime(CLOCK_MONOTONIC, &tst, i);
+			if (abs(tst.tv_sec - now.tv_sec) > 5)
+				return pr_fail("%ld %ld\n", now.tv_sec, tst.tv_sec);
+		}
+		return 0;
+	}
+
+	nscheck();
+
+	ksft_set_plan(1);
+
+	clock_gettime(CLOCK_MONOTONIC, &now);
+
+	if (unshare_timens())
+		return 1;
+
+	if (_settime(CLOCK_MONOTONIC, OFFSET))
+		return 1;
+
+	for (i = 0; i < 2; i++) {
+		_gettime(CLOCK_MONOTONIC, &tst, i);
+		if (abs(tst.tv_sec - now.tv_sec) > 5)
+			return pr_fail("%ld %ld\n",
+					now.tv_sec, tst.tv_sec);
+	}
+
+	if (argc > 1)
+		return 0;
+
+	pid = fork();
+	if (pid < 0)
+		return pr_perror("fork");
+
+	if (pid == 0) {
+		char now_str[64];
+		char *cargv[] = {"exec", now_str, NULL};
+		char *cenv[] = {NULL};
+
+		/* Check that a child process is in the new timens. */
+		for (i = 0; i < 2; i++) {
+			_gettime(CLOCK_MONOTONIC, &tst, i);
+			if (abs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
+				return pr_fail("%ld %ld\n",
+						now.tv_sec + OFFSET, tst.tv_sec);
+		}
+
+		/* Check for proper vvar offsets after execve. */
+		snprintf(now_str, sizeof(now_str), "%ld", now.tv_sec + OFFSET);
+		execve("/proc/self/exe", cargv, cenv);
+		return pr_perror("execve");
+	}
+
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("waitpid");
+
+	if (status)
+		ksft_exit_fail();
+
+	ksft_test_result_pass("exec\n");
+	ksft_exit_pass();
+	return 0;
+}
-- 
2.24.0

