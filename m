Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB3DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81B9218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxJGVriY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfCUH6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:58:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34981 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbfCUH56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 03:57:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id t21so3036204pfe.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 00:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gddGIs+Ptm+HnR6q5I4pJ5I5ClRxXb5o/V70RK6sM6s=;
        b=qxJGVriY6g6Tl/DFWm6OyulCaftQdogoSc67v0KLncSK2/HcMRNUoF8rFbo34QB/HI
         aUO/o5T0K/VavS8dlKXOMazIkgzOb5zlIWKCSWwdwrZ6O6DPcyL0u5CdwY2F3Bn5tfVc
         GlEzr8U+z4Y1ZSkooqBnlRA24mLrBKYFIEcaTDl4OGP7Ce2mSZXr92Q6jssM8rORgDpm
         XgeOkr1q4tlRZ3Wv8UL3t1R/g6QNtCGOxYsvYWZfohtu+adGUGDullK2qgHbg14Q01ko
         418DONmiJQtmtJelf+HCnYxAWfsLUSgPKuFCXfI41cM35DUbW2RzETKVzAXZ43X2SRTG
         ouVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gddGIs+Ptm+HnR6q5I4pJ5I5ClRxXb5o/V70RK6sM6s=;
        b=IfOw3wJvKnGkCaR47HvagQgXmZukqL4XiqoyU+Kd9GYmdlHiQMXhyGgVFjMIg5rVlr
         6FJHpR9vIOrlqdMN8Ono+qJRsHPW5W7QLVYdl3tSiF+45CD8RANGts+A/kkwKxJG9yf6
         L4ZbvQJRnl7M9+9D+p3NJp8sLmDANlAA9rspfmtS1zICd82XRvTx9LXImrqAcL172Zqc
         sqMS02Apie/TrXP/VyKW465sXIiTCcmWmwD2S98pd39pGy/ep1YUg1E4D1ndcA8W2u0r
         TYmUYLvDMJOpAXMrUigI3Tw8YwZLyetRyQdhJOG4aWp/f+eJ6MDxH8b83bVt2C9TYzXR
         X+WQ==
X-Gm-Message-State: APjAAAVNW8Lzl8F6VCweiVhDFRx0GL6h1UNVAV1WxMKSiaQO4x+GDA/o
        PcEneRbShWV5FQg7u4NvUOo=
X-Google-Smtp-Source: APXvYqx5YLDXJMj7eCbmpsSId70+SA1xBYPkdi6x/opgOBdYnBmlT2DgRBg52k0tG9s7Gt+g/ph9Cg==
X-Received: by 2002:a63:1960:: with SMTP id 32mr2094041pgz.171.1553155077098;
        Thu, 21 Mar 2019 00:57:57 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id e184sm6467148pfc.143.2019.03.21.00.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 00:57:56 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, joe@perches.com,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 08/18] locking/lockdep: Define INITIAL_CHAIN_KEY for chain keys to start with
Date:   Thu, 21 Mar 2019 15:57:15 +0800
Message-Id: <20190321075725.14054-9-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190321075725.14054-1-duyuyang@gmail.com>
References: <20190321075725.14054-1-duyuyang@gmail.com>
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
index 267087e..64d4565 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -224,6 +224,7 @@ struct lock_chain {
  * bitfield and hitting the BUG in hlock_class().
  */
 #define MAX_LOCKDEP_KEYS		((1UL << MAX_LOCKDEP_KEYS_BITS) - 1)
+#define INITIAL_CHAIN_KEY		0
 
 struct held_lock {
 	/*
diff --git a/init/init_task.c b/init/init_task.c
index 9460878..ff3e8bf 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -166,7 +166,7 @@ struct task_struct init_task
 #endif
 #ifdef CONFIG_LOCKDEP
 	.lockdep_depth = 0, /* no locks held yet */
-	.curr_chain_key = 0,
+	.curr_chain_key = INITIAL_CHAIN_KEY,
 	.lockdep_recursion = 0,
 #endif
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index ef59651..c6363f7 100644
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
 
@@ -867,7 +867,7 @@ static bool class_lock_list_valid(struct lock_class *c, struct list_head *h)
 static bool check_lock_chain_key(struct lock_chain *chain)
 {
 #ifdef CONFIG_PROVE_LOCKING
-	u64 chain_key = 0;
+	u64 chain_key = INITIAL_CHAIN_KEY;
 	int i;
 
 	for (i = chain->base; i < chain->base + chain->depth; i++)
@@ -2433,7 +2433,7 @@ static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
 print_chain_keys_held_locks(struct task_struct *curr, struct held_lock *hlock_next)
 {
 	struct held_lock *hlock;
-	u64 chain_key = 0;
+	u64 chain_key = INITIAL_CHAIN_KEY;
 	int depth = curr->lockdep_depth;
 	int i = get_first_held_lock(curr, hlock_next);
 
@@ -2453,7 +2453,7 @@ static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
 static void print_chain_keys_chain(struct lock_chain *chain)
 {
 	int i;
-	u64 chain_key = 0;
+	u64 chain_key = INITIAL_CHAIN_KEY;
 	int class_id;
 
 	printk("depth: %u\n", chain->depth);
@@ -2757,7 +2757,7 @@ static void check_chain_key(struct task_struct *curr)
 #ifdef CONFIG_DEBUG_LOCKDEP
 	struct held_lock *hlock, *prev_hlock = NULL;
 	unsigned int i;
-	u64 chain_key = 0;
+	u64 chain_key = INITIAL_CHAIN_KEY;
 
 	for (i = 0; i < curr->lockdep_depth; i++) {
 		hlock = curr->held_locks + i;
@@ -2781,7 +2781,7 @@ static void check_chain_key(struct task_struct *curr)
 
 		if (prev_hlock && (prev_hlock->irq_context !=
 							hlock->irq_context))
-			chain_key = 0;
+			chain_key = INITIAL_CHAIN_KEY;
 		chain_key = iterate_chain_key(chain_key, hlock->class_idx);
 		prev_hlock = hlock;
 	}
@@ -3694,14 +3694,14 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
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
@@ -4543,7 +4543,7 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 	return;
 
 recalc:
-	chain_key = 0;
+	chain_key = INITIAL_CHAIN_KEY;
 	for (i = chain->base; i < chain->base + chain->depth; i++)
 		chain_key = iterate_chain_key(chain_key, chain_hlocks[i] + 1);
 	if (chain->depth && chain->chain_key == chain_key)
-- 
1.8.3.1

