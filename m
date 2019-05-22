Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8027C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E972081C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388017AbfEVTv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:51:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:24848 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732080AbfEVTv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:51:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 12:51:25 -0700
X-ExtLoop1: 1
Received: from ideak-desk.fi.intel.com ([10.237.72.204])
  by orsmga003.jf.intel.com with ESMTP; 22 May 2019 12:51:24 -0700
From:   Imre Deak <imre.deak@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/2] lockdep: Fix OOO unlock when hlocks need merging
Date:   Wed, 22 May 2019 22:50:52 +0300
Message-Id: <20190522195053.15079-1-imre.deak@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

	mutex_trylock(&lock_c);

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
won't be any hlock merging:

	ww_acquire_init(&ww_ctx, &test_ww_class);

	ww_mutex_init(&ww_lock_a, &test_ww_class);
	ww_mutex_init(&ww_lock_b, &test_ww_class);

	mutex_init(&lock_c);
	mutex_init(&lock_d);

	WARN_ON(ww_mutex_lock(&ww_lock_a, &ww_ctx));

	WARN_ON(!mutex_trylock(&lock_c));
	WARN_ON(!mutex_trylock(&lock_d));

	WARN_ON(ww_mutex_lock(&ww_lock_b, &ww_ctx));

	mutex_unlock(&lock_d);

	ww_mutex_unlock(&ww_lock_b);
	ww_mutex_unlock(&ww_lock_a);

	mutex_unlock(&lock_c);

	ww_acquire_fini(&ww_ctx);

Fix this by taking the decrement due to merging into account during lock
release and hlock class re-setting. It can't happen during lock
downgrading since there won't be a new possibility to merge hlocks in
that case, so add a WARN if it happens.

Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 kernel/locking/lockdep.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c40fba54e324..967352d32af1 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3714,7 +3714,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 				hlock->references = 2;
 			}
 
-			return 1;
+			return 2;
 		}
 	}
 
@@ -3920,22 +3920,33 @@ static struct held_lock *find_held_lock(struct task_struct *curr,
 }
 
 static int reacquire_held_locks(struct task_struct *curr, unsigned int depth,
-			      int idx)
+				int idx, bool *first_merged)
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
+			*first_merged = idx == first_idx;
+			break;
+		default:
+			WARN_ON(1);
+			return 0;
+		}
 	}
 	return 0;
 }
@@ -3948,6 +3959,7 @@ __lock_set_class(struct lockdep_map *lock, const char *name,
 	struct task_struct *curr = current;
 	struct held_lock *hlock;
 	struct lock_class *class;
+	bool first_merged = false;
 	unsigned int depth;
 	int i;
 
@@ -3973,14 +3985,14 @@ __lock_set_class(struct lockdep_map *lock, const char *name,
 	curr->lockdep_depth = i;
 	curr->curr_chain_key = hlock->prev_chain_key;
 
-	if (reacquire_held_locks(curr, depth, i))
+	if (reacquire_held_locks(curr, depth, i, &first_merged))
 		return 0;
 
 	/*
 	 * I took it apart and put it back together again, except now I have
 	 * these 'spare' parts.. where shall I put them.
 	 */
-	if (DEBUG_LOCKS_WARN_ON(curr->lockdep_depth != depth))
+	if (DEBUG_LOCKS_WARN_ON(curr->lockdep_depth != depth - first_merged))
 		return 0;
 	return 1;
 }
@@ -3989,6 +4001,7 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 {
 	struct task_struct *curr = current;
 	struct held_lock *hlock;
+	bool first_merged = false;
 	unsigned int depth;
 	int i;
 
@@ -4014,7 +4027,7 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 	hlock->read = 1;
 	hlock->acquire_ip = ip;
 
-	if (reacquire_held_locks(curr, depth, i))
+	if (reacquire_held_locks(curr, depth, i, &first_merged))
 		return 0;
 
 	/*
@@ -4023,6 +4036,11 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 	 */
 	if (DEBUG_LOCKS_WARN_ON(curr->lockdep_depth != depth))
 		return 0;
+
+	/* Merging can't happen with unchanged classes.. */
+	if (DEBUG_LOCKS_WARN_ON(first_merged))
+		return 0;
+
 	return 1;
 }
 
@@ -4038,6 +4056,7 @@ __lock_release(struct lockdep_map *lock, int nested, unsigned long ip)
 {
 	struct task_struct *curr = current;
 	struct held_lock *hlock;
+	bool first_merged = false;
 	unsigned int depth;
 	int i;
 
@@ -4093,14 +4112,15 @@ __lock_release(struct lockdep_map *lock, int nested, unsigned long ip)
 	if (i == depth-1)
 		return 1;
 
-	if (reacquire_held_locks(curr, depth, i + 1))
+	if (reacquire_held_locks(curr, depth, i + 1, &first_merged))
 		return 0;
 
 	/*
 	 * We had N bottles of beer on the wall, we drank one, but now
 	 * there's not N-1 bottles of beer left on the wall...
+	 * Pouring two of the bottles together is acceptable.
 	 */
-	DEBUG_LOCKS_WARN_ON(curr->lockdep_depth != depth-1);
+	DEBUG_LOCKS_WARN_ON(curr->lockdep_depth != depth - 1 - first_merged);
 
 	/*
 	 * Since reacquire_held_locks() would have called check_chain_key()
-- 
2.17.1

