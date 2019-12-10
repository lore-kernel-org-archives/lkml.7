Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ACDC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F98F2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575950528;
	bh=caL/manb3rYvTbp0iAHtxlwE0AkRPwlCbqwp7y55iwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D7Nd1OXZy6i7ooDbWiZOIx1pWq8K+BxTCQc3G7eeNY5Ppoes9+HRy8eYqpZ2UfTys
	 jt/iUpUlrwMd4ppdvkAqyT3K9s++QFn9ESKkiHODA3odCxhUjhDtLYpsFVaijYUgO+
	 NLlH7PBXH7tFQKOSnazlRNj3zgC+IR+VSq2nowno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfLJECH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:02:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:41722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbfLJECC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:02:02 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F23D20838;
        Tue, 10 Dec 2019 04:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950521;
        bh=caL/manb3rYvTbp0iAHtxlwE0AkRPwlCbqwp7y55iwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ivn6p+D1vZILiXlF7kP/uPEOlsXAY/SzDzPEJIYwCQNM2/AK9TvZkKK9ZqhY+11RF
         PqQHKNj5bFDQ2G1GRVF83DUuWuCB5DwbRQabTeeTyEjGSrjyAMRgG8fNjoM+PZF/D/
         5OCPl+MDSAwhimC5AJdjZXaRFmmwmfP5DlbExZFw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/10] rcu: Replace synchronize_sched_expedited_wait() "_sched" with "_rcu"
Date:   Mon,  9 Dec 2019 20:01:53 -0800
Message-Id: <20191210040154.2498-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210040122.GA2419@paulmck-ThinkPad-P72>
References: <20191210040122.GA2419@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

After RCU flavor consolidation, synchronize_sched_expedited_wait() does
both RCU-preempt and RCU-sched, whichever happens to have been built into
the running kernel.  This commit therefore changes this function's name
to synchronize_rcu_expedited_wait() to reflect its new generic nature.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 1eafbcd..081a179 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -453,7 +453,7 @@ static void sync_rcu_exp_select_cpus(void)
  * Wait for the expedited grace period to elapse, issuing any needed
  * RCU CPU stall warnings along the way.
  */
-static void synchronize_sched_expedited_wait(void)
+static void synchronize_rcu_expedited_wait(void)
 {
 	int cpu;
 	unsigned long jiffies_stall;
@@ -538,7 +538,7 @@ static void rcu_exp_wait_wake(unsigned long s)
 {
 	struct rcu_node *rnp;
 
-	synchronize_sched_expedited_wait();
+	synchronize_rcu_expedited_wait();
 
 	// Switch over to wakeup mode, allowing the next GP to proceed.
 	// End the previous grace period only after acquiring the mutex
-- 
2.9.5

