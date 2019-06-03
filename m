Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C169C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B39725C0B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fcHr2hRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfFCNVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:21:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44251 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfFCNVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:21:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DLeso607066
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:21:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DLeso607066
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559568100;
        bh=RN2wDhoFLq6ABqLxgEME/VQcliZo+R93w8KdtFHEgTo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=fcHr2hRTwMOaX1y+aJr3L3AP6c+MX52XBxnjU+Jjw2xgSUzPPpTXh2fpwUHfkSGM5
         9fUx7fCKO8u32nMgVZsjYuBW1T4wvnPhOExFQG2OwFuydRMGVqpJXCavtbohHVGO5g
         SmkOxRVR+/uielN8iiNDy7aCY/ln9IHwpAhjDGKmcr7LAkZTyU7UnNj38M42MdYbeb
         WWtf3L1zyaohpfFzh02Xs3cbbuNN9eVwQDDafsccI/AiVqLLu3m/vK5jpWvueNU0Pr
         0P1gloB5rzpqqv8uFLTTI2lMR15Inf/Yb12Tf2PVSu4KvffVkbvgBhNCORSOYefFjc
         JUviDy11Y/MRQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DLedE607063;
        Mon, 3 Jun 2019 06:21:40 -0700
Date:   Mon, 3 Jun 2019 06:21:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yuyang Du <tipbot@zytor.com>
Message-ID: <tip-4d56330df22dd9dd9a24f147014f60ee4c914fb8@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, duyuyang@gmail.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, torvalds@linux-foundation.org,
          peterz@infradead.org, duyuyang@gmail.com
In-Reply-To: <20190506081939.74287-23-duyuyang@gmail.com>
References: <20190506081939.74287-23-duyuyang@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Adjust new bit cases in
 mark_lock
Git-Commit-ID: 4d56330df22dd9dd9a24f147014f60ee4c914fb8
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

Commit-ID:  4d56330df22dd9dd9a24f147014f60ee4c914fb8
Gitweb:     https://git.kernel.org/tip/4d56330df22dd9dd9a24f147014f60ee4c914fb8
Author:     Yuyang Du <duyuyang@gmail.com>
AuthorDate: Mon, 6 May 2019 16:19:38 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:55:52 +0200

locking/lockdep: Adjust new bit cases in mark_lock

The new bit can be any possible lock usage except it is garbage, so the
cases in switch can be made simpler. Warn early on if wrong usage bit is
passed without taking locks. No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bvanassche@acm.org
Cc: frederic@kernel.org
Cc: ming.lei@redhat.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190506081939.74287-23-duyuyang@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 1123e7e6c78d..9c4e2a7547d3 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3582,6 +3582,11 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 {
 	unsigned int new_mask = 1 << new_bit, ret = 1;
 
+	if (new_bit >= LOCK_USAGE_STATES) {
+		DEBUG_LOCKS_WARN_ON(1);
+		return 0;
+	}
+
 	/*
 	 * If already set then do not dirty the cacheline,
 	 * nor do any checks:
@@ -3605,25 +3610,13 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 		return 0;
 
 	switch (new_bit) {
-#define LOCKDEP_STATE(__STATE)			\
-	case LOCK_USED_IN_##__STATE:		\
-	case LOCK_USED_IN_##__STATE##_READ:	\
-	case LOCK_ENABLED_##__STATE:		\
-	case LOCK_ENABLED_##__STATE##_READ:
-#include "lockdep_states.h"
-#undef LOCKDEP_STATE
-		ret = mark_lock_irq(curr, this, new_bit);
-		if (!ret)
-			return 0;
-		break;
 	case LOCK_USED:
 		debug_atomic_dec(nr_unused_locks);
 		break;
 	default:
-		if (!debug_locks_off_graph_unlock())
+		ret = mark_lock_irq(curr, this, new_bit);
+		if (!ret)
 			return 0;
-		WARN_ON(1);
-		return 0;
 	}
 
 	graph_unlock();
