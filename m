Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094D2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C875C21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbfB1HED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:04:03 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55015 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731129AbfB1HEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:04:02 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S73LWq2936380
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:03:21 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S73Kik2936377;
        Wed, 27 Feb 2019 23:03:20 -0800
Date:   Wed, 27 Feb 2019 23:03:20 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-7ff8517e1034f26dde03d6df4026f085480408f0@git.kernel.org>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        bvanassche@acm.org, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, will.deacon@arm.com,
        peterz@infradead.org, longman@redhat.com,
        paulmck@linux.vnet.ibm.com, hpa@zytor.com,
        johannes@sipsolutions.net
Reply-To: bvanassche@acm.org, akpm@linux-foundation.org,
          will.deacon@arm.com, linux-kernel@vger.kernel.org,
          johannes@sipsolutions.net, hpa@zytor.com,
          paulmck@linux.vnet.ibm.com, longman@redhat.com, mingo@kernel.org,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          peterz@infradead.org
In-Reply-To: <20190214230058.196511-3-bvanassche@acm.org>
References: <20190214230058.196511-3-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Fix reported required memory
 size (1/2)
Git-Commit-ID: 7ff8517e1034f26dde03d6df4026f085480408f0
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

Commit-ID:  7ff8517e1034f26dde03d6df4026f085480408f0
Gitweb:     https://git.kernel.org/tip/7ff8517e1034f26dde03d6df4026f085480408f0
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 14 Feb 2019 15:00:37 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 28 Feb 2019 07:55:39 +0100

locking/lockdep: Fix reported required memory size (1/2)

Change the sizeof(array element time) * (array size) expressions into
sizeof(array). This fixes the size computations of the classhash_table[]
and chainhash_table[] arrays.

The reason is that commit:

  a63f38cc4ccf ("locking/lockdep: Convert hash tables to hlists")

changed the type of the elements of that array from 'struct list_head' into
'struct hlist_head'.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: johannes.berg@intel.com
Cc: tj@kernel.org
Link: https://lkml.kernel.org/r/20190214230058.196511-3-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 5c5283bf499c..57a523f0273c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4267,19 +4267,19 @@ void __init lockdep_init(void)
 	printk("... CHAINHASH_SIZE:          %lu\n", CHAINHASH_SIZE);
 
 	printk(" memory used by lock dependency info: %zu kB\n",
-		(sizeof(struct lock_class) * MAX_LOCKDEP_KEYS +
-		sizeof(struct list_head) * CLASSHASH_SIZE +
-		sizeof(struct lock_list) * MAX_LOCKDEP_ENTRIES +
-		sizeof(struct lock_chain) * MAX_LOCKDEP_CHAINS +
-		sizeof(struct list_head) * CHAINHASH_SIZE
+	       (sizeof(lock_classes) +
+		sizeof(classhash_table) +
+		sizeof(list_entries) +
+		sizeof(lock_chains) +
+		sizeof(chainhash_table)
 #ifdef CONFIG_PROVE_LOCKING
-		+ sizeof(struct circular_queue)
+		+ sizeof(lock_cq)
 #endif
 		) / 1024
 		);
 
 	printk(" per task-struct memory footprint: %zu bytes\n",
-		sizeof(struct held_lock) * MAX_LOCK_DEPTH);
+	       sizeof(((struct task_struct *)NULL)->held_locks));
 }
 
 static void
