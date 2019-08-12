Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD142C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DAF20665
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFtKDTyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfHLNuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:50:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33363 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfHLNuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:50:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so47809069plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 06:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kgjlojbfW5hiV8CTp3aJEp6Pk3hldkLco+LbMqOikOM=;
        b=MFtKDTySLemv5hjlvnaqkMQcPHYei/01QsdYQ90ndYBeqByXLobvq0zenKaRVxHrIv
         1RFnovoMSvqVoSC6n36SD48DvBnsQ+9cqxvriKmxsa36S64Xos4fFHLxXdJqbzQJ6j3I
         bUy0drkxOJ+V4jNQUbbqN4bWhsS4Q3eTnF58HEb/b6ITQcu8tenx24pLiO90GgXX4w3m
         MT5sh76ZIEAuww1SQJcgZjKot7H+j9+d7BA6xaYqMp9ZFTdzi200Vc+5XVMq/nwDg25J
         O0Me39MucOuF3Zfq4sx1+nawOeUjSPSq37OgqsAXOtEW/rt4iu6SzGEIDgHOTyZKMI6Z
         2byQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kgjlojbfW5hiV8CTp3aJEp6Pk3hldkLco+LbMqOikOM=;
        b=ogJEF2ljK1ovpfgGiEgrAJmD+zeJaYIf3wSr16nxWXX4E2azdyM/7huHo4OeeDa4Cf
         hvuPo7gt/XSPRBujutecN7oKDq9ccXq1+kRmdNiWAFsamirfCS6ys2WVplhDtR9hNpxX
         bkWNrt6t0qqWRXzEgZWI5YH8JL8dpswZzO5hOu2lwwMCDDqpToUFr9nvMaxy62diLTu0
         llu6apuzzp/YccPsxsmG2xpuBN9nPLfSumSoeKGXKdZ0Jmhztqx/BWdXQ8XWgY/hqQSN
         r+PVG8QAwkLMwnMMz6pbN9bJVGWJJ5EemKYz/JUtIj4dUDHNH9/3/JdiVD8aPq8Zvn/s
         BsJg==
X-Gm-Message-State: APjAAAXZxO6dF9NpBIOJlyp/IDIav5lzvV6tCMJX1BRuDcJ+HV6aGdFG
        dY9HvugF+osN4dKqobYDcwo=
X-Google-Smtp-Source: APXvYqw1VeItPTCPnM27HFTmOps2KtzHun1k8+c0C1iKwyvH0yUw9J39p7kW2kc9Wl9DTd3Yu0KxSw==
X-Received: by 2002:a17:902:5a5:: with SMTP id f34mr18397733plf.178.1565617800304;
        Mon, 12 Aug 2019 06:50:00 -0700 (PDT)
Received: from satendra-MM061.ib-wrb304n.setup.in ([103.82.150.135])
        by smtp.gmail.com with ESMTPSA id x9sm78656304pgp.75.2019.08.12.06.49.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 06:49:59 -0700 (PDT)
From:   Satendra Singh Thakur <sst2005@gmail.com>
Cc:     Satendra Singh Thakur <sst2005@gmail.com>,
        Satendra Singh Thakur <satendrasingh.thakur@hcl.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] [semaphore] Removed redundant code from semaphore's down family of function
Date:   Mon, 12 Aug 2019 19:18:59 +0530
Message-Id: <20190812134859.16061-1-sst2005@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190812053014.27743-1-satendrasingh.thakur@hcl.com>
References: <20190812053014.27743-1-satendrasingh.thakur@hcl.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-The semaphore code has four funcs
down,
down_interruptible,
down_killable,
down_timeout
-These four funcs have almost similar code except that
they all call lower level function __down_xyz.
-This lower level func in-turn call inline func
__down_common with appropriate arguments.
-This patch creates a common macro for above family of funcs
so that duplicate code is eliminated.
-Also, __down_common has been made noinline so that code is
functionally similar to previous one
-For example, earlier down_killable would call __down_killable
, which in-turn would call inline func __down_common
Now, down_killable calls noinline __down_common directly
through a macro
-The funcs __down_interruptible, __down_killable etc have been
removed as they were just wrapper to __down_common

Signed-off-by: Satendra Singh Thakur <satendrasingh.thakur@hcl.com>
---
 v1: removed disclaimer appended automatically by company mail policy

 kernel/locking/semaphore.c | 107 +++++++++++++------------------------
 1 file changed, 38 insertions(+), 69 deletions(-)

diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index d9dd94defc0a..0468bc335908 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -33,11 +33,33 @@
 #include <linux/spinlock.h>
 #include <linux/ftrace.h>
 
-static noinline void __down(struct semaphore *sem);
-static noinline int __down_interruptible(struct semaphore *sem);
-static noinline int __down_killable(struct semaphore *sem);
-static noinline int __down_timeout(struct semaphore *sem, long timeout);
+static noinline int __sched __down_common(struct semaphore *sem, long state,
+								long timeout);
 static noinline void __up(struct semaphore *sem);
+/**
+ * down_common - acquire the semaphore
+ * @sem: the semaphore to be acquired
+ * @state: new state of the task
+ * @timeout: either MAX_SCHEDULE_TIMEOUT or actual specified
+ * timeout
+ * Acquires the semaphore. If no more tasks are allowed to
+ * acquire the semaphore, calling this macro will put the task
+ * to sleep until the semaphore is released.
+ *
+ * This internally calls another func __down_common.
+ */
+#define down_common(sem, state, timeout)	\
+({	\
+	int ret = 0;	\
+	unsigned long flags;	\
+	raw_spin_lock_irqsave(&(sem)->lock, flags);	\
+	if (likely((sem)->count > 0))	\
+		(sem)->count--;	\
+	else	\
+		ret = __down_common(sem, state, timeout);	\
+	raw_spin_unlock_irqrestore(&(sem)->lock, flags);	\
+	ret;	\
+})
 
 /**
  * down - acquire the semaphore
@@ -52,14 +74,7 @@ static noinline void __up(struct semaphore *sem);
  */
 void down(struct semaphore *sem)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&sem->lock, flags);
-	if (likely(sem->count > 0))
-		sem->count--;
-	else
-		__down(sem);
-	raw_spin_unlock_irqrestore(&sem->lock, flags);
+	down_common(sem, TASK_UNINTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
 }
 EXPORT_SYMBOL(down);
 
@@ -74,17 +89,7 @@ EXPORT_SYMBOL(down);
  */
 int down_interruptible(struct semaphore *sem)
 {
-	unsigned long flags;
-	int result = 0;
-
-	raw_spin_lock_irqsave(&sem->lock, flags);
-	if (likely(sem->count > 0))
-		sem->count--;
-	else
-		result = __down_interruptible(sem);
-	raw_spin_unlock_irqrestore(&sem->lock, flags);
-
-	return result;
+	return down_common(sem, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
 }
 EXPORT_SYMBOL(down_interruptible);
 
@@ -100,17 +105,7 @@ EXPORT_SYMBOL(down_interruptible);
  */
 int down_killable(struct semaphore *sem)
 {
-	unsigned long flags;
-	int result = 0;
-
-	raw_spin_lock_irqsave(&sem->lock, flags);
-	if (likely(sem->count > 0))
-		sem->count--;
-	else
-		result = __down_killable(sem);
-	raw_spin_unlock_irqrestore(&sem->lock, flags);
-
-	return result;
+	return down_common(sem, TASK_KILLABLE, MAX_SCHEDULE_TIMEOUT);
 }
 EXPORT_SYMBOL(down_killable);
 
@@ -154,17 +149,7 @@ EXPORT_SYMBOL(down_trylock);
  */
 int down_timeout(struct semaphore *sem, long timeout)
 {
-	unsigned long flags;
-	int result = 0;
-
-	raw_spin_lock_irqsave(&sem->lock, flags);
-	if (likely(sem->count > 0))
-		sem->count--;
-	else
-		result = __down_timeout(sem, timeout);
-	raw_spin_unlock_irqrestore(&sem->lock, flags);
-
-	return result;
+	return down_common(sem, TASK_UNINTERRUPTIBLE, timeout);
 }
 EXPORT_SYMBOL(down_timeout);
 
@@ -196,12 +181,15 @@ struct semaphore_waiter {
 	bool up;
 };
 
-/*
- * Because this function is inlined, the 'state' parameter will be
- * constant, and thus optimised away by the compiler.  Likewise the
- * 'timeout' parameter for the cases without timeouts.
+/**
+ * __down_common - Adds the current task to wait list
+ * puts the task to sleep until signal, timeout or up flag
+ * @sem: the semaphore to be acquired
+ * @state: the state of the calling task
+ * @timeout: either MAX_SCHEDULE_TIMEOUT or actual specified
+ * timeout
  */
-static inline int __sched __down_common(struct semaphore *sem, long state,
+static noinline int __sched __down_common(struct semaphore *sem, long state,
 								long timeout)
 {
 	struct semaphore_waiter waiter;
@@ -232,25 +220,6 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
 	return -EINTR;
 }
 
-static noinline void __sched __down(struct semaphore *sem)
-{
-	__down_common(sem, TASK_UNINTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
-}
-
-static noinline int __sched __down_interruptible(struct semaphore *sem)
-{
-	return __down_common(sem, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
-}
-
-static noinline int __sched __down_killable(struct semaphore *sem)
-{
-	return __down_common(sem, TASK_KILLABLE, MAX_SCHEDULE_TIMEOUT);
-}
-
-static noinline int __sched __down_timeout(struct semaphore *sem, long timeout)
-{
-	return __down_common(sem, TASK_UNINTERRUPTIBLE, timeout);
-}
 
 static noinline void __sched __up(struct semaphore *sem)
 {
-- 
2.17.1

