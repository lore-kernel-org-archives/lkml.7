Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBCAC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B19320848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfEPJOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 05:14:11 -0400
Received: from [192.198.146.188] ([192.198.146.188]:12009 "EHLO
        E6440.gar.corp.intel.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726336AbfEPJOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 05:14:10 -0400
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 May 2019 05:14:09 EDT
Received: from E6440.gar.corp.intel.com (localhost [127.0.0.1])
        by E6440.gar.corp.intel.com (Postfix) with ESMTP id 94352C0C87;
        Thu, 16 May 2019 17:06:53 +0800 (CST)
From:   Harry Pan <harry.pan@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     gs0622@gmail.com, Harry Pan <harry.pan@intel.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH] clocksource: Untrust the clocksource watchdog when its interval is too small
Date:   Thu, 16 May 2019 17:06:51 +0800
Message-Id: <20190516090651.1396-1-harry.pan@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch performs a sanity check on the deviation of the clocksource watchdog,
target to reduce false alarm that incorrectly marks current clocksource unstable
when there comes discrepancy.

Say if there is a discrepancy between the current clocksource and watchdog,
validate the watchdog deviation first, if its interval is too small against
the expected timer interval, we shall trust the current clocksource.

It is identified on some Coffee Lake platform w/ PC10 allowed, when the CPU
entered and exited from PC10 (the residency counter is increased), the HPET
generates timestamp delay, this causes discrepancy making kernel incorrectly
untrust the current clocksource (TSC in this case) and re-select the next
clocksource which is the problematic HPET, this eventually causes a user
sensible wall clock delay.

The HPET timestamp delay shall be tackled in firmware domain in order to
properly handle the timer offload between XTAL and RTC when it enters PC10,
while this patch is a mitigation to reduce the false alarm of clocksource
unstable regardless what clocksources are paired.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=203183
Signed-off-by: Harry Pan <harry.pan@intel.com>

---

 kernel/time/clocksource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 3bcc19ceb073..fb0a67827346 100644
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
+				return;
+			}
 			pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unstable because the skew is too large:\n",
 				smp_processor_id(), cs->name);
 			pr_warn("                      '%s' wd_now: %llx wd_last: %llx mask: %llx\n",
-- 
2.20.1

