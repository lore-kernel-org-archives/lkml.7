Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA4FC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD9D2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bfhbj1w3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfEFIUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:20:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38809 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfEFIUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:20:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so6098092pgl.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jncaqXpvY9xiIvXn8Y040qvm3yjppXEdYjg++AKhNVI=;
        b=Bfhbj1w36mqYHvEtPxZ35+PNe5TwYdL2vKfcb/A07W10m/xbYsCuKyHA/yBVWzbW+L
         q5XJ2gjjr/1KtCPv+kqyjdvkzmXGGFp/u364fSBV2o88zyo1f/oYtCRQDe21S9Bx4pvP
         Z6o8vkMXnH6xBVkGka8dMdungtRKcpoQNfdtHsTi9yBI9fdMWgqbt+jqKdnfZOcYJy0D
         yTraIc72PmejnyX6GUwODKqqKH6b0+HlRUmeqh/yPyA4TVHZjwJrKNGQs+ZjiYkm55M5
         Zs9IJlNmSsxQNuvrMRlN8NzEwnTCpzMcW5GlW0shB4vFq6FHgLHow48/VQuqpqxijeUh
         oUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jncaqXpvY9xiIvXn8Y040qvm3yjppXEdYjg++AKhNVI=;
        b=MPuK5nN5qX5UOdC35Tjh9n/cJTSLW0LSuEr9HJJqVinQ+C1BLNnxNS0dAAxmE2Ukon
         o23shFsEUlExDJhjuAzZTGfFmtA39dJ9wgwxexxpyKhyIsB0iggLn6vtZuWSncdvpYMu
         PS9DiVu37KjaDJ3zenTPEhSVcBe62r3NIQczIfFmMsh4LNM2BG6HY78RzLF9LdgCRKNZ
         9mK+ZKmGoW0Qfatk5ws/M6e6Ie/9xP3rGuYOQIpjSXxiZ2VudC2vBDvNt4vRTtGOZXGm
         qmG5T/dA0dlLxh9lur8nj+rF/aTv0GgBGsSJyIdxGBWEv6RG2rGS4EXFPb9R6w++AP8O
         G9Mg==
X-Gm-Message-State: APjAAAXOA1VwcDZFLlogAVhddH9Ee893NlyGrRMjHy/ehoQ8gTqn23/E
        KnM37oVXNXNhI9ZPohQEdyc=
X-Google-Smtp-Source: APXvYqxWkQNMHLBnpH3eJiUDEizEP9HHCxgWNoS1q08/qPpbX4VMVs4tFGzmrL/5plTfrqfhDtuSmw==
X-Received: by 2002:a62:5a42:: with SMTP id o63mr33025957pfb.170.1557130837029;
        Mon, 06 May 2019 01:20:37 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm20958013pfa.138.2019.05.06.01.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 01:20:36 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 15/23] locking/lockdep: Update comments on dependency search
Date:   Mon,  6 May 2019 16:19:31 +0800
Message-Id: <20190506081939.74287-16-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190506081939.74287-1-duyuyang@gmail.com>
References: <20190506081939.74287-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 15cf2ac..7bd62e2 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1376,6 +1376,10 @@ static inline struct list_head *get_dep_list(struct lock_list *lock, int offset)
 	return lock_class + offset;
 }
 
+/*
+ * Forward- or backward-dependency search, used for both circular dependency
+ * checking and hardirq-unsafe/softirq-unsafe checking.
+ */
 static int __bfs(struct lock_list *source_entry,
 		 void *data,
 		 int (*match)(struct lock_list *entry, void *data),
@@ -1456,12 +1460,6 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
 
 }
 
-/*
- * Recursive, forwards-direction lock-dependency checking, used for
- * both noncyclic checking and for hardirq-unsafe/softirq-unsafe
- * checking.
- */
-
 static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)
 {
 	unsigned long *entries = stack_trace + trace->offset;
@@ -2280,7 +2278,7 @@ static inline void inc_chains(void)
 
 /*
  * There was a chain-cache miss, and we are about to add a new dependency
- * to a previous lock. We recursively validate the following rules:
+ * to a previous lock. We validate the following rules:
  *
  *  - would the adding of the <prev> -> <next> dependency create a
  *    circular dependency in the graph? [== circular deadlock]
@@ -2330,11 +2328,12 @@ static inline void inc_chains(void)
 	/*
 	 * Prove that the new <prev> -> <next> dependency would not
 	 * create a circular dependency in the graph. (We do this by
-	 * forward-recursing into the graph starting at <next>, and
-	 * checking whether we can reach <prev>.)
+	 * a breadth-first search into the graph starting at <next>,
+	 * and check whether we can reach <prev>.)
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

