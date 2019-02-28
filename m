Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DCEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FAA721850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbfB1HFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:05:09 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35221 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731129AbfB1HFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:05:08 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S74dHr2938111
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:04:39 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S74dvu2938108;
        Wed, 27 Feb 2019 23:04:39 -0800
Date:   Wed, 27 Feb 2019 23:04:39 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-523b113bace5e64e860d8c61d7aa25057d274753@git.kernel.org>
Cc:     johannes@sipsolutions.net, longman@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        paulmck@linux.vnet.ibm.com, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        will.deacon@arm.com, akpm@linux-foundation.org, bvanassche@acm.org
Reply-To: bvanassche@acm.org, akpm@linux-foundation.org,
          will.deacon@arm.com, torvalds@linux-foundation.org,
          tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
          paulmck@linux.vnet.ibm.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, longman@redhat.com,
          johannes@sipsolutions.net
In-Reply-To: <20190214230058.196511-5-bvanassche@acm.org>
References: <20190214230058.196511-5-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Avoid that add_chain_cache()
 adds an invalid chain to the cache
Git-Commit-ID: 523b113bace5e64e860d8c61d7aa25057d274753
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

Commit-ID:  523b113bace5e64e860d8c61d7aa25057d274753
Gitweb:     https://git.kernel.org/tip/523b113bace5e64e860d8c61d7aa25057d274753
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 14 Feb 2019 15:00:39 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 28 Feb 2019 07:55:40 +0100

locking/lockdep: Avoid that add_chain_cache() adds an invalid chain to the cache

Make sure that add_chain_cache() returns 0 and does not modify the
chain hash if nr_chain_hlocks == MAX_LOCKDEP_CHAIN_HLOCKS before this
function is called.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: johannes.berg@intel.com
Cc: tj@kernel.org
Link: https://lkml.kernel.org/r/20190214230058.196511-5-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index ec6f6aff4d8d..21d84510e28f 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2195,16 +2195,8 @@ static inline int add_chain_cache(struct task_struct *curr,
 			chain_hlocks[chain->base + j] = lock_id;
 		}
 		chain_hlocks[chain->base + j] = class - lock_classes;
-	}
-
-	if (nr_chain_hlocks < MAX_LOCKDEP_CHAIN_HLOCKS)
 		nr_chain_hlocks += chain->depth;
-
-#ifdef CONFIG_DEBUG_LOCKDEP
-	/*
-	 * Important for check_no_collision().
-	 */
-	if (unlikely(nr_chain_hlocks > MAX_LOCKDEP_CHAIN_HLOCKS)) {
+	} else {
 		if (!debug_locks_off_graph_unlock())
 			return 0;
 
@@ -2212,7 +2204,6 @@ static inline int add_chain_cache(struct task_struct *curr,
 		dump_stack();
 		return 0;
 	}
-#endif
 
 	hlist_add_head_rcu(&chain->entry, hash_head);
 	debug_atomic_inc(chain_lookup_misses);
