Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1940C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CC0208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OzDg2jsk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bsVZVswv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388405AbfGaPFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:05:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33096 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388373AbfGaPFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:05:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 41DB960734; Wed, 31 Jul 2019 15:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564585518;
        bh=v0COS4tNlV7f7PeQ6BOjxhVexjyTJsR2wjbJA9V2fBY=;
        h=From:To:Cc:Subject:Date:From;
        b=OzDg2jskxJ+RIqPi5gFdN8y41ntPKoMWlJxwh8s8xyT22ogAUGCbPgdfZG4XH4toE
         kJ5KPn7sbVZLpqTvqykTiCFeje4uBxvpvIGPclqXpMwaYeBuCWe7BcB6BiUI3gI37a
         pSnK5RFYsacO35gHnlESnCuSg7a5KUSWhrX6DKME=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6130F60734;
        Wed, 31 Jul 2019 15:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564585517;
        bh=v0COS4tNlV7f7PeQ6BOjxhVexjyTJsR2wjbJA9V2fBY=;
        h=From:To:Cc:Subject:Date:From;
        b=bsVZVswv28U8yTQafSaWPdx8YVvBxv3winJCgIW2vltEmEJx1hsx854WtNDEnOUOa
         t436Sj1YlnvPvH0R+GWke6sPogOSO/u9SvmxOHCe4BMuDYQb0sY5liDNjLymBtLk9d
         Y3s4zqISE/eYrqLnVlsO1a2kcgaXYZCXshwCNXww=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6130F60734
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 1/2 v3] locking/mutex: Make __mutex_owner static to mutex.c
Date:   Wed, 31 Jul 2019 20:35:03 +0530
Message-Id: <1564585504-3543-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
Changes in v3:
- Moved mutex_waiter and removed inline from mutex_trylock_recursive()
  mutex_is_owner().
  
Changes in v2:
- On Peterz suggestion, moved __mutex_owner() to mutex.c to
  make it static to mutex.c.

- Exported mutex_is_owner() and mutex_trylock_recursive()
  to keep the existing thing intact as there are loadable
  modules which uses these functions.

 include/linux/mutex.h  | 38 +++-----------------------------------
 kernel/locking/mutex.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 35 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index dcd03fe..eb8c62a 100644
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
index 5e06973..ac4929f 100644
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
@@ -65,11 +78,37 @@
 
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
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

