Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7270BC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6DD208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBzUoTfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfF1JRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:17:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42638 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfF1JRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:17:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id k13so2310123pgq.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qDxcVFqFgNNkV3TIcGqu0JHYgpA2EGWmwa8AL4oBEUs=;
        b=hBzUoTfd1DMRkBLiGUpfNnEjGd+L/NQxbeKO9MsEQK0fKkLsvMNLYAywU0IBNG3Ij+
         0V0wanIf3XZE+y7LDNAOJPWztRkUTvUQk8XWh191ie5PoXSF5IkBsWd6vc/DGQrdYsMn
         JUV9ToR23J6OBNb5Y0VKmcpjTyfS9JRZvsCFmnOmmdCSUfv8esvFk56FNtFKyfLiA79p
         GMGEkP63+Pwy74sZ6g89gbQo9AjnrSDOoJEQrqdr2aIh/+7h+6IoDwAq0jSwl+gasgS3
         VlBFh6ENW0TXjVP5bnUaogWa4iaZ5iMejp2tyu/WnNDbJKF+3o+66dL1aLdLKxAs5E4m
         ELgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qDxcVFqFgNNkV3TIcGqu0JHYgpA2EGWmwa8AL4oBEUs=;
        b=fjk9GnUYaHFpF87aybF40vVgKriqI57mcFGfdNigt91HssR6wjP/b3VuhfmtejvML1
         VZGtfoMJTMgh2KmpHFfJMoN9CYviDN2xzsa6caRfSGvS5efMW5a9Tz0PIrWS3i3J8H8y
         WRA+fK4NbfreAk/FpYKJq9kdECjPKpKJ6phJ8qgp1pCiJ6zNaMtHiq/E6xHQYhsmV4Hx
         E9Ge5ttGew/SsWmAGa52eJnzIbm0iR7qDu8nvcJrBUignnz5nhwTeAPnG9ofDl5yXcBE
         bhCKuJcGXGf2h52FRcXSgm6eAwAQbOqNI5j/BZBCREEpcGF+znu4k3Jm/q8ujIO1yffb
         Se2w==
X-Gm-Message-State: APjAAAWDzuVKWynOkkRoJuOENa2Ul9oSeSpRqq6ObThI4awWjDxdM4en
        hqvyXfLfXme/rkRikc6ErPM=
X-Google-Smtp-Source: APXvYqwHhgtUNvUYvppPeTgAnMpgI2cs9VxsRN6E2mIMY3K+D8SQ9ZmdDIBQ1eIXaJ45eU3Gd8bTtA==
X-Received: by 2002:a17:90a:cb01:: with SMTP id z1mr11727842pjt.93.1561713419987;
        Fri, 28 Jun 2019 02:16:59 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:16:59 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 17/30] locking/lockdep: Add read-write type for a lock dependency
Date:   Fri, 28 Jun 2019 17:15:15 +0800
Message-Id: <20190628091528.17059-18-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direct dependencies need to keep track of their read-write lock types.
Two bit fields, which share the distance field, are added to lock_list
struct so the types are stored there.

With a dependecy lock1 -> lock2, lock_type1 has the type for lock1 and
lock_type2 has the type for lock2, where the values are one of the
lock_type enums.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h  | 15 ++++++++++++++-
 kernel/locking/lockdep.c | 25 +++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index eb26e93..fd619ac 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -185,6 +185,8 @@ static inline void lockdep_copy_map(struct lockdep_map *to,
 		to->class_cache[i] = NULL;
 }
 
+#define LOCK_TYPE_BITS	2
+
 /*
  * Every lock has a list of other locks that were taken after or before
  * it as lock dependencies. These dependencies constitute a graph, which
@@ -207,7 +209,17 @@ struct lock_list {
 	struct list_head		chains;
 	struct lock_class		*class[2];
 	struct lock_trace		trace;
-	int				distance;
+
+	/*
+	 * The lock_type fields keep track of the lock type of this
+	 * dependency.
+	 *
+	 * With L1 -> L2, lock_type1 stores the lock type of L1, and
+	 * lock_type2 stores that of L2.
+	 */
+	unsigned int			lock_type1 : LOCK_TYPE_BITS,
+					lock_type2 : LOCK_TYPE_BITS,
+					distance   : 32 - 2*LOCK_TYPE_BITS;
 
 	/*
 	 * The parent field is used to implement breadth-first search.
@@ -362,6 +374,7 @@ enum lock_type {
 	LOCK_TYPE_WRITE		= 0,
 	LOCK_TYPE_READ,
 	LOCK_TYPE_RECURSIVE,
+	NR_LOCK_TYPE,
 };
 
 /*
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3c97d71..1805017 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1307,9 +1307,17 @@ static struct lock_list *alloc_list_entry(void)
  */
 static int add_lock_to_list(struct lock_class *lock1, struct lock_class *lock2,
 			    unsigned long ip, int distance,
-			    struct lock_trace *trace, struct lock_chain *chain)
+			    struct lock_trace *trace, struct lock_chain *chain,
+			    int lock_type1, int lock_type2)
 {
 	struct lock_list *entry;
+
+	/*
+	 * The distance bit field in struct lock_list must be large
+	 * enough to hold the maximum lock depth.
+	 */
+	BUILD_BUG_ON((1 << (32 - 2*LOCK_TYPE_BITS)) < MAX_LOCK_DEPTH);
+
 	/*
 	 * Lock not present yet - get a new dependency struct and
 	 * add it to the list:
@@ -1322,6 +1330,8 @@ static int add_lock_to_list(struct lock_class *lock1, struct lock_class *lock2,
 	entry->class[1] = lock2;
 	entry->distance = distance;
 	entry->trace = *trace;
+	entry->lock_type1 = lock_type1;
+	entry->lock_type2 = lock_type2;
 
 	/*
 	 * Both allocation and removal are done under the graph lock; but
@@ -1465,6 +1475,16 @@ static inline struct list_head *get_dep_list(struct lock_list *lock, int forward
 	return &class->dep_list[forward];
 }
 
+static inline int get_lock_type1(struct lock_list *lock)
+{
+	return lock->lock_type1;
+}
+
+static inline int get_lock_type2(struct lock_list *lock)
+{
+	return lock->lock_type2;
+}
+
 /*
  * Forward- or backward-dependency search, used for both circular dependency
  * checking and hardirq-unsafe/softirq-unsafe checking.
@@ -2503,7 +2523,8 @@ static inline void inc_chains(void)
 	 * dependency list of the previous lock <prev>:
 	 */
 	ret = add_lock_to_list(hlock_class(prev), hlock_class(next),
-			       next->acquire_ip, distance, trace, chain);
+			       next->acquire_ip, distance, trace, chain,
+			       prev->read, next->read);
 	if (!ret)
 		return 0;
 
-- 
1.8.3.1

