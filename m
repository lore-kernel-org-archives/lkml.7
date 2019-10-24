Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A509FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864582166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439383AbfJXLtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:49:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:50104 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439372AbfJXLtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:49:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A2AD0ADBB;
        Thu, 24 Oct 2019 11:49:49 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 3/3] watchdog/softlockup: Remove logic that tried to prevent repeated reports
Date:   Thu, 24 Oct 2019 13:49:28 +0200
Message-Id: <20191024114928.15377-4-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191024114928.15377-1-pmladek@suse.com>
References: <20191024114928.15377-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The softlockup detector does some gymnastic with the variable
soft_watchdog_warn. It was added by the commit 58687acba59266735ad
("lockup_detector: Combine nmi_watchdog and softlockup detector").

The purpose is not completely clear. There are the following clues:

  1. The comment "only warn once".

  2. watchdog_touch_ts is not explicitly updated when the softlockup is
    reported. It means that the softlockup might get reported every time
    watchdog_timer_fn() is called.

  3. The variable is set when softlockup is reported. And it is cleared
     when the watchdog was touched and the CPU is not longer is softlockup
     state.

It probably never worked. In each case, it have not worked last many years
because the watchdog gets touched in many known slow paths. For example,
it is touched in printk_stack_address(). Therefore it is touched
when printing the report. As a result, the report is always periodic.

Simply remove the logic. People want the periodic report anyway.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/watchdog.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 1eca651daf59..3626590c6542 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -174,7 +174,6 @@ static DEFINE_PER_CPU(unsigned long, watchdog_touch_ts);
 static DEFINE_PER_CPU(unsigned long, report_period_ts);
 static DEFINE_PER_CPU(struct hrtimer, watchdog_hrtimer);
 static DEFINE_PER_CPU(bool, softlockup_touch_sync);
-static DEFINE_PER_CPU(bool, soft_watchdog_warn);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts);
 static DEFINE_PER_CPU(unsigned long, soft_lockup_hrtimer_cnt);
 static DEFINE_PER_CPU(unsigned long, hrtimer_interrupts_saved);
@@ -431,19 +430,12 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		if (kvm_check_and_clear_guest_paused())
 			return HRTIMER_RESTART;
 
-		/* only warn once */
-		if (__this_cpu_read(soft_watchdog_warn) == true)
-			return HRTIMER_RESTART;
-
 		if (softlockup_all_cpu_backtrace) {
 			/* Prevent multiple soft-lockup reports if one cpu is already
 			 * engaged in dumping cpu back traces
 			 */
-			if (test_and_set_bit(0, &soft_lockup_nmi_warn)) {
-				/* Someone else will report us. Let's give up */
-				__this_cpu_write(soft_watchdog_warn, true);
+			if (test_and_set_bit(0, &soft_lockup_nmi_warn))
 				return HRTIMER_RESTART;
-			}
 		}
 
 		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
@@ -470,9 +462,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
 		if (softlockup_panic)
 			panic("softlockup: hung tasks");
-		__this_cpu_write(soft_watchdog_warn, true);
-	} else
-		__this_cpu_write(soft_watchdog_warn, false);
+	}
 
 	return HRTIMER_RESTART;
 }
-- 
2.16.4

