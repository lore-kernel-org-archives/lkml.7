Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253EAC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC51E206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ys2JK/2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732768AbfHAQI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:08:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53201 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfHAQI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:08:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x71G8k7c010136
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 09:08:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x71G8k7c010136
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564675727;
        bh=oqiteH2N7bZJpAn0FmMTHg0sVUfEFzV5QH08eZRlFQE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ys2JK/2j9h3xhb8JHJ8nsTN3WOB9vCgQuRgdKtZ2cJ0kjUH2Y6nHIwAscRtzzA9f4
         asexqMYRVEI2SnZ/r0xWviXiRMtYgebDCxB6ivM4okfdSQ9aJ/YmPkBFzAfsK2eAN2
         Wscio+IxXA2jt7Bo+bArXFGlCvIT6vrD9O3XAnihksMOyKZap3cwuPhUt5Exk9I0Nf
         RqzSc1afX/TVcLgXpsz8BngG9NGiyLhp6suwsYT6wsm5Ma8KoR+d5aeauLZx745QFt
         Vb0SIs5ADDN8JhLxD6A0NRee1SXJ4rMNt4SsQAdulGvbbCnGgyHIi7AaXks+Y/gU8I
         cPoN1qUl0dTiA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x71G8kI3010133;
        Thu, 1 Aug 2019 09:08:46 -0700
Date:   Thu, 1 Aug 2019 09:08:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-3a839db3eaeeef31520de45f3b078204d068e3d0@git.kernel.org>
Cc:     anna-maria@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: anna-maria@linutronix.de, mingo@kernel.org, peterz@infradead.org,
          tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190730223829.058247862@linutronix.de>
References: <20190730223829.058247862@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] posix-timers: Prepare for PREEMPT_RT
Git-Commit-ID: 3a839db3eaeeef31520de45f3b078204d068e3d0
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

Commit-ID:  3a839db3eaeeef31520de45f3b078204d068e3d0
Gitweb:     https://git.kernel.org/tip/3a839db3eaeeef31520de45f3b078204d068e3d0
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 31 Jul 2019 00:33:55 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Aug 2019 17:46:43 +0200

posix-timers: Prepare for PREEMPT_RT

Posix timer delete retry loops are affected by the same priority inversion
and live lock issues as the other timers.

Provide a RT specific synchronization function which keeps a reference to
the timer by holding rcu read lock to prevent the timer from being freed,
dropping the timer lock and invoking the timer specific wait function.

This does not yet cover posix CPU timers because they need more special
treatment on PREEMPT_RT.

Originally-by: Anna-Maria Gleixenr <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190730223829.058247862@linutronix.de

---
 kernel/time/posix-timers.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 3e663f982c82..a71c1aab071c 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -805,6 +805,29 @@ static int common_hrtimer_try_to_cancel(struct k_itimer *timr)
 	return hrtimer_try_to_cancel(&timr->it.real.timer);
 }
 
+#ifdef CONFIG_PREEMPT_RT
+static struct k_itimer *timer_wait_running(struct k_itimer *timer,
+					   unsigned long *flags)
+{
+	const struct k_clock *kc = READ_ONCE(timer->kclock);
+	timer_t timer_id = READ_ONCE(timer->it_id);
+
+	/* Prevent kfree(timer) after dropping the lock */
+	rcu_read_lock();
+	unlock_timer(timer, *flags);
+
+	if (kc->timer_arm == common_hrtimer_arm)
+		hrtimer_cancel_wait_running(&timer->it.real.timer);
+	else if (kc == &alarm_clock)
+		hrtimer_cancel_wait_running(&timer->it.alarm.alarmtimer.timer);
+	else
+		WARN_ON_ONCE(1);
+	rcu_read_unlock();
+
+	/* Relock the timer. It might be not longer hashed. */
+	return lock_timer(timer_id, flags);
+}
+#else
 static struct k_itimer *timer_wait_running(struct k_itimer *timer,
 					   unsigned long *flags)
 {
@@ -815,6 +838,7 @@ static struct k_itimer *timer_wait_running(struct k_itimer *timer,
 	/* Relock the timer. It might be not longer hashed. */
 	return lock_timer(timer_id, flags);
 }
+#endif
 
 /* Set a POSIX.1b interval timer. */
 int common_timer_set(struct k_itimer *timr, int flags,
