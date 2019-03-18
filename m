Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6BEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEF22082F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uo25g4gE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfCRI6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:58:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37773 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfCRI56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:57:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id q206so10920431pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 01:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k8zTvxN+hP6jOUfAi1cELVLtcKNt2ez1O3ztkU6CQhY=;
        b=Uo25g4gEM+oDEUCCmIlbjt3cnIEVY1ntdo81ymMEHuV1TPUg9PV+BC4baKwxMO7INg
         cPRd5WOfhL7uxCytE2JAMEfVokW5iq8DTAdtq71Jf7I4ZXWFhUSZi5XkefnxUqoyJy3I
         yZVb5AxVWYqggQJg58rF4AvyFZaCVI8yHrn3guJTVzRVt2LKSOJlLpBNHnvfufFfULpo
         QNB//rdzovfJgC33XeX3uc/qCfKzl7XwEF5gsA/oZQESx4e6c4UWxfEtv35YKBVyN48l
         +ZbPUqhGUOE2snEiww9PpZmcXptATtCBOFqQ7uiWYeMT8q4ySjY776Ghj31LUqnJfFVp
         UCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k8zTvxN+hP6jOUfAi1cELVLtcKNt2ez1O3ztkU6CQhY=;
        b=DsZ03D+ptQRmDMNMzFeXryTz7jooYWAimIOMQEMUiJIklMOvqxxaSsWkTIZ40rwZJ7
         zu4kWUouKebDkr8MfLv+PmrQPz+3UhO2FBMxOcAf+GvGjIrx03nnD8X7LzKLFzYjHkYg
         sQWQI1sYSshzqNhMtRAIFK2HByDiTg67FOgRD/MiFKogyxeKx2bzTUOwL6v7j94RR3oR
         7B9Dp2lFnuUBo+SNpSV1yvFQMcCylw2AL5U6EHYmALyXumi/56OR59fYk9nX4kFC9TM5
         Vs5i7DzUzPJ7p2QaSCwCmgFprcBos/HBV0OC2qh6efMyxePAnLOlutkc2HWKRVHa4unR
         tVrg==
X-Gm-Message-State: APjAAAUnOkDfb7T3f5ThsaCn2fQaSKcCbd/H0HrzMdEmxgBYSzczFkeL
        0iqGqhZmvRENvzoOAfj4l/M=
X-Google-Smtp-Source: APXvYqwFoEZj/u9U7My3pChXvbgKn+yHHDi9R2EQ/F3wonodhRk0Dt33iX4oFzGOyq3IEgxXsyrIaQ==
X-Received: by 2002:a17:902:2aca:: with SMTP id j68mr18169231plb.233.1552899477549;
        Mon, 18 Mar 2019 01:57:57 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id k8sm11147024pgq.37.2019.03.18.01.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 01:57:57 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 05/19] locking/lockdep: Adjust indents for function definitions
Date:   Mon, 18 Mar 2019 16:57:19 +0800
Message-Id: <20190318085733.3143-6-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190318085733.3143-1-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Being paranoid to see function arguments lines are aligned.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 63 +++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index dea495b..320ab62 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1308,7 +1308,7 @@ static inline unsigned int  __cq_get_elem_count(struct circular_queue *cq)
 }
 
 static inline void mark_lock_accessed(struct lock_list *lock,
-					struct lock_list *parent)
+				      struct lock_list *parent)
 {
 	unsigned long nr;
 
@@ -1413,19 +1413,17 @@ static int __bfs(struct lock_list *source_entry,
 	return ret;
 }
 
-static inline int __bfs_forwards(struct lock_list *src_entry,
-			void *data,
-			int (*match)(struct lock_list *entry, void *data),
-			struct lock_list **target_entry)
+static inline int __bfs_forwards(struct lock_list *src_entry, void *data,
+				 int (*match)(struct lock_list *entry, void *data),
+				 struct lock_list **target_entry)
 {
 	return __bfs(src_entry, data, match, target_entry, 1);
 
 }
 
-static inline int __bfs_backwards(struct lock_list *src_entry,
-			void *data,
-			int (*match)(struct lock_list *entry, void *data),
-			struct lock_list **target_entry)
+static inline int __bfs_backwards(struct lock_list *src_entry, void *data,
+				  int (*match)(struct lock_list *entry, void *data),
+				  struct lock_list **target_entry)
 {
 	return __bfs(src_entry, data, match, target_entry, 0);
 
@@ -1507,8 +1505,8 @@ static void print_circular_lock_scenario(struct held_lock *src,
  */
 static noinline void
 print_circular_bug_header(struct lock_list *entry, unsigned int depth,
-			struct held_lock *check_src,
-			struct held_lock *check_tgt)
+			  struct held_lock *check_src,
+			  struct held_lock *check_tgt)
 {
 	struct task_struct *curr = current;
 
@@ -1653,7 +1651,7 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
  */
 static noinline int
 check_noncircular(struct lock_list *root, struct lock_class *target,
-		struct lock_list **target_entry)
+		  struct lock_list **target_entry)
 {
 	int result;
 
@@ -1703,7 +1701,7 @@ static inline int usage_match(struct lock_list *entry, void *bit)
  */
 static int
 find_usage_forwards(struct lock_list *root, enum lock_usage_bit bit,
-			struct lock_list **target_entry)
+		    struct lock_list **target_entry)
 {
 	int result;
 
@@ -1726,7 +1724,7 @@ static inline int usage_match(struct lock_list *entry, void *bit)
  */
 static int
 find_usage_backwards(struct lock_list *root, enum lock_usage_bit bit,
-			struct lock_list **target_entry)
+		     struct lock_list **target_entry)
 {
 	int result;
 
@@ -2018,7 +2016,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 
 static int
 check_prev_add_irq(struct task_struct *curr, struct held_lock *prev,
-		struct held_lock *next)
+		   struct held_lock *next)
 {
 #define LOCKDEP_STATE(__STATE)						\
 	if (!check_irq_usage(curr, prev, next, LOCK_USED_IN_##__STATE))	\
@@ -2392,7 +2390,7 @@ struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i)
  * Returns the index of the first held_lock of the current chain
  */
 static inline int get_first_held_lock(struct task_struct *curr,
-					struct held_lock *hlock)
+				      struct held_lock *hlock)
 {
 	int i;
 	struct held_lock *hlock_curr;
@@ -2487,8 +2485,8 @@ static void print_collision(struct task_struct *curr,
  * Returns: 0 not passed, 1 passed
  */
 static int check_no_collision(struct task_struct *curr,
-			struct held_lock *hlock,
-			struct lock_chain *chain)
+			      struct held_lock *hlock,
+			      struct lock_chain *chain)
 {
 #ifdef CONFIG_DEBUG_LOCKDEP
 	int i, j, id;
@@ -2675,7 +2673,7 @@ static inline int lookup_chain_cache_add(struct task_struct *curr,
 }
 
 static int validate_chain(struct task_struct *curr, struct lockdep_map *lock,
-		struct held_lock *hlock, int chain_head, u64 chain_key)
+			  struct held_lock *hlock, int chain_head, u64 chain_key)
 {
 	/*
 	 * Trylock needs to maintain the stack of held locks, but it
@@ -3032,7 +3030,7 @@ typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
 
 static int
 mark_lock_irq(struct task_struct *curr, struct held_lock *this,
-		enum lock_usage_bit new_bit)
+	      enum lock_usage_bit new_bit)
 {
 	int excl_bit = exclusive_bit(new_bit);
 	int read = new_bit & LOCK_USAGE_READ_MASK;
@@ -3060,7 +3058,7 @@ typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
 	 * states.
 	 */
 	if ((!read || !dir || STRICT_READ_CHECKS) &&
-			!usage(curr, this, excl_bit, state_name(new_bit & ~LOCK_USAGE_READ_MASK)))
+	    !usage(curr, this, excl_bit, state_name(new_bit & ~LOCK_USAGE_READ_MASK)))
 		return 0;
 
 	/*
@@ -3071,8 +3069,8 @@ typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
 			return 0;
 
 		if (STRICT_READ_CHECKS &&
-			!usage(curr, this, excl_bit + LOCK_USAGE_READ_MASK,
-				state_name(new_bit + LOCK_USAGE_READ_MASK)))
+		    !usage(curr, this, excl_bit + LOCK_USAGE_READ_MASK,
+			   state_name(new_bit + LOCK_USAGE_READ_MASK)))
 			return 0;
 	}
 
@@ -3338,7 +3336,7 @@ static inline unsigned int task_irq_context(struct task_struct *task)
 }
 
 static int separate_irq_context(struct task_struct *curr,
-		struct held_lock *hlock)
+				struct held_lock *hlock)
 {
 	unsigned int depth = curr->lockdep_depth;
 
@@ -3364,14 +3362,14 @@ static int separate_irq_context(struct task_struct *curr,
 
 static inline
 int mark_lock_irq(struct task_struct *curr, struct held_lock *this,
-		enum lock_usage_bit new_bit)
+		  enum lock_usage_bit new_bit)
 {
 	WARN_ON(1); /* Impossible innit? when we don't have TRACE_IRQFLAG */
 	return 1;
 }
 
 static inline int mark_irqflags(struct task_struct *curr,
-		struct held_lock *hlock)
+				struct held_lock *hlock)
 {
 	return 1;
 }
@@ -3382,7 +3380,7 @@ static inline unsigned int task_irq_context(struct task_struct *task)
 }
 
 static inline int separate_irq_context(struct task_struct *curr,
-		struct held_lock *hlock)
+				       struct held_lock *hlock)
 {
 	return 0;
 }
@@ -3393,7 +3391,7 @@ static inline int separate_irq_context(struct task_struct *curr,
  * Mark a lock with a usage bit, and validate the state transition:
  */
 static int mark_lock(struct task_struct *curr, struct held_lock *this,
-			     enum lock_usage_bit new_bit)
+		     enum lock_usage_bit new_bit)
 {
 	unsigned int new_mask = 1 << new_bit, ret = 1;
 
@@ -3836,7 +3834,7 @@ static struct held_lock *find_held_lock(struct task_struct *curr,
 }
 
 static int reacquire_held_locks(struct task_struct *curr, unsigned int depth,
-			      int idx)
+				int idx)
 {
 	struct held_lock *hlock;
 
@@ -4210,8 +4208,8 @@ void lock_downgrade(struct lockdep_map *lock, unsigned long ip)
  * and also avoid lockdep recursion:
  */
 void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
-			  int trylock, int read, int check,
-			  struct lockdep_map *nest_lock, unsigned long ip)
+		  int trylock, int read, int check,
+		  struct lockdep_map *nest_lock, unsigned long ip)
 {
 	unsigned long flags;
 
@@ -4230,8 +4228,7 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 }
 EXPORT_SYMBOL_GPL(lock_acquire);
 
-void lock_release(struct lockdep_map *lock, int nested,
-			  unsigned long ip)
+void lock_release(struct lockdep_map *lock, int nested, unsigned long ip)
 {
 	unsigned long flags;
 
-- 
1.8.3.1

