Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E1CC04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA402087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuRhF2mE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfEFIUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:20:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44615 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEFIUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:20:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id z16so6080720pgv.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q1/noZSQvGvwMNkiB3NXfKHnpLYzNs326g0n8wQumEE=;
        b=cuRhF2mEerWphgQZh7DB8+/c6Q1rN3zmkeJEKc+4rT2CMXegUdkH4/zZfQZOuUlHnO
         9aufGOBfqoGXnI8654pYFBlS2kBgEbstw9WXajwTtvLluZ0jWUIHpE6eiq4quKBHe3/T
         IJhypqPi4LkgvGvPsLyfCH2vMTreIN5hTaDxVYywH7QZ3Sm1sptIOcbideEB1z6j1X94
         7Zv1LfFPPH/HrzVYDS4BMBH9M7hlaT3se3o3dQ/0Het3S5K7IeBB0pqqWoGAvhmYkWb1
         5RprGeZ9x+RvlXykqFN2rmfrc76eWiyFYcnDpBW9ijyrWUUwFVfmef3NeVwWwWEOv2eZ
         85lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q1/noZSQvGvwMNkiB3NXfKHnpLYzNs326g0n8wQumEE=;
        b=AvF3VjseOWKYa00dgq4Ctzx/NsthsCwGwqdIcFCpCy/rEiApm0xEJE3GqYYQsfFh5P
         FFuluvk9EXPL/7zzkcQBgL09Bhjh5dWyz2+5TpDDz+N8CYn70sQLItMQi78HuhfULaQo
         JaFR7tWed3qkefns1O25kku42grA7008gdJt44OAvbQBdIeepnYRdkc5l3FWZbqmuNOq
         yDYRSWHxw72af+LL9Kv6SStG4bYrvtsN0xEjuPJ6rKHseLIZizu1eAwWYMHICT1MFHBH
         mPEhbZQXoar3WLB5ccjOmMV9YyTSAK9HoE9T79ZNGblD7/TywQpJd/1u8IA4xUaO18VH
         9QOw==
X-Gm-Message-State: APjAAAWpRQu94jlpMTMmMnIxKu3wPzlGPNNr+X4sh+awcLZKI+zYbQ7p
        xaCEVLrA7npu78wJV+kmuZ0=
X-Google-Smtp-Source: APXvYqzRFFJ0q3j1bfWXl1gRR+sqH9njFNHuQselL5Ls640hsV8qEqWZbrj7w3KOSOOsGS1w3X0UMQ==
X-Received: by 2002:a65:518d:: with SMTP id h13mr30658254pgq.259.1557130811927;
        Mon, 06 May 2019 01:20:11 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm20958013pfa.138.2019.05.06.01.20.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 01:20:10 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 07/23] locking/lockdep: Use lockdep_init_task for task initiation consistently
Date:   Mon,  6 May 2019 16:19:23 +0800
Message-Id: <20190506081939.74287-8-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190506081939.74287-1-duyuyang@gmail.com>
References: <20190506081939.74287-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Despite that there is a lockdep_init_task() which does nothing, lockdep
initiates tasks by assigning lockdep fields and does so inconsistently. Fix
this by using lockdep_init_task().

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h  |  7 ++++++-
 init/init_task.c         |  2 ++
 kernel/fork.c            |  3 ---
 kernel/locking/lockdep.c | 11 ++++++++---
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 851d44f..751a2cc 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -287,6 +287,8 @@ struct held_lock {
 extern asmlinkage void lockdep_sys_exit(void);
 extern void lockdep_set_selftest_task(struct task_struct *task);
 
+extern inline void lockdep_init_task(struct task_struct *task);
+
 extern void lockdep_off(void);
 extern void lockdep_on(void);
 
@@ -411,6 +413,10 @@ static inline void lock_set_subclass(struct lockdep_map *lock,
 
 #else /* !CONFIG_LOCKDEP */
 
+static inline void lockdep_init_task(struct task_struct *task)
+{
+}
+
 static inline void lockdep_off(void)
 {
 }
@@ -503,7 +509,6 @@ enum xhlock_context_t {
 	{ .name = (_name), .key = (void *)(_key), }
 
 static inline void lockdep_invariant_state(bool force) {}
-static inline void lockdep_init_task(struct task_struct *task) {}
 static inline void lockdep_free_task(struct task_struct *task) {}
 
 #ifdef CONFIG_LOCK_STAT
diff --git a/init/init_task.c b/init/init_task.c
index c70ef65..1b15cb9 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -166,6 +166,8 @@ struct task_struct init_task
 	.softirqs_enabled = 1,
 #endif
 #ifdef CONFIG_LOCKDEP
+	.lockdep_depth = 0, /* no locks held yet */
+	.curr_chain_key = 0,
 	.lockdep_recursion = 0,
 #endif
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
diff --git a/kernel/fork.c b/kernel/fork.c
index 9dcd18a..8ec9e78 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1868,9 +1868,6 @@ static __latent_entropy struct task_struct *copy_process(
 	p->pagefault_disabled = 0;
 
 #ifdef CONFIG_LOCKDEP
-	p->lockdep_depth = 0; /* no locks held yet */
-	p->curr_chain_key = 0;
-	p->lockdep_recursion = 0;
 	lockdep_init_task(p);
 #endif
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 222ee91..f02f7dc 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -358,6 +358,13 @@ static inline u64 iterate_chain_key(u64 key, u32 idx)
 	return k0 | (u64)k1 << 32;
 }
 
+inline void lockdep_init_task(struct task_struct *task)
+{
+	task->lockdep_depth = 0; /* no locks held yet */
+	task->curr_chain_key = 0;
+	task->lockdep_recursion = 0;
+}
+
 void lockdep_off(void)
 {
 	current->lockdep_recursion++;
@@ -4588,9 +4595,7 @@ void lockdep_reset(void)
 	int i;
 
 	raw_local_irq_save(flags);
-	current->curr_chain_key = 0;
-	current->lockdep_depth = 0;
-	current->lockdep_recursion = 0;
+	lockdep_init_task(current);
 	memset(current->held_locks, 0, MAX_LOCK_DEPTH*sizeof(struct held_lock));
 	nr_hardirq_chains = 0;
 	nr_softirq_chains = 0;
-- 
1.8.3.1

