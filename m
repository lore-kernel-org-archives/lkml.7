Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1705BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0F72189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfH1KR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:17:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46429 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfH1KQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:37 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v0D-0000KK-MF; Wed, 28 Aug 2019 12:16:33 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 221371C0DE7;
        Wed, 28 Aug 2019 12:16:31 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:31 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Remove cputime_expires
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192921.790209622@linutronix.de>
References: <20190821192921.790209622@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698739106.5768.5546365133289895537.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     46b883995c88520f2c4de6a64cccc04c69d59f83
Gitweb:        https://git.kernel.org/tip/46b883995c88520f2c4de6a64cccc04c69d59f83
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:09:14 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:38 +02:00

posix-cpu-timers: Remove cputime_expires

The last users of the magic struct cputime based expiry cache are
gone. Remove the leftovers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192921.790209622@linutronix.de

---
 include/linux/posix-timers.h   |  9 ++-------
 kernel/time/posix-cpu-timers.c | 10 ----------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index e36c6fd..fd90984 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -65,19 +65,14 @@ static inline int clockid_to_fd(const clockid_t clk)
 #ifdef CONFIG_POSIX_TIMERS
 /**
  * posix_cputimers - Container for posix CPU timer related data
- * @cputime_expires:	Earliest-expiration cache task_cputime based
  * @expiries:		Earliest-expiration cache array based
  * @cpu_timers:		List heads to queue posix CPU timers
  *
  * Used in task_struct and signal_struct
  */
 struct posix_cputimers {
-	/* Temporary union until all users are cleaned up */
-	union {
-		struct task_cputime	cputime_expires;
-		u64			expiries[CPUCLOCK_MAX];
-	};
-	struct list_head		cpu_timers[CPUCLOCK_MAX];
+	u64			expiries[CPUCLOCK_MAX];
+	struct list_head	cpu_timers[CPUCLOCK_MAX];
 };
 
 static inline void posix_cputimers_init(struct posix_cputimers *pct)
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index e159b03..ffd4918 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -18,16 +18,6 @@
 
 #include "posix-timers.h"
 
-static inline void temporary_check(void)
-{
-	BUILD_BUG_ON(offsetof(struct task_cputime, stime) !=
-		     CPUCLOCK_PROF * sizeof(u64));
-	BUILD_BUG_ON(offsetof(struct task_cputime, utime) !=
-		     CPUCLOCK_VIRT * sizeof(u64));
-	BUILD_BUG_ON(offsetof(struct task_cputime, sum_exec_runtime) !=
-		     CPUCLOCK_SCHED * sizeof(u64));
-}
-
 static void posix_cpu_timer_rearm(struct k_itimer *timer);
 
 void posix_cputimers_group_init(struct posix_cputimers *pct, u64 cpu_limit)
