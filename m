Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD43C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992D0205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNebwHl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfEPIA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:00:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34076 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfEPIA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:00:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id n19so1432185pfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 01:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PMKaB0Oa5QXUNtHyl3wAgOjSQCtL7tLwsVttCyl931A=;
        b=mNebwHl3556stsQHTW1xYb9i00Zjjy5fbFM+qBbXUliEAsVVZNhEhp43EmfV5B2vRU
         boj13OY5+UPXztGPhm7/ShGDQUa31xDy82gKWtqqMW9WKiGJPSQWKCRMBacgeePPiX0D
         7Luyvc89GKpZSSl6avKi3kSoSqjM+PWsu3bp2nNnWjcBB3+RQSpTtoM+sJyFOpzJG8ck
         nUGQ+ALm2CV7GFzUFlPG9cTgGN+FxwrBvyQQiV1mcfuGI48LsDxtxu0foLo9Gpmi6p2k
         uAMSHbJM2u1sdn4JQwctG1AvLlggLkF7Y8h0niyJcuEmwWzbEuqq3b/IwfKwcNyOB3L7
         i0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMKaB0Oa5QXUNtHyl3wAgOjSQCtL7tLwsVttCyl931A=;
        b=cxSqgkN8F6LydFcSh8zbd1wgIJMgV+BZzey9vnYiHS363w+1/hdC8wqv0EavvtOup8
         uwA0CSJ615kH0C9uAlxjmUie4h2jHHBHMyFqgbF2zn6vTUBR5BkeNQBagFsugnQXqeav
         5KtZGBANTkTCn5jofNoIM6dLaxmFXrh42dffWGov7FtfPv2eYrySSywSG34t7LryPKxO
         jAYxyMDkYWCVIMc71NwPQzMC+6I5WExgTk8LrOSggVtGSoUYYCuuT245SDagJLLqU0VV
         CsGvhVdQ73sVqLfMvrttep+wrYVlrWx3Crc36k0APusfDWcpUUmcP95OWtFz+Xpdpqal
         sfdA==
X-Gm-Message-State: APjAAAWFD4KYwmSWqQcsg33XekbDQa8+tx6Q/FmLOW1xVj/EuhsP4LAv
        e1M8ixkqO3YgQHdVM9q9ekg=
X-Google-Smtp-Source: APXvYqxEZ8uHgZrKQnzhJ3S8hHPZ19fsSPG0VvGau1UnOCbrzSS7e5qJNclF5RBz6uLZdeIS6WU5Ng==
X-Received: by 2002:a63:17:: with SMTP id 23mr48293837pga.206.1557993626669;
        Thu, 16 May 2019 01:00:26 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id p7sm2051471pgb.92.2019.05.16.01.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 01:00:26 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com, paulmck@linux.ibm.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 01/17] locking/lockdep: Add lock type enum to explicitly specify read or write locks
Date:   Thu, 16 May 2019 15:59:59 +0800
Message-Id: <20190516080015.16033-2-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190516080015.16033-1-duyuyang@gmail.com>
References: <20190516080015.16033-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an enum to formalize lock types, as those type values now matter.

In order to make:

  LOCK_TYPE_READ & LOCK_TYPE_RECURSIVE != 0

The recursive-read type is set to 3 as opposed to the current 2.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h  | 45 +++++++++++++++++++++++++++++++++++++++------
 include/linux/rcupdate.h |  2 +-
 kernel/locking/lockdep.c | 23 +++++++++++++----------
 3 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 7c2fefa..1009c47 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -339,10 +339,38 @@ static inline int lockdep_match_key(struct lockdep_map *lock,
  *
  * Values for "read":
  *
- *   0: exclusive (write) acquire
- *   1: read-acquire (no recursion allowed)
- *   2: read-acquire with same-instance recursion allowed
+ *   LOCK_TYPE_EXCLUSIVE (LOCK_TYPE_WRITE): exclusive (write) acquire
+ *   LOCK_TYPE_READ: read-acquire (no recursion allowed)
+ *   LOCK_TYPE_RECURSIVE: read-acquire with same-instance recursion allowed
  *
+ * The same lock between tasks have the following exclusiveness (the read
+ * type includes recursive read):
+ *
+ *   read and read    (no )
+ *   read and write   (yes)
+ *   write and write  (yes)
+ *
+ * The enum values for the types are arranged such that:
+ *
+ *   if type1 and type2 are exclusive then type1 & type2 == 0.
+ *
+ * We have a tricky situation concerning read vs. recursive-read. Since
+ * there can be lock classes that may ever be both read lock and
+ * recursive-read lock, for example:
+ *
+ *   kernel/qrwlock.c:queued_read_lock_slowpath()
+ *
+ * The values of lock types are defined as follows:
+ */
+enum lock_type {
+	LOCK_TYPE_EXCLUSIVE	= 0,
+	LOCK_TYPE_WRITE		= 0,
+	LOCK_TYPE_READ,
+	LOCK_TYPE_UNUSED,
+	LOCK_TYPE_RECURSIVE,
+};
+
+/*
  * Values for check:
  *
  *   0: simple checks (freeing, held-at-exit-time, etc.)
@@ -588,9 +616,14 @@ static inline void print_irqtrace_events(struct task_struct *curr)
  * on the per lock-class debug mode:
  */
 
-#define lock_acquire_exclusive(l, s, t, n, i)		lock_acquire(l, s, t, 0, 1, n, i)
-#define lock_acquire_shared(l, s, t, n, i)		lock_acquire(l, s, t, 1, 1, n, i)
-#define lock_acquire_shared_recursive(l, s, t, n, i)	lock_acquire(l, s, t, 2, 1, n, i)
+#define lock_acquire_exclusive(l, s, t, n, i)			\
+	lock_acquire(l, s, t, LOCK_TYPE_EXCLUSIVE, 1, n, i)
+
+#define lock_acquire_shared(l, s, t, n, i)			\
+	lock_acquire(l, s, t, LOCK_TYPE_READ, 1, n, i)
+
+#define lock_acquire_shared_recursive(l, s, t, n, i)		\
+	lock_acquire(l, s, t, LOCK_TYPE_RECURSIVE, 1, n, i)
 
 #define spin_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
 #define spin_acquire_nest(l, s, t, n, i)	lock_acquire_exclusive(l, s, t, n, i)
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 922bb68..22b41b1 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -207,7 +207,7 @@ static inline void destroy_rcu_head_on_stack(struct rcu_head *head) { }
 
 static inline void rcu_lock_acquire(struct lockdep_map *map)
 {
-	lock_acquire(map, 0, 0, 2, 0, NULL, _THIS_IP_);
+	lock_acquire(map, 0, 0, LOCK_TYPE_RECURSIVE, 0, NULL, _THIS_IP_);
 }
 
 static inline void rcu_lock_release(struct lockdep_map *map)
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 7275d6c..fb6be63 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2297,7 +2297,10 @@ static inline void inc_chains(void)
  * (Note that this has to be done separately, because the graph cannot
  * detect such classes of deadlocks.)
  *
- * Returns: 0 on deadlock detected, 1 on OK, 2 on recursive read
+ * Returns:
+ *  0: on deadlock detected;
+ *  1: on OK;
+ *  3: LOCK_TYPE_RECURSIVE on recursive read
  */
 static int
 check_deadlock(struct task_struct *curr, struct held_lock *next)
@@ -2319,15 +2322,15 @@ static inline void inc_chains(void)
 		 * Allow read-after-read recursion of the same
 		 * lock class (i.e. read_lock(lock)+read_lock(lock)):
 		 */
-		if ((next->read == 2) && prev->read)
-			return 2;
+		if ((next->read == LOCK_TYPE_RECURSIVE) && prev->read)
+			return LOCK_TYPE_RECURSIVE;
 
 		/*
 		 * We're holding the nest_lock, which serializes this lock's
 		 * nesting behaviour.
 		 */
 		if (nest)
-			return 2;
+			return LOCK_TYPE_RECURSIVE;
 
 		print_deadlock_bug(curr, prev, next);
 		return 0;
@@ -2407,7 +2410,7 @@ static inline void inc_chains(void)
 	 * write-lock never takes any other locks, then the reads are
 	 * equivalent to a NOP.
 	 */
-	if (next->read == 2 || prev->read == 2)
+	if (next->read == LOCK_TYPE_RECURSIVE || prev->read == LOCK_TYPE_RECURSIVE)
 		return 1;
 	/*
 	 * Is the <prev> -> <next> dependency already present?
@@ -2493,7 +2496,7 @@ static inline void inc_chains(void)
 		 * Only non-recursive-read entries get new dependencies
 		 * added:
 		 */
-		if (hlock->read != 2 && hlock->check) {
+		if (hlock->read != LOCK_TYPE_RECURSIVE && hlock->check) {
 			int ret = check_prev_add(curr, hlock, next, distance,
 						 &trace);
 			if (!ret)
@@ -2877,13 +2880,13 @@ static int validate_chain(struct task_struct *curr,
 		 * building dependencies (just like we jump over
 		 * trylock entries):
 		 */
-		if (ret == 2)
-			hlock->read = 2;
+		if (ret == LOCK_TYPE_RECURSIVE)
+			hlock->read = LOCK_TYPE_RECURSIVE;
 		/*
 		 * Add dependency only if this lock is not the head
 		 * of the chain, and if it's not a secondary read-lock:
 		 */
-		if (!chain_head && ret != 2) {
+		if (!chain_head && ret != LOCK_TYPE_RECURSIVE) {
 			if (!check_prevs_add(curr, hlock))
 				return 0;
 		}
@@ -4105,7 +4108,7 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 	curr->curr_chain_key = hlock->prev_chain_key;
 
 	WARN(hlock->read, "downgrading a read lock");
-	hlock->read = 1;
+	hlock->read = LOCK_TYPE_READ;
 	hlock->acquire_ip = ip;
 
 	if (reacquire_held_locks(curr, depth, i))
-- 
1.8.3.1

