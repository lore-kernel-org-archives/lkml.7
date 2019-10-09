Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0502ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 21:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736BC21929
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 21:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PhmzBC2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbfJIVWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 17:22:05 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:35402 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731072AbfJIVWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 17:22:04 -0400
Received: by mail-pf1-f201.google.com with SMTP id r7so2876723pfg.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 14:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=q0LB3QrONlXjAoBwDCOcxOPcisCnwhBvfOg7a2tY6E0=;
        b=PhmzBC2fsyARm6XVttUCQKhmD6+4+G5xMCGRRIkHtH5rEuDyUufDIG2szKalIzK/7N
         k1RDJ3puuJxbc3rkNJmKFGPEEclfdFDR6Uo6xKQxJmYxIb0CupE7ukObLN6PohAJfgHo
         5V7XAHc3a8r5WI3/cYifO4fj25ANyVeAJpj7zGMkQWYe+s2g87LExflvlTK2tozbGtrq
         3fRlGmzsP4EjJen0RT13ct1ThQDZOwmLH9lDK4nmb3l8LjVemHbD5sWdx3oRC+af+UvU
         qeKVK3fcLQvBX1v5pJ/PqxpGyZrmeI9MS+2m7u3wVZSaU23+iV1ZPcdjeZ+cd2bjHqct
         1ArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=q0LB3QrONlXjAoBwDCOcxOPcisCnwhBvfOg7a2tY6E0=;
        b=Iu8V+mR0c9gQ9YsdgNFYFwuckBrySoYPy09+aYm0mWX1QQAN1ofqDQ8ZDTr62U7AFn
         dvB7Z2UglILzSvOuq2rD5AJqsozmV04DVg0zTzLcwDI6CXAMZSDRXcIeQJOYsM+yov1i
         XGjc+Tknihg7jhy+IYKtZ+izvlnwnL/kR2NAa6ESPG/6Xbdumi0eR3+CKo/RlNOwRswL
         UwP/XLH/vHvvAuip70/jGxR1Vp4LCTJvvN23W3vo9xnn0rA76kHgFPyb87y3Qav8rPQH
         gBIimVZ9Y/HMTBlGNR5jd+rlJyfAzb/+OFi9vRpjTJ1qbEWR8n0odc95Q8CX2S+S5+e2
         DoYw==
X-Gm-Message-State: APjAAAUIAd/GwECYrJ+NnlJKJKlCeL2DJluVGmt/8SqXkWIg5la2xX5V
        grFpBnwbtLz+atUxMTP8figzTlPbYrC2Tw==
X-Google-Smtp-Source: APXvYqzUTrcdF1BbmP/YYnLNsnu751gq08cftEjXdT8Pz0u14fvqRJg4xL9Wmc+EbPrwGOmH0sqHiVp2onMbsA==
X-Received: by 2002:a65:640e:: with SMTP id a14mr6423870pgv.392.1570656123876;
 Wed, 09 Oct 2019 14:22:03 -0700 (PDT)
Date:   Wed,  9 Oct 2019 14:21:54 -0700
Message-Id: <20191009212154.24709-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH] rcu: avoid data-race in rcu_gp_fqs_check_wake()
From:   Eric Dumazet <edumazet@google.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rcu_gp_fqs_check_wake() uses rcu_preempt_blocked_readers_cgp()
to read ->gp_tasks while otehr cpus might write over this field.

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
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Reported-by: syzbot <syzkaller@googlegroups.com>
---
 kernel/rcu/tree_plugin.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2defc7fe74c3991b03d1968a18c4d208bccf25f9..5500a8ba92da19f49fecf8db583ac7b5a21f5e7b 100644
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
-- 
2.23.0.581.g78d2f28ef7-goog

