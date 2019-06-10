Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6E3C468C1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 05:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E3A207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 05:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqUW3RnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387704AbfFJFxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 01:53:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39033 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387614AbfFJFxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 01:53:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id 196so4418584pgc.6
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 22:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cb3gxRBtC4jtsDqxGe/b90t+AehXfkMnaz8DHJHuAhQ=;
        b=nqUW3RnAXcR9IOWYTm7fkHv+YcFec2FrxmrgRLvCrZmwVSjiN8esU8yO/TelR0Hvdp
         99Zz1q7B7KVIu27vbEThUaL8YN3Fznu0jA7zjjBpGu4ri7A7ikJsbscMbJ3TgDcUphg5
         Lq1ebfU0YxKJ8H+JVg8jONHXJnctP9stBYq0zTZgkTLm9RaRf0tiRBhJJPfZ0VexJ7yb
         HOnfiA+iSrci7kPdsxmv5j4Mr0ENYjPpQSjWbGgs5KkdwYUzi7EVTjNIv64Ig5ZqalXM
         m5/cZJUAZdkOtYoAmw22Pte+CgXsq+y6YPfXkhqTfGnULQytZdWm1npiBnneRyBZRkl4
         8LDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cb3gxRBtC4jtsDqxGe/b90t+AehXfkMnaz8DHJHuAhQ=;
        b=n4ufAfy/LEOag2O9zqYFFN10bpoxRqCZZRqpONxUJKqR1C+VyKGj/2N4+b310wXm+b
         VjZhx+RTuJgoKhs+sTmwjbRiUL/R5ensKSDpnnk6BE4BtzXahlI3oTmqWU2Hr0x4lIBH
         SKRWggUTLlx7nTOElY3hy2lkcy0mIHa01TdK9UDC4jm5PuSqas1j0z2+fHzfs6/vRrzN
         5KF6FJGiL/jrj7/K1aasl6P9U8TKvSjkO01DwvktYrcRRX6G3LfhnPB6NYIIuqe3MN/u
         RQl9Y/bIts0yBVfvt9MzeTkOCsZkrdCIxWXRuerFwuG6MBfAbrEW+gjjgxniqxHfa5xR
         JdEQ==
X-Gm-Message-State: APjAAAWoHfN2gihRzPB+/mTB6vXb+I54wl5KUjI3Wc04tyysELHeAzHJ
        /o8NxMRzvdp7xeNj3DEQlFA=
X-Google-Smtp-Source: APXvYqyqZFgSinXJ2VcHVwPv5ixkv5+3Pt8ihi6KoWCUbyqEWpEELCULLkj3Po7EduMZ96+S+p7z3A==
X-Received: by 2002:a63:d504:: with SMTP id c4mr14044499pgg.20.1560145986524;
        Sun, 09 Jun 2019 22:53:06 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id 127sm9646147pfc.159.2019.06.09.22.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 22:53:06 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     cai@lca.pw, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH] locking/lockdep: Fix lock IRQ usage initialization bug
Date:   Mon, 10 Jun 2019 13:52:58 +0800
Message-Id: <20190610055258.6424-1-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit:

  091806515124b20 ("locking/lockdep: Consolidate lock usage bit initialization")

misses marking LOCK_USED flag at IRQ usage initialization when CONFIG_TRACE_IRQFLAGS
or CONFIG_PROVE_LOCKING is not defined. Fix it.

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 110 +++++++++++++++++++++++------------------------
 1 file changed, 53 insertions(+), 57 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 48a840a..c3db987 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3460,9 +3460,61 @@ void trace_softirqs_off(unsigned long ip)
 		debug_atomic_inc(redundant_softirqs_off);
 }
 
+static inline unsigned int task_irq_context(struct task_struct *task)
+{
+	return 2 * !!task->hardirq_context + !!task->softirq_context;
+}
+
+static int separate_irq_context(struct task_struct *curr,
+		struct held_lock *hlock)
+{
+	unsigned int depth = curr->lockdep_depth;
+
+	/*
+	 * Keep track of points where we cross into an interrupt context:
+	 */
+	if (depth) {
+		struct held_lock *prev_hlock;
+
+		prev_hlock = curr->held_locks + depth-1;
+		/*
+		 * If we cross into another context, reset the
+		 * hash key (this also prevents the checking and the
+		 * adding of the dependency to 'prev'):
+		 */
+		if (prev_hlock->irq_context != hlock->irq_context)
+			return 1;
+	}
+	return 0;
+}
+
+#else /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
+
+static inline
+int mark_lock_irq(struct task_struct *curr, struct held_lock *this,
+		enum lock_usage_bit new_bit)
+{
+	WARN_ON(1); /* Impossible innit? when we don't have TRACE_IRQFLAG */
+	return 1;
+}
+
+static inline unsigned int task_irq_context(struct task_struct *task)
+{
+	return 0;
+}
+
+static inline int separate_irq_context(struct task_struct *curr,
+		struct held_lock *hlock)
+{
+	return 0;
+}
+
+#endif /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
+
 static int
 mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
 {
+#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
 	if (!check)
 		goto lock_used;
 
@@ -3510,6 +3562,7 @@ void trace_softirqs_off(unsigned long ip)
 	}
 
 lock_used:
+#endif
 	/* mark it as used: */
 	if (!mark_lock(curr, hlock, LOCK_USED))
 		return 0;
@@ -3517,63 +3570,6 @@ void trace_softirqs_off(unsigned long ip)
 	return 1;
 }
 
-static inline unsigned int task_irq_context(struct task_struct *task)
-{
-	return 2 * !!task->hardirq_context + !!task->softirq_context;
-}
-
-static int separate_irq_context(struct task_struct *curr,
-		struct held_lock *hlock)
-{
-	unsigned int depth = curr->lockdep_depth;
-
-	/*
-	 * Keep track of points where we cross into an interrupt context:
-	 */
-	if (depth) {
-		struct held_lock *prev_hlock;
-
-		prev_hlock = curr->held_locks + depth-1;
-		/*
-		 * If we cross into another context, reset the
-		 * hash key (this also prevents the checking and the
-		 * adding of the dependency to 'prev'):
-		 */
-		if (prev_hlock->irq_context != hlock->irq_context)
-			return 1;
-	}
-	return 0;
-}
-
-#else /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
-
-static inline
-int mark_lock_irq(struct task_struct *curr, struct held_lock *this,
-		enum lock_usage_bit new_bit)
-{
-	WARN_ON(1); /* Impossible innit? when we don't have TRACE_IRQFLAG */
-	return 1;
-}
-
-static inline int
-mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
-{
-	return 1;
-}
-
-static inline unsigned int task_irq_context(struct task_struct *task)
-{
-	return 0;
-}
-
-static inline int separate_irq_context(struct task_struct *curr,
-		struct held_lock *hlock)
-{
-	return 0;
-}
-
-#endif /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
-
 /*
  * Mark a lock with a usage bit, and validate the state transition:
  */
-- 
1.8.3.1

