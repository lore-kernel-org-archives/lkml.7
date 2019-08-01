Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F26C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C23206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="boEfz+xE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388497AbfHATJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:09:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36713 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388231AbfHATJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:09:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x71J9BKd071817
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 12:09:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x71J9BKd071817
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564686552;
        bh=VQfxg4xv/yjOvqd6sIq5rsOQqi+fmC2e8qyAbnJd/NA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=boEfz+xEIna84ZfbRBEiTcdpfzWxJ2BZLdQ1cNhnTk7yoaz/V8mbC2Y1BixDIzE1P
         5d2LdvS/uW5KlJoieWeANe+ur+wkBlL7CyjJsoQaEFuSC+oucj4NN3podMUC4Q0UpT
         GarjGq0eYytf83tzwzd74cgQB7F4OVD72CaHPdWjUuXerhxOSdRKhID2gQmRQUlx6Q
         5ss8Z9xgPimFywoB/tP8XS26RXimEgAbWNdCF8m/9ysdNhtgHmgKswlZL0/5fnKhyd
         /Vxhpli4qlJpvQZzSSfE6PowLLIw5aOBd1nPhGzWIF46fqcPhsa/g1T/Zg/RE1a5ru
         VtuoirGYxEjrA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x71J9BtQ071814;
        Thu, 1 Aug 2019 12:09:11 -0700
Date:   Thu, 1 Aug 2019 12:09:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-6945e5c2abe008302b20266248d6de95575311a8@git.kernel.org>
Cc:     anna-maria@linutronix.de, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org
Reply-To: anna-maria@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          peterz@infradead.org, hpa@zytor.com
In-Reply-To: <20190730223828.874901027@linutronix.de>
References: <20190730223828.874901027@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] posix-timers: Rework cancel retry loops
Git-Commit-ID: 6945e5c2abe008302b20266248d6de95575311a8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6945e5c2abe008302b20266248d6de95575311a8
Gitweb:     https://git.kernel.org/tip/6945e5c2abe008302b20266248d6de95575311a8
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 31 Jul 2019 00:33:53 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Aug 2019 20:51:24 +0200

posix-timers: Rework cancel retry loops

As a preparatory step for adding the PREEMPT RT specific synchronization
mechanism to wait for a running timer callback, rework the timer cancel
retry loops so they call a common function. This allows trivial
substitution in one place.

Originally-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190730223828.874901027@linutronix.de


---
 kernel/time/posix-timers.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index f5aedd2f60df..bbe8f9686a70 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -805,6 +805,17 @@ static int common_hrtimer_try_to_cancel(struct k_itimer *timr)
 	return hrtimer_try_to_cancel(&timr->it.real.timer);
 }
 
+static struct k_itimer *timer_wait_running(struct k_itimer *timer,
+					   unsigned long *flags)
+{
+	timer_t timer_id = READ_ONCE(timer->it_id);
+
+	unlock_timer(timer, *flags);
+	cpu_relax();
+	/* Relock the timer. It might be not longer hashed. */
+	return lock_timer(timer_id, flags);
+}
+
 /* Set a POSIX.1b interval timer. */
 int common_timer_set(struct k_itimer *timr, int flags,
 		     struct itimerspec64 *new_setting,
@@ -859,8 +870,9 @@ static int do_timer_settime(timer_t timer_id, int tmr_flags,
 
 	if (old_spec64)
 		memset(old_spec64, 0, sizeof(*old_spec64));
-retry:
+
 	timr = lock_timer(timer_id, &flags);
+retry:
 	if (!timr)
 		return -EINVAL;
 
@@ -870,11 +882,14 @@ retry:
 	else
 		error = kc->timer_set(timr, tmr_flags, new_spec64, old_spec64);
 
-	unlock_timer(timr, flags);
 	if (error == TIMER_RETRY) {
-		old_spec64 = NULL;	// We already got the old time...
+		// We already got the old time...
+		old_spec64 = NULL;
+		/* Unlocks and relocks the timer if it still exists */
+		timr = timer_wait_running(timr, &flags);
 		goto retry;
 	}
+	unlock_timer(timr, flags);
 
 	return error;
 }
@@ -951,13 +966,15 @@ SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
 	struct k_itimer *timer;
 	unsigned long flags;
 
-retry_delete:
 	timer = lock_timer(timer_id, &flags);
+
+retry_delete:
 	if (!timer)
 		return -EINVAL;
 
-	if (timer_delete_hook(timer) == TIMER_RETRY) {
-		unlock_timer(timer, flags);
+	if (unlikely(timer_delete_hook(timer) == TIMER_RETRY)) {
+		/* Unlocks and relocks the timer if it still exists */
+		timer = timer_wait_running(timer, &flags);
 		goto retry_delete;
 	}
 
