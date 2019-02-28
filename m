Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0D3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE95321850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbfB1HE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:04:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54873 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731129AbfB1HE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:04:29 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7400r2936442
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:04:00 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S73xU02936438;
        Wed, 27 Feb 2019 23:03:59 -0800
Date:   Wed, 27 Feb 2019 23:03:59 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-15ea86b58c71d05e0921bebcf707aa30e43e9e25@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        johannes@sipsolutions.net, tglx@linutronix.de,
        akpm@linux-foundation.org, paulmck@linux.vnet.ibm.com,
        bvanassche@acm.org, hpa@zytor.com, peterz@infradead.org,
        will.deacon@arm.com, longman@redhat.com,
        torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, hpa@zytor.com,
          peterz@infradead.org, longman@redhat.com, will.deacon@arm.com,
          akpm@linux-foundation.org, bvanassche@acm.org,
          paulmck@linux.vnet.ibm.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, johannes@sipsolutions.net,
          tglx@linutronix.de
In-Reply-To: <20190214230058.196511-4-bvanassche@acm.org>
References: <20190214230058.196511-4-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Fix reported required memory
 size (2/2)
Git-Commit-ID: 15ea86b58c71d05e0921bebcf707aa30e43e9e25
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

Commit-ID:  15ea86b58c71d05e0921bebcf707aa30e43e9e25
Gitweb:     https://git.kernel.org/tip/15ea86b58c71d05e0921bebcf707aa30e43e9e25
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 14 Feb 2019 15:00:38 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 28 Feb 2019 07:55:39 +0100

locking/lockdep: Fix reported required memory size (2/2)

Lock chains are only tracked with CONFIG_PROVE_LOCKING=y. Do not report
the memory required for the lock chain array if CONFIG_PROVE_LOCKING=n.
See also commit:

  ca58abcb4a6d ("lockdep: sanitise CONFIG_PROVE_LOCKING")

Include the size of the chain_hlocks[] array.

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
Link: https://lkml.kernel.org/r/20190214230058.196511-4-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 57a523f0273c..ec6f6aff4d8d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4270,10 +4270,11 @@ void __init lockdep_init(void)
 	       (sizeof(lock_classes) +
 		sizeof(classhash_table) +
 		sizeof(list_entries) +
-		sizeof(lock_chains) +
 		sizeof(chainhash_table)
 #ifdef CONFIG_PROVE_LOCKING
 		+ sizeof(lock_cq)
+		+ sizeof(lock_chains)
+		+ sizeof(chain_hlocks)
 #endif
 		) / 1024
 		);
