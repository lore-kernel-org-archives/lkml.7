Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC04EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76ECC206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QFczaNKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbfHATKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:10:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47431 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388231AbfHATKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:10:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x71J9tTT071862
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 12:09:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x71J9tTT071862
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564686596;
        bh=s42twm9OO75Yr3MzJx7SPQmfkc9wUkGsP/3sfOf4t7s=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=QFczaNKaN8uUAeM7/ZOP64ij8skpdqjCIoBwtESoHSzoPvV5+lVk+gejGlVvm11Ma
         UevmDAm6lzQE7NOot6hWdJzw7kSWRtuQ0BJc+L7HLhC3eO86a2OlGKhMouwNkuzNWn
         oaJLVEJB9teydGHiV9v/lmTgHBUuap9vUAkphc9q2PbFNPvvcKhlZ2ZnDP8TZJaZvG
         PEl0jtIYj1TR3ferTJI5XpQAKwhGvEnCzCrZQgQNAo2gYUNN9joPLMHzUs3+VYR4md
         R9wqaKdclpNLCl0xpoN58VZOyuvL3Bv44eVmFU6Z9erWJPC7bBLfsnKJfnPeut2mg/
         pL2aWhL8aZvig==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x71J9tME071858;
        Thu, 1 Aug 2019 12:09:55 -0700
Date:   Thu, 1 Aug 2019 12:09:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-5d99b32a009e900a561f6a42ea7afe5b21288b8a@git.kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, tglx@linutronix.de,
        hpa@zytor.com
Reply-To: peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
          hpa@zytor.com
In-Reply-To: <20190730223828.965541887@linutronix.de>
References: <20190730223828.965541887@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] posix-timers: Move rcu_head out of it union
Git-Commit-ID: 5d99b32a009e900a561f6a42ea7afe5b21288b8a
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

Commit-ID:  5d99b32a009e900a561f6a42ea7afe5b21288b8a
Gitweb:     https://git.kernel.org/tip/5d99b32a009e900a561f6a42ea7afe5b21288b8a
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 31 Jul 2019 00:33:54 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Aug 2019 20:51:25 +0200

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
