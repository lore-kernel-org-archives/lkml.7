Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F97C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696B32087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCNkBV4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfEFIVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:21:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34435 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfEFIUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:20:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id b3so6362782pfd.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YR1uPUJkVk7yfuNsYEGBjpJtJTSenXj3xCLi83CgQCQ=;
        b=mCNkBV4IgMyS5Odt2U30IIR20STOIrsRBiSP0iAHuqTxsIitdfPIOvgCVw3f0iThNg
         xvF5SQslWgY7IEa8zcRl4Wo29ldvHS1Dx9QY6MLj3ZonHU10yagK+aTXNKOSIU33KJ3B
         flLwkk8+h+BR3GN6GP2LrefuRfiK1Q/ZbksdJ7iTod7YYEZROV+ABgrS2JZYK1SvQwxB
         WxvoEUq/v+BTwsEt/rcgpO/AeEjMQ1yQXEfcbtbSUpnhH8Wu6wBetMWlkQ9BJBgCzxlH
         uA/1qJkYdiZlLiAaf+ApQDAooKfoda2a/wqoKcEsC6iucVOXkNS7g2Oxpr6t/MmhMn7G
         lQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YR1uPUJkVk7yfuNsYEGBjpJtJTSenXj3xCLi83CgQCQ=;
        b=aTCMPwI5+Tp+5+6t3ooK9Ja3SFDZtOdL7wdbBoyV0HWBdGyfADhQsG40+e4e+fgZEz
         vChaqIkqltIl9nlTmPx9EbL/4XurJJRJQNuTnbr4q1PjDJpjfJkG8qFTNHxwfXaEi+rB
         pkmredy4zcWTIqYfgsVcBuF3io2lX3es7Oex11bo4C4tDQT52pRvxnF85/5fynx5n4v8
         Rr5B3GGKKXzow9JpeNa/KeFik7Ng0fHTTfjuSLqd8NUIv9+bTvDegQW/dr+OOYBNzJod
         BYA7QsZWdr4u/8m5N8D9GUemkRhgzJBqy9Q30GlywHxlTvTgkjmLsXWiHVXYTBh86tT/
         BNtg==
X-Gm-Message-State: APjAAAViRUbvGPIZ3oKGLBr3FmNOMU16TLIagJcxJzZSOBaZq3eLGcS1
        lEVmezxxGUoJmm5/+ID+HiQ=
X-Google-Smtp-Source: APXvYqx93xvJxwyDr+5//OVD6EMB327ZWW4cnjR0XSTvrSzLBFUTEGM01bqdYhhZmu1vvEvml2CcXw==
X-Received: by 2002:a63:7982:: with SMTP id u124mr30041388pgc.352.1557130833910;
        Mon, 06 May 2019 01:20:33 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm20958013pfa.138.2019.05.06.01.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 01:20:33 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 14/23] locking/lockdep: Avoid constant checks in __bfs by using offset reference
Date:   Mon,  6 May 2019 16:19:30 +0800
Message-Id: <20190506081939.74287-15-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190506081939.74287-1-duyuyang@gmail.com>
References: <20190506081939.74287-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In search of a dependency in the lock graph, there is contant checks for
forward or backward search. Directly reference the field offset of the
struct that differentiates the type of search to avoid those checks.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 5a0c908f..15cf2ac 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1362,11 +1362,25 @@ static inline int get_lock_depth(struct lock_list *child)
 	return depth;
 }
 
+/*
+ * Return the forward or backward dependency list.
+ *
+ * @lock:   the lock_list to get its class's dependency list
+ * @offset: the offset to struct lock_class to determine whether it is
+ *          locks_after or locks_before
+ */
+static inline struct list_head *get_dep_list(struct lock_list *lock, int offset)
+{
+	void *lock_class = lock->class;
+
+	return lock_class + offset;
+}
+
 static int __bfs(struct lock_list *source_entry,
 		 void *data,
 		 int (*match)(struct lock_list *entry, void *data),
 		 struct lock_list **target_entry,
-		 int forward)
+		 int offset)
 {
 	struct lock_list *entry;
 	struct lock_list *lock;
@@ -1380,11 +1394,7 @@ static int __bfs(struct lock_list *source_entry,
 		goto exit;
 	}
 
-	if (forward)
-		head = &source_entry->class->locks_after;
-	else
-		head = &source_entry->class->locks_before;
-
+	head = get_dep_list(source_entry, offset);
 	if (list_empty(head))
 		goto exit;
 
@@ -1398,10 +1408,7 @@ static int __bfs(struct lock_list *source_entry,
 			goto exit;
 		}
 
-		if (forward)
-			head = &lock->class->locks_after;
-		else
-			head = &lock->class->locks_before;
+		head = get_dep_list(lock, offset);
 
 		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
 
@@ -1434,7 +1441,8 @@ static inline int __bfs_forwards(struct lock_list *src_entry,
 			int (*match)(struct lock_list *entry, void *data),
 			struct lock_list **target_entry)
 {
-	return __bfs(src_entry, data, match, target_entry, 1);
+	return __bfs(src_entry, data, match, target_entry,
+		     offsetof(struct lock_class, locks_after));
 
 }
 
@@ -1443,7 +1451,8 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
 			int (*match)(struct lock_list *entry, void *data),
 			struct lock_list **target_entry)
 {
-	return __bfs(src_entry, data, match, target_entry, 0);
+	return __bfs(src_entry, data, match, target_entry,
+		     offsetof(struct lock_class, locks_before));
 
 }
 
-- 
1.8.3.1

