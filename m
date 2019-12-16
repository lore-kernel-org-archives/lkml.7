Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9521C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9B220409
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkHslhAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfLPPQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:16:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53790 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728339AbfLPPPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576509347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=X56v5hcsGqrOwqxcdWrkMsH5U0zPTWotNG6kQIoO2+w=;
        b=dkHslhARZa6RrcuJsFetaWKRmi/C2z4wyodsutN0iMaqKVCNADSNfEf9Va+F+wU4wCzHsT
        arxEU+yJP3T3jdHHb4FU9TFBaEdZ0JFAOp1j4LzAHk9To4cTkzITSOAyuMe2m31nTGc8nl
        xLCWDNqGXIMsuY2hBddxPjV/gph7QEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111--376s6SGNYSDSGtPlG0c5w-1; Mon, 16 Dec 2019 10:15:43 -0500
X-MC-Unique: -376s6SGNYSDSGtPlG0c5w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F873107ACCA;
        Mon, 16 Dec 2019 15:15:42 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA3D560BF4;
        Mon, 16 Dec 2019 15:15:41 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 2/6] locking/lockdep: Throw away all lock chains with zapped class
Date:   Mon, 16 Dec 2019 10:15:13 -0500
Message-Id: <20191216151517.7060-3-longman@redhat.com>
In-Reply-To: <20191216151517.7060-1-longman@redhat.com>
References: <20191216151517.7060-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a lock chain contains a class that is zapped, the whole lock chain is
now invalid. There is no point in keeping a partial chain behind hoping
it can be useful. So just dump the corresponding chain_hlocks entries for
now. A latter patch will try to reuse the freed chain_hlocks entries.

This patch also changes the type of nr_chain_hlocks to unsigned integer
to be consistent with the other counters.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c           | 36 ++++--------------------------
 kernel/locking/lockdep_internals.h |  4 ++--
 kernel/locking/lockdep_proc.c      |  2 +-
 3 files changed, 7 insertions(+), 35 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c8d0374101b0..30ebfe4978d5 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2624,8 +2624,8 @@ check_prevs_add(struct task_struct *curr, struct held_lock *next)
 
 struct lock_chain lock_chains[MAX_LOCKDEP_CHAINS];
 static DECLARE_BITMAP(lock_chains_in_use, MAX_LOCKDEP_CHAINS);
-int nr_chain_hlocks;
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
+unsigned int nr_chain_hlocks;
 
 struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i)
 {
@@ -4770,57 +4770,29 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 					 struct lock_class *class)
 {
 #ifdef CONFIG_PROVE_LOCKING
-	struct lock_chain *new_chain;
-	u64 chain_key;
 	int i;
 
 	for (i = chain->base; i < chain->base + chain->depth; i++) {
 		if (chain_hlocks[i] != class - lock_classes)
 			continue;
-		/* The code below leaks one chain_hlock[] entry. */
-		if (--chain->depth > 0) {
-			memmove(&chain_hlocks[i], &chain_hlocks[i + 1],
-				(chain->base + chain->depth - i) *
-				sizeof(chain_hlocks[0]));
-		}
 		/*
 		 * Each lock class occurs at most once in a lock chain so once
 		 * we found a match we can break out of this loop.
 		 */
-		goto recalc;
+		goto free_lock_chain;
 	}
 	/* Since the chain has not been modified, return. */
 	return;
 
-recalc:
-	chain_key = INITIAL_CHAIN_KEY;
-	for (i = chain->base; i < chain->base + chain->depth; i++)
-		chain_key = iterate_chain_key(chain_key, chain_hlocks[i]);
-	if (chain->depth && chain->chain_key == chain_key)
-		return;
+free_lock_chain:
 	/* Overwrite the chain key for concurrent RCU readers. */
-	WRITE_ONCE(chain->chain_key, chain_key);
+	WRITE_ONCE(chain->chain_key, INITIAL_CHAIN_KEY);
 	/*
 	 * Note: calling hlist_del_rcu() from inside a
 	 * hlist_for_each_entry_rcu() loop is safe.
 	 */
 	hlist_del_rcu(&chain->entry);
 	__set_bit(chain - lock_chains, pf->lock_chains_being_freed);
-	if (chain->depth == 0)
-		return;
-	/*
-	 * If the modified lock chain matches an existing lock chain, drop
-	 * the modified lock chain.
-	 */
-	if (lookup_chain_cache(chain_key))
-		return;
-	new_chain = alloc_lock_chain();
-	if (WARN_ON_ONCE(!new_chain)) {
-		debug_locks_off();
-		return;
-	}
-	*new_chain = *chain;
-	hlist_add_head_rcu(&new_chain->entry, chainhashentry(chain_key));
 #endif
 }
 
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index a31d16fd3c43..5dec0fe12507 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -128,14 +128,14 @@ extern unsigned long nr_zapped_classes;
 extern unsigned long nr_list_entries;
 long lockdep_next_lockchain(long i);
 unsigned long lock_chain_count(void);
-extern int nr_chain_hlocks;
 extern unsigned long nr_stack_trace_entries;
 
 extern unsigned int nr_hardirq_chains;
 extern unsigned int nr_softirq_chains;
 extern unsigned int nr_process_chains;
-extern unsigned int max_lockdep_depth;
+extern unsigned int nr_chain_hlocks;
 
+extern unsigned int max_lockdep_depth;
 extern unsigned int max_bfs_queue_depth;
 
 #ifdef CONFIG_PROVE_LOCKING
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index d98d349bb648..4c7dc0a8935d 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -271,7 +271,7 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 #ifdef CONFIG_PROVE_LOCKING
 	seq_printf(m, " dependency chains:             %11lu [max: %lu]\n",
 			lock_chain_count(), MAX_LOCKDEP_CHAINS);
-	seq_printf(m, " dependency chain hlocks:       %11d [max: %lu]\n",
+	seq_printf(m, " dependency chain hlocks:       %11u [max: %lu]\n",
 			nr_chain_hlocks, MAX_LOCKDEP_CHAIN_HLOCKS);
 #endif
 
-- 
2.18.1

