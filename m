Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FE1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DAF2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tvZwlW5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbfDXKU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:20:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42898 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbfDXKUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:20:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id x15so4712020pln.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fb2EnMzMz2ypaDEqcSzmRBnRvvy4LG0Bkb4/NEy/6yA=;
        b=tvZwlW5cyD0vQD+fjDSYBUaHF6PyD+Xpq5o9pNthq3MKHZZDqN8vcCNX24L8yo6ipu
         0szBNfnjmeqJs2ug+qejKkRfGffs8VxL3aBnc2LmZ4lRCa2mso0YUnAnniOG69hEXKVX
         8HjNMK5AE/tw22INvefEZTIEZJncDFhOXrty2MU4qHN3rb+tgTQSMxuETV9EZowtIDhO
         L6EjIvq9t0J8WH2yerLXYFtOIHpxWhCHkfwaKOcTIekU4aj5YGAuWX86Q3ciD3xcQCKK
         PirUD6yPKInIFKA2hhAETzeWskYYD7qDfAGSHrgDqF3miqE/8nv14lGuoWU+V/15GlPh
         JvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fb2EnMzMz2ypaDEqcSzmRBnRvvy4LG0Bkb4/NEy/6yA=;
        b=aNgLuq8T2Uv/sEgWrUvKjnuTANt6V7efsMa3iLbPZ3wkkoABT61eEVCcsou3Iv9SSe
         U8oUYbMSodnGXRPlWyYnLGyZRlnHco84rZ+COzfDUpIqJB0HPltPzFirjnGQlXhEvYu6
         zL2IbfCeCixq7iNzz5Yc+aZdfMkelQZ32cEFLSjhtJH4EWULzAtNBE29xbbVPCZK2rnn
         x4oEB5wb1xhGuHosXDWv6RC1mxN9FyA12MHd4hqUda7r6XMdp9itkT0PXCaOhooW0AKH
         aLa1fdDExfRwupSnFAiy09wA36B8+rVAC/cUDzgzJre2jS4F3/+cVGgWtxU2R2ZcHR1x
         wUjQ==
X-Gm-Message-State: APjAAAVe9YcMpnlAC4Fx9eZS7rl4dj8rUmi3yK2AOo7IjIbJr8eZ0XAC
        Vq3IdAnq5KGVNu6H1evSBbc=
X-Google-Smtp-Source: APXvYqw7xsJ3zxV0np2hdQ6aj+WwDIFACjlHf4OiOOlnIxg1cse9kHpX/7wftB/0BtYNbVIGpFGnpQ==
X-Received: by 2002:a17:902:ba85:: with SMTP id k5mr31584379pls.270.1556101252308;
        Wed, 24 Apr 2019 03:20:52 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:20:51 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 08/28] locking/lockdep: Define INITIAL_CHAIN_KEY for chain keys to start with
Date:   Wed, 24 Apr 2019 18:19:14 +0800
Message-Id: <20190424101934.51535-9-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chain keys are computed using Jenkins hash function, which needs an initial
hash to start with. Dedicate a macro to make this clear and configurable. A
later patch changes this initial chain key.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h  |  1 +
 init/init_task.c         |  2 +-
 kernel/locking/lockdep.c | 18 +++++++++---------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 751a2cc..bb47d7c 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -229,6 +229,7 @@ struct lock_chain {
  * bitfield and hitting the BUG in hlock_class().
  */
 #define MAX_LOCKDEP_KEYS		((1UL << MAX_LOCKDEP_KEYS_BITS) - 1)
+#define INITIAL_CHAIN_KEY		0
 
 struct held_lock {
 	/*
diff --git a/init/init_task.c b/init/init_task.c
index 1b15cb9..afa6ad7 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -167,7 +167,7 @@ struct task_struct init_task
 #endif
 #ifdef CONFIG_LOCKDEP
 	.lockdep_depth = 0, /* no locks held yet */
-	.curr_chain_key = 0,
+	.curr_chain_key = INITIAL_CHAIN_KEY,
 	.lockdep_recursion = 0,
 #endif
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4ce0e39..3055ea7 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -361,7 +361,7 @@ static inline u64 iterate_chain_key(u64 key, u32 idx)
 inline void lockdep_init_task(struct task_struct *task)
 {
 	task->lockdep_depth = 0; /* no locks held yet */
-	task->curr_chain_key = 0;
+	task->curr_chain_key = INITIAL_CHAIN_KEY;
 	task->lockdep_recursion = 0;
 }
 
@@ -852,7 +852,7 @@ static bool class_lock_list_valid(struct lock_class *c, struct list_head *h)
 static bool check_lock_chain_key(struct lock_chain *chain)
 {
 #ifdef CONFIG_PROVE_LOCKING
-	u64 chain_key = 0;
+	u64 chain_key = INITIAL_CHAIN_KEY;
 	int i;
 
 	for (i = chain->base; i < chain->base + chain->depth; i++)
@@ -2414,7 +2414,7 @@ static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
 print_chain_keys_held_locks(struct task_struct *curr, struct held_lock *hlock_next)
 {
 	struct held_lock *hlock;
-	u64 chain_key = 0;
+	u64 chain_key = INITIAL_CHAIN_KEY;
 	int depth = curr->lockdep_depth;
 	int i = get_first_held_lock(curr, hlock_next);
 
@@ -2434,7 +2434,7 @@ static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
 static void print_chain_keys_chain(struct lock_chain *chain)
 {
 	int i;
-	u64 chain_key = 0;
+	u64 chain_key = INITIAL_CHAIN_KEY;
 	int class_id;
 
 	printk("depth: %u\n", chain->depth);
@@ -2742,7 +2742,7 @@ static void check_chain_key(struct task_struct *curr)
 #ifdef CONFIG_DEBUG_LOCKDEP
 	struct held_lock *hlock, *prev_hlock = NULL;
 	unsigned int i;
-	u64 chain_key = 0;
+	u64 chain_key = INITIAL_CHAIN_KEY;
 
 	for (i = 0; i < curr->lockdep_depth; i++) {
 		hlock = curr->held_locks + i;
@@ -2766,7 +2766,7 @@ static void check_chain_key(struct task_struct *curr)
 
 		if (prev_hlock && (prev_hlock->irq_context !=
 							hlock->irq_context))
-			chain_key = 0;
+			chain_key = INITIAL_CHAIN_KEY;
 		chain_key = iterate_chain_key(chain_key, hlock->class_idx);
 		prev_hlock = hlock;
 	}
@@ -3681,14 +3681,14 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		/*
 		 * How can we have a chain hash when we ain't got no keys?!
 		 */
-		if (DEBUG_LOCKS_WARN_ON(chain_key != 0))
+		if (DEBUG_LOCKS_WARN_ON(chain_key != INITIAL_CHAIN_KEY))
 			return 0;
 		chain_head = 1;
 	}
 
 	hlock->prev_chain_key = chain_key;
 	if (separate_irq_context(curr, hlock)) {
-		chain_key = 0;
+		chain_key = INITIAL_CHAIN_KEY;
 		chain_head = 1;
 	}
 	chain_key = iterate_chain_key(chain_key, class_idx);
@@ -4530,7 +4530,7 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 	return;
 
 recalc:
-	chain_key = 0;
+	chain_key = INITIAL_CHAIN_KEY;
 	for (i = chain->base; i < chain->base + chain->depth; i++)
 		chain_key = iterate_chain_key(chain_key, chain_hlocks[i] + 1);
 	if (chain->depth && chain->chain_key == chain_key)
-- 
1.8.3.1

