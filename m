Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB5FC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 18:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6179B2087B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 18:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbfERSFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 14:05:41 -0400
Received: from [49.216.8.140] ([49.216.8.140]:55394 "EHLO
        E6440.gar.corp.intel.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728283AbfERSFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 14:05:41 -0400
Received: from E6440.gar.corp.intel.com (localhost [127.0.0.1])
        by E6440.gar.corp.intel.com (Postfix) with ESMTP id 21BACC023A;
        Sun, 19 May 2019 01:45:14 +0800 (CST)
From:   Harry Pan <harry.pan@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     gs0622@gmail.com, Harry Pan <harry.pan@intel.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v3] clocksource: Untrust the watchdog if its interval is too small
Date:   Sun, 19 May 2019 01:45:12 +0800
Message-Id: <20190518174512.21053-1-harry.pan@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190518141005.1132-1-harry.pan@intel.com>
References: <20190518141005.1132-1-harry.pan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perform sanity check on the watchdog to validate its interval, avoid
to generate a false alarm that incorrectly marks the main clocksource
as unstable when there comes discrepancy.

Say if there is a discrepancy between the current clocksource and watchdog,
validate the watchdog deviation first, if its interval is too small against
the expected timer interval, we shall trust the current clocksource, else
incorrectly kick off the main clocksource could mess up the wall clock.

It is identified on some Coffee Lake platform w/ PC10 allowed, it has a
problematic HPET timer in the platform integration, when the CPU exited
from the low power mode of PC10, the HPET generates timestamp delay, this
causes discrepancy making kernel incorrectly untrust the current clocksource
(TSC in this case) and re-select the next clocksource which is the problematic
HPET, this eventually causes a user sensible wall clock delay.

v2: fix resource leak: the locked watchdog_lock
v3: revise the communication: focus on the timer self validation

Link: https://bugzilla.kernel.org/show_bug.cgi?id=203183
Signed-off-by: Harry Pan <harry.pan@intel.com>

---

 kernel/time/clocksource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 3bcc19ceb073..090d937d5ec4 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -96,6 +96,7 @@ static u64 suspend_start;
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
 static void clocksource_watchdog_work(struct work_struct *work);
 static void clocksource_select(void);
+static void clocksource_dequeue_watchdog(struct clocksource *cs);
 
 static LIST_HEAD(watchdog_list);
 static struct clocksource *watchdog;
@@ -236,6 +237,12 @@ static void clocksource_watchdog(struct timer_list *unused)
 
 		/* Check the deviation from the watchdog clocksource. */
 		if (abs(cs_nsec - wd_nsec) > WATCHDOG_THRESHOLD) {
+			if (wd_nsec < jiffies_to_nsecs(WATCHDOG_INTERVAL) - WATCHDOG_THRESHOLD) {
+				pr_err("Stop timekeeping watchdog '%s' because expected interval is too small in %lld ns only\n",
+					watchdog->name, wd_nsec);
+				clocksource_dequeue_watchdog(cs);
+				goto out;
+			}
 			pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unstable because the skew is too large:\n",
 				smp_processor_id(), cs->name);
 			pr_warn("                      '%s' wd_now: %llx wd_last: %llx mask: %llx\n",
-- 
2.20.1

