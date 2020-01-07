Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A34DC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAC220678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431130;
	bh=jL8W/VTf5iJPzcxM24qMgXXJJz1FPFI/v0BUZSWvlEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yPwbijao6dRrUIZi1L6OY4dZMd01o02FV+TVKbIEl/phPHJP1duxXe04RV5z0OPZz
	 SwXBVCxQmYzb1TphY05E5O84bpwCEb1B4Dph754j8GjxV1+xvk7VHNqwqszYAZO54E
	 dmYTsNft/fXSHW/ZYsgtwaS69397VIgU5azIRos0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgAGVF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:05:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:51480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729222AbgAGVFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:05:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76B1520678;
        Tue,  7 Jan 2020 21:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431116;
        bh=jL8W/VTf5iJPzcxM24qMgXXJJz1FPFI/v0BUZSWvlEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IoVE+b32wjkXWe0U81YEVm4PkQX/38LY7unBIOdO9qOnl7uCGYcui8kRx19i/YI+3
         C0lJwLLK4zfFJ/sADfkEEn//4fcSS7+ISlP1MZmp0zCGfdFqorm/ck2C4tWaZGCzL6
         1C9BQgrMv4tFKm7W15pWp1QnqE8PGY9i3y3sve+A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 039/115] taskstats: fix data-race
Date:   Tue,  7 Jan 2020 21:54:09 +0100
Message-Id: <20200107205301.708613732@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

[ Upstream commit 0b8d616fb5a8ffa307b1d3af37f55c15dae14f28 ]

When assiging and testing taskstats in taskstats_exit() there's a race
when setting up and reading sig->stats when a thread-group with more
than one thread exits:

write to 0xffff8881157bbe10 of 8 bytes by task 7951 on cpu 0:
 taskstats_tgid_alloc kernel/taskstats.c:567 [inline]
 taskstats_exit+0x6b7/0x717 kernel/taskstats.c:596
 do_exit+0x2c2/0x18e0 kernel/exit.c:864
 do_group_exit+0xb4/0x1c0 kernel/exit.c:983
 get_signal+0x2a2/0x1320 kernel/signal.c:2734
 do_signal+0x3b/0xc00 arch/x86/kernel/signal.c:815
 exit_to_usermode_loop+0x250/0x2c0 arch/x86/entry/common.c:159
 prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
 do_syscall_64+0x2d7/0x2f0 arch/x86/entry/common.c:299
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

read to 0xffff8881157bbe10 of 8 bytes by task 7949 on cpu 1:
 taskstats_tgid_alloc kernel/taskstats.c:559 [inline]
 taskstats_exit+0xb2/0x717 kernel/taskstats.c:596
 do_exit+0x2c2/0x18e0 kernel/exit.c:864
 do_group_exit+0xb4/0x1c0 kernel/exit.c:983
 __do_sys_exit_group kernel/exit.c:994 [inline]
 __se_sys_exit_group kernel/exit.c:992 [inline]
 __x64_sys_exit_group+0x2e/0x30 kernel/exit.c:992
 do_syscall_64+0xcf/0x2f0 arch/x86/entry/common.c:296
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fix this by using smp_load_acquire() and smp_store_release().

Reported-by: syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com
Fixes: 34ec12349c8a ("taskstats: cleanup ->signal->stats allocation")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Acked-by: Marco Elver <elver@google.com>
Reviewed-by: Will Deacon <will@kernel.org>
Reviewed-by: Andrea Parri <parri.andrea@gmail.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://lore.kernel.org/r/20191009114809.8643-1-christian.brauner@ubuntu.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/taskstats.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 4e62a4a8fa91..82393952683c 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -564,25 +564,33 @@ static int taskstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
 static struct taskstats *taskstats_tgid_alloc(struct task_struct *tsk)
 {
 	struct signal_struct *sig = tsk->signal;
-	struct taskstats *stats;
+	struct taskstats *stats_new, *stats;
 
-	if (sig->stats || thread_group_empty(tsk))
-		goto ret;
+	/* Pairs with smp_store_release() below. */
+	stats = smp_load_acquire(&sig->stats);
+	if (stats || thread_group_empty(tsk))
+		return stats;
 
 	/* No problem if kmem_cache_zalloc() fails */
-	stats = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);
+	stats_new = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);
 
 	spin_lock_irq(&tsk->sighand->siglock);
-	if (!sig->stats) {
-		sig->stats = stats;
-		stats = NULL;
+	stats = sig->stats;
+	if (!stats) {
+		/*
+		 * Pairs with smp_store_release() above and order the
+		 * kmem_cache_zalloc().
+		 */
+		smp_store_release(&sig->stats, stats_new);
+		stats = stats_new;
+		stats_new = NULL;
 	}
 	spin_unlock_irq(&tsk->sighand->siglock);
 
-	if (stats)
-		kmem_cache_free(taskstats_cache, stats);
-ret:
-	return sig->stats;
+	if (stats_new)
+		kmem_cache_free(taskstats_cache, stats_new);
+
+	return stats;
 }
 
 /* Send pid data out on exit */
-- 
2.20.1



