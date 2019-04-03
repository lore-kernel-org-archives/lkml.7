Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93C3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 23:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EFF2133D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 23:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfDCXgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 19:36:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36155 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCXgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 19:36:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id 85so249444pgc.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 16:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6wSWdteryIht7SGYUv4BhXiv8EN7o7YuAXEUrHblfX8=;
        b=AmiyS9ATgXpGVTM+Z5b4DE0PyOPfjb0YZbhnCg5ixItMIZsZeTXBSxaNMl1VBpzN9k
         RIceUvfWed8TZk497oc08X1nqLz1DoCeCLCzWj5bx4h2jV7EKHW76G3hfUWpaO7us21S
         HUARKu5ekN+RDZ0uxzAKe/IJrvMwe3mDa/opdosZh3tAI1lsYcWHq0JxyZckGw5Tc0Rf
         qAY8WL9n6ueMb2fvkIsQnHln+RV9dfwVzL0W+1Q6VBWztRorBmQEtF0KbP1yduv6stNa
         1K8JdjYmP9QogKw7G7JeyipCCLzhs00AvKujHGusk/sy/EDe/F8UfYNg+3VA3nic733C
         g7vQ==
X-Gm-Message-State: APjAAAVCuD/xVNscDa6JZhm0kJnNIPRojJioSemDgWgwiuexUnRehkIM
        Tgkkby0chYV2mtxMAMJO/mY=
X-Google-Smtp-Source: APXvYqycqo70yFuNWWN3n97nXmMi4dixPTWMzhObbtO+RAUOlC336nME0cpmEZjvGXbVB5ikwJ2d5A==
X-Received: by 2002:a65:6283:: with SMTP id f3mr2420670pgv.125.1554334560583;
        Wed, 03 Apr 2019 16:36:00 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id l1sm16664082pgo.13.2019.04.03.16.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 16:35:59 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Will Deacon <will.deacon@arm.com>,
        Waiman Long <longman@redhat.com>, shenghui <shhuiw@foxmail.com>
Subject: [PATCH v2] locking/lockdep: Zap lock classes even with lock debugging disabled
Date:   Wed,  3 Apr 2019 16:35:52 -0700
Message-Id: <20190403233552.124673-1-bvanassche@acm.org>
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
debug_lock == true. Not zapping lock classes if debug_lock == false leaves
dangling pointers in several lockdep datastructures, e.g. lock_class::name
in the all_lock_classes list. The shell command "cat /proc/lockdep" causes
the kernel to iterate the all_lock_classes list. Hence the "unable to
handle kernel paging request" issue that Shenghui encountered by running
cat /proc/lockdep. Since the new behavior can cause cat /proc/lockdep to
crash, restore the pre-v5.1 behavior.

This patch avoids that cat /proc/lockdep triggers the following crash
with debug_lock == false:

BUG: unable to handle kernel paging request at fffffbfff40ca448
PGD 13bfde067 P4D 13bfde067 PUD 13bf7a067 PMD 1167d3067 PTE 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 4 PID: 4529 Comm: cat Tainted: G    B   W  O      5.1.0-rc1-dbg+ #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
RIP: 0010:__asan_load1+0x28/0x50
Call Trace:
 string+0xac/0x180
 vsnprintf+0x23e/0x820
 seq_vprintf+0x82/0xc0
 seq_printf+0x92/0xb0
 print_name+0x34/0xb0
 l_show+0x184/0x200
 seq_read+0x59e/0x6c0
 proc_reg_read+0x11f/0x170
 __vfs_read+0x4d/0x90
 vfs_read+0xc5/0x1f0
 ksys_read+0xab/0x130
 __x64_sys_read+0x43/0x50
 do_syscall_64+0x71/0x210
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Waiman Long <longman@redhat.com>
Cc: shenghui <shhuiw@foxmail.com>
Reported-by: shenghui <shhuiw@foxmail.com>
Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use") # v5.1-rc1.
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
Changes compared to v1:
- Restored lockdep recursion protection.
- Made patch description more detailed.

 kernel/locking/lockdep.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 34cdcbedda49..e16766ff184b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4689,8 +4689,8 @@ static void free_zapped_rcu(struct rcu_head *ch)
 		return;
 
 	raw_local_irq_save(flags);
-	if (!graph_lock())
-		goto out_irq;
+	arch_spin_lock(&lockdep_lock);
+	current->lockdep_recursion = 1;
 
 	/* closed head */
 	pf = delayed_free.pf + (delayed_free.index ^ 1);
@@ -4702,8 +4702,8 @@ static void free_zapped_rcu(struct rcu_head *ch)
 	 */
 	call_rcu_zapped(delayed_free.pf + delayed_free.index);
 
-	graph_unlock();
-out_irq:
+	current->lockdep_recursion = 0;
+	arch_spin_unlock(&lockdep_lock);
 	raw_local_irq_restore(flags);
 }
 
@@ -4744,21 +4744,17 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
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
+	current->lockdep_recursion = 1;
 	pf = get_pending_free();
 	__lockdep_free_key_range(pf, start, size);
 	call_rcu_zapped(pf);
-
-	graph_unlock();
-out_irq:
+	current->lockdep_recursion = 0;
+	arch_spin_unlock(&lockdep_lock);
 	raw_local_irq_restore(flags);
 
 	/*
@@ -4911,9 +4907,8 @@ void lockdep_unregister_key(struct lock_class_key *key)
 		return;
 
 	raw_local_irq_save(flags);
-	if (!graph_lock())
-		goto out_irq;
-
+	arch_spin_lock(&lockdep_lock);
+	current->lockdep_recursion = 1;
 	pf = get_pending_free();
 	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
 		if (k == key) {
@@ -4925,8 +4920,8 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	WARN_ON_ONCE(!found);
 	__lockdep_free_key_range(pf, key, 1);
 	call_rcu_zapped(pf);
-	graph_unlock();
-out_irq:
+	current->lockdep_recursion = 0;
+	arch_spin_unlock(&lockdep_lock);
 	raw_local_irq_restore(flags);
 
 	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
-- 
2.21.0.196.g041f5ea1cf98

