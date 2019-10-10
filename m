Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F50FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 03:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15C620B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 03:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570677504;
	bh=TMLqCptECTPCd6hDtCY+wtfhjTMZNqzCHX7UNi3pO+w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=04ZNRWQNB9s4xpGKi4B8lvYe9S7WRazlC62jiowJd5aWREggnzQ2p8mWCWUz/aEoS
	 l5E7eyrV0XBJ64y/9SBH7TBWzWoM2bCUC4gZytsoa1AuMyX8b9JixlOsYcGXU8hzOC
	 QAWWmzITXH9zy1D+83Ufy+8L3LfkdvR/x/nVAKo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732783AbfJJDSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 23:18:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbfJJDSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 23:18:23 -0400
Received: from paulmck-ThinkPad-P72 (unknown [12.12.162.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FEAE2086D;
        Thu, 10 Oct 2019 03:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570677502;
        bh=TMLqCptECTPCd6hDtCY+wtfhjTMZNqzCHX7UNi3pO+w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Po9IUL4OmXdMRd/kuB52xOLXfAV7amyzF7iWzMbPDCpgjP9NF0rH0xLXH9jRXspuT
         T6brVuNZyMojiBPhDP+2mXeww4uwYs85JVM/jJ1TwSZ8LeZLfQ1UdgCJalYxvkxGEL
         SIvflgJSVaOUk0wA9lYSUa9XihApIORcUgt+GDso=
Date:   Wed, 9 Oct 2019 20:18:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH] rcu: avoid data-race in rcu_gp_fqs_check_wake()
Message-ID: <20191010031820.GD2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191009212154.24709-1-edumazet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009212154.24709-1-edumazet@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:21:54PM -0700, Eric Dumazet wrote:
> rcu_gp_fqs_check_wake() uses rcu_preempt_blocked_readers_cgp()
> to read ->gp_tasks while otehr cpus might write over this field.
> 
> We need READ_ONCE()/WRITE_ONCE() pairs to avoid compiler
> tricks and KCSAN splats like the following :
> 
> BUG: KCSAN: data-race in rcu_gp_fqs_check_wake / rcu_preempt_deferred_qs_irqrestore
> 
> write to 0xffffffff85a7f190 of 8 bytes by task 7317 on cpu 0:
>  rcu_preempt_deferred_qs_irqrestore+0x43d/0x580 kernel/rcu/tree_plugin.h:507
>  rcu_read_unlock_special+0xec/0x370 kernel/rcu/tree_plugin.h:659
>  __rcu_read_unlock+0xcf/0xe0 kernel/rcu/tree_plugin.h:394
>  rcu_read_unlock include/linux/rcupdate.h:645 [inline]
>  __ip_queue_xmit+0x3b0/0xa40 net/ipv4/ip_output.c:533
>  ip_queue_xmit+0x45/0x60 include/net/ip.h:236
>  __tcp_transmit_skb+0xdeb/0x1cd0 net/ipv4/tcp_output.c:1158
>  __tcp_send_ack+0x246/0x300 net/ipv4/tcp_output.c:3685
>  tcp_send_ack+0x34/0x40 net/ipv4/tcp_output.c:3691
>  tcp_cleanup_rbuf+0x130/0x360 net/ipv4/tcp.c:1575
>  tcp_recvmsg+0x633/0x1a30 net/ipv4/tcp.c:2179
>  inet_recvmsg+0xbb/0x250 net/ipv4/af_inet.c:838
>  sock_recvmsg_nosec net/socket.c:871 [inline]
>  sock_recvmsg net/socket.c:889 [inline]
>  sock_recvmsg+0x92/0xb0 net/socket.c:885
>  sock_read_iter+0x15f/0x1e0 net/socket.c:967
>  call_read_iter include/linux/fs.h:1864 [inline]
>  new_sync_read+0x389/0x4f0 fs/read_write.c:414
> 
> read to 0xffffffff85a7f190 of 8 bytes by task 10 on cpu 1:
>  rcu_gp_fqs_check_wake kernel/rcu/tree.c:1556 [inline]
>  rcu_gp_fqs_check_wake+0x93/0xd0 kernel/rcu/tree.c:1546
>  rcu_gp_fqs_loop+0x36c/0x580 kernel/rcu/tree.c:1611
>  rcu_gp_kthread+0x143/0x220 kernel/rcu/tree.c:1768
>  kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 10 Comm: rcu_preempt Not tainted 5.3.0+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Reported-by: syzbot <syzkaller@googlegroups.com>

Again, good catch, applied for review and testing, thank you!

I added another READ_ONCE() to dump_blkd_tasks(), which is not exercised
unless you get an RCU CPU stall warning or some such.  The updated patch
is below, please let me know if I messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit 53a6fffb998fd442e4049b145d8843fecc2bb396
Author: Eric Dumazet <edumazet@google.com>
Date:   Wed Oct 9 14:21:54 2019 -0700

    rcu: Avoid data-race in rcu_gp_fqs_check_wake()
    
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

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index d43f4e0..56ac8a6 100644
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
