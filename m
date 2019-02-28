Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1551FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AA321850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbfB1HG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:06:28 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41481 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731129AbfB1HG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:06:28 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S75xOu2938362
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:05:59 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S75xok2938357;
        Wed, 27 Feb 2019 23:05:59 -0800
Date:   Wed, 27 Feb 2019 23:05:59 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-86cffb80a525f7b8f969c8c79669d383e02f17d1@git.kernel.org>
Cc:     mingo@kernel.org, johannes@sipsolutions.net, peterz@infradead.org,
        torvalds@linux-foundation.org, longman@redhat.com,
        tglx@linutronix.de, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        hpa@zytor.com, paulmck@linux.vnet.ibm.com, will.deacon@arm.com
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org,
          johannes@sipsolutions.net, mingo@kernel.org, longman@redhat.com,
          akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
          bvanassche@acm.org, tglx@linutronix.de, will.deacon@arm.com,
          paulmck@linux.vnet.ibm.com, hpa@zytor.com
In-Reply-To: <20190214230058.196511-7-bvanassche@acm.org>
References: <20190214230058.196511-7-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Make zap_class() remove all
 matching lock order entries
Git-Commit-ID: 86cffb80a525f7b8f969c8c79669d383e02f17d1
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

Commit-ID:  86cffb80a525f7b8f969c8c79669d383e02f17d1
Gitweb:     https://git.kernel.org/tip/86cffb80a525f7b8f969c8c79669d383e02f17d1
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 14 Feb 2019 15:00:41 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 28 Feb 2019 07:55:40 +0100

locking/lockdep: Make zap_class() remove all matching lock order entries

Make sure that all lock order entries that refer to a class are removed
from the list_entries[] array when a kernel module is unloaded.

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
Link: https://lkml.kernel.org/r/20190214230058.196511-7-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/lockdep.h  |  1 +
 kernel/locking/lockdep.c | 19 +++++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 0c38bade84b7..b5e6bfe0ae4a 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -178,6 +178,7 @@ static inline void lockdep_copy_map(struct lockdep_map *to,
 struct lock_list {
 	struct list_head		entry;
 	struct lock_class		*class;
+	struct lock_class		*links_to;
 	struct stack_trace		trace;
 	int				distance;
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 21d84510e28f..28fbeb2a10cc 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -859,7 +859,8 @@ static struct lock_list *alloc_list_entry(void)
 /*
  * Add a new dependency to the head of the list:
  */
-static int add_lock_to_list(struct lock_class *this, struct list_head *head,
+static int add_lock_to_list(struct lock_class *this,
+			    struct lock_class *links_to, struct list_head *head,
 			    unsigned long ip, int distance,
 			    struct stack_trace *trace)
 {
@@ -873,6 +874,7 @@ static int add_lock_to_list(struct lock_class *this, struct list_head *head,
 		return 0;
 
 	entry->class = this;
+	entry->links_to = links_to;
 	entry->distance = distance;
 	entry->trace = *trace;
 	/*
@@ -1907,14 +1909,14 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	 * Ok, all validations passed, add the new lock
 	 * to the previous lock's dependency list:
 	 */
-	ret = add_lock_to_list(hlock_class(next),
+	ret = add_lock_to_list(hlock_class(next), hlock_class(prev),
 			       &hlock_class(prev)->locks_after,
 			       next->acquire_ip, distance, trace);
 
 	if (!ret)
 		return 0;
 
-	ret = add_lock_to_list(hlock_class(prev),
+	ret = add_lock_to_list(hlock_class(prev), hlock_class(next),
 			       &hlock_class(next)->locks_before,
 			       next->acquire_ip, distance, trace);
 	if (!ret)
@@ -4107,15 +4109,20 @@ void lockdep_reset(void)
  */
 static void zap_class(struct lock_class *class)
 {
+	struct lock_list *entry;
 	int i;
 
 	/*
 	 * Remove all dependencies this lock is
 	 * involved in:
 	 */
-	for (i = 0; i < nr_list_entries; i++) {
-		if (list_entries[i].class == class)
-			list_del_rcu(&list_entries[i].entry);
+	for (i = 0, entry = list_entries; i < nr_list_entries; i++, entry++) {
+		if (entry->class != class && entry->links_to != class)
+			continue;
+		list_del_rcu(&entry->entry);
+		/* Clear .class and .links_to to avoid double removal. */
+		WRITE_ONCE(entry->class, NULL);
+		WRITE_ONCE(entry->links_to, NULL);
 	}
 	/*
 	 * Unhash the class and remove it from the all_lock_classes list:
