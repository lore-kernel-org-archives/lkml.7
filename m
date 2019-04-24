Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EF3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF45921773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vB+Akpu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbfDXKWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:22:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35622 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfDXKVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:21:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id t21so9094819pfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4i8ndKb48XdQYlFpCqUcVw/pSceEV1kvm2UZn1AkLHA=;
        b=vB+Akpu02PPMocUZ04mkoowzxARnUwWoU/ONDqDCKbrX+f1pWC9TeTMZ6XiCDm0l47
         NJyIYLmaSSdK///6D2pzrERsPTzL9Cod05J6EUKkE0BbrzjSKjkq6CQa4vP9sTINuzEZ
         UY2H7iDEsPDLU9AlnMDs3jJl4p0puDQRAiCVvRHmuqh/pQQ/4s/k/SMpUGCAzElcUNK5
         zIFRIfJ5Kgg4IXjK1oaXYXiKw44xpU/vfifU6WEP6F/baVuUeif7tlpJNY5UizHhE5UI
         bI8zz/P0kDHvHYSzN+nsnuazyXk4D45xsYF4Tf5ZzYRle8i2B4ZfHRrjT5YCgfITAvHz
         z8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4i8ndKb48XdQYlFpCqUcVw/pSceEV1kvm2UZn1AkLHA=;
        b=nA6oUo3tNsMArjdMLqyd3KpiHIeFptvhZass73dip97Fh7NOoMfJtHLUKi2p0NF+8U
         P6ecbbBirR1P4nbZ0ihequ1TVZ0dOG/DHdWLNvz0JDp33x3f0fshIEi96fzJID9cQ9ll
         8VwfP+Fjj86rnx7hNgmXgKch7dm1bdeHuZ9rIvZDh4dFyVQzr0vqsf1QeDxibvgR5M0a
         /fFh66WDsWp+/4chNrAgDj3vaRAFHz0Anlsv0FPLWkOmXnYc2dLp3V60KqD7vqv6hY8W
         14vnyfxIvgR8RH0wRNf13fVXY4t18OgIxVDpza1a9V47oW4Z1ao4IYDX7XCtJ0wGgFYu
         OERw==
X-Gm-Message-State: APjAAAXJ3np1G199YRCss9e9cC8YioZTrdGc0VLHXbL0tb68mfC2eML3
        fMPluJWxLls4hMse3GJ9MyM=
X-Google-Smtp-Source: APXvYqyjqbwc9bE/7SqR6cCuLAmwo8D2/u3JUBAAO6MQTIt3yl03OJt38H2/R51NAQeYv1YEg3hbhQ==
X-Received: by 2002:a62:f20e:: with SMTP id m14mr33634724pfh.228.1556101311327;
        Wed, 24 Apr 2019 03:21:51 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:21:50 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 27/28] locking/lockdep: Remove locks_before
Date:   Wed, 24 Apr 2019 18:19:33 +0800
Message-Id: <20190424101934.51535-28-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the backward dependencies are always empty, remove the
locks_before field in lock_class struct and its occurrences.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h  |  5 ++---
 kernel/locking/lockdep.c | 15 +++------------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 0e209b8..d0a587c 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -97,10 +97,9 @@ struct lock_class {
 
 	/*
 	 * These fields represent a directed graph of lock dependencies,
-	 * to every node we attach a list of "forward" and a list of
-	 * "backward" graph nodes.
+	 * to every node we attach a list of "forward" graph nodes.
 	 */
-	struct list_head		locks_after, locks_before;
+	struct list_head		locks_after;
 
 	struct lockdep_subclass_key	*key;
 	unsigned int			subclass;
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index acaa3b3..fa6611e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -823,8 +823,7 @@ static bool in_list(struct list_head *e, struct list_head *h)
 }
 
 /*
- * Check whether entry @e occurs in any of the locks_after or locks_before
- * lists.
+ * Check whether entry @e occurs in any of the locks_after list.
  */
 static bool in_any_class_list(struct list_head *e)
 {
@@ -833,8 +832,7 @@ static bool in_any_class_list(struct list_head *e)
 
 	for (i = 0; i < ARRAY_SIZE(lock_classes); i++) {
 		class = &lock_classes[i];
-		if (in_list(e, &class->locks_after) ||
-		    in_list(e, &class->locks_before))
+		if (in_list(e, &class->locks_after))
 			return true;
 	}
 	return false;
@@ -922,8 +920,6 @@ static bool __check_data_structures(void)
 	/* Check whether all classes have valid lock lists. */
 	for (i = 0; i < ARRAY_SIZE(lock_classes); i++) {
 		class = &lock_classes[i];
-		if (!class_lock_list_valid(class, &class->locks_before))
-			return false;
 		if (!class_lock_list_valid(class, &class->locks_after))
 			return false;
 	}
@@ -1021,7 +1017,6 @@ static void init_data_structures_once(void)
 	for (i = 0; i < ARRAY_SIZE(lock_classes); i++) {
 		list_add_tail(&lock_classes[i].lock_entry, &free_lock_classes);
 		INIT_LIST_HEAD(&lock_classes[i].locks_after);
-		INIT_LIST_HEAD(&lock_classes[i].locks_before);
 	}
 }
 
@@ -1151,7 +1146,6 @@ static bool is_dynamic_key(const struct lock_class_key *key)
 	class->key = key;
 	class->name = lock->name;
 	class->subclass = subclass;
-	WARN_ON_ONCE(!list_empty(&class->locks_before));
 	WARN_ON_ONCE(!list_empty(&class->locks_after));
 	class->name_version = count_matching_names(class);
 	for (i = 0; i < ARRAY_SIZE(class->irqsafe_distance); i++)
@@ -4798,8 +4792,7 @@ static void zap_class(struct pending_free *pf, struct lock_class *class)
 		nr_list_entries--;
 		list_del_rcu(&entry->entry);
 	}
-	if (list_empty(&class->locks_after) &&
-	    list_empty(&class->locks_before)) {
+	if (list_empty(&class->locks_after)) {
 		list_move_tail(&class->lock_entry, &pf->zapped);
 		hlist_del_rcu(&class->hash_entry);
 		WRITE_ONCE(class->key, NULL);
@@ -4822,11 +4815,9 @@ static void reinit_class(struct lock_class *class)
 
 	WARN_ON_ONCE(!class->lock_entry.next);
 	WARN_ON_ONCE(!list_empty(&class->locks_after));
-	WARN_ON_ONCE(!list_empty(&class->locks_before));
 	memset(p + offset, 0, sizeof(*class) - offset);
 	WARN_ON_ONCE(!class->lock_entry.next);
 	WARN_ON_ONCE(!list_empty(&class->locks_after));
-	WARN_ON_ONCE(!list_empty(&class->locks_before));
 }
 
 static inline int within(const void *addr, void *start, unsigned long size)
-- 
1.8.3.1

