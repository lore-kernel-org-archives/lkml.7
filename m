Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2081CC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F296120881
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbfEVPkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 11:40:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728466AbfEVPkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:40:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6702180F91;
        Wed, 22 May 2019 15:40:13 +0000 (UTC)
Received: from llong.com (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA53D60857;
        Wed, 22 May 2019 15:40:05 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/lock_events: Use this_cpu_add() when necessary
Date:   Wed, 22 May 2019 11:39:53 -0400
Message-Id: <20190522153953.30341-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 22 May 2019 15:40:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel test robot has reported that the use of __this_cpu_add()
causes bug messages like:

  BUG: using __this_cpu_add() in preemptible [00000000] code: ...

This is only an issue on preempt kernel where preemption can happen
in the middle of the multi-instruction percpu operation. It is not an
issue on x86 as the percpu operation is a single instruction.  The lock
events code is updated to use the slower this_cpu_add() for non-x86
preempt kernel or when CONFIG_DEBUG_PREEMPT is defined.

Fixes: a8654596f0371 ("locking/rwsem: Enable lock event counting")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lock_events.h | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lock_events.h b/kernel/locking/lock_events.h
index feb1acc54611..2b6c8b7588dc 100644
--- a/kernel/locking/lock_events.h
+++ b/kernel/locking/lock_events.h
@@ -30,13 +30,36 @@ enum lock_events {
  */
 DECLARE_PER_CPU(unsigned long, lockevents[lockevent_num]);
 
+/*
+ * The purpose of the lock event counting subsystem is to provide a low
+ * overhead way to record the number of specific locking events by using
+ * percpu counters. It is the percpu sum that matters, not specifically
+ * how many of them happens in each cpu.
+ *
+ * In !preempt kernel, we can just use __this_cpu_{inc|add}() as preemption
+ * won't happen in the middle of the percpu operation. In preempt kernel,
+ * it depends on whether the percpu operation is atomic (1 instruction)
+ * or not. We know x86 generates a single instruction to do percpu op, but
+ * we can't guarantee that for other architectures. We also need to use
+ * the slower this_cpu_{inc|add}() when CONFIG_DEBUG_PREEMPT is defined
+ * to make the checking code happy.
+ */
+#if defined(CONFIG_PREEMPT) && \
+   (defined(CONFIG_DEBUG_PREEMPT) || !defined(CONFIG_X86))
+#define lockevent_percpu_inc(x)		this_cpu_inc(x)
+#define lockevent_percpu_add(x, v)	this_cpu_add(x, v)
+#else
+#define lockevent_percpu_inc(x)		__this_cpu_inc(x)
+#define lockevent_percpu_add(x, v)	__this_cpu_add(x, v)
+#endif
+
 /*
  * Increment the PV qspinlock statistical counters
  */
 static inline void __lockevent_inc(enum lock_events event, bool cond)
 {
 	if (cond)
-		__this_cpu_inc(lockevents[event]);
+		lockevent_percpu_inc(lockevents[event]);
 }
 
 #define lockevent_inc(ev)	  __lockevent_inc(LOCKEVENT_ ##ev, true)
@@ -44,7 +67,7 @@ static inline void __lockevent_inc(enum lock_events event, bool cond)
 
 static inline void __lockevent_add(enum lock_events event, int inc)
 {
-	__this_cpu_add(lockevents[event], inc);
+	lockevent_percpu_add(lockevents[event], inc);
 }
 
 #define lockevent_add(ev, c)	__lockevent_add(LOCKEVENT_ ##ev, c)
-- 
2.18.1

