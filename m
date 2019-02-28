Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EB2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CA2218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731301AbfB1HDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:03:24 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42081 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731129AbfB1HDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:03:23 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S72f3k2936098
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:02:41 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S72eLb2936090;
        Wed, 27 Feb 2019 23:02:40 -0800
Date:   Wed, 27 Feb 2019 23:02:40 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-09d75ecb122d8b600d76e3b8d53a10ffbe3bcec2@git.kernel.org>
Cc:     bvanassche@acm.org, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, longman@redhat.com, paulmck@linux.vnet.ibm.com,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        johannes@sipsolutions.net, will.deacon@arm.com
Reply-To: paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org,
          will.deacon@arm.com, johannes@sipsolutions.net,
          longman@redhat.com, hpa@zytor.com, mingo@kernel.org,
          akpm@linux-foundation.org, peterz@infradead.org,
          bvanassche@acm.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190214230058.196511-2-bvanassche@acm.org>
References: <20190214230058.196511-2-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Fix two 32-bit compiler
 warnings
Git-Commit-ID: 09d75ecb122d8b600d76e3b8d53a10ffbe3bcec2
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

Commit-ID:  09d75ecb122d8b600d76e3b8d53a10ffbe3bcec2
Gitweb:     https://git.kernel.org/tip/09d75ecb122d8b600d76e3b8d53a10ffbe3bcec2
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 14 Feb 2019 15:00:36 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 28 Feb 2019 07:55:38 +0100

locking/lockdep: Fix two 32-bit compiler warnings

Use %zu to format size_t instead of %lu to avoid that the compiler
complains about a mismatch between format specifier and argument on
32-bit systems.

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
Link: https://lkml.kernel.org/r/20190214230058.196511-2-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 7f7db23fc002..5c5283bf499c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4266,7 +4266,7 @@ void __init lockdep_init(void)
 	printk("... MAX_LOCKDEP_CHAINS:      %lu\n", MAX_LOCKDEP_CHAINS);
 	printk("... CHAINHASH_SIZE:          %lu\n", CHAINHASH_SIZE);
 
-	printk(" memory used by lock dependency info: %lu kB\n",
+	printk(" memory used by lock dependency info: %zu kB\n",
 		(sizeof(struct lock_class) * MAX_LOCKDEP_KEYS +
 		sizeof(struct list_head) * CLASSHASH_SIZE +
 		sizeof(struct lock_list) * MAX_LOCKDEP_ENTRIES +
@@ -4278,7 +4278,7 @@ void __init lockdep_init(void)
 		) / 1024
 		);
 
-	printk(" per task-struct memory footprint: %lu bytes\n",
+	printk(" per task-struct memory footprint: %zu bytes\n",
 		sizeof(struct held_lock) * MAX_LOCK_DEPTH);
 }
 
