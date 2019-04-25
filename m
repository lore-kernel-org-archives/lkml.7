Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AB7C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43B620891
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="WfxVzMog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfDYQPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:15:01 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35891 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbfDYQO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:14:57 -0400
Received: by mail-ed1-f65.google.com with SMTP id u57so413375edm.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=67EsMmkwtTvQJAZDsLI27phRCwgBxFRDqY7Z56jTYdE=;
        b=WfxVzMogiipKuM5g7fYdEwtp133n8PcrUmyv/hdpsuU+syiUYD9+K9Wcs/TV+bquAc
         RwFSeASYdvA+wuJO6U7PXITb+geqousxIY8PZjH/zPmQE7822uYNxH/ZSh1yygq57wXp
         wOI9fRCsi8RHvEaUuyl4M0BDTS413cZWfA87tgKJBHbcQvNb5xmdcfvHaLKo33/48fHi
         GMOfvvNg3fiPaUmjoyVOLViwRcOnkG935pVjPd762YaQmMxA04k/7hfT8b+6HfLtfhDE
         I/nhepdcnZnH69DS4DHcJDVEunVvsB1/W+S/rkjFavGXsHj4LFYdAZ+ljDwy8AZjiElf
         OWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=67EsMmkwtTvQJAZDsLI27phRCwgBxFRDqY7Z56jTYdE=;
        b=e1tF6IN/H/jjdiY4fy6WI9qgI+BJziN84Vz7FbjCahkxR4uvTx3NuWEUGPLmgj3No3
         Qm12tCifxRvIgfmNj4065nPfwGN5LNZztU/YQ4ZLCBXG3p9bC/lncQgwF0XsVLO6cKW5
         v/eI6opUkWu22dY0+7Civ2KAlsrqYcU0dZ7LQd7EfDc/aRpfHaYpGMspFwPLlyZpk6Jo
         5tIspj49YsjfCznqjnk6xeTe200Tdl4prs5dACH0KoGmV5Zf9rhGELBXl4AQ2mbOLwFi
         AHDDRH13pyI7VkKS8lakljJvFw3dWPhNU5OkEjec8Mu0vXmstxBcY2GctX/YS4cs16O/
         2m7g==
X-Gm-Message-State: APjAAAUG/6e9qlQNJDb1dTZ2eCyKwcc9uuyTB20TTM/Q2hjdEOu7lxi4
        U91LS7xArXfGbymEWsHichvqa3QIm10=
X-Google-Smtp-Source: APXvYqwf0Hl2udWRUhA6cuN3N/GBIfe6yFf6JgAOBPQ+JtPinuhRg6qmPcxErOAt0Y2ijsd625gmoA==
X-Received: by 2002:a50:996d:: with SMTP id l42mr25085592edb.181.1556208895041;
        Thu, 25 Apr 2019 09:14:55 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id br19sm4147042ejb.48.2019.04.25.09.14.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 09:14:54 -0700 (PDT)
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
Subject: [PATCHv3 22/27] selftest/timens: Add a test for clock_nanosleep()
Date:   Thu, 25 Apr 2019 17:14:11 +0100
Message-Id: <20190425161416.26600-23-dima@arista.com>
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

Check that clock_nanosleep() takes into account clock offsets.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore     |   1 +
 tools/testing/selftests/timens/Makefile       |   2 +-
 .../selftests/timens/clock_nanosleep.c        | 100 ++++++++++++++++++
 3 files changed, 102 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/clock_nanosleep.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index b609f6ee9fb9..9b6c8ddac2c8 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1,2 +1,3 @@
+clock_nanosleep
 timens
 timerfd
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index 66b90cd28e5c..76a1dc891184 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,4 +1,4 @@
-TEST_GEN_PROGS := timens timerfd
+TEST_GEN_PROGS := timens timerfd clock_nanosleep
 
 CFLAGS := -Wall -Werror
 
diff --git a/tools/testing/selftests/timens/clock_nanosleep.c b/tools/testing/selftests/timens/clock_nanosleep.c
new file mode 100644
index 000000000000..dfd4e3429c75
--- /dev/null
+++ b/tools/testing/selftests/timens/clock_nanosleep.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+
+#include <sys/timerfd.h>
+#include <sys/syscall.h>
+#include <time.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+
+#include "log.h"
+#include "timens.h"
+
+static long long get_elapsed_time(int clockid, struct timespec *start)
+{
+	struct timespec curr;
+	long long secs, nsecs;
+
+	if (clock_gettime(clockid, &curr) == -1)
+		return pr_perror("clock_gettime");
+
+	secs = curr.tv_sec - start->tv_sec;
+	nsecs = curr.tv_nsec - start->tv_nsec;
+	if (nsecs < 0) {
+		secs--;
+		nsecs += 1000000000;
+	}
+	if (nsecs > 1000000000) {
+		secs++;
+		nsecs -= 1000000000;
+	}
+	return secs * 1000 + nsecs / 1000000;
+}
+
+int run_test(int clockid)
+{
+	long long elapsed;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		struct timespec now = {};
+		struct timespec start;
+
+		if (clock_gettime(clockid, &start) == -1)
+			return pr_perror("clock_gettime");
+
+
+		if (i == 1) {
+			now.tv_sec = start.tv_sec;
+			now.tv_nsec = start.tv_nsec;
+		}
+
+		now.tv_sec += 2;
+		clock_nanosleep(clockid, i ? TIMER_ABSTIME : 0, &now, NULL);
+
+		elapsed = get_elapsed_time(clockid, &start);
+		if (elapsed < 1900 || elapsed > 2100) {
+			pr_fail("clockid: %d abs: %d elapsed: %lld\n",
+				clockid, i, elapsed);
+			return 1;
+		}
+		ksft_test_result_pass("clockid: %d abs:%d\n", clockid, i);
+	}
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret, nsfd;
+
+	nscheck();
+
+	if (unshare(CLONE_NEWTIME))
+		return pr_perror("unshare");
+
+	if (_settime(CLOCK_MONOTONIC, 7 * 24 * 3600))
+		return 1;
+	if (_settime(CLOCK_BOOTTIME, 9 * 24 * 3600))
+		return 1;
+
+	nsfd = open("/proc/self/ns/time_for_children", O_RDONLY);
+	if (nsfd < 0)
+		return pr_perror("Unable to open timens_for_children");
+
+	if (setns(nsfd, CLONE_NEWTIME))
+		return pr_perror("Unable to set timens");
+
+	ret = 0;
+	ret |= run_test(CLOCK_MONOTONIC);
+	ret |= run_test(CLOCK_BOOTTIME_ALARM);
+
+	if (ret)
+		ksft_exit_fail();
+	ksft_exit_pass();
+	return ret;
+}
+
-- 
2.21.0

