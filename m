Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00952C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8959222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570066400;
	bh=MCTqIko+Pzcx4VB+BlyFBqZLFi9rRHWEgLAqrX7wJvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ymGkj5tqPB+dItMT22qtFqz4Lr5u5J1rXkeyqSRGdz40TK92W0PjQuUwQT2gOXaVi
	 1PDOtnP05sFF779BHzF0LU5KOHvcjEgfgLy/WShWkr+X7WumZFP6EuKhXlV8O3kJF2
	 m3zrHVLF2sQPFJDMO/HmWm5Q/JS4dL1G7N8iRwec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfJCBdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:33:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbfJCBdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:33:10 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8354222C8;
        Thu,  3 Oct 2019 01:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066389;
        bh=MCTqIko+Pzcx4VB+BlyFBqZLFi9rRHWEgLAqrX7wJvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vWQnWVqw1/AWW6U8K+8vyW0sYBSEhX9Dl2icPdy7TYnpjrf/eMgEDa8hHgfRlyxhZ
         QshkhIDVbq4Ev1mlxdU/BU4F7TBMt3A72NhsgTL4fyv4iucH+6vCz2rGnwqdwruP0U
         BaRlOW8Ga5kJ6BC1tQaLhWrCyhsv3oyYFqfxmpco=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 6/8] rcu: Update descriptions for rcu_nocb_wake tracepoint
Date:   Wed,  2 Oct 2019 18:33:03 -0700
Message-Id: <20191003013305.12854-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003013243.GA12705@paulmck-ThinkPad-P72>
References: <20191003013243.GA12705@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 include/trace/events/rcu.h | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index afa8985..4609f2e 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -258,20 +258,27 @@ TRACE_EVENT_RCU(rcu_exp_funnel_lock,
  * the number of the offloaded CPU are extracted.  The third and final
  * argument is a string as follows:
  *
- *	"WakeEmpty": Wake rcuo kthread, first CB to empty list.
- *	"WakeEmptyIsDeferred": Wake rcuo kthread later, first CB to empty list.
- *	"WakeOvf": Wake rcuo kthread, CB list is huge.
- *	"WakeOvfIsDeferred": Wake rcuo kthread later, CB list is huge.
- *	"WakeNot": Don't wake rcuo kthread.
- *	"WakeNotPoll": Don't wake rcuo kthread because it is polling.
- *	"DeferredWake": Carried out the "IsDeferred" wakeup.
- *	"Poll": Start of new polling cycle for rcu_nocb_poll.
- *	"Sleep": Sleep waiting for GP for !rcu_nocb_poll.
- *	"CBSleep": Sleep waiting for CBs for !rcu_nocb_poll.
- *	"WokeEmpty": rcuo kthread woke to find empty list.
- *	"WokeNonEmpty": rcuo kthread woke to find non-empty list.
- *	"WaitQueue": Enqueue partially done, timed wait for it to complete.
- *	"WokeQueue": Partial enqueue now complete.
+ * "AlreadyAwake": The to-be-awakened rcuo kthread is already awake.
+ * "Bypass": rcuo GP kthread sees non-empty ->nocb_bypass.
+ * "CBSleep": rcuo CB kthread sleeping waiting for CBs.
+ * "Check": rcuo GP kthread checking specified CPU for work.
+ * "DeferredWake": Timer expired or polled check, time to wake.
+ * "DoWake": The to-be-awakened rcuo kthread needs to be awakened.
+ * "EndSleep": Done waiting for GP for !rcu_nocb_poll.
+ * "FirstBQ": New CB to empty ->nocb_bypass (->cblist maybe non-empty).
+ * "FirstBQnoWake": FirstBQ plus rcuo kthread need not be awakened.
+ * "FirstBQwake": FirstBQ plus rcuo kthread must be awakened.
+ * "FirstQ": New CB to empty ->cblist (->nocb_bypass maybe non-empty).
+ * "NeedWaitGP": rcuo GP kthread must wait on a grace period.
+ * "Poll": Start of new polling cycle for rcu_nocb_poll.
+ * "Sleep": Sleep waiting for GP for !rcu_nocb_poll.
+ * "Timer": Deferred-wake timer expired.
+ * "WakeEmptyIsDeferred": Wake rcuo kthread later, first CB to empty list.
+ * "WakeEmpty": Wake rcuo kthread, first CB to empty list.
+ * "WakeNot": Don't wake rcuo kthread.
+ * "WakeNotPoll": Don't wake rcuo kthread because it is polling.
+ * "WakeOvfIsDeferred": Wake rcuo kthread later, CB list is huge.
+ * "WokeEmpty": rcuo CB kthread woke to find empty list.
  */
 TRACE_EVENT_RCU(rcu_nocb_wake,
 
-- 
2.9.5

