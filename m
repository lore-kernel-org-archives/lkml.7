Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B1EC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2012823429
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UetEJf1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfH2Icz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:32:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34201 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbfH2Icv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:32:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id b24so1594539pfp.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y9B4vIKEkG7WXy/phP6YFI7YjChHBUGCsTMIBlPmEiQ=;
        b=UetEJf1RJj6y7WkCUoLnGZwe6tuOeLPBq9CDt5Fcv0wzEO8uxDaUoNQrz3Tz9vF9Yk
         kdlnVIAt1PvY/Na8/UVZ8bNk/9nte3kq8lRMC3iASNEQ3g1evWGVGraNzjTwTuHpwoj3
         FnoR0oeKUbmxjgUV5vpv6k2xcl8MA+B625Y5NIXPNEzhfD9rsudgnRlmzLWktilPCcly
         Mn7zrgyGaHJyj4yQQH8YLvUaPZyJ7yks2OIFW5IhRFuy8zpEVwNe5I7r1M9tYfWTyYK1
         o1neNFv+MaNaRsu7vpCN3U20ROzFYoBhZMHsEyQel0mk78HYbe49QqAcfeXlGktvWfHj
         m10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y9B4vIKEkG7WXy/phP6YFI7YjChHBUGCsTMIBlPmEiQ=;
        b=Tr5Fb5g0p4mIYu73NypBmrrXa54kuGJoMjXuLUq4dVC0WWeRUNgp67duWGLS2NL+CQ
         KQzNuD2djhOcQuRP1geV48JFTKMTP/nn4t7665PEZ3JrDD50uOZVbrDhtF5PLanOVNts
         Nkdoe9kbkOnThhip3HcBqb8onFx8ZlEfRtYW27vew9mwCUhPF4HVULKbB3BYKgOwZlg/
         8U2GoXqEvBYmaq/T4Qta7KBcGER5PklHhi/v/2Ub5sybvuVg4nIcdB6XpO7B+PUcPmYk
         lLFoj/53ZGvvHtNzHb7etaT5lS5HTgHpGzmuS6Dz8iTUaCOEjdae2cCdzjVMXwuayxrQ
         SVFA==
X-Gm-Message-State: APjAAAWHGbFpsq5OPBOwwM0QeU305VqLVMqQyfLu2tKb8vQx8mFJ5Vj3
        yzTx8gvoyj6F0zQcnuO3Yvs=
X-Google-Smtp-Source: APXvYqwjK8S/+xQS3dDRG1a0gOUgZ85XUQ0bXEfbdmjyaxWwJ2F9vHBYngr3L54SDuMuqx5X2Q3+HA==
X-Received: by 2002:aa7:9a81:: with SMTP id w1mr9930060pfi.24.1567067571141;
        Thu, 29 Aug 2019 01:32:51 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.32.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:32:50 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 17/30] locking/lockdep: Use lock type enum to explicitly specify read or write locks
Date:   Thu, 29 Aug 2019 16:31:19 +0800
Message-Id: <20190829083132.22394-18-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
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
index fcfc1dd..2335447 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -350,10 +350,18 @@ static inline int lockdep_match_key(struct lockdep_map *lock,
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
@@ -599,9 +607,14 @@ static inline void print_irqtrace_events(struct task_struct *curr)
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
index c4f76a3..09128d5 100644
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
index 754a718..bdc7e94 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2430,7 +2430,10 @@ static inline void inc_chains(void)
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
@@ -2452,15 +2455,15 @@ static inline void inc_chains(void)
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
@@ -2563,7 +2566,7 @@ static inline void inc_chains(void)
 	 * write-lock never takes any other locks, then the reads are
 	 * equivalent to a NOP.
 	 */
-	if (next->read == 2 || prev->read == 2)
+	if (next->read == LOCK_TYPE_RECURSIVE || prev->read == LOCK_TYPE_RECURSIVE)
 		return 1;
 
 	if (!*trace) {
@@ -2946,7 +2949,7 @@ static int validate_chain(struct task_struct *curr, struct held_lock *next,
 		 * chain, and if it's not a second recursive-read lock. If
 		 * not, there is no need to check further.
 		 */
-		if (!(chain->depth > 1 && ret != 2))
+		if (!(chain->depth > 1 && ret != LOCK_TYPE_RECURSIVE))
 			goto out_unlock;
 	}
 
@@ -2955,7 +2958,7 @@ static int validate_chain(struct task_struct *curr, struct held_lock *next,
 	 * added:
 	 */
 	if (chain) {
-		if (hlock->read != 2 && hlock->check) {
+		if (hlock->read != LOCK_TYPE_RECURSIVE && hlock->check) {
 			int distance = curr->lockdep_depth - depth + 1;
 
 			if (!check_prev_add(curr, hlock, next, distance,
@@ -4208,7 +4211,7 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 	curr->curr_chain_key = hlock->prev_chain_key;
 
 	WARN(hlock->read, "downgrading a read lock");
-	hlock->read = 1;
+	hlock->read = LOCK_TYPE_READ;
 	hlock->acquire_ip = ip;
 
 	if (reacquire_held_locks(curr, depth, i, &merged))
-- 
1.8.3.1

