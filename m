Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A194EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC3A21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbfB1HLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:11:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37921 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbfB1HLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:11:04 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7AYl82939384
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:10:34 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S7AY8c2939381;
        Wed, 27 Feb 2019 23:10:34 -0800
Date:   Wed, 27 Feb 2019 23:10:34 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-2212684adff79e2704a2792ff46682afb9246fc8@git.kernel.org>
Cc:     paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, longman@redhat.com,
        akpm@linux-foundation.org, peterz@infradead.org,
        will.deacon@arm.com, bvanassche@acm.org, mingo@kernel.org,
        hpa@zytor.com, johannes@sipsolutions.net, tglx@linutronix.de
Reply-To: longman@redhat.com, akpm@linux-foundation.org,
          will.deacon@arm.com, bvanassche@acm.org, peterz@infradead.org,
          mingo@kernel.org, johannes@sipsolutions.net, hpa@zytor.com,
          tglx@linutronix.de, paulmck@linux.vnet.ibm.com,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
In-Reply-To: <20190214230058.196511-14-bvanassche@acm.org>
References: <20190214230058.196511-14-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Introduce
 lockdep_next_lockchain() and lock_chain_count()
Git-Commit-ID: 2212684adff79e2704a2792ff46682afb9246fc8
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

Commit-ID:  2212684adff79e2704a2792ff46682afb9246fc8
Gitweb:     https://git.kernel.org/tip/2212684adff79e2704a2792ff46682afb9246fc8
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 14 Feb 2019 15:00:48 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 28 Feb 2019 07:55:44 +0100

locking/lockdep: Introduce lockdep_next_lockchain() and lock_chain_count()

This patch does not change any functionality but makes the next patch in
this series easier to read.

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
Link: https://lkml.kernel.org/r/20190214230058.196511-14-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c           | 16 +++++++++++++++-
 kernel/locking/lockdep_internals.h |  3 ++-
 kernel/locking/lockdep_proc.c      | 12 ++++++------
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2c6d0b67e7b6..753a9b758266 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2096,7 +2096,7 @@ out_bug:
 	return 0;
 }
 
-unsigned long nr_lock_chains;
+static unsigned long nr_lock_chains;
 struct lock_chain lock_chains[MAX_LOCKDEP_CHAINS];
 int nr_chain_hlocks;
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
@@ -2230,6 +2230,20 @@ static int check_no_collision(struct task_struct *curr,
 	return 1;
 }
 
+/*
+ * Given an index that is >= -1, return the index of the next lock chain.
+ * Return -2 if there is no next lock chain.
+ */
+long lockdep_next_lockchain(long i)
+{
+	return i + 1 < nr_lock_chains ? i + 1 : -2;
+}
+
+unsigned long lock_chain_count(void)
+{
+	return nr_lock_chains;
+}
+
 /*
  * Adds a dependency chain into chain hashtable. And must be called with
  * graph_lock held.
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 2ebb9d0ea91c..d4c197425f68 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -100,7 +100,8 @@ struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i);
 
 extern unsigned long nr_lock_classes;
 extern unsigned long nr_list_entries;
-extern unsigned long nr_lock_chains;
+long lockdep_next_lockchain(long i);
+unsigned long lock_chain_count(void);
 extern int nr_chain_hlocks;
 extern unsigned long nr_stack_trace_entries;
 
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 3d31f9b0059e..9c49ec645d8b 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -104,18 +104,18 @@ static const struct seq_operations lockdep_ops = {
 #ifdef CONFIG_PROVE_LOCKING
 static void *lc_start(struct seq_file *m, loff_t *pos)
 {
+	if (*pos < 0)
+		return NULL;
+
 	if (*pos == 0)
 		return SEQ_START_TOKEN;
 
-	if (*pos - 1 < nr_lock_chains)
-		return lock_chains + (*pos - 1);
-
-	return NULL;
+	return lock_chains + (*pos - 1);
 }
 
 static void *lc_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	(*pos)++;
+	*pos = lockdep_next_lockchain(*pos - 1) + 1;
 	return lc_start(m, pos);
 }
 
@@ -268,7 +268,7 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 
 #ifdef CONFIG_PROVE_LOCKING
 	seq_printf(m, " dependency chains:             %11lu [max: %lu]\n",
-			nr_lock_chains, MAX_LOCKDEP_CHAINS);
+			lock_chain_count(), MAX_LOCKDEP_CHAINS);
 	seq_printf(m, " dependency chain hlocks:       %11d [max: %lu]\n",
 			nr_chain_hlocks, MAX_LOCKDEP_CHAIN_HLOCKS);
 #endif
