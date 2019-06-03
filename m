Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73576C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C8F2800A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qbNP7mx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbfFCNJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:09:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39145 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbfFCNJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:09:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53D9HSo605082
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:09:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53D9HSo605082
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559567358;
        bh=dJ+qfyn8VxxHFwwJtefaqDx8ffionAHA+SuDYprmkt8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=qbNP7mx5JR2gBIFzLp1NP7vABJOaHtRWeesYiltjRp6AH3LkdvSXEMZLEoekk4j7q
         Z5hOGzUHNwcOdH36JPnn9cUZGEG8HQDzBrQB7WRhFnXsCu7dQI9Zr0rcitUabeKNzv
         Tux1z4a0a0w0OIHialwCQaaSe20/DrvkO/Hmcr1uqD/BD5arXRwGlPgpNKu/BjXKXl
         5MsfSVXv7WfAtOEH3o/NAn4+AA6qcrTHRCmcYyuLHasuRuuuVJkIkHnxJGk0+Zx7vE
         jL/XO8LXGhkVhzFm2sEv/H2fVDT/CfiJJaVHrbC80jeHTZ9hde4OB4osHS/VPG6aiw
         EoQXpU8YzK8vQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53D9HcZ605079;
        Mon, 3 Jun 2019 06:09:17 -0700
Date:   Mon, 3 Jun 2019 06:09:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yuyang Du <tipbot@zytor.com>
Message-ID: <tip-834494b28024b39d45aea6bcc642b0fe94fe2503@git.kernel.org>
Cc:     peterz@infradead.org, torvalds@linux-foundation.org,
        mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        duyuyang@gmail.com, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, duyuyang@gmail.com,
          peterz@infradead.org, tglx@linutronix.de,
          torvalds@linux-foundation.org, mingo@kernel.org
In-Reply-To: <20190506081939.74287-6-duyuyang@gmail.com>
References: <20190506081939.74287-6-duyuyang@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Print the right depth for chain
 key collision
Git-Commit-ID: 834494b28024b39d45aea6bcc642b0fe94fe2503
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

Commit-ID:  834494b28024b39d45aea6bcc642b0fe94fe2503
Gitweb:     https://git.kernel.org/tip/834494b28024b39d45aea6bcc642b0fe94fe2503
Author:     Yuyang Du <duyuyang@gmail.com>
AuthorDate: Mon, 6 May 2019 16:19:21 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:55:36 +0200

locking/lockdep: Print the right depth for chain key collision

Since chains are separated by IRQ context, so when printing a chain the
depth should be consistent with it.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bvanassche@acm.org
Cc: frederic@kernel.org
Cc: ming.lei@redhat.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190506081939.74287-6-duyuyang@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3c477018e184..bc1efc12a8c5 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2519,10 +2519,11 @@ print_chain_keys_held_locks(struct task_struct *curr, struct held_lock *hlock_ne
 	struct held_lock *hlock;
 	u64 chain_key = 0;
 	int depth = curr->lockdep_depth;
-	int i;
+	int i = get_first_held_lock(curr, hlock_next);
 
-	printk("depth: %u\n", depth + 1);
-	for (i = get_first_held_lock(curr, hlock_next); i < depth; i++) {
+	printk("depth: %u (irq_context %u)\n", depth - i + 1,
+		hlock_next->irq_context);
+	for (; i < depth; i++) {
 		hlock = curr->held_locks + i;
 		chain_key = print_chain_key_iteration(hlock->class_idx, chain_key);
 
