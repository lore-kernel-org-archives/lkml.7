Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1917C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8DB218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551374096;
	bh=LYOpaCbm0GDxsCu/mGEPFgnQk0rsjKhVNhuMG+FWJRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SZgwvM4kdFHNrU1TBsQ46V1/2ATrLNtdV3PKZ42LNu1DTS2zjkwuLkZdaNvaMsaSr
	 7KU0T+piHF0U6waeKm+BYrAMJVHWdxwDl657Ax+7X3Ke7G3+HmLj/mrwMdMYO6Hih/
	 cCMb0foqNtelsy84Pl43dyOGHBtSrFbn/CLzb29E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388113AbfB1ROz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:14:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:59708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387802AbfB1ROv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:14:51 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0ED220857;
        Thu, 28 Feb 2019 17:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551374090;
        bh=LYOpaCbm0GDxsCu/mGEPFgnQk0rsjKhVNhuMG+FWJRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uj3CmOjctaPoGJ/YVDbmdE49HQkwVkG8QW9TnV1eDSl0BMwQtFtgjma4qOQSHz9Gg
         OppIqxWaSYFQxZrS+VPxr2f74tlA5vEyeKQuEO5xl4efBuFMYMyxx4FO9SkrcdNqGE
         dNnqp8ZXsZDf/gZjs3Evj6knJEp0AfRdbal3hNrw=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 34/37] locking/lockdep: Branch the new vec-finegrained softirq masking to lockdep
Date:   Thu, 28 Feb 2019 18:12:39 +0100
Message-Id: <20190228171242.32144-35-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have full support from softirqs to perform per vector
masking, let's feed lockdep with the proper inputs and push the vector
numbers involved in a base softirq lock usage:

LOCK_ENABLED_SOFTIRQ: push local_softirq_enabled()
LOCK_USED_IN_SOFTIRQ: push curr->softirq_context, modified by
                      lockdep_softirq_enter/exit()

Reviewed-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/locking/lockdep.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index aab634b07d67..4d38ff30006d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2879,6 +2879,7 @@ static void __trace_hardirqs_on_caller(unsigned long ip)
 	 */
 	if (curr->softirqs_enabled) {
 		usage.bit = LOCK_ENABLED_SOFTIRQ;
+		usage.vector = local_softirq_enabled();
 		if (!mark_held_locks(curr, &usage))
 			return;
 	}
@@ -2966,6 +2967,7 @@ void trace_softirqs_on(unsigned long ip)
 	struct task_struct *curr = current;
 	struct lock_usage usage = {
 		.bit = LOCK_ENABLED_SOFTIRQ,
+		.vector = local_softirq_enabled()
 	};
 
 	if (unlikely(!debug_locks || current->lockdep_recursion))
@@ -3030,7 +3032,7 @@ void trace_softirqs_off(unsigned long ip)
 
 static int mark_irqflags(struct task_struct *curr, struct held_lock *hlock)
 {
-	struct lock_usage usage = { .vector = 0 };
+	struct lock_usage usage;
 	/*
 	 * If non-trylock use in a hardirq or softirq context, then
 	 * mark the lock as used in these contexts:
@@ -3039,22 +3041,26 @@ static int mark_irqflags(struct task_struct *curr, struct held_lock *hlock)
 		if (hlock->read) {
 			if (curr->hardirq_context) {
 				usage.bit = LOCK_USED_IN_HARDIRQ_READ;
+				usage.vector = 0;
 				if (!mark_lock(curr, hlock, &usage))
 					return 0;
 			}
 			if (curr->softirq_context) {
 				usage.bit = LOCK_USED_IN_SOFTIRQ_READ;
+				usage.vector = curr->softirq_context;
 				if (!mark_lock(curr, hlock, &usage))
 					return 0;
 			}
 		} else {
 			if (curr->hardirq_context) {
 				usage.bit = LOCK_USED_IN_HARDIRQ;
+				usage.vector = 0;
 				if (!mark_lock(curr, hlock, &usage))
 					return 0;
 			}
 			if (curr->softirq_context) {
 				usage.bit = LOCK_USED_IN_SOFTIRQ;
+				usage.vector = curr->softirq_context;
 				if (!mark_lock(curr, hlock, &usage))
 					return 0;
 			}
@@ -3063,19 +3069,23 @@ static int mark_irqflags(struct task_struct *curr, struct held_lock *hlock)
 	if (!hlock->hardirqs_off) {
 		if (hlock->read) {
 			usage.bit = LOCK_ENABLED_HARDIRQ_READ;
+			usage.vector = 0;
 			if (!mark_lock(curr, hlock, &usage))
 				return 0;
 			if (curr->softirqs_enabled) {
 				usage.bit = LOCK_ENABLED_SOFTIRQ_READ;
+				usage.vector = local_softirq_enabled();
 				if (!mark_lock(curr, hlock, &usage))
 					return 0;
 			}
 		} else {
 			usage.bit = LOCK_ENABLED_HARDIRQ;
+			usage.vector = 0;
 			if (!mark_lock(curr, hlock, &usage))
 				return 0;
 			if (curr->softirqs_enabled) {
 				usage.bit = LOCK_ENABLED_SOFTIRQ;
+				usage.vector = local_softirq_enabled();
 				if (!mark_lock(curr, hlock, &usage))
 					return 0;
 			}
-- 
2.21.0

