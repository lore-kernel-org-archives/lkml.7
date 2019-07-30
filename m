Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDD3C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5133D2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QN5mJONh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lITk+w3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732619AbfG3PuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:50:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55320 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfG3PuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:50:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D6E05601D7; Tue, 30 Jul 2019 15:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564501812;
        bh=/JP1Y2EdIZiRCPi3xTwtJlE1Wurz1yrOV6VPdcFkWCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QN5mJONhGG33S6GS/sEr1zTdw9uRmhfZBxkwIDCOo4XyDGK0zBx6vdIZwUBgdgwNB
         2XC5ef+EyqLkBhfgUi0aYdEk4gCp1FCG6XiiyhMuNIeBXFnxoJUL2XeaSOkmLOddqu
         KfpkRPHD8/lT1KFyqeib6b2x9G08SayYss4XNYgQ=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 09231602BC;
        Tue, 30 Jul 2019 15:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564501811;
        bh=/JP1Y2EdIZiRCPi3xTwtJlE1Wurz1yrOV6VPdcFkWCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lITk+w3TLg21Vd1q4AcilPdYX/x91iu4uSMVjP/sXPSB15PJoYvJtsn8M0ux13RMP
         dxvxV36sb0hA3sKoR+y1ZWGSVe8UfsEeFeBlbt16Ye3JdCrhIfBjTA1AYg0GeTFEkS
         YvGAZPqnrg2ozLMAlgYFqRQ0H4y323uPH1fcENPM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 09231602BC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 1/2 v2] locking/mutex: Make __mutex_owner static to mutex.c
Date:   Tue, 30 Jul 2019 21:19:53 +0530
Message-Id: <1564501794-11379-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20190730080308.GF31381@hirez.programming.kicks-ass.net>
References: <20190730080308.GF31381@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__mutex_owner() should only be used by the mutex api's.
So, put this restiction let's move the __mutex_owner()
function definition from linux/mutex.h to mutex.c file.

There exist functions that uses __mutex_owner() like
mutex_is_locked() and mutex_trylock_recursive(), So
to keep the thing intact move them as well and
export them.

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
Changes in v2:
- On Peterz suggestion, moved __mutex_owner() to mutex.c to
  make it static to mutex.c.

- Exported mutex_is_owner() and mutex_trylock_recursive()
  to keep the existing thing intact as there are loadable
  modules which uses these functions.

 include/linux/mutex.h  | 44 +++-----------------------------------------
 kernel/locking/mutex.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 41 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index dcd03fe..841b47d 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -66,16 +66,6 @@ struct mutex {
 };
 
 /*
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
  * This is the control structure for tasks blocked on mutex,
  * which resides on the blocked task's kernel stack:
  */
@@ -138,17 +128,10 @@ static inline void mutex_destroy(struct mutex *lock) {}
 extern void __mutex_init(struct mutex *lock, const char *name,
 			 struct lock_class_key *key);
 
-/**
- * mutex_is_locked - is the mutex locked
- * @lock: the mutex to be queried
- *
- * Returns true if the mutex is locked, false if unlocked.
- */
-static inline bool mutex_is_locked(struct mutex *lock)
-{
-	return __mutex_owner(lock) != NULL;
-}
+extern inline bool mutex_is_locked(struct mutex *lock);
 
+extern inline /* __deprecated */ __must_check enum mutex_trylock_recursive_enum
+mutex_trylock_recursive(struct mutex *lock);
 /*
  * See kernel/locking/mutex.c for detailed documentation of these APIs.
  * Also see Documentation/locking/mutex-design.rst.
@@ -208,25 +191,4 @@ enum mutex_trylock_recursive_enum {
 	MUTEX_TRYLOCK_RECURSIVE,
 };
 
-/**
- * mutex_trylock_recursive - trylock variant that allows recursive locking
- * @lock: mutex to be locked
- *
- * This function should not be used, _ever_. It is purely for hysterical GEM
- * raisins, and once those are gone this will be removed.
- *
- * Returns:
- *  - MUTEX_TRYLOCK_FAILED    - trylock failed,
- *  - MUTEX_TRYLOCK_SUCCESS   - lock acquired,
- *  - MUTEX_TRYLOCK_RECURSIVE - we already owned the lock.
- */
-static inline /* __deprecated */ __must_check enum mutex_trylock_recursive_enum
-mutex_trylock_recursive(struct mutex *lock)
-{
-	if (unlikely(__mutex_owner(lock) == current))
-		return MUTEX_TRYLOCK_RECURSIVE;
-
-	return mutex_trylock(lock);
-}
-
 #endif /* __LINUX_MUTEX_H */
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 5e06973..f73250a 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -65,6 +65,50 @@
 
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
+/**
+ * mutex_is_locked - is the mutex locked
+ * @lock: the mutex to be queried
+ *
+ * Returns true if the mutex is locked, false if unlocked.
+ */
+inline bool mutex_is_locked(struct mutex *lock)
+{
+	return __mutex_owner(lock) != NULL;
+}
+EXPORT_SYMBOL(mutex_is_locked);
+
+/**
+ * mutex_trylock_recursive - trylock variant that allows recursive locking
+ * @lock: mutex to be locked
+ *
+ * This function should not be used, _ever_. It is purely for hysterical GEM
+ * raisins, and once those are gone this will be removed.
+ *
+ * Returns:
+ *  - MUTEX_TRYLOCK_FAILED    - trylock failed,
+ *  - MUTEX_TRYLOCK_SUCCESS   - lock acquired,
+ *  - MUTEX_TRYLOCK_RECURSIVE - we already owned the lock.
+ */
+inline /* __deprecated */ __must_check enum mutex_trylock_recursive_enum
+mutex_trylock_recursive(struct mutex *lock)
+{
+	if (unlikely(__mutex_owner(lock) == current))
+		return MUTEX_TRYLOCK_RECURSIVE;
+
+	return mutex_trylock(lock);
+}
+EXPORT_SYMBOL(mutex_trylock_recursive);
+
 static inline struct task_struct *__owner_task(unsigned long owner)
 {
 	return (struct task_struct *)(owner & ~MUTEX_FLAGS);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

