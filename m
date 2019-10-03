Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C375C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F0C222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570066390;
	bh=0O6/KxBqWs9ZFW/AB5xNVcImW8d46jKwPeTl36k/sPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=enSPA9JZCpF/U1IsiRhG4wqLKvjY83EW2Wf9NjtVreRqsB/3wB2UKVic6f1oKZf5F
	 5uviUskQBmiC4iqLzVUM+0GjVvxTU7NlrnLLN7M+7lBr0XZV86aehcQ6zqH/GxGwug
	 UN7hfXJ0UkZitOmovPXiHw/6xRwxlSXsW/TGzXTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfJCBdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:33:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfJCBdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:33:08 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8572D222C3;
        Thu,  3 Oct 2019 01:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066387;
        bh=0O6/KxBqWs9ZFW/AB5xNVcImW8d46jKwPeTl36k/sPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gNKRvF/EroRe3cuQmy2yWLeVaMSY+josLwMxAV183QsuV/aNuHcqj3nx1oa75RGds
         wJDLRW226CIZqDE99oDuqQeltguJvL0bzbQfWl7DI0m0BqcMT2NbcEV1+K+WfBVnvO
         xyxX/cYyPgnY71aPLCMbNRy4esPT8Ipwio1Y1cSs=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        kbuild test robot <lkp@intel.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 2/8] rcu: Several rcu_segcblist functions can be static
Date:   Wed,  2 Oct 2019 18:32:59 -0700
Message-Id: <20191003013305.12854-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003013243.GA12705@paulmck-ThinkPad-P72>
References: <20191003013243.GA12705@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kbuild test robot <lkp@intel.com>

None of rcu_segcblist_set_len(), rcu_segcblist_add_len(), or
rcu_segcblist_xchg_len() are used outside of kernel/rcu/rcu_segcblist.c.
This commit therefore makes them static.

Fixes: ab2ef5c7b4d1 ("rcu/nocb: Atomic ->len field in rcu_segcblist structure")
Signed-off-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/rcu_segcblist.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 495c58c..cbc87b8 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -88,7 +88,7 @@ struct rcu_head *rcu_cblist_dequeue(struct rcu_cblist *rclp)
 }
 
 /* Set the length of an rcu_segcblist structure. */
-void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
+static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
 {
 #ifdef CONFIG_RCU_NOCB_CPU
 	atomic_long_set(&rsclp->len, v);
@@ -104,7 +104,7 @@ void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
  * This increase is fully ordered with respect to the callers accesses
  * both before and after.
  */
-void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
+static void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
 {
 #ifdef CONFIG_RCU_NOCB_CPU
 	smp_mb__before_atomic(); /* Up to the caller! */
@@ -134,7 +134,7 @@ void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp)
  * with the actual number of callbacks on the structure.  This exchange is
  * fully ordered with respect to the callers accesses both before and after.
  */
-long rcu_segcblist_xchg_len(struct rcu_segcblist *rsclp, long v)
+static long rcu_segcblist_xchg_len(struct rcu_segcblist *rsclp, long v)
 {
 #ifdef CONFIG_RCU_NOCB_CPU
 	return atomic_long_xchg(&rsclp->len, v);
-- 
2.9.5

