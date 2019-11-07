Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F7AC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1CD2166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tztSAJOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfKGThr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:37:47 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:34784 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfKGThr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:37:47 -0500
Received: by mail-pg1-f202.google.com with SMTP id w9so2657956pgl.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 11:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=unu4a090GFms8fzkDfk3yCw2xwpt2ILomRsS9MTJjmw=;
        b=tztSAJOdqWFAjlQZeJ+g2ugY8dqvavfCHvajgmArzYAyVt5OqD3tKZlBwlRpCUCl5W
         IduHAGMCk1DqMLVdqFrt5E7dAUhfxJFZG1087/2NuDwjP3fLxGlfgGV+2/1pXK69w3OD
         NhwjfDHu9oBZuWRZ/1LywFhPktYbWnuVdfPTUnt3+GJAfDAU65O+ijYS0x9NVJrAbTCj
         NaXq81t/H3iNHla4zbIgk7N68+YsA2PFQk9v7Y3cWm83SVXRwkCy1kUmDyG7uL7wwAgh
         xYkyiCBwmaV/5EI0DTI+qoyKZIw2L+gH+EHwmCfeZPy0kAcHJJ2OfXvpPZ0sgTVp1tFo
         bLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=unu4a090GFms8fzkDfk3yCw2xwpt2ILomRsS9MTJjmw=;
        b=pNCs/VSz0Zju+nZCBzdHNTYxMH3B6AIlVzi1K06kmxbVkKQlfTZRTPBFGS1UKwdpwh
         WNKlWkVHN2d+T4/Ve4SvuJOADzYpt9o4kXqyvxRjA3p4n5N63G5TqmPR2i1mrO6bAkmm
         moo1XynVMrsJfjj8vfB+D5IYEJWGsja7EoURXy7hJ+JOSNPI+TdiT4KzxqMnE57kWyZ9
         bGgNlvDy6rSkkgiT34WkHnPB+Th79dKa0NNPonPGT7Rt8pxufUSdbWF4XBT7mA7SCWxc
         W1QKCuNcOO9GZnT7vA8UiLKEiVOSQPYRBz56jNwphwYxhRQVJceJrxKFyMGun4APiPEg
         y9DA==
X-Gm-Message-State: APjAAAUFYh24O1JnyNwrmtNV5/ggpv50X8bwTIoJLwoC8DjtoA9UlR8/
        YpJOyaGufF7iZkov5TpH3uUjZpQbJcRaQw==
X-Google-Smtp-Source: APXvYqzwd2kTTb0aa87G/qkJnXqolzk/oh6/R88LEMtF3YPIfAE9kXlFUO062dorQymzj/kL6q0rH9WXRQqwzg==
X-Received: by 2002:a63:f25:: with SMTP id e37mr6572837pgl.269.1573155464916;
 Thu, 07 Nov 2019 11:37:44 -0800 (PST)
Date:   Thu,  7 Nov 2019 11:37:38 -0800
In-Reply-To: <20191107193738.195914-1-edumazet@google.com>
Message-Id: <20191107193738.195914-2-edumazet@google.com>
Mime-Version: 1.0
References: <20191107193738.195914-1-edumazet@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH 2/2] timer: use hlist_unhashed_lockless() in timer_pending()
From:   Eric Dumazet <edumazet@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

timer_pending() is mostly used in lockless contexts.

Without proper annotations, KCSAN might detect a data-race [1]

Using hlist_unhashed_lockless() instead of hand-coding it
seems appropriate (as suggested by Paul E. McKenney).

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
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/timer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 1e6650ed066d5d28251b0bd385fc37ef94c96532..0dc19a8c39c9e49a7cde3d34bfa4be8871cbc1c2 100644
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
2.24.0.432.g9d3f5f5b63-goog

