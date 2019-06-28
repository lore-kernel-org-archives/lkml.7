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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D93C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC1F208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVcaiuJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfF1JPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:15:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35356 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfF1JPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:15:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so2911785plp.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLF10tHXSYj9nlQOchCpax5oxJ4CM95wZZZyCb5aYKQ=;
        b=fVcaiuJep4MSYMlT4ryvMOy4WMX248CdSsJXwtQNkTSEFa+jimM0sjIK5pCODQ0wrG
         SDLLzBFHmhxERswiwzL9RaK5w8vKu3/oPUd+v5nBmWxGdR1amcJg5H9PFxcVXpgNpTxE
         UqZxB/Gb5RdsFSqiXfRq+gzzJMmq2mHZksoyuDDkAwrdwhR9S9X/sp5kwErjq9NX3DBo
         WFqkbrJlJbx8DFwT8Kp63wPycofD8cD/pR4j+VEBJx7p9JrSfPZ/kM5ERq+yEMbYtBgv
         +X5J30h0y6ni9/aULs7bSjKFken08KuoqOPmUWsFxKp1KUslyEnMbYeJJPQOSh54lAk8
         OWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLF10tHXSYj9nlQOchCpax5oxJ4CM95wZZZyCb5aYKQ=;
        b=ppvjvp3fXAkqAsgUZakTgzz1YUfwDUsAuWxDYlr9Y/eiucEebHbxBJIB88tUBQ4LkE
         FntjYXJPNSQcu79rkVnelX+RHPw1mnq/lo0gwm8GrYpmptsQRGBQGt86qFPiUOvOK1Kh
         4GkR+pak5LOlvGlWoXlk6S3IVNn4Px9DMoC+4j8oZgDoAuOhwjyn+aEushVtHH8e7jou
         7yR+4HXa1ArlJzX14eiQOjbbB0hjJwTzWM1hYfOqJocNsILRQrJ3lPrAfxJvgli4MNua
         JWT7E1mq/ZnEQ0w6H/VOQC06Fv8XF5BK6DMnj9Go9+H/CKm8QgKFnLfHAPF8Yfy5Kkvb
         H6Tg==
X-Gm-Message-State: APjAAAWlH2WqBl7vkz0EEM2jd/O7yyr0tCHnl6UCqhOgtS9vDlml+5Vq
        IOkvTwD1NRxzyDSmRPgEWHg=
X-Google-Smtp-Source: APXvYqwQ9/oC6Q5HdxnbnLCzvvjjjNyj2w6SeKAEzz4kBImalTAq5TojsXsdjvms4wvmjJqErm70pA==
X-Received: by 2002:a17:902:363:: with SMTP id 90mr10061456pld.340.1561713347883;
        Fri, 28 Jun 2019 02:15:47 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:15:47 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 01/30] locking/lockdep: Rename deadlock check functions
Date:   Fri, 28 Jun 2019 17:14:59 +0800
Message-Id: <20190628091528.17059-2-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deadlock checks are performed at two places:

 - Within current's held lock stack, check for lock recursion deadlock.
 - Within dependency graph, check for lock inversion deadlock.

Rename the two relevant functions for later use. Plus, with
recursive-read locks, only a dependency circle in graph is not a
sufficient condition for lock inversion deadlocks anymore, so
check_noncircular() is not entirely accurate.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 341f521..e30e9e4 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1714,8 +1714,8 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
  * Print an error and return 0 if it does.
  */
 static noinline int
-check_noncircular(struct held_lock *src, struct held_lock *target,
-		  struct lock_trace *trace)
+check_deadlock_graph(struct held_lock *src, struct held_lock *target,
+		     struct lock_trace *trace)
 {
 	int ret;
 	struct lock_list *uninitialized_var(target_entry);
@@ -2302,7 +2302,8 @@ static inline void inc_chains(void)
 }
 
 /*
- * Check whether we are holding such a class already.
+ * Check whether we are holding such a class already in the current
+ * held lock stack.
  *
  * (Note that this has to be done separately, because the graph cannot
  * detect such classes of deadlocks.)
@@ -2310,7 +2311,7 @@ static inline void inc_chains(void)
  * Returns: 0 on deadlock detected, 1 on OK, 2 on recursive read
  */
 static int
-check_deadlock(struct task_struct *curr, struct held_lock *next)
+check_deadlock_current(struct task_struct *curr, struct held_lock *next)
 {
 	struct held_lock *prev;
 	struct held_lock *nest = NULL;
@@ -2394,7 +2395,7 @@ static inline void inc_chains(void)
 
 	/*
 	 * Prove that the new <prev> -> <next> dependency would not
-	 * create a circular dependency in the graph. (We do this by
+	 * create a deadlock scenario in the graph. (We do this by
 	 * a breadth-first search into the graph starting at <next>,
 	 * and check whether we can reach <prev>.)
 	 *
@@ -2402,7 +2403,7 @@ static inline void inc_chains(void)
 	 * MAX_CIRCULAR_QUEUE_SIZE) which keeps track of a breadth of nodes
 	 * in the graph whose neighbours are to be checked.
 	 */
-	ret = check_noncircular(next, prev, trace);
+	ret = check_deadlock_graph(next, prev, trace);
 	if (unlikely(ret <= 0))
 		return 0;
 
@@ -2878,7 +2879,7 @@ static int validate_chain(struct task_struct *curr,
 		 * The simple case: does the current hold the same lock
 		 * already?
 		 */
-		int ret = check_deadlock(curr, hlock);
+		int ret = check_deadlock_current(curr, hlock);
 
 		if (!ret)
 			return 0;
-- 
1.8.3.1

