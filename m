Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B90CC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257B92087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qdCC/eu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfG3WRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:17:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41501 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbfG3WRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:17:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UMGTGf3398928
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 15:16:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UMGTGf3398928
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564524989;
        bh=4h1lRGvK45JmQtMrFgN8U5BoqpxjyRh0ehQ63FWqXJ0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=qdCC/eu24mfLA+OuJ79/hBaKPJJ+h0jui69vnVo+laM0JHOovH75CIiZPib9MMJnv
         6bVtLYdHhc0wwa1GWS7iupQ8I+0T2ZImy/597mkZZD2HRxUOx0R7pi0ryUn/0hky2J
         80dbXhvW/6dXknlthJ+SGCpgSURjZsJ84hDpSHv5mgPJ7eBcp/LKFCu6FJIk6bgTAA
         wvpUT8QoyYZRgiXX2UYgoDfjThKNvBFNv4ANMOl2TNOqnZoCwekZ9APnDHTVg335YR
         EakWOpxhcX7zb1/xoqtfU8oKPol/dZjXyZQXdvA1W0hoNs4ajjGczwOcIXp+KrFT0m
         WlBuDtqZWUqlg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UMGScZ3398925;
        Tue, 30 Jul 2019 15:16:28 -0700
Date:   Tue, 30 Jul 2019 15:16:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-a6bc84e64a7dbfdeaae02f434ad1b296f2f9cd1e@git.kernel.org>
Cc:     bigeasy@linutronix.de, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
          bigeasy@linutronix.de, rostedt@goodmis.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org
In-Reply-To: <20190726185753.645792403@linutronix.de>
References: <20190726185753.645792403@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] hrtimer: Determine hard/soft expiry mode for
 hrtimer sleepers on RT
Git-Commit-ID: a6bc84e64a7dbfdeaae02f434ad1b296f2f9cd1e
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

Commit-ID:  a6bc84e64a7dbfdeaae02f434ad1b296f2f9cd1e
Gitweb:     https://git.kernel.org/tip/a6bc84e64a7dbfdeaae02f434ad1b296f2f9cd1e
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 20:30:58 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jul 2019 23:57:57 +0200

hrtimer: Determine hard/soft expiry mode for hrtimer sleepers on RT

On PREEMPT_RT enabled kernels hrtimers which are not explicitely marked for
hard interrupt expiry mode are moved into soft interrupt context either for
latency reasons or because the hrtimer callback takes regular spinlocks or
invokes other functions which are not suitable for hard interrupt context
on PREEMPT_RT.

The hrtimer_sleeper callback is RT compatible in hard interrupt context,
but there is a latency concern: Untrusted userspace can spawn many threads
which arm timers for the same expiry time on the same CPU. On expiry that
causes a latency spike due to the wakeup of a gazillion threads.

OTOH, priviledged real-time user space applications rely on the low latency
of hard interrupt wakeups. These syscall related wakeups are all based on
hrtimer sleepers.

If the current task is in a real-time scheduling class, mark the mode for
hard interrupt expiry.

[ tglx: Split out of a larger combo patch. Added changelog ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190726185753.645792403@linutronix.de

---
 kernel/time/hrtimer.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 90dcc4d95e91..c101f88ae8aa 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1676,6 +1676,16 @@ static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer)
 void hrtimer_sleeper_start_expires(struct hrtimer_sleeper *sl,
 				   enum hrtimer_mode mode)
 {
+	/*
+	 * Make the enqueue delivery mode check work on RT. If the sleeper
+	 * was initialized for hard interrupt delivery, force the mode bit.
+	 * This is a special case for hrtimer_sleepers because
+	 * hrtimer_init_sleeper() determines the delivery mode on RT so the
+	 * fiddling with this decision is avoided at the call sites.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && sl->timer.is_hard)
+		mode |= HRTIMER_MODE_HARD;
+
 	hrtimer_start_expires(&sl->timer, mode);
 }
 EXPORT_SYMBOL_GPL(hrtimer_sleeper_start_expires);
@@ -1683,6 +1693,30 @@ EXPORT_SYMBOL_GPL(hrtimer_sleeper_start_expires);
 static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
 				   clockid_t clock_id, enum hrtimer_mode mode)
 {
+	/*
+	 * On PREEMPT_RT enabled kernels hrtimers which are not explicitely
+	 * marked for hard interrupt expiry mode are moved into soft
+	 * interrupt context either for latency reasons or because the
+	 * hrtimer callback takes regular spinlocks or invokes other
+	 * functions which are not suitable for hard interrupt context on
+	 * PREEMPT_RT.
+	 *
+	 * The hrtimer_sleeper callback is RT compatible in hard interrupt
+	 * context, but there is a latency concern: Untrusted userspace can
+	 * spawn many threads which arm timers for the same expiry time on
+	 * the same CPU. That causes a latency spike due to the wakeup of
+	 * a gazillion threads.
+	 *
+	 * OTOH, priviledged real-time user space applications rely on the
+	 * low latency of hard interrupt wakeups. If the current task is in
+	 * a real-time scheduling class, mark the mode for hard interrupt
+	 * expiry.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		if (task_is_realtime(current) && !(mode & HRTIMER_MODE_SOFT))
+			mode |= HRTIMER_MODE_HARD;
+	}
+
 	__hrtimer_init(&sl->timer, clock_id, mode);
 	sl->timer.function = hrtimer_wakeup;
 	sl->task = current;
