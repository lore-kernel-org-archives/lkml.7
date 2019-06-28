Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677C2C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B68F208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2fRjok0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfF1JP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:15:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44223 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfF1JP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:15:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so2652355pfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LrejKXGQ1w0xv5dXMTolgVu6Mt2RPt99t9Zyghhmncc=;
        b=g2fRjok05T8sDhCGihSZhKC1VkmrQHJTG6puiIgFVoFjEj8ykJXoliOc+ljRzlCwkW
         Ek36iPrtwD/1+HqaBV6OSWBIIHg4/iCon7dNgxgnm1Z4u/BuytWNBrjEndydGTJ9vPll
         iidA99nMyOerR3WhwYAt4TlZf5/XbR9pkIjtWf5B6/R8aTi/8ZArDdsRHcepVDJHZ2KD
         5y76EhzMLzIcEq/DCpycqxJ9ybbF1/QMBuTaDJuE3GaSBzDk+UrqWm3qrIkrgkRpnTcY
         hXiH66NxIMJl5uAPr11ZOxtk+3IKRiuSTgoT7jOZN3aKODngdKjnqBqlDCUgfzicWAie
         F26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LrejKXGQ1w0xv5dXMTolgVu6Mt2RPt99t9Zyghhmncc=;
        b=YRjCcxXt6GeRV711YVwWW6d2ni6CBiyg1+w8T/26uTwJlvfW/itoqBS+u5i80iIJjX
         Vd8upstTKvKqEYd8BZrSHMANpG1d/+a8yUPDzSXqCBDIhlKKn3FkXG5Ihh39jK9pH/ni
         wtsdHaNS403tb6N7mCDVn3ZTzrVXBtC+s3CuT6CidCgxpMM5IIVkInsJlHdTAwPORq9u
         W1RZuf8WiP8CKV5geytXk/jEOReGD7tnNIHPESzqG+tCY6KaepuSr+AFJuvnf23etRzm
         zjJ74wmzZgGpxkQ5Wi6XxLESxYwM2qISpY/FT1iUJobWJ5DLxUM8M3K0GFgx3MB32RJF
         6AXg==
X-Gm-Message-State: APjAAAVTaAPuIXr6oDesp6TtHLuADt9nRIIu5A/OeBeI+MgpTT2wL5a9
        +RFUoRQxPEjXpjYrLgVbgZjhHtd+315+CQ==
X-Google-Smtp-Source: APXvYqw0Nz6jfkTZJobyFuFwTQ9cxrzjr6F1Lbl60NGul9fCc6CBo6261mSlRHSSK2y5ylQgb/1Tzg==
X-Received: by 2002:a63:6843:: with SMTP id d64mr991072pgc.383.1561713357112;
        Fri, 28 Jun 2019 02:15:57 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:15:56 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 03/30] locking/lockdep: Change return type of lookup_chain_cache_add()
Date:   Fri, 28 Jun 2019 17:15:01 +0800
Message-Id: <20190628091528.17059-4-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the previous change, the function lookup_chain_cache_add() returns
the pointer of the lock chain if the chain is new.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3546894..d545b6c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2796,13 +2796,13 @@ static inline struct lock_chain *lookup_chain_cache(u64 chain_key)
 
 /*
  * If the key is not present yet in dependency chain cache then
- * add it and return 1 - in this case the new dependency chain is
- * validated. If the key is already hashed, return 0.
- * (On return with 1 graph_lock is held.)
+ * add it and return the chain - in this case the new dependency
+ * chain will be validated. If the key is already hashed, return
+ * NULL. (On return with the new chain graph_lock is held.)
  */
-static inline int lookup_chain_cache_add(struct task_struct *curr,
-					 struct held_lock *hlock,
-					 u64 chain_key)
+static inline struct lock_chain *
+lookup_chain_cache_add(struct task_struct *curr, struct held_lock *hlock,
+		       u64 chain_key)
 {
 	struct lock_class *class = hlock_class(hlock);
 	struct lock_chain *chain = lookup_chain_cache(chain_key);
@@ -2810,7 +2810,7 @@ static inline int lookup_chain_cache_add(struct task_struct *curr,
 	if (chain) {
 cache_hit:
 		if (!check_no_collision(curr, hlock, chain))
-			return 0;
+			return NULL;
 
 		if (very_verbose(class)) {
 			printk("\nhash chain already cached, key: "
@@ -2819,7 +2819,7 @@ static inline int lookup_chain_cache_add(struct task_struct *curr,
 					class->key, class->name);
 		}
 
-		return 0;
+		return NULL;
 	}
 
 	if (very_verbose(class)) {
@@ -2828,7 +2828,7 @@ static inline int lookup_chain_cache_add(struct task_struct *curr,
 	}
 
 	if (!graph_lock())
-		return 0;
+		return NULL;
 
 	/*
 	 * We have to walk the chain again locked - to avoid duplicates:
@@ -2839,10 +2839,7 @@ static inline int lookup_chain_cache_add(struct task_struct *curr,
 		goto cache_hit;
 	}
 
-	if (!add_chain_cache(curr, hlock, chain_key))
-		return 0;
-
-	return 1;
+	return add_chain_cache(curr, hlock, chain_key);
 }
 
 static int validate_chain(struct task_struct *curr,
-- 
1.8.3.1

