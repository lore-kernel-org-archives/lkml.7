Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FA1C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4757520693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BoxjXDzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732791AbfG3QCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:02:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59726 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730449AbfG3QCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IOuBAuvmhysKzPvVUU/qlP1A0SFRzJAQWgg7qBQnYJE=; b=BoxjXDzGwt6hpFA+6s3Z+N9gL
        j7c5Fu9XcRFjuFyF4zcG+bVgDyiHOsrDXeIe9xPVIGt2hdssabCp2HlzEHgZvbokzTxemEi7VZBNX
        rt5SrKslFTzS/5Ltnx2Vvp5ayzazXqpouPgo1lOWEvl1iQrflklJVh/rNzAvlNYRpDiSVUa4cLU90
        8g6O7/4MpVYUXTakQwx3q7XsebZty38p1H8qym1t4k7gUqbO3aApOESdeHxfU2HE0M3tDfmnGj8c/
        SW2+TgVcLNuT3T9jl9GzwgUWydSkhx5oLoX1f+AEaXv0mFbj6xiuKWui1EdMZHtVYCsevDsRd2ZfX
        AKXQflZYg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsUaF-0000xd-7h; Tue, 30 Jul 2019 16:02:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DC1EB2029F869; Tue, 30 Jul 2019 18:02:36 +0200 (CEST)
Date:   Tue, 30 Jul 2019 18:02:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] locking/mutex: Use mutex flags macro instead of hard
 code value
Message-ID: <20190730160236.GN31381@hirez.programming.kicks-ass.net>
References: <1564397578-28423-1-git-send-email-mojha@codeaurora.org>
 <1564397578-28423-2-git-send-email-mojha@codeaurora.org>
 <20190729110727.GB31398@hirez.programming.kicks-ass.net>
 <a80972a1-8e24-33cb-0088-49ef0e680540@codeaurora.org>
 <20190730080308.GF31381@hirez.programming.kicks-ass.net>
 <6b0fd5fd-b3e2-585e-286d-de8ed3c21e66@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b0fd5fd-b3e2-585e-286d-de8ed3c21e66@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 06:10:49PM +0530, Mukesh Ojha wrote:

> To make it static , i have to export mutex_is_locked() after moving it
> inside mutex.c, so that other module can use it.

Yep, see below -- completely untested.

> Also are we thinking of removing
> static inline /* __deprecated */ __must_check enum
> mutex_trylock_recursive_enum
> mutex_trylock_recursive(struct mutex *lock)
> 
> inside linux/mutex.h in future ?
> 
> As i see it is used at one or two places and there is a check inside
> checkpatch guarding its further use .

That was the idea; recursive locking is evil, but we have these two
legacy sites.

---

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
index 5e069734363c..2f73935a6053 100644
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
@@ -65,6 +78,16 @@ EXPORT_SYMBOL(__mutex_init);
 
 #define MUTEX_FLAGS		0x07
 
+/*
+ * Internal helper function; C doesn't allow us to hide it :/
+ *
+ * DO NOT USE (outside of mutex code).
+ */
+static inline struct task_struct *__mutex_owner(struct mutex *lock)
+{
+	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~MUTEX_FLAGS);
+}
+
 static inline struct task_struct *__owner_task(unsigned long owner)
 {
 	return (struct task_struct *)(owner & ~MUTEX_FLAGS);
@@ -75,6 +98,22 @@ static inline unsigned long __owner_flags(unsigned long owner)
 	return owner & MUTEX_FLAGS;
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
 /*
  * Trylock variant that retuns the owning task on failure.
  */
