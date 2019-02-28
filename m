Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22D6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886D8218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbfB1HGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:06:03 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44593 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731129AbfB1HGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:06:02 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S75JD02938292
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:05:19 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S75IUX2938289;
        Wed, 27 Feb 2019 23:05:18 -0800
Date:   Wed, 27 Feb 2019 23:05:18 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-09329d1c2024522308ca4de977fc6bba753bab1a@git.kernel.org>
Cc:     will.deacon@arm.com, peterz@infradead.org,
        johannes@sipsolutions.net, paulmck@linux.vnet.ibm.com,
        tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        longman@redhat.com, hpa@zytor.com, bvanassche@acm.org
Reply-To: paulmck@linux.vnet.ibm.com, mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
          longman@redhat.com, torvalds@linux-foundation.org, hpa@zytor.com,
          will.deacon@arm.com, peterz@infradead.org,
          johannes@sipsolutions.net, bvanassche@acm.org
In-Reply-To: <20190214230058.196511-6-bvanassche@acm.org>
References: <20190214230058.196511-6-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Reorder struct lock_class
 members
Git-Commit-ID: 09329d1c2024522308ca4de977fc6bba753bab1a
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

Commit-ID:  09329d1c2024522308ca4de977fc6bba753bab1a
Gitweb:     https://git.kernel.org/tip/09329d1c2024522308ca4de977fc6bba753bab1a
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 14 Feb 2019 15:00:40 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 28 Feb 2019 07:55:40 +0100

locking/lockdep: Reorder struct lock_class members

This patch does not change any functionality but makes the patch that
frees lock classes that are no longer in use easier to read.

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
Link: https://lkml.kernel.org/r/20190214230058.196511-6-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/lockdep.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index c5335df2372f..0c38bade84b7 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -76,6 +76,13 @@ struct lock_class {
 	 */
 	struct list_head		lock_entry;
 
+	/*
+	 * These fields represent a directed graph of lock dependencies,
+	 * to every node we attach a list of "forward" and a list of
+	 * "backward" graph nodes.
+	 */
+	struct list_head		locks_after, locks_before;
+
 	struct lockdep_subclass_key	*key;
 	unsigned int			subclass;
 	unsigned int			dep_gen_id;
@@ -86,13 +93,6 @@ struct lock_class {
 	unsigned long			usage_mask;
 	struct stack_trace		usage_traces[XXX_LOCK_USAGE_STATES];
 
-	/*
-	 * These fields represent a directed graph of lock dependencies,
-	 * to every node we attach a list of "forward" and a list of
-	 * "backward" graph nodes.
-	 */
-	struct list_head		locks_after, locks_before;
-
 	/*
 	 * Generation counter, when doing certain classes of graph walking,
 	 * to ensure that we check one node only once:
