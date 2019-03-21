Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A86FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182662146E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3xbBO7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbfCUH63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:58:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39914 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbfCUH6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 03:58:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id i17so3788592pfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 00:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+o13T9DFMS0RJ6qbCf0R7iXbp/dGpnQOV33lCtkBhDM=;
        b=I3xbBO7HF4jMZpWll58mCPG7FYB6WWMD5dagN9PNlCcly0E76nNKAzQw7oe6womANv
         8IkOgqlc9oiyeqorwEONnFVlEQE3px93V3BvlRrmktsbOg6Ed67tRWXvschCABhwnI/t
         ax2osdyLNAeqqoKuAz16oKMnz94/plhBuxFghzSqBhAkEkI7YBYhfVBv031gpnSyy2k/
         GMaj9YagcOE+sYrfp6uJeJorD/JpjKHOUShE/jK0n1jA5M47lxj6PYIJBlrAEtg4G8sX
         aYMFuzYYiuRpe262d/0JDTBEhexbfV/YkHGSisqvVh+IZeQCHCsJggB/IVhBGvq3NfZZ
         TIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+o13T9DFMS0RJ6qbCf0R7iXbp/dGpnQOV33lCtkBhDM=;
        b=sEQSEIVj02cfYK3tW0jDJHSnctTCxY5oKAIxi1Zq2zSfMvZVtImD1VYuKtEllpSU86
         NYd9PkdD7JOysE1TR2qRgiiCTP3Kg0B+3ucc4SmeS10XJYaKaf7j05KvQXQq4KLwQhxv
         ON8O/8/XQG1dJBr28EqbPDa9t7AFhOWGU0jZVy6csvBye5Spqc4Oy6AoQcuLQVrJd1nQ
         1l4xhMAO4DKWZ/LymbAngKmJLedez6T1SjmTEUwAyg4jV96UiQR5b2dxcSRESJcuvwSg
         Tfzn4SPDbfE5DcjJLOTqgSfU3sk4l/s5+C6AaluK2sNej22peSynM+wH5FNXdFdYbT6o
         z6Hw==
X-Gm-Message-State: APjAAAVG2yZWk6dD2dKmeLRPkM3K8GcMfnmQ8T4LbVBXd/oB8Mo/rb4N
        zsoI6kIa5nGN5yQJ3EZw3sI8WHinvEAMvg==
X-Google-Smtp-Source: APXvYqxaMYw09Pw4arYCzzBbEGxGrHR4rwRQNXKFzjxlOumOMfLThMFAsCdB3HNxp005afjNiVo1Mw==
X-Received: by 2002:aa7:9103:: with SMTP id 3mr1997675pfh.192.1553155104816;
        Thu, 21 Mar 2019 00:58:24 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id e184sm6467148pfc.143.2019.03.21.00.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 00:58:24 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, joe@perches.com,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 17/18] locking/lockdep: Update comments on dependency search
Date:   Thu, 21 Mar 2019 15:57:24 +0800
Message-Id: <20190321075725.14054-18-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190321075725.14054-1-duyuyang@gmail.com>
References: <20190321075725.14054-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The breadth-first search is implemented as flat-out non-recursive now, but
the comments are still describing it as recursive, update the comments in
that regard.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 8202318..9df2b1a 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1390,6 +1390,10 @@ static inline struct list_head *get_dep_list(struct lock_list *lock, int offset)
 	return lock_class + offset;
 }
 
+/*
+ * Forward- or backward-dependency search, used for both circular dependency
+ * checking and hardirq-unsafe/softirq-unsafe checking.
+ */
 static int __bfs(struct lock_list *source_entry,
 		 void *data,
 		 int (*match)(struct lock_list *entry, void *data),
@@ -1471,12 +1475,6 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
 }
 
 /*
- * Recursive, forwards-direction lock-dependency checking, used for
- * both noncyclic checking and for hardirq-unsafe/softirq-unsafe
- * checking.
- */
-
-/*
  * Print a dependency chain entry (this is only done when a deadlock
  * has been detected):
  */
@@ -2177,7 +2175,7 @@ static inline void inc_chains(void)
 
 /*
  * There was a chain-cache miss, and we are about to add a new dependency
- * to a previous lock. We recursively validate the following rules:
+ * to a previous lock. We validate the following rules:
  *
  *  - would the adding of the <prev> -> <next> dependency create a
  *    circular dependency in the graph? [== circular deadlock]
@@ -2227,11 +2225,12 @@ static inline void inc_chains(void)
 	/*
 	 * Prove that the new <prev> -> <next> dependency would not
 	 * create a circular dependency in the graph. (We do this by
-	 * forward-recursing into the graph starting at <next>, and
-	 * checking whether we can reach <prev>.)
+	 * a breadth-first search into the graph starting at <next>,
+	 * which checks whether we can reach <prev>.)
 	 *
-	 * We are using global variables to control the recursion, to
-	 * keep the stackframe size of the recursive functions low:
+	 * The search is limited by the size of the circular queue (i.e.,
+	 * MAX_CIRCULAR_QUEUE_SIZE) which keeps track of a breadth of nodes
+	 * in the graph whose neighbours are to be checked.
 	 */
 	this.class = hlock_class(next);
 	this.parent = NULL;
-- 
1.8.3.1

