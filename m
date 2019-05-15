Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6217FC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 060C22070D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 07:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="jWaINFI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfEOHrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 03:47:42 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:35986 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725902AbfEOHrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 03:47:41 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id F420B2E0466;
        Wed, 15 May 2019 10:47:36 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id e21YSaajE5-las4rTNf;
        Wed, 15 May 2019 10:47:36 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1557906456; bh=wfD836RhXs9aZUqj40Lp1zo1zWWJzQk7JmF5lRUq/VE=;
        h=Message-ID:Date:To:From:Subject;
        b=jWaINFI6IaR1HD1ZhI199BsxdlQtUzY7ce5HhkPCKM0m3CQ3ltobNT1V0j/3jVN9W
         O+9lNCISmyciRYr1ezdgAESy9LGKP1JJ+hmAiV9nxa/Kw48IP+f8xoLMiu6M/0avj5
         cxQV7so2Hq7VhDK/aj1450WMkA8jfLJowdSKVmnI=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:ed19:3833:7ce1:2324])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 8hOMEmcvTx-la8Si03j;
        Wed, 15 May 2019 10:47:36 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH RFC] time: validate watchdog clocksource using second best
 candidate
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        linux-kernel@vger.kernel.org
Date:   Wed, 15 May 2019 10:47:36 +0300
Message-ID: <155790645605.1933.906798561802423361.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Timekeeping watchdog verifies doubtful clocksources using more reliable
candidates. For x86 it likely verifies 'tsc' using 'hpet'. But 'hpet'
is far from perfect too. It's better to have second opinion if possible.

We're seeing sudden jumps of hpet counter to 0xffffffff:

timekeeping watchdog on CPU56: Marking clocksource 'tsc' as unstable because the skew is too large:
'hpet' wd_now: ffffffff wd_last: 19ec5720 mask: ffffffff
'tsc' cs_now: 69b8a15f0aed cs_last: 69b862c9947d mask: ffffffffffffffff

Shaohua Li reported the same case three years ago.
His patch backlisted this exact value and re-read hpet counter.

This patch uses second reliable clocksource as backup for validation.
For x86 this is usually 'acpi_pm'. If watchdog and backup are not consent
then other clocksources will not be marked as unstable at this iteration.

In this case watchdog will print something like:
timekeeping watchdog on CPUxx: Ignoring watchdog 'hpet' hiccup because backup watchdog 'acpi_pm' is not consent:
and dump states of both clocksources.

Also this patch prints 'wd_nsec' and 'cs_nsec' for easier debug.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Link: https://lore.kernel.org/patchwork/patch/667413/
---
 kernel/time/clocksource.c |   67 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 16 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 3bcc19ceb073..c7209c833e97 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -99,6 +99,7 @@ static void clocksource_select(void);
 
 static LIST_HEAD(watchdog_list);
 static struct clocksource *watchdog;
+static struct clocksource *watchdog_backup;
 static struct timer_list watchdog_timer;
 static DECLARE_WORK(watchdog_work, clocksource_watchdog_work);
 static DEFINE_SPINLOCK(watchdog_lock);
@@ -190,6 +191,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 	u64 csnow, wdnow, cslast, wdlast, delta;
 	int64_t wd_nsec, cs_nsec;
 	int next_cpu, reset_pending;
+	bool backup_consent = true;
 
 	spin_lock(&watchdog_lock);
 	if (!watchdog_running)
@@ -236,16 +238,33 @@ static void clocksource_watchdog(struct timer_list *unused)
 
 		/* Check the deviation from the watchdog clocksource. */
 		if (abs(cs_nsec - wd_nsec) > WATCHDOG_THRESHOLD) {
-			pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unstable because the skew is too large:\n",
-				smp_processor_id(), cs->name);
-			pr_warn("                      '%s' wd_now: %llx wd_last: %llx mask: %llx\n",
-				watchdog->name, wdnow, wdlast, watchdog->mask);
-			pr_warn("                      '%s' cs_now: %llx cs_last: %llx mask: %llx\n",
-				cs->name, csnow, cslast, cs->mask);
-			__clocksource_unstable(cs);
+
+			/* Backup watchdog clocksource is first in the list */
+			if (cs == watchdog_backup)
+				backup_consent = false;
+
+			if (backup_consent)
+				pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unstable because the skew is too large:\n",
+					smp_processor_id(), cs->name);
+			else
+				pr_warn("timekeeping watchdog on CPU%d: Ignoring watchdog '%s' hiccup because backup watchdog '%s' is not consent:\n",
+					smp_processor_id(), watchdog->name,
+					watchdog_backup->name);
+
+			pr_warn("                      '%s' wd_now: %llx wd_last: %llx mask: %llx wd_nsec: %lld\n",
+				watchdog->name, wdnow, wdlast, watchdog->mask,
+				wd_nsec);
+			pr_warn("                      '%s' cs_now: %llx cs_last: %llx mask: %llx cs_nsec: %lld\n",
+				cs->name, csnow, cslast, cs->mask, cs_nsec);
+
+			if (backup_consent)
+				__clocksource_unstable(cs);
 			continue;
 		}
 
+		if (cs == watchdog_backup)
+			continue;
+
 		if (cs == curr_clocksource && cs->tick_stable)
 			cs->tick_stable(cs);
 
@@ -345,7 +364,7 @@ static void clocksource_enqueue_watchdog(struct clocksource *cs)
 	}
 }
 
-static void clocksource_select_watchdog(bool fallback)
+static void clocksource_select_watchdog(struct clocksource *except)
 {
 	struct clocksource *cs, *old_wd;
 	unsigned long flags;
@@ -353,26 +372,42 @@ static void clocksource_select_watchdog(bool fallback)
 	spin_lock_irqsave(&watchdog_lock, flags);
 	/* save current watchdog */
 	old_wd = watchdog;
-	if (fallback)
+	if (watchdog == except)
 		watchdog = NULL;
 
+	if (watchdog_backup) {
+		list_del_init(&watchdog_backup->wd_list);
+		watchdog_backup = NULL;
+	}
+
 	list_for_each_entry(cs, &clocksource_list, list) {
 		/* cs is a clocksource to be watched. */
 		if (cs->flags & CLOCK_SOURCE_MUST_VERIFY)
 			continue;
 
 		/* Skip current if we were requested for a fallback. */
-		if (fallback && cs == old_wd)
+		if (cs == except)
 			continue;
 
 		/* Pick the best watchdog. */
-		if (!watchdog || cs->rating > watchdog->rating)
+		if (!watchdog || cs->rating > watchdog->rating) {
+			watchdog_backup = watchdog;
 			watchdog = cs;
+		}
+
+		/* Pick the second best for cross-validation. */
+		if (cs != watchdog &&
+		    (!watchdog_backup || cs->rating > watchdog_backup->rating))
+			watchdog_backup = cs;
 	}
 	/* If we failed to find a fallback restore the old one. */
 	if (!watchdog)
 		watchdog = old_wd;
 
+	/* Backup watchdog must be first in the list. */
+	if (watchdog_backup)
+		list_add(&watchdog_backup->wd_list, &watchdog_list);
+
 	/* If we changed the watchdog we need to reset cycles. */
 	if (watchdog != old_wd)
 		clocksource_reset_watchdog();
@@ -430,7 +465,7 @@ static int clocksource_watchdog_kthread(void *data)
 
 static bool clocksource_is_watchdog(struct clocksource *cs)
 {
-	return cs == watchdog;
+	return cs == watchdog || cs == watchdog_backup;
 }
 
 #else /* CONFIG_CLOCKSOURCE_WATCHDOG */
@@ -441,7 +476,7 @@ static void clocksource_enqueue_watchdog(struct clocksource *cs)
 		cs->flags |= CLOCK_SOURCE_VALID_FOR_HRES;
 }
 
-static void clocksource_select_watchdog(bool fallback) { }
+static void clocksource_select_watchdog(struct clocksource *except) { }
 static inline void clocksource_dequeue_watchdog(struct clocksource *cs) { }
 static inline void clocksource_resume_watchdog(void) { }
 static inline int __clocksource_watchdog_kthread(void) { return 0; }
@@ -933,7 +968,7 @@ int __clocksource_register_scale(struct clocksource *cs, u32 scale, u32 freq)
 	clocksource_watchdog_unlock(&flags);
 
 	clocksource_select();
-	clocksource_select_watchdog(false);
+	clocksource_select_watchdog(NULL);
 	__clocksource_suspend_select(cs);
 	mutex_unlock(&clocksource_mutex);
 	return 0;
@@ -962,7 +997,7 @@ void clocksource_change_rating(struct clocksource *cs, int rating)
 	clocksource_watchdog_unlock(&flags);
 
 	clocksource_select();
-	clocksource_select_watchdog(false);
+	clocksource_select_watchdog(NULL);
 	clocksource_suspend_select(false);
 	mutex_unlock(&clocksource_mutex);
 }
@@ -977,7 +1012,7 @@ static int clocksource_unbind(struct clocksource *cs)
 
 	if (clocksource_is_watchdog(cs)) {
 		/* Select and try to install a replacement watchdog. */
-		clocksource_select_watchdog(true);
+		clocksource_select_watchdog(cs);
 		if (clocksource_is_watchdog(cs))
 			return -EBUSY;
 	}

