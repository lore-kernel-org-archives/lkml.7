Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BD0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053F7218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2vZ5Wum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfCUH6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:58:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45684 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbfCUH6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 03:58:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id v21so3761442pfm.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 00:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/LPAkczJl6Vb3ild5P9S4VSewCXyHBiBbqXn8Is6VP4=;
        b=G2vZ5WumG/tXCZD2WZVTqZqFrd5/kCp37/ngzFvqX/XERF8Vfarqm+VUhajrx94J2L
         P31wTdjqrSROV7lqkvQSeTMAIzAvKBX8Xo7SjOYFXWuzdX5o4zAqvIkl2Y8WOB0zUrvz
         +iUc5giPSLCw+HsHOBG1SSbZMoyT2YhMdDfojLZiAFrQoEdvHgP7hFhR20SpV0OPrDmS
         AdwB58KnRZQAwd/43HtYhuPSq9K9iADy3xh2FT8Uo8CGQOMWwL/nr8Lu45oA9xfHjW+E
         GpHU/w9BeCdApT1AJ3Xc5BkcniqpuHPmYxR9huZv/5KmcpFKPO2ld9jTdkv3m7u7nT3C
         IIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/LPAkczJl6Vb3ild5P9S4VSewCXyHBiBbqXn8Is6VP4=;
        b=cOOSo2BN4XG+OHIG29ycb578ZGd1FjNHIMtfUQnOAj9xKOIr5sEgY/h6glRNutKOKV
         72a00nJP47mDRIkm/mm8HGboD+PxdyuoMznc9zxRKDeNPO7UWRQ2/9LWJTtANUTYUNe/
         HOzNdwDNVLyclDlx8qJ19sIYFBBA/yI/LUJzswzLAt5mcf9Ox+lsbDKz6s78pNDMm9kE
         dWgHlL18x6sFfurVsNryQj7AjHpOAv4CpPEqBjfbB3+EkwYxDHzNeyKLeGZNlLnu0W3j
         YGFEPLS25edts9//nEVecnTEFTrPC/EfLAGq4QWjaJffOY1RRcJ3vbt+a9ZP5GK7XM79
         IfAg==
X-Gm-Message-State: APjAAAVOsti6oi8uvgfT7mp62n0ZTffOaLctgUcKMYP6amFaTrFs70VH
        qfnzp71Cojc+K/qgBdtO65Q=
X-Google-Smtp-Source: APXvYqzdJfPXKfnb7Q0acFjRBNn4ko0OKmZhPxsHNRNhr6GQAv/5vfwqfS9anBpCFlM2MqGfH9Zdew==
X-Received: by 2002:a65:4608:: with SMTP id v8mr2154250pgq.9.1553155083173;
        Thu, 21 Mar 2019 00:58:03 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id e184sm6467148pfc.143.2019.03.21.00.58.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 00:58:02 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, joe@perches.com,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 10/18] locking/lockdep: Remove unused argument in validate_chain() and check_deadlock()
Date:   Thu, 21 Mar 2019 15:57:17 +0800
Message-Id: <20190321075725.14054-11-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190321075725.14054-1-duyuyang@gmail.com>
References: <20190321075725.14054-1-duyuyang@gmail.com>
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
index f16d2f5..c7aec9f 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2134,8 +2134,7 @@ static inline void inc_chains(void)
  * Returns: 0 on deadlock detected, 1 on OK, 2 on recursive read
  */
 static int
-check_deadlock(struct task_struct *curr, struct held_lock *next,
-	       struct lockdep_map *next_instance, int read)
+check_deadlock(struct task_struct *curr, struct held_lock *next, int read)
 {
 	struct held_lock *prev;
 	struct held_lock *nest = NULL;
@@ -2698,8 +2697,9 @@ static inline int lookup_chain_cache_add(struct task_struct *curr,
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
@@ -2725,7 +2725,7 @@ static int validate_chain(struct task_struct *curr, struct lockdep_map *lock,
 		 * any of these scenarios could lead to a deadlock. If
 		 * All validations
 		 */
-		int ret = check_deadlock(curr, hlock, lock, hlock->read);
+		int ret = check_deadlock(curr, hlock, hlock->read);
 
 		if (!ret)
 			return 0;
@@ -2756,8 +2756,8 @@ static int validate_chain(struct task_struct *curr, struct lockdep_map *lock,
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
@@ -3733,7 +3733,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		WARN_ON_ONCE(!hlock_class(hlock)->key);
 	}
 
-	if (!validate_chain(curr, lock, hlock, chain_head, chain_key))
+	if (!validate_chain(curr, hlock, chain_head, chain_key))
 		return 0;
 
 	curr->curr_chain_key = chain_key;
-- 
1.8.3.1

