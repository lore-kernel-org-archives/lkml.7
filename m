Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACCFC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E457420726
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575951635;
	bh=D/nNxJU2R/ELQtX//F+ypH4+OKcnEVClhfyZCCaSxqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UlAOFCk++CmcKY8zUqfrhRVWviGSjKgAsgw0dC7Qq6Y0gBiqmd2pjg+aXMl4JPEpD
	 7Z/Ys2KrlYfojUB9KvSdBCeP7YNGMOKubqDTZCgnrJg+2R+jzLYpHNrGp0UDHfHkvt
	 i6q29uMJXCgAKvvoA4ugCh2rlTcJ7xA+m2sWYCfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfLJEUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:20:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:47018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfLJEUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:20:06 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C15F920838;
        Tue, 10 Dec 2019 04:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575951606;
        bh=D/nNxJU2R/ELQtX//F+ypH4+OKcnEVClhfyZCCaSxqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zqXCjPLiuJyaj+TpdtteuPUi6GgJRxzpXTUHmrgM6kzeunUwLQ7NYQqTKG2AoNtJw
         mbVHUMJbfdQWXMqCvAfTUz/Xk3R9qZRi1TKATBupKuuEkNTrGbs+NGU90jFICAhsKq
         NTieuaCLcTNbd1gdWwiTOo+1NZeAOZneM1KbmKI0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/9] timer: Use hlist_unhashed_lockless() in timer_pending()
Date:   Mon,  9 Dec 2019 20:19:56 -0800
Message-Id: <20191210042002.3490-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210041938.GA3367@paulmck-ThinkPad-P72>
References: <20191210041938.GA3367@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

The timer_pending() function is mostly used in lockless contexts, so
Without proper annotations, KCSAN might detect a data-race [1].

Using hlist_unhashed_lockless() instead of hand-coding it seems
appropriate (as suggested by Paul E. McKenney).

[1]

BUG: KCSAN: data-race in del_timer / detach_if_pending

write to 0xffff88808697d870 of 8 bytes by task 10 on cpu 0:
 __hlist_del include/linux/list.h:764 [inline]
 detach_timer kernel/time/timer.c:815 [inline]
 detach_if_pending+0xcd/0x2d0 kernel/time/timer.c:832
 try_to_del_timer_sync+0x60/0xb0 kernel/time/timer.c:1226
 del_timer_sync+0x6b/0xa0 kernel/time/timer.c:1365
 schedule_timeout+0x2d2/0x6e0 kernel/time/timer.c:1896
 rcu_gp_fqs_loop+0x37c/0x580 kernel/rcu/tree.c:1639
 rcu_gp_kthread+0x143/0x230 kernel/rcu/tree.c:1799
 kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352

read to 0xffff88808697d870 of 8 bytes by task 12060 on cpu 1:
 del_timer+0x3b/0xb0 kernel/time/timer.c:1198
 sk_stop_timer+0x25/0x60 net/core/sock.c:2845
 inet_csk_clear_xmit_timers+0x69/0xa0 net/ipv4/inet_connection_sock.c:523
 tcp_clear_xmit_timers include/net/tcp.h:606 [inline]
 tcp_v4_destroy_sock+0xa3/0x3f0 net/ipv4/tcp_ipv4.c:2096
 inet_csk_destroy_sock+0xf4/0x250 net/ipv4/inet_connection_sock.c:836
 tcp_close+0x6f3/0x970 net/ipv4/tcp.c:2497
 inet_release+0x86/0x100 net/ipv4/af_inet.c:427
 __sock_release+0x85/0x160 net/socket.c:590
 sock_close+0x24/0x30 net/socket.c:1268
 __fput+0x1e1/0x520 fs/file_table.c:280
 ____fput+0x1f/0x30 fs/file_table.c:313
 task_work_run+0xf6/0x130 kernel/task_work.c:113
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop+0x2b4/0x2c0 arch/x86/entry/common.c:163

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 12060 Comm: syz-executor.5 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine,

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/timer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 1e6650e..0dc19a8 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -164,7 +164,7 @@ static inline void destroy_timer_on_stack(struct timer_list *timer) { }
  */
 static inline int timer_pending(const struct timer_list * timer)
 {
-	return timer->entry.pprev != NULL;
+	return !hlist_unhashed_lockless(&timer->entry);
 }
 
 extern void add_timer_on(struct timer_list *timer, int cpu);
-- 
2.9.5

