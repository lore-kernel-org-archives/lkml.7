Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16A4C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742542087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NM3y1A/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfEFIU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:20:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40016 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfEFIUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:20:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so6091060pgl.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vOQ/ZXgXh1iGHeDRXw+fWRdbLu9r0kMK3YDSDZUg4YA=;
        b=NM3y1A/2JvaKc58ZS0Le9fKR8MxJULS4S3sp0Q/COZHmOxHah2wU4V9CGsk0MkKHx5
         TpY4iZjcKdEf+JZWYbsovr46zMTJ7A5o+e01Unv8xSOn753WuYvW/JNThkjtAOWE2Cnw
         aCackPtit+Hqw6UXfdKI587ogulyCKWq6ZaH1xOY1LBeFnD1c6YxS7mKDSxJsoFbzwCX
         ddwDevTtQvaOdH6HkT8mcnqnKf63oSc2yXWSJBf5qjas9cUGOx9dTjE34Z4Fx+HqLCll
         KVQAFhiRJftW/yLdlYxY359Fxpu/kpvF4aGhbAlpBOM4C10QY/WY0JjfWiXf051lBCWz
         GbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vOQ/ZXgXh1iGHeDRXw+fWRdbLu9r0kMK3YDSDZUg4YA=;
        b=t/X/CYFN88+zlD4LsxRCsUYWN3m8WFi6oQD4kQ3DhSPNuoajBMn0DltMiVksQSxc4S
         1MYvlVMWUEjJybwNdydGHthSpET+yzLfhGsnJbbknI8fZSsgZdvKNwZEDMgwbtp6Dbhl
         cPAURmWwAnIItKOYjdlM1jpTKNde5l1ZGnXA4IsDgHsw1w/BwW94E2wOVsF5+kcO+2Wh
         CctHybFRsgia5ClRU0lBkaLPE8/4GwuhECQreg7/N6ms9SpiN5Wed0GnjTJ2kChJ+rjB
         H2DzQNpWWtiQ4UY36jaPd/R0WjpvUyEkPQ/WB8p3/nXGHEKOOTxGQua2vr0e0zEXm8Kq
         NS5g==
X-Gm-Message-State: APjAAAWeP+kCAe2PPoCQGnySgR7/pb6BUFJqW+5J2iXcHpzCuSHsJU8Q
        336+iowuHSy4KMx3KI7tlYY=
X-Google-Smtp-Source: APXvYqxlCcCQOcvH1/oAF9Uva0jIkCq6M9LhWJuezMUdZTNdpTPjTJuCMk7K8yruOaWWqDLHjYqnAQ==
X-Received: by 2002:a63:1b04:: with SMTP id b4mr30248310pgb.305.1557130821324;
        Mon, 06 May 2019 01:20:21 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm20958013pfa.138.2019.05.06.01.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 01:20:20 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 10/23] locking/lockdep: Remove unused argument in validate_chain() and check_deadlock()
Date:   Mon,  6 May 2019 16:19:26 +0800
Message-Id: <20190506081939.74287-11-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190506081939.74287-1-duyuyang@gmail.com>
References: <20190506081939.74287-1-duyuyang@gmail.com>
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
 kernel/locking/lockdep.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 76152cc..aa36502 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2225,8 +2225,7 @@ static inline void inc_chains(void)
  * Returns: 0 on deadlock detected, 1 on OK, 2 on recursive read
  */
 static int
-check_deadlock(struct task_struct *curr, struct held_lock *next,
-	       struct lockdep_map *next_instance, int read)
+check_deadlock(struct task_struct *curr, struct held_lock *next, int read)
 {
 	struct held_lock *prev;
 	struct held_lock *nest = NULL;
@@ -2784,8 +2783,9 @@ static inline int lookup_chain_cache_add(struct task_struct *curr,
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
@@ -2811,7 +2811,7 @@ static int validate_chain(struct task_struct *curr, struct lockdep_map *lock,
 		 * any of these scenarios could lead to a deadlock. If
 		 * All validations
 		 */
-		int ret = check_deadlock(curr, hlock, lock, hlock->read);
+		int ret = check_deadlock(curr, hlock, hlock->read);
 
 		if (!ret)
 			return 0;
@@ -2842,8 +2842,8 @@ static int validate_chain(struct task_struct *curr, struct lockdep_map *lock,
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
@@ -3825,7 +3825,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		WARN_ON_ONCE(!hlock_class(hlock)->key);
 	}
 
-	if (!validate_chain(curr, lock, hlock, chain_head, chain_key))
+	if (!validate_chain(curr, hlock, chain_head, chain_key))
 		return 0;
 
 	curr->curr_chain_key = chain_key;
-- 
1.8.3.1

