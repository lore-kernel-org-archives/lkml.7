Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E14EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0732082F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kY1RcOK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfCRI6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:58:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36003 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbfCRI6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:58:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id p10so3996181pff.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 01:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KyHrxDe/xpb07A9K3M4+mxUi1KrAuSfwcb6ndTfQUHA=;
        b=kY1RcOK8xX2A5gB6C3uCfJtXrhg81dLPNNz2vYx7HLKKTPTDfmN4tqcBx2iJzGx0zz
         BTjICtSvogqHbbUieYnvfSX5gZLKS8W2tVtBEfuErTpWa6veyc7xs5OzSx7yZB5bdpXS
         gdhI+0uFTl3Y2Xs+JRi+eGjwnwYw/P68kK84dPIcCxQJN0+Myc1s4bs3ho6mFN0zs07U
         UfAa+/sVFkTU70T1adD2igOzwjkLnfs8A7sVyWP8TsCTiymbV4WDCLekP7FJpZgC0Cfr
         2etBCM4f55nvscWd1poim/PhicZ+Q8MSr1vo+U6C3GWBKPTSoR3c+/OjtZ3TEdeCN5gD
         pMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KyHrxDe/xpb07A9K3M4+mxUi1KrAuSfwcb6ndTfQUHA=;
        b=IKOK3cyCXlmN24Uh1FZ1+tzxyoSOK/7NenVL5UzhmiorB5zY3m2PDyXhQpeeu3wDrA
         rN9tcIgahd9ShOuk18r1+plLWDNAh4stQ6VqkpF4V/fGejXykAWzK4mVONWvrTMVQ12a
         bT+cYG7H+ACXKIrxpZ1fmQXYxb/yF5Wl8oED/SRb8BgztD6vJd0tvsBWr2RdBrRpmtX3
         l5qWATuGDwQmbybTDrjiva/LqiL1IzmCffgq/tDL3i9jAM51os2J/tusYc9SpEbWxtk1
         0cUs8c0gLTXQhss1TBSOtNlC97eQszkN5Ut2nkY1OXeQWa3yQEe8dPP+n8I93Jt359SZ
         ls/Q==
X-Gm-Message-State: APjAAAWtKYmqBgBLa2kIK6NkEbSjZ0Dv6Maz0e5zJ95dMNdZXMFFDURz
        cAf6eMV3okJfE9nRMZta9F8=
X-Google-Smtp-Source: APXvYqzr4SD9IeoJk4+pmmTFQUp8ydpDtDef9r3SzicZ/PibrZj7DZBDQ5NU5oGoMtZUXbWQHW8nDg==
X-Received: by 2002:a17:902:aa87:: with SMTP id d7mr18132416plr.146.1552899485873;
        Mon, 18 Mar 2019 01:58:05 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id k8sm11147024pgq.37.2019.03.18.01.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 01:58:05 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 08/19] locking/lockdep: Use lockdep_init_task for task initiation consistently
Date:   Mon, 18 Mar 2019 16:57:22 +0800
Message-Id: <20190318085733.3143-9-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190318085733.3143-1-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
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
index 1258a62..49b928f 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -280,6 +280,8 @@ struct held_lock {
 extern asmlinkage void lockdep_sys_exit(void);
 extern void lockdep_set_selftest_task(struct task_struct *task);
 
+extern inline void lockdep_init_task(struct task_struct *task);
+
 extern void lockdep_off(void);
 extern void lockdep_on(void);
 
@@ -404,6 +406,10 @@ static inline void lock_set_subclass(struct lockdep_map *lock,
 
 #else /* !CONFIG_LOCKDEP */
 
+static inline void lockdep_init_task(struct task_struct *task)
+{
+}
+
 static inline void lockdep_off(void)
 {
 }
@@ -496,7 +502,6 @@ enum xhlock_context_t {
 	{ .name = (_name), .key = (void *)(_key), }
 
 static inline void lockdep_invariant_state(bool force) {}
-static inline void lockdep_init_task(struct task_struct *task) {}
 static inline void lockdep_free_task(struct task_struct *task) {}
 
 #ifdef CONFIG_LOCK_STAT
diff --git a/init/init_task.c b/init/init_task.c
index 46dbf54..9460878 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -165,6 +165,8 @@ struct task_struct init_task
 	.softirqs_enabled = 1,
 #endif
 #ifdef CONFIG_LOCKDEP
+	.lockdep_depth = 0, /* no locks held yet */
+	.curr_chain_key = 0,
 	.lockdep_recursion = 0,
 #endif
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
diff --git a/kernel/fork.c b/kernel/fork.c
index 77059b2..c0d2000 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1869,9 +1869,6 @@ static __latent_entropy struct task_struct *copy_process(
 	p->pagefault_disabled = 0;
 
 #ifdef CONFIG_LOCKDEP
-	p->lockdep_depth = 0; /* no locks held yet */
-	p->curr_chain_key = 0;
-	p->lockdep_recursion = 0;
 	lockdep_init_task(p);
 #endif
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3df0a5e..737fe0a 100644
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
@@ -4492,9 +4499,7 @@ void lockdep_reset(void)
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

