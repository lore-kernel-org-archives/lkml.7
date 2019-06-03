Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177D9C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEA625C0B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iEq4FLB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfFCNVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:21:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41703 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfFCNVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:21:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DKwrI606800
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:20:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DKwrI606800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559568058;
        bh=j+X4HwT3zRPvMXzZ/Y4z3RR1/ToKXk8zq47jxNaY5D8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=iEq4FLB/4F2L4isKSs7ZDpgFw7Y7JyA/hUpmX8GWH4vnxa/fmmE1yaG66SRNFgrvZ
         7vFOnQQd9E0Da9wuTWwcZH4qXnqAgbuwrxj/PXrho9HVkNEY5f590QlDk/1TxfOdL8
         KMXUvIpzoZ8kgHVi7GALbOcegYUifHvLHVyMSof0UXvGfZ36XmogeU9RcUqu0XbeUK
         s73BEiBjK7FXxO8BjGLfbLgf4PalwxDyDgzZIXSzJebTcfF4nfBtXLQ+ujRa2Gm7wi
         2KybB0lev2A+y5vsQebE70VsKRs4Mi7AdpGtK0o7rFndJJg1yAqfaTBBq4ZquSq00s
         u3MrEBgeMzK/A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DKwTa606797;
        Mon, 3 Jun 2019 06:20:58 -0700
Date:   Mon, 3 Jun 2019 06:20:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yuyang Du <tipbot@zytor.com>
Message-ID: <tip-091806515124b20f8cff7927b4b7ff399483b109@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, duyuyang@gmail.com,
        torvalds@linux-foundation.org, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, duyuyang@gmail.com,
          peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
          torvalds@linux-foundation.org, hpa@zytor.com
In-Reply-To: <20190506081939.74287-22-duyuyang@gmail.com>
References: <20190506081939.74287-22-duyuyang@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Consolidate lock usage bit
 initialization
Git-Commit-ID: 091806515124b20f8cff7927b4b7ff399483b109
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  091806515124b20f8cff7927b4b7ff399483b109
Gitweb:     https://git.kernel.org/tip/091806515124b20f8cff7927b4b7ff399483b109
Author:     Yuyang Du <duyuyang@gmail.com>
AuthorDate: Mon, 6 May 2019 16:19:37 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:55:51 +0200

locking/lockdep: Consolidate lock usage bit initialization

Lock usage bit initialization is consolidated into one function
mark_usage(). Trivial readability improvement. No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bvanassche@acm.org
Cc: frederic@kernel.org
Cc: ming.lei@redhat.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190506081939.74287-22-duyuyang@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 63b82921698d..1123e7e6c78d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3460,8 +3460,12 @@ void trace_softirqs_off(unsigned long ip)
 		debug_atomic_inc(redundant_softirqs_off);
 }
 
-static int mark_irqflags(struct task_struct *curr, struct held_lock *hlock)
+static int
+mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
 {
+	if (!check)
+		goto lock_used;
+
 	/*
 	 * If non-trylock use in a hardirq or softirq context, then
 	 * mark the lock as used in these contexts:
@@ -3505,6 +3509,11 @@ static int mark_irqflags(struct task_struct *curr, struct held_lock *hlock)
 		}
 	}
 
+lock_used:
+	/* mark it as used: */
+	if (!mark_lock(curr, hlock, LOCK_USED))
+		return 0;
+
 	return 1;
 }
 
@@ -3546,8 +3555,8 @@ int mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 	return 1;
 }
 
-static inline int mark_irqflags(struct task_struct *curr,
-		struct held_lock *hlock)
+static inline int
+mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
 {
 	return 1;
 }
@@ -3833,11 +3842,8 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 #endif
 	hlock->pin_count = pin_count;
 
-	if (check && !mark_irqflags(curr, hlock))
-		return 0;
-
-	/* mark it as used: */
-	if (!mark_lock(curr, hlock, LOCK_USED))
+	/* Initialize the lock usage bit */
+	if (!mark_usage(curr, hlock, check))
 		return 0;
 
 	/*
