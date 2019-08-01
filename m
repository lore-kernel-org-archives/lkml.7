Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7320C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D4120838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="R/TUsuYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbfHAQH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:07:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47797 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfHAQH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:07:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x71G7GwY009933
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 09:07:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x71G7GwY009933
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564675637;
        bh=26PtLRURl1fUoMPCAjycO6ILoWoaLnioXFQ+vMKFF+0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=R/TUsuYKv55PhLkY4H0JstyFGFuRSKiw5o/B8zmfsfDiQbXJjcUbEdBEsm7Nu7lAx
         +VuWeyuyMj7xigoLZRSuxXqJ2B0DcoTeAhT4Mst+dp6EXnJaDtvk4vRlwDrumNBd6H
         PpiwpvCvOgdBTwf44XFP8vTCwpG00d4DNxDHt6FjbxcaPRG+vAUsYWn8RK1sADwvdv
         Z2SMd6r4XstaOk/fjSiaa4CdOGZUW5V4LbL9t5AUD9GLNN0F6aCihsmo0NBVQlt/W/
         Fse9JbrhnOLK5g/8UFGv2aTn2hRTEZSWkWYiWJknsXuZ2SNaCL+MPjbfTjQ+L4eSz6
         BeOKe4mbLTw6A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x71G7GZq009928;
        Thu, 1 Aug 2019 09:07:16 -0700
Date:   Thu, 1 Aug 2019 09:07:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-f8d1b0549263354b8d8854fefc521ac536be70ff@git.kernel.org>
Cc:     anna-maria@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
        tglx@linutronix.de
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          anna-maria@linutronix.de, peterz@infradead.org,
          tglx@linutronix.de
In-Reply-To: <20190730223828.874901027@linutronix.de>
References: <20190730223828.874901027@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] posix-timers: Rework cancel retry loops
Git-Commit-ID: f8d1b0549263354b8d8854fefc521ac536be70ff
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

Commit-ID:  f8d1b0549263354b8d8854fefc521ac536be70ff
Gitweb:     https://git.kernel.org/tip/f8d1b0549263354b8d8854fefc521ac536be70ff
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 31 Jul 2019 00:33:53 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Aug 2019 17:46:42 +0200

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
 
