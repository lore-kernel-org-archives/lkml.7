Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33F0C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2E020835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395518AbfIWNF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 09:05:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395472AbfIWNFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 09:05:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F78C307D983;
        Mon, 23 Sep 2019 13:05:54 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF5F35D9D5;
        Mon, 23 Sep 2019 13:05:51 +0000 (UTC)
Date:   Mon, 23 Sep 2019 15:05:31 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] uapi, posix-timers: provide clockid-related macros and
 functions to UAPI
Message-ID: <20190923130531.GA27774@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 23 Sep 2019 13:05:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of now, there is no interface exposed for converting pid/fd into
clockid and vice versa; linuxptp, for example, has been carrying these
definitions in missing.h header for quite some time[1].

[1] https://sourceforge.net/p/linuxptp/code/ci/af380e86/tree/missing.h

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
Changes since v1[1]:
 * Actually tried to build with the patch and fixed the build error
   reported by kbuild test robot[2].

[1] https://lkml.org/lkml/2019/9/20/698
[2] https://lkml.org/lkml/2019/9/22/13
---
 include/linux/posix-timers.h | 47 +------------------------------------------
 include/uapi/linux/time.h    | 48 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 46 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 3d10c84..ddc7e6e6 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -4,58 +4,13 @@
 
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/time.h>
 #include <linux/alarmtimer.h>
 #include <linux/timerqueue.h>
 
 struct kernel_siginfo;
 struct task_struct;
 
-/*
- * Bit fields within a clockid:
- *
- * The most significant 29 bits hold either a pid or a file descriptor.
- *
- * Bit 2 indicates whether a cpu clock refers to a thread or a process.
- *
- * Bits 1 and 0 give the type: PROF=0, VIRT=1, SCHED=2, or FD=3.
- *
- * A clockid is invalid if bits 2, 1, and 0 are all set.
- */
-#define CPUCLOCK_PID(clock)		((pid_t) ~((clock) >> 3))
-#define CPUCLOCK_PERTHREAD(clock) \
-	(((clock) & (clockid_t) CPUCLOCK_PERTHREAD_MASK) != 0)
-
-#define CPUCLOCK_PERTHREAD_MASK	4
-#define CPUCLOCK_WHICH(clock)	((clock) & (clockid_t) CPUCLOCK_CLOCK_MASK)
-#define CPUCLOCK_CLOCK_MASK	3
-#define CPUCLOCK_PROF		0
-#define CPUCLOCK_VIRT		1
-#define CPUCLOCK_SCHED		2
-#define CPUCLOCK_MAX		3
-#define CLOCKFD			CPUCLOCK_MAX
-#define CLOCKFD_MASK		(CPUCLOCK_PERTHREAD_MASK|CPUCLOCK_CLOCK_MASK)
-
-static inline clockid_t make_process_cpuclock(const unsigned int pid,
-		const clockid_t clock)
-{
-	return ((~pid) << 3) | clock;
-}
-static inline clockid_t make_thread_cpuclock(const unsigned int tid,
-		const clockid_t clock)
-{
-	return make_process_cpuclock(tid, clock | CPUCLOCK_PERTHREAD_MASK);
-}
-
-static inline clockid_t fd_to_clockid(const int fd)
-{
-	return make_process_cpuclock((unsigned int) fd, CLOCKFD);
-}
-
-static inline int clockid_to_fd(const clockid_t clk)
-{
-	return ~(clk >> 3);
-}
-
 #ifdef CONFIG_POSIX_TIMERS
 
 /**
diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index 958932e..58a78a7 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -70,4 +70,52 @@ struct itimerval {
  */
 #define TIMER_ABSTIME			0x01
 
+/*
+ * Bit fields within a clockid:
+ *
+ * The most significant 29 bits hold either a pid or a file descriptor.
+ *
+ * Bit 2 indicates whether a cpu clock refers to a thread or a process.
+ *
+ * Bits 1 and 0 give the type: PROF=0, VIRT=1, SCHED=2, or FD=3.
+ *
+ * A clockid is invalid if bits 2, 1, and 0 are all set.
+ */
+#define CPUCLOCK_PID(clock)		((pid_t) ~((clock) >> 3))
+#define CPUCLOCK_PERTHREAD(clock) \
+	(((clock) & (__kernel_clockid_t) CPUCLOCK_PERTHREAD_MASK) != 0)
+
+#define CPUCLOCK_PERTHREAD_MASK	4
+#define CPUCLOCK_WHICH(clock)	\
+	((clock) & (__kernel_clockid_t) CPUCLOCK_CLOCK_MASK)
+#define CPUCLOCK_CLOCK_MASK	3
+#define CPUCLOCK_PROF		0
+#define CPUCLOCK_VIRT		1
+#define CPUCLOCK_SCHED		2
+#define CPUCLOCK_MAX		3
+#define CLOCKFD			CPUCLOCK_MAX
+#define CLOCKFD_MASK		(CPUCLOCK_PERTHREAD_MASK|CPUCLOCK_CLOCK_MASK)
+
+static inline __kernel_clockid_t make_process_cpuclock(const unsigned int pid,
+		const clockid_t clock)
+{
+	return ((~pid) << 3) | clock;
+}
+static inline __kernel_clockid_t make_thread_cpuclock(const unsigned int tid,
+		const clockid_t clock)
+{
+	return make_process_cpuclock(tid, clock | CPUCLOCK_PERTHREAD_MASK);
+}
+
+static inline __kernel_clockid_t fd_to_clockid(const int fd)
+{
+	return make_process_cpuclock((unsigned int) fd, CLOCKFD);
+}
+
+static inline int clockid_to_fd(const __kernel_clockid_t clk)
+{
+	return ~(clk >> 3);
+}
+
+
 #endif /* _UAPI_LINUX_TIME_H */
-- 
2.1.4

