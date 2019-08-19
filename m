Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3151C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941DC2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="f7t2xJBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfHSJxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 05:53:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48991 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfHSJxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 05:53:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7J9qwAL4086401
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 19 Aug 2019 02:52:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7J9qwAL4086401
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1566208379;
        bh=ViFhlYlb4mbXvgvShCwnzSPVgUnY402sGO27DQuiJyc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=f7t2xJBYGTifbTouaeiJWIetLKpUdTGgk2bMt04z3zFhLpBueNJ8FsrAk/NA+WWSA
         1gWL4dIIemWQOHo42krbfrFe31s4aw9QK8qZrVVoi2rkeYsf2e3km32oq4JPX1ThfI
         RivjZsyQCfgx0GcSN8frd7EMRAoPdtw1scToKhk4o2Y3MXfOKkkSmWC24lexp3GJLQ
         4zuvVe11/6lX62AHdFitbn2jCRCaTP4U5j9FpRU6/zXq3im3VT+jzQZ0YPLcNxjq8Z
         3IuDIla9fWACi6tglaBOn5Rem7jFYrDj4WgLfNFCGiMBfKj3gbFCjXbcwXiBsfT0tc
         iOaz1DeCODkRw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7J9qwCj4086398;
        Mon, 19 Aug 2019 02:52:58 -0700
Date:   Mon, 19 Aug 2019 02:52:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-b0fdc01354f45d43f082025636ef808968a27b36@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org,
        bigeasy@linutronix.de, mingo@kernel.org
Reply-To: peterz@infradead.org, bigeasy@linutronix.de,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
          mingo@kernel.org, torvalds@linux-foundation.org
In-Reply-To: <20190816160626.12742-1-bigeasy@linutronix.de>
References: <20190816160626.12742-1-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/core: Schedule new worker even if
 PI-blocked
Git-Commit-ID: b0fdc01354f45d43f082025636ef808968a27b36
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

Commit-ID:  b0fdc01354f45d43f082025636ef808968a27b36
Gitweb:     https://git.kernel.org/tip/b0fdc01354f45d43f082025636ef808968a27b36
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Fri, 16 Aug 2019 18:06:26 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 19 Aug 2019 10:57:26 +0200

sched/core: Schedule new worker even if PI-blocked

If a task is PI-blocked (blocking on sleeping spinlock) then we don't want to
schedule a new kworker if we schedule out due to lock contention because !RT
does not do that as well. A spinning spinlock disables preemption and a worker
does not schedule out on lock contention (but spin).

On RT the RW-semaphore implementation uses an rtmutex so
tsk_is_pi_blocked() will return true if a task blocks on it. In this case we
will now start a new worker which may deadlock if one worker is waiting on
progress from another worker. Since a RW-semaphore starts a new worker on !RT,
we should do the same on RT.

XFS is able to trigger this deadlock.

Allow to schedule new worker if the current worker is PI-blocked.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20190816160626.12742-1-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2b037f195473..010d578118d6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3904,7 +3904,7 @@ void __noreturn do_task_dead(void)
 
 static inline void sched_submit_work(struct task_struct *tsk)
 {
-	if (!tsk->state || tsk_is_pi_blocked(tsk))
+	if (!tsk->state)
 		return;
 
 	/*
@@ -3920,6 +3920,9 @@ static inline void sched_submit_work(struct task_struct *tsk)
 		preempt_enable_no_resched();
 	}
 
+	if (tsk_is_pi_blocked(tsk))
+		return;
+
 	/*
 	 * If we are going to sleep and we have plugged IO queued,
 	 * make sure to submit it to avoid deadlocks.
