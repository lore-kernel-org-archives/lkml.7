Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE0DC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C4B20881
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2dWsZbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfEPIAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:00:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34988 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbfEPIAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:00:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id h1so1173203pgs.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 01:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kosXq0ZF1VWySbXOAJ231nmlCL06j4Wt318Yl0WkM/E=;
        b=W2dWsZbey+2oYCPspmthpWmnMB5GVFP7X1LrhXDhDd7rKSYfxSlLq0LLWAcmizIP95
         Olgt0LEC0IoyK9eM9daVAC95lwmU6zYNvf0UEz7njHQAVtdrNg92pO+525wy48R1TGc/
         TyVoErfD2TuVKbZ4wNoLd2UzHUOHIyUUzf4B1fowITWUG3GS/CQl4eZ2UjajaArSpsgZ
         d5MxUs3i0GBH5WK1YrecAzQ3Ezv8TmqU8rfhUiRLahG765umNdRY1gjsaUceFOTyplPy
         7O6FJ5oWDb/OCZ/S8hA4biCcDRSy25ygQK4YP7At70y2Vd7bndAdKM8u750vjRnZKgPk
         86dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kosXq0ZF1VWySbXOAJ231nmlCL06j4Wt318Yl0WkM/E=;
        b=OWowpk2Brinsk1gtpbT2qf4rPY6FgO5F2IQsjBZ8G05+/GcGRz/Y0EslO+8U7C9hvx
         Jb9KwdSxMNS8WaLCWYK29JS/DpIaa3TSEH5hACx38m3aTBKZUxn3GX/vqWQb/1YMYviz
         ZEjez2T4AKQfuFvDURn0gY6o4LMwIR7+DTXlIlhIdUlTM+1t/gfBoE5BSMRspD0ol+Jh
         88VpzXx04Jq75CfYnnWV4lJ8NHPviiIdTCedeEWeq9mpLVgXtueC4rSxpM8xcVs1/3Rw
         2KIeinU63/HWWlav7iK0wAP0oCyEnTgmPStxn38NlieW3g9CJlPcJXKEaw/QNq7VFG95
         dOLA==
X-Gm-Message-State: APjAAAXExR4B4wZfBw5chq8NEhtHj6627o9P6PiDDgEMSRWU1e5jNpjB
        P6rkZgI8iS1l3tGORrAAaro=
X-Google-Smtp-Source: APXvYqzyIE/ig2PmNYrPW5KqE+004U7x9D5yaOKQEGzF32xy+99IqdHzKh3aoTZak+Ue0vceUAqoNA==
X-Received: by 2002:a63:8a4a:: with SMTP id y71mr48922072pgd.270.1557993645798;
        Thu, 16 May 2019 01:00:45 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id p7sm2051471pgb.92.2019.05.16.01.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 01:00:45 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com, paulmck@linux.ibm.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 06/17] locking/lockdep: Adjust BFS algorithm to support multiple matches
Date:   Thu, 16 May 2019 16:00:04 +0800
Message-Id: <20190516080015.16033-7-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190516080015.16033-1-duyuyang@gmail.com>
References: <20190516080015.16033-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With read locks, circle is not sufficient condition for a deadlock. As a
result, we need to continue the search after a match but the match is not
wanted. __bfs() is adjusted to that end. The basic idea is to enqueue a
node's children before matching the node.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 54 +++++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index f4982ad..54ddf85 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1417,7 +1417,7 @@ static int __bfs(struct lock_list *source_entry,
 		 void *data,
 		 int (*match)(struct lock_list *entry, void *data),
 		 struct lock_list **target_entry,
-		 int offset)
+		 int offset, bool init)
 {
 	struct lock_list *entry;
 	struct lock_list *lock;
@@ -1425,19 +1425,11 @@ static int __bfs(struct lock_list *source_entry,
 	struct circular_queue *cq = &lock_cq;
 	int ret = 1;
 
-	if (match(source_entry, data)) {
-		*target_entry = source_entry;
-		ret = 0;
-		goto exit;
+	if (init) {
+		__cq_init(cq);
+		__cq_enqueue(cq, source_entry);
 	}
 
-	head = get_dep_list(source_entry, offset);
-	if (list_empty(head))
-		goto exit;
-
-	__cq_init(cq);
-	__cq_enqueue(cq, source_entry);
-
 	while ((lock = __cq_dequeue(cq))) {
 
 		if (!lock->class) {
@@ -1449,25 +1441,34 @@ static int __bfs(struct lock_list *source_entry,
 
 		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
 
+		/*
+		 * Enqueue a node's children before match() so that even
+		 * this node matches but is not wanted, we can continue
+		 * the search.
+		 */
 		list_for_each_entry_rcu(entry, head, entry) {
 			if (!lock_accessed(entry)) {
 				unsigned int cq_depth;
+
 				mark_lock_accessed(entry, lock);
-				if (match(entry, data)) {
-					*target_entry = entry;
-					ret = 0;
-					goto exit;
-				}
 
 				if (__cq_enqueue(cq, entry)) {
 					ret = -1;
 					goto exit;
 				}
+
 				cq_depth = __cq_get_elem_count(cq);
 				if (max_bfs_queue_depth < cq_depth)
 					max_bfs_queue_depth = cq_depth;
 			}
 		}
+
+		if (match(lock, data)) {
+			*target_entry = lock;
+			ret = 0;
+			goto exit;
+		}
+
 	}
 exit:
 	return ret;
@@ -1476,10 +1477,10 @@ static int __bfs(struct lock_list *source_entry,
 static inline int __bfs_forwards(struct lock_list *src_entry,
 			void *data,
 			int (*match)(struct lock_list *entry, void *data),
-			struct lock_list **target_entry)
+			struct lock_list **target_entry, bool init)
 {
 	return __bfs(src_entry, data, match, target_entry,
-		     offsetof(struct lock_class, locks_after));
+		     offsetof(struct lock_class, locks_after), init);
 
 }
 
@@ -1489,7 +1490,7 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
 			struct lock_list **target_entry)
 {
 	return __bfs(src_entry, data, match, target_entry,
-		     offsetof(struct lock_class, locks_before));
+		     offsetof(struct lock_class, locks_before), true);
 
 }
 
@@ -1662,7 +1663,7 @@ static unsigned long __lockdep_count_forward_deps(struct lock_list *this)
 	unsigned long  count = 0;
 	struct lock_list *uninitialized_var(target_entry);
 
-	__bfs_forwards(this, (void *)&count, noop_count, &target_entry);
+	__bfs_forwards(this, (void *)&count, noop_count, &target_entry, true);
 
 	return count;
 }
@@ -1750,12 +1751,12 @@ static inline void set_lock_type2(struct lock_list *lock, int read)
  */
 static noinline int
 check_path(struct lock_class *target, struct lock_list *src_entry,
-	   struct lock_list **target_entry)
+	   struct lock_list **target_entry, bool init)
 {
 	int ret;
 
 	ret = __bfs_forwards(src_entry, (void *)target, class_equal,
-			     target_entry);
+			     target_entry, init);
 
 	if (unlikely(ret < 0))
 		print_bfs_bug(ret);
@@ -1783,7 +1784,7 @@ static inline void set_lock_type2(struct lock_list *lock, int read)
 
 	debug_atomic_inc(nr_cyclic_checks);
 
-	ret = check_path(hlock_class(target), &src_entry, &target_entry);
+	ret = check_path(hlock_class(target), &src_entry, &target_entry, true);
 
 	if (unlikely(!ret)) {
 		if (!trace->nr_entries) {
@@ -1821,7 +1822,7 @@ static inline void set_lock_type2(struct lock_list *lock, int read)
 
 	debug_atomic_inc(nr_redundant_checks);
 
-	ret = check_path(hlock_class(target), &src_entry, &target_entry);
+	ret = check_path(hlock_class(target), &src_entry, &target_entry, true);
 
 	if (!ret) {
 		struct lock_list *parent;
@@ -1897,7 +1898,8 @@ static inline int usage_match(struct lock_list *entry, void *mask)
 
 	debug_atomic_inc(nr_find_usage_forwards_checks);
 
-	result = __bfs_forwards(root, &usage_mask, usage_match, target_entry);
+	result = __bfs_forwards(root, &usage_mask, usage_match,
+				target_entry, true);
 
 	return result;
 }
-- 
1.8.3.1

