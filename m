Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F953C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D241218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnJL+pPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfCUH60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:58:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43754 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbfCUH6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 03:58:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id l11so3656405pgq.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 00:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HaYMXNuuKlOKGTu/I8pMrDGtm6cT2FsnJYHwPUacK/Y=;
        b=cnJL+pPZnEmNlTQs78ttYDf3qA1kFiCRHjuMaD7m6s81btGOzwgHsFqHOwE5M1f7QW
         lVKAgMv6FFZVsfJIhOJ+3dlgcpx/GAz0AI0ekdCz+hKBCHHEnoSCILfL8reQTrbYyz0f
         imH9ayjiUXszZfOMv3tYA6RD9OUffdWVk6DK+5kKSMI4qUXKCNaI8NvXWK+ICLW0b5aC
         kYVTEj7mPK4Ju9+owBfM+5AtL2rjzDRZOtp3aHu+xyjNlV+Ymj+fab+zxXmxUzllpvo2
         0rRehDJr7Nd5u5R1FtUWh5X5NvGbwDIgd6VFo/Q8kDuy6QuiMDt5Jff9siTRNjw1curn
         coRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HaYMXNuuKlOKGTu/I8pMrDGtm6cT2FsnJYHwPUacK/Y=;
        b=N3InSRNsE6ODMP7OEv1S/SqASlWA0I5MiaQSZBA436BePCWg/UJbUgutbYc7SBbHv+
         ZzHprc9Ra6sIi66GsNSgHP9vY4zhPj8OABJ+3LFFAWKLaLFTXdzVIRu56i9uchfujurq
         28bwjXn9DfTKgB1s1pEJbqztbZ9dQJRJE+Eid4ae0WBt+ajwhZIMX7UBsI1IalR5qYnS
         LGeDkmeVF8todMLgQ+lO6TUl5q+a0Rk3CVGAJeN8i8KZnaQOgHLMqv8k1NAcKytI9pYG
         BIXxSkqBYvYVCYxH5/TmiK9g6fLKQJAFLijYiI8/sQyZjlbP6PksClSO2SY9J+O7XCSt
         klBg==
X-Gm-Message-State: APjAAAUx+NKAJ8WujiM+Pj5E9F5Y+cnuZDgNqwIu/YABi12S7uxLaYVl
        WDYb5LZsjMR8Bj/PmWYU8a4=
X-Google-Smtp-Source: APXvYqxPFgNtKUvzTEQAksECjc5fdmpALuA3sd3QiDCqyPourd+iKUG2oCQH5CEQOiQ84EBDwiumzg==
X-Received: by 2002:a17:902:1123:: with SMTP id d32mr2173059pla.16.1553155101383;
        Thu, 21 Mar 2019 00:58:21 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id e184sm6467148pfc.143.2019.03.21.00.58.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 00:58:20 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, joe@perches.com,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 16/18] locking/lockdep: Combine check_noncircular and check_redundant
Date:   Thu, 21 Mar 2019 15:57:23 +0800
Message-Id: <20190321075725.14054-17-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190321075725.14054-1-duyuyang@gmail.com>
References: <20190321075725.14054-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two functions are essentially duplicates, combine them into
check_nonexistent(). Also update the comment on it.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index cd6792c..8202318 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1688,29 +1688,18 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 }
 
 /*
- * Prove that the dependency graph starting at <entry> can not
- * lead to <target>. Print an error and return 0 if it does.
+ * Prove that the dependency graph starting at <root> can not
+ * lead to <target>. If existent, there is a circle when adding
+ * a <target> -> <root> dependency.
+ *
+ * Print an error and return 0 if it does exist.
  */
 static noinline int
-check_noncircular(struct lock_list *root, struct lock_class *target,
-		struct lock_list **target_entry)
+check_nonexistent(struct lock_list *root, struct lock_class *target,
+		  struct lock_list **target_entry)
 {
 	int result;
 
-	debug_atomic_inc(nr_cyclic_checks);
-
-	result = __bfs_forwards(root, target, class_equal, target_entry);
-
-	return result;
-}
-
-static noinline int
-check_redundant(struct lock_list *root, struct lock_class *target,
-		struct lock_list **target_entry)
-{
-	int result;
-
-	debug_atomic_inc(nr_redundant_checks);
 
 	result = __bfs_forwards(root, target, class_equal, target_entry);
 
@@ -2246,7 +2235,8 @@ static inline void inc_chains(void)
 	 */
 	this.class = hlock_class(next);
 	this.parent = NULL;
-	ret = check_noncircular(&this, hlock_class(prev), &target_entry);
+	debug_atomic_inc(nr_cyclic_checks);
+	ret = check_nonexistent(&this, hlock_class(prev), &target_entry);
 	if (unlikely(!ret)) {
 		if (!trace->entries) {
 			/*
@@ -2298,7 +2288,8 @@ static inline void inc_chains(void)
 	 */
 	this.class = hlock_class(prev);
 	this.parent = NULL;
-	ret = check_redundant(&this, hlock_class(next), &target_entry);
+	debug_atomic_inc(nr_redundant_checks);
+	ret = check_nonexistent(&this, hlock_class(next), &target_entry);
 	if (!ret) {
 		debug_atomic_inc(nr_redundant);
 		return 2;
-- 
1.8.3.1

