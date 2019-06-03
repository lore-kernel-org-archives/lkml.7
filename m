Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725E1C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3632424C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fkH2NLuw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfFCNd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:33:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52187 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfFCNdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:33:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DWePk610284
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:32:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DWePk610284
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559568760;
        bh=ID8SlhOGBycPVkbfjZfaePx7z0JmaA3ySYrLVCv5h2Q=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=fkH2NLuwU01jM0tcIBcioloY5DcwROmwbK2vvygTb38iInQhaOI+g/rexV5IbTDKV
         nV9hXeJ3SE/vfPcfBuTtx6RwUsSPK4y9w4PSYKDn1KdVC3/L/+P95nG0IfSlrrCKu5
         +3b0qtlGxjM4NOxT58Kz3PgJPfwWP+gvGiEJKUJtEJ0hxqnyGewoUCXpgbUNbynav0
         WZSqHwpbnS78fVFWgqltt3oB3DMW8pWWePTpCAxg5zrYX4LDUUCkyAXVF7pVHzGF90
         1J/DDsvLqKEmh6wR+Hcut1+o5XcagCA8+mb3R0ur7YAbXyFMAdeU6EK/21SjtNrOh2
         tIYLhBxFzyIzQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DWdYY610281;
        Mon, 3 Jun 2019 06:32:39 -0700
Date:   Mon, 3 Jun 2019 06:32:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Imre Deak <tipbot@zytor.com>
Message-ID: <tip-d9349850e188b8b59e5322fda17ff389a1c0cd7d@git.kernel.org>
Cc:     tglx@linutronix.de, torvalds@linux-foundation.org,
        will.deacon@arm.com, ville.syrjala@linux.intel.com,
        mingo@kernel.org, hpa@zytor.com, imre.deak@intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Reply-To: torvalds@linux-foundation.org, tglx@linutronix.de,
          will.deacon@arm.com, mingo@kernel.org,
          ville.syrjala@linux.intel.com, linux-kernel@vger.kernel.org,
          imre.deak@intel.com, hpa@zytor.com, peterz@infradead.org
In-Reply-To: <20190524201509.9199-2-imre.deak@intel.com>
References: <20190524201509.9199-2-imre.deak@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Fix merging of hlocks with
 non-zero references
Git-Commit-ID: d9349850e188b8b59e5322fda17ff389a1c0cd7d
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

Commit-ID:  d9349850e188b8b59e5322fda17ff389a1c0cd7d
Gitweb:     https://git.kernel.org/tip/d9349850e188b8b59e5322fda17ff389a1c0cd7d
Author:     Imre Deak <imre.deak@intel.com>
AuthorDate: Fri, 24 May 2019 23:15:09 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 12:32:56 +0200

locking/lockdep: Fix merging of hlocks with non-zero references

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

	ww_mutex_lock(&ww_lock_a, &ww_ctx);

	mutex_lock(&lock_c);

	ww_mutex_lock(&ww_lock_b, &ww_ctx);
	ww_mutex_lock(&ww_lock_c, &ww_ctx);

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
merge into another hlock or for the hlock we are merging into).

Signed-off-by: Imre Deak <imre.deak@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/r/20190524201509.9199-2-imre.deak@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 6c97f67ec321..48a840adb281 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3796,17 +3796,17 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (depth) {
 		hlock = curr->held_locks + depth - 1;
 		if (hlock->class_idx == class_idx && nest_lock) {
-			if (hlock->references) {
-				/*
-				 * Check: unsigned int references:12, overflow.
-				 */
-				if (DEBUG_LOCKS_WARN_ON(hlock->references == (1 << 12)-1))
-					return 0;
+			if (!references)
+				references++;
 
+			if (!hlock->references)
 				hlock->references++;
-			} else {
-				hlock->references = 2;
-			}
+
+			hlock->references += references;
+
+			/* Overflow */
+			if (DEBUG_LOCKS_WARN_ON(hlock->references < references))
+				return 0;
 
 			return 2;
 		}
