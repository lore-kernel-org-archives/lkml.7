Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71F5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8544C2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afOThhT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbfDXKUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:20:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35529 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729205AbfDXKUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:20:50 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so9079484plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q3GrRdrdMO69cDAUYXFHQTslG9md3PudUIdVEs6Gllk=;
        b=afOThhT6iG2nMzwF93z0ldDOjEyVs1t7TLGmfo7WOGHsNO4f/2oQb0YE8pkbHHQIJ9
         PnaIe+LosqObSzepHgbMbfTDA1jCvu1oixNsZij7OZJ9h8xTVwv3mBwCxmd21O0vNbg3
         ihUHNSHGH0toH0/5t52BodyB1HQJ6UfZGU9UmO1HWH6aZr81zoqANtP6EAHdONSI2gH7
         O+M3H61Ebt1WxZHiCiiFjtT4BoCkieonhLMc/RP7WB95p7e/5GbXLUAWQIw7v9IHCwUZ
         88T73bJGXZbJEX80SyPdBb5sTVOUpt65eMkxKKwSqxdiRTcwzAQnvsD+3+9YJEhUUd/2
         efLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q3GrRdrdMO69cDAUYXFHQTslG9md3PudUIdVEs6Gllk=;
        b=q8uGSKJxC9lks0+Ip5WSWoVHNrIJt1JnPKiEF2hmYsyq4QXSt14RHHJQMwL9qsRU5A
         LxzWVsI0nn6RAO6ku4TmekP1b28bAXB0nPueqkaFrmFZy3/KPFWvGJAnf37LPSOk9+fl
         aXLHtiVKw4+13sFPZT8n1LDRxYPaTXRxPqhiTHFhHtEY8GFid42lHVbK5XqLWIBlz/89
         v/bSwiQIegXHOdGoGcvmhxty4t/wKEpOnPS9drDoCEGFgZ81XLohNrnV2pclZLjx8Vci
         iAfKkdJFHeh4lYJCVJJmWwJyzuPcm2iWa6cpzmnO7oYvX8deRsTOUP8XlVmW0bck2l+B
         jSng==
X-Gm-Message-State: APjAAAVs4iq9K0biRO5E4oWWMPLluLoqLtj9hqX2eF6eMiQM+Kl/M191
        C02p1ohi4CSaSwhhK0x2v3s=
X-Google-Smtp-Source: APXvYqzChGYwGTdCWp0y45Nbu9XwuHhaYUUoc+4HlouBIuUksij/W8tQCA2NwxdmFGsQTXzE1zjYtg==
X-Received: by 2002:a17:902:be09:: with SMTP id r9mr31915014pls.215.1556101249368;
        Wed, 24 Apr 2019 03:20:49 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:20:48 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 07/28] locking/lockdep: Use lockdep_init_task for task initiation consistently
Date:   Wed, 24 Apr 2019 18:19:13 +0800
Message-Id: <20190424101934.51535-8-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
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
index e001dfb..4ce0e39 100644
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
@@ -4483,9 +4490,7 @@ void lockdep_reset(void)
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

