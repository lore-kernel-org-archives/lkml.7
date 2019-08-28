Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D381C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9E8233A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfH1KQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:16:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46358 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfH1KQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:16:24 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2v00-0000Al-B8; Wed, 28 Aug 2019 12:16:20 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F1EF81C07D2;
        Wed, 28 Aug 2019 12:16:19 +0200 (CEST)
Date:   Wed, 28 Aug 2019 10:16:19 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Use common permission check in
 posix_cpu_timer_create()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190821192919.505833418@linutronix.de>
References: <20190821192919.505833418@linutronix.de>
MIME-Version: 1.0
Message-ID: <156698737988.5692.15003724980491955957.tip-bot2@tip-bot2>
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

Commit-ID:     e5a8b65b4cb2fe024b83bdec0424269949cc0a27
Gitweb:        https://git.kernel.org/tip/e5a8b65b4cb2fe024b83bdec0424269949cc0a27
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 21 Aug 2019 21:08:50 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 11:50:25 +02:00

posix-cpu-timers: Use common permission check in posix_cpu_timer_create()

Yet another copy of the same thing gone...

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190821192919.505833418@linutronix.de

---
 kernel/time/posix-cpu-timers.c | 35 ++-------------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index eb11117..4426a0f 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -316,44 +316,15 @@ static int posix_cpu_clock_get(const clockid_t clock, struct timespec64 *tp)
  */
 static int posix_cpu_timer_create(struct k_itimer *new_timer)
 {
-	int ret = 0;
-	const pid_t pid = CPUCLOCK_PID(new_timer->it_clock);
-	struct task_struct *p;
+	struct task_struct *p = get_task_for_clock(new_timer->it_clock);
 
-	if (CPUCLOCK_WHICH(new_timer->it_clock) >= CPUCLOCK_MAX)
+	if (!p)
 		return -EINVAL;
 
 	new_timer->kclock = &clock_posix_cpu;
-
 	INIT_LIST_HEAD(&new_timer->it.cpu.entry);
-
-	rcu_read_lock();
-	if (CPUCLOCK_PERTHREAD(new_timer->it_clock)) {
-		if (pid == 0) {
-			p = current;
-		} else {
-			p = find_task_by_vpid(pid);
-			if (p && !same_thread_group(p, current))
-				p = NULL;
-		}
-	} else {
-		if (pid == 0) {
-			p = current->group_leader;
-		} else {
-			p = find_task_by_vpid(pid);
-			if (p && !has_group_leader_pid(p))
-				p = NULL;
-		}
-	}
 	new_timer->it.cpu.task = p;
-	if (p) {
-		get_task_struct(p);
-	} else {
-		ret = -EINVAL;
-	}
-	rcu_read_unlock();
-
-	return ret;
+	return 0;
 }
 
 /*
