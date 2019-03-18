Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A605C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5502082F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDwCsg1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfCRI6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:58:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35266 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfCRI6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:58:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id g8so261203pgf.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 01:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hfiVd3OBtopIjjlxzVpJmPhqmGR52gATqqr1d/XNrlg=;
        b=ZDwCsg1+ZGiTkk1Ppo5ReBaF0htN//Q6pml1SSesLF0svvWmOMwXU1btwMB48xwfvL
         vc4rn82Ga8L3Cwf8/g3i0CISV1kKt5yTi2y7E8HNaXWtlAq4GNn+78TpmLX2mKkAaGtv
         EYwlqK1sOnIQSwLk29mKi2J+Dz4R6jg/flRDwmUvdsvHQb6ai60Bp+6P8NEV40Rwm/O+
         mUzycOSwicp91CWutILOrhbaxVpPdazKyV2Yn/EwXh+4bG4JS7ZiJJTH3sgiHmHJHhQ0
         hFjQAG4rdmKYbQj8KNpQ45AS4chG9gror48e981lnnmvFXS3m+BG9XoOUBGTitf9yzjG
         tQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hfiVd3OBtopIjjlxzVpJmPhqmGR52gATqqr1d/XNrlg=;
        b=tAhiWBjhuMVhtdcF74zDRTkUoi/Fk0Ygs0e7LENPkyUyLCzwIS2wB+z7+hoVCPNqSX
         t31I2mzIOnUJQervSEevZPvegoiYtMAEPh4k6NAc8lAVAV7cSc0xvDo6vrEkjviH83EZ
         31AQp81P+CPpddBcSTRb94XIvsmIKLPS5s/UhK0gwkmvs4jtmYDqdLV+//X+LzrQYHGw
         LgPOvW0BF8Y1d062g9etYWdXrAqlwESFme0JCr/1VHa7Q+vK47JXzjUqibYFf+OqdqYn
         uKDsqbE5TAp2SM5xJqN+I0p3CZyTLkEn1WS46EsDajU5i0SSLESmQ19Np3MnkQT5fRGg
         oKCA==
X-Gm-Message-State: APjAAAVLCf/RJru/c54uFN9yMzLWEeK2GloPbl++taLtSNYs40HGSrzp
        WJBtIRrZW7D0cncyNEO0PfCxlXPmXZTlEg==
X-Google-Smtp-Source: APXvYqyndm0SFS7NIDOWo2A6jusOydB8NGg+m0Q+giTV4xvYsZFjQHTE18o7T3ohhWm03WCALR5d3Q==
X-Received: by 2002:aa7:8082:: with SMTP id v2mr18145823pff.164.1552899494730;
        Mon, 18 Mar 2019 01:58:14 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id k8sm11147024pgq.37.2019.03.18.01.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 01:58:13 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 11/19] locking/lockdep: Remove unused argument in validate_chain()
Date:   Mon, 18 Mar 2019 16:57:25 +0800
Message-Id: <20190318085733.3143-12-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190318085733.3143-1-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Its lockdep_map argument is not used, remove it.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e8871f2..dcff644 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2131,8 +2131,7 @@ static void print_deadlock_scenario(struct held_lock *nxt,
  * Returns: 0 on deadlock detected, 1 on OK, 2 on recursive read
  */
 static int
-check_deadlock(struct task_struct *curr, struct held_lock *next,
-	       struct lockdep_map *next_instance, int read)
+check_deadlock(struct task_struct *curr, struct held_lock *next, int read)
 {
 	struct held_lock *prev;
 	struct held_lock *nest = NULL;
@@ -2695,8 +2694,9 @@ static inline int lookup_chain_cache_add(struct task_struct *curr,
 	return 1;
 }
 
-static int validate_chain(struct task_struct *curr, struct lockdep_map *lock,
-			  struct held_lock *hlock, int chain_head, u64 chain_key)
+static int validate_chain(struct task_struct *curr,
+			  struct held_lock *hlock,
+			  int chain_head, u64 chain_key)
 {
 	/*
 	 * Trylock needs to maintain the stack of held locks, but it
@@ -2722,7 +2722,7 @@ static int validate_chain(struct task_struct *curr, struct lockdep_map *lock,
 		 * any of these scenarios could lead to a deadlock. If
 		 * All validations
 		 */
-		int ret = check_deadlock(curr, hlock, lock, hlock->read);
+		int ret = check_deadlock(curr, hlock, hlock->read);
 
 		if (!ret)
 			return 0;
@@ -2753,7 +2753,7 @@ static int validate_chain(struct task_struct *curr, struct lockdep_map *lock,
 }
 #else
 static inline int validate_chain(struct task_struct *curr,
-				 struct lockdep_map *lock, struct held_lock *hlock,
+				 struct held_lock *hlock,
 				 int chain_head, u64 chain_key)
 {
 	return 1;
@@ -3730,7 +3730,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		WARN_ON_ONCE(!hlock_class(hlock)->key);
 	}
 
-	if (!validate_chain(curr, lock, hlock, chain_head, chain_key))
+	if (!validate_chain(curr, hlock, chain_head, chain_key))
 		return 0;
 
 	curr->curr_chain_key = chain_key;
-- 
1.8.3.1

