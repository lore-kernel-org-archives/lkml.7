Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A4DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F6E20857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlQ0phEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfCRI6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:58:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46470 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfCRI6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:58:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id a22so10888184pgg.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 01:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6losf3tQR5/07kLvPHhQ7EAuCmSM+1UcqHl2cRw0n6k=;
        b=ZlQ0phEF3nFFFNpLiBbLOOJjPR837QVb5AkF88VGIJSi79wAEM06a34TLCSYOPjymn
         3mW7WuByjJ9AkDx5yTE8b3/4NiF7hZsCL30U8a2fRbJS1pXV5WOShG0/zTusG/GFiLp1
         nr6oHgJzuH+8meK0u4R9cz7VEND4LziDakMSTdmxwc5Qj6SvxAxHa2mZ4w4oTSojBzyU
         t1zTIrhIy7WYIS740UXBWeFIib8RrV6LQy5Ho4DGHwOGaJr8U3sfH0fSjxvsugSpfKkW
         VFpzNI07vL6r0R9cNj9efGifp85Xh8hOaS6UYSz1N4DwhMLYBlSuwmBMN93Wg4MpJ1hf
         Eg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6losf3tQR5/07kLvPHhQ7EAuCmSM+1UcqHl2cRw0n6k=;
        b=QY7QPqZeXpLc2WA1cKCCYKDEgcvUU3H20/tH5n2XuoJAcdrzTEKK3tas7JrOA66Zo8
         qP95j989AJTEOLdXj4tCNby/YdZKml3Yp4+tpB7tiYrm6/qzd6OYUCjpafJhUF3XWTlA
         5ZzDiYb6/jfPcY579SfLxCQy1CkiXPanDmL2uO/GtmMSxp08+o+JD9CiyUVk6ZOgMeID
         n+Djwg+3is74EWknBWpfez6/qbUW6dpL5N7VmG26dR/A5voReNd7z7jZpC0ULwBQKGKW
         pq3yFX7x8RcIs3Jqvw0RKfMAwuna1tppwhEDATOuDQba5ELgaCbcCotrJhk1uBISwLmq
         6FKw==
X-Gm-Message-State: APjAAAVML4I01JIajhGL5Egbt2RofRDtiRR0e/4j7hlcJMHSpRZbEkE+
        rDVVCiLixGWUd5vAaWU+QxA=
X-Google-Smtp-Source: APXvYqzCIzufJ9Jk5+Kf6cdKDaO7zqFLzlV3wW0MAlPvTALW/9NmAUKSi36GrspoVnH1ThlkR0wqPw==
X-Received: by 2002:aa7:9099:: with SMTP id i25mr18225923pfa.102.1552899516429;
        Mon, 18 Mar 2019 01:58:36 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id k8sm11147024pgq.37.2019.03.18.01.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 01:58:35 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 19/19] locking/lockdep: Change if to else-if when checking bfs errors
Date:   Mon, 18 Mar 2019 16:57:33 +0800
Message-Id: <20190318085733.3143-20-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190318085733.3143-1-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After BFS searching, we check whether there is an error. These checks are
exclusive, so we can use "else if" instead of "if", which results in a bit
optimized code.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 1d38bf6..3efc00e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1950,21 +1950,21 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 
 	this.class = hlock_class(prev);
 	ret = find_usage_backwards(&this, bit_backwards, &target_entry);
-	if (ret < 0) {
+	if (unlikely(ret < 0)) {
 		print_bfs_bug(ret);
 		return 0;
 	}
-	if (ret == 1)
+	else if (ret == 1)
 		return ret;
 
 	that.parent = NULL;
 	that.class = hlock_class(next);
 	ret = find_usage_forwards(&that, bit_forwards, &target_entry1);
-	if (ret < 0) {
+	if (unlikely(ret < 0)) {
 		print_bfs_bug(ret);
 		return 0;
 	}
-	if (ret == 1)
+	else if (ret == 1)
 		return ret;
 
 	print_bad_irq_dependency(curr, &this, &that,
@@ -2282,7 +2282,7 @@ static void print_deadlock_scenario(struct held_lock *nxt,
 		debug_atomic_inc(nr_redundant);
 		return 2;
 	}
-	if (ret < 0) {
+	else if (unlikely(ret < 0)) {
 		print_bfs_bug(ret);
 		return 0;
 	}
@@ -2967,11 +2967,11 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	root.parent = NULL;
 	root.class = hlock_class(this);
 	ret = find_usage_forwards(&root, bit, &target_entry);
-	if (ret < 0) {
+	if (unlikely(ret < 0)) {
 		print_bfs_bug(ret);
 		return 0;
 	}
-	if (ret == 1)
+	else if (ret == 1)
 		return ret;
 
 	print_irq_inversion_bug(curr, &root, target_entry,
@@ -2994,11 +2994,11 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	root.parent = NULL;
 	root.class = hlock_class(this);
 	ret = find_usage_backwards(&root, bit, &target_entry);
-	if (ret < 0) {
+	if (unlikely(ret < 0)) {
 		print_bfs_bug(ret);
 		return 0;
 	}
-	if (ret == 1)
+	else if (ret == 1)
 		return ret;
 
 	print_irq_inversion_bug(curr, &root, target_entry,
-- 
1.8.3.1

