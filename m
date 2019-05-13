Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C7FC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB8721479
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h77jrrrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfEMJNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:13:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33549 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfEMJNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:13:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id z28so6878817pfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 02:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Ut+0w3ota/GIP6ZIncC3MqeJGwljW+9P2Proi/wfSM=;
        b=h77jrrrgB7F3Zkf2IdYum4v1Mm1PVZLsDytNfBYqxmWbjqUUQoxDIl9LUnQ27Dp94b
         fjsKTf6AN1G9hikKwmLaxeikZv0ab+B90WX5DqlmsXj5Ka66Yb9hpQYCUpcEBxn+evfG
         wYYKF2tlMWDZkFkefHVRE+iRnxk3e2r1215QT8eOxFjr1ZW31JC8SSIyh/ynwyLhKBPw
         v0ybIWS+VjpL0tMpiZIuvivgDU6zcA5WmUYqBpmqotQq2Q0q3WiD5KWslT50rBPj3r0i
         9DNpIQQfLqxcAv9DEnXoC8VDv7v6lKWdbAGJyIfxq6RYodOkghnD+O2OJEu8na4WZEE5
         EDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Ut+0w3ota/GIP6ZIncC3MqeJGwljW+9P2Proi/wfSM=;
        b=IbbjXb5bETNiAC8Ki4w3OMvG6fLM2nwbNoRV7XVwVEcph5NLbsXd853flRjvbb4spQ
         rXkOYlr/Au5aVX1iYwf/sxfZrzRTDEB2tfUu2AAJHLS09tsHOLLVZchx4F+EXGkPM8gL
         X+S3KpfkcYzMvooRVT0mTCyEcfolEwR5yEt7f35viz4b5tRBIr+YW26lm1HNNfZXpdVl
         CFoK9hSH7Gt1kdMTfq2GajpNmR2LiicH1/6bBsBtKiI1f+pbogu5fVXhyAwqTY/FVQKJ
         +Qg6iu3o7k5vOmI6nGcEeJeJdOwtSLHoM35Gyyaow8qEwOISzfIK53BAhRXU+t+RpN5D
         Mqsw==
X-Gm-Message-State: APjAAAVimnR6D0Mwh1eXnoqogjseqR9it0PX35zQI/peskQxPrAGhkdw
        1E2JDSdSflmLpe/HmLStF0g=
X-Google-Smtp-Source: APXvYqwqgefeAUW5Ge0rqedEpfwTdx2CYT2hDxi7pE0KtaOcQZtp1lb3kE65KlrKVZNggoGNTabOGg==
X-Received: by 2002:aa7:8f2f:: with SMTP id y15mr21106164pfr.124.1557738800634;
        Mon, 13 May 2019 02:13:20 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id n18sm35500837pfi.48.2019.05.13.02.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 02:13:20 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 01/17] locking/lockdep: Add lock type enum to explicitly specify read or write locks
Date:   Mon, 13 May 2019 17:11:47 +0800
Message-Id: <20190513091203.7299-2-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190513091203.7299-1-duyuyang@gmail.com>
References: <20190513091203.7299-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an enum to formalize lock types, as those type values now matter. No
functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h  | 28 ++++++++++++++++++++++------
 kernel/locking/lockdep.c | 23 +++++++++++++----------
 2 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 7c2fefa..441288c 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -339,10 +339,21 @@ static inline int lockdep_match_key(struct lockdep_map *lock,
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
+ * Note that we have an assumption that a lock class cannot ever be both
+ * read and recursive-read.
+ */
+enum lock_type {
+	LOCK_TYPE_EXCLUSIVE	= 0,
+	LOCK_TYPE_WRITE		= 0,
+	LOCK_TYPE_READ,
+	LOCK_TYPE_RECURSIVE,
+};
+
+/*
  * Values for check:
  *
  *   0: simple checks (freeing, held-at-exit-time, etc.)
@@ -588,9 +599,14 @@ static inline void print_irqtrace_events(struct task_struct *curr)
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
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 7275d6c..e9eafcf 100644
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
+ *  2: LOCK_TYPE_RECURSIVE on recursive read
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

