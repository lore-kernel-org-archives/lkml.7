Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1855DC2D0BE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF6A214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575950870;
	bh=EHdy3lPlwbUbWpC4sHzAdF6ygyYZm7lBwwiG9rLftcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cDAHSWD9ZG1fOU+NiNPrbOy3/RsgoDj7serQikI6rZjVF5Uu4x+J3WV0ios6fkfQV
	 fn3q9gG0CZyhc4Cwm3o9pDdPs/AShjIUAvFEK+b3e4CW5S9LTk4/yR+AHJC9jPcXWw
	 YC1jo0gR9HXw25kOdo+tmRfA1i2cSRlQ2um+B7mA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfLJEHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:07:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:43280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfLJEHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:07:45 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30EEC207FF;
        Tue, 10 Dec 2019 04:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950864;
        bh=EHdy3lPlwbUbWpC4sHzAdF6ygyYZm7lBwwiG9rLftcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhQMj57GvpdwRs8km7MjtlGzAaCslsLdRDwiveYDIDOHRN42zcqC29T+24ZUR7rfB
         ZPzU8zIA7gAwoQ39W/ffBMBm/OXKlxhEK/F5R/sDLZCdZqVBIkiYGmjXwLPLdf5sJl
         sKKKLbjcJo+uF3MkCrs2EvKdxXwr6eogKeOyjnus=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/12] rcu: Mark non-global functions and variables as static
Date:   Mon,  9 Dec 2019 20:07:31 -0800
Message-Id: <20191210040741.2943-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210040714.GA2715@paulmck-ThinkPad-P72>
References: <20191210040714.GA2715@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Each of rcu_state, rcu_rnp_online_cpus(), rcu_dynticks_curr_cpu_in_eqs(),
and rcu_dynticks_snap() are used only in the kernel/rcu/tree.o translation
unit, and may thus be marked static.  This commit therefore makes this
change.

Reported-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 8 ++++----
 kernel/rcu/tree.h | 2 --
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1694a6b..dd8cfc3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -84,7 +84,7 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
 	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
 };
-struct rcu_state rcu_state = {
+static struct rcu_state rcu_state = {
 	.level = { &rcu_state.node[0] },
 	.gp_state = RCU_GP_IDLE,
 	.gp_seq = (0UL - 300UL) << RCU_SEQ_CTR_SHIFT,
@@ -188,7 +188,7 @@ EXPORT_SYMBOL_GPL(rcu_get_gp_kthreads_prio);
  * held, but the bit corresponding to the current CPU will be stable
  * in most contexts.
  */
-unsigned long rcu_rnp_online_cpus(struct rcu_node *rnp)
+static unsigned long rcu_rnp_online_cpus(struct rcu_node *rnp)
 {
 	return READ_ONCE(rnp->qsmaskinitnext);
 }
@@ -294,7 +294,7 @@ static void rcu_dynticks_eqs_online(void)
  *
  * No ordering, as we are sampling CPU-local information.
  */
-bool rcu_dynticks_curr_cpu_in_eqs(void)
+static bool rcu_dynticks_curr_cpu_in_eqs(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
@@ -305,7 +305,7 @@ bool rcu_dynticks_curr_cpu_in_eqs(void)
  * Snapshot the ->dynticks counter with full ordering so as to allow
  * stable comparison of this counter with past and future snapshots.
  */
-int rcu_dynticks_snap(struct rcu_data *rdp)
+static int rcu_dynticks_snap(struct rcu_data *rdp)
 {
 	int snap = atomic_add_return(0, &rdp->dynticks);
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 055c317..e4dc5de 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -403,8 +403,6 @@ static const char *tp_rcu_varname __used __tracepoint_string = rcu_name;
 #define RCU_NAME rcu_name
 #endif /* #else #ifdef CONFIG_TRACING */
 
-int rcu_dynticks_snap(struct rcu_data *rdp);
-
 /* Forward declarations for tree_plugin.h */
 static void rcu_bootup_announce(void);
 static void rcu_qs(void);
-- 
2.9.5

