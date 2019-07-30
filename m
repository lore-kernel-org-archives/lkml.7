Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3998C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A9A205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="aK9wjhLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfG3WP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:15:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51189 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfG3WP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:15:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UMFiLI3398823
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 15:15:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UMFiLI3398823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564524944;
        bh=qctDV/DofJjZAu0TvRJH+IMKXEgAUtUomRmCSuVCz+0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=aK9wjhLBffqHKePNzHslNSzVp3VK5SXAm7XIU3BtCQQ2++9G+FX1w9tX2i085YFcD
         TMItzJlcEIMsXJbHd2GXsKltSSN+u+3dXHhzD9i8b/Iwrmg0Nce98KwjMLaUY/5xvP
         KlKDjV5iNNVj+1x7nO6Eyklt5VuhWNFJ2hoVAEz8dddJSD+QekX6/Ck6RMFO6kKSU0
         niB/OhwYLlojM7hY20kXI+irnMUKYMagYITV0WsGLrIgrTmcrhFs1MDYokGuClM8b+
         GnuMcetj9KpHfLLQWZ5FUFgb73h/1+7AgLzO+QoJtKF6srxhXMjwlVv85JQYstPAeK
         SztSzl0I8VX6A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UMFh2o3398820;
        Tue, 30 Jul 2019 15:15:43 -0700
Date:   Tue, 30 Jul 2019 15:15:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-f4f9a0e3f4c01a11043aca77006532c3c889c9ba@git.kernel.org>
Cc:     bigeasy@linutronix.de, hpa@zytor.com, peterz@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
          hpa@zytor.com
In-Reply-To: <20190726185753.551967692@linutronix.de>
References: <20190726185753.551967692@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] hrtimer: Move unmarked hrtimers to soft interrupt
 expiry on RT
Git-Commit-ID: f4f9a0e3f4c01a11043aca77006532c3c889c9ba
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

Commit-ID:  f4f9a0e3f4c01a11043aca77006532c3c889c9ba
Gitweb:     https://git.kernel.org/tip/f4f9a0e3f4c01a11043aca77006532c3c889c9ba
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 20:30:57 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jul 2019 23:57:56 +0200

hrtimer: Move unmarked hrtimers to soft interrupt expiry on RT

On PREEMPT_RT not all hrtimers can be expired in hard interrupt context
even if that is perfectly fine on a PREEMPT_RT=n kernel, e.g. because they
take regular spinlocks. Also for latency reasons PREEMPT_RT tries to defer
most hrtimers' expiry into softirq context.

hrtimers marked with HRTIMER_MODE_HARD must be kept in hard interrupt
context expiry mode. Add the required logic.

No functional change for PREEMPT_RT=n kernels.

[ tglx: Split out of a larger combo patch. Added changelog ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190726185753.551967692@linutronix.de

---
 kernel/time/hrtimer.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 0ace301a56f4..90dcc4d95e91 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1275,8 +1275,17 @@ static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 			   enum hrtimer_mode mode)
 {
 	bool softtimer = !!(mode & HRTIMER_MODE_SOFT);
-	int base = softtimer ? HRTIMER_MAX_CLOCK_BASES / 2 : 0;
 	struct hrtimer_cpu_base *cpu_base;
+	int base;
+
+	/*
+	 * On PREEMPT_RT enabled kernels hrtimers which are not explicitely
+	 * marked for hard interrupt expiry mode are moved into soft
+	 * interrupt context for latency reasons and because the callbacks
+	 * can invoke functions which might sleep on RT, e.g. spin_lock().
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !(mode & HRTIMER_MODE_HARD))
+		softtimer = true;
 
 	memset(timer, 0, sizeof(struct hrtimer));
 
@@ -1290,6 +1299,7 @@ static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 	if (clock_id == CLOCK_REALTIME && mode & HRTIMER_MODE_REL)
 		clock_id = CLOCK_MONOTONIC;
 
+	base = softtimer ? HRTIMER_MAX_CLOCK_BASES / 2 : 0;
 	base += hrtimer_clockid_to_base(clock_id);
 	timer->is_soft = softtimer;
 	timer->is_hard = !softtimer;
