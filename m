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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95D9C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9AF208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roiBrov5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfF1JPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:15:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35361 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfF1JPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:15:52 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so2911893plp.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ZupqnYwdfry1yDlXcIvfj0C01TyC2YPNUbKz1TOZak=;
        b=roiBrov5fpCRmVYIJCjceBC0rbNG5/vkCUUjuHOd52D33+4pAG4Grwu0jhlyUHI2zu
         XZI0M70wU/LuSr02xV3Y9+gidtGOriKOeeB4kGpBHeK0H9SSa0a/DP4kuO6Lx3lP4DKT
         sCbGND7lVARatvP1K0S1+SwnjRUtg4K7oeVEfaLaT9w69k2EZycaMqe6xWko7lMTML4M
         vJJeSP/iLHfFvN3zT8jYM7C4IGfnIDqTVx9CAwcQ3E0CGK/R3vBadkkMsug+2a8ZIkyJ
         3epxb2+5BJPaYXQTRMUOnx1Pj/tIAduN1pvjqY12AE95NNNT7RolxtmHjqbXZ+H9IVrS
         bfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ZupqnYwdfry1yDlXcIvfj0C01TyC2YPNUbKz1TOZak=;
        b=Y3qOlqSUTe5Ui4KDMKU6d0vry1y3n8xrDVwPdIB7I4mrTZyxddZ6YtBEsXAzfhoW+q
         AjbcrEpv6YALEA0ulT8OocQ0BfenqxxuN5vRhRlf6wb3PhsS28ZbA9IG9zF5ZqaSfI+r
         HUaAsr4KPgSrw2RP3yjIRibTH0oPflPjZEkbznSHcSrQbLoj8uZofFXOycziJ4x65z3B
         u47YCIXHiL3EByjZ4nrA9489lsR7IGnNNj0CIEuunLJeLvnCKbnbwS5fpOBDPSYtGsfF
         R5tEtQDIE8rr5uduJTOaUeNA2na+tP5QvPbhd0XD53ya11SKYtzy7UVbrEwjLCwlAKHp
         T9WQ==
X-Gm-Message-State: APjAAAVqT4OlXt8LBFpFC0lagkEdoys1J6l0Mo/htQu64RhdGpoqV8JP
        S0ryo4acAv972dUnodXT2To=
X-Google-Smtp-Source: APXvYqxk0+eTz6UMuYx8L/729aHdSYoLDv/cyKXJIazMzAD8zGbgpDTEsqiTTfdIGUukxYnjAWtgag==
X-Received: by 2002:a17:902:7247:: with SMTP id c7mr10188437pll.202.1561713352391;
        Fri, 28 Jun 2019 02:15:52 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.15.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:15:51 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 02/30] locking/lockdep: Change return type of add_chain_cache()
Date:   Fri, 28 Jun 2019 17:15:00 +0800
Message-Id: <20190628091528.17059-3-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function add_chain_cache() adds a new chain - the current lock chain
- into the lock_chains cache if it does not exist in there.

Previously if failed to add an integer 0 is returned and if successful 1
is returned. Change the return type to the pointer of the chain if the
new chain is added or NULL if otherwise.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e30e9e4..3546894 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2714,12 +2714,12 @@ static struct lock_chain *alloc_lock_chain(void)
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
@@ -2732,16 +2732,16 @@ static inline int add_chain_cache(struct task_struct *curr,
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
@@ -2762,18 +2762,18 @@ static inline int add_chain_cache(struct task_struct *curr,
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

