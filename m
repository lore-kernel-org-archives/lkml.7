Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B86C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC6D2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="GymuE7Eo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfFLT1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:27:25 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:42883 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbfFLT1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:27:08 -0400
Received: by mail-wr1-f46.google.com with SMTP id x17so2852225wrl.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 12:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7rs0KnEcx59klLTCf2/DfuexlDXTmQ6L/KY+ZkNgoYU=;
        b=GymuE7EoGLqFlGb4+s7ihWt1BliTJjy1DMzb1n/lWp4yLTjsRiqrvhB09Q3Hb8Q23S
         3Emo+AScRPWUUD03IzjkhemPYrw39K5DSf5qqWmwmSpYfcuvwpI7BKkiMl0QVYKNgV8B
         /meRYBC0HBEEqCAwV1y3rowaX9d1a8/Hsn3FGmAFi5ay5l75wsT5xlpvR3+Gg2f/ziJ0
         DFaGkb0KNDGn5nhGhGXH+mCXn6xbUIxdLIqy8B2FQT+7qrX1i7VLSAMsNwyd/AsOaAGG
         1zLXpqYv710x/k5yNqmEt7taoUDo8iyOV9iS2ua3AQIGoSna/DcaeadGRVPXoDAAxkSn
         RklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7rs0KnEcx59klLTCf2/DfuexlDXTmQ6L/KY+ZkNgoYU=;
        b=JDqtY8ry4lPg+sf+vaLWWL1Sx+8NLdNf5ChUKDLBhsiPKamBmuYfj19dQcmd1abrZs
         qYgyQYOevVq24Ag0Qr6/joyZHRenhKYVy6I83FarK8tpnmyTcZq14UENO8AH+KbkJR7E
         0bbXiET3Biib8CsEd3gUEUH68DM0UQDlBttIfvZ17Ra/oh7+iXr5VpX+q7zyYIVuZwK4
         dXmyfdFzgJgrjntqULOUfoekqcFMircPq2W4KoaT2otwOBW1+6WC/VEt/wZLoEs27qD9
         EO/ZMyHjE1YAiQGjnBbpA0XFv7TrVxkfTId5c43vouOqaF92D6lyChPldnuRUZ+VJR72
         5r7A==
X-Gm-Message-State: APjAAAXkkSm5oWfL27QsfkEaGmPw14F3FtRtmp732uny4wJ4sAK2foEt
        cknix9UMRanfj6mtIfToBivv+hTtBDQ=
X-Google-Smtp-Source: APXvYqwHCjVUig0jhc6KiWJnvv5POK2g5ZL8BPe3jXQqd7tCK4pRGp+WdOiNjrZKXGLLRKCU27xCJw==
X-Received: by 2002:adf:c506:: with SMTP id q6mr41598753wrf.219.1560367626298;
        Wed, 12 Jun 2019 12:27:06 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.27.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:27:05 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@openvz.org>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCHv4 25/28] selftest/timens: Add timer offsets test
Date:   Wed, 12 Jun 2019 20:26:24 +0100
Message-Id: <20190612192628.23797-26-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@openvz.org>

Check that timer_create() takes into account clock offsets.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore |   1 +
 tools/testing/selftests/timens/Makefile   |   3 +-
 tools/testing/selftests/timens/timer.c    | 116 ++++++++++++++++++++++
 3 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/timer.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index 94ffdd9cead7..3b7eda8f35ce 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1,4 +1,5 @@
 clock_nanosleep
 procfs
 timens
+timer
 timerfd
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index f96f50d1fef8..ae1ffd24cc43 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,5 +1,6 @@
-TEST_GEN_PROGS := timens timerfd clock_nanosleep procfs
+TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs
 
 CFLAGS := -Wall -Werror
+LDFLAGS := -lrt
 
 include ../lib.mk
diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
new file mode 100644
index 000000000000..6e33cd54d397
--- /dev/null
+++ b/tools/testing/selftests/timens/timer.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <signal.h>
+#include <time.h>
+
+#include "log.h"
+#include "timens.h"
+
+int run_test(int clockid, struct timespec now)
+{
+	struct itimerspec new_value;
+	long long elapsed;
+	timer_t fd;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		struct sigevent sevp = {.sigev_notify = SIGEV_NONE};
+		int flags = 0;
+
+		new_value.it_value.tv_sec = 3600;
+		new_value.it_value.tv_nsec = 0;
+		new_value.it_interval.tv_sec = 1;
+		new_value.it_interval.tv_nsec = 0;
+
+		if (i == 1) {
+			new_value.it_value.tv_sec += now.tv_sec;
+			new_value.it_value.tv_nsec += now.tv_nsec;
+		}
+
+		if (timer_create(clockid, &sevp, &fd) == -1)
+			return pr_perror("timerfd_create");
+
+		if (i == 1)
+			flags |= TIMER_ABSTIME;
+		if (timer_settime(fd, flags, &new_value, NULL) == -1)
+			return pr_perror("timerfd_settime");
+
+		if (timer_gettime(fd, &new_value) == -1)
+			return pr_perror("timerfd_gettime");
+
+		elapsed = new_value.it_value.tv_sec;
+		if (abs(elapsed - 3600) > 60) {
+			ksft_test_result_fail("clockid: %d elapsed: %lld\n",
+					      clockid, elapsed);
+			return 1;
+		}
+	}
+
+	ksft_test_result_pass("clockid=%d\n", clockid);
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret, status, len, fd;
+	char buf[4096];
+	pid_t pid;
+	struct timespec btime_now, mtime_now;
+
+	nscheck();
+
+	clock_gettime(CLOCK_MONOTONIC, &mtime_now);
+	clock_gettime(CLOCK_BOOTTIME, &btime_now);
+
+	if (unshare(CLONE_NEWTIME))
+		return pr_perror("unshare");
+
+	len = snprintf(buf, sizeof(buf), "%d %d 0\n%d %d 0",
+			CLOCK_MONOTONIC, 70 * 24 * 3600,
+			CLOCK_BOOTTIME, 9 * 24 * 3600);
+	fd = open("/proc/self/timens_offsets", O_WRONLY);
+	if (fd < 0)
+		return pr_perror("/proc/self/timens_offsets");
+
+	if (write(fd, buf, len) != len)
+		return pr_perror("/proc/self/timens_offsets");
+
+	close(fd);
+	mtime_now.tv_sec += 70 * 24 * 3600;
+	btime_now.tv_sec += 9 * 24 * 3600;
+
+	pid = fork();
+	if (pid < 0)
+		return pr_perror("Unable to fork");
+	if (pid == 0) {
+		ret = 0;
+		ret |= run_test(CLOCK_BOOTTIME, btime_now);
+		ret |= run_test(CLOCK_MONOTONIC, mtime_now);
+		ret |= run_test(CLOCK_BOOTTIME_ALARM, btime_now);
+
+		if (ret)
+			ksft_exit_fail();
+		ksft_exit_pass();
+		return ret;
+	}
+
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("Unable to wait the child process");
+
+	if (WIFEXITED(status))
+		return WEXITSTATUS(status);
+
+	return 1;
+}
+
-- 
2.22.0

