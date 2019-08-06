Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E3CC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D58620C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="p1Fc7dSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732560AbfHFNGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:06:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44915 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731379AbfHFNGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:06:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x76D6WBe2187767
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 6 Aug 2019 06:06:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x76D6WBe2187767
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565096793;
        bh=AtCqteFjldMB6T0RG6+s029XovRQR+lH66/cIYM5M/Q=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=p1Fc7dSS8EY0GsBuaunxLYcf7IrvCwQN6gldM+2GfsKzkyF46o0MK+nCnnp4K+2uZ
         De9M/5SmzEPvz02/QOvobwLll7XER7RH8PV74j9FIjryfJgT1bZUHQkbPMNTMZJowR
         DuvK0OxhKPhHxTia21nQve8wQAzii1Ip/AGDbyA/nD9pm9b+ZZ2PuFWMLJlLeax/1F
         U7vLODHflZUHTkU/oOhr+8mJbG+GRWwa3B10OvtEvj5wD5xNJwCzU4gu2dwkuJFbeU
         YoyWBsWPHStiD9Na9gEDqcvQxXODPhRshnoDCpa3PjyqbwyD9uC29WoVWgTVG2S9VV
         Y69zuD02mpV6A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x76D6WMw2187764;
        Tue, 6 Aug 2019 06:06:32 -0700
Date:   Tue, 6 Aug 2019 06:06:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mukesh Ojha <tipbot@zytor.com>
Message-ID: <tip-5f35d5a66b3ec62cb5ec4ec2ad9aebe2ac325673@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        mojha@codeaurora.org
Reply-To: peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
          mojha@codeaurora.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <1564585504-3543-1-git-send-email-mojha@codeaurora.org>
References: <1564585504-3543-1-git-send-email-mojha@codeaurora.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/mutex: Make __mutex_owner static to
 mutex.c
Git-Commit-ID: 5f35d5a66b3ec62cb5ec4ec2ad9aebe2ac325673
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5f35d5a66b3ec62cb5ec4ec2ad9aebe2ac325673
Gitweb:     https://git.kernel.org/tip/5f35d5a66b3ec62cb5ec4ec2ad9aebe2ac325673
Author:     Mukesh Ojha <mojha@codeaurora.org>
AuthorDate: Wed, 31 Jul 2019 20:35:03 +0530
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Tue, 6 Aug 2019 12:49:16 +0200

locking/mutex: Make __mutex_owner static to mutex.c

__mutex_owner() should only be used by the mutex api's.
So, to put this restiction let's move the __mutex_owner()
function definition from linux/mutex.h to mutex.c file.

There exist functions that uses __mutex_owner() like
mutex_is_locked() and mutex_trylock_recursive(), So
to keep legacy thing intact move them as well and
export them.

Move mutex_waiter structure also to keep it private to the
file.

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: mingo@redhat.com
Cc: will@kernel.org
Link: https://lkml.kernel.org/r/1564585504-3543-1-git-send-email-mojha@codeaurora.org
---
 include/linux/mutex.h  | 38 +++-----------------------------------
 kernel/locking/mutex.c | 39 +++++++++++++++++++++++++++++++++++++++
 kernel/locking/mutex.h |  2 ++
 3 files changed, 44 insertions(+), 35 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index dcd03fee6e01..eb8c62aba263 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -65,29 +65,6 @@ struct mutex {
 #endif
 };
 
-/*
- * Internal helper function; C doesn't allow us to hide it :/
- *
- * DO NOT USE (outside of mutex code).
- */
-static inline struct task_struct *__mutex_owner(struct mutex *lock)
-{
-	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~0x07);
-}
-
-/*
- * This is the control structure for tasks blocked on mutex,
- * which resides on the blocked task's kernel stack:
- */
-struct mutex_waiter {
-	struct list_head	list;
-	struct task_struct	*task;
-	struct ww_acquire_ctx	*ww_ctx;
-#ifdef CONFIG_DEBUG_MUTEXES
-	void			*magic;
-#endif
-};
-
 #ifdef CONFIG_DEBUG_MUTEXES
 
 #define __DEBUG_MUTEX_INITIALIZER(lockname)				\
@@ -144,10 +121,7 @@ extern void __mutex_init(struct mutex *lock, const char *name,
  *
  * Returns true if the mutex is locked, false if unlocked.
  */
-static inline bool mutex_is_locked(struct mutex *lock)
-{
-	return __mutex_owner(lock) != NULL;
-}
+extern bool mutex_is_locked(struct mutex *lock);
 
 /*
  * See kernel/locking/mutex.c for detailed documentation of these APIs.
@@ -220,13 +194,7 @@ enum mutex_trylock_recursive_enum {
  *  - MUTEX_TRYLOCK_SUCCESS   - lock acquired,
  *  - MUTEX_TRYLOCK_RECURSIVE - we already owned the lock.
  */
-static inline /* __deprecated */ __must_check enum mutex_trylock_recursive_enum
-mutex_trylock_recursive(struct mutex *lock)
-{
-	if (unlikely(__mutex_owner(lock) == current))
-		return MUTEX_TRYLOCK_RECURSIVE;
-
-	return mutex_trylock(lock);
-}
+extern /* __deprecated */ __must_check enum mutex_trylock_recursive_enum
+mutex_trylock_recursive(struct mutex *lock);
 
 #endif /* __LINUX_MUTEX_H */
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 5e069734363c..ac4929f1e085 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -36,6 +36,19 @@
 # include "mutex.h"
 #endif
 
+/*
+ * This is the control structure for tasks blocked on mutex,
+ * which resides on the blocked task's kernel stack:
+ */
+struct mutex_waiter {
+	struct list_head	list;
+	struct task_struct	*task;
+	struct ww_acquire_ctx	*ww_ctx;
+#ifdef CONFIG_DEBUG_MUTEXES
+	void			*magic;
+#endif
+};
+
 void
 __mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
 {
@@ -65,11 +78,37 @@ EXPORT_SYMBOL(__mutex_init);
 
 #define MUTEX_FLAGS		0x07
 
+/*
+ * Internal helper function; C doesn't allow us to hide it :/
+ *
+ * DO NOT USE (outside of mutex code).
+ */
+static inline struct task_struct *__mutex_owner(struct mutex *lock)
+{
+	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~0x07);
+}
+
 static inline struct task_struct *__owner_task(unsigned long owner)
 {
 	return (struct task_struct *)(owner & ~MUTEX_FLAGS);
 }
 
+bool mutex_is_locked(struct mutex *lock)
+{
+	return __mutex_owner(lock) != NULL;
+}
+EXPORT_SYMBOL(mutex_is_locked);
+
+__must_check enum mutex_trylock_recursive_enum
+mutex_trylock_recursive(struct mutex *lock)
+{
+	if (unlikely(__mutex_owner(lock) == current))
+		return MUTEX_TRYLOCK_RECURSIVE;
+
+	return mutex_trylock(lock);
+}
+EXPORT_SYMBOL(mutex_trylock_recursive);
+
 static inline unsigned long __owner_flags(unsigned long owner)
 {
 	return owner & MUTEX_FLAGS;
diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index 1c2287d3fa71..7cde5c6d414e 100644
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -19,6 +19,8 @@
 #define debug_mutex_unlock(lock)			do { } while (0)
 #define debug_mutex_init(lock, name, key)		do { } while (0)
 
+struct mutex_waiter;
+
 static inline void
 debug_mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter)
 {
