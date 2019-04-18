Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932D3C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E37C217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="jMBGusi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388860AbfDRL1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 07:27:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60725 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRL1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 07:27:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3IBRZmf167091
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Apr 2019 04:27:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3IBRZmf167091
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555586855;
        bh=oMxL5AEa7POd5Ny5iN4O5Ew4orVa5FOghKoqxMDfdEo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=jMBGusi0XqpcUkXGbg3fDIyPsYOGA0wSphATuSAHsNXcSlK1OGGHtChUF1c4rwDzN
         fXamG5WhW7ENaye/f5LND9TrP6IVO7j4pVzLIwdrPECJCTEThLejI1g4loaSJ6KmIt
         ETk9cW5bMWNAOsad0SPrqx9Q6JdDjHtZIaWbXtIrFPJbGcx+1IDnm+W0ZKsJyySUdk
         x4j7O3ZSbeTWaMCse73XSzyYWZfvYy/XlPJcNu7JmQv0wJlb/BZDS9YAYEcj6XHKaB
         TFS9AMC41Um1BDF/Dk16AgqL52cNYPEbGwf/jWG3rwK3yzfAejurZrKoGS1wwh/TT6
         T1ZxEOOlGTMEw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3IBRY7p167087;
        Thu, 18 Apr 2019 04:27:34 -0700
Date:   Thu, 18 Apr 2019 04:27:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-627f364d24c009b61c9199b2c75006e35c294675@git.kernel.org>
Cc:     will.deacon@arm.com, torvalds@linux-foundation.org,
        mingo@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, frederic@kernel.org,
        peterz@infradead.org, tglx@linutronix.de,
        paulmck@linux.vnet.ibm.com
Reply-To: frederic@kernel.org, peterz@infradead.org, hpa@zytor.com,
          paulmck@linux.vnet.ibm.com, tglx@linutronix.de,
          will.deacon@arm.com, torvalds@linux-foundation.org,
          mingo@kernel.org, akpm@linux-foundation.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190402160244.32434-4-frederic@kernel.org>
References: <20190402160244.32434-4-frederic@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Use expanded masks on
 find_usage_*() functions
Git-Commit-ID: 627f364d24c009b61c9199b2c75006e35c294675
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  627f364d24c009b61c9199b2c75006e35c294675
Gitweb:     https://git.kernel.org/tip/627f364d24c009b61c9199b2c75006e35c294675
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 2 Apr 2019 18:02:43 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 18 Apr 2019 12:50:17 +0200

locking/lockdep: Use expanded masks on find_usage_*() functions

In order to optimize check_irq_usage() and factorize all the IRQ usage
validations we'll need to be able to check multiple lock usage bits at
once. Prepare the low level usage mask check functions for that purpose.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/r/20190402160244.32434-4-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2288aa2fa4c6..5e149dd78298 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1682,9 +1682,9 @@ check_redundant(struct lock_list *root, struct lock_class *target,
  * without creating any illegal irq-safe -> irq-unsafe lock dependency.
  */
 
-static inline int usage_match(struct lock_list *entry, void *bit)
+static inline int usage_match(struct lock_list *entry, void *mask)
 {
-	return entry->class->usage_mask & (1 << (enum lock_usage_bit)bit);
+	return entry->class->usage_mask & *(unsigned long *)mask;
 }
 
 
@@ -1700,14 +1700,14 @@ static inline int usage_match(struct lock_list *entry, void *bit)
  * Return <0 on error.
  */
 static int
-find_usage_forwards(struct lock_list *root, enum lock_usage_bit bit,
+find_usage_forwards(struct lock_list *root, unsigned long usage_mask,
 			struct lock_list **target_entry)
 {
 	int result;
 
 	debug_atomic_inc(nr_find_usage_forwards_checks);
 
-	result = __bfs_forwards(root, (void *)bit, usage_match, target_entry);
+	result = __bfs_forwards(root, &usage_mask, usage_match, target_entry);
 
 	return result;
 }
@@ -1723,14 +1723,14 @@ find_usage_forwards(struct lock_list *root, enum lock_usage_bit bit,
  * Return <0 on error.
  */
 static int
-find_usage_backwards(struct lock_list *root, enum lock_usage_bit bit,
+find_usage_backwards(struct lock_list *root, unsigned long usage_mask,
 			struct lock_list **target_entry)
 {
 	int result;
 
 	debug_atomic_inc(nr_find_usage_backwards_checks);
 
-	result = __bfs_backwards(root, (void *)bit, usage_match, target_entry);
+	result = __bfs_backwards(root, &usage_mask, usage_match, target_entry);
 
 	return result;
 }
@@ -1935,7 +1935,7 @@ check_usage(struct task_struct *curr, struct held_lock *prev,
 	this.parent = NULL;
 
 	this.class = hlock_class(prev);
-	ret = find_usage_backwards(&this, bit_backwards, &target_entry);
+	ret = find_usage_backwards(&this, lock_flag(bit_backwards), &target_entry);
 	if (ret < 0)
 		return print_bfs_bug(ret);
 	if (ret == 1)
@@ -1943,7 +1943,7 @@ check_usage(struct task_struct *curr, struct held_lock *prev,
 
 	that.parent = NULL;
 	that.class = hlock_class(next);
-	ret = find_usage_forwards(&that, bit_forwards, &target_entry1);
+	ret = find_usage_forwards(&that, lock_flag(bit_forwards), &target_entry1);
 	if (ret < 0)
 		return print_bfs_bug(ret);
 	if (ret == 1)
@@ -2941,7 +2941,7 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
 
 	root.parent = NULL;
 	root.class = hlock_class(this);
-	ret = find_usage_forwards(&root, bit, &target_entry);
+	ret = find_usage_forwards(&root, lock_flag(bit), &target_entry);
 	if (ret < 0)
 		return print_bfs_bug(ret);
 	if (ret == 1)
@@ -2965,7 +2965,7 @@ check_usage_backwards(struct task_struct *curr, struct held_lock *this,
 
 	root.parent = NULL;
 	root.class = hlock_class(this);
-	ret = find_usage_backwards(&root, bit, &target_entry);
+	ret = find_usage_backwards(&root, lock_flag(bit), &target_entry);
 	if (ret < 0)
 		return print_bfs_bug(ret);
 	if (ret == 1)
