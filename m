Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F835C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF19420857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKX0+n1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfCRI6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:58:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46458 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbfCRI6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:58:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id a22so10888061pgg.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 01:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7J1PZEGPvTyxhKQufXDc4OOFjcFwzJJjt2oPZMN+8zw=;
        b=MKX0+n1cnXI/mvWtB6mvfNuZRobmSOhXqvnT2+3WHLf+b952KI0WqTRmmXcRhk+WWO
         m9b3/DUXLrZbxPx+dNUigJicgwSOLnmkmIBggmyrvEmCKy9doHcdfCxH8LnQw7fyXa4G
         fpqMOKsKiCEav5qpIk6SwNEtY7clF3aJtf3i3lBj8PKxCGwHH62zCK5Wu87q3OwvkHlH
         BQ0id/yvX24UBrE6PKaM0DM/cIjjF1ecYGhQk2+CE5v8vsEu7KS0vUVA9FWRiDrr0UQ+
         GYBR35LBUfM/9soRevWGxDcLinbT/fvYsp0KxGrrujidyi/xXiptlAEctLmE6onJgvWh
         n0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7J1PZEGPvTyxhKQufXDc4OOFjcFwzJJjt2oPZMN+8zw=;
        b=FEOdPvMF3BqwLwtb/8vL68now+Y0N54m1yHcMQG675BpuDx0WEJj5QV4nwIDur0soO
         oHRWopMqlQwOgHMtCgmfcKgvV/WkeskJ7yVb41O+FFkckZY9RBdWdRc3nRikI/AxaetG
         +GHIlp5vnQSnzQ+vCKaRW2repKBzgWGgor24QsJJCfjlFBkgI68TCjHV1d4SGsv8m3Nb
         FE8Yd8nAkLqN89J0ocuIxvo7ZZehb0aP7dPOHIAv24F+x+2iiXaVFiR9w1jJulNM6ROG
         dfFLNs2qbZ+qRPNjj03CuOJeRd6SCHjFtQd2ypfWinW6GmCIF+6TQV0B++2RbV8uXLb1
         i3fQ==
X-Gm-Message-State: APjAAAXPFbCf8fd8fIcneIL3+wUL+LKWOKWAthkvOT/BLEMgnu5yK4zu
        aO0FO3N/Ys8rtZDJgpLp32M=
X-Google-Smtp-Source: APXvYqyisEFgMTQ1OOrhLGn2Y8ky+OIw3gbULexnXTab4gWXIAj/cp1YADNQjYDUAGYgwRHBlBzD+w==
X-Received: by 2002:a63:c04e:: with SMTP id z14mr16394262pgi.20.1552899510939;
        Mon, 18 Mar 2019 01:58:30 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id k8sm11147024pgq.37.2019.03.18.01.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 01:58:30 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 17/19] locking/lockdep: Combine check_noncircular and check_redundant
Date:   Mon, 18 Mar 2019 16:57:31 +0800
Message-Id: <20190318085733.3143-18-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190318085733.3143-1-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two functions are essentially duplicates, combine them.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3dbb4d0..90d58cc 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1677,29 +1677,18 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 }
 
 /*
- * Prove that the dependency graph starting at <entry> can not
- * lead to <target>. Print an error and return 0 if it does.
+ * Prove that the dependency graph starting at <root> can not
+ * lead to <target>. If existent, there is a circle when adding
+ * a <target> -> <root> dependency.
+ *
+ * Print an error and return 0 if it does exist.
  */
 static noinline int
-check_noncircular(struct lock_list *root, struct lock_class *target,
+check_nonexistent(struct lock_list *root, struct lock_class *target,
 		  struct lock_list **target_entry)
 {
 	int result;
 
-	debug_atomic_inc(nr_cyclic_checks);
-
-	result = __bfs_forwards(root, target, class_equal, target_entry);
-
-	return result;
-}
-
-static noinline int
-check_redundant(struct lock_list *root, struct lock_class *target,
-		struct lock_list **target_entry)
-{
-	int result;
-
-	debug_atomic_inc(nr_redundant_checks);
 
 	result = __bfs_forwards(root, target, class_equal, target_entry);
 
@@ -2235,7 +2224,8 @@ static void print_deadlock_scenario(struct held_lock *nxt,
 	 */
 	this.class = hlock_class(next);
 	this.parent = NULL;
-	ret = check_noncircular(&this, hlock_class(prev), &target_entry);
+	debug_atomic_inc(nr_cyclic_checks);
+	ret = check_nonexistent(&this, hlock_class(prev), &target_entry);
 	if (unlikely(!ret)) {
 		if (!trace->entries) {
 			/*
@@ -2287,7 +2277,8 @@ static void print_deadlock_scenario(struct held_lock *nxt,
 	 */
 	this.class = hlock_class(prev);
 	this.parent = NULL;
-	ret = check_redundant(&this, hlock_class(next), &target_entry);
+	debug_atomic_inc(nr_redundant_checks);
+	ret = check_nonexistent(&this, hlock_class(next), &target_entry);
 	if (!ret) {
 		debug_atomic_inc(nr_redundant);
 		return 2;
-- 
1.8.3.1

