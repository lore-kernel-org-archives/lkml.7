Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB855C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0002082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554220981;
	bh=iKyjNLG9r0I0AqUzA6Jyys10Q65u+XWLvHv5QAfX1eI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TkJWH8H+thW8Sy1In5E6k2FQoFc5QTaotd9256ZLNEJ5RRiPY1fWELFQZsQ7Tjv9x
	 lpSZRI1SSTAobJ2hrNrw24+/+MRiccTUBw0K87TOSZpbfNU/WDCJ/IO82qk6t2gx93
	 AN6aQ4mnJzafDhNfdiH24ncrFw1V1K64w/0YiwJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbfDBQDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:03:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbfDBQC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:02:57 -0400
Received: from lenoir.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7011520856;
        Tue,  2 Apr 2019 16:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554220976;
        bh=iKyjNLG9r0I0AqUzA6Jyys10Q65u+XWLvHv5QAfX1eI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IzY0J1+G+O1HP/bA5Ynzv9RJRyeWTMJN9FwXjNgjRDLHhQzUhcEVdc5sFk1o3zN85
         CDsGmV9KDx4i4lBDCgrrNRb3Uz+eSzj3B/5cEOcHydDIn16/oGspnsMNiW2el0SPcA
         WYQgQJ8D1Y2+q8fp7lG5PsiuMKLSSp94hPSn2Gjk=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 3/4] locking/lockdep: Use expanded masks on find_usage_*() functions
Date:   Tue,  2 Apr 2019 18:02:43 +0200
Message-Id: <20190402160244.32434-4-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402160244.32434-1-frederic@kernel.org>
References: <20190402160244.32434-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to optimize check_irq_usage() and factorize all the IRQ usage
validations we'll need to be able to check multiple lock usage bits at
once. Prepare the low level usage mask check functions for that purpose.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
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
-- 
2.21.0

