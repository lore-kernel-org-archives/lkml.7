Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83C7C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A270521556
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575951997;
	bh=qnOCy3R7oF7uk4WJhiKaMhVNS1u2drNJf8xRjkLGYTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fTWFMnKqnOyVLY1Xa6/dTmJQy2Ji3Gr99bxfqYcd36bYL4I4QQeZBOxo8vPIXuzbj
	 2JtLq2yKGIdt1C2GMuwT7QvSBydPaamB/aqXrmJYmZsf39ZTbNmMc1RSicIq9LOgwY
	 QD1Wy2hrSPYaivt1/5W1HEMeLCjnWYujQypkFSwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfLJE0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:26:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:48420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfLJE0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:26:34 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F7DF208C3;
        Tue, 10 Dec 2019 04:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951992;
        bh=qnOCy3R7oF7uk4WJhiKaMhVNS1u2drNJf8xRjkLGYTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WsVPcNkxYgWFbIqSXBm8BYI0Yb9yY4XE3gOmavmyVMsL79LYxFc6Gdl7LGaGlZ9D3
         m3XZ2gsrUa58fZ/ubyQnvcdvhf4JNFyflRqOSM0IkDDFKz6iJH3vjdEYcQ+9O+im3a
         6wi+hKp590XBe+I+J7wAPe8gqLwNe3zkxRSAOlvo=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/11] rcu: Avoid data-race in rcu_gp_fqs_check_wake()
Date:   Mon,  9 Dec 2019 20:26:20 -0800
Message-Id: <20191210042629.3808-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210042606.GA3624@paulmck-ThinkPad-P72>
References: <20191210042606.GA3624@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

The rcu_gp_fqs_check_wake() function uses rcu_preempt_blocked_readers_cgp()
to read ->gp_tasks while other cpus might overwrite this field.

We need READ_ONCE()/WRITE_ONCE() pairs to avoid compiler
tricks and KCSAN splats like the following :

BUG: KCSAN: data-race in rcu_gp_fqs_check_wake / rcu_preempt_deferred_qs_irqrestore

write to 0xffffffff85a7f190 of 8 bytes by task 7317 on cpu 0:
 rcu_preempt_deferred_qs_irqrestore+0x43d/0x580 kernel/rcu/tree_plugin.h:507
 rcu_read_unlock_special+0xec/0x370 kernel/rcu/tree_plugin.h:659
 __rcu_read_unlock+0xcf/0xe0 kernel/rcu/tree_plugin.h:394
 rcu_read_unlock include/linux/rcupdate.h:645 [inline]
 __ip_queue_xmit+0x3b0/0xa40 net/ipv4/ip_output.c:533
 ip_queue_xmit+0x45/0x60 include/net/ip.h:236
 __tcp_transmit_skb+0xdeb/0x1cd0 net/ipv4/tcp_output.c:1158
 __tcp_send_ack+0x246/0x300 net/ipv4/tcp_output.c:3685
 tcp_send_ack+0x34/0x40 net/ipv4/tcp_output.c:3691
 tcp_cleanup_rbuf+0x130/0x360 net/ipv4/tcp.c:1575
 tcp_recvmsg+0x633/0x1a30 net/ipv4/tcp.c:2179
 inet_recvmsg+0xbb/0x250 net/ipv4/af_inet.c:838
 sock_recvmsg_nosec net/socket.c:871 [inline]
 sock_recvmsg net/socket.c:889 [inline]
 sock_recvmsg+0x92/0xb0 net/socket.c:885
 sock_read_iter+0x15f/0x1e0 net/socket.c:967
 call_read_iter include/linux/fs.h:1864 [inline]
 new_sync_read+0x389/0x4f0 fs/read_write.c:414

read to 0xffffffff85a7f190 of 8 bytes by task 10 on cpu 1:
 rcu_gp_fqs_check_wake kernel/rcu/tree.c:1556 [inline]
 rcu_gp_fqs_check_wake+0x93/0xd0 kernel/rcu/tree.c:1546
 rcu_gp_fqs_loop+0x36c/0x580 kernel/rcu/tree.c:1611
 rcu_gp_kthread+0x143/0x220 kernel/rcu/tree.c:1768
 kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 10 Comm: rcu_preempt Not tainted 5.3.0+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
[ paulmck:  Added another READ_ONCE() for RCU CPU stall warnings. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 758bfe1..fe5f448 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -220,7 +220,7 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * blocked tasks.
 	 */
 	if (!rnp->gp_tasks && (blkd_state & RCU_GP_BLKD)) {
-		rnp->gp_tasks = &t->rcu_node_entry;
+		WRITE_ONCE(rnp->gp_tasks, &t->rcu_node_entry);
 		WARN_ON_ONCE(rnp->completedqs == rnp->gp_seq);
 	}
 	if (!rnp->exp_tasks && (blkd_state & RCU_EXP_BLKD))
@@ -340,7 +340,7 @@ EXPORT_SYMBOL_GPL(rcu_note_context_switch);
  */
 static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
 {
-	return rnp->gp_tasks != NULL;
+	return READ_ONCE(rnp->gp_tasks) != NULL;
 }
 
 /* Bias and limit values for ->rcu_read_lock_nesting. */
@@ -493,7 +493,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		trace_rcu_unlock_preempted_task(TPS("rcu_preempt"),
 						rnp->gp_seq, t->pid);
 		if (&t->rcu_node_entry == rnp->gp_tasks)
-			rnp->gp_tasks = np;
+			WRITE_ONCE(rnp->gp_tasks, np);
 		if (&t->rcu_node_entry == rnp->exp_tasks)
 			rnp->exp_tasks = np;
 		if (IS_ENABLED(CONFIG_RCU_BOOST)) {
@@ -663,7 +663,7 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
 		dump_blkd_tasks(rnp, 10);
 	if (rcu_preempt_has_tasks(rnp) &&
 	    (rnp->qsmaskinit || rnp->wait_blkd_tasks)) {
-		rnp->gp_tasks = rnp->blkd_tasks.next;
+		WRITE_ONCE(rnp->gp_tasks, rnp->blkd_tasks.next);
 		t = container_of(rnp->gp_tasks, struct task_struct,
 				 rcu_node_entry);
 		trace_rcu_unlock_preempted_task(TPS("rcu_preempt-GPS"),
@@ -757,7 +757,8 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 		pr_info("%s: %d:%d ->qsmask %#lx ->qsmaskinit %#lx ->qsmaskinitnext %#lx\n",
 			__func__, rnp1->grplo, rnp1->grphi, rnp1->qsmask, rnp1->qsmaskinit, rnp1->qsmaskinitnext);
 	pr_info("%s: ->gp_tasks %p ->boost_tasks %p ->exp_tasks %p\n",
-		__func__, rnp->gp_tasks, rnp->boost_tasks, rnp->exp_tasks);
+		__func__, READ_ONCE(rnp->gp_tasks), rnp->boost_tasks,
+		rnp->exp_tasks);
 	pr_info("%s: ->blkd_tasks", __func__);
 	i = 0;
 	list_for_each(lhp, &rnp->blkd_tasks) {
-- 
2.9.5

