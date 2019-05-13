Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4BAC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD88E21479
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACv6VZoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfEMJNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:13:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42194 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbfEMJNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:13:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id 145so6445951pgg.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 02:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cLJ1ldOM7IleRggUIq7aKinRSCo8rE9wEnfY75h347Q=;
        b=ACv6VZoWCPqFKrhwTkbqNjypin55cwcva3nJN9j4cbou2rAm8cv4A+Q0q5foEgv9/R
         35gyirq/JzkgED9/XzY7kFXu30fpoVvj1DgVJD8FVvX6sVVrQvgBYpubW9cFOIww8Bsc
         Rs8oeHlDp/hff70dYy7vjWftm3b821vYtHy6cGSX8ohNGrlte5n9sz1xcSg9H/psuLXr
         fwDS3HX7Jtfq6xrx7g2xQ9CYHCfUIJk2hF6jcyoLpWf0Yhq6sOaZRFOuo/pHDC+z1sr3
         cAxIQo/d8oFLW7jeYg4IznZiEc/gbvYRwBsgeBIixEtTcPq1Ka9H+CzwLjg2qshYkw/h
         UaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cLJ1ldOM7IleRggUIq7aKinRSCo8rE9wEnfY75h347Q=;
        b=jWNTkFLAkMS0fSow8hD9labgMLO/iCWeLh6XljP5SZ+ynj+ZEOsNORCBYYcLSv6FLX
         iyx9+jVV2hUEsDMC7Ir8qqIk7bL47e9jvo7jFTmVQGD7M9ThfWk23s6T76lTz9PvHY7A
         9pQs1kxxCR1FI8CrEGHLwOZdUA0c8LmCXTmI0ULwkQXx4OJzHkflVK1KHI66sAN4SXa2
         qdoYV52qPm3RQYighU2thNiwaX3wrBytl6dZ8U/qC3frvqT7YsP4hasFY4dv9fQ7bc1i
         EnvrMcunbukbmnsLR5HF2nCa9xHrb388XPmoraHEkAmpaPFI7i5SCsJDpnebvVVAaENI
         QxuA==
X-Gm-Message-State: APjAAAUKawmsJD1+SiLuED5Y6bOmYZ65k8OMugoF1/S5VI2XjSOJe3r8
        /96cMkFtNTm7P9Qsfeg+4a8=
X-Google-Smtp-Source: APXvYqwZbB6se6HGY4NbadOsmi7ZuCImW+/4meH3D/zVn2OXZ7XrOR+oT6+QgE1BEDN0YGGg7DhVtQ==
X-Received: by 2002:a62:3381:: with SMTP id z123mr32660077pfz.42.1557738813792;
        Mon, 13 May 2019 02:13:33 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id n18sm35500837pfi.48.2019.05.13.02.13.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 02:13:33 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 05/17] locking/lockdep: Rename deadlock check functions
Date:   Mon, 13 May 2019 17:11:51 +0800
Message-Id: <20190513091203.7299-6-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190513091203.7299-1-duyuyang@gmail.com>
References: <20190513091203.7299-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deadlock checks are performed at two places:

 - Within current's held lock stack, check for lock recursion deadlock.
 - Within dependency graph, check for lock inversion deadlock.

Rename the two relevant functions for later use. Plus, with read locks,
dependency circle in graph is not a sufficient condition for lock
inversion deadlocks anymore, so check_noncircular() is not entirely
accurate.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 27ca55f..4adaf27 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1771,8 +1771,8 @@ static inline void set_lock_type2(struct lock_list *lock, int read)
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
@@ -2385,7 +2385,8 @@ static inline void inc_chains(void)
 }
 
 /*
- * Check whether we are holding such a class already.
+ * Check whether we are holding such a class already in current
+ * context's held lock stack.
  *
  * (Note that this has to be done separately, because the graph cannot
  * detect such classes of deadlocks.)
@@ -2396,7 +2397,7 @@ static inline void inc_chains(void)
  *  2: LOCK_TYPE_RECURSIVE on recursive read
  */
 static int
-check_deadlock(struct task_struct *curr, struct held_lock *next)
+check_deadlock_current(struct task_struct *curr, struct held_lock *next)
 {
 	struct held_lock *prev;
 	struct held_lock *nest = NULL;
@@ -2480,7 +2481,7 @@ static inline void inc_chains(void)
 
 	/*
 	 * Prove that the new <prev> -> <next> dependency would not
-	 * create a circular dependency in the graph. (We do this by
+	 * create a deadlock scenario in the graph. (We do this by
 	 * a breadth-first search into the graph starting at <next>,
 	 * and check whether we can reach <prev>.)
 	 *
@@ -2488,7 +2489,7 @@ static inline void inc_chains(void)
 	 * MAX_CIRCULAR_QUEUE_SIZE) which keeps track of a breadth of nodes
 	 * in the graph whose neighbours are to be checked.
 	 */
-	ret = check_noncircular(next, prev, trace);
+	ret = check_deadlock_graph(next, prev, trace);
 	if (unlikely(ret <= 0))
 		return 0;
 
@@ -2983,7 +2984,7 @@ static int validate_chain(struct task_struct *curr,
 		 * The simple case: does the current hold the same lock
 		 * already?
 		 */
-		int ret = check_deadlock(curr, hlock);
+		int ret = check_deadlock_current(curr, hlock);
 
 		if (!ret)
 			return 0;
-- 
1.8.3.1

