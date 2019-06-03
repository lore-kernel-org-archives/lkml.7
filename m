Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFA7C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A4F27DB3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="k8SJZHGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfFCNcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:32:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41117 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfFCNcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:32:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DVuvt610232
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:31:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DVuvt610232
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559568717;
        bh=tuJUTfZDFkJlyqJAY5AhfeSThTuNHh3cxL+IKwIk6G8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=k8SJZHGeERFrxC+/K+EWLXnirytpVPQWJbi+FIJeIIDpPdB9IOG25ZoKwrQhUWBlg
         0876zPCGTD3g+KzO9wP2HLSuR5llBoDa1tAG8JFkvhlmBFNrTxHIa0/jmCPq8Ynb+i
         SGMWyEtMR92ZRgKa1vxAMsyuGAcJ0EYO0V8Y0V3SLAP63P3tH1aYdNaHqnjJc0E0Ip
         gHIyroVkCMVXVS5xaoJ27FvyuxO/oOVXzuHMHgv3dqyUKKjR649tzAlOOKvpt/zNWV
         UNE5pxZayla+Ox6OmxapFNN93wQBuy6sim+Nn8pC4IF/r+0JnXQID5lccHU6rtJ5Di
         fCg603+1l6MIg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DVuL7610229;
        Mon, 3 Jun 2019 06:31:56 -0700
Date:   Mon, 3 Jun 2019 06:31:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Imre Deak <tipbot@zytor.com>
Message-ID: <tip-8c8889d8eaf4501ae4aaf870b6f8f55db5d5109a@git.kernel.org>
Cc:     peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, will.deacon@arm.com, imre.deak@intel.com
Reply-To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de,
          imre.deak@intel.com, will.deacon@arm.com, mingo@kernel.org
In-Reply-To: <20190524201509.9199-1-imre.deak@intel.com>
References: <20190524201509.9199-1-imre.deak@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Fix OOO unlock when hlocks need
 merging
Git-Commit-ID: 8c8889d8eaf4501ae4aaf870b6f8f55db5d5109a
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

Commit-ID:  8c8889d8eaf4501ae4aaf870b6f8f55db5d5109a
Gitweb:     https://git.kernel.org/tip/8c8889d8eaf4501ae4aaf870b6f8f55db5d5109a
Author:     Imre Deak <imre.deak@intel.com>
AuthorDate: Fri, 24 May 2019 23:15:08 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 12:32:29 +0200

locking/lockdep: Fix OOO unlock when hlocks need merging

The sequence

	static DEFINE_WW_CLASS(test_ww_class);

	struct ww_acquire_ctx ww_ctx;
	struct ww_mutex ww_lock_a;
	struct ww_mutex ww_lock_b;
	struct mutex lock_c;
	struct mutex lock_d;

	ww_acquire_init(&ww_ctx, &test_ww_class);

	ww_mutex_init(&ww_lock_a, &test_ww_class);
	ww_mutex_init(&ww_lock_b, &test_ww_class);

	mutex_init(&lock_c);

	ww_mutex_lock(&ww_lock_a, &ww_ctx);

	mutex_lock(&lock_c);

	ww_mutex_lock(&ww_lock_b, &ww_ctx);

	mutex_unlock(&lock_c);		(*)

	ww_mutex_unlock(&ww_lock_b);
	ww_mutex_unlock(&ww_lock_a);

	ww_acquire_fini(&ww_ctx);

triggers the following WARN in __lock_release() when doing the unlock at *:

	DEBUG_LOCKS_WARN_ON(curr->lockdep_depth != depth - 1);

The problem is that the WARN check doesn't take into account the merging
of ww_lock_a and ww_lock_b which results in decreasing curr->lockdep_depth
by 2 not only 1.

Note that the following sequence doesn't trigger the WARN, since there
won't be any hlock merging.

	ww_acquire_init(&ww_ctx, &test_ww_class);

	ww_mutex_init(&ww_lock_a, &test_ww_class);
	ww_mutex_init(&ww_lock_b, &test_ww_class);

	mutex_init(&lock_c);
	mutex_init(&lock_d);

	ww_mutex_lock(&ww_lock_a, &ww_ctx);

	mutex_lock(&lock_c);
	mutex_lock(&lock_d);

	ww_mutex_lock(&ww_lock_b, &ww_ctx);

	mutex_unlock(&lock_d);

	ww_mutex_unlock(&ww_lock_b);
	ww_mutex_unlock(&ww_lock_a);

	mutex_unlock(&lock_c);

	ww_acquire_fini(&ww_ctx);

In general both of the above two sequences are valid and shouldn't
trigger any lockdep warning.

Fix this by taking the decrement due to the hlock merging into account
during lock release and hlock class re-setting. Merging can't happen
during lock downgrading since there won't be a new possibility to merge
hlocks in that case, so add a WARN if merging still happens then.

Signed-off-by: Imre Deak <imre.deak@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: ville.syrjala@linux.intel.com
Link: https://lkml.kernel.org/r/20190524201509.9199-1-imre.deak@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2168e94715b9..6c97f67ec321 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3808,7 +3808,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 				hlock->references = 2;
 			}
 
-			return 1;
+			return 2;
 		}
 	}
 
@@ -4011,22 +4011,33 @@ out:
 }
 
 static int reacquire_held_locks(struct task_struct *curr, unsigned int depth,
-			      int idx)
+				int idx, unsigned int *merged)
 {
 	struct held_lock *hlock;
+	int first_idx = idx;
 
 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
 		return 0;
 
 	for (hlock = curr->held_locks + idx; idx < depth; idx++, hlock++) {
-		if (!__lock_acquire(hlock->instance,
+		switch (__lock_acquire(hlock->instance,
 				    hlock_class(hlock)->subclass,
 				    hlock->trylock,
 				    hlock->read, hlock->check,
 				    hlock->hardirqs_off,
 				    hlock->nest_lock, hlock->acquire_ip,
-				    hlock->references, hlock->pin_count))
+				    hlock->references, hlock->pin_count)) {
+		case 0:
 			return 1;
+		case 1:
+			break;
+		case 2:
+			*merged += (idx == first_idx);
+			break;
+		default:
+			WARN_ON(1);
+			return 0;
+		}
 	}
 	return 0;
 }
@@ -4037,9 +4048,9 @@ __lock_set_class(struct lockdep_map *lock, const char *name,
 		 unsigned long ip)
 {
 	struct task_struct *curr = current;
+	unsigned int depth, merged = 0;
 	struct held_lock *hlock;
 	struct lock_class *class;
-	unsigned int depth;
 	int i;
 
 	if (unlikely(!debug_locks))
@@ -4066,14 +4077,14 @@ __lock_set_class(struct lockdep_map *lock, const char *name,
 	curr->lockdep_depth = i;
 	curr->curr_chain_key = hlock->prev_chain_key;
 
-	if (reacquire_held_locks(curr, depth, i))
+	if (reacquire_held_locks(curr, depth, i, &merged))
 		return 0;
 
 	/*
 	 * I took it apart and put it back together again, except now I have
 	 * these 'spare' parts.. where shall I put them.
 	 */
-	if (DEBUG_LOCKS_WARN_ON(curr->lockdep_depth != depth))
+	if (DEBUG_LOCKS_WARN_ON(curr->lockdep_depth != depth - merged))
 		return 0;
 	return 1;
 }
@@ -4081,8 +4092,8 @@ __lock_set_class(struct lockdep_map *lock, const char *name,
 static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 {
 	struct task_struct *curr = current;
+	unsigned int depth, merged = 0;
 	struct held_lock *hlock;
-	unsigned int depth;
 	int i;
 
 	if (unlikely(!debug_locks))
@@ -4109,7 +4120,11 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 	hlock->read = 1;
 	hlock->acquire_ip = ip;
 
-	if (reacquire_held_locks(curr, depth, i))
+	if (reacquire_held_locks(curr, depth, i, &merged))
+		return 0;
+
+	/* Merging can't happen with unchanged classes.. */
+	if (DEBUG_LOCKS_WARN_ON(merged))
 		return 0;
 
 	/*
@@ -4118,6 +4133,7 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 	 */
 	if (DEBUG_LOCKS_WARN_ON(curr->lockdep_depth != depth))
 		return 0;
+
 	return 1;
 }
 
@@ -4132,8 +4148,8 @@ static int
 __lock_release(struct lockdep_map *lock, unsigned long ip)
 {
 	struct task_struct *curr = current;
+	unsigned int depth, merged = 1;
 	struct held_lock *hlock;
-	unsigned int depth;
 	int i;
 
 	if (unlikely(!debug_locks))
@@ -4192,14 +4208,15 @@ __lock_release(struct lockdep_map *lock, unsigned long ip)
 	if (i == depth-1)
 		return 1;
 
-	if (reacquire_held_locks(curr, depth, i + 1))
+	if (reacquire_held_locks(curr, depth, i + 1, &merged))
 		return 0;
 
 	/*
 	 * We had N bottles of beer on the wall, we drank one, but now
 	 * there's not N-1 bottles of beer left on the wall...
+	 * Pouring two of the bottles together is acceptable.
 	 */
-	DEBUG_LOCKS_WARN_ON(curr->lockdep_depth != depth-1);
+	DEBUG_LOCKS_WARN_ON(curr->lockdep_depth != depth - merged);
 
 	/*
 	 * Since reacquire_held_locks() would have called check_chain_key()
