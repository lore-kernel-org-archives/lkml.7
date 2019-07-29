Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC520C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7795921773
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="GniQmcIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbfG2V7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:59:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45475 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389348AbfG2V6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:58:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so63440314wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QlOwhEOC4bO6ztUPcHZX2D8R8lwFv2ELZ3dmT/1+sz8=;
        b=GniQmcImU6aGr9ZnMTvc9NlCGDJeFI2pQ+o2evRgG/m2iBzuZ0MPiZj1X2FQl15aD4
         ohxwLYPDwNeB+L8iIdnC/LcYZWLt4yYuiU4VNPiLfIqKPi7OCC/KXNH8d8f1XqyYEYu4
         EcmrXYY68JkbQVTQw9TotsJ7hlSkkocNbOaBo6eGOeWq4Oq0/K1axFyX10F/F4Wuibgi
         jxYo0pzlvkIsPuNUgAtei9L9KLJnRhs9xqJPUQJhQ98R2lQxKZSeizKaCXIaTws3No4Z
         NT30lI4KcLcTvoyb3OcZFjlECu9McQ/cuBDjgSyM6N5kKsZP9EEZL5JWxOCX1JYNIDvh
         xwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QlOwhEOC4bO6ztUPcHZX2D8R8lwFv2ELZ3dmT/1+sz8=;
        b=RtpGtVA9t2Re/H72CMWEdeX9Zkt6Me/93fDyT0CQrA/jlAtOEwS2EvQoxDFJkdb/uk
         /Ohgled4dYO8Q3SLmEORmy4z4IAyXaiXjCaT49CCtqmyIVp61saCLiDvsZu+ZXS1ezi2
         lg6eHZ7YCIsu5Y+2SS0w0GtU054A94U9IQTkEIiUmO1MhSApP/IcnfqEimDS8ZBeuHy5
         OpgFALqQFc4Xv4/+gcE6USBg4xe2ZQZjuvFNKR+etLc4/Mu0neIP6A75xnWowhYKNaWY
         GlTsKmtKUuwbdAXtNKvrX2LEMpkwBzRgg4ljzIpdirC41SM+5WO5SsuWGJJj3I4KCBHP
         5VrQ==
X-Gm-Message-State: APjAAAXTCVbalR5M00mK01ZYtqcTss3J40aym0TkNrdOhAs/08Dh8NjX
        BP8o0y82MEPt3QfKLKEquGS5dhNPRAcqHux3oU1FdoqqepJCL12QGc9dixWVFmC8b3BsHGeo0Nb
        T2I705JlSHSOl3+mIn29ymcLwGbN7eFDIgzVcSg63EFL6RdUAFt3qZnA6AptO7By3WvOdeabPTk
        4Z6D/DVUehkffePKrSyyBgkGpwo1i4rTQu+C2SmkE=
X-Google-Smtp-Source: APXvYqxGNkbtCVrpqfsxiuUfy9QMpEWxVyLJoQ/I77nmoMlZMKO9zi5ZrnBMbycP+tEAPONQakZldQ==
X-Received: by 2002:adf:cf0d:: with SMTP id o13mr77419816wrj.291.1564437531653;
        Mon, 29 Jul 2019 14:58:51 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:51 -0700 (PDT)
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
Subject: [PATCHv5 37/37] selftest/timens: Check that a right vdso is mapped after fork and exec
Date:   Mon, 29 Jul 2019 22:57:19 +0100
Message-Id: <20190729215758.28405-38-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729215758.28405-1-dima@arista.com>
References: <20190729215758.28405-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore |  1 +
 tools/testing/selftests/timens/Makefile   |  2 +-
 tools/testing/selftests/timens/exec.c     | 93 +++++++++++++++++++++++
 3 files changed, 95 insertions(+), 1 deletion(-)
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
index 97e0460eaf48..b77fe22fa24d 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,4 +1,4 @@
-TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs gettime_perf
+TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs gettime_perf exec
 
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/i386/)
diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
new file mode 100644
index 000000000000..de7798832429
--- /dev/null
+++ b/tools/testing/selftests/timens/exec.c
@@ -0,0 +1,93 @@
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
+	}
+
+	nscheck();
+
+	ksft_set_plan(1);
+
+	clock_gettime(CLOCK_MONOTONIC, &now);
+
+	if (unshare(CLONE_NEWTIME))
+		return pr_perror("Can't unshare() timens");
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
+		/* Check that a proper vdso will be mapped after execve. */
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
2.22.0

