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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20641C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E705D233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AP9qaacm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfH2Ibu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:31:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43598 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfH2Ibt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:31:49 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so1230351pld.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PdlvwnGEzcFCAXeOFNM8mKM5jXwMmc9nBvJCjWEqLJs=;
        b=AP9qaacmgc66TcZAS96mcNHpmHkXa2YSjhhR+Zm0HxyoCaYgyltFEztJRiFJzy7qsT
         sfa8sVQIXUrFxLLbcEnMR4b93etILParDz+y/cCdUoyHPdii4l9u3866Kx4P82Hna8CY
         nuJaRUiQe9/4krZc61/4tWDfzrBMTawBTATCjRos6aUQcE1YSolst0W6t9CcXJ7PA1i/
         k3NsDfQuFj8bF3aVA1dYpWezniD+Eh2jkRcId31ub8FNA3p5mbouz1etlp4hjRnQH8LQ
         /mk750SOBjo4JCwhcXOGGzWPHV4vlnIr1UNpnlMkrHuUuKhAlPHFIp3bPNWTebHGt3lz
         qpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PdlvwnGEzcFCAXeOFNM8mKM5jXwMmc9nBvJCjWEqLJs=;
        b=DbGdOKrwjzl+5/s7IsiGThGGjqe3Mms2MJVOwYFF50h2QEO+rs+O6z4CFAQkgczOe/
         73TFhiux7A6ws0pJwbvWD7gQyrfNbktcdTzpdsllxn+KOCdMqUX18RamhYkytPxEpDSD
         zDNSvAAY19v8ta6UefqGV/ZbZ8FPWYD0zeeJfzcbiThD3/H/RVZ1mkIBo7H5POnMbgZL
         DQgJ62rcnm5mAUsBcNFwJtgVg/JCexC/Jbm39U46hvamwduiVPqk4EiqTvQWRJ+IIF5s
         vcc6k0m8jeMdzELXPooDsh6dquDU7PuvUxkNTx7YbpQlbhdM1c+bDrYVWgf0kAlYjGGz
         7hgA==
X-Gm-Message-State: APjAAAVmkQEF44XpnDFo9JwiiDMovU9yHBYQaq4b8yZhJTXAo82PTOuf
        XM99G5y9zUC3dpmt6wUOJoo=
X-Google-Smtp-Source: APXvYqwJXWw1dLt0CdGMHdc4u3w30M4S6oJxAQji0hycyS5TLYhK0edFq7Fl7vHA2sbhW2EAWuvYxQ==
X-Received: by 2002:a17:902:aa09:: with SMTP id be9mr8367781plb.52.1567067509064;
        Thu, 29 Aug 2019 01:31:49 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.31.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:31:48 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 01/30] locking/lockdep: Rename deadlock check functions
Date:   Thu, 29 Aug 2019 16:31:03 +0800
Message-Id: <20190829083132.22394-2-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In lockdep, deadlock checkings are carried out at two places:

 - In current task's held lock stack, check lock recursion deadlock scenarios.
 - In dependency graph, check lock inversion deadlock scenarios.

Rename these two relevant functions for later use. Plus, with recursive-read
locks, only a dependency circle in lock graph is not sufficient condition
for lock inversion deadlocks anymore, so check_noncircular() is not entirely
accurate.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3c3902c..3c89a50 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1782,8 +1782,8 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
  * Print an error and return 0 if it does.
  */
 static noinline int
-check_noncircular(struct held_lock *src, struct held_lock *target,
-		  struct lock_trace **const trace)
+check_deadlock_graph(struct held_lock *src, struct held_lock *target,
+		     struct lock_trace **const trace)
 {
 	int ret;
 	struct lock_list *uninitialized_var(target_entry);
@@ -2372,7 +2372,8 @@ static inline void inc_chains(void)
 }
 
 /*
- * Check whether we are holding such a class already.
+ * Check whether we are holding such a class already in the current
+ * held lock stack.
  *
  * (Note that this has to be done separately, because the graph cannot
  * detect such classes of deadlocks.)
@@ -2380,7 +2381,7 @@ static inline void inc_chains(void)
  * Returns: 0 on deadlock detected, 1 on OK, 2 on recursive read
  */
 static int
-check_deadlock(struct task_struct *curr, struct held_lock *next)
+check_deadlock_current(struct task_struct *curr, struct held_lock *next)
 {
 	struct held_lock *prev;
 	struct held_lock *nest = NULL;
@@ -2465,7 +2466,7 @@ static inline void inc_chains(void)
 
 	/*
 	 * Prove that the new <prev> -> <next> dependency would not
-	 * create a circular dependency in the graph. (We do this by
+	 * create a deadlock scenario in the graph. (We do this by
 	 * a breadth-first search into the graph starting at <next>,
 	 * and check whether we can reach <prev>.)
 	 *
@@ -2473,7 +2474,7 @@ static inline void inc_chains(void)
 	 * MAX_CIRCULAR_QUEUE_SIZE) which keeps track of a breadth of nodes
 	 * in the graph whose neighbours are to be checked.
 	 */
-	ret = check_noncircular(next, prev, trace);
+	ret = check_deadlock_graph(next, prev, trace);
 	if (unlikely(ret <= 0))
 		return 0;
 
@@ -2952,7 +2953,7 @@ static int validate_chain(struct task_struct *curr,
 		 * The simple case: does the current hold the same lock
 		 * already?
 		 */
-		int ret = check_deadlock(curr, hlock);
+		int ret = check_deadlock_current(curr, hlock);
 
 		if (!ret)
 			return 0;
-- 
1.8.3.1

