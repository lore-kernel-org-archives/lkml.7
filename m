Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB932C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCB12424C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cOL0X8u4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbfFCNdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:33:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49815 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfFCNdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:33:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DXNKa610554
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:33:23 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DXNKa610554
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559568804;
        bh=yeiSwi4vhGBmjedmweLO6MFjvESJJPY/hFcT1Ie7yCQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=cOL0X8u4hLcsiNoBoQUngRdWn74flNkhaBTXqbrNc3W3UAhogLjr69GJ9+kff1oXc
         K6KZIbHdo7sJPAfuUw6SgnxNNxdAvvq2XkUPZByJfKrd5JLIFyasmNmDjUQb/G3hDa
         RK+3IPOfXtE4z8lA/ATCTfv0qUNw4QIkTS6PKMH6BVg3nOet625ACx7ut+ePPvsKpC
         v2COVVnt9Da+TMtXVOF19V9K9tOO6ne7xNDe+bxODxjcF620os2DYKgKcMgEk4+Fx1
         +GzxqYSVHo1tr+Z7LjBYdPXQNeVabyKi2+4JIG7SXqvIUn1aRaTlz/jls+9/rBPVcq
         H38LcXLMt10Zg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DXMRA610551;
        Mon, 3 Jun 2019 06:33:22 -0700
Date:   Mon, 3 Jun 2019 06:33:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-24811637dbfd07c69da7e9db586d35d17e6afca3@git.kernel.org>
Cc:     huang.ying.caritas@gmail.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, longman@redhat.com,
        torvalds@linux-foundation.org, bp@alien8.de,
        tim.c.chen@linux.intel.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        dave@stgolabs.net
Reply-To: dave@stgolabs.net, peterz@infradead.org,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          bp@alien8.de, tim.c.chen@linux.intel.com, will.deacon@arm.com,
          tglx@linutronix.de, hpa@zytor.com, huang.ying.caritas@gmail.com,
          longman@redhat.com, mingo@kernel.org
In-Reply-To: <20190527082326.GP2623@hirez.programming.kicks-ass.net>
References: <20190527082326.GP2623@hirez.programming.kicks-ass.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lock_events: Use raw_cpu_{add,inc}() for
 stats
Git-Commit-ID: 24811637dbfd07c69da7e9db586d35d17e6afca3
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

Commit-ID:  24811637dbfd07c69da7e9db586d35d17e6afca3
Gitweb:     https://git.kernel.org/tip/24811637dbfd07c69da7e9db586d35d17e6afca3
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Mon, 27 May 2019 10:23:26 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 12:32:56 +0200

locking/lock_events: Use raw_cpu_{add,inc}() for stats

Instead of playing silly games with CONFIG_DEBUG_PREEMPT toggling
between this_cpu_*() and __this_cpu_*() use raw_cpu_*(), which is
exactly what we want here.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: huang ying <huang.ying.caritas@gmail.com>
Link: https://lkml.kernel.org/r/20190527082326.GP2623@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lock_events.h | 45 ++++----------------------------------------
 1 file changed, 4 insertions(+), 41 deletions(-)

diff --git a/kernel/locking/lock_events.h b/kernel/locking/lock_events.h
index 46b71af8eef2..8c7e7d25f09c 100644
--- a/kernel/locking/lock_events.h
+++ b/kernel/locking/lock_events.h
@@ -31,50 +31,13 @@ enum lock_events {
 DECLARE_PER_CPU(unsigned long, lockevents[lockevent_num]);
 
 /*
- * The purpose of the lock event counting subsystem is to provide a low
- * overhead way to record the number of specific locking events by using
- * percpu counters. It is the percpu sum that matters, not specifically
- * how many of them happens in each cpu.
- *
- * It is possible that the same percpu counter may be modified in both
- * the process and interrupt contexts. For architectures that perform
- * percpu operation with multiple instructions, it is possible to lose
- * count if a process context percpu update is interrupted in the middle
- * and the same counter is updated in the interrupt context. Therefore,
- * the generated percpu sum may not be precise. The error, if any, should
- * be small and insignificant.
- *
- * For those architectures that do multi-instruction percpu operation,
- * preemption in the middle and moving the task to another cpu may cause
- * a larger error in the count. Again, this will be few and far between.
- * Given the imprecise nature of the count and the possibility of resetting
- * the count and doing the measurement again, this is not really a big
- * problem.
- *
- * To get a better picture of what is happening under the hood, it is
- * suggested that a few measurements should be taken with the counts
- * reset in between to stamp out outliner because of these possible
- * error conditions.
- *
- * To minimize overhead, we use __this_cpu_*() in all cases except when
- * CONFIG_DEBUG_PREEMPT is defined. In this particular case, this_cpu_*()
- * will be used to avoid the appearance of unwanted BUG messages.
- */
-#ifdef CONFIG_DEBUG_PREEMPT
-#define lockevent_percpu_inc(x)		this_cpu_inc(x)
-#define lockevent_percpu_add(x, v)	this_cpu_add(x, v)
-#else
-#define lockevent_percpu_inc(x)		__this_cpu_inc(x)
-#define lockevent_percpu_add(x, v)	__this_cpu_add(x, v)
-#endif
-
-/*
- * Increment the PV qspinlock statistical counters
+ * Increment the statistical counters. use raw_cpu_inc() because of lower
+ * overhead and we don't care if we loose the occasional update.
  */
 static inline void __lockevent_inc(enum lock_events event, bool cond)
 {
 	if (cond)
-		lockevent_percpu_inc(lockevents[event]);
+		raw_cpu_inc(lockevents[event]);
 }
 
 #define lockevent_inc(ev)	  __lockevent_inc(LOCKEVENT_ ##ev, true)
@@ -82,7 +45,7 @@ static inline void __lockevent_inc(enum lock_events event, bool cond)
 
 static inline void __lockevent_add(enum lock_events event, int inc)
 {
-	lockevent_percpu_add(lockevents[event], inc);
+	raw_cpu_add(lockevents[event], inc);
 }
 
 #define lockevent_add(ev, c)	__lockevent_add(LOCKEVENT_ ##ev, c)
