Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B303C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF40214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CKb3C0sV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbfHFNFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:05:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55293 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfHFNFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:05:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x76D4Jpp2187282
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 6 Aug 2019 06:04:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x76D4Jpp2187282
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565096660;
        bh=toX7vu0z5wVM6JP2c0ACZ+pM8PVVz538gqSLHoIsDlc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=CKb3C0sVM9x2/p0gI4gBn2LRGkQH5d6Ix0pmppWjeYGu8gICBa015RC2/kOb6WFYS
         Z1n9EUv0H07lpgLP5U56t70+cmRaDONX5WSEmuoXA11Vmb+RNS/rwOt0HE7q0XIqRV
         eAkgMoDCqlZQ/Z0F0jDOyY3qpzIUXMo9Sd+QJVdHEEfffqtPoRJlqVYSGwVv/rnSZo
         3T3b4YEWE46vtC5I8ooRa3Ez2Kph1xABP8psOPokhptDj9hDrwZ+Ktdj7s+xew0/8g
         DO48YR8RpZRYy8HRHXTuUP3h5DlAyFdPZcLJUTdIsHMzY/E7dFb6WF2194jaJaSrCw
         gmBrOC2Z/CJkw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x76D4JUe2187278;
        Tue, 6 Aug 2019 06:04:19 -0700
Date:   Tue, 6 Aug 2019 06:04:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-91d2a812dfb98b3b4dad661529c33bc38d303461@git.kernel.org>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org, hpa@zytor.com,
        longman@redhat.com, bp@alien8.de, tim.c.chen@linux.intel.com,
        peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        huang.ying.caritas@gmail.com, will.deacon@arm.com,
        dave@stgolabs.net
Reply-To: dave@stgolabs.net, will.deacon@arm.com,
          huang.ying.caritas@gmail.com, mingo@redhat.com,
          peterz@infradead.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          torvalds@linux-foundation.org, bp@alien8.de,
          tim.c.chen@linux.intel.com, longman@redhat.com, hpa@zytor.com
In-Reply-To: <20190625143913.24154-1-longman@redhat.com>
References: <20190625143913.24154-1-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Make handoff writer
 optimistically spin on owner
Git-Commit-ID: 91d2a812dfb98b3b4dad661529c33bc38d303461
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

Commit-ID:  91d2a812dfb98b3b4dad661529c33bc38d303461
Gitweb:     https://git.kernel.org/tip/91d2a812dfb98b3b4dad661529c33bc38d303461
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Tue, 25 Jun 2019 10:39:13 -0400
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Tue, 6 Aug 2019 12:49:15 +0200

locking/rwsem: Make handoff writer optimistically spin on owner

When the handoff bit is set by a writer, no other tasks other than
the setting writer itself is allowed to acquire the lock. If the
to-be-handoff'ed writer goes to sleep, there will be a wakeup latency
period where the lock is free, but no one can acquire it. That is less
than ideal.

To reduce that latency, the handoff writer will now optimistically spin
on the owner if it happens to be a on-cpu writer. It will spin until
it releases the lock and the to-be-handoff'ed writer can then acquire
the lock immediately without any delay. Of course, if the owner is not
a on-cpu writer, the to-be-handoff'ed writer will have to sleep anyway.

The optimistic spinning code is also modified to not stop spinning
when the handoff bit is set. This will prevent an occasional setting of
handoff bit from causing a bunch of optimistic spinners from entering
into the wait queue causing significant reduction in throughput.

On a 1-socket 22-core 44-thread Skylake system, the AIM7 shared_memory
workload was run with 7000 users. The throughput (jobs/min) of the
following kernels were as follows:

 1) 5.2-rc6
    - 8,092,486
 2) 5.2-rc6 + tip's rwsem patches
    - 7,567,568
 3) 5.2-rc6 + tip's rwsem patches + this patch
    - 7,954,545

Using perf-record(1), the %cpu time used by rwsem_down_write_slowpath(),
rwsem_down_write_failed() and their callees for the 3 kernels were 1.70%,
5.46% and 2.08% respectively.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: x86@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: huang ying <huang.ying.caritas@gmail.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20190625143913.24154-1-longman@redhat.com
---
 kernel/locking/rwsem.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index bd0f0d05724c..354238a08b7a 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -724,11 +724,12 @@ rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
 
 	rcu_read_lock();
 	for (;;) {
-		if (atomic_long_read(&sem->count) & RWSEM_FLAG_HANDOFF) {
-			state = OWNER_NONSPINNABLE;
-			break;
-		}
-
+		/*
+		 * When a waiting writer set the handoff flag, it may spin
+		 * on the owner as well. Once that writer acquires the lock,
+		 * we can spin on it. So we don't need to quit even when the
+		 * handoff bit is set.
+		 */
 		new = rwsem_owner_flags(sem, &new_flags);
 		if ((new != owner) || (new_flags != flags)) {
 			state = rwsem_owner_state(new, new_flags, nonspinnable);
@@ -974,6 +975,13 @@ static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
 {
 	return false;
 }
+
+static inline int
+rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
+{
+	return 0;
+}
+#define OWNER_NULL	1
 #endif
 
 /*
@@ -1206,6 +1214,18 @@ wait:
 
 		raw_spin_unlock_irq(&sem->wait_lock);
 
+		/*
+		 * After setting the handoff bit and failing to acquire
+		 * the lock, attempt to spin on owner to accelerate lock
+		 * transfer. If the previous owner is a on-cpu writer and it
+		 * has just released the lock, OWNER_NULL will be returned.
+		 * In this case, we attempt to acquire the lock again
+		 * without sleeping.
+		 */
+		if ((wstate == WRITER_HANDOFF) &&
+		    (rwsem_spin_on_owner(sem, 0) == OWNER_NULL))
+			goto trylock_again;
+
 		/* Block until there are no active lockers. */
 		for (;;) {
 			if (signal_pending_state(state, current))
@@ -1240,7 +1260,7 @@ wait:
 				break;
 			}
 		}
-
+trylock_again:
 		raw_spin_lock_irq(&sem->wait_lock);
 	}
 	__set_current_state(TASK_RUNNING);
