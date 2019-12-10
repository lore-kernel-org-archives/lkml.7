Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAA9C2D0BE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879DD2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575950524;
	bh=zlW+ViAIq4hy7RxkkBHIUvjRG95s5I6WyajCmWgrfwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YqbKF+qnqpbPbsIFAd76oI2Do3xpjo3Fn5d3Jj6Yi128WzUjpPaO9p0pHcb+FF34T
	 K5E0rnhQFdJAzBdfhoMjflnj0zuprDtzAlbc76BQeTb12CQgYKSHO6ZyDUCfo9G7n+
	 ia4JKN0mlcrWU3lKdFgpW/sfHv3Fw4MEf7RVQ4n0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfLJECD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:02:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:41488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbfLJEB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:01:59 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31CFD20726;
        Tue, 10 Dec 2019 04:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950518;
        bh=zlW+ViAIq4hy7RxkkBHIUvjRG95s5I6WyajCmWgrfwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pnQjhudpZHgGx96aU9zBkoTxvXHCN2cqowLmpb1MSvoWkDB7egX7L1ZHNB716Dl3V
         AwnOpshyMrG9UAtAcF3nH92TuBQXawXiBTtsy6qgIRuCwtrcytCG2y1BF/dwSuhtvl
         QTQAFRN982RdUefnh2VqqSsPxmFy1sdvlayWdiX8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/10] rcu: Substitute lookup for bit-twiddling in sync_rcu_exp_select_node_cpus()
Date:   Mon,  9 Dec 2019 20:01:48 -0800
Message-Id: <20191210040154.2498-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210040122.GA2419@paulmck-ThinkPad-P72>
References: <20191210040122.GA2419@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The code in sync_rcu_exp_select_node_cpus() calculates the current
CPU's mask within its rcu_node structure's bitmasks, but this has
already been computed in the ->grpmask field of that CPU's rcu_data
structure.  This commit therefore just uses this ->grpmask field.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6a6f328..3b59c3e 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -345,8 +345,8 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 	/* Each pass checks a CPU for identity, offline, and idle. */
 	mask_ofl_test = 0;
 	for_each_leaf_node_cpu_mask(rnp, cpu, rnp->expmask) {
-		unsigned long mask = leaf_node_cpu_bit(rnp, cpu);
 		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+		unsigned long mask = rdp->grpmask;
 		int snap;
 
 		if (raw_smp_processor_id() == cpu ||
@@ -373,8 +373,8 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 
 	/* IPI the remaining CPUs for expedited quiescent state. */
 	for_each_leaf_node_cpu_mask(rnp, cpu, mask_ofl_ipi) {
-		unsigned long mask = leaf_node_cpu_bit(rnp, cpu);
 		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+		unsigned long mask = rdp->grpmask;
 
 retry_ipi:
 		if (rcu_dynticks_in_eqs_since(rdp, rdp->exp_dynticks_snap)) {
-- 
2.9.5

