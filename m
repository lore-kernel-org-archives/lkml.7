Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E1EC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE8A2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388024AbfEVTvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:51:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:24848 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732101AbfEVTv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:51:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 12:51:27 -0700
X-ExtLoop1: 1
Received: from ideak-desk.fi.intel.com ([10.237.72.204])
  by orsmga003.jf.intel.com with ESMTP; 22 May 2019 12:51:26 -0700
From:   Imre Deak <imre.deak@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/2] lockdep: Fix merging of hlocks with non-zero references
Date:   Wed, 22 May 2019 22:50:53 +0300
Message-Id: <20190522195053.15079-2-imre.deak@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522195053.15079-1-imre.deak@intel.com>
References: <20190522195053.15079-1-imre.deak@intel.com>
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
	struct ww_mutex ww_lock_c;
	struct mutex lock_c;

	ww_acquire_init(&ww_ctx, &test_ww_class);

	ww_mutex_init(&ww_lock_a, &test_ww_class);
	ww_mutex_init(&ww_lock_b, &test_ww_class);
	ww_mutex_init(&ww_lock_c, &test_ww_class);

	mutex_init(&lock_c);

	WARN_ON(ww_mutex_lock(&ww_lock_a, &ww_ctx));

	WARN_ON(!mutex_trylock(&lock_c));

	WARN_ON(ww_mutex_lock(&ww_lock_b, &ww_ctx));
	WARN_ON(ww_mutex_lock(&ww_lock_c, &ww_ctx));

	mutex_unlock(&lock_c);	(*)

	ww_mutex_unlock(&ww_lock_c);
	ww_mutex_unlock(&ww_lock_b);
	ww_mutex_unlock(&ww_lock_a);

	ww_acquire_fini(&ww_ctx); (**)

will trigger the following error in __lock_release() when calling
mutex_release() at **:

	DEBUG_LOCKS_WARN_ON(depth <= 0)

The problem is that the hlock merging happening at * updates the
references for test_ww_class incorrectly to 3 whereas it should've
updated it to 4 (representing all the instances for ww_ctx and
ww_lock_[abc]).

Fix this by updating the references during merging correctly taking into
account that we can have non-zero references (both for the hlock that we
merge into another hlock or for the hlock we are mering into).

Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 kernel/locking/lockdep.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 967352d32af1..9e2a4ab6c731 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3637,6 +3637,11 @@ print_lock_nested_lock_not_held(struct task_struct *curr,
 
 static int __lock_is_held(const struct lockdep_map *lock, int read);
 
+static int hlock_reference(int reference)
+{
+	return reference ? : 1;
+}
+
 /*
  * This gets called for every mutex_lock*()/spin_lock*() operation.
  * We maintain the dependency maps and validate the locking attempt:
@@ -3702,17 +3707,15 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (depth) {
 		hlock = curr->held_locks + depth - 1;
 		if (hlock->class_idx == class_idx && nest_lock) {
-			if (hlock->references) {
-				/*
-				 * Check: unsigned int references overflow.
-				 */
-				if (DEBUG_LOCKS_WARN_ON(hlock->references == UINT_MAX))
-					return 0;
+			/*
+			 * Check: unsigned int references overflow.
+			 */
+			if (DEBUG_LOCKS_WARN_ON(hlock_reference(hlock->references) >
+						UINT_MAX - hlock_reference(references)))
+				return 0;
 
-				hlock->references++;
-			} else {
-				hlock->references = 2;
-			}
+			hlock->references = hlock_reference(hlock->references) +
+					    hlock_reference(references);
 
 			return 2;
 		}
-- 
2.17.1

