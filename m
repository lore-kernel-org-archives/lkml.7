Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8526C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CFC206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="3xDAxEWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732745AbfHAQIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:08:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46889 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfHAQIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:08:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x71G82TJ010050
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 09:08:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x71G82TJ010050
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564675682;
        bh=BeSO+XFfNYMZSS26kDLBaUm7Y96k9Dy2ppnatAp1m30=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=3xDAxEWpDxylUZCoVdm1J3o4ns+e7CKY6K6E76Pkd2pwWfIcsHQKBEPvSbJiv9TQv
         1g2tyqYdi/YO0VhDSCmO1dCBpnUKJXZzZAlszFHrjnN2NHFnXMJ2ht4k6Lh8lKMdvD
         Sb+k6AlDN5BaXVCChrquSKDtfvR3ZIgxoXJDkzMsUP+/dIEA1PgDo30+sl7O+jgyfW
         1wxK7zKH0u1VZu25WyH/u1gt001yu5n7JDKOqDQviaim3nx77rRowAKmN1xc3kDnJJ
         kP/orCMwkF7qFe2Pv/EALPwxQKx6nixGLCKWryiPM5DvwAHl/QKTZQ2aOC/XzLtKqG
         Bv/5rj98QZltQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x71G82U2010047;
        Thu, 1 Aug 2019 09:08:02 -0700
Date:   Thu, 1 Aug 2019 09:08:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-eb5d344194342c08406e0f04c224007ea7338c11@git.kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
        bigeasy@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, peterz@infradead.org, hpa@zytor.com,
          bigeasy@linutronix.de
In-Reply-To: <20190730223828.965541887@linutronix.de>
References: <20190730223828.965541887@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] posix-timers: Move rcu_head out of it union
Git-Commit-ID: eb5d344194342c08406e0f04c224007ea7338c11
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

Commit-ID:  eb5d344194342c08406e0f04c224007ea7338c11
Gitweb:     https://git.kernel.org/tip/eb5d344194342c08406e0f04c224007ea7338c11
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 31 Jul 2019 00:33:54 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Aug 2019 17:46:42 +0200

posix-timers: Move rcu_head out of it union

Timer deletion on PREEMPT_RT is prone to priority inversion and live
locks. The hrtimer code has a synchronization mechanism for this. Posix CPU
timers will grow one.

But that mechanism cannot be invoked while holding the k_itimer lock
because that can deadlock against the running timer callback. So the lock
must be dropped which allows the timer to be freed.

The timer free can be prevented by taking RCU readlock before dropping the
lock, but because the rcu_head is part of the 'it' union a concurrent free
will overwrite the hrtimer on which the task is trying to synchronize.

Move the rcu_head out of the union to prevent this.

[ tglx: Fixed up kernel-doc. Rewrote changelog ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190730223828.965541887@linutronix.de

---
 include/linux/posix-timers.h | 5 +++--
 kernel/time/posix-timers.c   | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index b20798fc5191..604cec0e41ba 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -85,7 +85,8 @@ static inline int clockid_to_fd(const clockid_t clk)
  * @it_process:		The task to wakeup on clock_nanosleep (CPU timers)
  * @sigq:		Pointer to preallocated sigqueue
  * @it:			Union representing the various posix timer type
- *			internals. Also used for rcu freeing the timer.
+ *			internals.
+ * @rcu:		RCU head for freeing the timer.
  */
 struct k_itimer {
 	struct list_head	list;
@@ -114,8 +115,8 @@ struct k_itimer {
 		struct {
 			struct alarm	alarmtimer;
 		} alarm;
-		struct rcu_head		rcu;
 	} it;
+	struct rcu_head		rcu;
 };
 
 void run_posix_cpu_timers(struct task_struct *task);
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index bbe8f9686a70..3e663f982c82 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -442,7 +442,7 @@ static struct k_itimer * alloc_posix_timer(void)
 
 static void k_itimer_rcu_free(struct rcu_head *head)
 {
-	struct k_itimer *tmr = container_of(head, struct k_itimer, it.rcu);
+	struct k_itimer *tmr = container_of(head, struct k_itimer, rcu);
 
 	kmem_cache_free(posix_timers_cache, tmr);
 }
@@ -459,7 +459,7 @@ static void release_posix_timer(struct k_itimer *tmr, int it_id_set)
 	}
 	put_pid(tmr->it_pid);
 	sigqueue_free(tmr->sigq);
-	call_rcu(&tmr->it.rcu, k_itimer_rcu_free);
+	call_rcu(&tmr->rcu, k_itimer_rcu_free);
 }
 
 static int common_timer_create(struct k_itimer *new_timer)
