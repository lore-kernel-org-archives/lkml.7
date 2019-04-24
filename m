Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDD0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68A921773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS0w0TCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfDXKVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:21:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45676 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729181AbfDXKVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:21:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so9059090pfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D0Pab/AtTPxB5RWhI2RP6rmxChFSTkmf53xKekTBC6E=;
        b=fS0w0TCXXl/T2/KdYF6vTF8H+PwTGgkOEZQbojayQKs5xg48MCEr67Bgl0n8xhGEWW
         kZAauMuQ/jVUVxMAmpB4EIr6iPKiT8dO2TEmPr8TZvitNvPOBmvbaTfK037cl881UE01
         7M0tPOZdtXKfQeSNX4gA1sFdbuBrUvatEwi1JSR+Whhqdtl0hUTcXN17uC2ND2Uso+UO
         IvCbg5sdsjefdnvkYTgMviSHzC/lHT50biNqwWgqQ5cqnQzgslCMmH07N+xKNgKFO1Q7
         rerMt6GD40xu1tynHSXmd6SMcL7F0zzbUp69dKYnd/6NfLM/ymScdLFWpjOvkwirlByA
         JU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D0Pab/AtTPxB5RWhI2RP6rmxChFSTkmf53xKekTBC6E=;
        b=ObhEWb3xRcoEToyCvWLK7rbLJPw6A3RNkAeYDzC+uuogw1HyfIU4Td5+TNbKji4oZA
         qFunQm5dBs9Ot/fz9ROE8J4vuopWTYv4xStIA7mTyAWnkeM6oE8Y/yvLeHD0hWZcm3Qu
         TXm+sGy87txqUeLSWIq8ER0Y1CNQReovPHcmTHvVTa3nh4PrqJVcsuOZ5p8f4vhrny0a
         zBpCZnPx1uqP0CPYQ0T+Kob3ATGWBjazPSKbI6cy2Floatcrh2vK2dHqVMf7ZIKbKdTd
         Y/3FZzl11e4MZWzvScNxIe2WfMoUS5jE1D47hxMq6imwud4ddiv2crCsElc43PWqHX81
         sDGw==
X-Gm-Message-State: APjAAAVTIw1Qto0KFMgm+0O6Rl5vZowZ2Hf5x9CHGJ2ofOUF8yyJOfip
        8/lB0c3SRET6j17rYsUjDGM=
X-Google-Smtp-Source: APXvYqzGgIJZP5O9IhIGD1RNzDTg92FNINK2tj/8a4z5ze/B2A1rqfd/rZmbnDdZOJL87ww8vdO/4g==
X-Received: by 2002:a63:df50:: with SMTP id h16mr17239035pgj.208.1556101289447;
        Wed, 24 Apr 2019 03:21:29 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:21:28 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 20/28] locking/lockdep: Refactorize check_noncircular and check_redundant
Date:   Wed, 24 Apr 2019 18:19:26 +0800
Message-Id: <20190424101934.51535-21-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two functions now handle different check results themselves. A new
check_path function is added to check whether there is a path in the
dependency graph. No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 98 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 63 insertions(+), 35 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index a3138c9..4d42124 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1681,33 +1681,79 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 }
 
 /*
- * Prove that the dependency graph starting at <entry> can not
- * lead to <target>. Print an error and return 0 if it does.
+ * Check that the dependency graph starting at <src> can lead to
+ * <target> or not. Print an error and return 0 if it does.
  */
 static noinline int
-check_noncircular(struct lock_list *root, struct lock_class *target,
-		struct lock_list **target_entry)
+check_path(struct lock_class *target, struct lock_list *src_entry,
+	   struct lock_list **target_entry)
 {
-	int result;
+	int ret;
+
+	ret = __bfs_forwards(src_entry, (void *)target, class_equal,
+			     target_entry);
+
+	if (unlikely(ret < 0))
+		print_bfs_bug(ret);
+
+	return ret;
+}
+
+/*
+ * Prove that the dependency graph starting at <src> can not
+ * lead to <target>. If it can, there is a circle when adding
+ * <target> -> <src> dependency.
+ *
+ * Print an error and return 0 if it does.
+ */
+static noinline int
+check_noncircular(struct held_lock *src, struct held_lock *target)
+{
+	int ret;
+	struct lock_list *uninitialized_var(target_entry);
+	struct lock_list src_entry = {
+		.class = hlock_class(src),
+		.parent = NULL,
+	};
 
 	debug_atomic_inc(nr_cyclic_checks);
 
-	result = __bfs_forwards(root, target, class_equal, target_entry);
+	ret = check_path(hlock_class(target), &src_entry, &target_entry);
 
-	return result;
+	if (unlikely(!ret))
+		print_circular_bug(&src_entry, target_entry, src, target);
+
+	return ret;
 }
 
+/*
+ * Check that the dependency graph starting at <src> can lead to
+ * <target> or not. If it can, <src> -> <target> dependency is already
+ * in the graph.
+ *
+ * Print an error and return 2 if it does or 1 if it does not.
+ */
 static noinline int
-check_redundant(struct lock_list *root, struct lock_class *target,
-		struct lock_list **target_entry)
+check_redundant(struct held_lock *src, struct held_lock *target)
 {
-	int result;
+	int ret;
+	struct lock_list *uninitialized_var(target_entry);
+	struct lock_list src_entry = {
+		.class = hlock_class(src),
+		.parent = NULL,
+	};
 
 	debug_atomic_inc(nr_redundant_checks);
 
-	result = __bfs_forwards(root, target, class_equal, target_entry);
+	ret = check_path(hlock_class(target), &src_entry, &target_entry);
 
-	return result;
+	if (!ret) {
+		debug_atomic_inc(nr_redundant);
+		ret = 2;
+	} else if (ret < 0)
+		ret = 0;
+
+	return ret;
 }
 
 #if defined(CONFIG_TRACE_IRQFLAGS)
@@ -2208,9 +2254,7 @@ static inline void inc_chains(void)
 check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	       struct held_lock *next, int distance)
 {
-	struct lock_list *uninitialized_var(target_entry);
 	struct lock_list *entry;
-	struct lock_list this;
 	struct lock_trace trace;
 	int ret;
 
@@ -2242,17 +2286,9 @@ static inline void inc_chains(void)
 	 * MAX_CIRCULAR_QUEUE_SIZE) which keeps track of a breadth of nodes
 	 * in the graph whose neighbours are to be checked.
 	 */
-	this.class = hlock_class(next);
-	this.parent = NULL;
-	ret = check_noncircular(&this, hlock_class(prev), &target_entry);
-	if (unlikely(!ret)) {
-		print_circular_bug(&this, target_entry, next, prev);
-		return 0;
-	}
-	else if (unlikely(ret < 0)) {
-		print_bfs_bug(ret);
+	ret = check_noncircular(next, prev);
+	if (unlikely(ret <= 0))
 		return 0;
-	}
 
 	if (!check_prev_add_irq(curr, prev, next))
 		return 0;
@@ -2286,17 +2322,9 @@ static inline void inc_chains(void)
 	/*
 	 * Is the <prev> -> <next> link redundant?
 	 */
-	this.class = hlock_class(prev);
-	this.parent = NULL;
-	ret = check_redundant(&this, hlock_class(next), &target_entry);
-	if (!ret) {
-		debug_atomic_inc(nr_redundant);
-		return 2;
-	}
-	if (ret < 0) {
-		print_bfs_bug(ret);
-		return 0;
-	}
+	ret = check_redundant(prev, next);
+	if (ret != 1)
+		return ret;
 
 	if (!save_trace(&trace))
 		return 0;
-- 
1.8.3.1

