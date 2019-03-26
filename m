Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82887C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A102075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbfCZT7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:59:39 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36755 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCZT7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 15:59:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id k2so2128591plt.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 12:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AH4vvTxixdh92C0weTxwlBQL8wg6WuWvfq2/y6RXgBE=;
        b=luoBzne8GlKRqYkxWoLctMcjTgHtroPbQa+fh7IPrS20dj+QT0a9Vpyi0tfzazFECp
         LQ5594uTxnYXbKmJnN6WJ6fSNuXtzgDL/IdYwe1Ox1RUE0ZQMD0vld7039UzzN48AUFc
         ZNBnH3dhspSAljytqXNj4vIs+4hCSSpTBmP2KuGavJuuxcG2VysBwtNavoZ94YB004VD
         bNI0z/hGMOZHf/zLjJ2hAfx2Vjnbte04F1/e2aaoWTCYZxvsF2hNzY/Bi4GODtvo3OCj
         O+0jz1LjTZHYxx9UlhTvhc6MbV/ZjBfe8tcuMVqSfuP7GJMvH1rjjLb3t8O6zsXBlDgB
         gfwQ==
X-Gm-Message-State: APjAAAWLr450xAa6td0vGzyMqvDTPowBm1WfPXv3RGu5ME8yoqE0amnI
        c7FNOXmT0Whkgu1pZDEXeTo=
X-Google-Smtp-Source: APXvYqzs35m7RzBhMCpnSOD5eVB4OV1pOwueBsGeSnTN4hjObHE/JnlYADo/qzFMUD5oM1RBnzMHEA==
X-Received: by 2002:a17:902:9884:: with SMTP id s4mr33089215plp.110.1553630377175;
        Tue, 26 Mar 2019 12:59:37 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id o2sm29400278pgq.29.2019.03.26.12.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 12:59:36 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Will Deacon <will.deacon@arm.com>,
        Waiman Long <longman@redhat.com>, shenghui <shhuiw@foxmail.com>
Subject: [PATCH] locking/lockdep: Zap lock classes even with lock debugging disabled
Date:   Tue, 26 Mar 2019 12:59:12 -0700
Message-Id: <20190326195912.43316-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer
in use") changed the behavior of lockdep_free_key_range() from
unconditionally zapping lock classes into only zapping lock classes if
debug_lock == true. Since the new behavior can cause cat /proc/lockdep to
crash due to a NULL pointer dereference, restore the pre-v5.1 behavior.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Waiman Long <longman@redhat.com>
Cc: shenghui <shhuiw@foxmail.com>
Reported-by: shenghui <shhuiw@foxmail.com>
Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use") # v5.1-rc1.
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 34cdcbedda49..70480e4f8f5d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4689,8 +4689,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
 		return;
 
 	raw_local_irq_save(flags);
-	if (!graph_lock())
-		goto out_irq;
+	arch_spin_lock(&lockdep_lock);
 
 	/* closed head */
 	pf = delayed_free.pf + (delayed_free.index ^ 1);
@@ -4702,8 +4701,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
 	 */
 	call_rcu_zapped(delayed_free.pf + delayed_free.index);
 
-	graph_unlock();
-out_irq:
+	arch_spin_unlock(&lockdep_lock);
 	raw_local_irq_restore(flags);
 }
 
@@ -4744,21 +4742,15 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
 {
 	struct pending_free *pf;
 	unsigned long flags;
-	int locked;
 
 	init_data_structures_once();
 
 	raw_local_irq_save(flags);
-	locked = graph_lock();
-	if (!locked)
-		goto out_irq;
-
+	arch_spin_lock(&lockdep_lock);
 	pf = get_pending_free();
 	__lockdep_free_key_range(pf, start, size);
 	call_rcu_zapped(pf);
-
-	graph_unlock();
-out_irq:
+	arch_spin_unlock(&lockdep_lock);
 	raw_local_irq_restore(flags);
 
 	/*
@@ -4911,9 +4903,7 @@ void lockdep_unregister_key(struct lock_class_key *key)
 		return;
 
 	raw_local_irq_save(flags);
-	if (!graph_lock())
-		goto out_irq;
-
+	arch_spin_lock(&lockdep_lock);
 	pf = get_pending_free();
 	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
 		if (k == key) {
@@ -4925,8 +4915,7 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	WARN_ON_ONCE(!found);
 	__lockdep_free_key_range(pf, key, 1);
 	call_rcu_zapped(pf);
-	graph_unlock();
-out_irq:
+	arch_spin_unlock(&lockdep_lock);
 	raw_local_irq_restore(flags);
 
 	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
-- 
2.21.0.196.g041f5ea1cf98

