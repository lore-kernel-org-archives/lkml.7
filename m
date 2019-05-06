Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425E3C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100462087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H64jLotM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfEFIUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:20:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45181 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEFIUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:20:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id i21so6078560pgi.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CRPjEac+QYCQoZbUsgWGH3RazQoBlxNvMhpXYV4UOw8=;
        b=H64jLotMAXbJousojWrPkdTGZeHLRgADu6RhEokos7TDjxyMJdUwVvVmODuybo1YuF
         rirLOA6fPjPFg6+jhW/mdPItp58A1mpe2Ap3C8bzN9ZWd8HdDeRLZ2AP59nKvv3+AipF
         JnIpA9tIzvlIsLHSftJC14xkLkbnxGl7y0oskzUI6Ei+0a/jMVc4ebCTM6HFTQU0P2Se
         3Q3A7Kb62MfdWwZSFuKhV79Cu6i9otu/VZOUSYE3EyiKNqxWdAfVoWIDD9cutvfl6T3W
         jp3Z7RDqhss0jF1/7Ml0YcHtl3BiVTf8pSZuBQ+xetcJMyUZuqW7BYNLpgfevD1MYx1m
         m+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CRPjEac+QYCQoZbUsgWGH3RazQoBlxNvMhpXYV4UOw8=;
        b=UccmvQN9HHEZkHL8J8EQG8pEZL2vJzTj2Lvfoy2hDhuQY7UaNQGJDINA6rzqjaF9Zo
         UiwjIFDyyoKY6GN5XPSwFmzgUic5YVDBy7aSEJDveHxNqndmnP1hqTZGiRIRDWy8lpKh
         ztwXC92NVr8SZugeHaMeJ77btQVfe/9qfMK6jrQumXRNjIZFdRgV5Uy4CvntaUeTpf3f
         SLAK6SCJqv9ra7tggqT3zJL+4IEGpxZzrfkBEC3JIFlVNIn/F6U0jgIump/PCaGmHFTe
         PANucP1kkdyljHBQLmXynv/1tqIRNdP6I7T4Rklx+zZyP1XNXmjN2ixmvRqOrU0FroOa
         qXBw==
X-Gm-Message-State: APjAAAXxJMTKrbi3KBvw32BVvjNJT3xJigIZo6Cw/cmBepECJ7PSHeOI
        sz00T0NiYL3x9I3gVNbFYwg=
X-Google-Smtp-Source: APXvYqwphiqi89V559FqYDX5N1vD1ushi5gZEA/kxh37AYrPjpdDqUivExLp4kTADfbGhwXmRSMs1w==
X-Received: by 2002:a63:2118:: with SMTP id h24mr30833868pgh.320.1557130814984;
        Mon, 06 May 2019 01:20:14 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm20958013pfa.138.2019.05.06.01.20.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 01:20:14 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 08/23] locking/lockdep: Define INITIAL_CHAIN_KEY for chain keys to start with
Date:   Mon,  6 May 2019 16:19:24 +0800
Message-Id: <20190506081939.74287-9-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190506081939.74287-1-duyuyang@gmail.com>
References: <20190506081939.74287-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chain keys are computed using Jenkins hash function, which needs an initial
hash to start with. Dedicate a macro to make this clear and configurable. A
later patch changes this initial chain key.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h  |  1 +
 init/init_task.c         |  2 +-
 kernel/locking/lockdep.c | 18 +++++++++---------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 751a2cc..bb47d7c 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -229,6 +229,7 @@ struct lock_chain {
  * bitfield and hitting the BUG in hlock_class().
  */
 #define MAX_LOCKDEP_KEYS		((1UL << MAX_LOCKDEP_KEYS_BITS) - 1)
+#define INITIAL_CHAIN_KEY		0
 
 struct held_lock {
 	/*
diff --git a/init/init_task.c b/init/init_task.c
index 1b15cb9..afa6ad7 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -167,7 +167,7 @@ struct task_struct init_task
 #endif
 #ifdef CONFIG_LOCKDEP
 	.lockdep_depth = 0, /* no locks held yet */
-	.curr_chain_key = 0,
+	.curr_chain_key = INITIAL_CHAIN_KEY,
 	.lockdep_recursion = 0,
 #endif
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index f02f7dc..7d16fcc 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -361,7 +361,7 @@ static inline u64 iterate_chain_key(u64 key, u32 idx)
 inline void lockdep_init_task(struct task_struct *task)
 {
 	task->lockdep_depth = 0; /* no locks held yet */
-	task->curr_chain_key = 0;
+	task->curr_chain_key = INITIAL_CHAIN_KEY;
 	task->lockdep_recursion = 0;
 }
 
@@ -852,7 +852,7 @@ static bool class_lock_list_valid(struct lock_class *c, struct list_head *h)
 static bool check_lock_chain_key(struct lock_chain *chain)
 {
 #ifdef CONFIG_PROVE_LOCKING
-	u64 chain_key = 0;
+	u64 chain_key = INITIAL_CHAIN_KEY;
 	int i;
 
 	for (i = chain->base; i < chain->base + chain->depth; i++)
@@ -2519,7 +2519,7 @@ static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
 print_chain_keys_held_locks(struct task_struct *curr, struct held_lock *hlock_next)
 {
 	struct held_lock *hlock;
-	u64 chain_key = 0;
+	u64 chain_key = INITIAL_CHAIN_KEY;
 	int depth = curr->lockdep_depth;
 	int i = get_first_held_lock(curr, hlock_next);
 
@@ -2539,7 +2539,7 @@ static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
 static void print_chain_keys_chain(struct lock_chain *chain)
 {
 	int i;
-	u64 chain_key = 0;
+	u64 chain_key = INITIAL_CHAIN_KEY;
 	int class_id;
 
 	printk("depth: %u\n", chain->depth);
@@ -2847,7 +2847,7 @@ static void check_chain_key(struct task_struct *curr)
 #ifdef CONFIG_DEBUG_LOCKDEP
 	struct held_lock *hlock, *prev_hlock = NULL;
 	unsigned int i;
-	u64 chain_key = 0;
+	u64 chain_key = INITIAL_CHAIN_KEY;
 
 	for (i = 0; i < curr->lockdep_depth; i++) {
 		hlock = curr->held_locks + i;
@@ -2871,7 +2871,7 @@ static void check_chain_key(struct task_struct *curr)
 
 		if (prev_hlock && (prev_hlock->irq_context !=
 							hlock->irq_context))
-			chain_key = 0;
+			chain_key = INITIAL_CHAIN_KEY;
 		chain_key = iterate_chain_key(chain_key, hlock->class_idx);
 		prev_hlock = hlock;
 	}
@@ -3786,14 +3786,14 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		/*
 		 * How can we have a chain hash when we ain't got no keys?!
 		 */
-		if (DEBUG_LOCKS_WARN_ON(chain_key != 0))
+		if (DEBUG_LOCKS_WARN_ON(chain_key != INITIAL_CHAIN_KEY))
 			return 0;
 		chain_head = 1;
 	}
 
 	hlock->prev_chain_key = chain_key;
 	if (separate_irq_context(curr, hlock)) {
-		chain_key = 0;
+		chain_key = INITIAL_CHAIN_KEY;
 		chain_head = 1;
 	}
 	chain_key = iterate_chain_key(chain_key, class_idx);
@@ -4635,7 +4635,7 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 	return;
 
 recalc:
-	chain_key = 0;
+	chain_key = INITIAL_CHAIN_KEY;
 	for (i = chain->base; i < chain->base + chain->depth; i++)
 		chain_key = iterate_chain_key(chain_key, chain_hlocks[i] + 1);
 	if (chain->depth && chain->chain_key == chain_key)
-- 
1.8.3.1

