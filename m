Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F003ECE58F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91BD21835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571194656;
	bh=Zy5Co8o7yQYFv62wT6ae0jPjo3yyBuST9CkCTe6aN7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=edo4iedNTRPgPkTSAilm4gySBQDGwR6NoCYOJxxLePJ+zsbWFh982i1PKXCqOBChZ
	 dS+JW+Xq7CzCcXZV3WM1KcDZeXpnRMup1Ruv09XlfDrMUllmbtd2RXKBb/6FF32qGk
	 NRsKmfmq5ofOUVRsIv+dyPdDr0ZzF+AdYFj6m7l8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390755AbfJPC5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 22:57:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728406AbfJPC5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:57:31 -0400
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3E2420873;
        Wed, 16 Oct 2019 02:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571194650;
        bh=Zy5Co8o7yQYFv62wT6ae0jPjo3yyBuST9CkCTe6aN7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XqPAhWdRnMW1VfW5VCko5j5SZaTsRYqKRYEV/8yjXEoZDFmH1LEQmQPd569jlL5ku
         9NoufOsmONrsSqQSIIV30TlB1vX1cZaV3GYneSK6uTE4xxiwiW7w1jcHr6yAFbxeUY
         3ySZLOVQA3x+5oT5rAp00Wvt7UTYuOFaPTjY+CuE=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 08/14] sched/vtime: Rename vtime_accounting_cpu_enabled() to vtime_accounting_enabled_this_cpu()
Date:   Wed, 16 Oct 2019 04:56:54 +0200
Message-Id: <20191016025700.31277-9-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016025700.31277-1-frederic@kernel.org>
References: <20191016025700.31277-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Standardize the naming on top of the vtime_accounting_enabled_*() base.
Also make it clear we are checking the vtime state of the
*current* CPU with this function. We'll need to add an API to check that
state on remote CPUs as well, so we must disambiguate the naming.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/context_tracking.h |  4 ++--
 include/linux/vtime.h            | 10 +++++-----
 kernel/sched/cputime.c           |  2 +-
 kernel/time/tick-sched.c         |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index c9065ad518a7..64ec82851aa3 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -103,7 +103,7 @@ static inline void context_tracking_init(void) { }
 /* must be called with irqs disabled */
 static inline void guest_enter_irqoff(void)
 {
-	if (vtime_accounting_cpu_enabled())
+	if (vtime_accounting_enabled_this_cpu())
 		vtime_guest_enter(current);
 	else
 		current->flags |= PF_VCPU;
@@ -127,7 +127,7 @@ static inline void guest_exit_irqoff(void)
 	if (context_tracking_enabled())
 		__context_tracking_exit(CONTEXT_GUEST);
 
-	if (vtime_accounting_cpu_enabled())
+	if (vtime_accounting_enabled_this_cpu())
 		vtime_guest_exit(current);
 	else
 		current->flags &= ~PF_VCPU;
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 54e91511250b..eb2e7a19054b 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -11,11 +11,11 @@
 struct task_struct;
 
 /*
- * vtime_accounting_cpu_enabled() definitions/declarations
+ * vtime_accounting_enabled_this_cpu() definitions/declarations
  */
 #if defined(CONFIG_VIRT_CPU_ACCOUNTING_NATIVE)
 
-static inline bool vtime_accounting_cpu_enabled(void) { return true; }
+static inline bool vtime_accounting_enabled_this_cpu(void) { return true; }
 extern void vtime_task_switch(struct task_struct *prev);
 
 #elif defined(CONFIG_VIRT_CPU_ACCOUNTING_GEN)
@@ -31,7 +31,7 @@ static inline bool vtime_accounting_enabled(void)
 	return context_tracking_enabled();
 }
 
-static inline bool vtime_accounting_cpu_enabled(void)
+static inline bool vtime_accounting_enabled_this_cpu(void)
 {
 	if (vtime_accounting_enabled()) {
 		if (context_tracking_enabled_this_cpu())
@@ -45,13 +45,13 @@ extern void vtime_task_switch_generic(struct task_struct *prev);
 
 static inline void vtime_task_switch(struct task_struct *prev)
 {
-	if (vtime_accounting_cpu_enabled())
+	if (vtime_accounting_enabled_this_cpu())
 		vtime_task_switch_generic(prev);
 }
 
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING */
 
-static inline bool vtime_accounting_cpu_enabled(void) { return false; }
+static inline bool vtime_accounting_enabled_this_cpu(void) { return false; }
 static inline void vtime_task_switch(struct task_struct *prev) { }
 
 #endif
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 34086afc3518..b931a19df093 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -475,7 +475,7 @@ void account_process_tick(struct task_struct *p, int user_tick)
 	u64 cputime, steal;
 	struct rq *rq = this_rq();
 
-	if (vtime_accounting_cpu_enabled())
+	if (vtime_accounting_enabled_this_cpu())
 		return;
 
 	if (sched_clock_irqtime) {
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 955851748dc3..c2748232f607 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1119,7 +1119,7 @@ static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 	unsigned long ticks;
 
-	if (vtime_accounting_cpu_enabled())
+	if (vtime_accounting_enabled_this_cpu())
 		return;
 	/*
 	 * We stopped the tick in idle. Update process times would miss the
-- 
2.23.0

