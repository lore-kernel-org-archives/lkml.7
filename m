Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB924C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CB021773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiW8G5O3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbfDXKVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:21:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41422 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbfDXKVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:21:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so9152802pgs.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TTSJeJChcHNZMTBu1HF95U4ErzrozbTOn8A0dkI+M1k=;
        b=CiW8G5O3fZy7IFTCBdCPcs+Y/sstsAe0Cv7e939CYl70R2NsN7k91Lz/CEeloQePPC
         GE1zm/Lm3s80fxAsbIfZeeJmyZ8+6EgmnrEkpjJc0H78pf1O7TZA/3/Uwr9+YTD34+8R
         u2It7Bi5qHsgN4/T/6nJPiAzHwoJz/Pis/Ra+arOKP8ba7VlfIFxVUd2dE4NLRwRdgE+
         1HaOJBYFBQ4AkELhWzGCmn+D2s2RmIAEA6TSQgMrXnqT672WgSdyWNZxr09KzTB3BoTs
         U4Gjx5HkK7CJfM9Dfdyd8wF9mubyuXbFa5tdx/D+dQ0hi3O70a9XVu+MSza3NEovc6Ya
         I4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TTSJeJChcHNZMTBu1HF95U4ErzrozbTOn8A0dkI+M1k=;
        b=oFnFq2rQlvGBOqUQI/sOBpEt3ujWM+ohs1+R8bPBE0hSF/Wh9q8fAPQI6EvtgNt2f9
         4Am9mtN6sXZwtBX4ixc33psz2uSBsxuWGhhSYVNhi10Vs4qUPBXDJHwfDCJjvmKrIc0T
         bqx81Og+lOHE2TiU6qhr+vXWra6r8JOHzkng9Mg6Iifn64hazZSyZThFq+YaVM4cFf6+
         8oVdT56QAKOef+GQLk1hjtY3zRqRc9oi7HVR8QJbbJ+gLdQwaElc552vPW/QBZXBfK9F
         jWB2oq8CcH04hQaKLsbSyco2Yb7FouQePGr2YyMvnrU+aaLZulJYHpY69pe1+fKHCjC+
         Qhhw==
X-Gm-Message-State: APjAAAVt8PD+tSjt3Xa4PdnS2CqZxn/qkQd8CLBDLQklhgubEiyE9VoL
        vyY/Z2LLK7VjWAIE36B1RZo=
X-Google-Smtp-Source: APXvYqy8ky5feQD5Ff775omZnMk42zV1ljjcYHuH8IKC7EeH7ohLND2MZxit7JvVijJpgFbO/R0QHQ==
X-Received: by 2002:a63:ee15:: with SMTP id e21mr774463pgi.180.1556101273774;
        Wed, 24 Apr 2019 03:21:13 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:21:13 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 15/28] locking/lockdep: Update comments on dependency search
Date:   Wed, 24 Apr 2019 18:19:21 +0800
Message-Id: <20190424101934.51535-16-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
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
index 16f524c..d153b97 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1375,6 +1375,10 @@ static inline struct list_head *get_dep_list(struct lock_list *lock, int offset)
 	return lock_class + offset;
 }
 
+/*
+ * Forward- or backward-dependency search, used for both circular dependency
+ * checking and hardirq-unsafe/softirq-unsafe checking.
+ */
 static int __bfs(struct lock_list *source_entry,
 		 void *data,
 		 int (*match)(struct lock_list *entry, void *data),
@@ -1455,12 +1459,6 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
 
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
@@ -2182,7 +2180,7 @@ static inline void inc_chains(void)
 
 /*
  * There was a chain-cache miss, and we are about to add a new dependency
- * to a previous lock. We recursively validate the following rules:
+ * to a previous lock. We validate the following rules:
  *
  *  - would the adding of the <prev> -> <next> dependency create a
  *    circular dependency in the graph? [== circular deadlock]
@@ -2233,11 +2231,12 @@ static inline void inc_chains(void)
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

