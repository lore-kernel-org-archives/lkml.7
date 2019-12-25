Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA9CC2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 10:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352552077B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 10:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfLYKju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 05:39:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40657 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfLYKjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 05:39:41 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ik44e-0008GV-TS; Wed, 25 Dec 2019 11:39:29 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8D7C11C2B1E;
        Wed, 25 Dec 2019 11:39:28 +0100 (CET)
Date:   Wed, 25 Dec 2019 10:39:28 -0000
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/lockdep: Fix buffer overrun problem in
 stack_trace[]
Cc:     Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191220135128.14876-1-longman@redhat.com>
References: <20191220135128.14876-1-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <157727036841.30329.5537146240257959465.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     d91f3057263ceb691ef527e71b41a56b17f6c869
Gitweb:        https://git.kernel.org/tip/d91f3057263ceb691ef527e71b41a56b17f6c869
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Fri, 20 Dec 2019 08:51:28 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 Dec 2019 10:42:32 +01:00

locking/lockdep: Fix buffer overrun problem in stack_trace[]

If the lockdep code is really running out of the stack_trace entries,
it is likely that buffer overrun can happen and the data immediately
after stack_trace[] will be corrupted.

If there is less than LOCK_TRACE_SIZE_IN_LONGS entries left before
the call to save_trace(), the max_entries computation will leave it
with a very large positive number because of its unsigned nature. The
subsequent call to stack_trace_save() will then corrupt the data after
stack_trace[]. Fix that by changing max_entries to a signed integer
and check for negative value before calling stack_trace_save().

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 12593b7467f9 ("locking/lockdep: Reduce space occupied by stack traces")
Link: https://lkml.kernel.org/r/20191220135128.14876-1-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 32282e7..32406ef 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -482,7 +482,7 @@ static struct lock_trace *save_trace(void)
 	struct lock_trace *trace, *t2;
 	struct hlist_head *hash_head;
 	u32 hash;
-	unsigned int max_entries;
+	int max_entries;
 
 	BUILD_BUG_ON_NOT_POWER_OF_2(STACK_TRACE_HASH_SIZE);
 	BUILD_BUG_ON(LOCK_TRACE_SIZE_IN_LONGS >= MAX_STACK_TRACE_ENTRIES);
@@ -490,10 +490,8 @@ static struct lock_trace *save_trace(void)
 	trace = (struct lock_trace *)(stack_trace + nr_stack_trace_entries);
 	max_entries = MAX_STACK_TRACE_ENTRIES - nr_stack_trace_entries -
 		LOCK_TRACE_SIZE_IN_LONGS;
-	trace->nr_entries = stack_trace_save(trace->entries, max_entries, 3);
 
-	if (nr_stack_trace_entries >= MAX_STACK_TRACE_ENTRIES -
-	    LOCK_TRACE_SIZE_IN_LONGS - 1) {
+	if (max_entries <= 0) {
 		if (!debug_locks_off_graph_unlock())
 			return NULL;
 
@@ -502,6 +500,7 @@ static struct lock_trace *save_trace(void)
 
 		return NULL;
 	}
+	trace->nr_entries = stack_trace_save(trace->entries, max_entries, 3);
 
 	hash = jhash(trace->entries, trace->nr_entries *
 		     sizeof(trace->entries[0]), 0);
