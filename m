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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0809C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C88E2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqyNijba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfF1JQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:16:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36389 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfF1JQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:16:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so2913605plt.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M6wDBAy/l0rcfis1XfUCinpCxxx66mRh9XV5lnS5OpM=;
        b=XqyNijbaYyvigoz1D3y4W5J/rQwnKxLQ7v2/fGh8yhyTF3eGh8vYRgunMc3f/2MefL
         DzcbuKjDpy5aUGS0qg1VK3Wm73Gi3ouAheiP+Bb2S2mNeZ0S8W5/u/6E4Unwekb2OhP0
         AG/8QEHjMdP4ibIFDpUQFxSngEl3mBpQ2jGNtO7fCSMgpe/zf70w6D6mUlw4obMaWQOD
         iPZ4edziG3uL6nc6THE35lB7uEZ3FNvRNbzJNt6UDyf4wrD+TDmKsAuWXh3S5G/FheAN
         ZT3vo/XLIR6NW4rTf8fq3v6Sg461PdiI/KRCcvkajBZsdVYKQK4WbTfkcVUyIQBgcyiS
         HAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M6wDBAy/l0rcfis1XfUCinpCxxx66mRh9XV5lnS5OpM=;
        b=NXz/UcaeAMHCcFswEj9+mczn9ZkHhLUof4RV/abfJy1MKYyAaXMkqBUDpLuFJkIW0F
         c2MWcin+pML7kPMfz3g5x2LaQ4KmlPkMTFzFqPP7t/Fiv0t/ECZZcfN/IBshJhiO6cot
         oSm9bsQ+v2qGJUWUy4T1Tq1aag185DXKKOteShO6JDLaYZQ55cjfZYdUSFi/CN6I0Hlc
         g1ocROCMlu3Z720yqPD02fB8eQZgOx4tWkSYPb1Le7ly6clph8MwHy0ollcAR3lvLIkk
         5ZWQswsNPo5itqufMSLOJ/yvapfpy14qfU0ka9P9DCqEbfoCRelq9v/Q4G6xv41M4h/f
         KF4Q==
X-Gm-Message-State: APjAAAXa+NAmkMQ7bEiwXf7wwzGdFYDH9av45cPRSl8r857pz+zIyUIU
        dH4PfiyBAYqzmfN/gfOmyyM=
X-Google-Smtp-Source: APXvYqxrs9i8Fs8A0hGi1L7VqXwqrBJ9j1seCCZdAHvM/H2KAwtglBEtiCPDFQSFq1Gk4h3clwDQqw==
X-Received: by 2002:a17:902:7603:: with SMTP id k3mr10389375pll.245.1561713415186;
        Fri, 28 Jun 2019 02:16:55 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:16:54 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 16/30] locking/lockdep: Use lock type enum to explicitly specify read or write locks
Date:   Fri, 28 Jun 2019 17:15:14 +0800
Message-Id: <20190628091528.17059-17-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an enum to formally quantify lock types. No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h  | 27 ++++++++++++++++++++-------
 include/linux/rcupdate.h |  2 +-
 kernel/locking/lockdep.c | 19 +++++++++++--------
 3 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 981718b..eb26e93 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -353,10 +353,18 @@ static inline int lockdep_match_key(struct lockdep_map *lock,
  *
  * Values for "read":
  *
- *   0: exclusive (write) acquire
- *   1: read-acquire (no recursion allowed)
- *   2: read-acquire with same-instance recursion allowed
- *
+ *   LOCK_TYPE_EXCLUSIVE (LOCK_TYPE_WRITE): exclusive (write) acquire
+ *   LOCK_TYPE_READ: read-acquire (no recursion allowed)
+ *   LOCK_TYPE_RECURSIVE: read-acquire with same-instance recursion allowed
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
@@ -602,9 +610,14 @@ static inline void print_irqtrace_events(struct task_struct *curr)
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
index b25d208..d0279da 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -205,7 +205,7 @@ static inline void destroy_rcu_head_on_stack(struct rcu_head *head) { }
 
 static inline void rcu_lock_acquire(struct lockdep_map *map)
 {
-	lock_acquire(map, 0, 0, 2, 0, NULL, _THIS_IP_);
+	lock_acquire(map, 0, 0, LOCK_TYPE_RECURSIVE, 0, NULL, _THIS_IP_);
 }
 
 static inline void rcu_lock_release(struct lockdep_map *map)
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3b655fd..3c97d71 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2356,7 +2356,10 @@ static inline void inc_chains(void)
  * (Note that this has to be done separately, because the graph cannot
  * detect such classes of deadlocks.)
  *
- * Returns: 0 on deadlock detected, 1 on OK, 2 on recursive read
+ * Returns:
+ *  0: on deadlock detected;
+ *  1: on OK;
+ *  LOCK_TYPE_RECURSIVE: on recursive read
  */
 static int
 check_deadlock_current(struct task_struct *curr, struct held_lock *next)
@@ -2378,15 +2381,15 @@ static inline void inc_chains(void)
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
@@ -2489,7 +2492,7 @@ static inline void inc_chains(void)
 	 * write-lock never takes any other locks, then the reads are
 	 * equivalent to a NOP.
 	 */
-	if (next->read == 2 || prev->read == 2)
+	if (next->read == LOCK_TYPE_RECURSIVE || prev->read == LOCK_TYPE_RECURSIVE)
 		return 1;
 
 	if (!trace->nr_entries && !save_trace(trace))
@@ -2869,7 +2872,7 @@ static int validate_chain(struct task_struct *curr, struct held_lock *next,
 		 * chain, and if it's not a second recursive-read lock. If
 		 * not, there is no need to check further.
 		 */
-		if (!(chain->depth > 1 && ret != 2))
+		if (!(chain->depth > 1 && ret != LOCK_TYPE_RECURSIVE))
 			goto out_unlock;
 	}
 
@@ -2878,7 +2881,7 @@ static int validate_chain(struct task_struct *curr, struct held_lock *next,
 	 * added:
 	 */
 	if (chain) {
-		if (hlock->read != 2 && hlock->check) {
+		if (hlock->read != LOCK_TYPE_RECURSIVE && hlock->check) {
 			int distance = curr->lockdep_depth - depth + 1;
 
 			if (!check_prev_add(curr, hlock, next, distance,
@@ -4132,7 +4135,7 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 	curr->curr_chain_key = hlock->prev_chain_key;
 
 	WARN(hlock->read, "downgrading a read lock");
-	hlock->read = 1;
+	hlock->read = LOCK_TYPE_READ;
 	hlock->acquire_ip = ip;
 
 	if (reacquire_held_locks(curr, depth, i, &merged))
-- 
1.8.3.1

