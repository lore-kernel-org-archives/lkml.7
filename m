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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7872CC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7D02133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUxmbpjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfF1JQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:16:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39179 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfF1JQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:16:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id j2so2661768pfe.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ok7LAiocwziPNLnJTigNrjpE5FyHnTrBjoEWno2vU9A=;
        b=OUxmbpjO++VwthWJNz4MH56TcHQeHrAp1zMRZKOBCB10CSq6eKs+R4AgUJhNO5UReY
         hoWJ1QRrKBZQh/cFrzV7QPvo8Ej91ISFcijnvDKttL8mkz67+8b1VGGW9v4X8mGNfGl5
         Ia0oMj3kkd1PJ2zzAri5m/HHELD0K0szFUbiSqLvsWNJ+dcImYzINfEWFA9zrVg2GX5N
         cVIiny3+dIIJctqwdPYcjVKNE10lW6/0d5EwlbdQSgkkANrN33Q6qQ13/rae/OVa2+Q1
         VlT21DqppUFwOoWY8zjcTjW1AWI/1JTdCRm55d47I5a7XFKueyBDBSR1RCBOU7q7yTcP
         2l7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ok7LAiocwziPNLnJTigNrjpE5FyHnTrBjoEWno2vU9A=;
        b=dF3WqlSHqWG6pk2+dveu3Bje93k10/qfMsTvaYfiZdV9jGoSbehQWFbSyoMTJ/6tut
         g0VRd1ueuJ2aUx+w+B+HjKpLKFCD8ytcUn3YazSolMvtJHMeBrCLVulnRnN2egRH6dVT
         Tj+qN6lN1332vjsJqKzvdH96uRi26ciREfkMVdLzH8iMXjoAkiiFtMtP2Rug+zWfyW14
         SnlrEsDmkogUAh2kg6A4z4WiPc7c6Q3PIFsdvUXuwOc1fVxH4iAEMIWicbiMJsw0/wtp
         FIX1oAhiNVWRj5b16IGH9Gp6glrq2HDzTHOIQytLvLxApZiK2F0x63MH5iUz7Z1VD6ay
         D3nQ==
X-Gm-Message-State: APjAAAW1Vo9slVsTHcKTpG4GvTgy5cHO4ExXR6PbcjyIIQYTdCXHrEQE
        mwBmaeqx0UMf/tLSdvCKygc=
X-Google-Smtp-Source: APXvYqwFmSUbG9L1pqTdwfLWmXRXudIYGsPtwLkXHI7prpsDDVYiqtO6o/nHUAwzzYKt2F6BkNACOA==
X-Received: by 2002:a65:6497:: with SMTP id e23mr2755586pgv.89.1561713383985;
        Fri, 28 Jun 2019 02:16:23 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.16.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:16:23 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 09/30] locking/lockdep: Remove chain_head argument in validate_chain()
Date:   Fri, 28 Jun 2019 17:15:07 +0800
Message-Id: <20190628091528.17059-10-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This argument says whether the chain is a head, meaning having just one
lock, which can actually be tested by lock_chain->depth. So there is no
need to explicitly make this argument, so remove it.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4ffb4df..e2ad673 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2807,9 +2807,8 @@ static inline struct lock_chain *lookup_chain_cache(u64 chain_key)
 	return add_chain_cache(curr, hlock, chain_key);
 }
 
-static int validate_chain(struct task_struct *curr,
-			  struct held_lock *hlock,
-			  int chain_head, u64 chain_key)
+static int validate_chain(struct task_struct *curr, struct held_lock *hlock,
+			  u64 chain_key)
 {
 	struct lock_chain *chain;
 	/*
@@ -2857,7 +2856,7 @@ static int validate_chain(struct task_struct *curr,
 		 * Add dependency only if this lock is not the head
 		 * of the chain, and if it's not a secondary read-lock:
 		 */
-		if (!chain_head && ret != 2) {
+		if (chain->depth > 1 && ret != 2) {
 			if (!check_prevs_add(curr, hlock, chain))
 				return 0;
 		}
@@ -2874,7 +2873,7 @@ static int validate_chain(struct task_struct *curr,
 #else
 static inline int validate_chain(struct task_struct *curr,
 				 struct held_lock *hlock,
-				 int chain_head, u64 chain_key)
+				 u64 chain_key)
 {
 	return 1;
 }
@@ -3707,7 +3706,6 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	struct lock_class *class = NULL;
 	struct held_lock *hlock;
 	unsigned int depth;
-	int chain_head = 0;
 	int class_idx;
 	u64 chain_key;
 
@@ -3821,14 +3819,12 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		 */
 		if (DEBUG_LOCKS_WARN_ON(chain_key != INITIAL_CHAIN_KEY))
 			return 0;
-		chain_head = 1;
 	}
 
 	hlock->prev_chain_key = chain_key;
-	if (separate_irq_context(curr, hlock)) {
+	if (separate_irq_context(curr, hlock))
 		chain_key = INITIAL_CHAIN_KEY;
-		chain_head = 1;
-	}
+
 	chain_key = iterate_chain_key(chain_key, class_idx);
 
 	if (nest_lock && !__lock_is_held(nest_lock, -1)) {
@@ -3841,7 +3837,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		WARN_ON_ONCE(!hlock_class(hlock)->key);
 	}
 
-	if (!validate_chain(curr, hlock, chain_head, chain_key))
+	if (!validate_chain(curr, hlock, chain_key))
 		return 0;
 
 	curr->curr_chain_key = chain_key;
-- 
1.8.3.1

