Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D23CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A8521655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439362AbfJXLtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:49:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:50026 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726326AbfJXLtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:49:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 376D2ABC7;
        Thu, 24 Oct 2019 11:49:46 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 1/3] watchdog/softlockup: Remove obsolete check of last reported task
Date:   Thu, 24 Oct 2019 13:49:26 +0200
Message-Id: <20191024114928.15377-2-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191024114928.15377-1-pmladek@suse.com>
References: <20191024114928.15377-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 9cf57731b63e37ed995 ("watchdog/softlockup: Replace "watchdog/%u"
 threads with cpu_stop_work") caused that the watchdog is reliably touched
during a task switch.

As a result the check for a unnoticed task switch is not longer needed.
And the commit b1a8de1f534337b398c7778 ("softlockup: make detector be aware
of task switch of processes hogging cpu") can be reverted.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/watchdog.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index f41334ef0971..b7e2046380cf 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -174,7 +174,6 @@ static DEFINE_PER_CPU(bool, softlockup_touch_sync);
 static DEFINE_PER_CPU(bool, soft_watchdog_warn);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
 static DEFINE_PER_CPU(unsigned long, soft_lockup_hrtimer_cnt);
-static DEFINE_PER_CPU(struct task_struct *, softlockup_task_ptr_saved);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
 static unsigned long soft_lockup_nmi_warn;
 
@@ -416,22 +415,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 			return HRTIMER_RESTART;
 
 		/* only warn once */
-		if (__this_cpu_read(soft_watchdog_warn) == true) {
-			/*
-			 * When multiple processes are causing softlockups the
-			 * softlockup detector only warns on the first one
-			 * because the code relies on a full quiet cycle to
-			 * re-arm.  The second process prevents the quiet cycle
-			 * and never gets reported.  Use task pointers to detect
-			 * this.
-			 */
-			if (__this_cpu_read(softlockup_task_ptr_saved) !=
-			    current) {
-				__this_cpu_write(soft_watchdog_warn, false);
-				__touch_watchdog();
-			}
+		if (__this_cpu_read(soft_watchdog_warn) == true)
 			return HRTIMER_RESTART;
-		}
 
 		if (softlockup_all_cpu_backtrace) {
 			/* Prevent multiple soft-lockup reports if one cpu is already
@@ -447,7 +432,6 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
 			smp_processor_id(), duration,
 			current->comm, task_pid_nr(current));
-		__this_cpu_write(softlockup_task_ptr_saved, current);
 		print_modules();
 		print_irqtrace_events(current);
 		if (regs)
-- 
2.16.4

