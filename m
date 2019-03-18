Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D5DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F862082F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SesPiTyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfCRI6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:58:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37918 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfCRI6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:58:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id v1so6209596pgi.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 01:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DNEVrH2qIEuUmlHT4Wso2jW0WNqej54O6KK/lklqNUc=;
        b=SesPiTyvQM0EvDgxWe8I8CfDcPzWtYp8V50wxN5+GjnoAjKwWq4VAXyiiLRUV1MXMz
         OX92PEHS375gTEbHXqcx0NZCP0A4WFGpMR+7czwN8DuJmrlZq7U9nm+XVStzAU84JQ3w
         ARKDxm2mp7vgS7k0s2AJuHw0g9TdcT1drYMlw0fn+SSg2Bpu//wZoCnxjlffUlJpC10o
         WgO+oY1Kkf+4othr079LNwI9V9DHtQ00Iwf/BeDt8oDI08ZPLHMIThQUjhZYzQJ8zlSV
         zP7H4MnTBgWcaigWWQcc5WSSLxWfqUYl2QUN9YAOVRdd8aMAF0782AR9+GWG4ilHS5VI
         beCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DNEVrH2qIEuUmlHT4Wso2jW0WNqej54O6KK/lklqNUc=;
        b=qxy3YAYg0eXXYqe6tONtD1ClflrTxYvTzgzcjS3/JaJTxTZXUGcCFgxf4Blf6J4BIn
         HWnuzyOEMHOiFtJTcEQtzcSMq3trg1Robn5ZGKeN/luq+rKDXUtjdgioZFxPp9hVaN4f
         o/nr+Asjd3qB0Zv4BM7J8H+KVcdjkOGxf8wsebpnL/gWrkV6dBWvVxaERya4k78ncZUz
         qYcFF5VAPxIBxJsqGY5Zv1fUjSiJIMTo3rIRbfKQR4XS+lx/pIbVWI26VzuRUQxW26zX
         geJIdAG6lVpekf4T/8jAsvpAThU0ehEqMsWGFnABNtrruZmLKam1RoUgDgXGAVwB02y0
         5skA==
X-Gm-Message-State: APjAAAWaLl+wyV2PCQzIs45NUo/zXc2n7e+OReydAGrgm1xDXsiHEVA4
        C1PaCrABsSfD2S3l+wMRSaY=
X-Google-Smtp-Source: APXvYqw1E0o8QqyH8+IEttiemurxGDPBcdPxTgQNjoHSS/C6nYOUj58HXm/gOisj4Y2qrRAjeoSxOw==
X-Received: by 2002:a17:902:7896:: with SMTP id q22mr18873448pll.66.1552899488830;
        Mon, 18 Mar 2019 01:58:08 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id k8sm11147024pgq.37.2019.03.18.01.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 01:58:08 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 09/19] locking/lockdep: Define INITIAL_CHAIN_KEY for chain keys to start with
Date:   Mon, 18 Mar 2019 16:57:23 +0800
Message-Id: <20190318085733.3143-10-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190318085733.3143-1-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
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
index 49b928f..dd8cf33 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -222,6 +222,7 @@ struct lock_chain {
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
index 737fe0a..5459d37 100644
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
@@ -2430,7 +2430,7 @@ static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
 print_chain_keys_held_locks(struct task_struct *curr, struct held_lock *hlock_next)
 {
 	struct held_lock *hlock;
-	u64 chain_key = 0;
+	u64 chain_key = INITIAL_CHAIN_KEY;
 	int depth = curr->lockdep_depth;
 	int i = get_first_held_lock(curr, hlock_next);
 
@@ -2450,7 +2450,7 @@ static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
 static void print_chain_keys_chain(struct lock_chain *chain)
 {
 	int i;
-	u64 chain_key = 0;
+	u64 chain_key = INITIAL_CHAIN_KEY;
 	int class_id;
 
 	printk("depth: %u\n", chain->depth);
@@ -2754,7 +2754,7 @@ static void check_chain_key(struct task_struct *curr)
 #ifdef CONFIG_DEBUG_LOCKDEP
 	struct held_lock *hlock, *prev_hlock = NULL;
 	unsigned int i;
-	u64 chain_key = 0;
+	u64 chain_key = INITIAL_CHAIN_KEY;
 
 	for (i = 0; i < curr->lockdep_depth; i++) {
 		hlock = curr->held_locks + i;
@@ -2778,7 +2778,7 @@ static void check_chain_key(struct task_struct *curr)
 
 		if (prev_hlock && (prev_hlock->irq_context !=
 							hlock->irq_context))
-			chain_key = 0;
+			chain_key = INITIAL_CHAIN_KEY;
 		chain_key = iterate_chain_key(chain_key, hlock->class_idx);
 		prev_hlock = hlock;
 	}
@@ -3691,14 +3691,14 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
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
@@ -4539,7 +4539,7 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 	return;
 
 recalc:
-	chain_key = 0;
+	chain_key = INITIAL_CHAIN_KEY;
 	for (i = chain->base; i < chain->base + chain->depth; i++)
 		chain_key = iterate_chain_key(chain_key, chain_hlocks[i] + 1);
 	if (chain->depth && chain->chain_key == chain_key)
-- 
1.8.3.1

