Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A208CC04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66196208C0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjJlj6D6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfEFIVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:21:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36959 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfEFIUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:20:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id g3so6352394pfi.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+8HIoRSyDPaSOtCc6WVfXhPNvkE0D51zSx8WtXTLxao=;
        b=TjJlj6D6iObGQWNC6mjY5viFyYUfLeBqv1XY3YKsicJRHP86kDbbTdEGVmnymlA7kZ
         VxSty4rFVgFLMtC9Z+QlWk//k+Y0pTjLR8zPN/nsNkhh1ZNi9lEcDWqptfwjs2Y6nQ5D
         Sgu+rvwEDXACiJX0eKrMv49tcVS8+wA+MSJw0G47lN7gfR7pR/a7moJfdk9ep0FVnlSP
         LV0IurlVDrj0c7IH3PfqGOcaf7n1bgRHbMScXa9YO/pknhbhdH4nlYMST2BlQXdC1g6W
         2+hSOO+SC6aYHW6oKmBnO7aKuM+tCMBQTPsXUUobfeyarEawOzqfiauJSshv8Iz7Vp/B
         W6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+8HIoRSyDPaSOtCc6WVfXhPNvkE0D51zSx8WtXTLxao=;
        b=lJZdAjkq1gaWabUNz01fAQLgUGoLsVAwq5PUiqGECWJ2ieHIzW3kXOIpRHfp/cpsir
         bOSCpA6P+NVZsZlWS8KhH0yTNt1fQ8ddtQUG1oBhzXBu0KKh+QHHIl50+JgRW2xg1DAh
         jV6EtbsklyIotFK2zWkb3l28ewSWMm5U/MeJ34GXHjGuazhbyg48PjIPpub7+Nlcx4cH
         furd3ZapXuTJfA0OIDHRTLiOvigGizZ0UTJwtHZPkIzFvleBGae33a25Mvvk7V/9gWKL
         fpFQc85GK3VHKLXysb7zZO6CsEb0UxofwCenSikR5W7m/1Y4rex87QPL289uDDcpWeYh
         YndQ==
X-Gm-Message-State: APjAAAV1aG4YFQ2gm4D8lfpua9teUaaHJ3VwuiumoNURnIE8coOps4PK
        HuQ3RhCQPgqjA5cZOknqS6A=
X-Google-Smtp-Source: APXvYqyps9j/IbWcccPBcH3kvO0rvSxX5ijEtgazw/TVq1cRwYEZgNPyUzd6eObN8vDSc1MgTUMrkg==
X-Received: by 2002:a63:de11:: with SMTP id f17mr29708964pgg.94.1557130849411;
        Mon, 06 May 2019 01:20:49 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm20958013pfa.138.2019.05.06.01.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 01:20:48 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 19/23] locking/lockdep: Refactorize check_noncircular and check_redundant
Date:   Mon,  6 May 2019 16:19:35 +0800
Message-Id: <20190506081939.74287-20-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190506081939.74287-1-duyuyang@gmail.com>
References: <20190506081939.74287-1-duyuyang@gmail.com>
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
 kernel/locking/lockdep.c | 118 +++++++++++++++++++++++++++++------------------
 1 file changed, 74 insertions(+), 44 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index ebfa42a..2502ea4 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1678,33 +1678,90 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
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
+check_noncircular(struct held_lock *src, struct held_lock *target,
+		  struct lock_trace *trace)
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
+	if (unlikely(!ret)) {
+		if (!trace->nr_entries) {
+			/*
+			 * If save_trace fails here, the printing might
+			 * trigger a WARN but because of the !nr_entries it
+			 * should not do bad things.
+			 */
+			save_trace(trace);
+		}
+
+		print_circular_bug(&src_entry, target_entry, src, target);
+	}
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
 
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -2302,9 +2359,7 @@ static inline void inc_chains(void)
 check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	       struct held_lock *next, int distance, struct lock_trace *trace)
 {
-	struct lock_list *uninitialized_var(target_entry);
 	struct lock_list *entry;
-	struct lock_list this;
 	int ret;
 
 	if (!hlock_class(prev)->key || !hlock_class(next)->key) {
@@ -2335,25 +2390,9 @@ static inline void inc_chains(void)
 	 * MAX_CIRCULAR_QUEUE_SIZE) which keeps track of a breadth of nodes
 	 * in the graph whose neighbours are to be checked.
 	 */
-	this.class = hlock_class(next);
-	this.parent = NULL;
-	ret = check_noncircular(&this, hlock_class(prev), &target_entry);
-	if (unlikely(!ret)) {
-		if (!trace->nr_entries) {
-			/*
-			 * If save_trace fails here, the printing might
-			 * trigger a WARN but because of the !nr_entries it
-			 * should not do bad things.
-			 */
-			save_trace(trace);
-		}
-		print_circular_bug(&this, target_entry, next, prev);
+	ret = check_noncircular(next, prev, trace);
+	if (unlikely(ret <= 0))
 		return 0;
-	}
-	else if (unlikely(ret < 0)) {
-		print_bfs_bug(ret);
-		return 0;
-	}
 
 	if (!check_irq_usage(curr, prev, next))
 		return 0;
@@ -2387,18 +2426,9 @@ static inline void inc_chains(void)
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
-
+	ret = check_redundant(prev, next);
+	if (ret != 1)
+		return ret;
 
 	if (!trace->nr_entries && !save_trace(trace))
 		return 0;
-- 
1.8.3.1

