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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12ECC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E702053B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pP7ODj+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfH2IcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:32:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37581 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfH2IcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:32:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id y9so1576437pfl.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mhA4zWE9OY43Oghtx1Iqd8SWyXu1Zvn3og4YkBwF73A=;
        b=pP7ODj+LPEo40S2MVYorJuDGWMCKnoqPUhNZ46OjzJnJ4DOVR5LfMAxTBFbpK1CZgl
         DkiFPlbOwyRlRlL1KzURSmn/WZpzJqow9DqZibKAn+Treg02EoNbnR7QACw6g6TZ1nla
         jsHOgc5nUdTbTXY/PMOVbvN74+KVV4u7uRjFGINr+4g3uYYLLBHyKJ+oRJIbA9g8rvul
         JdHRriB3baczhg9YymwFfJ9cDC5EpPGwXVW8yhIL9tPjRhLBPD8wFvw7UlqEht+7euk4
         LZZ24qsX8lIQeBao5HoaiL5UVK4/LvEL43U12lsrO2Cay31uwQMz6N+QB58bkt+X3mGK
         G5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mhA4zWE9OY43Oghtx1Iqd8SWyXu1Zvn3og4YkBwF73A=;
        b=Uu1VFeB4ecLX+dGqZbp7vqrn0JywJF5kznKbOvyVu1CqQKqCPOSkmlcmK6B5PfdEHQ
         O5YUW18IJEEKHbPRIcZoCxb/6iefmafAr7OTgmvnO/PDbmnL/uSvIe3FNKR72Og1Rdsd
         ZEjT1YMd5naLsLFzaERVhjg4O2LbGV/Wf69754Un5zofyFAr/D93m5xFVszsOIxT4lWQ
         OmWpbL2/t2JaIVVWt8wMUUIjryZRHmqKTjSy2FlcG7+Iun3gZhztsYCVwYAeeKtGAj/U
         eA2aTGoTzYPnVtevXU7rgdFYgM0A5av4jHLgidbrvNhqls8SeD5qPRtfKAL+QhWi5xwP
         yWug==
X-Gm-Message-State: APjAAAUffA8WU4wK2GtvnTNJhrsoJgUP4pMPAMf1w/315A18EkUzpNHx
        DRF7pzUmYnjpncJ9wn+rv0w=
X-Google-Smtp-Source: APXvYqwvwt14bwxkhc18OGfPyb/jbwAmSjYcrNtDOo5DkDWGrmw5qOUdA99o1n5mmP7kg5zo7iHCqg==
X-Received: by 2002:aa7:9a04:: with SMTP id w4mr9962790pfj.126.1567067540687;
        Thu, 29 Aug 2019 01:32:20 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.32.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:32:20 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 09/30] locking/lockdep: Remove chain_head argument in validate_chain()
Date:   Thu, 29 Aug 2019 16:31:11 +0800
Message-Id: <20190829083132.22394-10-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
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
index de088da..e8ebb64 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2880,9 +2880,8 @@ static inline struct lock_chain *lookup_chain_cache(u64 chain_key)
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
@@ -2930,7 +2929,7 @@ static int validate_chain(struct task_struct *curr,
 		 * Add dependency only if this lock is not the head
 		 * of the chain, and if it's not a secondary read-lock:
 		 */
-		if (!chain_head && ret != 2) {
+		if (chain->depth > 1 && ret != 2) {
 			if (!check_prevs_add(curr, hlock, chain))
 				return 0;
 		}
@@ -2947,7 +2946,7 @@ static int validate_chain(struct task_struct *curr,
 #else
 static inline int validate_chain(struct task_struct *curr,
 				 struct held_lock *hlock,
-				 int chain_head, u64 chain_key)
+				 u64 chain_key)
 {
 	return 1;
 }
@@ -3781,7 +3780,6 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	struct lock_class *class = NULL;
 	struct held_lock *hlock;
 	unsigned int depth;
-	int chain_head = 0;
 	int class_idx;
 	u64 chain_key;
 
@@ -3895,14 +3893,12 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
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
@@ -3915,7 +3911,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		WARN_ON_ONCE(!hlock_class(hlock)->key);
 	}
 
-	if (!validate_chain(curr, hlock, chain_head, chain_key))
+	if (!validate_chain(curr, hlock, chain_key))
 		return 0;
 
 	curr->curr_chain_key = chain_key;
-- 
1.8.3.1

