Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A03C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D0D218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbO/9kqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfDXKVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:21:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32911 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbfDXKU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:20:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id h5so9087812pfo.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=okEfUllLWyKhS67zFWTcs4Z8NAZObQ9Di1RueDY+4Wc=;
        b=PbO/9kqCV6umfY3XXBw3sOw4NrMChEiMN+PlQYznaOehlsN7N87ggezaI/t+IwQUP/
         5oNOzGFCNR3KQG8DD0YrMrMaLT9Q1aoshzCy2SB0XNwNBXVd5zoiJ/IiLZyXwRzmpnrs
         mjRSxHVV6bHmaUGpa/Y8oYcioBYeOhdG3rmufDEga6oOXrEM5T1YFlPResu/d2iH+pUz
         RlbzjcLJePAZ2+7mTb4PWbWbb9YxqU8m+4BQ9d9peoBYzoZsG0aMyzE+vX9Q0zlyrobs
         3ZkTQ0ZNNoGIAGJy613U9LBxe3JbD4isqTHtA/zFsk+ORYK2lsT/I0W0Y+3CjUMQarhK
         APSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=okEfUllLWyKhS67zFWTcs4Z8NAZObQ9Di1RueDY+4Wc=;
        b=ujUdIZ/DjxD9pIfr05uHm1sirKbm/0Cbu/v7Y5oN6EwmzKWKexjOJC2UycKa3+bIM+
         Aw4suaauTPxtoe964SVIBPoafudo0cbS/3MKICrBzGkh/Nhzj1AiaZr9ThjN4kMupn0h
         ZAxrsNiGh9SytaNr1AO3rWNnWpybB+BCJ34LFcMqX7IYB0c1GoJzqjWu81FHtWPfeilM
         7cpAHX9hRTDZzVyO1IsRflT9gZ2FxE2YSmEQ5PTyXlsT7H/z8htkYPk2NOpwSSXeAf0F
         Ai2zrdeSKLizcEwMDzJny5Lif08/tXL2EudtMiTcjGwdF04qz0bN50GdVzD+EFpfx70B
         9Jpg==
X-Gm-Message-State: APjAAAVMbIHlg1Qp396iCqzj3e10hTzgRGQITFIS9hjYESBuF/Fx5bUu
        St6WfoaaZLMHK07Z9i0r7m4=
X-Google-Smtp-Source: APXvYqzG6FMGIoxS9DXFIHpyym9JlCabqHBIPFy75XHxFoj7OJWx2CdgPF0YbDaHCWPa5WcgtcS1dw==
X-Received: by 2002:a62:2ad5:: with SMTP id q204mr32088879pfq.259.1556101258487;
        Wed, 24 Apr 2019 03:20:58 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.20.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:20:58 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 10/28] locking/lockdep: Remove unused argument in validate_chain() and check_deadlock()
Date:   Wed, 24 Apr 2019 18:19:16 +0800
Message-Id: <20190424101934.51535-11-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lockdep_map argument in them is not used, remove it.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3a2b0da..ec4043b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2128,8 +2128,7 @@ static inline void inc_chains(void)
  * Returns: 0 on deadlock detected, 1 on OK, 2 on recursive read
  */
 static int
-check_deadlock(struct task_struct *curr, struct held_lock *next,
-	       struct lockdep_map *next_instance, int read)
+check_deadlock(struct task_struct *curr, struct held_lock *next, int read)
 {
 	struct held_lock *prev;
 	struct held_lock *nest = NULL;
@@ -2279,7 +2278,6 @@ static inline void inc_chains(void)
 		return 0;
 	}
 
-
 	if (!save_trace(&trace))
 		return 0;
 
@@ -2679,8 +2677,9 @@ static inline int lookup_chain_cache_add(struct task_struct *curr,
 	return 1;
 }
 
-static int validate_chain(struct task_struct *curr, struct lockdep_map *lock,
-		struct held_lock *hlock, int chain_head, u64 chain_key)
+static int validate_chain(struct task_struct *curr,
+			  struct held_lock *hlock,
+			  int chain_head, u64 chain_key)
 {
 	/*
 	 * Trylock needs to maintain the stack of held locks, but it
@@ -2706,7 +2705,7 @@ static int validate_chain(struct task_struct *curr, struct lockdep_map *lock,
 		 * any of these scenarios could lead to a deadlock. If
 		 * All validations
 		 */
-		int ret = check_deadlock(curr, hlock, lock, hlock->read);
+		int ret = check_deadlock(curr, hlock, hlock->read);
 
 		if (!ret)
 			return 0;
@@ -2737,8 +2736,8 @@ static int validate_chain(struct task_struct *curr, struct lockdep_map *lock,
 }
 #else
 static inline int validate_chain(struct task_struct *curr,
-	       	struct lockdep_map *lock, struct held_lock *hlock,
-		int chain_head, u64 chain_key)
+				 struct held_lock *hlock,
+				 int chain_head, u64 chain_key)
 {
 	return 1;
 }
@@ -3720,7 +3719,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		WARN_ON_ONCE(!hlock_class(hlock)->key);
 	}
 
-	if (!validate_chain(curr, lock, hlock, chain_head, chain_key))
+	if (!validate_chain(curr, hlock, chain_head, chain_key))
 		return 0;
 
 	curr->curr_chain_key = chain_key;
-- 
1.8.3.1

