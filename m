Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E045AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA69D216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="jpVOpaPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389294AbfG2V6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:58:51 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:55001 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730564AbfG2V6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:58:48 -0400
Received: by mail-wm1-f45.google.com with SMTP id p74so55159152wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nEPH/HBT5LEaDOPJsRodxQcT9N0GAR3W8MewC/Ub1VE=;
        b=jpVOpaPtdgsnKI72mbzOn7SYZmmb5uPaZ1EF7m3lK56Kv+cK1c0BD3xWeGAJ31C9m5
         hK637zwb1Q7rADqiZWWbG0nJZj8+CM6Mfn6iLHcj9BcG/ioKJnOS/HxvO3qxhYk79EeP
         dMB3YhASm9ZBDyFrh74guk31+WK4RDWPy9Y6YCHlVXwuj+UWh5HlKRDGJEL9XXU7CB0C
         0ChiioNtmk3c1JDfBPnk6+tqZKtVvUqF2i0dqnnyKlIJA4iUQm49Ec7fx61HsiM1z3ix
         7tUgw+OOj/7IIRS9DrB0BUTkDmAxD/it2vzCXlnja2JmHbZ0VW45b6p8exdCkuzIN48v
         179g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nEPH/HBT5LEaDOPJsRodxQcT9N0GAR3W8MewC/Ub1VE=;
        b=LmjpuLmIwm5WjNjsPCqXas/zR5MVWKAnzluvVbbQDNmezTQFW2uHc47EbTGSXLUU5+
         +kQ1tNjtLkISCx6IQ4xaXWRvpgN+8ygf0hGMEx8t6BQ7ZXcdT/HJOgUUG36hXeJXX5H0
         pR81MMEiUpbjK9rMYUSamNatm9RehCOiLV5Gg9gwuWwemBNwRMLOAfpcXaavYYpKsos7
         HC2l4K0A9Q7EBThZ4I0pH9Rhtrg9hIG7AwahHYg6xjHonzHukvB6d59ICuHY1tGb4Vsp
         rgc+dSJh3HsKM5AkUxGdMenalU0Yi1wPEHYTqNpDibdFLoczIGxEaG0C+pSAdC9FG2yQ
         Dykg==
X-Gm-Message-State: APjAAAWeR2vmdATOxsjLnHLuFeLWNSopYy4/redE4SY5nad8mRuIvqNU
        UwK/5d0WzIEMcyS6I9jtTVRpIn3YOtgyI89cuyePtkYRWaTMkpc/G06qM25KgoKyjMhgV3Pa7bq
        353ujmHwUqyphXBL8OLokkDF3UbiW3pFpUiEqNtl+40sDvyxLfE4NhMt2obNgspVIF4vN0MF4C+
        I47X7f8PqrAiS//Fl/qTqUw6KGhCLThN9g7SoK2Vg=
X-Google-Smtp-Source: APXvYqxU583Nqe+NvhEB5zwfT0gvyQq5c2Hk7m9J9+wgGwnRvWQiGzkNbmcqkGafB07ERPd96vOA2w==
X-Received: by 2002:a1c:4041:: with SMTP id n62mr41296064wma.100.1564437525799;
        Mon, 29 Jul 2019 14:58:45 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:45 -0700 (PDT)
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
Subject: [PATCHv5 33/37] selftest/timens: Add a test for clock_nanosleep()
Date:   Mon, 29 Jul 2019 22:57:15 +0100
Message-Id: <20190729215758.28405-34-dima@arista.com>
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

Check that clock_nanosleep() takes into account clock offsets.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/timens/.gitignore     |   1 +
 tools/testing/selftests/timens/Makefile       |   2 +-
 .../selftests/timens/clock_nanosleep.c        | 102 ++++++++++++++++++
 3 files changed, 104 insertions(+), 1 deletion(-)
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
index 000000000000..7956e65d3032
--- /dev/null
+++ b/tools/testing/selftests/timens/clock_nanosleep.c
@@ -0,0 +1,102 @@
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
+	ksft_set_plan(4);
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
2.22.0

