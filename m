Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE64C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9078920679
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="C1F2zOTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733087AbfHAS7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:59:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34987 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfHAS7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:59:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x71IxdhC068347
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 11:59:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x71IxdhC068347
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564685980;
        bh=law6ZTlI5ho8cu51jCOAD+nCQfJKWi5Iq8JmVYevSQ8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=C1F2zOTkdelv/2dQFbfLAkf3phdwePnKrEWMY4GA1SGdaUCeljvahZxaedqvzkOoD
         uz7XmsSboRsdPAwiuJxWr1TA0t1NRhvTnXMGJ861Ogl6NjoOr4ANokT2bYz6Sm54P4
         mahkWYK4qLuITATKzipbkLX87UMJP0IYVLMBXhhn5+YRWjdUm2m+9Ik5R70wxSNQD1
         Mx59O+6C4veijZBm6lj9hENVnXe8sc6kcSd3CuapblqXkA0clC6K+Y7fME+A0OQ/b3
         fsXpmyQPOJLKYlaNmyC1MfMxaVUTOjeLDexMGsBcjQAfjAIOOhUpv4tkjteKZSYkY0
         On0b0XMlmWWkw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x71Ixd45068344;
        Thu, 1 Aug 2019 11:59:39 -0700
Date:   Thu, 1 Aug 2019 11:59:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-30f9028b6c43fd17c006550594ea3dbb87afbf80@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org,
        mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
          hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
          peterz@infradead.org
In-Reply-To: <20190726185753.169509224@linutronix.de>
References: <20190726185753.169509224@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] perf/core: Mark hrtimers to expire in hard
 interrupt context
Git-Commit-ID: 30f9028b6c43fd17c006550594ea3dbb87afbf80
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

Commit-ID:  30f9028b6c43fd17c006550594ea3dbb87afbf80
Gitweb:     https://git.kernel.org/tip/30f9028b6c43fd17c006550594ea3dbb87afbf80
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 20:30:53 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Aug 2019 20:51:20 +0200

perf/core: Mark hrtimers to expire in hard interrupt context

To guarantee that the multiplexing mechanism and the hrtimer driven events
work on PREEMPT_RT enabled kernels it's required that the related hrtimers
expire in hard interrupt context. Mark them so PREEMPT_RT kernels wont
defer them to soft interrupt context.

No functional change.

[ tglx: Split out of larger combo patch. Added changelog ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190726185753.169509224@linutronix.de



---
 kernel/events/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 026a14541a38..9d623e257a51 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1103,7 +1103,7 @@ static void __perf_mux_hrtimer_init(struct perf_cpu_context *cpuctx, int cpu)
 	cpuctx->hrtimer_interval = ns_to_ktime(NSEC_PER_MSEC * interval);
 
 	raw_spin_lock_init(&cpuctx->hrtimer_lock);
-	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
+	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
 	timer->function = perf_mux_hrtimer_handler;
 }
 
@@ -1121,7 +1121,7 @@ static int perf_mux_hrtimer_restart(struct perf_cpu_context *cpuctx)
 	if (!cpuctx->hrtimer_active) {
 		cpuctx->hrtimer_active = 1;
 		hrtimer_forward_now(timer, cpuctx->hrtimer_interval);
-		hrtimer_start_expires(timer, HRTIMER_MODE_ABS_PINNED);
+		hrtimer_start_expires(timer, HRTIMER_MODE_ABS_PINNED_HARD);
 	}
 	raw_spin_unlock_irqrestore(&cpuctx->hrtimer_lock, flags);
 
@@ -9491,7 +9491,7 @@ static void perf_swevent_start_hrtimer(struct perf_event *event)
 		period = max_t(u64, 10000, hwc->sample_period);
 	}
 	hrtimer_start(&hwc->hrtimer, ns_to_ktime(period),
-		      HRTIMER_MODE_REL_PINNED);
+		      HRTIMER_MODE_REL_PINNED_HARD);
 }
 
 static void perf_swevent_cancel_hrtimer(struct perf_event *event)
@@ -9513,7 +9513,7 @@ static void perf_swevent_init_hrtimer(struct perf_event *event)
 	if (!is_sampling_event(event))
 		return;
 
-	hrtimer_init(&hwc->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&hwc->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	hwc->hrtimer.function = perf_swevent_hrtimer;
 
 	/*
