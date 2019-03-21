Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319A7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B7C218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEOAkkzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfCUH55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:57:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45669 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbfCUH5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 03:57:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id v21so3761206pfm.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 00:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1qE83cxju6awRm0ckFh7Wf/e0C0vHrQbiasFOtKekmo=;
        b=bEOAkkzVZq0VJ2RjXJy3dJdRgvrL0rfFmcZrfDdJSSq7r4uglAKcswj8on2PktGAg4
         J0XnIrSHlMZRbhhamwVmw0pQbzZK4ROIii5RqcNJMa930AoHQhrXxGLVtdYp0TcWUWht
         M8zwQYXmCKD5P/KBVDeI51rDjVZ/9KEZDwpcUo9ibhGgk1xkBxd+yY0tYl6TCugnjcbP
         tUwoDgEIh6kvCsBv7EyP7kSECQZmG+TzS75P7X6pWG+I1ZIyzCODGmQYCb1S6zZ4jLYG
         DISTXFDf1uSLnf7NRqNQzzu4QSF+k5hS089D6pmWHAZD+nh4T4HZHcR3X8Z7x1ta1VC3
         3KEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1qE83cxju6awRm0ckFh7Wf/e0C0vHrQbiasFOtKekmo=;
        b=DDeR1fN4InJNs4SX/cc/n3p1z0RC79Bc+IkoBgJgNPcf/E6EW9ukit5y49CKnVcoqz
         UVHYBoLzXv9t/QxtWM5Twe2+PGFCHDqTcKXc4Gm3br9yZc+y1ygo6ZaiJzaIURB6XiWx
         Fr/nwKbIz5JaaiPJ+La3lQJ3W+8Ar+meSdPE5PuvWUCx3tJrcvs6D3KOk/IfjaC8qewq
         4FylkGBlNdD6rPkS+FK1QPigNMat1sx+Ne1pRe/pyiQV8Iwi41J2+eRVxzaoP/Kfzul9
         UMfHa9HFlmNeMl2R65WJSZ5obGJziOsVn4oNPxV+WaeEkoL8RGB54Mg/9Ucc91twhH5a
         wHqw==
X-Gm-Message-State: APjAAAVbHIYRYHfhTWAOMy19heS1yvDnXPJES1Dg+6S7ooe1JHvPb84p
        eUqzylo7oe9emgh4YqVyjEU=
X-Google-Smtp-Source: APXvYqz0ZJJeZP9iwXdbdOIGuBulKqXV40aGTXkxJiOZHqr6eritZ148c3haBJSB4E9Fe7Sumglr2A==
X-Received: by 2002:a65:4344:: with SMTP id k4mr2119702pgq.20.1553155074174;
        Thu, 21 Mar 2019 00:57:54 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id e184sm6467148pfc.143.2019.03.21.00.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 00:57:53 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, joe@perches.com,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 07/18] locking/lockdep: Use lockdep_init_task for task initiation consistently
Date:   Thu, 21 Mar 2019 15:57:14 +0800
Message-Id: <20190321075725.14054-8-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190321075725.14054-1-duyuyang@gmail.com>
References: <20190321075725.14054-1-duyuyang@gmail.com>
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
index 37706ad..267087e 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -282,6 +282,8 @@ struct held_lock {
 extern asmlinkage void lockdep_sys_exit(void);
 extern void lockdep_set_selftest_task(struct task_struct *task);
 
+extern inline void lockdep_init_task(struct task_struct *task);
+
 extern void lockdep_off(void);
 extern void lockdep_on(void);
 
@@ -406,6 +408,10 @@ static inline void lock_set_subclass(struct lockdep_map *lock,
 
 #else /* !CONFIG_LOCKDEP */
 
+static inline void lockdep_init_task(struct task_struct *task)
+{
+}
+
 static inline void lockdep_off(void)
 {
 }
@@ -498,7 +504,6 @@ enum xhlock_context_t {
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
index 05c31d6..ef59651 100644
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
@@ -4496,9 +4503,7 @@ void lockdep_reset(void)
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

