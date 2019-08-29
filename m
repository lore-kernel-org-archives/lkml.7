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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E403C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE362341B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJkEthxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfH2Iby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:31:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38916 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfH2Ibx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:31:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id y200so1570049pfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m6tcKjo6eL3f+Qm7o9vpHNeE0P9WDqQ11+tf0hyw80Y=;
        b=NJkEthxSvl9dDQ2BI+SnuQcCJg1nw28grfBQjUIRdgTclzjWPgWJVETt7xqWV5zGSJ
         NXzEBLxMDUxziOTdTrtI4PVkdT4HvLjwdjzlS1UUd347lKvHBWH4nkyB1m8z9dWnyhnt
         0m4EZWI7x1AG1P2vZ6chpiR9d2hUpDeW+0qBW0QztIZsOck7zmJTdYrdSaEiU2qrGFzd
         dPv7oF0/iPzXu5jhMRvJjtxIr4qyhfupiGAzXaiHTraQFicU+lo8nwMECuRp7jBB3MAx
         rO7m2cFXGUpShdDTlTy2/+nJGHOV0tE/4reG+sNviIUjTRW/H1g3W1gZiuJ1mzVNPdv5
         ASvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m6tcKjo6eL3f+Qm7o9vpHNeE0P9WDqQ11+tf0hyw80Y=;
        b=O1YrU40KyeWBWNcabqcN8yi/8Kdvi5XgbTEbXpJGp06nHaoKxZOL2R+VbhP9OkgpSt
         Sic8KAnsr8XvDpzU6M/K8DjWUrCk0AFZ7JWlzj1ebJ8wvcUIIToH0qcchnGrZf0eg4CG
         VhyUN/M9Eqcjac9xOLX8iUC27Z+dUFbNt4ifxmk6tUlQy1oBRkcK2hLV/zIa0E5Gfxim
         9gBnesQtmyg8KE/pK4kT1P1U/shtNXCW1Jr73pgINwT0AT2l6A4s93QYuSI0aLvvUyEE
         4o4jNibPTj/0fJKNuCeUXpfoheltfGgforxArarjyDWYGMClDCxW6PqFjyjPLMOwv/ky
         lCrA==
X-Gm-Message-State: APjAAAVTvKqmQy796kWF87VkyHQahiAnsraiOJntk2dS3rXNQQ0cx6j4
        ub9DQJdZ22Qnb5rP8OvZTtG2XcZJ7iJW6w==
X-Google-Smtp-Source: APXvYqwkwADde79iY6HXYmVtKjyQMf7uUjVkdeeJaFf8CYVMXds6UKQGAxr+hiBp0uDjmZY3gY5cWQ==
X-Received: by 2002:a17:90a:de11:: with SMTP id m17mr8443614pjv.38.1567067512938;
        Thu, 29 Aug 2019 01:31:52 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:31:52 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 02/30] locking/lockdep: Change return type of add_chain_cache()
Date:   Thu, 29 Aug 2019 16:31:04 +0800
Message-Id: <20190829083132.22394-3-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function add_chain_cache() adds a new chain - the current lock chain
- into the lock_chains cache if it does not exist in there.

Previously if failed, an integer 0 is returned and if successful, 1 is
returned. Change the return type to the pointer of the chain if the new
chain is added or NULL otherwise for later use.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3c89a50..9c9b408 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2788,12 +2788,12 @@ static struct lock_chain *alloc_lock_chain(void)
  * Adds a dependency chain into chain hashtable. And must be called with
  * graph_lock held.
  *
- * Return 0 if fail, and graph_lock is released.
- * Return 1 if succeed, with graph_lock held.
+ * Return NULL if failed, and graph_lock is released.
+ * Return the new chain if successful, with graph_lock held.
  */
-static inline int add_chain_cache(struct task_struct *curr,
-				  struct held_lock *hlock,
-				  u64 chain_key)
+static inline struct lock_chain *add_chain_cache(struct task_struct *curr,
+						 struct held_lock *hlock,
+						 u64 chain_key)
 {
 	struct lock_class *class = hlock_class(hlock);
 	struct hlist_head *hash_head = chainhashentry(chain_key);
@@ -2806,16 +2806,16 @@ static inline int add_chain_cache(struct task_struct *curr,
 	 * lockdep won't complain about its own locking errors.
 	 */
 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
-		return 0;
+		return NULL;
 
 	chain = alloc_lock_chain();
 	if (!chain) {
 		if (!debug_locks_off_graph_unlock())
-			return 0;
+			return NULL;
 
 		print_lockdep_off("BUG: MAX_LOCKDEP_CHAINS too low!");
 		dump_stack();
-		return 0;
+		return NULL;
 	}
 	chain->chain_key = chain_key;
 	chain->irq_context = hlock->irq_context;
@@ -2836,18 +2836,18 @@ static inline int add_chain_cache(struct task_struct *curr,
 		nr_chain_hlocks += chain->depth;
 	} else {
 		if (!debug_locks_off_graph_unlock())
-			return 0;
+			return NULL;
 
 		print_lockdep_off("BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!");
 		dump_stack();
-		return 0;
+		return NULL;
 	}
 
 	hlist_add_head_rcu(&chain->entry, hash_head);
 	debug_atomic_inc(chain_lookup_misses);
 	inc_chains();
 
-	return 1;
+	return chain;
 }
 
 /*
-- 
1.8.3.1

