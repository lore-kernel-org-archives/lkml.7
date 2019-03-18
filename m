Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647B7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347EF20857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1NH941D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfCRI6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:58:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33722 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfCRI62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:58:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id i19so10826498pfd.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 01:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ozLE+gocjez2Yf2mxQ/KxI7wEMlRsw33T2k8E6RJBY0=;
        b=d1NH941DU6ltEQ5tuVa7HhvQrHz0QnDoaw9qAdnkfhUAiHKHy1RctpvVq6HE17sIDU
         NaSM4q/AuZA/wSntggipeE2VSCSC6HE/XKdsxfNNV2KwIh7P78ElreHGIMtPvN7jN6ua
         wGd0zGCE/uMHloR/OoAeNs4yLUvIK2JfYjwvi5ePYi7mFE417Z8Rd+rPiEjeYjmcrU/G
         s0rACwREgka4O6Lv6YoYBY5shZNL1qpUZD6xaXiUpXNMix0dcYGbTQDCe4rmYh+FejE0
         ka1vYyhEdkU86bs1XGBVX1FKwG1ktlkrLFU0K1mYCnUbEvR6FL6t/AKKcKblc77PBPto
         gTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ozLE+gocjez2Yf2mxQ/KxI7wEMlRsw33T2k8E6RJBY0=;
        b=BGxtDN7dlN1j+U/EUSvQPaIt0DmPs9EcG5FWnHzSlpGy+52H/K/0Evo2ZXsKapYOfQ
         daA7jhqFaOt9W20r9HLxgcigj7f6LZCuT4vs5i6Tj3UaCGNyI/b4rqmWMu3d+uREs6wP
         ZYAlmWTvwAOdlB7IHnUqRardnv08aI3fsw+y2V4BfrWkVzYD4MeKEnEgsck8SkhabFkm
         rW9F8d4HrtiCVv8z8StnEvfADa31VsdXzjFETTHurNUB3fT4S50FyM1ZFuobEZzkRpez
         TfgVnQa3m4Hc/QIbjyKQcwpYOjCGu3vc8oxivl5ZOZ8sjEdOryXPWmvHBjd4YsVGb6Pt
         4/LQ==
X-Gm-Message-State: APjAAAWyb+48cnSH9pUhab/j1Mlczj7UwGLL2LS1hKNFpXJFUd2Oml0V
        Xv+IohMtxEOSzEAYlyKGrCU=
X-Google-Smtp-Source: APXvYqyPpnE59/OQLQLvvVrkwSrM9aAwdE7vfA7PI771EzxFfF3AUMdLJAaEj7kxLSRRF6lHJgKaUQ==
X-Received: by 2002:a62:55c7:: with SMTP id j190mr14064897pfb.226.1552899508262;
        Mon, 18 Mar 2019 01:58:28 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id k8sm11147024pgq.37.2019.03.18.01.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 01:58:27 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 16/19] locking/lockdep: Use function pointer to avoid constant checks
Date:   Mon, 18 Mar 2019 16:57:30 +0800
Message-Id: <20190318085733.3143-17-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190318085733.3143-1-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In search of a dependency in the lock graph, there is contant check for
forward or backward search. Use a function pointer to avoid that check.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index ee8fe64..3dbb4d0 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1374,11 +1374,21 @@ static inline int get_lock_depth(struct lock_list *child)
 	return depth;
 }
 
+static inline struct list_head *get_forward_dep(struct lock_list * lock)
+{
+	return &lock->class->locks_after;
+}
+
+static inline struct list_head *get_backward_dep(struct lock_list * lock)
+{
+	return &lock->class->locks_before;
+}
+
 static int __bfs(struct lock_list *source_entry,
 		 void *data,
 		 int (*match)(struct lock_list *entry, void *data),
 		 struct lock_list **target_entry,
-		 int forward)
+		 struct list_head *(*get_dep)(struct lock_list * lock))
 {
 	struct lock_list *entry;
 	struct lock_list *lock;
@@ -1392,11 +1402,7 @@ static int __bfs(struct lock_list *source_entry,
 		goto exit;
 	}
 
-	if (forward)
-		head = &source_entry->class->locks_after;
-	else
-		head = &source_entry->class->locks_before;
-
+	head = get_dep(source_entry);
 	if (list_empty(head))
 		goto exit;
 
@@ -1410,10 +1416,7 @@ static int __bfs(struct lock_list *source_entry,
 			goto exit;
 		}
 
-		if (forward)
-			head = &lock->class->locks_after;
-		else
-			head = &lock->class->locks_before;
+		head = get_dep(lock);
 
 		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
 
@@ -1445,7 +1448,7 @@ static inline int __bfs_forwards(struct lock_list *src_entry, void *data,
 				 int (*match)(struct lock_list *entry, void *data),
 				 struct lock_list **target_entry)
 {
-	return __bfs(src_entry, data, match, target_entry, 1);
+	return __bfs(src_entry, data, match, target_entry, get_forward_dep);
 
 }
 
@@ -1453,7 +1456,7 @@ static inline int __bfs_backwards(struct lock_list *src_entry, void *data,
 				  int (*match)(struct lock_list *entry, void *data),
 				  struct lock_list **target_entry)
 {
-	return __bfs(src_entry, data, match, target_entry, 0);
+	return __bfs(src_entry, data, match, target_entry, get_backward_dep);
 
 }
 
-- 
1.8.3.1

